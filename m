Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEB0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E75205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E75205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbP4K-0005N5-MB
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jbP3e-0004pV-Qc
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:46:54 -0400
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:44090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jbP3d-0006Cw-CQ
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:46:54 -0400
Received: from player760.ha.ovh.net (unknown [10.108.54.230])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 593B08B77B
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 15:46:49 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player760.ha.ovh.net (Postfix) with ESMTPSA id 01FF112923907;
 Wed, 20 May 2020 13:46:44 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004f849baba-d057-423c-b5b7-a8eb20b7bff8,D4AE9CB3A4750E3488E7135F1D4D455A9A9A4933)
 smtp.auth=groug@kaod.org
Date: Wed, 20 May 2020 15:46:43 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 8/9] ppc/pnv: Add model for POWER9 PHB5 PCIe Host bridge
Message-ID: <20200520154643.5dbb3ea3@bahia.lan>
In-Reply-To: <20200513151109.453530-9-clg@kaod.org>
References: <20200513151109.453530-1-clg@kaod.org>
 <20200513151109.453530-9-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 3803289889156209035
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddtledgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueekjeekiefffedtveeukedvteejgeeivefhgfejgfdtleduvdfgfeelkeeuveeunecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejiedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.50.107; envelope-from=groug@kaod.org;
 helo=6.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 09:46:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I guess you mean POWER10 ?

On Wed, 13 May 2020 17:11:08 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> PHB4 and PHB5 are very similar. Use the PHB4 models with some minor
> adjustements in a subclass for P10.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/pci-host/pnv_phb4.h |  11 ++++
>  include/hw/ppc/pnv.h           |   3 +
>  include/hw/ppc/pnv_xscom.h     |   6 ++
>  hw/pci-host/pnv_phb4_pec.c     |  44 ++++++++++++++
>  hw/ppc/pnv.c                   | 101 +++++++++++++++++++++++++++++++++
>  5 files changed, 165 insertions(+)
>=20
> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb=
4.h
> index c882bfd0aa23..ea3810f74066 100644
> --- a/include/hw/pci-host/pnv_phb4.h
> +++ b/include/hw/pci-host/pnv_phb4.h
> @@ -227,4 +227,15 @@ typedef struct PnvPhb4PecClass {
>      int stk_compat_size;
>  } PnvPhb4PecClass;
> =20
> +/*
> + * POWER10 definitions
> + */
> +
> +#define PNV_PHB5_VERSION           0x000000a500000001ull
> +#define PNV_PHB5_DEVICE_ID         0x0652
> +
> +#define TYPE_PNV_PHB5_PEC "pnv-phb5-pec"
> +#define PNV_PHB5_PEC(obj) \
> +    OBJECT_CHECK(PnvPhb4PecState, (obj), TYPE_PNV_PHB5_PEC)
> +
>  #endif /* PCI_HOST_PNV_PHB4_H */
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 86bfa2107a8c..516229a51e7b 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -127,6 +127,9 @@ typedef struct Pnv10Chip {
>      uint32_t     nr_quads;
>      PnvQuad      *quads;
> =20
> +#define PNV10_CHIP_MAX_PEC 2
> +    PnvPhb4PecState pecs[PNV10_CHIP_MAX_PEC];
> +
>  } Pnv10Chip;
> =20
>  #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index f26c5217764d..433c7b878af4 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -139,6 +139,12 @@ typedef struct PnvXScomInterfaceClass {
>  #define PNV10_XSCOM_XIVE2_BASE     0x2010800
>  #define PNV10_XSCOM_XIVE2_SIZE     0x400
> =20
> +#define PNV10_XSCOM_PEC_NEST_BASE  0x3011800 /* index goes downwards ...=
 */
> +#define PNV10_XSCOM_PEC_NEST_SIZE  0x100
> +
> +#define PNV10_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes upwards ... */
> +#define PNV10_XSCOM_PEC_PCI_SIZE   0x200
> +
>  void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp);
>  int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
>                   uint64_t xscom_base, uint64_t xscom_size,
> diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
> index 911d147ffd7d..869fd77b62cc 100644
> --- a/hw/pci-host/pnv_phb4_pec.c
> +++ b/hw/pci-host/pnv_phb4_pec.c
> @@ -586,9 +586,53 @@ static const TypeInfo pnv_pec_stk_type_info =3D {
>      }
>  };
> =20
> +/*
> + * POWER10 definitions
> + */
> +
> +static uint32_t pnv_phb5_pec_xscom_pci_base(PnvPhb4PecState *pec)
> +{
> +    return PNV10_XSCOM_PEC_PCI_BASE + 0x1000000 * pec->index;
> +}
> +
> +static uint32_t pnv_phb5_pec_xscom_nest_base(PnvPhb4PecState *pec)
> +{
> +    /* index goes down ... */
> +    return PNV10_XSCOM_PEC_NEST_BASE - 0x1000000 * pec->index;
> +}
> +
> +static void pnv_phb5_pec_class_init(ObjectClass *klass, void *data)
> +{
> +    PnvPhb4PecClass *pecc =3D PNV_PHB4_PEC_CLASS(klass);
> +    static const char compat[] =3D "ibm,power10-pbcq";
> +    static const char stk_compat[] =3D "ibm,power10-phb-stack";
> +
> +    pecc->xscom_nest_base =3D pnv_phb5_pec_xscom_nest_base;
> +    pecc->xscom_pci_base  =3D pnv_phb5_pec_xscom_pci_base;
> +    pecc->xscom_nest_size =3D PNV10_XSCOM_PEC_NEST_SIZE;
> +    pecc->xscom_pci_size  =3D PNV10_XSCOM_PEC_PCI_SIZE;
> +    pecc->compat =3D compat;
> +    pecc->compat_size =3D sizeof(compat);
> +    pecc->stk_compat =3D stk_compat;
> +    pecc->stk_compat_size =3D sizeof(stk_compat);
> +}
> +
> +static const TypeInfo pnv_phb5_pec_type_info =3D {
> +    .name          =3D TYPE_PNV_PHB5_PEC,
> +    .parent        =3D TYPE_PNV_PHB4_PEC,
> +    .instance_size =3D sizeof(PnvPhb4PecState),
> +    .class_init    =3D pnv_phb5_pec_class_init,
> +    .class_size    =3D sizeof(PnvPhb4PecClass),
> +    .interfaces    =3D (InterfaceInfo[]) {
> +        { TYPE_PNV_XSCOM_INTERFACE },
> +        { }
> +    }
> +};
> +
>  static void pnv_pec_register_types(void)
>  {
>      type_register_static(&pnv_pec_type_info);
> +    type_register_static(&pnv_phb5_pec_type_info);
>      type_register_static(&pnv_pec_stk_type_info);
>  }
> =20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index fc751dd575d4..ac4bd2a17a9e 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -705,9 +705,17 @@ static void pnv_ipmi_bt_init(ISABus *bus, IPMIBmc *b=
mc, uint32_t irq)
>  static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
>  {
>      Pnv10Chip *chip10 =3D PNV10_CHIP(chip);
> +    int i, j;
> =20
>      pnv_xive2_pic_print_info(&chip10->xive, mon);
>      pnv_psi_pic_print_info(&chip10->psi, mon);
> +
> +    for (i =3D 0; i < PNV10_CHIP_MAX_PEC; i++) {
> +        PnvPhb4PecState *pec =3D &chip10->pecs[i];
> +        for (j =3D 0; j < pec->num_stacks; j++) {
> +            pnv_phb4_pic_print_info(&pec->stacks[j].phb, mon);
> +        }
> +    }
>  }
> =20
>  static void pnv_init(MachineState *machine)
> @@ -1607,7 +1615,10 @@ static void pnv_chip_power9_class_init(ObjectClass=
 *klass, void *data)
> =20
>  static void pnv_chip_power10_instance_init(Object *obj)
>  {
> +    PnvChip *chip =3D PNV_CHIP(obj);
>      Pnv10Chip *chip10 =3D PNV10_CHIP(obj);
> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(obj);
> +    int i;
> =20
>      object_initialize_child(obj, "xive", &chip10->xive, sizeof(chip10->x=
ive),
>                              TYPE_PNV_XIVE2, &error_abort, NULL);
> @@ -1619,6 +1630,17 @@ static void pnv_chip_power10_instance_init(Object =
*obj)
>                              TYPE_PNV10_LPC, &error_abort, NULL);
>      object_initialize_child(obj, "occ",  &chip10->occ, sizeof(chip10->oc=
c),
>                              TYPE_PNV10_OCC, &error_abort, NULL);
> +
> +    for (i =3D 0; i < PNV10_CHIP_MAX_PEC; i++) {
> +        object_initialize_child(obj, "pec[*]", &chip10->pecs[i],
> +                                sizeof(chip10->pecs[i]), TYPE_PNV_PHB5_P=
EC,
> +                                &error_abort, NULL);
> +    }
> +
> +    /*
> +     * Number of PHBs is the chip default
> +     */
> +    chip->num_phbs =3D pcc->num_phbs;
>  }
> =20
> =20
> @@ -1648,6 +1670,77 @@ static void pnv_chip_power10_quad_realize(Pnv10Chi=
p *chip10, Error **errp)
>      }
>  }
> =20
> +static void pnv_chip_power10_phb_realize(PnvChip *chip, Error **errp)
> +{
> +    Pnv10Chip *chip10 =3D PNV10_CHIP(chip);
> +    Error *local_err =3D NULL;
> +    int i, j;
> +    int phb_id =3D 0;
> +
> +    for (i =3D 0; i < PNV10_CHIP_MAX_PEC; i++) {
> +        PnvPhb4PecState *pec =3D &chip10->pecs[i];
> +        PnvPhb4PecClass *pecc =3D PNV_PHB4_PEC_GET_CLASS(pec);
> +        uint32_t pec_nest_base;
> +        uint32_t pec_pci_base;
> +
> +        object_property_set_int(OBJECT(pec), i, "index", &error_fatal);
> +        /*
> +         * PEC0 -> 3 stacks
> +         * PEC1 -> 3 stacks
> +         */
> +        object_property_set_int(OBJECT(pec), 3, "num-stacks",
> +                                &error_fatal);
> +        object_property_set_int(OBJECT(pec), chip->chip_id, "chip-id",
> +                                 &error_fatal);
> +        object_property_set_link(OBJECT(pec), OBJECT(get_system_memory()=
),
> +                                 "system-memory", &error_abort);
> +        object_property_set_bool(OBJECT(pec), true, "realized", &local_e=
rr);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +
> +        pec_nest_base =3D pecc->xscom_nest_base(pec);
> +        pec_pci_base =3D pecc->xscom_pci_base(pec);
> +
> +        pnv_xscom_add_subregion(chip, pec_nest_base, &pec->nest_regs_mr);
> +        pnv_xscom_add_subregion(chip, pec_pci_base, &pec->pci_regs_mr);
> +
> +        for (j =3D 0; j < pec->num_stacks && phb_id < chip->num_phbs;
> +             j++, phb_id++) {
> +            PnvPhb4PecStack *stack =3D &pec->stacks[j];
> +            Object *obj =3D OBJECT(&stack->phb);
> +
> +            object_property_set_int(obj, phb_id, "index", &error_fatal);
> +            object_property_set_int(obj, chip->chip_id, "chip-id",
> +                                    &error_fatal);
> +            object_property_set_int(obj, PNV_PHB5_VERSION, "version",
> +                                    &error_fatal);
> +            object_property_set_int(obj, PNV_PHB5_DEVICE_ID, "device-id",
> +                                    &error_fatal);
> +            object_property_set_link(obj, OBJECT(stack), "stack", &error=
_abort);
> +            object_property_set_bool(obj, true, "realized", &local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +                return;
> +            }
> +            qdev_set_parent_bus(DEVICE(obj), sysbus_get_default());
> +
> +            /* Populate the XSCOM address space. */
> +            pnv_xscom_add_subregion(chip,
> +                                   pec_nest_base + 0x40 * (stack->stack_=
no + 1),
> +                                   &stack->nest_regs_mr);
> +            pnv_xscom_add_subregion(chip,
> +                                    pec_pci_base + 0x40 * (stack->stack_=
no + 1),
> +                                    &stack->pci_regs_mr);
> +            pnv_xscom_add_subregion(chip,
> +                                    pec_pci_base + PNV9_XSCOM_PEC_PCI_ST=
K0 +
> +                                    0x40 * stack->stack_no,
> +                                    &stack->phb_regs_mr);
> +        }
> +    }
> +}
> +
>  static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>  {
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(dev);
> @@ -1737,6 +1830,13 @@ static void pnv_chip_power10_realize(DeviceState *=
dev, Error **errp)
>      }
>      pnv_xscom_add_subregion(chip, PNV10_XSCOM_OCC_BASE,
>                              &chip10->occ.xscom_regs);
> +
> +    /* PHBs */
> +    pnv_chip_power10_phb_realize(chip, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>  }
> =20
>  static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
> @@ -1763,6 +1863,7 @@ static void pnv_chip_power10_class_init(ObjectClass=
 *klass, void *data)
>      k->xscom_core_base =3D pnv_chip_power10_xscom_core_base;
>      k->xscom_pcba =3D pnv_chip_power10_xscom_pcba;
>      dc->desc =3D "PowerNV Chip POWER10";
> +    k->num_phbs =3D 6;
> =20
>      device_class_set_parent_realize(dc, pnv_chip_power10_realize,
>                                      &k->parent_realize);


