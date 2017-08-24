Received: from eggs.gnu.org ([2001:4830:134:3::10]:52971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkwCH-0002T7-Vg
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 13:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkwCG-0000cB-F1
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 13:45:37 -0400
References: <20170824153345.2244-1-stefanha@redhat.com>
	<20170824153345.2244-4-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1914068-2570-2572-5d39-d81037df79c2@redhat.com>
Date: Thu, 24 Aug 2017 12:45:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170824153345.2244-4-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9ItrgC27m9JHT1x3nWn9hScbCUgxkGt4t"
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: test NBD over UNIX
 domain sockets in 083
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9ItrgC27m9JHT1x3nWn9hScbCUgxkGt4t
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1914068-2570-2572-5d39-d81037df79c2@redhat.com>
Subject: Re: [PATCH 3/3] qemu-iotests: test NBD over UNIX domain sockets in
 083
References: <20170824153345.2244-1-stefanha@redhat.com>
 <20170824153345.2244-4-stefanha@redhat.com>
In-Reply-To: <20170824153345.2244-4-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 10:33 AM, Stefan Hajnoczi wrote:
> 083 only tests TCP.  Some failures might be specific to UNIX domain
> sockets.
>=20
> A few adjustments are necessary:
>=20
> 1. Generating a port number and waiting for server startup is
>    TCP-specific.  Use the new nbd-fault-injector.py startup protocol to=

>    fetch the address.  This is a little more elegant because we don't
>    need netstat anymore.
>=20
> 2. The NBD filter does not work for the UNIX domain sockets URIs we
>    generate and must be extended.
>=20
> 3. Run all tests twice: once for TCP and once for UNIX domain sockets.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/083           | 138 +++++++++++++++++++++++--------=
------
>  tests/qemu-iotests/083.out       | 145 +++++++++++++++++++++++++++++++=
+++-----
>  tests/qemu-iotests/common.filter |   4 +-
>  3 files changed, 215 insertions(+), 72 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9ItrgC27m9JHT1x3nWn9hScbCUgxkGt4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmfELEACgkQp6FrSiUn
Q2rcRwf+I5HvNj8AddELmTXlm1FUtIarVJyr/58i07Pem/APwTMetbTCZ9DRpcB6
lLDShQNiM0JzFh76Kxd97Md9PvpwtQXnR35UmX7bDrC0OW2n+YmZJvtluMBOCOe2
tG80C9ip2hgDcmoiH0oztVNiDRBYnEMwpRvumgqDaG1JSQTjLUJCdwesxpJXKure
OvC9+xOE57WSWl25kNeabO572mhyca938v4GfIZIiFTOGZ0pgG+ILuyheFybw71L
+kRKwdsUCWbSi3kR08Wun0GJxcKzZ+SbpV1cxsJFR4Y6YQj01pL5iMKZSGaZb+ez
CTWx+5lHDUDONI5DXY4sr/dVfbDOZw==
=C5vT
-----END PGP SIGNATURE-----

--9ItrgC27m9JHT1x3nWn9hScbCUgxkGt4t--
