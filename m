Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEF6C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A272084F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A272084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84EG-0006kj-Be
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i840l-0002zt-8O
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i840j-0001Nf-Sy
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:54:23 -0400
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:52795)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i840j-0001N6-O1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:54:21 -0400
Received: from player738.ha.ovh.net (unknown [10.108.35.210])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 7F49818F0FD
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 16:54:18 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 86C0C9D1D2D1;
 Wed, 11 Sep 2019 14:54:08 +0000 (UTC)
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20190911142925.19197-1-bala24@linux.ibm.com>
 <20190911142925.19197-5-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <398aa677-02fa-df42-a330-dec956154c70@kaod.org>
Date: Wed, 11 Sep 2019 16:54:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911142925.19197-5-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 763923087308917586
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdefgdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.162.229
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/ppc/pnv: fix checkpatch.pl
 coding style warnings
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
Cc: maddy@linux.vnet.ibm.com, groug@kaod.org, anju@linux.vnet.ibm.com,
 qemu-ppc@nongnu.org, hari@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/2019 16:29, Balamuruhan S wrote:
> There were few trailing comments after `/*` instead in
> new line and line more than 80 character, these fixes are
> trivial and doesn't change any logic in code.
>=20
> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/pnv.c | 49 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index f249e72356..77a86c6a23 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -187,7 +187,8 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc,=
 void *fdt)
> =20
>      _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq))=
);
>      _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
> -    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_op=
ts->slb_size)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size",
> +                           cpu->hash64_opts->slb_size)));
>      _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
>      _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
> =20
> @@ -200,19 +201,23 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *p=
c, void *fdt)
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
> @@ -424,7 +429,8 @@ static int pnv_dt_isa_device(DeviceState *dev, void=
 *opaque)
>      return 0;
>  }
> =20
> -/* The default LPC bus of a multichip system is on chip 0. It's
> +/*
> + * The default LPC bus of a multichip system is on chip 0. It's
>   * recognized by the firmware (skiboot) using a "primary" property.
>   */
>  static void pnv_dt_isa(PnvMachineState *pnv, void *fdt)
> @@ -442,8 +448,10 @@ static void pnv_dt_isa(PnvMachineState *pnv, void =
*fdt)
>      assert(phandle > 0);
>      _FDT((fdt_setprop_cell(fdt, isa_offset, "phandle", phandle)));
> =20
> -    /* ISA devices are not necessarily parented to the ISA bus so we
> -     * can not use object_child_foreach() */
> +    /*
> +     * ISA devices are not necessarily parented to the ISA bus so we
> +     * can not use object_child_foreach()
> +     */
>      qbus_walk_children(BUS(pnv->isa_bus), pnv_dt_isa_device, NULL, NUL=
L, NULL,
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
> -        /* TODO: put all the memory in one node on chip 0 until we fin=
d a
> +        /*
> +         * TODO: put all the memory in one node on chip 0 until we fin=
d a
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
> @@ -803,7 +815,8 @@ static void pnv_chip_power9_intc_create(PnvChip *ch=
ip, PowerPCCPU *cpu,
>      pnv_cpu->intc =3D obj;
>  }
> =20
> -/* Allowed core identifiers on a POWER8 Processor Chip :
> +/*
> + * Allowed core identifiers on a POWER8 Processor Chip :
>   *
>   * <EX0 reserved>
>   *  EX1  - Venice only
> @@ -928,8 +941,10 @@ static void pnv_chip_power8_realize(DeviceState *d=
ev, Error **errp)
>                                              (uint64_t) PNV_XSCOM_BASE(=
chip),
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
> @@ -1442,8 +1457,8 @@ static void pnv_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->init =3D pnv_init;
>      mc->reset =3D pnv_reset;
>      mc->max_cpus =3D MAX_CPUS;
> -    mc->block_default_type =3D IF_IDE; /* Pnv provides a AHCI device f=
or
> -                                      * storage */
> +    /* Pnv provides a AHCI device for storage */
> +    mc->block_default_type =3D IF_IDE;
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D NULL;
>      /*
>=20


