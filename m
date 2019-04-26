Received: from eggs.gnu.org ([209.51.188.92]:53289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK4uP-0000Pc-1u
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK4uN-0005K9-Kn
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:45:12 -0400
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
	<20190415144948.78568-2-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d5c453df-d732-b9af-4235-8cd33f61b4cb@redhat.com>
Date: Fri, 26 Apr 2019 19:44:49 +0200
MIME-Version: 1.0
In-Reply-To: <20190415144948.78568-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xjfVd2zw1pQA1UdEOSaDzbIBTjSJ2DfFi"
Subject: Re: [Qemu-devel] [PATCH v6 1/5] block/backup: simplify
 backup_incremental_init_copy_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xjfVd2zw1pQA1UdEOSaDzbIBTjSJ2DfFi
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <d5c453df-d732-b9af-4235-8cd33f61b4cb@redhat.com>
Subject: Re: [PATCH v6 1/5] block/backup: simplify
 backup_incremental_init_copy_bitmap
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
 <20190415144948.78568-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190415144948.78568-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.04.19 16:49, Vladimir Sementsov-Ogievskiy wrote:
> Simplify backup_incremental_init_copy_bitmap using the function
> bdrv_dirty_bitmap_next_dirty_area.
>=20
> Note: move to job->len instead of bitmap size: it should not matter but=

> less code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 40 ++++++++++++----------------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--xjfVd2zw1pQA1UdEOSaDzbIBTjSJ2DfFi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzDQ5EACgkQ9AfbAGHV
z0ANKgf/VbFbdBQY/7lZISJaoDaEMPotmQfJNXknXTmwN4pvqY5bTvMIvT7uvTcl
gQeqiJ0wbXLyfGKvNNqJ8Sev/hjTTYXtMbQOuyxmiTuGbe2BKsYZ1jeAEtx4eZZd
rjYsDdm4gPaQwADuOtrlDKlOMZeMV5hwk7DnUzRcT1Hpy+YYfpse7stkhtqoNT2j
DkVAq7HyThGaLgKwI+abfGF/BSS/ld90Qd5TAJ5A9wUgums9MRIMfL/siYYVYhoo
nbIn5ahCfi/2CH6SJUrWIiSZSYLMwSTqJcDcD38dQ/SNbUHiEBO0J6zp30+UrEx8
1eD/Eu7g6RMoQSn2b42VWZVquejXkg==
=iRGB
-----END PGP SIGNATURE-----

--xjfVd2zw1pQA1UdEOSaDzbIBTjSJ2DfFi--
