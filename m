Received: from eggs.gnu.org ([2001:4830:134:3::10]:47963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cswtR-0004a2-1K
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cswtQ-00027b-6Z
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:35:01 -0400
References: <20170308191434.2413-1-mreitz@redhat.com>
	<20170308191434.2413-3-mreitz@redhat.com>
	<20170323174620.GC5344@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f24a03e8-7b9e-b74c-7dfb-98090f85fe5c@redhat.com>
Date: Tue, 28 Mar 2017 21:34:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170323174620.GC5344@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gBLEq5Xkr4ofa7UBEfgrT7lFevD7PrFUI"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 2/4] block: Add errp to b{lk,
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gBLEq5Xkr4ofa7UBEfgrT7lFevD7PrFUI
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Message-ID: <f24a03e8-7b9e-b74c-7dfb-98090f85fe5c@redhat.com>
Subject: Re: [PATCH v2 for-2.10 2/4] block: Add errp to b{lk,drv}_truncate()
References: <20170308191434.2413-1-mreitz@redhat.com>
 <20170308191434.2413-3-mreitz@redhat.com>
 <20170323174620.GC5344@noname.redhat.com>
In-Reply-To: <20170323174620.GC5344@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 23.03.2017 18:46, Kevin Wolf wrote:
> Am 08.03.2017 um 20:14 hat Max Reitz geschrieben:
>> For one thing, this allows us to drop the error message generation fro=
m
>> qemu-img.c and blockdev.c and instead have it unified in
>> bdrv_truncate().
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 6a92d2ef3f..43b8a986f0 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -2294,9 +2294,8 @@ static int qcow2_create2(const char *filename, i=
nt64_t total_size,
>>      }
>> =20
>>      /* Okay, now that we have a valid image, let's give it the right =
size */
>> -    ret =3D blk_truncate(blk, total_size);
>> +    ret =3D blk_truncate(blk, total_size, errp);
>>      if (ret < 0) {
>> -        error_setg_errno(errp, -ret, "Could not resize image");
>=20
> Maybe error_prepend(errp, "Could not resize image: ") could make sense?=


Sure, why not.

Max

>>          goto out;
>>      }
>=20
> Kevin
>=20



--gBLEq5Xkr4ofa7UBEfgrT7lFevD7PrFUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljautsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aad4IAJ1a1UV1P+OD+HcfkkkC4E+7vgBDJILj
r6B/O+xKt3B3WjM+esthLvB4IS1nnCNpg/q6tXf6tOorXvASPkUFpBEWAm2o9z1y
O4/gNqplda9gOn5d+MkMKPoDFiTQqURmvq4zdpIYVXNAoS5CdPNM2/D+lsM/eD8k
sQ5UIS63iT3JpQ7f29dzjxdBAM0rGvefLeJHvINOrwvximl8WMHtFzSBtj5erTTB
kfm/+lneQYI95bAf2YnZwoQrjtmaAmrHixuuLevuXzB+wu1aAXV3omk6W2h+l6h9
o/2Pb8AcNyoSo2DoZqX6oPt9PJwHj5fLJBZhNmd5mRi4Rtd3EWKlq1I=
=2KNl
-----END PGP SIGNATURE-----

--gBLEq5Xkr4ofa7UBEfgrT7lFevD7PrFUI--
