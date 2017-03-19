Received: from eggs.gnu.org ([2001:4830:134:3::10]:60035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc@brightwise.de>) id 1cpb54-0002qx-3u
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 09:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc@brightwise.de>) id 1cpb4z-0000ep-Es
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 09:41:10 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::4]:28942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marc@brightwise.de>) id 1cpb4y-0000eL-VW
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 09:41:05 -0400
Date: Sun, 19 Mar 2017 14:41:01 +0100 (CET)
From: Marc Bommert <marc@brightwise.de>
Message-ID: <556061744.76602.1489930862122@communicator.strato.de>
In-Reply-To: <CAFEAcA-82Hx102VSxxsxD_20RSRCG6BWWtvtxpY4vhWnQTFo-g@mail.gmail.com>
References: <5909E3D6-85D8-4B21-9442-CCD312A4717B@inbox.ru>
	<741795585.70221.1489871707491@communicator.strato.de>
	<CAFEAcA-82Hx102VSxxsxD_20RSRCG6BWWtvtxpY4vhWnQTFo-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Strange behaviour in network device initialization.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

> Peter Maydell <peter.maydell@linaro.org> hat am 18. M=C3=A4rz 2017 um 23:=
22 geschrieben:
>=20
> This is expected, because you're creating two devices.
> Device 1 is the one that's created by calling
> mydevice_init() here in the board code.
> Device 2 is created because you say "-device mydevice"
> on the command line.

I see. Already played around with omitting it, but I also have sporadic con=
nectivity issues with the tap device, so I thought I would need it to link =
the device with the NIC on the command line. Oops.
=20
> The slightly odd thing is that -device mydevice
> doesn't fail for you -- if you try that for smc91c111 it
> will complain:
>  "Device smc91c111 cannot be dynamically instantiated"
> to let you know that the command line option is wrong.

I suppose this is the output of add_fdt_node() in hw/arm/sysbus-fdt.c, so I=
'll try to reverse why that succeeds for my platform. That's a good pointer=
.

> PS: smc91c111 is not a very good model to copy,
> because that device code is very old, and doesn't
> necessarily follow current QEMU coding practices.
> Looking at a device that's been added to QEMU
> more recently may be a better idea.

I'll stick with it for prototyping. Probably I picked versatilepb as a blue=
print because it is better understandable and complete, with lesser indirec=
tions.

Still, so many opportunities to make errors when you work your way into thi=
s stuff.
Thank you for your time, Peter.

- Marc
