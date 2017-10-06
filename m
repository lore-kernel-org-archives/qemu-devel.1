Received: from eggs.gnu.org ([2001:4830:134:3::10]:39002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0M6e-0008Dk-9z
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0M6b-0000PU-5m
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:27:32 -0400
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:46419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e0M6a-0000OE-SL
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:27:29 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 8361D138182
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 08:27:27 +0200 (CEST)
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-24-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b7fa915e-4175-7b59-db96-41814f8189e3@kaod.org>
Date: Fri, 6 Oct 2017 08:27:22 +0200
MIME-Version: 1.0
In-Reply-To: <1507220690-265042-24-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 23/23] ppc: pnv: consolidate
 type definitions and batch register them
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
> Use a new DEFINE_TYPES() helper to simplify type registration
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/pnv.c | 92 ++++++++++++++++++++++------------------------------=
--------
>  1 file changed, 34 insertions(+), 58 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index ab7083b..e23dc3c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -730,13 +730,6 @@ static void pnv_chip_power8e_class_init(ObjectClas=
s *klass, void *data)
>      dc->desc =3D "PowerNV Chip POWER8E";
>  }
> =20
> -static const TypeInfo pnv_chip_power8e_info =3D {
> -    .name          =3D TYPE_PNV_CHIP_POWER8E,
> -    .parent        =3D TYPE_PNV_CHIP,
> -    .instance_size =3D sizeof(PnvChip),
> -    .class_init    =3D pnv_chip_power8e_class_init,
> -};
> -
>  static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -751,13 +744,6 @@ static void pnv_chip_power8_class_init(ObjectClass=
 *klass, void *data)
>      dc->desc =3D "PowerNV Chip POWER8";
>  }
> =20
> -static const TypeInfo pnv_chip_power8_info =3D {
> -    .name          =3D TYPE_PNV_CHIP_POWER8,
> -    .parent        =3D TYPE_PNV_CHIP,
> -    .instance_size =3D sizeof(PnvChip),
> -    .class_init    =3D pnv_chip_power8_class_init,
> -};
> -
>  static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *da=
ta)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -772,13 +758,6 @@ static void pnv_chip_power8nvl_class_init(ObjectCl=
ass *klass, void *data)
>      dc->desc =3D "PowerNV Chip POWER8NVL";
>  }
> =20
> -static const TypeInfo pnv_chip_power8nvl_info =3D {
> -    .name          =3D TYPE_PNV_CHIP_POWER8NVL,
> -    .parent        =3D TYPE_PNV_CHIP,
> -    .instance_size =3D sizeof(PnvChip),
> -    .class_init    =3D pnv_chip_power8nvl_class_init,
> -};
> -
>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -793,13 +772,6 @@ static void pnv_chip_power9_class_init(ObjectClass=
 *klass, void *data)
>      dc->desc =3D "PowerNV Chip POWER9";
>  }
> =20
> -static const TypeInfo pnv_chip_power9_info =3D {
> -    .name          =3D TYPE_PNV_CHIP_POWER9,
> -    .parent        =3D TYPE_PNV_CHIP,
> -    .instance_size =3D sizeof(PnvChip),
> -    .class_init    =3D pnv_chip_power9_class_init,
> -};
> -
>  static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
>  {
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> @@ -1001,15 +973,6 @@ static void pnv_chip_class_init(ObjectClass *klas=
s, void *data)
>      dc->desc =3D "PowerNV Chip";
>  }
> =20
> -static const TypeInfo pnv_chip_info =3D {
> -    .name          =3D TYPE_PNV_CHIP,
> -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> -    .class_init    =3D pnv_chip_class_init,
> -    .instance_init =3D pnv_chip_init,
> -    .class_size    =3D sizeof(PnvChipClass),
> -    .abstract      =3D true,
> -};
> -
>  static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
>  {
>      PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> @@ -1145,27 +1108,40 @@ static void powernv_machine_class_init(ObjectCl=
ass *oc, void *data)
>      powernv_machine_class_props_init(oc);
>  }
> =20
> -static const TypeInfo powernv_machine_info =3D {
> -    .name          =3D TYPE_POWERNV_MACHINE,
> -    .parent        =3D TYPE_MACHINE,
> -    .instance_size =3D sizeof(PnvMachineState),
> -    .instance_init =3D powernv_machine_initfn,
> -    .class_init    =3D powernv_machine_class_init,
> -    .interfaces =3D (InterfaceInfo[]) {
> -        { TYPE_XICS_FABRIC },
> -        { TYPE_INTERRUPT_STATS_PROVIDER },
> -        { },
> +#define DEFINE_PNV_CHIP_TYPE(type, class_initfn) \
> +    {                                            \
> +        .name          =3D type,                   \
> +        .class_init    =3D class_initfn,           \
> +        .parent        =3D TYPE_PNV_CHIP,          \
> +    }
> +
> +static const TypeInfo types[] =3D {
> +    {
> +        .name          =3D TYPE_POWERNV_MACHINE,
> +        .parent        =3D TYPE_MACHINE,
> +        .instance_size =3D sizeof(PnvMachineState),
> +        .instance_init =3D powernv_machine_initfn,
> +        .class_init    =3D powernv_machine_class_init,
> +        .interfaces =3D (InterfaceInfo[]) {
> +            { TYPE_XICS_FABRIC },
> +            { TYPE_INTERRUPT_STATS_PROVIDER },
> +            { },
> +        },
>      },
> +    {
> +        .name          =3D TYPE_PNV_CHIP,
> +        .parent        =3D TYPE_SYS_BUS_DEVICE,
> +        .class_init    =3D pnv_chip_class_init,
> +        .instance_init =3D pnv_chip_init,
> +        .instance_size =3D sizeof(PnvChip),
> +        .class_size    =3D sizeof(PnvChipClass),
> +        .abstract      =3D true,
> +    },
> +    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER9, pnv_chip_power9_class_i=
nit),
> +    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_i=
nit),
> +    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_class=
_init),
> +    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
> +                         pnv_chip_power8nvl_class_init),
>  };
> =20
> -static void powernv_machine_register_types(void)
> -{
> -    type_register_static(&powernv_machine_info);
> -    type_register_static(&pnv_chip_info);
> -    type_register_static(&pnv_chip_power8e_info);
> -    type_register_static(&pnv_chip_power8_info);
> -    type_register_static(&pnv_chip_power8nvl_info);
> -    type_register_static(&pnv_chip_power9_info);
> -}
> -
> -type_init(powernv_machine_register_types)
> +DEFINE_TYPES(types)
>=20
