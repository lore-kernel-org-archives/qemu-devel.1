Received: from eggs.gnu.org ([2001:4830:134:3::10]:52013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrzH-0003QD-0z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrzC-00031m-5g
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:01:47 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:32931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dUrzB-00031I-Ts
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:01:42 -0400
Received: by mail-lf0-f42.google.com with SMTP id z78so80586075lff.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 03:01:41 -0700 (PDT)
Date: Tue, 11 Jul 2017 11:00:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711100037.GK17792@stefanha-x1.localdomain>
References: <CAFSh4Uw0bH=a18C0s0k9FReSTebihesfEuwT+PV2Vp50LsX8sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUvfsPTz/SzOZDdw"
Content-Disposition: inline
In-Reply-To: <CAFSh4Uw0bH=a18C0s0k9FReSTebihesfEuwT+PV2Vp50LsX8sA@mail.gmail.com>
Subject: Re: [Qemu-devel] Modular hardware emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tom Cook <tom.k.cook@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--fUvfsPTz/SzOZDdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 05:56:51PM +0000, Tom Cook wrote:
> I'm using qemu to emulate a certain fruit-flavoured single-board computer=
 -
> which is fantastic for testing changes configuration, by the way.
>=20
> We have a bit of custom hardware attached to that single-board computer -
> essentially an SPI-slave 8-channel ADC with some analog electronics
> attached.
>=20
> I'm trying to get a feel for the level of effort involved in writing an
> emulation of this custom hardware that will work with qemu.  I can see two
> extremes:  At one end of the scale, there might be a nice Python interface
> already in place for writing SPI device emulations and all I need to do is
> point a command-line parameter at a suitable script and away it goes.  At
> the other end, I need to hack around in the qemu source, understand about
> 3/4 of it and create a custom build of the whole emulator.
>=20
> Can someone give me some sort of idea what level of effort is involved, a=
nd
> perhaps a pointer in the right direction, please?

Emulated devices are part of the QEMU codebase.  They live in hw/.  You
would have to learn about QEMU internals to add a custom device.

I'm not an ARM expert or familiar with SPI, but the starting point would
be looking at the machine type (board) you are using and locating the
SPI controller (BCM2835 SPI0?).  See if that is emulated in QEMU and if
there are any existing devices for you to study.

git grep -i '\<spi\>' doesn't show much evidence of true SPI support.
There is SSI and I2C support though, so at least those would give you an
idea of how to add SPI.

Stefan

--fUvfsPTz/SzOZDdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZKHFAAoJEJykq7OBq3PIXC4H/207xFIiZvgQgG6ZiWyVWRa2
ksbL1olzEms8uEypIRcC5eg5vBqnBrIcf2W1wq9YIWSxTukT89RvJnBgK4cOt0cz
n/AX7OIN5IoDpc/d8LpJJrqvZ7/+X4vi490lMm7Wrf+ifEAacVfccf8DzUgaD4V4
4Bu5GXzxJBig1T9eOIhw7ki53IBa7x+32T3Tlkw3N/Yx4a+oPGG7QG+6Vjl4B/kZ
kCTAOZrTPAe9ctguPW/dfJkmP3NimmirEyWO6zHW1leoGFuuYN/hRNU9jsfkHnwC
Ppoexv/5HXOUdL0eiqVUKORGWyxJf6u88rQrut9NHlUMrYj4jEtBgHpE9hB6rGw=
=SwPh
-----END PGP SIGNATURE-----

--fUvfsPTz/SzOZDdw--
