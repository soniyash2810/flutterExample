import 'package:flutter/material.dart';
import 'package:newsapi/model/Article.dart';
import 'package:newsapi/service/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context){
    Apiservice apiService = Apiservice();
    return Scaffold(
        appBar: AppBar(
          title: Text('News API'),
        ),
        body: FutureBuilder(
            future:apiService.getArticle() ,
            builder: (BuildContext context, AsyncSnapshot<List <Article>> Snapshot){
              if(Snapshot.hasData){
                return ListView.builder(
                    itemCount: Snapshot.data!.length,
                    itemBuilder:((BuildContext context, index){
                      return ListTile(
                        title: Text('${Snapshot.data![index].title}'),
                        subtitle:Text('${Snapshot.data![index].description}') ,
                        trailing: Image.network('${Snapshot.data![index].urlToImage}'),
                      );
                    }
                    )
                );
              }

              return Center(child: CircularProgressIndicator()
              );
            }
        )
    );
  }
}