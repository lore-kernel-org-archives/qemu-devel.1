Received: from eggs.gnu.org ([209.51.188.92]:37163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGmfh-0005P9-56
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGmfe-0008JP-7m
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 11:40:24 -0400
References: <20190417153005.30096-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5897a475-e056-a0d6-f979-5cea490451d1@redhat.com>
Date: Wed, 17 Apr 2019 10:39:57 -0500
MIME-Version: 1.0
In-Reply-To: <20190417153005.30096-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UD44ldDwPNCTgR0vWmaNzV1JDeP8REgSh"
Subject: Re: [Qemu-devel] [PATCH] iotests: Make 182 do without device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UD44ldDwPNCTgR0vWmaNzV1JDeP8REgSh
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Message-ID: <5897a475-e056-a0d6-f979-5cea490451d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Make 182 do without device_add
References: <20190417153005.30096-1-mreitz@redhat.com>
In-Reply-To: <20190417153005.30096-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/17/19 10:30 AM, Max Reitz wrote:
> 182 fails if qemu has no support for hotplugging of a virtio-blk device=
=2E
> Using an NBD server instead works just as well for the test, even on
> qemus without hotplugging support.
>=20
> Fixes: 6d0a4a0fb5c8f10c8eb68b52cfda0082b00ae963
> Reported-by: Danilo C. L. de Paula <ddepaula@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> To reintroduce the bug for which this test was written, revert the
> following commits:
>=20
> $ git revert -n \
>     23dece19da41724349809873923e20a48b619cb7 \
>     6ceabe6f77e4ae5ac2fa3d2ac1be11dc95021941 \
>     a6aeca0ca530f104b5a5dd6704fca22b2c5edefa \
>     577a133988c76e4ebf01d050d0d758d207a1baf7

Useful instructions; with them, I was able to:

Tested-by: Eric Blake <eblake@redhat.com>

> ---
>  tests/qemu-iotests/182     | 22 +++++++++++++++++-----
>  tests/qemu-iotests/182.out |  1 +
>  2 files changed, 18 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Do you want me to take this through my NBD tree, since it now depends on
NBD? I'm also fine letting it go through your iotests tree

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--UD44ldDwPNCTgR0vWmaNzV1JDeP8REgSh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3SM0ACgkQp6FrSiUn
Q2pPsQgAmFlgPNHkSyLJZXYzjaKmTV9etpHIo1YprNYzXi8RCCnNowveZnZ/qVVn
6DzCGeYU7O70btDPHR848EhCpfayQVmRH1ooQNeTi4u2PUxv2kYO8ki7b8i/VPEA
wyz4g9uMXxzvZPDZgFJ1zkW9NRjJgQVXbzX0yM1aOMLdSBGFqGWyx6JK3KwlqNiC
b99CSobUj8or/Ikvj/4aj8hZFK/AjgAtnhDe2BDoGDOAHJlTvfQOzqAwfxxwgIf9
6hZ6EAbMJjn8ucs8saY6fGjffoUFDX1l3Dxn9tkw3FW+bqfcCHMtl6EeqPQBiC+/
RMYWKqYSSxK07hQD0d6NZLTq3KQQIg==
=QzvC
-----END PGP SIGNATURE-----

--UD44ldDwPNCTgR0vWmaNzV1JDeP8REgSh--
