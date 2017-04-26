Received: from eggs.gnu.org ([2001:4830:134:3::10]:34269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3Nzu-0006MZ-AO
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3Nzq-0004mY-HL
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:32:50 -0400
References: <20170426020349.25257-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <26b222e4-cb81-b13b-21ec-ea592c6bf20d@redhat.com>
Date: Wed, 26 Apr 2017 16:32:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170426020349.25257-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p84kQHGkc3cHKtwiO9efJwFrRWXwi45x0"
Subject: Re: [Qemu-devel] [PATCH] block: Remove NULL check in bdrv_co_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p84kQHGkc3cHKtwiO9efJwFrRWXwi45x0
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <26b222e4-cb81-b13b-21ec-ea592c6bf20d@redhat.com>
Subject: Re: [PATCH] block: Remove NULL check in bdrv_co_flush
References: <20170426020349.25257-1-famz@redhat.com>
In-Reply-To: <20170426020349.25257-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.04.2017 04:03, Fam Zheng wrote:
> Reported by Coverity. We already use bs in bdrv_inc_in_flight before
> checking for NULL. It is unnecessary as all callers pass non-NULL bs, s=
o
> drop it.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--p84kQHGkc3cHKtwiO9efJwFrRWXwi45x0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkAr4ESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6g0H/0JUK+8M5JURcvLnWgQsunq95fxQT9bR
79hI6TSRwlUXSspSWGdRvxKGDf0rG2K4YQXUWG7GWJXHoWDSVvCyQEPuIydPZoro
DmTiBiJ29F0sbihRVtpodQHCoIfJkDEUu0dqE4nIUkdiYxYh6/HOj6WREUsLK8rA
qdiAhOpSekJyzqUNjMHynHoxaeEM2PCdtjFhDJpQyUno+0PkdUbU2+W9mTLmybg1
pxtyXdFj4Yw5Uvn6WXi37BlB6gQR21BFIOdZ5GNpaJISUZOh+mkon/VMoGYW7H+m
/pQ/MhYmR8uv9+WleZA1jgxQzoi4QMiyA+Pi87tVUfy1IB9c8ZIl7vk=
=0X8d
-----END PGP SIGNATURE-----

--p84kQHGkc3cHKtwiO9efJwFrRWXwi45x0--
