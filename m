Received: from eggs.gnu.org ([2001:4830:134:3::10]:49508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dCjbG-0004q6-7T
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dCjbD-0003A4-4H
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:26:02 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dCjbC-00039u-Tw
	for qemu-devel@nongnu.org; Mon, 22 May 2017 05:25:59 -0400
Received: by mail-wm0-x243.google.com with SMTP id k15so30610172wmh.3
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 02:25:58 -0700 (PDT)
Date: Mon, 22 May 2017 10:25:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170522092555.GC12205@stefanha-x1.localdomain>
References: <CA+9O3V3G8CqDuKWMP3wT2j+e7GB0B9Xe1ps22MT9eViSFEC3zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <CA+9O3V3G8CqDuKWMP3wT2j+e7GB0B9Xe1ps22MT9eViSFEC3zg@mail.gmail.com>
Subject: Re: [Qemu-devel] How to pass intercepted mouse move x and y from
 host to a virtual machine running in Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Syvak <alexander.svk@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 20, 2017 at 10:44:23AM +0300, Alexander Syvak wrote:
> Hi, guys!
>=20
> There exists a manually written virtual USB device registered as Qemu typ=
e.
>=20
> It reads 5 bytes
>=20
> - x and y of a mouse move, x and y of scrolling, and buttons state -
>=20
> from mouse.fifo but there is no code in the implementation file which wou=
ld
> actually parse those bytes.
>=20
> First where does Qemu actually parse those bytes?
>=20
> And the most important - can I actually pass double value for a mouse mov=
e?
>=20
> I use libinput in order to intercept host input events.

It's not clear whether you are referring to a device in qemu.git or
custom code.  If you want help with custom code, please post a link to
the source.  If you want help with qemu.git code, please mention
specific the filename and/or function name you are asking about.

CCing Gerd Hoffman, USB maintainer.

Stefan

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZIq6jAAoJEJykq7OBq3PIn5gIAL+4Kj+CXV3tAxg1CuZY3/Es
SPPPjj7MfVMHxd+89XaNdXUSDUZmUSHfaH/xFF+kKjzC5hCDhtiWXRs15aW4cgBP
ymEep9472dDjyRcRe2UutYsexEonWYMDOxY218VzODbMNfMH5kHqcJ39D7utboI1
HIuntfBVFAGdJ8qrCtETs1NP2hoy2+G1HmHvl1yhZWlCcqQBx23COg/i9nTsruug
9rEjCj7Nmg0ru0iqSzBkcotdHqCyOPcOZbbq+SVli3S7LQZHzWz/Q4To7JgRDgCb
BAseyeXtEdwj504xk9gWv8nGvhMaSuzZez7U0VFdA874zKU7EBcijjjlPeoMNhc=
=YaMb
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
