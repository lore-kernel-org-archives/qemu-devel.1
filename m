Received: from eggs.gnu.org ([2001:4830:134:3::10]:43801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdI6u-0003IA-Sl
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdI6u-0006MF-10
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:00:12 -0500
Date: Mon, 13 Feb 2017 15:00:03 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213150003.GO10361@stefanha-x1.localdomain>
References: <20170208170533.28822-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCFQJunhLz1tFGpX"
Content-Disposition: inline
In-Reply-To: <20170208170533.28822-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ide: remove undefined behavior in ide-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-trivial@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org


--lCFQJunhLz1tFGpX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2017 at 12:05:33PM -0500, John Snow wrote:
> trivial: initialize the dirty buffer with a random-ish byte.
> Stops valgrind from whining about uninitialized buffers.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/ide-test.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/ide-test.c b/tests/ide-test.c
> index 2fa97bc..139ebc0 100644
> --- a/tests/ide-test.c
> +++ b/tests/ide-test.c
> @@ -550,6 +550,7 @@ static void make_dirty(uint8_t device)
> =20
>      guest_buf =3D guest_alloc(guest_malloc, len);
>      buf =3D g_malloc(len);
> +    memset(buf, rand() % 255 + 1, len);

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>      g_assert(guest_buf);
>      g_assert(buf);

Pre-existing issue:
g_assert(buf) is unnecessary since g_malloc() is guaranteed to return
non-NULL.

--lCFQJunhLz1tFGpX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYocnzAAoJEJykq7OBq3PIxsMH/3IPQSmdSDkeryjxY0Aaa5/l
rISxzCyc4P83J0zqznDN2rctasaTbDkyeAhrM+YH6GUYUL6b7vsK4WzmqZwSsrl2
bA4oe//Ls8VNI80BkkfTKC0Vr5+YbqJdcEAmpT+nqqLYOeKWwS8Y2WK+4GDAOaL+
yQZBaGH2UlYm5V5k/k5UrlSVRz0DpjQwt84r50LQzu7ywd/7mrJxQcLnXyGAYEcB
ATWYUvfiu7wkvdRcKicgns35x0AccR65TnLcBLG1JiU+6ED0V7vzyZJIQFytiyuo
qptbdEWkuRHu6mwcQCPCNhw6Mdh0cXu6A9tu7r5iRbzQxXU4QLpLaJxPcpepj0U=
=yy8y
-----END PGP SIGNATURE-----

--lCFQJunhLz1tFGpX--
