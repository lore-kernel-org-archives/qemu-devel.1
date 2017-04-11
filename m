Received: from eggs.gnu.org ([2001:4830:134:3::10]:35502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxueY-0008GR-1q
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxueS-0005K5-GL
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:12:10 -0400
References: <20170411011718.9152-1-eblake@redhat.com>
	<20170411011718.9152-4-eblake@redhat.com>
	<7d7d9d70-1842-7911-6854-571b3cb04d19@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb799df8-94bb-e395-d2f3-d5424d8bd307@redhat.com>
Date: Tue, 11 Apr 2017 07:11:56 -0500
MIME-Version: 1.0
In-Reply-To: <7d7d9d70-1842-7911-6854-571b3cb04d19@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HomUo9tv5i8t4NqCJalgU00cPFM4433KO"
Subject: Re: [Qemu-devel] [PATCH v9 03/13] qemu-io: Switch 'alloc' command
 to byte-based length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HomUo9tv5i8t4NqCJalgU00cPFM4433KO
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <eb799df8-94bb-e395-d2f3-d5424d8bd307@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 03/13] qemu-io: Switch 'alloc' command to
 byte-based length
References: <20170411011718.9152-1-eblake@redhat.com>
 <20170411011718.9152-4-eblake@redhat.com>
 <7d7d9d70-1842-7911-6854-571b3cb04d19@amsat.org>
In-Reply-To: <7d7d9d70-1842-7911-6854-571b3cb04d19@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2017 09:37 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Eric,
>=20
> On 04/10/2017 10:17 PM, Eric Blake wrote:
>> For the 'alloc' command, accepting an offset in bytes but a length
>> in sectors, and reporting output in sectors, is confusing.  Do
>> everything in bytes, and adjust the expected output accordingly.
>>

>>          }
>>      } else {
>> -        nb_sectors =3D 1;
>> +        bytes =3D BDRV_SECTOR_SIZE;
>>      }
>> +    if (bytes & 0x1ff) {
>=20
> This macro is self-explanatory:
>=20
> if(!QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE))

Indeed; but I was going for copy-and-paste consistency with the rest of
the file that also open-codes this.  A separate cleanup patch for all of
them would qualify as trivial.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HomUo9tv5i8t4NqCJalgU00cPFM4433KO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7MgMAAoJEKeha0olJ0NqxK0IAJ9xdE0sAUwInX4lr5GIdflR
oJdG8ACD5//k2U9ZaSzOysrqFCYzdUlt877rasxpSYRoFqyRIjX6g9Unooi/RZmi
+p/+qW6dZFfqSnxaq0LIuD8DOchw2KtUALptkXN+3E44s/rHEn3+QlIDCVfht4iV
lY0EKSN2qtA7KP01VNrpqj/2Fbkn0SfHUmtOuFKSyQ4Bq4TbUE09qHPgp2Ay5s2g
21ZO3TBtH8vieuvX6FXPlYD0gYIbtiQPrA5QUHPviWz+5S/0OwMYKNoar8kyHTz0
bqJEHbqHczGjkfovlyHXZXXnAhiuiBZaaPItnlHW1dHwF4ITdsF5KzzzL3t6b0Y=
=r7CG
-----END PGP SIGNATURE-----

--HomUo9tv5i8t4NqCJalgU00cPFM4433KO--
