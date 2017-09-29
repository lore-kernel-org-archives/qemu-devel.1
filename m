Received: from eggs.gnu.org ([2001:4830:134:3::10]:55602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxtQR-0007YF-MJ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxtQQ-0005b3-Qg
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:25:47 -0400
References: <20170928120300.58164-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <115951b8-99da-6a0b-efce-376b247d3f8a@redhat.com>
Date: Fri, 29 Sep 2017 13:25:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170928120300.58164-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DBpJdxvk1XJoTqtnCO772GAoqBkH85l6t"
Subject: Re: [Qemu-devel] [PATCH] block/mirror: check backing in
 bdrv_mirror_top_refresh_filename
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, eblake@redhat.com, qemu-stable@nongnu.org
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DBpJdxvk1XJoTqtnCO772GAoqBkH85l6t
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, eblake@redhat.com,
 qemu-stable@nongnu.org
Message-ID: <115951b8-99da-6a0b-efce-376b247d3f8a@redhat.com>
Subject: Re: [PATCH] block/mirror: check backing in
 bdrv_mirror_top_refresh_filename
References: <20170928120300.58164-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170928120300.58164-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-28 14:03, Vladimir Sementsov-Ogievskiy wrote:
> Backing may be zero after failed bdrv_attach_child in
> bdrv_set_backing_hd, which leads to SIGSEGV.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--DBpJdxvk1XJoTqtnCO772GAoqBkH85l6t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnOLa8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A8WEIAKgw2Uzge5zm57ZEY71z1IPwUUydeOgN
raSNzv83viXPZ2k6XAr32hmVTUdrjFCke/lTgZXv6q+zD+RrtuNjqvYOLlzJbikG
EH1CRSSc/pArz0jQWbp+1zx2QbvgERPP2AbsexadsXrrRnBfDCWwDyR2zEomLTyF
3ASIZfwd+49MB+V9yxhMfGMt60ZtmFucGo2q3uRPBGG095YfhgEEQS+5NAxV+2GC
IW7/3PzSHa1olmIf9rYoCPGck7w+TOC9w4rls2q37C8Llk++beh2pzvhewef1/1u
b+iQ0aYSlR7OH2/vyhtAmg/2tDyFvzGT2SbecFkPiJIJm4ANiAIOgjo=
=O4pI
-----END PGP SIGNATURE-----

--DBpJdxvk1XJoTqtnCO772GAoqBkH85l6t--
