Received: from eggs.gnu.org ([2001:4830:134:3::10]:48085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ3Pc-0002ct-1O
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ3Pb-0007v2-As
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:30:00 -0500
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
	<1479837270-79005-9-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <057d247b-febb-6938-4594-67e36a22aa61@redhat.com>
Date: Wed, 1 Feb 2017 23:29:46 +0100
MIME-Version: 1.0
In-Reply-To: <1479837270-79005-9-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="a4ishfdvIRaa6cD0QGGORDkgVWtMUdFKK"
Subject: Re: [Qemu-devel] [PATCH 08/17] block/dirty-bitmap: add
 bdrv_dirty_bitmap_release_successor
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
--a4ishfdvIRaa6cD0QGGORDkgVWtMUdFKK
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com,
 quintela@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org,
 dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com
Message-ID: <057d247b-febb-6938-4594-67e36a22aa61@redhat.com>
Subject: Re: [PATCH 08/17] block/dirty-bitmap: add
 bdrv_dirty_bitmap_release_successor
References: <1479837270-79005-1-git-send-email-vsementsov@virtuozzo.com>
 <1479837270-79005-9-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479837270-79005-9-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:54, Vladimir Sementsov-Ogievskiy wrote:
> To just release successor and unfreeze bitmap without any additional
> work.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  block/dirty-bitmap.c         | 10 ++++++++++
>  include/block/dirty-bitmap.h |  2 ++
>  2 files changed, 12 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--a4ishfdvIRaa6cD0QGGORDkgVWtMUdFKK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSYVoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AcqUH/0D/qIy4SxgXx6v7zkxw6il0Rslp8ZPk
rOlGexyHkiHKsH/TYTa0Fl71e5HkPXXuSqJB0Vq7nSkR2ZMJY6D3WkwrLWePK3NN
ZmQb5o9jG3tvOYFHKw9s9Ly2S+G+JStbg54OsDN63dPaFMddaU2lybi8cIuIvVEW
ZFpaY8yapC2OUkU4ncHftDjlnGD1SoxaiBzrwhxjDub3YUCV9dd7OECBrePVxXRz
0kUd5cJ9nkurq9Af4X3Ap0BPs+bGXRT5e4IDMG37UFohVogHcnPvxlbLG6dQGBIa
L6LR7QZhHhYIIyNOB9WnMVspwyvQdrj9pymgNk8X57m/8SHNzldi/10=
=VrP9
-----END PGP SIGNATURE-----

--a4ishfdvIRaa6cD0QGGORDkgVWtMUdFKK--
