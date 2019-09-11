Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5E1C49ED7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 00:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502F3216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 00:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lXgTFK0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502F3216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7qxz-0006jv-DY
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 20:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i7qwc-0005vQ-Ss
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 20:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i7qwZ-0003OB-Uc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 20:57:14 -0400
Received: from ozlabs.org ([203.11.71.1]:44263)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i7qwY-0003NO-UT; Tue, 10 Sep 2019 20:57:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Sk4y5Xrdz9sNT; Wed, 11 Sep 2019 10:57:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568163426;
 bh=dz0bodBRWzrWXYU6DiBke/R00s9y0I7LsqBTpZhL2rc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lXgTFK0kVFluofMC2DCw2t/70rpJ2Fx9W3ExQmluNMFjXjoQKFSC8vrpbU1xDRpX5
 vSswjUMJB7jnsd+1ox0XeHFrHHt776nXXlv9aA/WfxeNemXbD1XUiFZyCYRbj6LL8R
 UL182XkRQKSRA4vqcv5v5sEBIKoB277x5/6GLhAM=
Date: Wed, 11 Sep 2019 10:34:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Balamuruhan S <bala24@linux.ibm.com>
Message-ID: <20190911003405.GC30740@umbus.fritz.box>
References: <20190910071019.16689-1-bala24@linux.ibm.com>
 <20190910071019.16689-4-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <20190910071019.16689-4-bala24@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v1 3/3] hw/ppc/pnv_homer: add PowerNV homer
 device model
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
Cc: maddy@linux.vnet.ibm.com, groug@kaod.org, qemu-devel@nongnu.org,
 anju@linux.vnet.ibm.com, qemu-ppc@nongnu.org, clg@kaod.org,
 hari@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 12:40:19PM +0530, Balamuruhan S wrote:
> add PnvHOMER device model to emulate homer memory access

Please use PnvHomer as the identifier instead.  I'm guessing that
messes with the usual capitalization of HOMER, but my experience with
spapr is that matching qemu capitalization style is more important for
code readability (hence fairly recent changes of sPAPRPHBState to
SpaprPhbState and so so forth).

> for pstate table, occ-sensors, slw, occ static and dynamic
> values for Power8 and Power9 chips. Fix few coding style
> warnings given by checkpatch.pl.
>=20
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  hw/ppc/Makefile.objs       |   1 +
>  hw/ppc/pnv.c               |  79 +++++++++++---
>  hw/ppc/pnv_homer.c         | 258 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/pnv.h       |   3 +
>  include/hw/ppc/pnv_homer.h |  52 +++++++++
>  5 files changed, 376 insertions(+), 17 deletions(-)
>  create mode 100644 hw/ppc/pnv_homer.c
>  create mode 100644 include/hw/ppc/pnv_homer.h
>=20
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 2c4e1c8de0..580bb4f0dd 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -9,6 +9,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
>  obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
>  # IBM PowerNV
>  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
> +obj-$(CONFIG_POWERNV) +=3D pnv_homer.o
>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
>  obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
>  endif
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 80338ffe87..ddddcc9bb6 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -187,7 +187,8 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, v=
oid *fdt)
> =20
>      _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
>      _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
> -    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_opts=
->slb_size)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size",
> +                           cpu->hash64_opts->slb_size)));
>      _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
>      _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
> =20
> @@ -200,19 +201,23 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc,=
 void *fdt)
>                             segs, sizeof(segs))));
>      }
> =20
> -    /* Advertise VMX/VSX (vector extensions) if available
> +    /*
> +     * Advertise VMX/VSX (vector extensions) if available
>       *   0 / no property =3D=3D no vector extensions
>       *   1               =3D=3D VMX / Altivec available
> -     *   2               =3D=3D VSX available */
> +     *   2               =3D=3D VSX available
> +     */
>      if (env->insns_flags & PPC_ALTIVEC) {
>          uint32_t vmx =3D (env->insns_flags2 & PPC2_VSX) ? 2 : 1;
> =20
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", vmx)));
>      }
> =20
> -    /* Advertise DFP (Decimal Floating Point) if available
> +    /*
> +     * Advertise DFP (Decimal Floating Point) if available
>       *   0 / no property =3D=3D no DFP
> -     *   1               =3D=3D DFP available */
> +     *   1               =3D=3D DFP available
> +     */
>      if (env->insns_flags2 & PPC2_DFP) {
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
>      }
> @@ -424,7 +429,8 @@ static int pnv_dt_isa_device(DeviceState *dev, void *=
opaque)
>      return 0;
>  }
> =20
> -/* The default LPC bus of a multichip system is on chip 0. It's
> +/*
> + * The default LPC bus of a multichip system is on chip 0. It's
>   * recognized by the firmware (skiboot) using a "primary" property.
>   */
>  static void pnv_dt_isa(PnvMachineState *pnv, void *fdt)
> @@ -442,8 +448,10 @@ static void pnv_dt_isa(PnvMachineState *pnv, void *f=
dt)
>      assert(phandle > 0);
>      _FDT((fdt_setprop_cell(fdt, isa_offset, "phandle", phandle)));
> =20
> -    /* ISA devices are not necessarily parented to the ISA bus so we
> -     * can not use object_child_foreach() */
> +    /*
> +     * ISA devices are not necessarily parented to the ISA bus so we
> +     * can not use object_child_foreach()
> +     */
>      qbus_walk_children(BUS(pnv->isa_bus), pnv_dt_isa_device, NULL, NULL,=
 NULL,
>                         &args);
>  }
> @@ -545,7 +553,8 @@ static void pnv_reset(MachineState *machine)
> =20
>      qemu_devices_reset();
> =20
> -    /* OpenPOWER systems have a BMC, which can be defined on the
> +    /*
> +     * OpenPOWER systems have a BMC, which can be defined on the
>       * command line with:
>       *
>       *   -device ipmi-bmc-sim,id=3Dbmc0
> @@ -705,7 +714,8 @@ static void pnv_init(MachineState *machine)
> =20
>          pnv->chips[i] =3D PNV_CHIP(chip);
> =20
> -        /* TODO: put all the memory in one node on chip 0 until we find a
> +        /*
> +         * TODO: put all the memory in one node on chip 0 until we find a
>           * way to specify different ranges for each chip
>           */
>          if (i =3D=3D 0) {
> @@ -732,8 +742,10 @@ static void pnv_init(MachineState *machine)
>      /* Create an RTC ISA device too */
>      mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
> =20
> -    /* OpenPOWER systems use a IPMI SEL Event message to notify the
> -     * host to powerdown */
> +    /*
> +     * OpenPOWER systems use a IPMI SEL Event message to notify the
> +     * host to powerdown
> +     */
>      pnv->powerdown_notifier.notify =3D pnv_powerdown_notify;
>      qemu_register_powerdown_notifier(&pnv->powerdown_notifier);
>  }
> @@ -803,7 +815,8 @@ static void pnv_chip_power9_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
>      pnv_cpu->intc =3D obj;
>  }
> =20
> -/* Allowed core identifiers on a POWER8 Processor Chip :
> +/*
> + * Allowed core identifiers on a POWER8 Processor Chip :
>   *
>   * <EX0 reserved>
>   *  EX1  - Venice only
> @@ -847,6 +860,11 @@ static void pnv_chip_power8_instance_init(Object *ob=
j)
>                              TYPE_PNV8_OCC, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip8->occ), "psi",
>                                     OBJECT(&chip8->psi), &error_abort);
> +
> +    object_initialize_child(obj, "homer",  &chip8->homer, sizeof(chip8->=
homer),
> +                            TYPE_PNV8_HOMER, &error_abort, NULL);
> +    object_property_add_const_link(OBJECT(&chip8->homer), "xics",
> +                                   OBJECT(qdev_get_machine()), &error_ab=
ort);
>  }
> =20
>  static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
> @@ -923,8 +941,10 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
>                                              (uint64_t) PNV_XSCOM_BASE(ch=
ip),
>                                              PNV_XSCOM_LPC_BASE);
> =20
> -    /* Interrupt Management Area. This is the memory region holding
> -     * all the Interrupt Control Presenter (ICP) registers */
> +    /*
> +     * Interrupt Management Area. This is the memory region holding
> +     * all the Interrupt Control Presenter (ICP) registers
> +     */
>      pnv_chip_icp_realize(chip8, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> @@ -942,6 +962,16 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
>      /* OCC SRAM model */
>      memory_region_add_subregion(get_system_memory(), PNV_OCC_COMMON_AREA=
(chip),
>                                  &chip8->occ.sram_regs);
> +
> +    /* HOMER */
> +    object_property_set_bool(OBJECT(&chip8->homer), true, "realized",
> +                             &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    memory_region_add_subregion(get_system_memory(), PNV_HOMER_BASE(chip=
),
> +                                &chip8->homer.homer_regs);
>  }
> =20
>  static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
> @@ -1024,6 +1054,11 @@ static void pnv_chip_power9_instance_init(Object *=
obj)
>                              TYPE_PNV9_OCC, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip9->occ), "psi",
>                                     OBJECT(&chip9->psi), &error_abort);
> +
> +    object_initialize_child(obj, "homer",  &chip9->homer, sizeof(chip9->=
homer),
> +                            TYPE_PNV9_HOMER, &error_abort, NULL);
> +    object_property_add_const_link(OBJECT(&chip9->homer), "chip", obj,
> +                                   &error_abort);
>  }
> =20
>  static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
> @@ -1134,6 +1169,16 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
>      /* OCC SRAM model */
>      memory_region_add_subregion(get_system_memory(), PNV9_OCC_COMMON_ARE=
A(chip),
>                                  &chip9->occ.sram_regs);
> +
> +    /* HOMER */
> +    object_property_set_bool(OBJECT(&chip9->homer), true, "realized",
> +                             &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    memory_region_add_subregion(get_system_memory(), PNV9_HOMER_BASE(chi=
p),
> +                                &chip9->homer.homer_regs);
>  }
> =20
>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
> @@ -1412,8 +1457,8 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
>      mc->init =3D pnv_init;
>      mc->reset =3D pnv_reset;
>      mc->max_cpus =3D MAX_CPUS;
> -    mc->block_default_type =3D IF_IDE; /* Pnv provides a AHCI device for
> -                                      * storage */
> +    /* Pnv provides a AHCI device for storage */
> +    mc->block_default_type =3D IF_IDE;
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D NULL;
>      /*
> diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
> new file mode 100644
> index 0000000000..2886e27176
> --- /dev/null
> +++ b/hw/ppc/pnv_homer.c
> @@ -0,0 +1,258 @@
> +/*
> + * QEMU PowerPC PowerNV Emulation of a few HOMER related registers
> + *
> + * Copyright (c) 2019, IBM Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/cpus.h"
> +#include "hw/ppc/pnv.h"
> +#include "hw/qdev-core.h"
> +#include "hw/ppc/pnv_homer.h"
> +
> +
> +static bool core_max_array(void *opaque, hwaddr addr)
> +{
> +    PnvHOMER *homer =3D PNV_HOMER(opaque);
> +    PnvHOMERClass *homer_class =3D PNV_HOMER_GET_CLASS(homer);
> +
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +
> +    for (int i =3D 0; i <=3D ms->smp.cores; i++) {
> +        if (addr =3D=3D (homer_class->core_max_base + i)) {
> +            return true;
> +       }
> +    }
> +    return false;
> +}
> +
> +/* P8 Pstate table */
> +
> +#define PNV8_OCC_PSTATE_VERSION          0x1f8001
> +#define PNV8_OCC_PSTATE_MIN              0x1f8003
> +#define PNV8_OCC_PSTATE_VALID            0x1f8000
> +#define PNV8_OCC_PSTATE_THROTTLE         0x1f8002
> +#define PNV8_OCC_PSTATE_NOM              0x1f8004
> +#define PNV8_OCC_PSTATE_TURBO            0x1f8005
> +#define PNV8_OCC_PSTATE_ULTRA_TURBO      0x1f8006
> +#define PNV8_OCC_PSTATE_DATA             0x1f8008
> +#define PNV8_OCC_PSTATE_ID_ZERO          0x1f8010
> +#define PNV8_OCC_PSTATE_ID_ONE           0x1f8018
> +#define PNV8_OCC_PSTATE_ID_TWO           0x1f8020
> +#define PNV8_OCC_VDD_VOLTAGE_IDENTIFIER  0x1f8012
> +#define PNV8_OCC_VCS_VOLTAGE_IDENTIFIER  0x1f8013
> +#define PNV8_OCC_PSTATE_ZERO_FREQUENCY   0x1f8014
> +#define PNV8_OCC_PSTATE_ONE_FREQUENCY    0x1f801c
> +#define PNV8_OCC_PSTATE_TWO_FREQUENCY    0x1f8024
> +#define PNV8_CORE_MAX_BASE               0x1f8810
> +
> +
> +static uint64_t pnv_power8_homer_read(void *opaque, hwaddr addr,
> +                                      unsigned size)
> +{
> +    switch (addr) {
> +    case PNV8_OCC_PSTATE_VERSION:
> +    case PNV8_OCC_PSTATE_MIN:
> +    case PNV8_OCC_PSTATE_ID_ZERO:
> +        return 0;
> +    case PNV8_OCC_PSTATE_VALID:
> +    case PNV8_OCC_PSTATE_THROTTLE:
> +    case PNV8_OCC_PSTATE_NOM:
> +    case PNV8_OCC_PSTATE_TURBO:
> +    case PNV8_OCC_PSTATE_ID_ONE:
> +    case PNV8_OCC_VDD_VOLTAGE_IDENTIFIER:
> +    case PNV8_OCC_VCS_VOLTAGE_IDENTIFIER:
> +        return 1;
> +    case PNV8_OCC_PSTATE_ULTRA_TURBO:
> +    case PNV8_OCC_PSTATE_ID_TWO:
> +        return 2;
> +    case PNV8_OCC_PSTATE_DATA:
> +        return 0x1000000000000000;
> +    /* P8 frequency for 0, 1, and 2 pstates */
> +    case PNV8_OCC_PSTATE_ZERO_FREQUENCY:
> +    case PNV8_OCC_PSTATE_ONE_FREQUENCY:
> +    case PNV8_OCC_PSTATE_TWO_FREQUENCY:
> +        return 3000;
> +    }
> +    /* pstate table core max array */
> +    if (core_max_array(opaque, addr)) {
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +static void pnv_power8_homer_write(void *opaque, hwaddr addr,
> +                                   uint64_t val, unsigned size)
> +{
> +    /* callback function defined to homer write */
> +    return;
> +}
> +
> +static const MemoryRegionOps pnv_power8_homer_ops =3D {
> +    .read =3D pnv_power8_homer_read,
> +    .write =3D pnv_power8_homer_write,
> +    .valid.min_access_size =3D 1,
> +    .valid.max_access_size =3D 8,
> +    .impl.min_access_size =3D 1,
> +    .impl.max_access_size =3D 8,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +};
> +
> +static void pnv_homer_power8_class_init(ObjectClass *klass, void *data)
> +{
> +    PnvHOMERClass *homer =3D PNV_HOMER_CLASS(klass);
> +
> +    homer->homer_size =3D PNV_HOMER_SIZE;
> +    homer->homer_ops =3D &pnv_power8_homer_ops;
> +    homer->core_max_base =3D PNV8_CORE_MAX_BASE;
> +}
> +
> +static const TypeInfo pnv_homer_power8_type_info =3D {
> +    .name          =3D TYPE_PNV8_HOMER,
> +    .parent        =3D TYPE_PNV_HOMER,
> +    .instance_size =3D sizeof(PnvHOMER),
> +    .class_init    =3D pnv_homer_power8_class_init,
> +};
> +
> +/* P9 Pstate table */
> +
> +#define PNV9_OCC_PSTATE_ID_ZERO          0xe2018
> +#define PNV9_OCC_PSTATE_ID_ONE           0xe2020
> +#define PNV9_OCC_PSTATE_ID_TWO           0xe2028
> +#define PNV9_OCC_PSTATE_DATA             0xe2000
> +#define PNV9_OCC_PSTATE_DATA_AREA        0xe2008
> +#define PNV9_OCC_PSTATE_MIN              0xe2003
> +#define PNV9_OCC_PSTATE_NOM              0xe2004
> +#define PNV9_OCC_PSTATE_TURBO            0xe2005
> +#define PNV9_OCC_PSTATE_ULTRA_TURBO      0xe2818
> +#define PNV9_OCC_MAX_PSTATE_ULTRA_TURBO  0xe2006
> +#define PNV9_OCC_PSTATE_MAJOR_VERSION    0xe2001
> +#define PNV9_OCC_OPAL_RUNTIME_DATA       0xe2b85
> +#define PNV9_CHIP_HOMER_IMAGE_POINTER    0x200008
> +#define PNV9_CHIP_HOMER_BASE             0x0
> +#define PNV9_OCC_PSTATE_ZERO_FREQUENCY   0xe201c
> +#define PNV9_OCC_PSTATE_ONE_FREQUENCY    0xe2024
> +#define PNV9_OCC_PSTATE_TWO_FREQUENCY    0xe202c
> +#define PNV9_OCC_ROLE_MASTER_OR_SLAVE    0xe2002
> +#define PNV9_CORE_MAX_BASE               0xe2819
> +
> +
> +static uint64_t pnv_power9_homer_read(void *opaque, hwaddr addr,
> +                                      unsigned size)
> +{
> +    switch (addr) {
> +    case PNV9_OCC_MAX_PSTATE_ULTRA_TURBO:
> +    case PNV9_OCC_PSTATE_ID_ZERO:
> +        return 0;
> +    case PNV9_OCC_PSTATE_DATA:
> +    case PNV9_OCC_ROLE_MASTER_OR_SLAVE:
> +    case PNV9_OCC_PSTATE_NOM:
> +    case PNV9_OCC_PSTATE_TURBO:
> +    case PNV9_OCC_PSTATE_ID_ONE:
> +    case PNV9_OCC_PSTATE_ULTRA_TURBO:
> +    case PNV9_OCC_OPAL_RUNTIME_DATA:
> +        return 1;
> +    case PNV9_OCC_PSTATE_MIN:
> +    case PNV9_OCC_PSTATE_ID_TWO:
> +        return 2;
> +
> +    /* 3000 khz frequency for 0, 1, and 2 pstates */
> +    case PNV9_OCC_PSTATE_ZERO_FREQUENCY:
> +    case PNV9_OCC_PSTATE_ONE_FREQUENCY:
> +    case PNV9_OCC_PSTATE_TWO_FREQUENCY:
> +        return 3000;
> +    case PNV9_OCC_PSTATE_MAJOR_VERSION:
> +        return 0x90;
> +    case PNV9_CHIP_HOMER_BASE:
> +    case PNV9_OCC_PSTATE_DATA_AREA:
> +    case PNV9_CHIP_HOMER_IMAGE_POINTER:
> +        return 0x1000000000000000;
> +    }
> +    /* pstate table core max array */
> +    if (core_max_array(opaque, addr)) {
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +static void pnv_power9_homer_write(void *opaque, hwaddr addr,
> +                                   uint64_t val, unsigned size)
> +{
> +    /* callback function defined to homer write */
> +    return;
> +}
> +
> +static const MemoryRegionOps pnv_power9_homer_ops =3D {
> +    .read =3D pnv_power9_homer_read,
> +    .write =3D pnv_power9_homer_write,
> +    .valid.min_access_size =3D 1,
> +    .valid.max_access_size =3D 8,
> +    .impl.min_access_size =3D 1,
> +    .impl.max_access_size =3D 8,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +};
> +
> +static void pnv_homer_power9_class_init(ObjectClass *klass, void *data)
> +{
> +    PnvHOMERClass *homer =3D PNV_HOMER_CLASS(klass);
> +
> +    homer->homer_size =3D PNV9_HOMER_SIZE;
> +    homer->homer_ops =3D &pnv_power9_homer_ops;
> +    homer->core_max_base =3D PNV9_CORE_MAX_BASE;
> +}
> +
> +static const TypeInfo pnv_homer_power9_type_info =3D {
> +    .name          =3D TYPE_PNV9_HOMER,
> +    .parent        =3D TYPE_PNV_HOMER,
> +    .instance_size =3D sizeof(PnvHOMER),
> +    .class_init    =3D pnv_homer_power9_class_init,
> +};
> +
> +static void pnv_homer_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvHOMER *homer =3D PNV_HOMER(dev);
> +    PnvHOMERClass *homer_class =3D PNV_HOMER_GET_CLASS(homer);
> +
> +    /* homer region */
> +    memory_region_init_io(&homer->homer_regs, OBJECT(dev),
> +                          homer_class->homer_ops, homer, "homer-main-mem=
ory",
> +                          homer_class->homer_size);
> +}
> +
> +static void pnv_homer_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->realize =3D pnv_homer_realize;
> +    dc->desc =3D "PowerNV HOMER Memory";
> +}
> +
> +static const TypeInfo pnv_homer_type_info =3D {
> +    .name          =3D TYPE_PNV_HOMER,
> +    .parent        =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(PnvHOMER),
> +    .class_init    =3D pnv_homer_class_init,
> +    .class_size    =3D sizeof(PnvHOMERClass),
> +    .abstract      =3D true,
> +};
> +
> +static void pnv_homer_register_types(void)
> +{
> +    type_register_static(&pnv_homer_type_info);
> +    type_register_static(&pnv_homer_power8_type_info);
> +    type_register_static(&pnv_homer_power9_type_info);
> +}
> +
> +type_init(pnv_homer_register_types);
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 63a4b7b6a7..321d4ca967 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -26,6 +26,7 @@
>  #include "hw/ppc/pnv_lpc.h"
>  #include "hw/ppc/pnv_psi.h"
>  #include "hw/ppc/pnv_occ.h"
> +#include "hw/ppc/pnv_homer.h"
>  #include "hw/ppc/pnv_xive.h"
>  #include "hw/ppc/pnv_core.h"
> =20
> @@ -76,6 +77,7 @@ typedef struct Pnv8Chip {
>      PnvLpcController lpc;
>      Pnv8Psi      psi;
>      PnvOCC       occ;
> +    PnvHOMER     homer;
>  } Pnv8Chip;
> =20
>  #define TYPE_PNV9_CHIP "pnv9-chip"
> @@ -90,6 +92,7 @@ typedef struct Pnv9Chip {
>      Pnv9Psi      psi;
>      PnvLpcController lpc;
>      PnvOCC       occ;
> +    PnvHOMER     homer;
> =20
>      uint32_t     nr_quads;
>      PnvQuad      *quads;
> diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
> new file mode 100644
> index 0000000000..3b666a6245
> --- /dev/null
> +++ b/include/hw/ppc/pnv_homer.h
> @@ -0,0 +1,52 @@
> +/*
> + * QEMU PowerPC PowerNV Emulation of a few HOMER related registers
> + *
> + * Copyright (c) 2019, IBM Corporation.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#ifndef PPC_PNV_HOMER_H
> +#define PPC_PNV_HOMER_H
> +
> +#define TYPE_PNV_HOMER "pnv-homer"
> +#define PNV_HOMER(obj) OBJECT_CHECK(PnvHOMER, (obj), TYPE_PNV_HOMER)
> +#define TYPE_PNV8_HOMER TYPE_PNV_HOMER "-POWER8"
> +#define PNV8_HOMER(obj) OBJECT_CHECK(PnvHOMER, (obj), TYPE_PNV8_HOMER)
> +#define TYPE_PNV9_HOMER TYPE_PNV_HOMER "-POWER9"
> +#define PNV9_HOMER(obj) OBJECT_CHECK(PnvHOMER, (obj), TYPE_PNV9_HOMER)
> +
> +typedef struct PnvHOMER {
> +    DeviceState parent;
> +
> +    MemoryRegion homer_regs;
> +} PnvHOMER;
> +
> +#define PNV_HOMER_CLASS(klass)   \
> +     OBJECT_CLASS_CHECK(PnvHOMERClass, (klass), TYPE_PNV_HOMER)
> +#define PNV_HOMER_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(PnvHOMERClass, (obj), TYPE_PNV_HOMER)
> +
> +typedef struct PnvHOMERClass {
> +    DeviceClass parent_class;
> +
> +    int homer_size;
> +    const MemoryRegionOps *homer_ops;
> +
> +    hwaddr core_max_base;
> +} PnvHOMERClass;
> +
> +
> +
> +#endif /* PPC_PNV_HOMER_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl14QPsACgkQbDjKyiDZ
s5J/nA//WzlmD9uWYSCe3JWMfvecXHz0iGK1U3ogKqrx1oPcP8BO70d8xPEaSdQ/
wq4DS1QJKUuNdnIW9cBIiPbsqDGmziapbX/0iBPyH92kA856gI03+F+6mrmb7lMp
XVyx/+EmOYWa4s21vPtx820Sbz52jivNGEK6kbW1s/ZA9D7ZGsYWr6HiU3Y660/w
JUZE7lnKdl2rmxa/hSbsbaecRYnuxNAAv98zZ8nkPq3fcCpgSFiKt+3geqNck8JP
DOoU75EC03iKMB0MHO+s5e3GisRFL4mO4UHAWTEISFWhPcQJu9pocco7+I8xBdQ7
94CO3A8hADyWTtpu51wpdCQ/ubalX+SVpru8lv1yeCiHB95eITEUjXZ7aOp+ACFb
eEHZDaVGkHTk0ouw5DI4qynTqZA4abGEl3oqwsT9807GHwqimMTivTC1h3Pyvzpa
+5xwRy8A2nHOqkv7WyAdA4DKStXktIUJgC+7edxhkLbhjsnF0BEhagwwiIddZb6a
2Df9d2jBZOLGo4Z7IKZh6hmtcn9qVKyJFXz92PisnqckJez/fR4bjdzVXRJlIBbg
7Vo90ouvPkSLt9IwmXOxjfKzqK6NeEeefa/CaewTvBo/g6k1dtpNSX0gHEerXHJw
AgjCyVJ5m62ncdL/ksKHzfxSqIoOuydu20/TV4jZ9Lk1LKAZYrg=
=dvVg
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--

