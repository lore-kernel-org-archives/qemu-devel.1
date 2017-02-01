Received: from eggs.gnu.org ([2001:4830:134:3::10]:48091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ3Pc-0002d7-Dl
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:30:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ3Pb-0007vD-Nm
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:30:00 -0500
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-7-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <26bb2b75-d74b-c864-4cc7-f2768d0df1eb@redhat.com>
Date: Wed, 1 Feb 2017 23:29:50 +0100
MIME-Version: 1.0
In-Reply-To: <1479837270-79005-7-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9hWV0h6gwhkoIgltflixV2OosQ9rO3g8x"
Subject: Re: [Qemu-devel] [PATCH 06/17] block: add
 bdrv_dirty_bitmap_enable_successor()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9hWV0h6gwhkoIgltflixV2OosQ9rO3g8x
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com,
 quintela@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org,
 dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com
Message-ID: <26bb2b75-d74b-c864-4cc7-f2768d0df1eb@redhat.com>
Subject: Re: [PATCH 06/17] block: add bdrv_dirty_bitmap_enable_successor()
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
 <1479837270-79005-7-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479837270-79005-7-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:54, Vladimir Sementsov-Ogievskiy wrote:
> Enabling bitmap successor is necessary to enable successors of bitmaps
> being migrated before target vm start.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         | 5 +++++
>  include/block/dirty-bitmap.h | 1 +
>  2 files changed, 6 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--9hWV0h6gwhkoIgltflixV2OosQ9rO3g8x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSYV4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AEU0IAIw8aeGcnf/botknAv1pLBEmSboolz9u
0q8DuadQwUuZg1CJ+19FeI4CgidzU4Hn5pvGYoHKSefYN7PKdYX6d8wVYHhCkYyX
rZqaOOI8v1byRgxdPXQ458FObDhtAlIALabxKRfNx4SmsfaavUdGl9tED9p7JR5m
805vEqsoE5Bcnuroa7mbZZ/+6ccwdapnmNIIIBSderJzkS8lrBbT+bP7OkjckLgO
yoF6J72pxkeWBb4zz98PjIxXdbPorF93nA/+xJI2GIYbLSZTsWmjLmt9koeHykM5
X9EH5puzB8O/WcBVFdspqSJO4PSa/AGaBOubTsmw5Yj/Lzy3h4IHYlc=
=cz/q
-----END PGP SIGNATURE-----

--9hWV0h6gwhkoIgltflixV2OosQ9rO3g8x--
