Received: from eggs.gnu.org ([2001:4830:134:3::10]:49231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elGa4-0008Bq-30
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elGa3-0001aF-37
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:03:48 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-19-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <84d0fa3b-06c9-613e-6abf-fc7baed9b721@redhat.com>
Date: Mon, 12 Feb 2018 17:03:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-19-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0pKHBVZMLJKvxZmHpShWLHt4xtFPE8Gex"
Subject: Re: [Qemu-devel] [PATCH 18/27] sheepdog: QAPIfy "redundacy" create
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0pKHBVZMLJKvxZmHpShWLHt4xtFPE8Gex
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <84d0fa3b-06c9-613e-6abf-fc7baed9b721@redhat.com>
Subject: Re: [PATCH 18/27] sheepdog: QAPIfy "redundacy" create option
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-19-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-19-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> The "redundacy" option for Sheepdog image creation is currently a strin=
g
> that can encode one or two integers depending on its format, which at
> the same time implicitly selects a mode.
>=20
> This patch turns it into a QAPI union and converts the string into such=

> a QAPI object before interpreting the values.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json | 45 ++++++++++++++++++++++++++
>  block/sheepdog.c     | 89 ++++++++++++++++++++++++++++++++++++--------=
--------
>  2 files changed, 107 insertions(+), 27 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index f684477328..dc0348f120 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c

[...]

> @@ -1912,35 +1954,28 @@ static int parse_redundancy(BDRVSheepdogState *=
s, const char *opt)
>          return -EINVAL;
>      }
> =20
> -    copy =3D strtol(n1, NULL, 10);
>      /* FIXME fix error checking by switching to qemu_strtol() */

But this is not the time? ;-)

> -    if (copy > SD_MAX_COPIES || copy < 1) {
> -        return -EINVAL;
> -    }
> -    if (!n2) {
> -        inode->copy_policy =3D 0;
> -        inode->nr_copies =3D copy;
> -        return 0;
> -    }
> +    copy =3D strtol(n1, NULL, 10);
> =20


--0pKHBVZMLJKvxZmHpShWLHt4xtFPE8Gex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBussSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQjEH/ipjyNg/x4a23hdbcb0SQ3HaI+3hkzUh
cwajtbvnhM4DqV8NM6MLOshGMyOBH3S6USRIryV4HDMlsIzi88YFmcbUErnLYXA6
vQx50GtyyQyq07MJHgLHUB1gG9WQi8KZrdjrkHEjSahiV6St3gZIKMaeI0CMjQwa
cNlMMBUkCJXNL4sSCj7bxnjyweBukMbO+qXDf7VJBeEgWhYRqn2n9OhP3lPeCEU0
v3zdcr8Vy2iIbwHewXQ478G2IryDi6SHxz1Z2D8Mu5QpwbO4w0CFmWZOkSNgS22u
ovIRgdom7rvCMjV1kSQHiNd9HBo1lStVJDuUzpx9XKEXceypU9+Oylo=
=lYD3
-----END PGP SIGNATURE-----

--0pKHBVZMLJKvxZmHpShWLHt4xtFPE8Gex--
