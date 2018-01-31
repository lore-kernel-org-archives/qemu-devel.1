Received: from eggs.gnu.org ([2001:4830:134:3::10]:44289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egwNS-0006DM-Jm
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egwNR-0000g4-Ci
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 12:40:54 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-9-git-send-email-anton.nefedov@virtuozzo.com>
	<7b84e8fe-2141-5609-3f86-1890fc314b6d@redhat.com>
	<2e58f0a9-7db4-b562-e1d0-b8c712a67b21@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4b7846c3-bec4-b1a0-50e3-58aa337028ac@redhat.com>
Date: Wed, 31 Jan 2018 18:40:43 +0100
MIME-Version: 1.0
In-Reply-To: <2e58f0a9-7db4-b562-e1d0-b8c712a67b21@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Zzylw1xc430oqQ4zK6kBQplDcKhjdXk4O"
Subject: Re: [Qemu-devel] [PATCH v7 8/9] qcow2: skip writing zero buffers to
 empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zzylw1xc430oqQ4zK6kBQplDcKhjdXk4O
From: Max Reitz <mreitz@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com, berto@igalia.com
Message-ID: <4b7846c3-bec4-b1a0-50e3-58aa337028ac@redhat.com>
Subject: Re: [PATCH v7 8/9] qcow2: skip writing zero buffers to empty COW
 areas
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1516297747-107232-9-git-send-email-anton.nefedov@virtuozzo.com>
 <7b84e8fe-2141-5609-3f86-1890fc314b6d@redhat.com>
 <2e58f0a9-7db4-b562-e1d0-b8c712a67b21@virtuozzo.com>
In-Reply-To: <2e58f0a9-7db4-b562-e1d0-b8c712a67b21@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-30 15:23, Anton Nefedov wrote:
>=20
>=20
> On 29/1/2018 11:28 PM, Max Reitz wrote:
>> On 2018-01-18 18:49, Anton Nefedov wrote:
>>> If COW areas of the newly allocated clusters are zeroes on the
>>> backing image,
>>> efficient bdrv_write_zeroes(flags=3DBDRV_REQ_ALLOCATE) can be used on=

>>> the whole
>>> cluster instead of writing explicit zero buffers later in perform_cow=
().
>>>
>>> iotest 060:
>>> write to the discarded cluster does not trigger COW anymore.
>>> Use a backing image instead.
>>>
>>> iotest 066:
>>> cluster-alignment areas that were not really COWed are now detected
>>> as zeroes, hence the initial write has to be exactly the same size fo=
r
>>> the maps to match
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> ---
>>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 4 ++-
>>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++++
>>> =C2=A0 block/qcow2-cluster.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
+-
>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 66
>>> ++++++++++++++++++++++++++++++++++++++++++++--
>>> =C2=A0 block/trace-events=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
>>> =C2=A0 tests/qemu-iotests/060=C2=A0=C2=A0=C2=A0=C2=A0 | 26 ++++++++++=
+-------
>>> =C2=A0 tests/qemu-iotests/060.out |=C2=A0 5 +++-
>>> =C2=A0 tests/qemu-iotests/066=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 tests/qemu-iotests/066.out |=C2=A0 4 +--
>>> =C2=A0 9 files changed, 98 insertions(+), 18 deletions(-)
>>
>> [...]
>>
>>> @@ -1875,6 +1880,52 @@ static bool is_zero(BlockDriverState *bs,
>>> int64_t offset, int64_t bytes)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return res >=3D 0 && (res & BDRV_BLOCK=
_ZERO) && nr =3D=3D bytes;
>>> =C2=A0 }
>>> =C2=A0 +static bool is_zero_cow(BlockDriverState *bs, QCowL2Meta *m)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 return is_zero(bs, m->offset + m->cow_start.offse=
t,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m->cow_start.nb_bytes) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_zero=
(bs, m->offset + m->cow_end.offset,
>>> m->cow_end.nb_bytes);
>>> +}
>>> +
>>> +static int handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2me=
ta)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>>> +=C2=A0=C2=A0=C2=A0 QCowL2Meta *m;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (m =3D l2meta; m !=3D NULL; m =3D m->next) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!m->cow_start.nb_byte=
s && !m->cow_end.nb_bytes) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bs->encrypted) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> Not sure if the compiler optimizes this anyway, but I'd pull this out =
of
>> the loop.
>>
>=20
> An imprint of the following patches (which were dropped from this
> series) - preallocation ahead of image EOF, which takes action
> regardless of image encryption.
>=20
> But I'll leave the check outside the loop until it's needed
> there.
>=20
>=20
>> Maybe you could put all of the conditions under which this function ca=
n
>> actually do something at its beginning: That is, we can't do anything =
if
>> the BDS is encrypted or if bs->file does not support BDRV_REQ_ALLOCATE=

>> (and then you just call this function unconditionally in
>> qcow2_co_pwritev()).
>>
>=20
> Done.
>=20
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!is_zero_cow(bs, m)) =
{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> Is this really efficient?=C2=A0 I remember someone complaining about
>> bdrv_co_block_status() being kind of slow on some filesystems, so
>> there'd be a tradeoff depending on how it compares to just reading up =
to
>> two clusters from the backing file -- especially considering that the =
OS
>> can query the same information just as quickly, and thus the only
>> overhead the read should have is a memset() (assuming the OS is clever=
).
>>
>> So basically my question is whether it would be better to just skip th=
is
>> if we have any backing file at all and only do this optimization if
>> there is none.
>>
>=20
> So what we trade between is
> (read+write) vs (lseek+fallocate or lseek+read+write).
>=20
> Indeed if it comes to lseek the profit is smaller, and we're probably
> unlikely to find a hole anyway.
>=20
> Maybe it's good enough to cover these cases:
> =C2=A01. no backing
> =C2=A02. beyond bdrv_getlength() in backing
> =C2=A03. unallocated in backing qcow2 (covers 'beyond bdrv_getlength()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 in backing->file')
>=20
> 1 & 2 are easy to check;

Not sure how useful 2 is, though.  (I don't know.  I always hear about
people wanting to optimize for such a case where a backing file is
shorter than the overlay, but I can't imagine a real use case for that.)

> 3: if that's not too hacky maybe we can do the bdrv_is_allocated() chec=
k
> for qcow2 exclusively and if there is raw (or any other format) backing=

> image - do the COW

Yes, well, it seems useful in principle...  But it would require general
block layer work indeed.  Maybe a new flag for bdrv_block_status*() that
says only to look into the format layer?

Max


--Zzylw1xc430oqQ4zK6kBQplDcKhjdXk4O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpx/5sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+1YIALA/Dj9TVNEDxMsc5J3Pf1mHLJC5y0oh
ShBxImn70QiXqjhs4hXBO5wE3PeIxLKhksP9WC6T4l6DH0szhRlQ2wIAd9pxbO2N
YhPTcp5jfNo8VCOmxXr7EHd7Kf6FNyJIvK12dGLoHJq4wQBFCVsBnns9E3Lb1G0i
jikpN4e/BiPK66yVJtYkioXBu7OdM1ZUeTaRjTqgioDHjvL7H27DVfYb5RCHESbF
iOOQA8A5XZ3CkEr5u240+S8nkivJ+uMiRHwGGuXLdetRSG03Yy3Jad5oLE67JlBq
Z9Dz9/f5FLKFemxjK3PvpA25/G3KdrrHOqkPLxXwiojraRkVssnQBWE=
=Yd5p
-----END PGP SIGNATURE-----

--Zzylw1xc430oqQ4zK6kBQplDcKhjdXk4O--
