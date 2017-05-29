Received: from eggs.gnu.org ([2001:4830:134:3::10]:36252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFNd7-0005gf-EG
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFNd6-0001f4-PK
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:34:53 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-13-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <38a30b72-850a-9c78-f82c-c3c247836e8b@redhat.com>
Date: Mon, 29 May 2017 18:34:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170503122539.282182-13-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5sdOSeNG653bFkgfMgrlpI93PpBdakTqr"
Subject: Re: [Qemu-devel] [PATCH 12/25] block: bdrv_close: release bitmaps
 after drv->bdrv_close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5sdOSeNG653bFkgfMgrlpI93PpBdakTqr
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <38a30b72-850a-9c78-f82c-c3c247836e8b@redhat.com>
Subject: Re: [PATCH 12/25] block: bdrv_close: release bitmaps after
 drv->bdrv_close
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-13-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-13-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
> Release bitmaps after 'if (bs->drv) { ... }' block. This will allow
> format driver to save persistent bitmaps, which will appear in followin=
g
> commits.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--5sdOSeNG653bFkgfMgrlpI93PpBdakTqr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLE2dEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQLCi
B/9D/QL2FeGkBu1l91IBuK1iP4tmT+BaylBZ0O4i/nxltKJ+9v2ltg1UzKc9gsQP
oDuR19/KVeUW5TOAygwoKUUnIque4kgnPJRwjK7t9N8/qtoq4PWlPGPhkMRP79J+
Y14yVtZe2gcOBwGVncJW8tN0XgUy3fwoAgiYtGqEULh6Rek08eEHPFilDgRHL4uW
VB4w2rt/xiprLxxuZRKpZLSXnXfqM7Gm3VK31rTEO6IES0zmnZgazGEiCFFDsLkf
TOEntIK3hd8KyEHpewa92pOp7QKqvtY21+3jIhGIhVNzG0XJ20uv+2Zh5sjblOmq
4yArbgG5A2bfdBhKxfBX31Rw
=OUhd
-----END PGP SIGNATURE-----

--5sdOSeNG653bFkgfMgrlpI93PpBdakTqr--
