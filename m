Received: from eggs.gnu.org ([2001:4830:134:3::10]:48104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKDK5-0002mH-TE
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 21:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKDK1-0004Kz-R2
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 21:12:01 -0500
Date: Wed, 7 Nov 2018 13:05:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181107020559.GC1754@umbus.fritz.box>
References: <20181030093531.18587-1-agraf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <20181030093531.18587-1-agraf@suse.de>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: PPC: Remove myself
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 30, 2018 at 10:35:31AM +0100, Alexander Graf wrote:
> I haven't really been maintaining any PowerPC code for quite a while now,
> so let's reflect reality: David does all the work and embedded PPC is in
> "Odd Fixes" state rather than supported now.
>=20
> Signed-off-by: Alexander Graf <agraf@suse.de>

Applied to ppc-for-3.1.

> ---
>  MAINTAINERS | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d794bd7a66..d1a6d3c740 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -230,7 +230,6 @@ F: tests/tcg/openrisc/
> =20
>  PowerPC
>  M: David Gibson <david@gibson.dropbear.id.au>
> -M: Alexander Graf <agraf@suse.de>
>  L: qemu-ppc@nongnu.org
>  S: Maintained
>  F: target/ppc/
> @@ -340,7 +339,7 @@ S: Maintained
>  F: target/mips/kvm.c
> =20
>  PPC
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  S: Maintained
>  F: target/ppc/kvm.c
> =20
> @@ -780,21 +779,21 @@ F: hw/openrisc/openrisc_sim.c
>  PowerPC Machines
>  ----------------
>  405
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/ppc/ppc405_boards.c
> =20
>  Bamboo
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/ppc/ppc440_bamboo.c
> =20
>  e500
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: hw/ppc/e500.[hc]
>  F: hw/ppc/e500plat.c
>  F: include/hw/ppc/ppc_e500.h
> @@ -802,16 +801,16 @@ F: include/hw/pci-host/ppce500.h
>  F: pc-bios/u-boot.e500
> =20
>  mpc8544ds
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: hw/ppc/mpc8544ds.c
>  F: hw/ppc/mpc8544_guts.c
> =20
>  New World
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/ppc/mac_newworld.c
>  F: hw/pci-host/uninorth.c
>  F: hw/pci-bridge/dec.[hc]
> @@ -823,9 +822,9 @@ F: include/hw/misc/mos6522.h
>  F: include/hw/ppc/mac_dbdma.h
> =20
>  Old World
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/ppc/mac_oldworld.c
>  F: hw/pci-host/grackle.c
>  F: hw/misc/macio/
> @@ -850,7 +849,6 @@ F: pc-bios/ppc_rom.bin
> =20
>  sPAPR
>  M: David Gibson <david@gibson.dropbear.id.au>
> -M: Alexander Graf <agraf@suse.de>
>  L: qemu-ppc@nongnu.org
>  S: Supported
>  F: hw/*/spapr*
> @@ -1117,7 +1115,7 @@ F: tests/bios-tables-test.c
>  F: tests/acpi-utils.[hc]
> =20
>  ppc4xx
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/ppc/ppc4*.c
> @@ -1126,9 +1124,9 @@ F: include/hw/ppc/ppc4xx.h
>  F: include/hw/i2c/ppc4xx_i2c.h
> =20
>  ppce500
> -M: Alexander Graf <agraf@suse.de>
> +M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
> -S: Supported
> +S: Odd Fixes
>  F: hw/ppc/e500*
>  F: hw/pci-host/ppce500.c
>  F: hw/net/fsl_etsec/

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlviSIQACgkQbDjKyiDZ
s5L5ww/8DuPKb8vYwRSRcXACg90YfJFR56CYcIWbIRWVoitqm7IExwuZlr8TjPQx
Ouk4aWU8McoMw4d5/F3FrpjIlvSKDGjbhkWB88TgRjpP7LslF5ias79fqWDTYdde
f4a2ElRUrCk41NfzZzISPsy9SaVl4H5VERND3RPstTAucpY0UcLg/X3DcHOhyF5G
kprHK2/ZNMkMWOJcNo7RmHkrLepwiSKs+okUgV1Bq2R3YDR2NvWdYR6dmh/PzYyi
sBX/8S63zaXQIWBJKqzdskQWCM0UfWrlSLUoaAFbLzOujBTIeetZj4kee89i3A5p
dkwC/QFDzoccFknd8Njn7kpWTQ5ietM0J3oyOXll0RKrFnNJpYPG0b7svleIJJwH
BM/7LajdvdaGWZ0h2C1xjxECFN3vzcw6IaCcLRBLkSFkA/BvI6DYWC5afHRUnYkT
5bG7tFWCzCKTbieAkHMAlXVytnR0BbthLf7p4O/ee+A9HhD/2lqWmJwYX5BSRwDP
MVftKY/CN97NiIybuXETIam3222GZJ7x5kobGUVBaL3XDQFSFBNtXSpGNFRRoWRe
6oZI+bF91wJzTaGQMbHXWTo3Vj6zkt9an9CJYZpxCvs47oGKASG/EgnrDbATiUR8
u/+LTlhd9+4xz3YRXv4dtY1RluwXuMJT7QHoiLCaaSUR/5rSNQ4=
=W6mO
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
