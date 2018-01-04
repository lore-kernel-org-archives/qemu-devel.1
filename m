Received: from eggs.gnu.org ([2001:4830:134:3::10]:49097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX6Pg-0001O0-7Z
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX6Pe-0000HY-OC
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:22:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eX6Pe-0000GQ-E6
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:22:30 -0500
References: <1515068847-20311-1-git-send-email-thuth@redhat.com>
	<20180104132600.ikr4migzznhantmt@var.youpi.perso.aquilenet.fr>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8590ff50-6b1a-c85f-c9fb-a70ebf8132b5@redhat.com>
Date: Thu, 4 Jan 2018 15:22:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180104132600.ikr4migzznhantmt@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 04.01.2018 14:26, Samuel Thibault wrote:
> Hello,
>=20
> I'm afraid I can't even work out how to replace -usbdevice braille (or
> -usbdevice serial, all questions below apply, except making chardev
> default to braille):
>=20
> ... -usbdevice braille
>=20
> -usbdevice braille: '-usbdevice' is deprecated, please use '-device usb=
-...' instead
>=20
> but -device usb-serial is not actually documented in the manual page
> (same for usb-keyboard, usb-tablet, etc. for instance I can't find in
> the manpage anything about replacement for -usbdevice host:nnnn:nnnn)

As mentioned in my other mail, it's in the qemu-doc here:

https://qemu.weilnetz.de/doc/qemu-doc.html#usb_005fdevices

> But then
>=20
> ... -usb -device usb-braille
>=20
> -device usb-braille: Property chardev is required
>=20
> that used to be a default, could we keep it a default when using
> -device?  Hardly anybody would want to use usb-braille with something
> else than chardev braille.

I think it's more common to not do any magic default setup with
"-device", but if you think this should be the case here, it can
certainly be added again (not with this patch here, though, since this
is a separate issue).

> ... -usb -device usb-braille,chardev=3Dbraille
>=20
> -device usb-serial,chardev=3Dbraille: Property 'usb-serial.chardev' can=
't find value 'braille'
>=20
> Uh?  It seems there is a parsing issue here?

Chardevs have to be specified with the "-chardev" parameter:

... -usb -device usb-braille,chardev=3Dbr0 -chardev braille,id=3Dbr0

 HTH,
  Thomas
