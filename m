Received: from eggs.gnu.org ([2001:4830:134:3::10]:48658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cdzr9-0004ih-HD
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cdzr8-0001Hc-Rg
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 08:42:51 -0500
References: <20170212014724.10618-1-mreitz@redhat.com>
	<w51lgtazdqs.fsf@maestria.local.igalia.com>
	<8d536684-8a07-7c34-16ca-be234685ab2a@redhat.com>
	<w51k28tumiv.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7fcba84d-4cd8-b34d-ef3e-4fbfa46d59a9@redhat.com>
Date: Wed, 15 Feb 2017 14:42:40 +0100
MIME-Version: 1.0
In-Reply-To: <w51k28tumiv.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iQcEtCwC62QjFWo8ljeFM3USShTIUQj4Q"
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
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iQcEtCwC62QjFWo8ljeFM3USShTIUQj4Q
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <7fcba84d-4cd8-b34d-ef3e-4fbfa46d59a9@redhat.com>
Subject: Re: [Qemu-block] [PATCH] block: Swap request limit definitions
References: <20170212014724.10618-1-mreitz@redhat.com>
 <w51lgtazdqs.fsf@maestria.local.igalia.com>
 <8d536684-8a07-7c34-16ca-be234685ab2a@redhat.com>
 <w51k28tumiv.fsf@maestria.local.igalia.com>
In-Reply-To: <w51k28tumiv.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 14.02.2017 10:52, Alberto Garcia wrote:
> On Mon 13 Feb 2017 06:13:38 PM CET, Max Reitz wrote:
>=20
>>>> -#define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS, =
\
>>>> -                                     INT_MAX >> BDRV_SECTOR_BITS)
>>>> -#define BDRV_REQUEST_MAX_BYTES (BDRV_REQUEST_MAX_SECTORS << BDRV_SE=
CTOR_BITS)
>>>> +#define BDRV_REQUEST_MAX_BYTES      MIN(SIZE_MAX, INT_MAX)
>>>> +#define BDRV_REQUEST_MAX_SECTORS    (BDRV_REQUEST_MAX_BYTES >> BDRV=
_SECTOR_BITS)
>>>
>>> I'm just pointing it out because I don't know if this can cause
>>> problems, but this patch would make BDRV_REQUEST_MAX_BYTES not a
>>> multiple of the sector size (INT_MAX is actually a prime number).
>>
>> Very good point. I don't think this could be an issue, though. For one=

>> thing, the use of BDRV_REQUEST_MAX_BYTES is very limited.
>=20
> Ok, but then I wonder what's the benefit of increasing
> BDRV_REQUEST_MAX_BYTES.

The benefit is that the definition looks cleaner.

Max


--iQcEtCwC62QjFWo8ljeFM3USShTIUQj4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlikWtASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABT4H/A5Xd1fTK7IRIH1KHcdPgtZp5V6FutNA
73mzT0X6MTPhO/rXvrFpB2j9Qi80hxzVzr/VCiuupHs2cgfg91X4ZGT05QVfbhV7
I1YKSOVgaPiVbRbOg/NMiwogScKlXzBdfd1KqT9YaKJblYj5xHwr/e3TJLFFhiZS
ywxPM/EpaHvW742QzUw+/Yi/CYBP/6P2m9XJy7UvHE6m0sDgLb8JQR0zLMTC2pjH
s8Ny+Wkd12arELp0ZJafIuhoCuypJOZXJDF2JfeTWfi5oZLmma0IAsSGfLglfBOR
5OqFtelp1I0tRmYpNdcCHydFOIrJb7n4ldslillBZUAtYA5ksVNk4f8=
=6fiC
-----END PGP SIGNATURE-----

--iQcEtCwC62QjFWo8ljeFM3USShTIUQj4Q--
