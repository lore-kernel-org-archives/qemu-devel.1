Received: from eggs.gnu.org ([2001:4830:134:3::10]:39090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiaxin.wu@intel.com>) id 1dT09v-0003Nt-QS
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 02:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiaxin.wu@intel.com>) id 1dT09s-0000SK-Kj
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 02:21:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:63116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiaxin.wu@intel.com>) id 1dT09s-0000Qy-6a
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 02:21:00 -0400
From: "Wu, Jiaxin" <jiaxin.wu@intel.com>
Date: Thu, 6 Jul 2017 06:20:54 +0000
Message-ID: <895558F6EA4E3B41AC93A00D163B7274162E2512@SHSMSX103.ccr.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] The maximum limit of virtual network device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Wu, Jiaxin" <jiaxin.wu@intel.com>

Hello experts,

We know QEMU has the capability to create the multiple network devices in o=
ne QEMU guest with the -device syntax. But I met the below failure when I'm=
 trying to create more than 30 virtual devices with the each TAP backend:

qemu-system-x86_64: -device e1000: PCI: no slot/function available for e100=
0, all in use.

The corresponding QEMU command shows as following:

sudo qemu-system-x86_64 -pflash OVMF.fd -global e1000.romfile=3D"" -netdev =
tap,id=3Dhostnet0,ifname=3Dtap0,script=3Dno,downscript=3Dno -device e1000,n=
etdev=3Dhostnet0 -netdev tap,id=3Dhostnet1,ifname=3Dtap1,script=3Dno,downsc=
ript=3Dno -device e1000,netdev=3Dhostnet1 -netdev tap,id=3Dhostnet2,ifname=
=3Dtap2,script=3Dno,downscript=3Dno -device e1000,netdev=3Dhostnet2 -netdev=
 tap,id=3Dhostnet3,ifname=3Dtap3,script=3Dno,downscript=3Dno -device e1000,=
netdev=3Dhostnet3 -netdev tap,id=3Dhostnet4,ifname=3Dtap4,script=3Dno,downs=
cript=3Dno -device e1000,netdev=3Dhostnet4 -netdev tap,id=3Dhostnet5,ifname=
=3Dtap5,script=3Dno,downscript=3Dno -device e1000,netdev=3Dhostnet5 -netdev=
 tap,id=3Dhostnet6,ifname=3Dtap6,script=3Dno,downscript=3Dno -device e1000,=
netdev=3Dhostnet6 -netdev tap,id=3Dhostnet7,ifname=3Dtap7,script=3Dno,downs=
cript=3Dno -device e1000,netdev=3Dhostnet7 -netdev tap,id=3Dhostnet8,ifname=
=3Dtap8,script=3Dno,downscript=3Dno -device e1000,netdev=3Dhostnet8 -netdev=
 tap,id=3Dhostnet9,ifname=3Dtap9,script=3Dno,downscript=3Dno -device e1000,=
netdev=3Dhostnet9 -netdev tap,id=3Dhostnet10,ifname=3Dtap10,script=3Dno,dow=
nscript=3Dno -device e1000,netdev=3Dhostnet10 -netdev tap,id=3Dhostnet11,if=
name=3Dtap11,script=3Dno,downscript=3Dno -device e1000,netdev=3Dhostnet11 -=
netdev tap,id=3Dhostnet12,ifname=3Dtap12,script=3Dno,downscript=3Dno -devic=
e e1000,netdev=3Dhostnet12 -netdev tap,id=3Dhostnet13,ifname=3Dtap13,script=
=3Dno,downscript=3Dno -device e1000,netdev=3Dhostnet13 -netdev tap,id=3Dhos=
tnet14,ifname=3Dtap14,script=3Dno,downscript=3Dno -device e1000,netdev=3Dho=
stnet14 -netdev tap,id=3Dhostnet15,ifname=3Dtap15,script=3Dno,downscript=3D=
no -device e1000,netdev=3Dhostnet15 -netdev tap,id=3Dhostnet16,ifname=3Dtap=
16,script=3Dno,downscript=3Dno -device e1000,netdev=3Dhostnet16 -netdev tap=
,id=3Dhostnet17,ifname=3Dtap17,script=3Dno,downscript=3Dno -device e1000,ne=
tdev=3Dhostnet17 -netdev tap,id=3Dhostnet18,ifname=3Dtap18,script=3Dno,down=
script=3Dno -device e1000,netdev=3Dhostnet18 -netdev tap,id=3Dhostnet19,ifn=
ame=3Dtap19,script=3Dno,downscript=3Dno -device e1000,netdev=3Dhostnet19 -n=
etdev tap,id=3Dhostnet20,ifname=3Dtap20,script=3Dno,downscript=3Dno -device=
 e1000,netdev=3Dhostnet20 -netdev tap,id=3Dhostnet21,ifname=3Dtap21,script=
=3Dno,downscript=3Dno -device e1000,netdev=3Dhostnet21 -netdev tap,id=3Dhos=
tnet22,ifname=3Dtap22,script=3Dno,downscript=3Dno -device e1000,netdev=3Dho=
stnet22 -netdev tap,id=3Dhostnet23,ifname=3Dtap23,script=3Dno,downscript=3D=
no -device e1000,netdev=3Dhostnet23 -netdev tap,id=3Dhostnet24,ifname=3Dtap=
24,script=3Dno,downscript=3Dno -device e1000,netdev=3Dhostnet24 -netdev tap=
,id=3Dhostnet25,ifname=3Dtap25,script=3Dno,downscript=3Dno -device e1000,ne=
tdev=3Dhostnet25 -netdev tap,id=3Dhostnet26,ifname=3Dtap26,script=3Dno,down=
script=3Dno -device e1000,netdev=3Dhostnet26 -netdev tap,id=3Dhostnet27,ifn=
ame=3Dtap27,script=3Dno,downscript=3Dno -device e1000,netdev=3Dhostnet27 -n=
etdev tap,id=3Dhostnet28,ifname=3Dtap28,script=3Dno,downscript=3Dno -device=
 e1000,netdev=3Dhostnet28 -netdev tap,id=3Dhostnet29,ifname=3Dtap29,script=
=3Dno,downscript=3Dno -device e1000,netdev=3Dhostnet29

>From above,  the max limit of virtual network device in one guest is about =
29? If not, how can I avoid such failure? My use case is to create more tha=
n 150 network devices in one guest. Please provide your comments on this.

Thank you!

Best Regards.
Jiaxin
