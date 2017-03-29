Received: from eggs.gnu.org ([2001:4830:134:3::10]:48210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctAs1-0001yh-Rl
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 06:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctArx-0006fC-TG
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 06:30:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ctArx-0006eF-Mt
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 06:30:25 -0400
Date: Wed, 29 Mar 2017 11:30:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170329103022.GB10462@stefanha-x1.localdomain>
References: <20170328134418.3426-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20170328134418.3426-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] configure: eliminate Python dependency
 for --help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 02:44:18PM +0100, Stefan Hajnoczi wrote:
> The ./configure script should produce --help output even if Python is
> not installed.
>=20
> Listing trace backends is simple: show the names of all Python modules
> in scripts/tracetool/backend/ whose source code contains 'PUBLIC =3D
> True'.
>=20
> Perform the backend enumeration in shell instead of Python so that we
> can move the Python check until after ./configure --help.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Make grep regex portable [Peter]
>  * Enumerate trace backends outside help text [Peter]
>=20
>  configure | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)

Thanks, applied to my tracing-next tree for QEMU 2.10:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY24y+AAoJEJykq7OBq3PIT0oH/1IeRJeuNFBf7aNXJXtd6+Y3
yy8V3arNI7RsBaCmIikKd/dAhy5sDvna4abgOA7Ytm2ySM/hi0LA6QeUMMJzQ4YM
wuv2yonDrTfLORwd6eUBfjdgxyPUO0/nxlOxkXDdOp2YQLuVjesPqDBY02HyKuOx
TBbbhr9uQY5IS45+pq53mxSkvK3C78F/mXJE18sn9+6N749op9CK92d0SQhPfIIS
daSsWg6XxuV2+ehiwdknjXYw/MHSWjG3U6m72wqM8V1NF9CALSXXvBKN9fr19lIq
ylb+aw4qf2tYLyBef5qG9e4jop7LvGI8gom8YrIPoLy6QY7qq1fJZNbczk/eN38=
=E2D2
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
