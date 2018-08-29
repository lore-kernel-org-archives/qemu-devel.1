Received: from eggs.gnu.org ([2001:4830:134:3::10]:39054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuxBH-0005Yy-AU
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fux23-00061T-Co
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:45:00 -0400
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-6-mreitz@redhat.com>
	<w517ekasjtr.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ca1fb933-8a5b-3055-0460-ab1d3859ebdf@redhat.com>
Date: Wed, 29 Aug 2018 11:44:52 +0200
MIME-Version: 1.0
In-Reply-To: <w517ekasjtr.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4TxbCocw9mXlXYaEzp9a8tUDGQoPvokUJ"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 05/31] block: Respect backing
 bs in bdrv_refresh_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4TxbCocw9mXlXYaEzp9a8tUDGQoPvokUJ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <ca1fb933-8a5b-3055-0460-ab1d3859ebdf@redhat.com>
Subject: Re: [PATCH for-3.1 v10 05/31] block: Respect backing bs in
 bdrv_refresh_filename
References: <20180809213528.14738-1-mreitz@redhat.com>
 <20180809213528.14738-6-mreitz@redhat.com>
 <w517ekasjtr.fsf@maestria.local.igalia.com>
In-Reply-To: <w517ekasjtr.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-28 15:26, Alberto Garcia wrote:
> On Thu 09 Aug 2018 11:35:02 PM CEST, Max Reitz wrote:
>> +    backing_overridden =3D bdrv_backing_overridden(bs);
>> +
>> +    if (bs->open_flags & BDRV_O_NO_IO) {
>> +        /* Without I/O, the backing file does not change anything.
>> +         * Therefore, in such a case (primarily qemu-img), we can
>> +         * pretend the backing file has not been overridden even if
>> +         * it technically has been. */
>> +        backing_overridden =3D false;
>> +    }
>=20
> What is this for?

qemu-img info opens files with BDRV_O_NO_BACKING.  Without this check,
you'd get a json:{} filename with "backing": null.

Max


--4TxbCocw9mXlXYaEzp9a8tUDGQoPvokUJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGaxQACgkQ9AfbAGHV
z0BMJAgAvLBk5/5sYJemcen3Q7QfiPjkm3h9TTB3A5qm0Ga3YM4+Nq7VHG7EBu/Q
GwKag/7cC+RDXrMRAC+EGefKoaRa9w8TDDytC4jnmckOjIru//DRsOFFERwgvPOw
4EpqABe6pncvdnR305rUCg8/agofTT+a7N5ekguhBs93sdOwxhBE7MkvMxili+k2
7P9aqUIwwkjPARZyqy1kf0qVrTzJNLoF+TDRpJOYeHhiqwOTjcJYSdJSYzedo3IX
sNLuu0YqM2kAMG0J+Jxi8W642hTLuUeeQ2nI1+1WOl1GAAcL3ROmdtxM0NizQHbw
ZeClWnvCMlf/4HustE3yyH2ayhmO/g==
=JqJL
-----END PGP SIGNATURE-----

--4TxbCocw9mXlXYaEzp9a8tUDGQoPvokUJ--
