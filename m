Received: from eggs.gnu.org ([2001:4830:134:3::10]:57302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYa9Z-0007JA-4u
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYa9X-00012d-AT
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:15:29 -0500
Date: Tue, 31 Jan 2017 15:15:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131151519.GU18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-16-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b9dEYEwnDXkv9lSy"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-16-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 15/21] bitmap: add bitmap_count_between()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--b9dEYEwnDXkv9lSy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:58PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  include/qemu/bitmap.h |  4 ++++
>  util/bitmap.c         | 27 +++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>=20
> diff --git a/include/qemu/bitmap.h b/include/qemu/bitmap.h
> index 63ea2d0..3bfc33e 100644
> --- a/include/qemu/bitmap.h
> +++ b/include/qemu/bitmap.h
> @@ -216,6 +216,10 @@ static inline int bitmap_intersects(const unsigned l=
ong *src1,
>      }
>  }
> =20
> +unsigned long bitmap_count_between(const unsigned long *src,
> +                                   unsigned long start,
> +                                   unsigned long end);

Please add this to the table of functions documented at the top of the
header file.

> +
>  void bitmap_set(unsigned long *map, long i, long len);
>  void bitmap_set_atomic(unsigned long *map, long i, long len);
>  void bitmap_clear(unsigned long *map, long start, long nr);
> diff --git a/util/bitmap.c b/util/bitmap.c
> index 43ed011..e5aaa1c 100644
> --- a/util/bitmap.c
> +++ b/util/bitmap.c
> @@ -336,3 +336,30 @@ int slow_bitmap_intersects(const unsigned long *bitm=
ap1,
>      }
>      return 0;
>  }
> +
> +unsigned long bitmap_count_between(const unsigned long *src,
> +                                   unsigned long start,
> +                                   unsigned long end)

Most of the other functions use long start and long nr.  Please follow
that convention.

--b9dEYEwnDXkv9lSy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkKoHAAoJEJykq7OBq3PI+B4H/A/js7k0rsyQeDJy3rfNwETN
qHvrOgBhbfK5VwlgtA+YtiS/mdiZwjH2RrfNpLe6AZ8OQgmiHD7+O3apVh9gegUk
DYY1ijIJX0CV3apkMNKFLVwLx09Be5rv30OITxJaEqoHMgglMjGoJVaAh7ylgo8r
NC/clF6QMg8UJFhUbCyG8D2HzrLoaGZv/tdd5uUoCRFSvACiT01sbvgkOs402BgQ
rUKeWULdJpEYECtTEaml3z89lSrfvOY3QqEpSyEO6e7F3zAnfqyhgNELyObkuryA
lczmy0gcjTi5SKkbmljckuKrJde58/BnviKFNpU2tdSgbuj6zQUwg0KrNjlxtsY=
=e92r
-----END PGP SIGNATURE-----

--b9dEYEwnDXkv9lSy--
