Received: from eggs.gnu.org ([2001:4830:134:3::10]:47317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1dOhob-0006V9-5H
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 05:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hossein.ajallooiean@epfl.ch>) id 1dOhoX-0005i6-9C
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 05:57:17 -0400
Received: from smtp0.epfl.ch ([2001:620:618:1e0:1:80b2:e058:1]:40778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hossein.ajallooiean@epfl.ch>)
	id 1dOhoW-0005hY-VZ
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 05:57:13 -0400
From: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>
Date: Sat, 24 Jun 2017 09:57:03 +0000
Message-ID: <1498298223332.65648@epfl.ch>
References: <1498045580087.46004@epfl.ch>,<87injotkxi.fsf@linaro.org>
In-Reply-To: <87injotkxi.fsf@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Looking for ideas: Single process vs multi process
 qemu instances
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Alex,=0A=
=0A=
Thanks for you email.=0A=
=0A=
I'm on x86-64 and am emulating ARM64 using TCG - QEMU 2.9.=0A=
=0A=
Well I was hoping to see if I can use a single process to have all the mach=
ines within it to do a simple lockstep execution among the emulating machin=
es. =0A=
=0A=
Im assuming the biggest issue is the thread conflicts the machines would ha=
ve? other than that do you see any other obstacles?=0A=
=0A=
Thanks=0A=
Hoss=0A=
=0A=
________________________________________=0A=
From: Alex Benn=E9e <alex.bennee@linaro.org>=0A=
Sent: Thursday, June 22, 2017 11:45 AM=0A=
To: Ajallooiean Hossein=0A=
Cc: qemu-devel@nongnu.org=0A=
Subject: Re: [Qemu-devel] Looking for ideas: Single process vs multi proces=
s qemu instances=0A=
=0A=
Ajallooiean Hossein <hossein.ajallooiean@epfl.ch> writes:=0A=
=0A=
> Hi All,=0A=
>=0A=
>=0A=
> we are trying to do server simulation and for that purpose we need to=0A=
> have multiple Qemu instances (each can have a different spec) that are=0A=
> part of a virtual network (ns-3 in our case).=0A=
=0A=
So you are talking about using TCG for simulation rather than KVM here?=0A=
=0A=
>=0A=
>=0A=
> Now for the Qemu implementation part: would it be easier/better to=0A=
> have all the Qemu instances under a single process or multiple=0A=
> processes? i am assuming if one single process is used, there will be=0A=
> a threading conflict that would probably need to be looked at.=0A=
=0A=
QEMU isn't really setup for multiple machine instances in the one=0A=
binary. If you are simulating a complex set of communicating machines=0A=
then you will need one QEMU instance per machine.=0A=
=0A=
TCG can now use multiple threads (one per emulated vCPU) but this has=0A=
only been enabled for a subset of architectures so far. You don't say=0A=
what architecture your servers machines are.=0A=
=0A=
>=0A=
>=0A=
> I am looking at this purely from a management/performance view.=0A=
>=0A=
>=0A=
> Any ideas/suggestions?=0A=
>=0A=
>=0A=
> Thanks=0A=
>=0A=
> Hoss=0A=
=0A=
=0A=
--=0A=
Alex Benn=E9e=0A=
