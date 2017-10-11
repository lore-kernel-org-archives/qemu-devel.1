Received: from eggs.gnu.org ([2001:4830:134:3::10]:36786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e2Ams-00089n-5j
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 02:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e2Amp-0004Lv-2a
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 02:46:38 -0400
Date: Wed, 11 Oct 2017 17:41:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171011064123.GE10496@umbus.fritz.box>
References: <20171009154930.29095-1-clg@kaod.org>
	<20171009154930.29095-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
In-Reply-To: <20171009154930.29095-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] target/ppc: export
 ppc_cpu_pvr_match() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2017 at 05:49:27PM +0200, C=E9dric Le Goater wrote:
> It will be used to test the family of a CPU.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I don't think this is useful, see comments on later patches.

> ---
>  include/hw/ppc/ppc.h | 1 +
>  target/ppc/machine.c | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
> index 4e7fe110d67b..01e32fa03d2e 100644
> --- a/include/hw/ppc/ppc.h
> +++ b/include/hw/ppc/ppc.h
> @@ -107,4 +107,5 @@ enum {
>  void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flag=
s);
> =20
>  void ppc_cpu_parse_features(const char *cpu_model);
> +bool ppc_cpu_pvr_match(PowerPCCPU *cpu, uint32_t pvr);
>  #endif
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 384caee800e6..6085a8c25fd3 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -4,6 +4,7 @@
>  #include "exec/exec-all.h"
>  #include "hw/hw.h"
>  #include "hw/boards.h"
> +#include "hw/ppc/ppc.h"
>  #include "sysemu/kvm.h"
>  #include "helper_regs.h"
>  #include "mmu-hash64.h"
> @@ -210,7 +211,7 @@ static int cpu_pre_save(void *opaque)
>   * between sufficiently similar PVRs, as determined by the CPU class's
>   * pvr_match() hook.
>   */
> -static bool pvr_match(PowerPCCPU *cpu, uint32_t pvr)
> +bool ppc_cpu_pvr_match(PowerPCCPU *cpu, uint32_t pvr)
>  {
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
> @@ -247,7 +248,7 @@ static int cpu_post_load(void *opaque, int version_id)
>      } else
>  #endif
>      {
> -        if (!pvr_match(cpu, env->spr[SPR_PVR])) {
> +        if (!ppc_cpu_pvr_match(cpu, env->spr[SPR_PVR])) {
>              return -1;
>          }
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlndvRMACgkQbDjKyiDZ
s5KJxxAAqeWc4lZFLsTIgQ2e2DK9OReOwCYYCuSxZafGa1L522UNGwoL9J/GwCBn
iB7xwE/fOauUo3/8AxioEZPl9Xqz5/XyV6eAd05lqA6X3/3w6ymd2KZhm3sTCkPq
Mo6rhe90/S02rcLUQVu2jkBpaFP7BeOWaKWJ48BwPBlN6QyE5ooosjo8D3V+ZL4x
demn9wMXa4V1R85GpoTWGZO8XuaMXxZtamisx5gZed4Jqvea4ozEFQSn+Qky/ubO
I21gM8YciFq4QPQ6uizuds5/xEfPDB2i2Juj/8S2UUl3IP+J80rVsDDGrftOcksR
zxlEVRj+vlousQU/vpiyGQfIwlR7NbaV6bNdYb59nHF4VTOEs8bvvF4ldao7Ipmh
WrZzfqUP2cYJ+pF9oH5ySzErIJkMn5McAA0p13EEwREO4payNpE9pHFkCfLYlUL/
8XePGVZpxaEG3aSce/GEyfqDDcmONHvwTylGFU8VZBTXPeMIGRVoDnZaL7LQiQnr
+QmDlLAdcC+bAzz+e79kxmv5MmX9jMCWNvTKXvO0lmP+Q/pSOB3M/0g5Qil6sISf
l4h03rbc/rkeTter8kt/ZkZ09zGR7F1CT2m1evoasN6E7Or66gJhwRuXqka4hpK9
MSGU/vj1EWEtS1jbYW55NVy3xf7Y+qTV/bGDUUpu603zOnQifV4=
=L9nQ
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
