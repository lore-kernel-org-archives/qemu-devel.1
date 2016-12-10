Received: from eggs.gnu.org ([2001:4830:134:3::10]:38613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cFk3q-0000BH-Jy
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cFk3n-000070-JD
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:59:42 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cFk3n-0008SB-C4
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:59:39 -0500
Received: by mail-wm0-f68.google.com with SMTP id a20so2252422wme.2
	for <qemu-devel@nongnu.org>; Sat, 10 Dec 2016 07:59:17 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <9e21bec4-4308-667f-253f-951cccc6d73d@weilnetz.de>
Date: Sat, 10 Dec 2016 17:58:13 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <AEB799AB-D03E-417C-9B67-26158CF70B97@livius.net>
References: <bd061de5-5cf6-035c-ce1c-acda671f0463@ilande.co.uk>
	<5ef0624b-25d7-4d8d-efe4-3a51d5d212b7@weilnetz.de>
	<CABLmASGthfWrCCxmy+xfrMHzg-3vHkmirsOcQECQWh87BqmyxQ@mail.gmail.com>
	<c16121e5-4822-42b2-ec78-7347ab9cc63f@weilnetz.de>
	<CABLmASGw9httdKD1qEjxod=K4mWemt+OBKzWHL8XHSjoxuv-Yg@mail.gmail.com>
	<e9e2b4a7-991b-4713-a282-1ca27b11c022@ilande.co.uk>
	<2e61d0c2-5c16-de77-8fef-e824974e4a6f@weilnetz.de>
	<CABLmASEZw7wxfU-4gsmGkK4ObXgxiO4VFuttZagwDM60xET8Hg@mail.gmail.com>
	<CABLmASH45_ahx5c6RnvkOFcwqOb5x9t8gEm-S0Dfzs93i5C8KQ@mail.gmail.com>
	<f46fac8a-683c-08a4-5ef8-7668b91b13e0@weilnetz.de>
	<CABLmASG9hrA1go5qROhBLKk3-oR6mzFSp4wmAMz+sjr7kteing@mail.gmail.com>
	<4a68532a-aaaf-fe18-be1a-8bbd36ffd339@weilnetz.de>
	<CABLmASFXDgZ=RMzX=Py+3zLrZzMU4nRNKTTdXuHSMmsVJoXhUw@mail.gmail.com>
	<CABLmASHp8fUsui6Am4=_QpbnZmKr5_4Z=xpnxRbDBTWcTiM5sQ@mail.gmail.com>
	<1971f7f3-a69f-faa5-b7e5-350ad58b652f@weilnetz.de>
	<CABLmASFw_GYyhUBHagQ0ah8cEU4VJD9HM885dKUa9BYiJB7xDw@mail.gmail.com>
	<9e21bec4-4308-667f-253f-951cccc6d73d@weilnetz.de>
Subject: Re: [Qemu-devel] QEMU for Windows - UI status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>


> On 10 Dec 2016, at 16:33, Stefan Weil <sw@weilnetz.de> wrote:
>=20
> I started testing with SDL 2.0 today. A default build for Windows
> is not usable,

I recently migrated GNU ARM Eclipse QEMU to SDL 2, and it works just =
fine on Windows, Linux and macOS. The graphical interactions with the =
user are LEDs that blink in real time and buttons that can be pushed to =
reset and send user actions to a GPIO pin. However my fork uses my own =
event loop and my own graphical processing.

But SDL 2 itself is fine, if there is anything wrong, it must be =
searched in QEMU.


Regards,

Liviu
