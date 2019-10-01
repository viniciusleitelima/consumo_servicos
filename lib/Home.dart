import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerCep = TextEditingController();

  String _resultado = "Resultado";

  _recuperarCep() async {

    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json";
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String cep_resposta = retorno["cep"];
    String complemento = retorno["complemento"];
    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];
    String unidade = retorno["unidade"];
    String ibge = retorno["ibge"];
    String gia = retorno["gia"];

    setState((){
      _resultado = "${cep_resposta}, ${complemento}, ${logradouro}, ${bairro}, ${localidade}, ${uf}, ${unidade}, ${ibge}, ${gia}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o cep: ex: 40300171"
              ),
              style: TextStyle(
                fontSize: 20
              ),
              controller: _controllerCep,
            ),
            RaisedButton(
              child: Text("Clique aqui"),
              onPressed: _recuperarCep,
            ),
            Text( _resultado)
          ],
        ),
      )
    );
  }
}
