Received: from eggs.gnu.org ([209.51.188.92]:52850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmIWR-0001yE-Kk
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gmIRS-0001fx-Fz
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:19:44 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-2-vsementsov@virtuozzo.com>
	<cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
	<5accce39-2c94-ca4e-5afc-2fec242836a8@virtuozzo.com>
	<29032c00-29cf-a8a4-d18e-fcaa7651636a@redhat.com>
	<9767ccf8-6a00-88b0-e28a-3b8602580c2e@virtuozzo.com>
	<352c85fb-fd1d-56e7-ace3-61553e8bbc94@redhat.com>
	<7edf764f-0eef-a47d-48f2-70501f2697a5@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d1251978-6677-c022-d6f1-353717600ea5@redhat.com>
Date: Wed, 23 Jan 2019 14:19:26 +0100
MIME-Version: 1.0
In-Reply-To: <7edf764f-0eef-a47d-48f2-70501f2697a5@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PctbajD6vvt68iTBFeQOTrCDKY3403cID"
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PctbajD6vvt68iTBFeQOTrCDKY3403cID
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>
Message-ID: <d1251978-6677-c022-d6f1-353717600ea5@redhat.com>
Subject: Re: [PATCH v5 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-2-vsementsov@virtuozzo.com>
 <cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
 <5accce39-2c94-ca4e-5afc-2fec242836a8@virtuozzo.com>
 <29032c00-29cf-a8a4-d18e-fcaa7651636a@redhat.com>
 <9767ccf8-6a00-88b0-e28a-3b8602580c2e@virtuozzo.com>
 <352c85fb-fd1d-56e7-ace3-61553e8bbc94@redhat.com>
 <7edf764f-0eef-a47d-48f2-70501f2697a5@virtuozzo.com>
In-Reply-To: <7edf764f-0eef-a47d-48f2-70501f2697a5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.19 09:20, Vladimir Sementsov-Ogievskiy wrote:
> 16.01.2019 16:05, Max Reitz wrote:
>> On 14.01.19 15:48, Vladimir Sementsov-Ogievskiy wrote:
>>> 14.01.2019 17:13, Max Reitz wrote:
>>>> On 14.01.19 15:01, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 14.01.2019 16:10, Max Reitz wrote:
>>>>>> On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> Simplify backup_incremental_init_copy_bitmap using the function
>>>>>>> bdrv_dirty_bitmap_next_dirty_area.
>>>>>>>
>>>>>>> Note: move to job->len instead of bitmap size: it should not matt=
er but
>>>>>>> less code.
>>>>>>>
>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo=
=2Ecom>
>>>>>>> ---
>>>>>>>     block/backup.c | 40 ++++++++++++----------------------------
>>>>>>>     1 file changed, 12 insertions(+), 28 deletions(-)
>>>>>>
>>>>>> Overall: What is this function even supposed to do?  To me, it loo=
ks
>>>>>> like it marks all areas in job->copy_bitmap dirty that are dirty i=
n
>>>>>> job->sync_bitmap.
>>>>>>
>>>>>> If so, wouldn't just replacing this by hbitmap_merge() simplify th=
ings
>>>>>> further?
>>>>>>
>>>>>>> diff --git a/block/backup.c b/block/backup.c
>>>>>>> index 435414e964..fbe7ce19e1 100644
>>>>>>> --- a/block/backup.c
>>>>>>> +++ b/block/backup.c
>>>>>>> @@ -406,43 +406,27 @@ static int coroutine_fn backup_run_incremen=
tal(BackupBlockJob *job)
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> +    while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
>>>>>>> +                                             &offset, &bytes))
>>>>>>> +    {
>>>>>>> +        uint64_t cluster =3D offset / job->cluster_size;
>>>>>>> +        uint64_t last_cluster =3D (offset + bytes) / job->cluste=
r_size;
>>>>>>>    =20
>>>>>>> -        next_cluster =3D DIV_ROUND_UP(offset, job->cluster_size)=
;
>>>>>>> -        hbitmap_set(job->copy_bitmap, cluster, next_cluster - cl=
uster);
>>>>>>> -        if (next_cluster >=3D end) {
>>>>>>> +        hbitmap_set(job->copy_bitmap, cluster, last_cluster - cl=
uster + 1);
>>>>>>
>>>>>> Why the +1?  Shouldn't the division for last_cluster round up inst=
ead?
>>>>>>
>>>>>>> +
>>>>>>> +        offset =3D (last_cluster + 1) * job->cluster_size;
>>>>>>
>>>>>> Same here.
>>>>>
>>>>> last cluster is not "end", but it's last dirty cluster. so number o=
f dirty clusters is last_cluster - cluster + 1, and next offset is calcul=
ated through +1 too.
>>>>>
>>>>> If I round up division result, I'll get last for most cases, but "e=
nd" (next after the last), for the case when offset % job->cluster_size =3D=
=3D 0, so, how to use it?
>>>>
>>>> Doesn't bdrv_dirty_bitmap_next_dirty_area() return a range [offset,
>>>> offset + bytes), i.e. where "offset + bytes" is the first clean offs=
et?
>>>
>>> oops, you are right. then I need
>>> uint64_t last_cluster =3D (offset + bytes - 1) / job->cluster_size;
>>
>> That, or you just use a rounding up division and rename it from
>> last_cluster to end_cluster or first_clean_cluster or something (and
>> subsequently drop the +1s).
>=20
> This will not work, as ((offset + bytes) / job->cluster_size) is not fi=
rst clean cluster
> or end cluster. It's a cluster, where is first clean bit located, but i=
t may have dirty
> bits too (or, may not).
>=20
> So, to rewrite based on end_cluster, it should be calculated as
>=20
> (offset + bytes - 1) / job->cluster_size + 1

That's why I asked "Shouldn't the division for last_cluster round up
instead?"

Max

> and, I'm going to do so, one "+1" instead of two, and, may be, a bit mo=
re understandable.
>=20



--PctbajD6vvt68iTBFeQOTrCDKY3403cID
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxIad4ACgkQ9AfbAGHV
z0CNigf8CyPYsSueAmoTu4onzOy3y/u4x++BZ6rGLXIvE1koTgs/auz0ypOr43/x
FGt6phrLkNTZNCzzu88yEdheReLrynZShW1AQdn9aDJVu2QJ88107iO9l8xlWozw
B6XWzO4q1hCbex3NNDFhQ1tcuOKdC3Y2wE6mZiU8c8m21EYD9QdrbrtFCO4k3cze
qgapS/wzgoageRlzoRvuCWzAN7eVL048JFpBBQAkBsq/O1wBxJVNnIwTo3q3kRzX
wbvpFePYQJBOXLeuhy3/zq33jCZl12rqdD614uot18rKyDE3vvToLnZVDE5So90p
/3QRTb+TRa3JqWo1QbFtrPzFC+7xCQ==
=G3wp
-----END PGP SIGNATURE-----

--PctbajD6vvt68iTBFeQOTrCDKY3403cID--
