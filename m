Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88672C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 19:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE9320658
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 19:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApKvBvz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE9320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7lAL-0007DN-7w
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 15:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7l94-0005we-Vc; Mon, 17 Aug 2020 15:50:14 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:45650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7l91-0004uG-2w; Mon, 17 Aug 2020 15:50:14 -0400
Received: by mail-il1-x143.google.com with SMTP id k4so15595906ilr.12;
 Mon, 17 Aug 2020 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H/s7k8ignUQyK57x7x+i93UxNODR+Gb2wkrwM/MszE4=;
 b=ApKvBvz9NHLkwsI+sWo9MMyUx6C9JQVlQbXyJyojEWyRbr8AFBfGDO4zF/A3Gpe6YL
 koFti5eXJRDuFcpWRRTvp2KgTMwoRGu48rjS9Oj70NMppyz2yD29QDIPWO5ZCUQZ9z0k
 IkXFaGcjSt+6e3TPX1Uc/EE8jrI75fizX16ww99bqt1beE6hzdCtN+j4D5uFK7mhtKFP
 ldKC5sDHopXW9NLqddka1mSMUVgVYrCwUBLXs4QhPF2JH0V11vw0fFdcgeEu1E1SZoS0
 vJP8dLF1Q1I3LfCtLRQ025MAJTgs03puLsxkgy8Pwsl/OFCO4WWDmYaRz/SmLZN+ev4n
 SfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H/s7k8ignUQyK57x7x+i93UxNODR+Gb2wkrwM/MszE4=;
 b=ZFV8epOm0LDQ5llQlwc7CnTPzz53Hgh2g2ckLHqE3gl5FV893zE5P0t1y5Uy1gwtQk
 2GtM1Pue2F+gTBAMsX10GZp/4YBT2T9pzv+wVqH2S7vtJ/c755O5yg3QEuEgUlRxvAR4
 rKj439oMw3GHtBlH1VonqasQoxQd9XRY+XaYyMzKA70Ojv+G4BAER1fhwVDcZhQN40/F
 28/+1YEV66awkyITDCF8asRWyaOHMwOsh2jvMs0UMMNDR6TglF/jrkiO5dd7KuEz724I
 MDlLcluzArcYDGTM0wryyt0PDUFQOOEqhugyugwkZTpggNs4Rf8r3dmkXfQBjhwhs83Q
 GOkg==
X-Gm-Message-State: AOAM533svy8RkkHNpAtII8SSELFwfzs6iVHbqDhkuh0i15Z70xq4u4pi
 ZH6sAB9ARSQIYVPMEJPgGO2uU7sxJMt8LQoa4H4=
X-Google-Smtp-Source: ABdhPJy8IINFfQEmInMOj7mdQix1kqpKTWD8G0CPP6N1rCVQxGGhDHrVmHrJotTuMUPUN+mz10gk+ZWWjegXHqpTNE0=
X-Received: by 2002:a05:6e02:13f1:: with SMTP id
 w17mr15611548ilj.131.1597693809491; 
 Mon, 17 Aug 2020 12:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-5-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1597423256-14847-5-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Aug 2020 12:39:37 -0700
Message-ID: <CAKmqyKM_qPNQaFmqW+PwXaRCf8DvLvQ2goKak6M00QT13NiUmA@mail.gmail.com>
Subject: Re: [PATCH 04/18] hw/riscv: Initial support for Microchip PolarFire
 SoC Icicle Kit board
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 9:43 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This is an initial support for Microchip PolarFire SoC Icicle Kit.
> The Icicle Kit board integrates a PolarFire SoC, with one SiFive's
> E51 plus four U54 cores and many on-chip peripherals and an FPGA.
>
> For more details about Microchip PolarFire Soc, please see:
> https://www.microsemi.com/product-directory/soc-fpgas/5498-polarfire-soc-fpga
>
> Unlike SiFive FU540, the RISC-V core resect vector is at 0x20220000.
> The following perepherals are created as an unimplemented device:
>
> - Bus Error Uint 0/1/2/3/4
> - L2 cache controller
> - SYSREG
> - MPUCFG
> - IOSCBCFG
>
> More devices will be added later.
>
> The BIOS image used by this machine is hss.bin, aka Hart Software
> Services, which can be built from:
> https://github.com/polarfire-soc/hart-software-services
>
> To launch this machine:
> $ qemu-system-riscv64 -nographic -M microchip-icicle-kit
>
> The memory is set to 1 GiB by default to match the hardware.
> A sanity check on ram size is performed in the machine init routine
> to prompt user to increase the RAM size to > 1 GiB when less than
> 1 GiB ram is detected.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Looks good. I didn't check the addresses and PLIC config data with the
datasheet, but I'm assuming it's correct.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  MAINTAINERS                         |   7 +
>  default-configs/riscv64-softmmu.mak |   1 +
>  hw/riscv/Kconfig                    |   6 +
>  hw/riscv/Makefile.objs              |   1 +
>  hw/riscv/microchip_pfsoc.c          | 312 ++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/microchip_pfsoc.h  |  88 ++++++++++
>  6 files changed, 415 insertions(+)
>  create mode 100644 hw/riscv/microchip_pfsoc.c
>  create mode 100644 include/hw/riscv/microchip_pfsoc.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0886eb3..8716cb6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1314,6 +1314,13 @@ F: include/hw/riscv/opentitan.h
>  F: include/hw/char/ibex_uart.h
>  F: include/hw/intc/ibex_plic.h
>
> +Microchip PolarFire SoC Icicle Kit
> +M: Bin Meng <bin.meng@windriver.com>
> +L: qemu-riscv@nongnu.org
> +S: Supported
> +F: hw/riscv/microchip_pfsoc.c
> +F: include/hw/riscv/microchip_pfsoc.h
> +
>  RX Machines
>  -----------
>  rx-gdbsim
> diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
> index aaf6d73..76b6195 100644
> --- a/default-configs/riscv64-softmmu.mak
> +++ b/default-configs/riscv64-softmmu.mak
> @@ -10,3 +10,4 @@ CONFIG_SPIKE=y
>  CONFIG_SIFIVE_E=y
>  CONFIG_SIFIVE_U=y
>  CONFIG_RISCV_VIRT=y
> +CONFIG_MICROCHIP_PFSOC=y
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 28947ef..3292fae 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -48,3 +48,9 @@ config RISCV_VIRT
>      select PCI_EXPRESS_GENERIC_BRIDGE
>      select PFLASH_CFI01
>      select SIFIVE
> +
> +config MICROCHIP_PFSOC
> +    bool
> +    select HART
> +    select SIFIVE
> +    select UNIMP
> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> index 57cc708..419a5a0 100644
> --- a/hw/riscv/Makefile.objs
> +++ b/hw/riscv/Makefile.objs
> @@ -14,3 +14,4 @@ obj-$(CONFIG_SIFIVE_U) += sifive_u_prci.o
>  obj-$(CONFIG_SIFIVE) += sifive_uart.o
>  obj-$(CONFIG_SPIKE) += spike.o
>  obj-$(CONFIG_RISCV_VIRT) += virt.o
> +obj-$(CONFIG_MICROCHIP_PFSOC) += microchip_pfsoc.o
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> new file mode 100644
> index 0000000..20a642c
> --- /dev/null
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -0,0 +1,312 @@
> +/*
> + * QEMU RISC-V Board Compatible with Microchip PolarFire SoC Icicle Kit
> + *
> + * Copyright (c) 2020 Wind River Systems, Inc.
> + *
> + * Author:
> + *   Bin Meng <bin.meng@windriver.com>
> + *
> + * Provides a board compatible with the Microchip PolarFire SoC Icicle Kit
> + *
> + * 0) CLINT (Core Level Interruptor)
> + * 1) PLIC (Platform Level Interrupt Controller)
> + * 2) eNVM (Embedded Non-Volatile Memory)
> + *
> + * This board currently generates devicetree dynamically that indicates at least
> + * two harts and up to five harts.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/log.h"
> +#include "qemu/units.h"
> +#include "qemu/cutils.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/irq.h"
> +#include "hw/loader.h"
> +#include "hw/sysbus.h"
> +#include "hw/cpu/cluster.h"
> +#include "target/riscv/cpu.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/riscv/sifive_clint.h"
> +#include "hw/riscv/sifive_plic.h"
> +#include "hw/riscv/microchip_pfsoc.h"
> +
> +/*
> + * The BIOS image used by this machine is called Hart Software Services (HSS).
> + * See https://github.com/polarfire-soc/hart-software-services
> + */
> +#define BIOS_FILENAME   "hss.bin"
> +#define RESET_VECTOR    0x20220000
> +
> +static const struct MemmapEntry {
> +    hwaddr base;
> +    hwaddr size;
> +} microchip_pfsoc_memmap[] = {
> +    [MICROCHIP_PFSOC_DEBUG] =           {        0x0,     0x1000 },
> +    [MICROCHIP_PFSOC_E51_DTIM] =        {  0x1000000,     0x2000 },
> +    [MICROCHIP_PFSOC_BUSERR_UNIT0] =    {  0x1700000,     0x1000 },
> +    [MICROCHIP_PFSOC_BUSERR_UNIT1] =    {  0x1701000,     0x1000 },
> +    [MICROCHIP_PFSOC_BUSERR_UNIT2] =    {  0x1702000,     0x1000 },
> +    [MICROCHIP_PFSOC_BUSERR_UNIT3] =    {  0x1703000,     0x1000 },
> +    [MICROCHIP_PFSOC_BUSERR_UNIT4] =    {  0x1704000,     0x1000 },
> +    [MICROCHIP_PFSOC_CLINT] =           {  0x2000000,    0x10000 },
> +    [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,     0x1000 },
> +    [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,  0x2000000 },
> +    [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,  0x4000000 },
> +    [MICROCHIP_PFSOC_SYSREG] =          { 0x20002000,     0x2000 },
> +    [MICROCHIP_PFSOC_MPUCFG] =          { 0x20005000,     0x1000 },
> +    [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
> +    [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
> +    [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
> +    [MICROCHIP_PFSOC_DRAM] =            { 0x80000000,        0x0 },
> +};
> +
> +static void microchip_pfsoc_soc_instance_init(Object *obj)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    MicrochipPFSoCState *s = MICROCHIP_PFSOC(obj);
> +
> +    object_initialize_child(obj, "e-cluster", &s->e_cluster, TYPE_CPU_CLUSTER);
> +    qdev_prop_set_uint32(DEVICE(&s->e_cluster), "cluster-id", 0);
> +
> +    object_initialize_child(OBJECT(&s->e_cluster), "e-cpus", &s->e_cpus,
> +                            TYPE_RISCV_HART_ARRAY);
> +    qdev_prop_set_uint32(DEVICE(&s->e_cpus), "num-harts", 1);
> +    qdev_prop_set_uint32(DEVICE(&s->e_cpus), "hartid-base", 0);
> +    qdev_prop_set_string(DEVICE(&s->e_cpus), "cpu-type",
> +                         TYPE_RISCV_CPU_SIFIVE_E51);
> +    qdev_prop_set_uint64(DEVICE(&s->e_cpus), "resetvec", RESET_VECTOR);
> +
> +    object_initialize_child(obj, "u-cluster", &s->u_cluster, TYPE_CPU_CLUSTER);
> +    qdev_prop_set_uint32(DEVICE(&s->u_cluster), "cluster-id", 1);
> +
> +    object_initialize_child(OBJECT(&s->u_cluster), "u-cpus", &s->u_cpus,
> +                            TYPE_RISCV_HART_ARRAY);
> +    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
> +    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
> +    qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type",
> +                         TYPE_RISCV_CPU_SIFIVE_U54);
> +    qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", RESET_VECTOR);
> +}
> +
> +static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    MicrochipPFSoCState *s = MICROCHIP_PFSOC(dev);
> +    const struct MemmapEntry *memmap = microchip_pfsoc_memmap;
> +    MemoryRegion *system_memory = get_system_memory();
> +    MemoryRegion *e51_dtim_mem = g_new(MemoryRegion, 1);
> +    MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
> +    MemoryRegion *envm_data = g_new(MemoryRegion, 1);
> +    char *plic_hart_config;
> +    size_t plic_hart_config_len;
> +    int i;
> +
> +    sysbus_realize(SYS_BUS_DEVICE(&s->e_cpus), &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->u_cpus), &error_abort);
> +    /*
> +     * The cluster must be realized after the RISC-V hart array container,
> +     * as the container's CPU object is only created on realize, and the
> +     * CPU must exist and have been parented into the cluster before the
> +     * cluster is realized.
> +     */
> +    qdev_realize(DEVICE(&s->e_cluster), NULL, &error_abort);
> +    qdev_realize(DEVICE(&s->u_cluster), NULL, &error_abort);
> +
> +    /* E51 DTIM */
> +    memory_region_init_ram(e51_dtim_mem, NULL, "microchip.pfsoc.e51_dtim_mem",
> +                           memmap[MICROCHIP_PFSOC_E51_DTIM].size, &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +                                memmap[MICROCHIP_PFSOC_E51_DTIM].base,
> +                                e51_dtim_mem);
> +
> +    /* Bus Error Units */
> +    create_unimplemented_device("microchip.pfsoc.buserr_unit0_mem",
> +        memmap[MICROCHIP_PFSOC_BUSERR_UNIT0].base,
> +        memmap[MICROCHIP_PFSOC_BUSERR_UNIT0].size);
> +    create_unimplemented_device("microchip.pfsoc.buserr_unit1_mem",
> +        memmap[MICROCHIP_PFSOC_BUSERR_UNIT1].base,
> +        memmap[MICROCHIP_PFSOC_BUSERR_UNIT1].size);
> +    create_unimplemented_device("microchip.pfsoc.buserr_unit2_mem",
> +        memmap[MICROCHIP_PFSOC_BUSERR_UNIT2].base,
> +        memmap[MICROCHIP_PFSOC_BUSERR_UNIT2].size);
> +    create_unimplemented_device("microchip.pfsoc.buserr_unit3_mem",
> +        memmap[MICROCHIP_PFSOC_BUSERR_UNIT3].base,
> +        memmap[MICROCHIP_PFSOC_BUSERR_UNIT3].size);
> +    create_unimplemented_device("microchip.pfsoc.buserr_unit4_mem",
> +        memmap[MICROCHIP_PFSOC_BUSERR_UNIT4].base,
> +        memmap[MICROCHIP_PFSOC_BUSERR_UNIT4].size);
> +
> +    /* CLINT */
> +    sifive_clint_create(memmap[MICROCHIP_PFSOC_CLINT].base,
> +        memmap[MICROCHIP_PFSOC_CLINT].size, ms->smp.cpus,
> +        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
> +
> +    /* L2 cache controller */
> +    create_unimplemented_device("microchip.pfsoc.l2cc",
> +        memmap[MICROCHIP_PFSOC_L2CC].base, memmap[MICROCHIP_PFSOC_L2CC].size);
> +
> +    /*
> +     * Add L2-LIM at reset size.
> +     * This should be reduced in size as the L2 Cache Controller WayEnable
> +     * register is incremented. Unfortunately I don't see a nice (or any) way
> +     * to handle reducing or blocking out the L2 LIM while still allowing it
> +     * be re returned to all enabled after a reset. For the time being, just
> +     * leave it enabled all the time. This won't break anything, but will be
> +     * too generous to misbehaving guests.
> +     */
> +    memory_region_init_ram(l2lim_mem, NULL, "microchip.pfsoc.l2lim",
> +                           memmap[MICROCHIP_PFSOC_L2LIM].size, &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +                                memmap[MICROCHIP_PFSOC_L2LIM].base,
> +                                l2lim_mem);
> +
> +    /* create PLIC hart topology configuration string */
> +    plic_hart_config_len = (strlen(MICROCHIP_PFSOC_PLIC_HART_CONFIG) + 1) *
> +                           ms->smp.cpus;
> +    plic_hart_config = g_malloc0(plic_hart_config_len);
> +    for (i = 0; i < ms->smp.cpus; i++) {
> +        if (i != 0) {
> +            strncat(plic_hart_config, "," MICROCHIP_PFSOC_PLIC_HART_CONFIG,
> +                    plic_hart_config_len);
> +        } else {
> +            strncat(plic_hart_config, "M", plic_hart_config_len);
> +        }
> +        plic_hart_config_len -= (strlen(MICROCHIP_PFSOC_PLIC_HART_CONFIG) + 1);
> +    }
> +
> +    /* PLIC */
> +    s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
> +        plic_hart_config,
> +        MICROCHIP_PFSOC_PLIC_NUM_SOURCES,
> +        MICROCHIP_PFSOC_PLIC_NUM_PRIORITIES,
> +        MICROCHIP_PFSOC_PLIC_PRIORITY_BASE,
> +        MICROCHIP_PFSOC_PLIC_PENDING_BASE,
> +        MICROCHIP_PFSOC_PLIC_ENABLE_BASE,
> +        MICROCHIP_PFSOC_PLIC_ENABLE_STRIDE,
> +        MICROCHIP_PFSOC_PLIC_CONTEXT_BASE,
> +        MICROCHIP_PFSOC_PLIC_CONTEXT_STRIDE,
> +        memmap[MICROCHIP_PFSOC_PLIC].size);
> +    g_free(plic_hart_config);
> +
> +    /* SYSREG */
> +    create_unimplemented_device("microchip.pfsoc.sysreg",
> +        memmap[MICROCHIP_PFSOC_SYSREG].base,
> +        memmap[MICROCHIP_PFSOC_SYSREG].size);
> +
> +    /* MPUCFG */
> +    create_unimplemented_device("microchip.pfsoc.mpucfg",
> +        memmap[MICROCHIP_PFSOC_MPUCFG].base,
> +        memmap[MICROCHIP_PFSOC_MPUCFG].size);
> +
> +    /* eNVM */
> +    memory_region_init_rom(envm_data, OBJECT(dev), "microchip.pfsoc.envm.data",
> +                           memmap[MICROCHIP_PFSOC_ENVM_DATA].size,
> +                           &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +                                memmap[MICROCHIP_PFSOC_ENVM_DATA].base,
> +                                envm_data);
> +
> +    /* IOSCBCFG */
> +    create_unimplemented_device("microchip.pfsoc.ioscb.cfg",
> +        memmap[MICROCHIP_PFSOC_IOSCB_CFG].base,
> +        memmap[MICROCHIP_PFSOC_IOSCB_CFG].size);
> +}
> +
> +static void microchip_pfsoc_soc_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = microchip_pfsoc_soc_realize;
> +    /* Reason: Uses serial_hds in realize function, thus can't be used twice */
> +    dc->user_creatable = false;
> +}
> +
> +static const TypeInfo microchip_pfsoc_soc_type_info = {
> +    .name = TYPE_MICROCHIP_PFSOC,
> +    .parent = TYPE_DEVICE,
> +    .instance_size = sizeof(MicrochipPFSoCState),
> +    .instance_init = microchip_pfsoc_soc_instance_init,
> +    .class_init = microchip_pfsoc_soc_class_init,
> +};
> +
> +static void microchip_pfsoc_soc_register_types(void)
> +{
> +    type_register_static(&microchip_pfsoc_soc_type_info);
> +}
> +
> +type_init(microchip_pfsoc_soc_register_types)
> +
> +static void microchip_icicle_kit_machine_init(MachineState *machine)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    const struct MemmapEntry *memmap = microchip_pfsoc_memmap;
> +    MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(machine);
> +    MemoryRegion *system_memory = get_system_memory();
> +    MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> +
> +    /* Sanity check on RAM size */
> +    if (machine->ram_size < mc->default_ram_size) {
> +        char *sz = size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be bigger than %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    /* Initialize SoC */
> +    object_initialize_child(OBJECT(machine), "soc", &s->soc,
> +                            TYPE_MICROCHIP_PFSOC);
> +    qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
> +
> +    /* Register RAM */
> +    memory_region_init_ram(main_mem, NULL, "microchip.icicle.kit.ram",
> +                           machine->ram_size, &error_fatal);
> +    memory_region_add_subregion(system_memory,
> +                                memmap[MICROCHIP_PFSOC_DRAM].base, main_mem);
> +
> +    /* Load the firmware */
> +    riscv_find_and_load_firmware(machine, BIOS_FILENAME, RESET_VECTOR, NULL);
> +}
> +
> +static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "Microchip PolarFire SoC Icicle Kit";
> +    mc->init = microchip_icicle_kit_machine_init;
> +    mc->max_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT +
> +                   MICROCHIP_PFSOC_COMPUTE_CPU_COUNT;
> +    mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
> +    mc->default_cpus = mc->min_cpus;
> +    mc->default_ram_size = 1 * GiB;
> +}
> +
> +static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
> +    .name       = MACHINE_TYPE_NAME("microchip-icicle-kit"),
> +    .parent     = TYPE_MACHINE,
> +    .class_init = microchip_icicle_kit_machine_class_init,
> +    .instance_size = sizeof(MicrochipIcicleKitState),
> +};
> +
> +static void microchip_icicle_kit_machine_init_register_types(void)
> +{
> +    type_register_static(&microchip_icicle_kit_machine_typeinfo);
> +}
> +
> +type_init(microchip_icicle_kit_machine_init_register_types)
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> new file mode 100644
> index 0000000..1953ef1
> --- /dev/null
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -0,0 +1,88 @@
> +/*
> + * Microchip PolarFire SoC machine interface
> + *
> + * Copyright (c) 2020 Wind River Systems, Inc.
> + *
> + * Author:
> + *   Bin Meng <bin.meng@windriver.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_MICROCHIP_PFSOC_H
> +#define HW_MICROCHIP_PFSOC_H
> +
> +typedef struct MicrochipPFSoCState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +    CPUClusterState e_cluster;
> +    CPUClusterState u_cluster;
> +    RISCVHartArrayState e_cpus;
> +    RISCVHartArrayState u_cpus;
> +    DeviceState *plic;
> +} MicrochipPFSoCState;
> +
> +#define TYPE_MICROCHIP_PFSOC    "microchip.pfsoc"
> +#define MICROCHIP_PFSOC(obj) \
> +    OBJECT_CHECK(MicrochipPFSoCState, (obj), TYPE_MICROCHIP_PFSOC)
> +
> +typedef struct MicrochipIcicleKitState {
> +    /*< private >*/
> +    MachineState parent_obj;
> +
> +    /*< public >*/
> +    MicrochipPFSoCState soc;
> +} MicrochipIcicleKitState;
> +
> +#define TYPE_MICROCHIP_ICICLE_KIT_MACHINE \
> +    MACHINE_TYPE_NAME("microchip-icicle-kit")
> +#define MICROCHIP_ICICLE_KIT_MACHINE(obj) \
> +    OBJECT_CHECK(MicrochipIcicleKitState, (obj), \
> +                 TYPE_MICROCHIP_ICICLE_KIT_MACHINE)
> +
> +enum {
> +    MICROCHIP_PFSOC_DEBUG,
> +    MICROCHIP_PFSOC_E51_DTIM,
> +    MICROCHIP_PFSOC_BUSERR_UNIT0,
> +    MICROCHIP_PFSOC_BUSERR_UNIT1,
> +    MICROCHIP_PFSOC_BUSERR_UNIT2,
> +    MICROCHIP_PFSOC_BUSERR_UNIT3,
> +    MICROCHIP_PFSOC_BUSERR_UNIT4,
> +    MICROCHIP_PFSOC_CLINT,
> +    MICROCHIP_PFSOC_L2CC,
> +    MICROCHIP_PFSOC_L2LIM,
> +    MICROCHIP_PFSOC_PLIC,
> +    MICROCHIP_PFSOC_SYSREG,
> +    MICROCHIP_PFSOC_MPUCFG,
> +    MICROCHIP_PFSOC_ENVM_CFG,
> +    MICROCHIP_PFSOC_ENVM_DATA,
> +    MICROCHIP_PFSOC_IOSCB_CFG,
> +    MICROCHIP_PFSOC_DRAM,
> +};
> +
> +#define MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT    1
> +#define MICROCHIP_PFSOC_COMPUTE_CPU_COUNT       4
> +
> +#define MICROCHIP_PFSOC_PLIC_HART_CONFIG        "MS"
> +#define MICROCHIP_PFSOC_PLIC_NUM_SOURCES        185
> +#define MICROCHIP_PFSOC_PLIC_NUM_PRIORITIES     7
> +#define MICROCHIP_PFSOC_PLIC_PRIORITY_BASE      0x04
> +#define MICROCHIP_PFSOC_PLIC_PENDING_BASE       0x1000
> +#define MICROCHIP_PFSOC_PLIC_ENABLE_BASE        0x2000
> +#define MICROCHIP_PFSOC_PLIC_ENABLE_STRIDE      0x80
> +#define MICROCHIP_PFSOC_PLIC_CONTEXT_BASE       0x200000
> +#define MICROCHIP_PFSOC_PLIC_CONTEXT_STRIDE     0x1000
> +
> +#endif /* HW_MICROCHIP_PFSOC_H */
> --
> 2.7.4
>
>

