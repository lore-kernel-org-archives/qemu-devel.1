Received: from eggs.gnu.org ([2001:4830:134:3::10]:40630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1efxTo-0000Gk-2Q
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 19:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1efxTm-00038D-TW
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 19:39:24 -0500
Date: Mon, 29 Jan 2018 11:36:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180129003623.GE12900@umbus>
References: <20180119050005.29392-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <20180119050005.29392-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V5 0/7] target/ppc: Rework
 spapr_caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@ozlabs.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 03:59:58PM +1100, Suraj Jitindar Singh wrote:
> The following patch series adds 3 new tristate capabilities and their
> associated handling.
>=20
> A new H-Call is implemented which a guest will use to query the=20
> requirement for and availability of workarounds for certain cpu=20
> behaviours.
>=20
> Applies on top of David's tree: ppc-for-2.12

Applied to ppc-for-2.12 (except that the kernel header updates from
1/7 were dropped, since they were already included by Cornelia's
general update in 9cbb6362.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpubIQACgkQbDjKyiDZ
s5Lhsg//WzlDGri5UbFuk5hc5gpT0EX/AgVML3DoCie/ZT6/NHml8DyVpmoeFsUb
Y5yz9b/rV8i4Zv0WxsfLBuzaBm3OFpab2ni+XiqnzW8C13BgJ5QIcE7mMgCeA5N/
D62sAFpN1QQB/j/sPUBXQbEWhTOD2a8wpvE0GJ+3vYgUSdy/E80aGuPY2XiDQI1d
goc7EjqSdSMirf5Y3v0fcQ95nRPWOxwNqUpj/XHbD1FY0DW9rAeZfasD9HruB7BD
8ESjN7OFhCXr/smezy4utxFez3BWd/NRdD60LojswNRaV0ZHjwkRP9smgdK47ivD
e7Z9xmDy3DJHkQ51qUQudvhsp25hn+z8OmDSv1sQwnLn7aA8JwnfGflSt81NRQff
Y1m/8hZNtEj6ntbKg1wuQIR8UhjDLStMx31zf83eyvPmh2n9RBAj9qFs+yhdZOZP
cY6X+oYlCf35Rc8qtThKLa+ggUWfeqHE4BDXsXE64pKh3SyZ4PxATwKftRRmkPpC
MEEdWxRS4Qtz5NG6yxBjyq7FOn5+/4WHjRtX5tT9BpEI6hVRbFjQNgx7khbzjbNW
UVTKlQfl+OI7mh3LtSWDfxRgasUohGTdby6wv0BViTvhLsGwXX1veRlpn2eUe+Kv
WkgsT97p8XOfw4p93LJhBVW4HrG0ZM9W9gQIu0bdazIbeopG8tY=
=ITuR
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
