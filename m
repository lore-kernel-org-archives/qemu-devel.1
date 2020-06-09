Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221E7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E883D207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E883D207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYeE-0007mG-5P
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jiYd4-0006Bd-5x
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:25:02 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:40214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jiYd2-00063v-Bz
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:25:01 -0400
Received: from player737.ha.ovh.net (unknown [10.108.57.150])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 298CE1436F2
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 09:24:57 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 8D8439B655A8;
 Tue,  9 Jun 2020 07:24:52 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0064577ab14-bdb4-49e7-a903-0065fc3383a5,
 2CE69A6D3B62F9BF35ECE14C7D737F520D542DA8) smtp.auth=clg@kaod.org
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH 6/6] hw/arm: Add two NPCM7xx-based machines
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200521192133.127559-1-hskinnemoen@google.com>
 <20200521192133.127559-7-hskinnemoen@google.com>
Message-ID: <8664fc38-070b-48fa-ce50-091e165daeb4@kaod.org>
Date: Tue, 9 Jun 2020 09:24:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521192133.127559-7-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4127830533478517673
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudehfedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhuffvfhfkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffdvhfdukeffgfeiueehvdeufeeijeefhffhteevfeehtefhgfefueejvddvfeffnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.72.44; envelope-from=clg@kaod.org;
 helo=9.mo173.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 03:24:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001, URIBL_SBL=1.623, URIBL_SBL_A=0.1 autolearn=_AUTOLEARN
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 9:21 PM, Havard Skinnemoen wrote:
> This adds two new machines:
> 
>   - npcm750-evb: Nuvoton NPCM750 Evaluation Board.
>   - quanta-gsj: A board with a NPCM730 chip.
> 
> They rely on the NPCM7xx SoC device to do the heavy lifting. They are
> almost completely identical at the moment, apart from the SoC type,
> which currently only changes the reset contents of one register
> (GCR.MDLR), but they might grow apart a bit more as more functionality
> is added.
> 
> Both machines can boot the Linux kernel into /bin/sh.
> 
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  hw/arm/Makefile.objs     |   2 +-
>  hw/arm/npcm7xx_boards.c  | 108 +++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/npcm7xx.h |  19 +++++++
>  3 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/npcm7xx_boards.c
> 
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 13d163a599..c333548ce1 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -41,7 +41,7 @@ obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
>  obj-$(CONFIG_STM32F405_SOC) += stm32f405_soc.o
>  obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
>  obj-$(CONFIG_XLNX_VERSAL) += xlnx-versal.o xlnx-versal-virt.o
> -obj-$(CONFIG_NPCM7XX) += npcm7xx.o
> +obj-$(CONFIG_NPCM7XX) += npcm7xx.o npcm7xx_boards.o
>  obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
>  obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
>  obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o
> diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
> new file mode 100644
> index 0000000000..b89819f6e2
> --- /dev/null
> +++ b/hw/arm/npcm7xx_boards.c
> @@ -0,0 +1,108 @@
> +/*
> + * Machine definitions for boards featuring an NPCM7xx SoC.
> + *
> + * Copyright 2020 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/arm/boot.h"
> +#include "hw/arm/npcm7xx.h"
> +#include "hw/core/cpu.h"
> +#include "qapi/error.h"
> +#include "qemu/units.h"
> +
> +static struct arm_boot_info npcm7xx_binfo = {
> +    .loader_start       = NPCM7XX_LOADER_START,
> +    .smp_loader_start   = NPCM7XX_SMP_LOADER_START,
> +    .smp_bootreg_addr   = NPCM7XX_SMP_BOOTREG_ADDR,
> +    .gic_cpu_if_addr    = NPCM7XX_GIC_CPU_IF_ADDR,
> +    .write_secondary_boot = npcm7xx_write_secondary_boot,
> +    .board_id           = -1,
> +};
> +
> +static void npcm7xx_machine_init(MachineState *machine)
> +{
> +    NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_GET_CLASS(machine);
> +    NPCM7xxState *soc;
> +
> +    soc = NPCM7XX(object_new_with_props(nmc->soc_type, OBJECT(machine), "soc",
> +                                        &error_abort, NULL));
> +    object_property_set_int(OBJECT(soc), machine->smp.cpus, "num-cpus",
> +                            &error_abort);
> +    object_property_set_link(OBJECT(soc), OBJECT(machine->ram), "dram",
> +                             &error_abort);
> +    object_property_set_bool(OBJECT(soc), true, "realized", &error_abort);
> +
> +    npcm7xx_binfo.ram_size = machine->ram_size;
> +    npcm7xx_binfo.nb_cpus = machine->smp.cpus;
> +
> +    arm_load_kernel(soc->cpu[0], machine, &npcm7xx_binfo);
> +}
> +
> +static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->init            = npcm7xx_machine_init;
> +    mc->max_cpus        = NPCM7XX_MAX_NUM_CPUS;
> +    mc->default_cpus    = NPCM7XX_MAX_NUM_CPUS;
> +    mc->no_floppy       = 1;
> +    mc->no_cdrom        = 1;
> +    mc->no_parallel     = 1;
> +    mc->default_ram_id  = "ram";
> +}
> +
> +/*
> + * Schematics:
> + * https://github.com/Nuvoton-Israel/nuvoton-info/blob/master/npcm7xx-poleg/evaluation-board/board_deliverables/NPCM750x_EB_ver.A1.1_COMPLETE.pdf
> + */
> +static void npcm750_evb_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc            = "Nuvoton NPCM750 Evaluation Board (Cortex A9)";
> +    nmc->soc_type       = TYPE_NPCM750;
> +    mc->default_ram_size = 512 * MiB;
> +};
> +
> +static void gsj_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc            = "Quanta GSJ (Cortex A9)";
> +    nmc->soc_type       = TYPE_NPCM730;
> +    mc->default_ram_size = 512 * MiB;
> +};
> +
> +static const TypeInfo npcm7xx_machine_types[] = {
> +    {
> +        .name           = TYPE_NPCM7XX_MACHINE,
> +        .parent         = TYPE_MACHINE,
> +        .instance_size  = sizeof(NPCM7xxMachine),
> +        .class_size     = sizeof(NPCM7xxMachineClass),
> +        .class_init     = npcm7xx_machine_class_init,
> +        .abstract       = true,
> +    }, {
> +        .name           = MACHINE_TYPE_NAME("npcm750-evb"),
> +        .parent         = TYPE_NPCM7XX_MACHINE,
> +        .class_init     = npcm750_evb_machine_class_init,
> +    }, {
> +        .name           = MACHINE_TYPE_NAME("quanta-gsj"),
> +        .parent         = TYPE_NPCM7XX_MACHINE,
> +        .class_init     = gsj_machine_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(npcm7xx_machine_types)
> diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
> index 0a8798dd24..c1a108e89a 100644
> --- a/include/hw/arm/npcm7xx.h
> +++ b/include/hw/arm/npcm7xx.h
> @@ -30,6 +30,25 @@
>  #define NPCM7XX_SMP_BOOTREG_ADDR        (0xF080013C)  /* GCR.SCRPAD */
>  #define NPCM7XX_GIC_CPU_IF_ADDR         (0xF03FE100)  /* GIC within A9 */
>  
> +typedef struct NPCM7xxMachine {
> +    MachineState        parent;
> +} NPCM7xxMachine;
> +
> +#define TYPE_NPCM7XX_MACHINE MACHINE_TYPE_NAME("npcm7xx")
> +#define NPCM7XX_MACHINE(obj)                                            \
> +    OBJECT_CHECK(NPCM7xxMachine, (obj), TYPE_NPCM7XX_MACHINE)
> +
> +typedef struct NPCM7xxMachineClass {
> +    MachineClass        parent;
> +
> +    const char          *soc_type;
> +} NPCM7xxMachineClass;
> +
> +#define NPCM7XX_MACHINE_CLASS(klass)                                    \
> +    OBJECT_CLASS_CHECK(NPCM7xxMachineClass, (klass), TYPE_NPCM7XX_MACHINE)
> +#define NPCM7XX_MACHINE_GET_CLASS(obj)                                  \
> +    OBJECT_GET_CLASS(NPCM7xxMachineClass, (obj), TYPE_NPCM7XX_MACHINE)
> +
>  typedef struct NPCM7xxState {
>      DeviceState         parent;
>  
> 


