Received: from eggs.gnu.org ([2001:4830:134:3::10]:45713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxuiK-0000hT-Dn
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxuiJ-0001yY-Jt
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:48:20 -0400
References: <20170927211334.3988-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6b78de48-1f51-8b12-62ee-d81f7194b6c6@redhat.com>
Date: Fri, 29 Sep 2017 14:48:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170927211334.3988-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jFWK3r3XrvOU4OBRwD70l2FcfUraQ8AMf"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix 195 if IMGFMT is part of
 TEST_DIR
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jFWK3r3XrvOU4OBRwD70l2FcfUraQ8AMf
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <6b78de48-1f51-8b12-62ee-d81f7194b6c6@redhat.com>
Subject: Re: [PATCH] iotests: Fix 195 if IMGFMT is part of TEST_DIR
References: <20170927211334.3988-1-mreitz@redhat.com>
In-Reply-To: <20170927211334.3988-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-27 23:13, Max Reitz wrote:
> do_run_qemu() in iotest 195 first applies _filter_imgfmt when printing
> qemu's command line and _filter_testdir only afterwards.  Therefore, if=

> the image format is part of the test directory path, _filter_testdir
> will no longer apply and the actual output will differ from the
> reference output even in case of success.
>=20
> For example, TEST_DIR might be "/tmp/test-qcow2", in which case
> _filter_imgfmt first transforms this to "/tmp/test-IMGFMT" which is no
> longer recognized as the TEST_DIR by _filter_testdir.
>=20
> Fix this by not applying _filter_imgfmt in do_run_qemu() but in
> run_qemu() instead, and only after _filter_testdir.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/195 | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied to my block branch.

Max


--jFWK3r3XrvOU4OBRwD70l2FcfUraQ8AMf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnOQQgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AeGAH/1s+II4MiZODnaGLwbdv70hKugBbLua5
nv+QaW1V5/rY5ZWIfkClyCZLsvNknVwYPntU+OY6Dsw9svvGvibQuo+Q3ZxGxCtN
aTmNqDuGj9ig+dBUwKCEDBk3/eiR9V/VqAlE7DkQYHkVU0vVVFNNpJnvyMwj+SWL
2uTZxkRRQeeMswTswVOA2lSyLTTSwi5x/Uh62g89QOltfP/rauFJlQ3lU0T9MBSt
UpvE2zA9zce9IeCz+GYMb05DO/sEUOdTPFi+bDATBY2/13OJ2JaW1Pe8NJiz0LJ4
cdVzF2BW/mJo/9snlsG+RxWNW87S4iUbmuQM6yOa6lydONaLg1hhVHI=
=zE3F
-----END PGP SIGNATURE-----

--jFWK3r3XrvOU4OBRwD70l2FcfUraQ8AMf--
