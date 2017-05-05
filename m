Received: from eggs.gnu.org ([2001:4830:134:3::10]:56820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6cwr-00088C-6O
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6cwo-0001XQ-1W
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:07:05 -0400
Date: Fri, 5 May 2017 14:06:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505130658.GE11350@stefanha-x1.localdomain>
References: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Refactor DMG driver to have chunk
 size independence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, famz@redhat.com, peter@lekensteyn.nl, qemu-devel@nongnu.org, qemu-block@nongnu.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 01:36:30PM +0530, Ashijeet Acharya wrote:
> ->Testing procedure:
> Convert a DMG file to raw format using the "qemu-img convert" tool presen=
t in
> v2.9.0
> Next convert the same image again after applying these patches.
> Compare the two images using "qemu-img compare" tool to check if they are
> identical.
>=20
> You can pickup any DMG image from the collection present
> Here -> https://lists.gnu.org/archive/html/qemu-devel/2014-12/msg03606.ht=
ml

Please add a qemu-iotests test case:
http://wiki.qemu.org/Testing/QemuIoTests

Image files can be included in tests/qemu-iotests/sample_images/.  They
must be small.

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDHjyAAoJEJykq7OBq3PIXywIAKC4jWhcfMDtt9+OQ9XffxTR
Gy+vXJwEKQMOzRZQma49a3YN7MiG9geEGFOoghAwOWvunEFJFZD/mO1GdR8JVgK0
8upZl4N/I8z0JRGfWkphvs2r+6H6feLNsu1Bc5vEPhnyACJOw8ZDou9K+BL1IZPd
MyBX6YRHwBniQHNiVP6vN1zEa6gzXgvpnLQzTxHybES8U085msFC++3yFVAjnxOC
ZADo/BV5EFq2UbrUvLdK6n37M9j1E8oi7OBXtIwpsbb6YsgxrKNkAuk4XAss77CB
PDqGbhq5tWiAh9z2AZiIKPkty2h8Q5pKs8eUknD/E3rJGUBRD0HPyyJ0fVWZBow=
=tXP8
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
