Received: from eggs.gnu.org ([2001:4830:134:3::10]:42848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce2l9-0003T7-Rl
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ce2l8-0005GE-Qx
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:48:51 -0500
References: <20170212014724.10618-1-mreitz@redhat.com>
	<w51lgtazdqs.fsf@maestria.local.igalia.com>
	<8d536684-8a07-7c34-16ca-be234685ab2a@redhat.com>
	<w51k28tumiv.fsf@maestria.local.igalia.com>
	<7fcba84d-4cd8-b34d-ef3e-4fbfa46d59a9@redhat.com>
	<20170215164451.GH4935@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4756605d-5cd3-20be-d7fc-2909bae8a268@redhat.com>
Date: Wed, 15 Feb 2017 17:48:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170215164451.GH4935@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hwT6nox9bGeSS4J0IHhWaDsfaUXGBIwa8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Swap request limit
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hwT6nox9bGeSS4J0IHhWaDsfaUXGBIwa8
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <4756605d-5cd3-20be-d7fc-2909bae8a268@redhat.com>
Subject: Re: [Qemu-block] [PATCH] block: Swap request limit definitions
References: <20170212014724.10618-1-mreitz@redhat.com>
 <w51lgtazdqs.fsf@maestria.local.igalia.com>
 <8d536684-8a07-7c34-16ca-be234685ab2a@redhat.com>
 <w51k28tumiv.fsf@maestria.local.igalia.com>
 <7fcba84d-4cd8-b34d-ef3e-4fbfa46d59a9@redhat.com>
 <20170215164451.GH4935@noname.redhat.com>
In-Reply-To: <20170215164451.GH4935@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 15.02.2017 17:44, Kevin Wolf wrote:
> Am 15.02.2017 um 14:42 hat Max Reitz geschrieben:
>> On 14.02.2017 10:52, Alberto Garcia wrote:
>>> On Mon 13 Feb 2017 06:13:38 PM CET, Max Reitz wrote:
>>>
>>>>>> -#define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS=
, \
>>>>>> -                                     INT_MAX >> BDRV_SECTOR_BITS)=

>>>>>> -#define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_=
SECTOR_BITS)
>>>>>> +#define BDRV_REQUEST_MAX_BYTES      MIN(SIZE_MAX, INT_MAX)
>>>>>> +#define BDRV_REQUEST_MAX_SECTORS    (BDRV_REQUEST_MAX_BYTES >> BD=
RV_SECTOR_BITS)
>>>>>
>>>>> I'm just pointing it out because I don't know if this can cause
>>>>> problems, but this patch would make BDRV_REQUEST_MAX_BYTES not a
>>>>> multiple of the sector size (INT_MAX is actually a prime number).
>>>>
>>>> Very good point. I don't think this could be an issue, though. For o=
ne
>>>> thing, the use of BDRV_REQUEST_MAX_BYTES is very limited.
>>>
>>> Ok, but then I wonder what's the benefit of increasing
>>> BDRV_REQUEST_MAX_BYTES.
>>
>> The benefit is that the definition looks cleaner.
>=20
> Whatever way we want to write it, I think MAX_BYTES =3D MAX_SECTORS * 5=
12
> should be a given. Everything else is bound to confuse people and
> introduce bugs sooner or later.

Probably only sooner and not later, considering we are switching to byte
granularity overall anyway. And if something confuses people, I'd argue
it's the fact that we still have sector granularity all over the place
and not that your requests can be a bit bigger if you submit them in
bytes than if you submit them in sectors.

Anyway, if MAX_BYTES should be a multiple of the sector size, then I
can't think of a much better way to write this than what we currently
have and this patch is unneeded.

Max


--hwT6nox9bGeSS4J0IHhWaDsfaUXGBIwa8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlikhmkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABZEIAJP6q5I/CtRIjXjqtw0Xd7XYyDIvZ+KM
ZkwZgPreSHwPk1s1SEdh6+dENzX5NRYQ3Aw6oLGfSnMfXdrLUPQgqcdraldfiDmn
L4xFsi7IBBYEmRuE6Kgma54Dv5EXkafj4+CJAix+YQwoDyL1t8ibC4E6zmJWo5k4
C8kwflFEyY7jvhGS5/6uY5GGOfFAjDiAXW7oCwz0GV5yOWbDA8Kko3beWZN7Wn87
NHDa9WZRCIbkpuctWdhquRjtDAAhKpq1N+v0qH2NRlSYsgDUO1NoaHH4aMYz0Ok5
IAS+UPWnRKGEW2E1Pp7scGTUmGCKLD2wSRePtxBPwgEJjy0kwTzFWkw=
=3Uan
-----END PGP SIGNATURE-----

--hwT6nox9bGeSS4J0IHhWaDsfaUXGBIwa8--
