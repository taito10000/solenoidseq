Server.default.makeGui
AppClock(1);
s.boot;
p = ArduinoSMS("/dev/tty.usbmodem1d11", 38400);




(



var window = Window.new("Sequencer",Rect(318, 356, 1020, 300)).front;
var sekvenssi, rutiini, selvittaja, soittaja;
var spek = ControlSpec(10,250, 'lin', 1);
var naputtaja1, naputtaja2, naputtaja3, naputtaja4, naputtaja5, naputtaja6;
var tempo = TempoClock(2, queueSize: 1);
var queu = Quant(0,0,0);

~selvitys = Array.newClear(4);
~valo = Array.newClear(41);
~rivi = Array.newClear(161);

~valo[..40] = 0;
~rivi[..160] = 0;



window.view.decorator = FlowLayout(window.view.bounds);

a = Array.newClear(40);
b = Array.newClear(160);
a[0] = 0;
b[0] = 0;



// VALONAPIT

for (0, 39, {arg i;


	var id;

	a[i] = Button.new(window,Rect(13, 14, 21, 10))
	.states_([ [ "-", Color(0.0, 0.0, 0.0, 1.0), Color(0.2, 0.2, 0.2, 0.8) ], [ "x", Color(1.0, 0.9, 1.0, 1.0), Color(1.0, 0.0, 0.0, 1.0) ] ])
	.action_{|v|


		 v.value.postln;
		 id = i;
		 id.postln;
		 ~rivi[i] = v.value;
		 ~rivi.postln;
		 };


});



// SEQVENSSINAPIT

for (0,159, {arg i;

var id;

b[i] = Button.new(window,Rect(13, 14, 21, 22))
	.states_([ [ "-", Color(0.0, 0.0, 0.0, 1.0), Color(0.2, 0.2, 0.2, 0.4) ], [ "o", Color(1.0, 1.0, 1.0, 1.0), Color(0.0, 0.8, 0.2, 1.0) ] ])


	.action_{|v|


		 v.value.postln;
		 id = i;
		 id.postln;
		 //~rivi[i] = v.value;
		 //~rivi.postln;

		 };


});


// ISOT NAPIT

c = Button.new(window, Rect(100, 10, 50, 22))
	.states_([ [ "CLOSE", Color(1.0, 1.0, 1.0, 1.0), Color(0.8, 0.2, 0.2, 1.0) ], [ "-", Color(1.0, 1.0, 1.0, 1.0), Color(0.0, 0.8, 0.2, 1.0) ] ])


	.action_{|v|


			window.close;

};

	d = Button.new(window, Rect(160, 10, 50, 22))
	.states_([ [ "START", Color(1.0, 1.0, 1.0, 1.0), Color(0.0, 0.8, 0.2, 1.0) ], [ "STOP", Color(1.0, 1.0, 1.0, 1.0), Color(0.8, 0.2, 0.2, 1.0) ] ])

	.action_{|v|


	switch (v.value) {0} {sekvenssi.stop;

		 for (0,39, {arg i;

			{a[i].value = 0;}.defer});




	}


	{1} {sekvenssi.start(tempo,quant: queu)};



};



e = EZKnob.new(window, Rect(200, 10, 80, 90), "TEMPO", spek)

.action_{|v|

	~tempoknobi = v.value;
	tempo.tempo_(v.value/60*~tempokerroin);

	tempo.tempo.postln;




};


f = Button.new(window, Rect(260, 90, 50, 22))
.states_([ [ "1", Color(1.0, 1.0, 1.0, 1.0), Color(0.0, 0.5, 0.5, 1.0) ], [ "1/2", Color(1.0, 1.0, 1.0, 1.0), Color(0.0, 0.5, 0.5, 1.0) ], ["1/4", Color(1.0,1.0,1.0,1.0), Color(0.0,0.5,0.5,1.0)], ["1/8", Color(1.0,1.0,1.0,1.0), Color(0.0,0.5,0.5,1.0)] ])

	.action_{|v|

	switch (v.value) {0}{~tempokerroin = 1; tempo.tempo_(~tempoknobi/60*~tempokerroin); }
	{1}{~tempokerroin = 2; tempo.tempo_(~tempoknobi/60*~tempokerroin);}
	{2}{~tempokerroin = 4; tempo.tempo_(~tempoknobi/60*~tempokerroin);}
	{3}{~tempokerroin = 8; tempo.tempo_(~tempoknobi/60*~tempokerroin);};
};


~tr1 = Button.new(window, Rect(320, 90, 60, 22))


.states_([ [ "TR1 OFF", Color(1.0, 1.0, 1.0, 1.0), Color(0.9, 0.2, 0.2, 1.0) ], [ "TR1 ON", Color(1.0, 1.0, 1.0, 1.0), Color(0.2, 0.9, 0.2, 1.0) ] ])

	.action_{|v|

	~tr1.value.postln;


};




~tr2 = Button.new(window, Rect(340, 90, 60, 22))


.states_([ [ "TR2 OFF", Color(1.0, 1.0, 1.0, 1.0), Color(0.9, 0.2, 0.2, 1.0) ], [ "TR2 ON", Color(1.0, 1.0, 1.0, 1.0), Color(0.2, 0.9, 0.2, 1.0) ] ])

	.action_{|v|

};



~tr3 = Button.new(window, Rect(410, 90, 60, 22))


.states_([ [ "TR3 OFF", Color(1.0, 1.0, 1.0, 1.0), Color(0.9, 0.2, 0.2, 1.0) ], [ "TR3 ON", Color(1.0, 1.0, 1.0, 1.0), Color(0.2, 0.9, 0.2, 1.0) ] ])

	.action_{|v|

};




~tr4 = Button.new(window, Rect(320, 90, 60, 22))


.states_([ [ "TR4 OFF", Color(1.0, 1.0, 1.0, 1.0), Color(0.9, 0.2, 0.2, 1.0) ], [ "TR4 ON", Color(1.0, 1.0, 1.0, 1.0), Color(0.2, 0.9, 0.2, 1.0) ] ])

	.action_{|v|

};








// FUNKTIOITA


selvittaja = {arg i;

		var valo, rivi1, rivi2, rivi3, rivi4;
	    var soitetaanko = Array.newClear(5);
		soitetaanko[..5] = false;

		valo = i;
		rivi1 = i;
	rivi2 = (i+40);
	rivi3 = (i+80);
	rivi4 = (i+120);

	["SELVITYS: ", valo.value, rivi1.value, rivi2.value, rivi3.value, rivi4.value].postln;

	{~selvitys = [b[rivi1].value*~tr1.value, b[rivi2].value*~tr2.value, b[rivi3].value*~tr3.value, b[rivi4].value*~tr4.value]}.defer;


	soittaja.value(~selvitys);

	};



soittaja = {arg z;


	if (z[0]==1, {


		naputtaja1.start;

		};
	);

		//tähän syna ja synan asetukset





		if (z[1]==1, {


		naputtaja2.start;


		};


	);


		//tähän syna ja synan asetukset



	if (z[2]==1, {


		j = Synth("Syna", [\hertz, ~hz3, \pan, 0,
			\vol, ~volumes3[1],
			\sus, ~volumes3[2] , \att, ~times3[0] , \dec,~times3[1] ,
			\rel,~times3[2], \width,~rwdt3, \stfreq,~rgr3 ]);
		//tähän syna ja synan asetukset

		"syna 3 soi".postln;

	});



	if (z[3]==1, {

		k = Synth("Syna", [\hertz, ~hz4, \pan, 0,
			\vol, ~volumes4[1],
			\sus, ~volumes4[2] , \att, ~times4[0] , \dec,~times4[1] ,
			\rel,~times4[2], \width,~rwdt4, \stfreq,~rgr4]);
		//tähän syna ja synan asetukset

		"syna 4 soi".postln;

	});



	};





sekvenssi = Task {//arg f;

	         var counter, rivi1, rivi2, rivi3,rivi4, valo, temp;
	f=(0-1);
	f.postln;



			2000.do{


		f = f+1;



		if (f==0, {selvittaja.value(0);});



		if (f!=0, {

			selvittaja.value(f);

			if (f<40, {
				{a[f-1].value = 1;}.defer;
				if (f!=1, {{a[f-2].value = 0}.defer;});


		// f.postln;




			});

		});

		if (f>39, {

			f = 0;
			selvittaja.value(0);
			{a[0].value = 1}.defer;
			{a[38].value = 0}.defer;
		});



		1.wait;

};
};


// sekvenssi.play(tempo);


naputtaja1 = Task {arg o;

		p.send($w, $d, 12, 1);
		0.05.wait;
		p.send($w, $d, 12, 0);


};

naputtaja2 = Task {arg o;

		p.send($w, $d, 11, 1);
		0.05.wait;
		p.send($w, $d, 11, 0);


};

)








