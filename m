Received: from eggs.gnu.org ([2001:4830:134:3::10]:38019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cle4k-0007sU-Gk
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 11:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cle4j-0003iK-5n
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 11:04:30 -0500
References: <20170306195255.15806-1-mreitz@redhat.com>
	<20170306195407.16415-1-mreitz@redhat.com>
	<20170307104748.GG5871@noname.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <54b7dbc7-9a04-f8b5-2d01-9332b725f46b@redhat.com>
Date: Wed, 8 Mar 2017 17:04:10 +0100
MIME-Version: 1.0
In-Reply-To: <20170307104748.GG5871@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XlrcAlRnUrVWSLM25ODKlu98SmoR2SgG8"
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/3] block: Add errp to b{lk,
 drv}_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XlrcAlRnUrVWSLM25ODKlu98SmoR2SgG8
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <54b7dbc7-9a04-f8b5-2d01-9332b725f46b@redhat.com>
Subject: Re: [PATCH for-2.10 1/3] block: Add errp to b{lk,drv}_truncate()
References: <20170306195255.15806-1-mreitz@redhat.com>
 <20170306195407.16415-1-mreitz@redhat.com>
 <20170307104748.GG5871@noname.str.redhat.com>
In-Reply-To: <20170307104748.GG5871@noname.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07.03.2017 11:47, Kevin Wolf wrote:
> Am 06.03.2017 um 20:54 hat Max Reitz geschrieben:
>> For one thing, this allows us to drop the error message generation fro=
m
>> qemu-img.c and blockdev.c and instead have it unified in
>> bdrv_truncate().
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>>  block/commit.c                 |  5 +++--
>>  block/mirror.c                 |  2 +-
>=20
> These still pass NULL after the series. Fixing it would require to add =
a
> way to complete jobs with an Error object, but maybe we should do this
> sooner or later anyway. Not necessarily part of this series, though.
>=20
>>  block/vhdx.c                   |  6 +++---
>>  block/vpc.c                    |  2 +-
>=20
> vpc can easily be fixed to pass the actual errp from vpc_create() to th=
e
> blk_truncate() call. In vhdx.c, the blk_truncate() call is a bit more
> deeply nested, but it doesn't seem completely unreasonable there either=
=2E

I'll look into it, thanks.

>> --- a/qemu-io-cmds.c
>> +++ b/qemu-io-cmds.c
>> @@ -1569,7 +1569,7 @@ static int truncate_f(BlockBackend *blk, int arg=
c, char **argv)
>>          return 0;
>>      }
>> =20
>> -    ret =3D blk_truncate(blk, offset);
>> +    ret =3D blk_truncate(blk, offset, NULL);
>>      if (ret < 0) {
>>          printf("truncate: %s\n", strerror(-ret));
>>          return 0;
>=20
> Come on, using NULL immediately before a printf()? Doing the right thin=
g
> here is trivial.

Yeah, but it's also qemu-io, so I somehow felt both "Better not touch it
because it may break tests" and "Nobody really cares about a nice
message here anyway".

Will fix, since apparently at least you do care. ;-)

Max


--XlrcAlRnUrVWSLM25ODKlu98SmoR2SgG8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljAK3oSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/ksH91rzCQkEDYhRlcZ81bCZdVooxcMcELCc
FTPjlCl8z0uQpZHhWLlwHqAhqP/7J/07+NKnKB4Gzcmg2h82HoXqEOF3QTcVtImB
M6nBeFdaBGjWk279pAchBT9REA/8PUFY1W9hj+1BovVJij0FEYCMQuVhL55jgtmf
6nt9IuKRuKR0muaKYv6+DRPb7DOIbdMaR9NyRVSjGMLO0oFbM9uTCY2P6Fisuegq
ifP3NHEUJVsr4FCnCHJe07McfNkO12gDrl6N9BoD84yGUcCL6MaZ75K0wBTJvSts
UB7oRuPUF55Ps0n7+p2f4j9LRLwh14Ir6RCE4I6O3C/O/akdE2ydfw==
=P1+d
-----END PGP SIGNATURE-----

--XlrcAlRnUrVWSLM25ODKlu98SmoR2SgG8--
