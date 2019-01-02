Received: from eggs.gnu.org ([208.118.235.92]:37623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geqr3-00054t-Uf
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 19:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geqr1-0005GR-QJ
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 19:27:21 -0500
Date: Thu, 3 Jan 2019 10:44:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102234405.GB10853@umbus.fritz.box>
References: <1546444676-27790-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <1546444676-27790-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add some missing ppc-related
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 04:57:56PM +0100, Thomas Huth wrote:
> hw/gpio/mpc8xxx.c is only used by the e500 machine, so add it there.
> And the hw/input/adb* files are specific to the Mac machines, so
> they should be assigned to these categories.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-4.0, thanks.

> ---
>  MAINTAINERS | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef6b7f6..eb037df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -951,6 +951,7 @@ L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/ppc/e500.[hc]
>  F: hw/ppc/e500plat.c
> +F: hw/gpio/mpc8xxx.c
>  F: include/hw/ppc/ppc_e500.h
>  F: include/hw/pci-host/ppce500.h
>  F: pc-bios/u-boot.e500
> @@ -962,7 +963,7 @@ S: Odd Fixes
>  F: hw/ppc/mpc8544ds.c
>  F: hw/ppc/mpc8544_guts.c
> =20
> -New World
> +New World (mac99)
>  M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
> @@ -972,12 +973,14 @@ F: hw/pci-bridge/dec.[hc]
>  F: hw/misc/macio/
>  F: hw/misc/mos6522.c
>  F: hw/nvram/mac_nvram.c
> +F: hw/input/adb*
>  F: include/hw/misc/macio/
>  F: include/hw/misc/mos6522.h
>  F: include/hw/ppc/mac_dbdma.h
>  F: include/hw/pci-host/uninorth.h
> +F: include/hw/input/adb*
> =20
> -Old World
> +Old World (g3beige)
>  M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
> @@ -985,7 +988,9 @@ F: hw/ppc/mac_oldworld.c
>  F: hw/pci-host/grackle.c
>  F: hw/misc/macio/
>  F: hw/intc/heathrow_pic.c
> +F: hw/input/adb*
>  F: include/hw/intc/heathrow_pic.h
> +F: include/hw/input/adb*
> =20
>  PReP
>  M: Herv=E9 Poussineau <hpoussin@reactos.org>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwtTMAACgkQbDjKyiDZ
s5LirhAAxnEPZEaHR5JVOzRCo91DOYE3CKixOn8SDz79/av0AXVwVwc+gQrcvu91
LJ9PLYt0FH2LhsYTcj0S7wgUqf4yIZd0NeKAy1YGVCoctwv/AHzgXPmbT2PNnfu7
GV7Vmk21cfEufgcPkz/BMdHqAPhnLtmUZo8ose4MrBllGeK2l0hmhYD8gljfTmTP
Ovr1i7nbeGUulXFcMWmHUxJYh/GLKhuTfQIChI4wIXuJC7qL/52pUc4B9cX7KadT
Iyil6oiARsb+uHsOceOj/Zkz1pxMXZovKHCDCxhriMZbGNO9PBNEB2TcNNLjtQTl
AsArL2DpG+uSsF1lNBk2le4+0MYyOGPGHLi7E3X0itcqbgErc8ymoxhY1QK22XfC
nRo7ZvaJiPkx5SYH7iRrNvVJiP/7+bihdAs1HN1X7zgirtG0oiL3R7PUjbouoA/0
XB/HIe8lWGPnlrl7cmtH5PVEJRIg9ObhN4nLH2g8rABFn8w3RH6CYuULQnLgtQZ8
/boCLFH72cy6ZG5xjf1JN00ay48yj9Ykv6rEaxov5J0uoA4z49maEAj5Z6oLdx0G
rvnzDIGtp8JCLsI2bvofD+TXJC9Cxf+6B7uDpbXii3qDR7UGmClM81eIRofnuCDl
z9yoiJ2/F+SBuzf1jZieVAlKNbLtvXxKirb72//1dvbyx62M+o8=
=cbst
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
