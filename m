Received: from eggs.gnu.org ([2001:4830:134:3::10]:45177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce2tZ-0001Cj-RO
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ce2tZ-0001iD-75
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:57:33 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-9-vsementsov@virtuozzo.com>
	<4cfafc14-f9af-f992-b0be-8f283d0ddcfa@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a05595fe-1e70-823f-9584-64c968f11398@redhat.com>
Date: Wed, 15 Feb 2017 17:57:27 +0100
MIME-Version: 1.0
In-Reply-To: <4cfafc14-f9af-f992-b0be-8f283d0ddcfa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OLkKk2PJmULfJL2UJpFgiIJlA0HvL2F9l"
Subject: Re: [Qemu-devel] [PATCH 08/18] hbitmap: add next_zero function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OLkKk2PJmULfJL2UJpFgiIJlA0HvL2F9l
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com
Message-ID: <a05595fe-1e70-823f-9584-64c968f11398@redhat.com>
Subject: Re: [PATCH 08/18] hbitmap: add next_zero function
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-9-vsementsov@virtuozzo.com>
 <4cfafc14-f9af-f992-b0be-8f283d0ddcfa@redhat.com>
In-Reply-To: <4cfafc14-f9af-f992-b0be-8f283d0ddcfa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/02/2017 23:55, Eric Blake wrote:
> On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
>> The function searches for next zero bit.
>> Also add interface for BdrvDirtyBitmap.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  block/dirty-bitmap.c         |  5 +++++
>>  include/block/dirty-bitmap.h |  2 ++
>>  include/qemu/hbitmap.h       |  8 ++++++++
>>  util/hbitmap.c               | 26 ++++++++++++++++++++++++++
>>  4 files changed, 41 insertions(+)
>>
>=20
> It would be nice to enhance the testsuite to cover hbitmap_next_zero().=

>=20

Agreed.

Paolo


--OLkKk2PJmULfJL2UJpFgiIJlA0HvL2F9l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYpIh3AAoJEL/70l94x66D/fAH/A/zojwF43i80Oi/MZs7WDKR
/AZgskXkPX/3bdYN+w4m7zDqZwDgLQx6n/CwRTukzZe/HeHTsNA1llCTcBouem3x
3xQ8tnuKvBzHDgGgZVAwYrcHWVHm974gf+7fTHc1NyjLDsAjFACEVrX4gRfvpNgl
QYkqZ6QxS9Jlsnd+61Rv2cu/KYrUAD6MPE/okpGwHYA2DuBNlQB7hzDhJwIsmHcW
J4IMBya/xtQwyIzRazZ/IrZkt4zo7gyARyYzJ9JVJoYN9W2gnSPh7Y8Osv6/8NfV
ajmeqPZ4DfDYjqvF1EreZiymQHYJ55JRo2idebnAMKc6Md/ck5e8TM2HO2U9lSE=
=8Tv2
-----END PGP SIGNATURE-----

--OLkKk2PJmULfJL2UJpFgiIJlA0HvL2F9l--
