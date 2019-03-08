Received: from eggs.gnu.org ([209.51.188.92]:42244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240N-0006FA-GW
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240K-0000zt-BL
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:54 -0500
Date: Fri, 8 Mar 2019 11:58:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308005835.GR7722@umbus.fritz.box>
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-15-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bpNGSkw8ExqLHKDe"
Content-Disposition: inline
In-Reply-To: <20190307223548.20516-15-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 14/15] ppc/pnv: add a "ibm,
 opal/power-mgt" device tree node on POWER9
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


--bpNGSkw8ExqLHKDe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:35:47PM +0100, C=E9dric Le Goater wrote:
> Activate only stop0 and stop1 levels. We should not need more levels
> when under QEMU.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, although..

> ---
>  hw/ppc/pnv.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index e68d419203e8..8be4d4cbf785 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -438,6 +438,16 @@ static void pnv_dt_isa(PnvMachineState *pnv, void *f=
dt)
>                         &args);
>  }
> =20
> +static void pnv_dt_power_mgt(void *fdt)
> +{
> +    int off;
> +
> +    off =3D fdt_add_subnode(fdt, 0, "ibm,opal");
> +    off =3D fdt_add_subnode(fdt, off, "power-mgt");
> +
> +    _FDT(fdt_setprop_cell(fdt, off, "ibm,enabled-stop-levels", 0xc000000=
0));
> +}
> +
>  static void *pnv_dt_create(MachineState *machine)
>  {
>      const char plat_compat[] =3D "qemu,powernv\0ibm,powernv";
> @@ -493,6 +503,11 @@ static void *pnv_dt_create(MachineState *machine)
>          pnv_dt_bmc_sensors(pnv->bmc, fdt);
>      }
> =20
> +    /* Create an extra node for power management on Power9 */
> +    if (pnv_is_power9(pnv)) {

=2E. as always, I think specific code calling generic helpers is a
better pattern than generic code conditionally calling specific details.

> +        pnv_dt_power_mgt(fdt);
> +    }
> +
>      return fdt;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bpNGSkw8ExqLHKDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBvjsACgkQbDjKyiDZ
s5J/LBAA2/iG4A3JVjY70w2g9/7l6IHOU2fS1bGf6HAOC5mdZsO3a2proWvj8Oky
/QZmh9WRCmTpd0MwK/eG6E50q7pJRyCvlU4lAJpnE39FFNVJgXKarebrpQouNmHR
298bh7NozI1pYlkJ4JxvBhvxwevsRai4mpA6woI+m+yKDu/C/l9psbhq2saz1n/+
5enrApEeInpuEGS07ffGMra5dpQd8tVO9tLAG9UilDEodIHp+E5h06k4oV4tnW7/
GZXfG/scyZnbnyYy4L9/vz5OiKGiHDv2eXm+CNwyaRKnTsjU1lo5OcuY0iCYtXh1
pTFtVtboXUEbXKn9oLe8DEh+6a2XiWwXo8mpgBVc2A9l3kVrGWnkRks6Us/8Ug2s
s7CaorxdPOeAARKzmMPJh28ExQ/sm2SR7P7vggEDetJL31LdShZbNtFlX3fwYBbg
5cqGGmOvdJ05qjMH2e+RBU3xSQjVCJteML83KMD208fborCHIzKisMabYYSApwW+
3AbC1+lCL+KDOqzTnBI0nOzwxVQPWdF8rwSY9OETYHEXNnbaqQTb9XXD+jbhTLCx
TVsW8FuDhs4LcNF3l2f2C+0wkBafCR+z8dOn8BCuDGqzhdQx0smaV7sZqbNl9h4x
IpsgqWi1Hrxd/3Y5Y1J0O8y7TmkfXRxY2hC0aBkdTSjxRW4vUAc=
=/Rek
-----END PGP SIGNATURE-----

--bpNGSkw8ExqLHKDe--
