Received: from eggs.gnu.org ([2001:4830:134:3::10]:38677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQkyI-0008WH-K3
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:43:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQkyH-0007qZ-Pi
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:43:46 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-18-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e44d9ad-e3d3-ac50-19cf-a63c31f1bb3d@redhat.com>
Date: Thu, 29 Jun 2017 20:43:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170628120530.31251-18-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gVdrkAJI08odTMXW5JA0AshG0iCLAoFcu"
Subject: Re: [Qemu-devel] [PATCH v22 17/30] block: introduce persistent
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gVdrkAJI08odTMXW5JA0AshG0iCLAoFcu
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <9e44d9ad-e3d3-ac50-19cf-a63c31f1bb3d@redhat.com>
Subject: Re: [PATCH v22 17/30] block: introduce persistent dirty bitmaps
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
 <20170628120530.31251-18-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-18-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 07:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> New field BdrvDirtyBitmap.persistent means, that bitmap should be saved=

> by format driver in .bdrv_close and .bdrv_inactivate. No format driver
> supports it for now.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         | 29 +++++++++++++++++++++++++++++
>  block/qcow2-bitmap.c         |  1 +
>  include/block/dirty-bitmap.h |  4 ++++
>  3 files changed, 34 insertions(+)
>=20

> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -73,6 +73,8 @@ void bdrv_dirty_bitmap_deserialize_finish(BdrvDirtyBi=
tmap *bitmap);
> =20
>  void bdrv_dirty_bitmap_set_readonly(BdrvDirtyBitmap *bitmap, bool valu=
e);
>  void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool auto=
load);
> +void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
> +                                                bool persistent);
> =20

Indentation is off.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gVdrkAJI08odTMXW5JA0AshG0iCLAoFcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVazBAAoJEKeha0olJ0NqgFcH/Ar5p8bJgyTH9Nq1WK9fPIYW
raJGaOeTW2DdNHqTSpYkmVg3qZ2bDgmTNIA8I7u1QsEN4Qg73P6wIlGrYY4AvQkH
h8u/+Q6JSxgZTmozbONp4GbAr2SQJk0D4VbCBbD8D4RAumD4soKC6zOK/OsLZ2zC
DDBF4neasPJJDli0h9UPFQali32Qxbqahh3M4QbPCELF6L5LL1mhI/RvBfMCxexE
rL+Wv870xf7Q0vXc6DPi6rMih4TVzINm1POjkSHzxXV3MZpxzc/oiCaany4l4gbn
unHh0dYeMpPr0/caqM2JEjLUUqNQg1OxKaAmUakaQyoqXUpv0NMIaAZWM4Xauno=
=u529
-----END PGP SIGNATURE-----

--gVdrkAJI08odTMXW5JA0AshG0iCLAoFcu--
