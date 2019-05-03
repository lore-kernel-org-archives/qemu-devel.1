Received: from eggs.gnu.org ([209.51.188.92]:43312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMPwl-00039F-7G
	for qemu-devel@nongnu.org; Fri, 03 May 2019 00:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMPwk-0003of-CM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 00:37:19 -0400
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
	<f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <61685a48-b84e-c379-7193-f456e82635ba@redhat.com>
Date: Fri, 3 May 2019 06:37:03 +0200
MIME-Version: 1.0
In-Reply-To: <f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="uVRlTm7E2l2HXjKSuDiOFq69MEpRDVd6o"
Subject: Re: [Qemu-devel] Failing QEMU iotest 175
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Nir Soffer <nirsof@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uVRlTm7E2l2HXjKSuDiOFq69MEpRDVd6o
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02/05/2019 23.56, Eric Blake wrote:
> On 4/28/19 10:18 AM, Thomas Huth wrote:
>> QEMU iotest 175 is failing for me when I run it with -raw:
>>
>=20
>>  =3D=3D creating image with default preallocation =3D=3D
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
>> -size=3D1048576, blocks=3D0
>> +size=3D1048576, blocks=3D2
>=20
> What filesystem?

ext4

> It should be fairly obvious that 'stat -c blocks=3D%b' is
> file-system dependent (some allocate slightly more or less space, based=

> on granularities and on predictions of future use), so we may need to
> update the test to apply a filter or otherwise allow a bit of fuzz in
> the answer. But 0/2 is definitely different than...
>>
>>  =3D=3D creating image with preallocation off =3D=3D
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 prealloca=
tion=3Doff
>> -size=3D1048576, blocks=3D0
>> +size=3D1048576, blocks=3D2
>>
>>  =3D=3D creating image with preallocation full =3D=3D
>>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 prealloca=
tion=3Dfull
>> -size=3D1048576, blocks=3D2048
>> +size=3D1048576, blocks=3D2050
>=20
> 2048/2050, so we DO have some indication of whether the file is sparse
> or fully allocated.

Maybe we could check that the value after "blocks=3D" is a single digit i=
n
the first case, and matches "blocks=3D20.." in the second case?

 Thomas


--uVRlTm7E2l2HXjKSuDiOFq69MEpRDVd6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcy8V0AAoJEC7Z13T+cC21qZMP/1CqP4adU7txqJaftatQ9PXx
q+91yK9EQWAZ+NJxtL0664WiTt9NrGNGVTMrSq8ot5e2wwzerm7giflNBMyre3Qs
PhHGkn/KjpRq9EaTbB0ZAhh9GTYs2AfUe7UKUB568u1wyyhy066mcvVvq1toryFM
68nFfRcEl8mRfJmmWdDvVUMNxIkkWOhJs9envN0moKlpJd5USqe7sOMLFRObw3nd
vKdJiMva4wXCTH+NTgCWnUAxHndgGFjO0B5aAH6j73V73Elm0RlEebZL33OgYL4D
D02tsfmEeW/4gnRvkJ46vFLuRzp3fUQEUtdvJwRpYFucBsNii6FQzlAj37pu8Ocu
MGTILSgncZvRQfK4vHBATM1Lnx58LNtj/ZMAmLW6P5Ezd3YrBfCi9ILv4ogWYBas
V/bMg//Jka3Dx4aHHl07ctCCCkxhgeyhKnn+o6IuhbZNA+nq2m4fmKCexNUgDaYz
XslalHZZe7zTjrv/ABwCui1/JOtYjPSsj3MY0fcymL4euiadC8dJfoBqvzZ1lWNL
JK2zoB6plxfhHiKlvLA6NL1z0LOMFiGKNCM91/6gqAH4V5r+N5rL6elUnZXj+tJz
ZPSOJaLCnl3gS5jKgm6L8+w/nhKhso4spapX8i7Pe8/uvzEQoEcCfK+sbOoURUlR
JGTrdMR6Hbwcyxb+7X+l
=rg2q
-----END PGP SIGNATURE-----

--uVRlTm7E2l2HXjKSuDiOFq69MEpRDVd6o--
