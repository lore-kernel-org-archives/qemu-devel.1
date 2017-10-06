Received: from eggs.gnu.org ([2001:4830:134:3::10]:40331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OPI-0004X1-1Y
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OPE-0008E2-Vf
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:54:56 -0400
Date: Fri, 6 Oct 2017 19:37:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006083705.GX3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-20-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Swav0nNPrA3tWuBp"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-20-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 19/23] ppc: pnv: normalize core/chip type
 names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--Swav0nNPrA3tWuBp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:46PM +0200, Igor Mammedov wrote:
> typically for cpus/core type names following convention is used
>=20
>    new_type_prefix-superclass_typename
>=20
> make PNV core/chip to follow common convention.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/pnv.h      | 11 +++++++----
>  include/hw/ppc/pnv_core.h |  2 ++
>  hw/ppc/pnv.c              |  2 +-
>  hw/ppc/pnv_core.c         |  2 +-
>  4 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 2525f7f..d82eee1 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -80,19 +80,22 @@ typedef struct PnvChipClass {
>      uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
>  } PnvChipClass;
> =20
> -#define TYPE_PNV_CHIP_POWER8E TYPE_PNV_CHIP "-power8e_v2.1"
> +#define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
> +#define PNV_CHIP_TYPE_NAME(cpu_model) cpu_model PNV_CHIP_TYPE_SUFFIX
> +
> +#define TYPE_PNV_CHIP_POWER8E PNV_CHIP_TYPE_NAME("power8e_v2.1")
>  #define PNV_CHIP_POWER8E(obj) \
>      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8E)
> =20
> -#define TYPE_PNV_CHIP_POWER8 TYPE_PNV_CHIP "-power8_v2.0"
> +#define TYPE_PNV_CHIP_POWER8 PNV_CHIP_TYPE_NAME("power8_v2.0")
>  #define PNV_CHIP_POWER8(obj) \
>      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8)
> =20
> -#define TYPE_PNV_CHIP_POWER8NVL TYPE_PNV_CHIP "-power8nvl_v1.0"
> +#define TYPE_PNV_CHIP_POWER8NVL PNV_CHIP_TYPE_NAME("power8nvl_v1.0")
>  #define PNV_CHIP_POWER8NVL(obj) \
>      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER8NVL)
> =20
> -#define TYPE_PNV_CHIP_POWER9 TYPE_PNV_CHIP "-power9_v1.0"
> +#define TYPE_PNV_CHIP_POWER9 PNV_CHIP_TYPE_NAME("power9_v1.0")
>  #define PNV_CHIP_POWER9(obj) \
>      OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP_POWER9)
> =20
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 2955a41..3360c4b 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -45,6 +45,8 @@ typedef struct PnvCoreClass {
>      ObjectClass *cpu_oc;
>  } PnvCoreClass;
> =20
> +#define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
> +#define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
>  extern char *pnv_core_typename(const char *model);
> =20
>  #endif /* _PPC_PNV_CORE_H */
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 4169837..9c5eb7c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -609,7 +609,7 @@ static void ppc_powernv_init(MachineState *machine)
> =20
>      /* Create the processor chips */
>      i =3D strlen(machine->cpu_type) - strlen(POWERPC_CPU_TYPE_SUFFIX);
> -    chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%.*s",
> +    chip_typename =3D g_strdup_printf(PNV_CHIP_TYPE_NAME("%.*s"),
>                                      i, machine->cpu_type);
>      if (!object_class_by_name(chip_typename)) {
>          error_report("invalid CPU model '%.*s' for %s machine",
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 44b0b24..b3e3f23 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -252,5 +252,5 @@ type_init(pnv_core_register_types)
> =20
>  char *pnv_core_typename(const char *model)
>  {
> -    return g_strdup_printf(TYPE_PNV_CORE "-%s", model);
> +    return g_strdup_printf(PNV_CORE_TYPE_NAME("%s"), model);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Swav0nNPrA3tWuBp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXQLEACgkQbDjKyiDZ
s5IgAhAAyxCYkqnrw5Ryw0Zy9yBU6ZcMLYHPAoTtrogkc6OY4xHW7C8KgajO6b+O
3HB+GLIjJMy1nxxo6ECKyU+oNj5w7TLdM5QaPLeDSKf4rWFyT30T1CoohGB1g94e
g6MHKk+xtHyfYQQq4k97C3yIl1mOac/jfOI4G5WmvBHrxW+gG/spD8JR7+ostS+q
y2hYMJbM1ay5LxRFepK1U1Ymc2ZLQqhvH60RLEHdR9VLgmeBwvS4DrblbQcOxHeI
RkPMBUxHTMtS54DlnYRtUq2sImWVf/80Dd2zb0Xq+418E30vvFlvv56PPtN5+kWl
LuTgXut/uHFhjj3AwNQZzOUXzZUakcxBO3XfMPiDF3aK3M9FpSHGJBipZgS8sL+Q
X6j5nWx6X/iLtIloAA3ozQCTGmKfLXfYdO1HamKwLQSCNr3D+YeCrVnR24vWqI3q
K7rO3RZCIIzSYs149uA8DlCweRZ+r0l7fSmVk5iLrguJCPerc87Q+sm0jtamYwIB
TfuFB0sw4qegi/IhremZzo2EPWkGit3bWUdF1T/c+6UCb/F8qBdJV2H5+0N5mZA6
pG/0kVSQf7EdqBoiojC4W2fZAg0+/XyV1Ndym+4oKWjWO08CWGdAExZNmn81PQ/1
Y2n7J3vwerT2dMtQSyJMOBfu/NEGL0UTL4+YOV3/YRQhgDKRRpY=
=2VRF
-----END PGP SIGNATURE-----

--Swav0nNPrA3tWuBp--
