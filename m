Received: from eggs.gnu.org ([2001:4830:134:3::10]:40462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dxBLY-0002Ym-Fj
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dxBLV-0003tt-8p
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:21:48 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Wed, 27 Sep 2017 12:21:30 +0000
Message-ID: <AM5P194MB013209976BC625983F3265D3C8780@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <AM5P194MB0132C46F9FCCF1DCF2FFC7D0C87A0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>,
	<1506512087.25036.10.camel@redhat.com>
In-Reply-To: <1506512087.25036.10.camel@redhat.com>
Content-Language: it-IT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] ppce500 usb-ehci-pci issue on last uboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

hi Gerd,
yes the host is a big endian but i can test it on an little endian host too=
 and report.
About xhci or ohci the uboot dont recognize it . ehci-pci are the only usb =
pci board from where uboot on ppce500 vm  can make the load from device or =
use directly the device attached on  it if cmd reset work for initislize th=
e board.

regards
luigi

Inviato da iPad

> Il giorno 27 set 2017, alle ore 13:34, Gerd Hoffmann <kraxel@redhat.com> =
ha scritto:
>=20
>  Hi,
>=20
>> "actually, I tried it yesterday and it seems to be a bug in qemu in
>> case you reset the EHCI controller, it doesn't come out of reset for
>> whatever reason ... so you probably want to talk to the qemu guys,
>> it's when U-Boot sets USBCMD RESET bit and then does handshake, the
>> controller is stuck with reset bit asserted"
>>=20
>>=20
>> i ask if possible to fix it?
>=20
> Nothing obvious in the ehci reset code.  Needs someone debugging it ...
>=20
> Is this on a bigendian host?  If so this could be endian bugs in the
> ehci emulation.
>=20
> You could also try xhci or ohci instead, these are known-working on
> bigendian hosts (used by ppc64 pseries).
>=20
> cheers,
>  Gerd
>=20
>=20
