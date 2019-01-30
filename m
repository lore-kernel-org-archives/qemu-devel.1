Received: from eggs.gnu.org ([209.51.188.92]:60950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gopYe-0004UW-SP
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gopYR-0003S4-5W
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:05:27 -0500
References: <20190123144610.8842-1-mreitz@redhat.com>
	<20190123144610.8842-4-mreitz@redhat.com>
	<468692a4-a2e2-55f0-eb49-6dee6be6aee7@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <33e33681-a95a-40e9-4b37-4633e3f72ae3@redhat.com>
Date: Wed, 30 Jan 2019 14:05:13 +0100
MIME-Version: 1.0
In-Reply-To: <468692a4-a2e2-55f0-eb49-6dee6be6aee7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dbkgwQPtPjt87PE8WlG1MbOQsgQe4gAcQ"
Subject: Re: [Qemu-devel] [PATCH 3/9] iotests: Fix 232 for LUKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dbkgwQPtPjt87PE8WlG1MbOQsgQe4gAcQ
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <33e33681-a95a-40e9-4b37-4633e3f72ae3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/9] iotests: Fix 232 for LUKS
References: <20190123144610.8842-1-mreitz@redhat.com>
 <20190123144610.8842-4-mreitz@redhat.com>
 <468692a4-a2e2-55f0-eb49-6dee6be6aee7@redhat.com>
In-Reply-To: <468692a4-a2e2-55f0-eb49-6dee6be6aee7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.01.19 22:26, John Snow wrote:
>=20
>=20
> On 1/23/19 9:46 AM, Max Reitz wrote:
>> With IMGOPTSSYNTAX, $TEST_IMG is useless for this test (it only tests
>> the file-posix protocol driver).  Therefore, if $TEST_IMG_FILE is set,=

>> use that instead.
>>
>> Because this test requires the file protocol, $TEST_IMG_FILE will alwa=
ys
>> be set if $IMGOPTSSYNTAX is true.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> This keeps biting us. Or at least, it bit me once and then it has bitte=
n
> someone else. It's not obvious that you need to accommodate this when
> writing a new test.

No, it isn't. :-)

But I think at least me running ./check -luks from time to time should
be sufficient, usually.  It's just that I had basically given up on a
clean iotests run for a month or two now...

Max


--dbkgwQPtPjt87PE8WlG1MbOQsgQe4gAcQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxRoQkACgkQ9AfbAGHV
z0BLTAf9GcpY9tLUJS9PJN9RW4R4fZJlQ25Vx8JZzteSViRvkkpSwSVHTb7Wi7kU
IuH42YvLSxRlME3GWaKrBKEm/FRd4HGhMFg7FFQlV/HGJ6GdKJs6B8EdjUpm1ijR
/AUbXkYLmPXNh5749raiNQnz/Emf4VL1ZGWoRcCdvcSSZB3MlNLQ/OZx7bv8Rt0B
cxN6q1AGpmzAowRa39UGsHaVc0fMVW+2Eq5/V+sjVML+xaSHtXOYw+6rMIWuDQ7e
lzstkrf/1CVrfKAvqitHeYhb3NDOEyZrFOfkcu5XhkW06q/+SzYBfcQgrm2Ae/W3
2R0AOkvxHps8GnNVUgcj0FeI0F71SA==
=CLsi
-----END PGP SIGNATURE-----

--dbkgwQPtPjt87PE8WlG1MbOQsgQe4gAcQ--
