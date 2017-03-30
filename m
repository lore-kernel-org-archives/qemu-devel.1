Received: from eggs.gnu.org ([2001:4830:134:3::10]:50214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctPak-0001s3-UF
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 22:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctPaj-000385-P3
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 22:13:38 -0400
References: <20170308025428.1037-1-eblake@redhat.com>
	<20170308025428.1037-3-eblake@redhat.com>
	<f4cbc108-a91f-6d52-b46e-3c1332199779@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4de9047a-0c0f-3653-e470-ce1715816f49@redhat.com>
Date: Wed, 29 Mar 2017 21:13:29 -0500
MIME-Version: 1.0
In-Reply-To: <f4cbc108-a91f-6d52-b46e-3c1332199779@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ljNP19M6mo7kvORvvkeO7FSDmQPhNpNne"
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
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ljNP19M6mo7kvORvvkeO7FSDmQPhNpNne
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <4de9047a-0c0f-3653-e470-ce1715816f49@redhat.com>
Subject: Re: [PATCH v6 02/10] iotests: Improve image-clear tests on
 non-aligned image
References: <20170308025428.1037-1-eblake@redhat.com>
 <20170308025428.1037-3-eblake@redhat.com>
 <f4cbc108-a91f-6d52-b46e-3c1332199779@redhat.com>
In-Reply-To: <f4cbc108-a91f-6d52-b46e-3c1332199779@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 05:00 PM, Max Reitz wrote:
> On 08.03.2017 03:54, Eric Blake wrote:
>> Tweak 097 and 176 to operate on an image that is not cluster-aligned,
>> to give further coverage of clearing out an entire image.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v6: new patch
>> ---
>>  tests/qemu-iotests/097     |  7 ++++---
>>  tests/qemu-iotests/097.out | 24 ++++++++++++------------
>>  tests/qemu-iotests/176     |  7 ++++---
>>  tests/qemu-iotests/176.out | 24 ++++++++++++------------
>>  4 files changed, 32 insertions(+), 30 deletions(-)
>=20
> I don't have anything against this patch, but maybe it would be even
> more useful if it wrote some data to the final partial cluster (just an=

> idea).

And not a bad one.  Kevin said patch 1 and 2 are okay for freeze (if
wanted; but not essential if they miss it), so I'll post v7 soon.

>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Of course, testing data written in the final cluster is non-trivial, so
I'll drop your R-b.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ljNP19M6mo7kvORvvkeO7FSDmQPhNpNne
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3GnJAAoJEKeha0olJ0NqIB8H/0Z3kT5pmUPMNLiddZ0IssWJ
1g8O1VhuqBqtqtB/704G03ERlarzxU6FDMJjDt3uR5oBX+KwnLdLBGJqYAAK32EM
84lh2ZRmzudNhBgPvxSFbXQFSHpUXMDtYit8nwOaWqwTwodR0BtPGy0rDIFA62xq
t68zwR4Ta1eKTZlklUhiDQfthY50e/le6Or+Zd9nbOZXY+JTv9j/x/3j8CTVjJN1
IVlRy8Mg/xB6DtmrkABd72fq5FLdyROZuT/VjwQFXnpMiC4OTAZEclgQdD2B712r
OQ/kHm2dDyUleLB/UFu4TM3HX7+Pk6+9ncM59kD8AT3EbBPYDcaeBvcL4qCSUfQ=
=rYHD
-----END PGP SIGNATURE-----

--ljNP19M6mo7kvORvvkeO7FSDmQPhNpNne--
