    //
    //  TrailerViewController.swift
    //  Flixxxx
    //
    //  Created by Shy Shy on 2/24/21.
    //
    
    import UIKit
    import WebKit
    
    class TrailerViewController: UIViewController, WKNavigationDelegate {
        
        var movie: [String: Any]!
        //store a proerpty we can refer to later on
        var webView: WKWebView!
        
        override func loadView() {
            webView = WKWebView()
            webView.navigationDelegate = self
            view = webView
            
            func viewDidLoad() {
                super.viewDidLoad()
                                
            }
            
            let id = movie["id"] as! Int
            
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
                // This will run when the network request returns
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data {
                    let dataDictionary = try!
                        JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    let movieVideos = dataDictionary["results"] as! Array<Any>
                    let video = movieVideos[0] as! Dictionary as [String:Any]
                    let key = video["key"] as! String
                    
                    // Do any additional setup after loading the view.
                    let url2 = URL(string: "https://www.youtube.com/watch?v=\(key)")!
                    print(url2)
                    self.webView.load(URLRequest(url: url2))
                    self.webView.allowsBackForwardNavigationGestures = true
                    
                }
            }
            task.resume()
            
            
        }
        
    }
    
    
    
    
    
    
    
    
    
