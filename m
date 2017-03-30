Received: from eggs.gnu.org ([2001:4830:134:3::10]:40729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cthZZ-000130-9n
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 17:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cthZY-0000Ld-Dp
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 17:25:37 -0400
References: <20170308025428.1037-1-eblake@redhat.com>
	<20170308025428.1037-3-eblake@redhat.com>
	<f4cbc108-a91f-6d52-b46e-3c1332199779@redhat.com>
	<4de9047a-0c0f-3653-e470-ce1715816f49@redhat.com>
	<4b120de9-55fe-0527-8ed3-753dceea3b3e@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e845695c-fd1a-c614-f742-1213382e00fd@redhat.com>
Date: Thu, 30 Mar 2017 23:25:28 +0200
MIME-Version: 1.0
In-Reply-To: <4b120de9-55fe-0527-8ed3-753dceea3b3e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rEq0gmX70HH39w7HDEHlvPXVHaqk5Aqa6"
Subject: Re: [Qemu-devel] [PATCH v6 02/10] iotests: Improve image-clear
 tests on non-aligned image
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
--rEq0gmX70HH39w7HDEHlvPXVHaqk5Aqa6
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <e845695c-fd1a-c614-f742-1213382e00fd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 02/10] iotests: Improve image-clear tests
 on non-aligned image
References: <20170308025428.1037-1-eblake@redhat.com>
 <20170308025428.1037-3-eblake@redhat.com>
 <f4cbc108-a91f-6d52-b46e-3c1332199779@redhat.com>
 <4de9047a-0c0f-3653-e470-ce1715816f49@redhat.com>
 <4b120de9-55fe-0527-8ed3-753dceea3b3e@redhat.com>
In-Reply-To: <4b120de9-55fe-0527-8ed3-753dceea3b3e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.03.2017 20:39, Eric Blake wrote:
> On 03/29/2017 09:13 PM, Eric Blake wrote:
>> On 03/13/2017 05:00 PM, Max Reitz wrote:
>>> On 08.03.2017 03:54, Eric Blake wrote:
>>>> Tweak 097 and 176 to operate on an image that is not cluster-aligned=
,
>>>> to give further coverage of clearing out an entire image.
>>>>
>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>>
>>>> ---
>>>> v6: new patch
>>>> ---
>>>>  tests/qemu-iotests/097     |  7 ++++---
>>>>  tests/qemu-iotests/097.out | 24 ++++++++++++------------
>>>>  tests/qemu-iotests/176     |  7 ++++---
>>>>  tests/qemu-iotests/176.out | 24 ++++++++++++------------
>>>>  4 files changed, 32 insertions(+), 30 deletions(-)
>>>
>>> I don't have anything against this patch, but maybe it would be even
>>> more useful if it wrote some data to the final partial cluster (just =
an
>>> idea).
>>
>> And not a bad one.  Kevin said patch 1 and 2 are okay for freeze (if
>> wanted; but not essential if they miss it), so I'll post v7 soon.
>=20
> Urrgh. Doing this uncovered the fact that we have a latent bug: we STIL=
L
> leave the unaligned tail cluster allocated, when using the slow path; o=
r
> put another way, commit a3e1505 is an incomplete fix.
>=20
> Do I say "thanks" for your suggestion being the cause for me to find th=
e
> problem, or "no thanks" for it turning into more work? ;)

Just pretend you didn't see any problem. Whoops, you've already posted a
mail to the list, this will make it a bit awkward. ;-)

Max


--rEq0gmX70HH39w7HDEHlvPXVHaqk5Aqa6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljdd8gSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACekH/iSkbEqz+iJYadiBx7wIVAfW3RYN7NYm
kqi02XVHrQHiX1AhoWoLlJjoLr0b6DZoRyMsf5XVXbSRhTd+H90JoyOkr35k2Ga0
WxGJ4HT77cYf8jWJfx6F+f6/vXdb3Uf7/KhMPEBrhBqJo+ftmEFLzU9kPsQCUAc5
7l824KEcYvgxDTdUqk3Tn+RZ3j1yGaAADJXFU0UTUiHD3kpxSWMCMMWgizoVmNHV
QzpP8uNEMqjmCEYWepQfrOMJ2VfUWaBSi7NcV7aWDEjO41clOVFQwYBhf5Jd7fkn
Ph+61Xq05DbwWmbnP6KpDf9jwcm2sNypfe+do9vM8EzX4fTD2HGHX28=
=sWqF
-----END PGP SIGNATURE-----

--rEq0gmX70HH39w7HDEHlvPXVHaqk5Aqa6--
