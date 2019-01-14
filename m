Received: from eggs.gnu.org ([209.51.188.92]:36072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj23n-0000Jo-Li
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gj23l-000155-Gt
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:13:47 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-2-vsementsov@virtuozzo.com>
	<cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
Message-ID: <49d23317-61f9-4029-5f78-58fcfa9d27a5@redhat.com>
Date: Mon, 14 Jan 2019 14:13:09 +0100
MIME-Version: 1.0
In-Reply-To: <cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c8ag9T7fNgA50M2XuCr90WxKCYvmFRGjO"
Subject: Re: [Qemu-devel] [PATCH v5 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c8ag9T7fNgA50M2XuCr90WxKCYvmFRGjO
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com, jsnow@redhat.com
Message-ID: <49d23317-61f9-4029-5f78-58fcfa9d27a5@redhat.com>
Subject: Re: [PATCH v5 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-2-vsementsov@virtuozzo.com>
 <cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
In-Reply-To: <cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.01.19 14:10, Max Reitz wrote:
> On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
>> Simplify backup_incremental_init_copy_bitmap using the function
>> bdrv_dirty_bitmap_next_dirty_area.
>>
>> Note: move to job->len instead of bitmap size: it should not matter bu=
t
>> less code.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  block/backup.c | 40 ++++++++++++----------------------------
>>  1 file changed, 12 insertions(+), 28 deletions(-)
>=20
> Overall: What is this function even supposed to do?  To me, it looks
> like it marks all areas in job->copy_bitmap dirty that are dirty in
> job->sync_bitmap.
>=20
> If so, wouldn't just replacing this by hbitmap_merge() simplify things
> further?

Ah, no, because they would need to have the same granularity...

Max


--c8ag9T7fNgA50M2XuCr90WxKCYvmFRGjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw8iuUACgkQ9AfbAGHV
z0B+sQgAvSefw78TqOx/C0loJou5I5gMZ1krFeuRiO9/6TUt2E10M6TlQo65QRL4
8kZSOPE0dv9vgSWioll8NE+Rd+xUz/Pwgc0ZshLXrRhEckzk7RB/FbGa843w1Yk0
1fMETAQ+Qf38LBUHvD/7a0byUVktAyovoJus7MYGSi1E2KR536FDbjLUOkvuR9Fu
1Ti/K7DXawVJqonJB3feJjjRBo6QPvUbVD6PKiRgJ/P2H+InWDzthWLU3XijFWUK
uVArbO/EXphXB156LRd1yj0qeH4pmth/zTA6kb1lWvgiW69UTw+RqYsMOX4zYMIo
W+HWcbSCXhS31t56/uzCJ424swHyNg==
=SRQz
-----END PGP SIGNATURE-----

--c8ag9T7fNgA50M2XuCr90WxKCYvmFRGjO--
