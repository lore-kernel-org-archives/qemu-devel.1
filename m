Received: from eggs.gnu.org ([2001:4830:134:3::10]:40998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eyHqE-0000JK-7K
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eyHq9-0001Fg-QC
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:02:18 -0400
References: <20180319090223.23336-1-vsementsov@virtuozzo.com>
	<20180319090223.23336-4-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ad6bb9d8-559c-58dc-6bbb-aa8b2feaa85b@redhat.com>
Date: Tue, 20 Mar 2018 15:01:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180319090223.23336-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HNu42ajxE5ZmGpcFajJwIXPlb3GWo7Eo1"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] iotests: enable shared migration
 cases in 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HNu42ajxE5ZmGpcFajJwIXPlb3GWo7Eo1
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <ad6bb9d8-559c-58dc-6bbb-aa8b2feaa85b@redhat.com>
Subject: Re: [PATCH v3 3/3] iotests: enable shared migration cases in 169
References: <20180319090223.23336-1-vsementsov@virtuozzo.com>
 <20180319090223.23336-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180319090223.23336-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-19 10:02, Vladimir Sementsov-Ogievskiy wrote:
> Shared migration for dirty bitmaps is fixed by previous patches,
> so we can enable the test.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/169 | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Isn't this missing some changes to 169.out (because the number of tests
is doubled)?

Max


--HNu42ajxE5ZmGpcFajJwIXPlb3GWo7Eo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqxFFMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AwQ0H/0Mgq9+ocYITNYA1BGKjnmkCCUQLyyGH
VDXgaY3QHByHKsR8904RYOUuoz847VfV7o5yuEn7gp6oUHqB3M6TYdw0a3ZNu+44
cpItU1fXsjfmNiOFyM7Dxxe9kNflcloCsAEbHvfzpac8x7yCKtkiXResgHxM1ehl
uNR3pEvQKXAyEFvfcCoQFaAkFxRdk1sqeQMUclwPHSC2wJfXe73Q5x2P4oVyt8hq
t9LrNPqSHQKhTcUzh/nhVpf2Kjt43xa8hu8uwlhKZCdsBIIuauDiTn1JpJKUb1ur
q8DRPZoW0uaxIHQ9YjMfYnxW4HDeXjMtLHS3MLHqpHLRi28yxhFL26Q=
=oeKm
-----END PGP SIGNATURE-----

--HNu42ajxE5ZmGpcFajJwIXPlb3GWo7Eo1--
