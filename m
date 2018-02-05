Received: from eggs.gnu.org ([2001:4830:134:3::10]:47914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1einui-0006c1-1y
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:02:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1einuh-000422-29
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:02:56 -0500
References: <20180202160752.143796-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7e60b588-249e-4961-1556-b56c76342ddb@redhat.com>
Date: Mon, 5 Feb 2018 22:02:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180202160752.143796-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sn9qQipEEDmaz2uWBcPWSARdgevD4hRCY"
Subject: Re: [Qemu-devel] [PATCH v3] block: maintain persistent disabled
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sn9qQipEEDmaz2uWBcPWSARdgevD4hRCY
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com,
 mnestratov@virtuozzo.com
Message-ID: <7e60b588-249e-4961-1556-b56c76342ddb@redhat.com>
Subject: Re: [PATCH v3] block: maintain persistent disabled bitmaps
References: <20180202160752.143796-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180202160752.143796-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-02 17:07, Vladimir Sementsov-Ogievskiy wrote:
> To maintain load/store disabled bitmap there is new approach:
>=20
>  - deprecate @autoload flag of block-dirty-bitmap-add, make it ignored
>  - store enabled bitmaps as "auto" to qcow2
>  - store disabled bitmaps without "auto" flag to qcow2
>  - on qcow2 open load "auto" bitmaps as enabled and others
>    as disabled (except in_use bitmaps)
>=20
> Also, adjust iotests 165 and 176 appropriately.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--sn9qQipEEDmaz2uWBcPWSARdgevD4hRCY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp4xmUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AfWIH/3Rs67fjylIIzcYH9T9x74y2CXSRcwfZ
7MWgAeIzwCclXDMa23VYvdGU5gvmTzwGNHV822oeAKuMMd0C3Afb7Z172Bui7rtX
ZuVE9PC3zZs/5bl+6cA/w+OM4czLewo6XLY1j0dV1ZQpDfi/0gjwA6tQneR1rb52
HjKTdX0rUyEQz3BwlZU9FSBN9zoEOGnevslCqz6vpzJpvuHzTNFYd41zSNkyckQU
dmfXwn+hfGlBtePLex9QnVUZFAIQV8/iA7Hx5bmixKK1kfoerkKuCWzVeuH8baFd
2rT7le1KYTTJcEuGokVzSnzzzNnYMHw0oidIQlR6ekvDd2UR9ujHhPc=
=g051
-----END PGP SIGNATURE-----

--sn9qQipEEDmaz2uWBcPWSARdgevD4hRCY--
