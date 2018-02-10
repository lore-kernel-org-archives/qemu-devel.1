Received: from eggs.gnu.org ([2001:4830:134:3::10]:47056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekJ91-0006QU-Tv
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 19:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekJ90-0000s8-Uw
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 19:35:55 -0500
Date: Sat, 10 Feb 2018 11:16:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210001647.GJ11634@umbus.fritz.box>
References: <20180209181330.17371-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AXxEqdD4tcVTjWte"
Content-Disposition: inline
In-Reply-To: <20180209181330.17371-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/ppc: rename functions in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--AXxEqdD4tcVTjWte
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 04:13:30PM -0200, Daniel Henrique Barboza wrote:
> Commit bcb5ce08cf ("spapr: Rename machine init functions for clarity")
> renamed ppc_spapr_reset to spapr_machine_reset and ppc_spapr_init
> to spapr_machine_init. Let's also rename the references in
> comments.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Nice catch, applied.


> ---
>  hw/ppc/spapr.c       | 3 ++-
>  hw/ppc/spapr_hcall.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 659be6b746..96515036e6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -464,7 +464,8 @@ static int spapr_populate_memory(sPAPRMachineState *s=
papr, void *fdt)
>              }
>          }
>          if (!mem_start) {
> -            /* ppc_spapr_init() checks for rma_size <=3D node0_size alre=
ady */
> +            /* spapr_machine_init() checks for rma_size <=3D node0_size
> +             * already */
>              spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
>              mem_start +=3D spapr->rma_size;
>              node_size -=3D spapr->rma_size;
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 4d0e6eb0cf..badf01cece 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1635,7 +1635,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      spapr->cas_legacy_guest_workaround =3D !spapr_ovec_test(ov1_guest,
>                                                            OV1_PPC_3_00);
>      if (!spapr->cas_reboot) {
> -        /* If ppc_spapr_reset() did not set up a HPT but one is necessary
> +        /* If spapr_machine_reset() did not set up a HPT but one is nece=
ssary
>           * (because the guest isn't going to use radix) then set it up h=
ere. */
>          if ((spapr->patb_entry & PATBE1_GR) && !guest_radix) {
>              /* legacy hash or new hash: */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AXxEqdD4tcVTjWte
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp+OewACgkQbDjKyiDZ
s5JdsRAAppaEV55PUVLYUmxn6fdvgtUv61QAK6BXwHSpIoML+MMsybVpG6NXFODB
f7q6dNrB9c033eEg0ChC8R4NXaIFda/E5iv//dHG1A7XVWZLxBqJ4+F4uxgZ61Hw
xMLDBtmbjj5VI34lsbEfd6JxJeXaYFGzCUSXP/XVV7AfYejLcQKqQvE1Nkq44TJr
F5oxZFL44xeQXPPsSW5Vc5npZQeh2VYD94LEXEo2qeomfrwIRKZCraijF7VqxiGU
X1sGnETnbvO3E7dH+sd+9bUQq76vEntIZI6tcKMVemcOnVC9Uh1UsZkiZ+UJ11yC
Nqd9rd0TCd5nP73Gn8DRzYt1ZyRxcRd7r6FxkK7H3VphMGyrfJb6r5NPzicjABnf
JVOdhsYFeCeQ0A6LR7QJYEfGKfg4UeFGow4YewNsHA3RduPE2vg70JzfQg9vfDJz
u7if67tFGpXD/7hFtCFUMRTz+m2cE2FchHQhy7xl4GlkRghmWgeaVlZP3f34y/2P
c2oC9DQSSMCH9x2Z+P+3ZK4kBPlh0vyTOSbbaq5OiVzOo5SGv982/PDTEFfee/k1
KGqIafcVEPJvrwD1DPqxvgebrev0/jLh5+ieCenKtzHpZ1ULO0dfqb8F0G5vLyjP
2lbnN4yJUuOJH1V5x/MQztoW3hyVoIdNwhsKbaWoiYIafCkeX4g=
=jg3b
-----END PGP SIGNATURE-----

--AXxEqdD4tcVTjWte--
