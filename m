Received: from eggs.gnu.org ([2001:4830:134:3::10]:52756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fRlch-0001xx-54
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 17:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fRlcg-00007v-7p
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 17:42:11 -0400
References: <20180608101225.2575-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <45aa42eb-dc17-18d7-5fa5-3f1d56b989ed@redhat.com>
Date: Sat, 9 Jun 2018 23:42:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180608101225.2575-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h3OPU6DwUYcaobxmkGfeFGLwWEm30A9Rq"
Subject: Re: [Qemu-devel] [PATCH] block/qcow2-bitmap: fix
 free_bitmap_clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h3OPU6DwUYcaobxmkGfeFGLwWEm30A9Rq
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com
Message-ID: <45aa42eb-dc17-18d7-5fa5-3f1d56b989ed@redhat.com>
Subject: Re: [PATCH] block/qcow2-bitmap: fix free_bitmap_clusters
References: <20180608101225.2575-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180608101225.2575-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-08 12:12, Vladimir Sementsov-Ogievskiy wrote:
> This assert may fail, because bitmap_table is not initialized. Just
> drop it, as it's obvious, that bitmap_table_load sets bitmap_table
> parameter only when returning zero.
>=20
> Reported-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--h3OPU6DwUYcaobxmkGfeFGLwWEm30A9Rq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlscSaoACgkQ9AfbAGHV
z0B9ZQgAnTOnt7TLXmbA9/z0xvVCbpDKqzkYUCGQFyoQ6U/T6M39OcSeMgTpKrBC
j05JR+HJj/tSKSPhPnmIPZmXpis0K5sMKdvBCe2Sju+erzTCJ2dIPwsGnjBNT+2K
mCdKUbiiCwZc+ZzGsyl/hgiSnVjqRaC9i5wFKiBXCONAm+GQ4RUDldrEBEOhatsv
3mF/S36iMwUxv5BihK31p0xJ2TWryxhx80bqm2ZRdXhlapQdXDEmMMZW3Jwnnkez
86svkNA5aqQANydkA1wVi0bFwsTLHJFBo8yRvSPAkyWfdg0G3oEaq0V8xaMxiVDF
4ckAQLnE3ONJuni4xUjlDjFEIan8YQ==
=lUIk
-----END PGP SIGNATURE-----

--h3OPU6DwUYcaobxmkGfeFGLwWEm30A9Rq--
