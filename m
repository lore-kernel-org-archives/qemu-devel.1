Received: from eggs.gnu.org ([2001:4830:134:3::10]:50444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4CCe-0005sS-1B
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4CCd-0008LP-49
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:09:19 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-8-eblake@redhat.com>
	<99e512ad-d73a-09dd-ee68-ee57dc4581af@redhat.com>
	<03c4ac54-99fd-4316-1867-8d16e0703605@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ed4433d0-debc-5df1-0b88-d3cafac6056e@redhat.com>
Date: Fri, 28 Apr 2017 22:09:10 +0200
MIME-Version: 1.0
In-Reply-To: <03c4ac54-99fd-4316-1867-8d16e0703605@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Niq2Q8xtwwIXtBI5eOwpEF6pOJFejh12b"
Subject: Re: [Qemu-devel] [PATCH v10 07/17] qemu-io: Switch 'alloc' command
 to byte-based length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Niq2Q8xtwwIXtBI5eOwpEF6pOJFejh12b
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <ed4433d0-debc-5df1-0b88-d3cafac6056e@redhat.com>
Subject: Re: [PATCH v10 07/17] qemu-io: Switch 'alloc' command to byte-based
 length
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-8-eblake@redhat.com>
 <99e512ad-d73a-09dd-ee68-ee57dc4581af@redhat.com>
 <03c4ac54-99fd-4316-1867-8d16e0703605@redhat.com>
In-Reply-To: <03c4ac54-99fd-4316-1867-8d16e0703605@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.04.2017 21:59, Eric Blake wrote:
> On 04/28/2017 02:46 PM, Max Reitz wrote:
>> On 27.04.2017 03:46, Eric Blake wrote:
>>> For the 'alloc' command, accepting an offset in bytes but a length
>>> in sectors, and reporting output in sectors, is confusing.  Do
>>> everything in bytes, and adjust the expected output accordingly.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>
>=20
>>>      }
>>> +    if (!QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE)) {
>>> +        printf("bytes %" PRId64 " is not sector aligned\n",
>>
>> This isn't real English. :-)
>=20
> But, it's just copy-and-paste from the other instances you just reviewe=
d
> in 6/17!  [Translation - if I change this one, I also get to redo that =
one]

No, those are "offset" and "count" -- all singular. "bytes" is plural. ;-=
)

>=20
> Which of these various alternatives (if any) looks better:
>=20
> bytes=3D511 is not sector-aligned
> 511 is not a sector-aligned value for 'bytes'
> requested 'bytes' of 511 is not sector-aligned
> alignment error: 511 bytes is not sector-aligned> 'bytes' must be secto=
r-aligned: 511
> your clever entry here...

How about "byte count" instead of "bytes" or "bytes value", if really
want to have the exact spelling in there?

For your entries above: (1) and (2) work for me (I like (2) a bit
better), (3) doesn't sound like real English either, and it should be
s/is/are/ in (4) (but it still sounds off with that change). (5) I
mostly dislike because I dislike error message of the form "This should
be X: $foo", I like "$foo is not X" better.

>> With that fixed (somehow, you know better than me how to):
>=20
> Re-reading my various alternatives, I do think that /sector
> aligned/sector-aligned/ helps no matter what; and that the remaining
> trick is to use quoting or '=3D' or some other lexical trick to make it=

> obvious that 'bytes' is a parameter name whose value 511 is invalid,
> rather than part of the actual error of a value that is not properly
> aligned.

First of all, I think the user is clever enough to figure out that a
description like "byte count" refers to the "bytes" parameter. ;-)

Secondly, this is even more true because this is a debugging tool so we
don't have to worry too much about... Let's say inexperienced users.

Max


--Niq2Q8xtwwIXtBI5eOwpEF6pOJFejh12b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDoWYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AjLcIAKBZ4bsa5wymG4g+OVJrfMttjUmmyoZv
aAkiNm8o+7YOixL2BkYyHgi2M7hWOjgUxPgAhdFi17RcqvoGrQcWFirkj0lGIpzZ
5KjCn2pxAk/ZlGWAwfVhe83qaqDdfvw/Ol39EUo9JDnJWdUbbCP3jJAJJqO2syTN
KmdaszId0pMd8dXTFVyl0j2P3cnX8yGDtVT4hWZxqCUGeWq/3ETmSdtnOsev2PB8
mO45TuOcv47GeVZ0ZRMPkayZY5m8fzsxXcvC+tDESog5R4YvbWY26Uav4enR9boe
A0a/PsXOVi6pilzvsgHSfZM3mKMUIwc5/MBMIOOhyQb2l/IZvSZeC3I=
=XMxs
-----END PGP SIGNATURE-----

--Niq2Q8xtwwIXtBI5eOwpEF6pOJFejh12b--
