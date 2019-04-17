Received: from eggs.gnu.org ([209.51.188.92]:40850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGokR-0007MP-CF
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGokJ-0002W0-GN
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:53:22 -0400
References: <20190417171101.1254-1-eblake@redhat.com>
	<20190417171101.1254-3-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4ce5d8a7-8fdc-84ec-bb4c-0e7248aad62c@redhat.com>
Date: Wed, 17 Apr 2019 19:52:57 +0200
MIME-Version: 1.0
In-Reply-To: <20190417171101.1254-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="evzUGUgenlz3T2Qc3tMFLvCw40aCrowVM"
Subject: Re: [Qemu-devel] [PATCH v3 2/2] qemu-img: Saner printing of large
 file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, "Richard W . M . Jones" <rjones@redhat.com>, Alberto Garcia <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--evzUGUgenlz3T2Qc3tMFLvCw40aCrowVM
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <4ce5d8a7-8fdc-84ec-bb4c-0e7248aad62c@redhat.com>
Subject: Re: [PATCH v3 2/2] qemu-img: Saner printing of large file sizes
References: <20190417171101.1254-1-eblake@redhat.com>
 <20190417171101.1254-3-eblake@redhat.com>
In-Reply-To: <20190417171101.1254-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.04.19 19:11, Eric Blake wrote:
> Disk sizes close to INT64_MAX cause overflow, for some pretty
> ridiculous output:
>=20
>   $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img info $=
nbd'
>   image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
>   file format: raw
>   virtual size: -8388607T (9223372036854775296 bytes)
>   disk size: unavailable
>=20
> But there's no reason to have two separate implementations of integer
> to human-readable abbreviation, where one has overflow and stops at
> 'T', while the other avoids overflow and goes all the way to 'E'. With
> this patch, the output now claims 8EiB instead of -8388607T, which
> really is the correct rounding of largest file size supported by qemu
> (we could go 511 bytes larger if we used byte-accurate sizing instead
> of rounding up to the next sector boundary, but that wouldn't change
> the human-readable result).
>=20
> Quite a few iotests need updates to expected output to match.
>=20
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> ---
> v3: fix 59 for vmdk [Max]

Tested-by: Max Reitz <mreitz@redhat.com>


--evzUGUgenlz3T2Qc3tMFLvCw40aCrowVM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAly3Z/kACgkQ9AfbAGHV
z0AGjQf8CR8hVFib6FhaLB3SLLJdOzrUBQ3140xO4NDBs06frNxcqD4KOyyMFLQc
mEmGcgnsuTgfEPuIfKdXXg7FPAqMyG244dWWpWiXa8fMCbGSq8czlwGcFapIzMNY
Zv3cNUjMg3S5GzV8TBeMcgUMgg9BqPCui3U49xrv9We7ewiUHvFpK+TrtAKXAGgC
YCBcCI+j0QgQRkScMDwg+gbS/ZmN2FXaq3BegyfOEGZfPtCHUFJFFgiKRD7jgajQ
mtQCmiHtpwbJVc5PfFM2WOMq6RhRup7UQx7bg2idk14RQB1i5MnNVBLKNEATVoLv
rtB6bTqR2wvS0j5IyPYX5JbE3lFgDQ==
=0/vy
-----END PGP SIGNATURE-----

--evzUGUgenlz3T2Qc3tMFLvCw40aCrowVM--
