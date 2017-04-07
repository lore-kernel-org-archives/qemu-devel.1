Received: from eggs.gnu.org ([2001:4830:134:3::10]:46806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1cwfwj-0001Gn-Bz
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 22:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1cwfwg-0003nH-69
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 22:17:49 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Fri, 7 Apr 2017 17:49:55 +0000
Message-ID: <AM5P194MB01294EAC74E1825F9210E04CC80C0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "rth@twiddle.net" <rth@twiddle.net>
Cc: "programmingkidx@gmail.com" <programmingkidx@gmail.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>

Tested on PowerMac G5 Quad  and 380% of system load and working on

Fedora 25 PPC64 host and Ubuntu Mate 17.04 guest  (patched the 2.9 rc3)


The machine configuration was this

sudo ./qemu-system-ppc64 -cpu POWER8 -vga none -machine pseries-2.5,usb=3Do=
ff -m 2G  -smp 4,cores=3D4,threads=3D1 -accel tcg,thread=3Dmulti  -kerne vm=
linuz    -append root=3D/dev/sda   -device ich9-ahci,id=3Dahci   -device id=
e-drive,drive=3Ddisk0 -drive file=3D/dev/sda4,if=3Dnone,id=3Ddisk0   -net n=
ic,model=3Dpcnet -net user -soundhw hda  -display sdl -vga virtio


vga virtio working too

here a shot

https://scontent-mxp1-1.xx.fbcdn.net/v/t1.0-9/17796379_10208795258860396_78=
25547329794577576_n.jpg?oh=3D526d6ddeb67c817053582d5b9ee56c71&oe=3D594D7BDF


Thanks

Luigi
