Received: from eggs.gnu.org ([2001:4830:134:3::10]:53495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXbM9-0007qs-Do
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 17:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXbM8-0001xH-25
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 17:20:25 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-10-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1d513ca9-a005-4870-7819-981a121e1939@redhat.com>
Date: Sat, 28 Jan 2017 23:20:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170123121036.4823-10-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FHAnbpabkJPdS3BQtcqAuTAaMCx1moSv0"
Subject: Re: [Qemu-devel] [PATCH 09/24] qcow2: add
 .bdrv_load_autoloading_dirty_bitmaps
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
--FHAnbpabkJPdS3BQtcqAuTAaMCx1moSv0
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <1d513ca9-a005-4870-7819-981a121e1939@redhat.com>
Subject: Re: [PATCH 09/24] qcow2: add .bdrv_load_autoloading_dirty_bitmaps
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
> Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. They=

> are loaded when the image is opened and become BdrvDirtyBitmaps for the=

> corresponding drive.
>=20
> Extra data in bitmaps is not supported for now.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/Makefile.objs  |   2 +-
>  block/qcow2-bitmap.c | 712 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c        |   2 +
>  block/qcow2.h        |   3 +
>  4 files changed, 718 insertions(+), 1 deletion(-)
>  create mode 100644 block/qcow2-bitmap.c

[...]

> new file mode 100644
> index 0000000000..758622dcfc
> --- /dev/null
> +++ b/block/qcow2-bitmap.c

[...]

> +
> +/*
> + * Bitmap List end
> + */
> +
> +static int update_ext_header_and_dir_in_place(BlockDriverState *bs,
> +                                              Qcow2BitmapList *bm_list=
)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +
> +    if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS) ||
> +        bm_list =3D=3D NULL || QSIMPLEQ_EMPTY(bm_list) ||
> +        bitmap_list_count(bm_list) !=3D s->nb_bitmaps)
> +    {
> +        return -EINVAL;
> +    }
> +
> +    s->autoclear_features &=3D ~(uint64_t)QCOW2_AUTOCLEAR_BITMAPS;
> +    ret =3D update_header_sync(bs);

This function is defined only in patch 13, until then the code won't
compile; the definition should be moved into this patch.

Max


--FHAnbpabkJPdS3BQtcqAuTAaMCx1moSv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliNGRsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ANG4IALnu0AMLEgEUUG30m3PjqjeBYdjYF8Lu
JBLrtHTM60WyoUXkUaeCTGdfQ9GFlaqZAmyPhabXnUs9J9yLPLulNHAR5LmwaFZi
M+rCqKYoZXgT8jbKvaoBKgLsFYtO8f0qa+sJVBm3aqSw9ntD2FTwi0PK1ExTQRTH
xmi5zNHL/NgqnldU9gb3o1JIXeUR7ZZ4h/vPaL04LxMurl7kx5Zj3acYDBrWPplE
CBXPPTA9ibuNBYXLYyGcK937MegsEDC4bL7tTo0aih6+oLOGeNBqKJIxa7Z6hkky
9ulS+2yaVOMLREkrL28MyG1z0zOHeB+H/B96QhF+YzLFu0vHPNCHFyQ=
=d10m
-----END PGP SIGNATURE-----

--FHAnbpabkJPdS3BQtcqAuTAaMCx1moSv0--
