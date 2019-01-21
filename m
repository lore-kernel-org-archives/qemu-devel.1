Received: from eggs.gnu.org ([209.51.188.92]:35773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1glgcF-0000Ns-G2
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1glgcD-0006J9-LW
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:56:18 -0500
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <95f91d74-f165-542f-678f-a79f9253a3c5@redhat.com>
Date: Mon, 21 Jan 2019 14:56:13 -0600
MIME-Version: 1.0
In-Reply-To: <20181221234750.23577-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p05gbnSXHc0CfNsdB9WXpjcCitcj8MzWZ"
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: Bind qemu-nbd to localhost in
 147
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p05gbnSXHc0CfNsdB9WXpjcCitcj8MzWZ
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <95f91d74-f165-542f-678f-a79f9253a3c5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: Bind qemu-nbd to localhost in
 147
References: <20181221234750.23577-1-mreitz@redhat.com>
 <20181221234750.23577-3-mreitz@redhat.com>
In-Reply-To: <20181221234750.23577-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/21/18 5:47 PM, Max Reitz wrote:
> By default, qemu-nbd binds to 0.0.0.0.  However, we then proceed to
> connect to "localhost".  Usually, this works out fine; but if this test=

> is run concurrently, some other test function may have bound a differen=
t
> server to ::1 (on the same port -- you can bind different serves to the=


s/serves/servers/

> same port, as long as one is on IPv4 and the other on IPv6).
>=20
> So running qemu-nbd works, it can bind to 0.0.0.0:NBD_PORT.  But
> potentially a concurrent test has successfully taken [::1]:NBD_PORT.  I=
n
> this case, trying to connect to "localhost" will lead us to the IPv6
> instance, where we do not want to end up.
>=20
> Fix this by just binding to "localhost".  This will make qemu-nbd error=

> out immediately and not give us cryptic errors later.
>=20
> (Also, it will allow us to just try a different port as of a future
> patch.)
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/147 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--p05gbnSXHc0CfNsdB9WXpjcCitcj8MzWZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxGMe0ACgkQp6FrSiUn
Q2rtfAf/bV8lDxPMR5IRNG97DvUlx0i+zXP9D1mwz67/hzsulEsUczkLKaF+FGwy
Dj9SJryqHUYn3ptuNbVuz9KIzXGYfRHRBIO6bOk87kqdDs7D9PbVDpuxaInPKjFh
EkHV774ObaKMOlvggFZlvax7gmdA9LCwSJiqowXgWT3kYQTTKVHLq4uzLKtSezGn
ymmf7xORYIauqxZUZGePSb2aWjGhMdfKwAx4NCA8I2ZEHtwyLIzo2sueMk/+PaOm
LRi4F2AMef+wncjlkM7CfCRbvo0IcK3vHijfvY/dq/5XiHzUC2ouNwBCSydPkgvp
T1jp5CqKkyN7byJYFufAxUhpJHfgbw==
=MPLL
-----END PGP SIGNATURE-----

--p05gbnSXHc0CfNsdB9WXpjcCitcj8MzWZ--
