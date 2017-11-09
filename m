Received: from eggs.gnu.org ([2001:4830:134:3::10]:54446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCpLt-00032g-9t
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCpLq-0003jY-1V
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:06:49 -0500
Date: Thu, 9 Nov 2017 16:06:30 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171109160630.GB25162@stefanha-x1.localdomain>
References: <20171109013804.14488-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20171109013804.14488-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/5] iotests: Make some tests
 less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2017 at 02:37:59AM +0100, Max Reitz wrote:
> There are a couple of tests that fail (on my machine) from time to
> time (and by that I mean that recently I've rarely ever had a test run
> with both 083 and 136 working on first try).
> This series should fix most (at least the issues I am aware of).
>=20
> Notes:
> - 083 might have another issue, but if so it occurs extremely rarely and
>   so I was unable to debug it.
>=20
> - 129 is flaky, too, because it tries to use block jobs with BB
>   throttling -- however, block jobs ignore that these days.  Making it
>   use a throttle filter node will require quite a bit of work.  See
>   http://lists.nongnu.org/archive/html/qemu-block/2017-11/msg00111.html
>   for more.
>=20
> - 194 sometimes hangs because the source VM fails to drain its drive.
>   This is probably not an issue with the test, but actually an issue in
>   qemu.  See
>   http://lists.nongnu.org/archive/html/qemu-block/2017-11/msg00256.html
>   for more.
>=20
>=20
> "All tests have passed, let's ship it!"
> -- Me, 2:36 am
>=20
>=20
> (Editor's note: "all" means raw/file, qcow2/file, and raw/nbd.)
>=20
>=20
> Max Reitz (5):
>   iotests: Make 030 less flaky
>   iotests: Add missing 'blkdebug::' in 040
>   iotests: Make 055 less flaky
>   iotests: Make 083 less flaky
>   iotests: Make 136 less flaky
>=20
>  tests/qemu-iotests/030 |  8 ++++++--
>  tests/qemu-iotests/040 |  2 +-
>  tests/qemu-iotests/055 | 25 ++++++++++++++++---------
>  tests/qemu-iotests/083 |  3 ++-
>  tests/qemu-iotests/136 | 14 +++++++++++++-
>  5 files changed, 38 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.13.6
>=20
>=20

Thanks for these fixes!  QEMU 2.11 material.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBH0GAAoJEJykq7OBq3PIdNEH/1NNgzjiWhsLaDvQCDb49BDV
6Snk1JI+r5v/jypiZCt6iq0URoOLSNHlrqVcdvtnLfiaMfjdT+7THj/d32r9ZXCD
u6n6syyZDv2xxbeOoszFaihV3RkYOr6P0t7umad6G2NYhJf+YuoCMi9DCrM4R65u
fiXoU/KrNCpM0sjaG8GtYgzzv2+gXjDsi+16ytYoxwbM3S0V0BtTgIgMFBiuELRY
Dicw8lYav+6Qv9rej6Nso77Wr6ym+9eD4gvXFQLxIYo/TYD7kgEI57LiF27dRmrn
CzZRKfkW52vHcSVOK6pLOhAo+VGeYUObsGC5IQbBEymwGnoYdQ7HaX7W60PjR7o=
=lJUU
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
