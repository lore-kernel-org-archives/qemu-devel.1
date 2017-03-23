Received: from eggs.gnu.org ([2001:4830:134:3::10]:45939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEs-0001ri-M3
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEr-0005oF-8i
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:42 -0400
Date: Thu, 23 Mar 2017 15:16:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170323041633.GJ19078@umbus.fritz.box>
References: <1489674912-21942-1-git-send-email-clg@kaod.org>
	<1489674912-21942-7-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3bvv0EcKsvvYeex"
Content-Disposition: inline
In-Reply-To: <1489674912-21942-7-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 6/8] ppc/pnv: add a helper to calculate
 MMIO addresses registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--u3bvv0EcKsvvYeex
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 03:35:10PM +0100, C=E9dric Le Goater wrote:
> Some controllers (ICP, PSI) have a base register address which is
> calculated using the chip id.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/pnv.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index d6ef04771aff..cfd059fc49db 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -92,14 +92,24 @@ typedef struct PnvChipClass {
>      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER9)
> =20
>  /*
> - * This generates a HW chip id depending on an index:
> + * This generates a HW chip id depending on an index, as found on a
> + * two socket system with dual chip modules :
>   *
>   *    0x0, 0x1, 0x10, 0x11
>   *
>   * 4 chips should be the maximum
> + *
> + * TODO: use a machine property to define the chip ids
>   */
>  #define PNV_CHIP_HWID(i) ((((i) & 0x3e) << 3) | ((i) & 0x1))
> =20
> +/*
> + * Converts back a HW chip id to an index. This is useful to calculate
> + * the MMIO addresses of some controllers which depend on the chip id.
> + */
> +#define PNV_CHIP_INDEX(chip)                                    \
> +    (((chip)->chip_id >> 2) * 2 + ((chip)->chip_id & 0x3))
> +
>  #define TYPE_POWERNV_MACHINE       MACHINE_TYPE_NAME("powernv")
>  #define POWERNV_MACHINE(obj) \
>      OBJECT_CHECK(PnvMachineState, (obj), TYPE_POWERNV_MACHINE)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u3bvv0EcKsvvYeex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY00whAAoJEGw4ysog2bOSX4kQAJovAI9tS1WRUz6NY4K4KBxT
fzmeYMt9k94Q4BN5Avj1lDtqLOV1azwRTAJtKdSm7jfbmpS6FAwYwP0qzn2qyq5K
L5KVsxFNGIiwRSKcGt5GmjxPn0WRTezS34FNsTuDQ20j1rGty+QDnTDpjmnerO2k
8r5Ssbv+dbgHwlssbNFmI+cJM/23FJS7D2yHLEEDW7bwBvbqG9yAhRKUOYRmkkt8
dkwAbgJ8H4eqBgKUxF5IxOxIOV7PQqpS/pY/hRwTokJIocvsvlgLppUMgjvC5i+P
addzGduni7vnCyXJi31qsgol1hgekbRTEOkrlMDNUINGW3Skubxc/pI9mmCpsBcZ
jq4dJCQaA8/do782JFM5zFM8ZUgiFSCWR/rmaShqZ/PfQKvNI45hQydyKecvc8PM
LuXXJqQoZbwFnv7iHfgId1fJ8RXNjTd4D85wkck2TbUnUPGe3wb74KWaf7T16c2k
ANB+liE1tV3Q/d8uLJdFhEc0MuJ3synpZuyraeFMfwSvyXgMvISIJQLmZkQMcIaI
MIww4YidWhlehs7FE6Mf4obauT9TuQ5wdqcTW9OUhz/bUUffI2AhGavsRyopFEWy
Z84V0OER17l0x5kPWw8pTPce3ott3ovo0YygUrEMFtFKR+4ZRzSGBBmhaDv0RnS6
tHshq1MnBcHVw4Mm3sXD
=vHQ9
-----END PGP SIGNATURE-----

--u3bvv0EcKsvvYeex--
