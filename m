Received: from eggs.gnu.org ([2001:4830:134:3::10]:37799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0M1y-0006C3-1g
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0M1u-0004j4-SU
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:22:42 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:41955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e0M1u-0004hx-Mb
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:22:38 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5A910138197
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 08:22:37 +0200 (CEST)
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-20-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <db4b87a1-75c1-3a99-1059-14dacc51f80f@kaod.org>
Date: Fri, 6 Oct 2017 08:22:32 +0200
MIME-Version: 1.0
In-Reply-To: <1507220690-265042-20-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 19/23] ppc: pnv: normalize
 core/chip type names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:ppce500" <qemu-ppc@nongnu.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>

On 10/05/2017 06:24 PM, Igor Mammedov wrote:
> typically for cpus/core type names following convention is used
>=20
>    new_type_prefix-superclass_typename
>=20
> make PNV core/chip to follow common convention.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

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
>=20
