Received: from eggs.gnu.org ([2001:4830:134:3::10]:60792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fShkE-0006LT-RP
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fShkA-0002hM-Ly
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:45:50 -0400
Date: Tue, 12 Jun 2018 21:19:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612111928.GG30690@umbus.fritz.box>
References: <20180612051630.17854-1-sjitindarsingh@gmail.com>
	<20180612051630.17854-2-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Content-Disposition: inline
In-Reply-To: <20180612051630.17854-2-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V2 2/2] ppc/spapr_caps: Don't
 disable cap_cfpc on POWER8 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, muriloo@linux.ibm.com


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 03:16:30PM +1000, Suraj Jitindar Singh wrote:
> In default_caps_with_cpu() we set spapr_cap_cfpc to broken for POWER8
> processors and before.
>=20
> Since we no longer require private l1d cache on POWER8 for this cap to
> be set to workaround change this to default to broken for POWER7
> processors and before.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to ppc-for-3.0, thanks.

>=20
> ---
>=20
> V1 -> V2:
> - No Change
>=20
> ---
>  hw/ppc/spapr_caps.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 531e145114..00e43a9ba7 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -335,14 +335,10 @@ static sPAPRCapabilities default_caps_with_cpu(sPAP=
RMachineState *spapr,
> =20
>      caps =3D smc->default_caps;
> =20
> -    if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00,
> -                          0, spapr->max_compat_pvr)) {
> -        caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
> -    }
> -
>      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
>                            0, spapr->max_compat_pvr)) {
>          caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> +        caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
>      }
> =20
>      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06_PLUS,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfrEAACgkQbDjKyiDZ
s5KQqg/+JLFVCIwUyDCCBjnEwBNt/3MXMOvzPQEVgJ24xbW3WQk0bTOIlwz9XHGk
//h7pXpHP8SPuJ+fbHAH4xxaCqEejlcEG2nUsiWj5zTrsWoxM8Cc4j8l+0Vxmwyv
lat56QTM3eclGfhPqd4+ZengegxPSsBYHy1kcQx1k0vCNKfTPXSoIlA5ueactiiO
AisL9ZggDfIdhozEoMI7XEfvFz6XWENTen9+x9TtHKTGFu0b2TpBCTPoyfleERPa
t8l7zrkcOBCTqpvVJ6XiYYhAxkKapbchDSrsPnA6/VMVqZgC/GV9YRrVQWfyp8sz
lzlrdUCN3Kw3YkQHIWU+4DTkOL5G2WYMUpQ2jKtmvEQwW0m5PB4XqDHrKdtCA5PS
L4ORoGTH6PwNmzzc8jrmM9aV5QyJeSTs7rFw+Dwn9Yu5ko99RK1NN4rPg3PclBA3
Op9sOFr2ZRwY3gEIoVvwEm/bdUeCMEpQZFRXrbHo8bEHpoUamSdU0DKEGVPC+nw/
vSBLRX1c9K6aty0wyvQo84y+4LDE2oLjobDWEdZuM/EyCDbtcYBnj/4g0pGywRVs
XjcfQpvSsBNjc72xn1ZftURngq76qIMhCwRJ7+g3GNb8xXzWy+o3pQpmWiTMcyVZ
1GS6YS6K4+1qGTBrbcMKxVitlEWd54O6ZYa/EjYmMTczJhAmcnY=
=L6At
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--
