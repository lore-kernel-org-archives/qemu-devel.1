Received: from eggs.gnu.org ([2001:4830:134:3::10]:59447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dsFul-0001N3-C5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dsFuk-0006Zz-0r
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:13:47 -0400
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:44039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dsFuj-0006Wj-Rc
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 18:13:45 -0400
Received: by mail-io0-x230.google.com with SMTP id v36so9512076ioi.1
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 15:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <2385fc24-dbc3-ba7c-948f-b986edb27c7a@advancedtelematic.com>
In-Reply-To: <2385fc24-dbc3-ba7c-948f-b986edb27c7a@advancedtelematic.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 13 Sep 2017 22:13:33 +0000
Message-ID: <CAJ+F1C+TZy=DY1d4qTf75iqkJ=-0nuOADa-h1SD1ZR3uj-BVTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Trying to use ccid-card-emulated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patrick Vacek <patrick@advancedtelematic.com>, qemu-devel@nongnu.org

Hi Patrick

On Wed, Sep 6, 2017 at 5:04 PM Patrick Vacek <patrick@advancedtelematic.com=
>
wrote:

> Hello,
>
> I'm trying to emulate a smartcard. I found section 4 of docs/ccid.txt,
> which appears to do exactly what I'm interested in. However, that
> document is a few years old and references CoolKey, which at this point
> seems obsolete, with OpenSC being the preferred succcessor. I've
> followed the rest of steps with success, and tried registering OpenSC
> with NSS (i.e. modutil -dbdir /etc/pki/nssdb -add "CAC Module" -libfile
> /usr/lib/opensc-pkcs11.so), but I'm still not seeing my three
> certificates listed on the device as I'd expect.
>
> I'm using QEMU emulator version 2.8.0(Debian 1:2.8+dfsg-3ubuntu2.3).
> I've also tried using QEMU emulator version 2.10.0 (built from source),
> but the interface has changed and the commands from the documentation
> don't work anymore.
>
> 1. Am I correct to assume that OpenSC is the logical successor to
> CoolKey, and should I expect a simple substitution such as that to work?
>

 That's my understanding too, and it seems Fedora 26 deprecated coolkey.
However, when I tried opensc a few years with qemu/libcacard, it didn't
work. I haven't looked further since.

2. Are there other steps I might be overlooking with OpenSC or with
> getting the certificates recognized on the device?
>

I would first try to get coolkey module to work, before debuging opensc.
Ideally get some help from opensc developper since qemu should still work
with coolkey.

3. If, as I suspect, that document is no longer up to date, what do the
> steps currently look like to get smartcard emulation working?
>

They look still pretty ok to me. certutil usage may have changes, but qemu
& coolkey didn't change I think.

What problems did you have when trying to setup following docs/ccid.txt ?
we may want to update the doc.

Thanks
--=20
Marc-Andr=C3=A9 Lureau
