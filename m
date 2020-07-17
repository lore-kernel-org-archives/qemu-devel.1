Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA7C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01D0920684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D0920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwPMg-00089Y-Ad
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 08:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jwPLz-0007fn-41
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:20:39 -0400
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:34364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jwPLv-00011V-Jw
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:20:38 -0400
Received: from player770.ha.ovh.net (unknown [10.108.54.172])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 96D8E25D701
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 14:20:31 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id 64B261486BCEA;
 Fri, 17 Jul 2020 12:20:23 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0036d196503-e7a1-48de-8f8b-adc2f4076e4c,EDCDB8C856EF0F0B0CA5B21EBB7B009702C7510A)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v6 04/13] hw/arm: Add NPCM730 and NPCM750 SoC models
To: Havard Skinnemoen <hskinnemoen@google.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20200717060258.1602319-1-hskinnemoen@google.com>
 <20200717060258.1602319-5-hskinnemoen@google.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <99db91b7-60e2-7212-abd2-a6505aee5d3d@kaod.org>
Date: Fri, 17 Jul 2020 14:20:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717060258.1602319-5-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10920947623444581316
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfeeigdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeffvddtudegieefudeugffhjefgieegieegleettdehgfeiieevueeihfegfefgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=87.98.178.58; envelope-from=clg@kaod.org;
 helo=17.mo3.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 08:20:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kfting@nuvoton.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Avi.Fishman@nuvoton.com, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 8:02 AM, Havard Skinnemoen wrote:
> The Nuvoton NPCM7xx SoC family are used to implement Baseboard
> Management Controllers in servers. While the family includes four SoCs,
> this patch implements limited support for two of them: NPCM730 (targeted
> for Data Center applications) and NPCM750 (targeted for Enterprise
> applications).
> 
> This patch includes little more than the bare minimum needed to boot a
> Linux kernel built with NPCM7xx support in direct-kernel mode:
> 
>   - Two Cortex-A9 CPU cores with built-in periperhals.
>   - Global Configuration Registers.
>   - Clock Management.
>   - 3 Timer Modules with 5 timers each.
>   - 4 serial ports.
> 
> The chips themselves have a lot more features, some of which will be
> added to the model at a later stage.
> 
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  include/hw/arm/npcm7xx.h |  85 ++++++++
>  hw/arm/npcm7xx.c         | 407 +++++++++++++++++++++++++++++++++++++++
>  hw/arm/Kconfig           |   5 +
>  hw/arm/Makefile.objs     |   1 +
>  4 files changed, 498 insertions(+)
>  create mode 100644 include/hw/arm/npcm7xx.h
>  create mode 100644 hw/arm/npcm7xx.c
> 
> diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
> new file mode 100644
> index 0000000000..e68d9c79e6
> --- /dev/null
> +++ b/include/hw/arm/npcm7xx.h
> @@ -0,0 +1,85 @@
> +/*
> + * Nuvoton NPCM7xx SoC family.
> + *
> + * Copyright 2020 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +#ifndef NPCM7XX_H
> +#define NPCM7XX_H
> +
> +#include "hw/boards.h"
> +#include "hw/cpu/a9mpcore.h"
> +#include "hw/misc/npcm7xx_clk.h"
> +#include "hw/misc/npcm7xx_gcr.h"
> +#include "hw/timer/npcm7xx_timer.h"
> +#include "target/arm/cpu.h"
> +
> +#define NPCM7XX_MAX_NUM_CPUS    (2)
> +
> +/* The first half of the address space is reserved for DDR4 DRAM. */
> +#define NPCM7XX_DRAM_BA         (0x00000000)
> +#define NPCM7XX_DRAM_SZ         (2 * GiB)
> +
> +/* Magic addresses for setting up direct kernel booting and SMP boot stubs. */
> +#define NPCM7XX_LOADER_START            (0x00000000)  /* Start of SDRAM */
> +#define NPCM7XX_SMP_LOADER_START        (0xffff0000)  /* Boot ROM */
> +#define NPCM7XX_SMP_BOOTREG_ADDR        (0xf080013c)  /* GCR.SCRPAD */
> +#define NPCM7XX_GIC_CPU_IF_ADDR         (0xf03fe100)  /* GIC within A9 */
> +
> +typedef struct NPCM7xxState {
> +    DeviceState         parent;
> +
> +    ARMCPU              cpu[NPCM7XX_MAX_NUM_CPUS];
> +    A9MPPrivState       a9mpcore;
> +
> +    MemoryRegion        sram;
> +    MemoryRegion        irom;
> +    MemoryRegion        ram3;
> +    MemoryRegion        *dram;
> +
> +    NPCM7xxGCRState     gcr;
> +    NPCM7xxCLKState     clk;
> +    NPCM7xxTimerCtrlState tim[3];
> +} NPCM7xxState;
> +
> +#define TYPE_NPCM7XX    "npcm7xx"
> +#define NPCM7XX(obj)    OBJECT_CHECK(NPCM7xxState, (obj), TYPE_NPCM7XX)
> +
> +#define TYPE_NPCM730    "npcm730"
> +#define TYPE_NPCM750    "npcm750"
> +
> +typedef struct NPCM7xxClass {
> +    DeviceClass         parent;
> +
> +    /* Bitmask of modules that are permanently disabled on this chip. */
> +    uint32_t            disabled_modules;
> +    /* Number of CPU cores enabled in this SoC class (may be 1 or 2). */
> +    uint32_t            num_cpus;
> +} NPCM7xxClass;
> +
> +#define NPCM7XX_CLASS(klass)                                            \
> +    OBJECT_CLASS_CHECK(NPCM7xxClass, (klass), TYPE_NPCM7XX)
> +#define NPCM7XX_GET_CLASS(obj)                                          \
> +    OBJECT_GET_CLASS(NPCM7xxClass, (obj), TYPE_NPCM7XX)
> +
> +/**
> + * npcm7xx_load_kernel - Loads memory with everything needed to boot
> + * @machine - The machine containing the SoC to be booted.
> + * @soc - The SoC containing the CPU to be booted.
> + *
> + * This will set up the ARM boot info structure for the specific NPCM7xx
> + * derivative and call arm_load_kernel() to set up loading of the kernel, etc.
> + * into memory, if requested by the user.
> + */
> +void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc);
> +
> +#endif /* NPCM7XX_H */
> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> new file mode 100644
> index 0000000000..9669ac5fa0
> --- /dev/null
> +++ b/hw/arm/npcm7xx.c
> @@ -0,0 +1,407 @@
> +/*
> + * Nuvoton NPCM7xx SoC family.
> + *
> + * Copyright 2020 Google LLC
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "exec/address-spaces.h"
> +#include "hw/arm/boot.h"
> +#include "hw/arm/npcm7xx.h"
> +#include "hw/char/serial.h"
> +#include "hw/loader.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qemu/units.h"
> +#include "sysemu/sysemu.h"
> +
> +/*
> + * This covers the whole MMIO space. We'll use this to catch any MMIO accesses
> + * that aren't handled by any device.
> + */
> +#define NPCM7XX_MMIO_BA         (0x80000000)
> +#define NPCM7XX_MMIO_SZ         (0x7ffd0000)
> +
> +/* Core system modules. */
> +#define NPCM7XX_L2C_BA          (0xf03fc000)
> +#define NPCM7XX_CPUP_BA         (0xf03fe000)
> +#define NPCM7XX_GCR_BA          (0xf0800000)
> +#define NPCM7XX_CLK_BA          (0xf0801000)
> +
> +/* Internal AHB SRAM */
> +#define NPCM7XX_RAM3_BA         (0xc0008000)
> +#define NPCM7XX_RAM3_SZ         (4 * KiB)
> +
> +/* Memory blocks at the end of the address space */
> +#define NPCM7XX_RAM2_BA         (0xfffd0000)
> +#define NPCM7XX_RAM2_SZ         (128 * KiB)
> +#define NPCM7XX_ROM_BA          (0xffff0000)
> +#define NPCM7XX_ROM_SZ          (64 * KiB)
> +
> +/*
> + * Interrupt lines going into the GIC. This does not include internal Cortex-A9
> + * interrupts.
> + */
> +enum NPCM7xxInterrupt {
> +    NPCM7XX_UART0_IRQ           = 2,
> +    NPCM7XX_UART1_IRQ,
> +    NPCM7XX_UART2_IRQ,
> +    NPCM7XX_UART3_IRQ,
> +    NPCM7XX_TIMER0_IRQ          = 32,   /* Timer Module 0 */
> +    NPCM7XX_TIMER1_IRQ,
> +    NPCM7XX_TIMER2_IRQ,
> +    NPCM7XX_TIMER3_IRQ,
> +    NPCM7XX_TIMER4_IRQ,
> +    NPCM7XX_TIMER5_IRQ,                 /* Timer Module 1 */
> +    NPCM7XX_TIMER6_IRQ,
> +    NPCM7XX_TIMER7_IRQ,
> +    NPCM7XX_TIMER8_IRQ,
> +    NPCM7XX_TIMER9_IRQ,
> +    NPCM7XX_TIMER10_IRQ,                /* Timer Module 2 */
> +    NPCM7XX_TIMER11_IRQ,
> +    NPCM7XX_TIMER12_IRQ,
> +    NPCM7XX_TIMER13_IRQ,
> +    NPCM7XX_TIMER14_IRQ,
> +};
> +
> +/* Total number of GIC interrupts, including internal Cortex-A9 interrupts. */
> +#define NPCM7XX_NUM_IRQ         (160)
> +
> +/* Register base address for each Timer Module */
> +static const hwaddr npcm7xx_tim_addr[] = {
> +    0xf0008000,
> +    0xf0009000,
> +    0xf000a000,
> +};
> +
> +/* Register base address for each 16550 UART */
> +static const hwaddr npcm7xx_uart_addr[] = {
> +    0xf0001000,
> +    0xf0002000,
> +    0xf0003000,
> +    0xf0004000,
> +};
> +
> +static void npcm7xx_write_secondary_boot(ARMCPU *cpu,
> +                                         const struct arm_boot_info *info)
> +{
> +    /*
> +     * The default smpboot stub halts the secondary CPU with a 'wfi'
> +     * instruction, but the arch/arm/mach-npcm/platsmp.c in the Linux kernel
> +     * does not send an IPI to wake it up, so the second CPU fails to boot. So
> +     * we need to provide our own smpboot stub that can not use 'wfi', it has
> +     * to spin the secondary CPU until the first CPU writes to the SCRPAD reg.
> +     */
> +    uint32_t smpboot[] = {
> +        0xe59f2018,     /* ldr r2, bootreg_addr */
> +        0xe3a00000,     /* mov r0, #0 */
> +        0xe5820000,     /* str r0, [r2] */
> +        0xe320f002,     /* wfe */
> +        0xe5921000,     /* ldr r1, [r2] */
> +        0xe1110001,     /* tst r1, r1 */
> +        0x0afffffb,     /* beq <wfe> */
> +        0xe12fff11,     /* bx r1 */
> +        NPCM7XX_SMP_BOOTREG_ADDR,
> +    };
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(smpboot); i++) {
> +        smpboot[i] = tswap32(smpboot[i]);
> +    }
> +
> +    rom_add_blob_fixed("smpboot", smpboot, sizeof(smpboot),
> +                       NPCM7XX_SMP_LOADER_START);
> +}
> +
> +static struct arm_boot_info npcm7xx_binfo = {
> +    .loader_start           = NPCM7XX_LOADER_START,
> +    .smp_loader_start       = NPCM7XX_SMP_LOADER_START,
> +    .smp_bootreg_addr       = NPCM7XX_SMP_BOOTREG_ADDR,
> +    .gic_cpu_if_addr        = NPCM7XX_GIC_CPU_IF_ADDR,
> +    .write_secondary_boot   = npcm7xx_write_secondary_boot,
> +    .board_id               = -1,
> +};
> +
> +void npcm7xx_load_kernel(MachineState *machine, NPCM7xxState *soc)
> +{
> +    NPCM7xxClass *sc = NPCM7XX_GET_CLASS(soc);
> +
> +    npcm7xx_binfo.ram_size = machine->ram_size;
> +    npcm7xx_binfo.nb_cpus = sc->num_cpus;
> +
> +    arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
> +}
> +
> +static qemu_irq npcm7xx_irq(NPCM7xxState *s, int n)
> +{
> +    return qdev_get_gpio_in(DEVICE(&s->a9mpcore), n);
> +}
> +
> +static void npcm7xx_init(Object *obj)
> +{
> +    NPCM7xxState *s = NPCM7XX(obj);
> +    int i;
> +
> +    for (i = 0; i < NPCM7XX_MAX_NUM_CPUS; i++) {
> +        object_initialize_child(obj, "cpu[*]", &s->cpu[i],
> +                                ARM_CPU_TYPE_NAME("cortex-a9"));
> +    }
> +
> +    object_initialize_child(obj, "a9mpcore", &s->a9mpcore, TYPE_A9MPCORE_PRIV);
> +    object_initialize_child(obj, "gcr", &s->gcr, TYPE_NPCM7XX_GCR);
> +    object_property_add_alias(obj, "power-on-straps", OBJECT(&s->gcr),
> +                              "power-on-straps");
> +    object_initialize_child(obj, "clk", &s->clk, TYPE_NPCM7XX_CLK);
> +
> +    for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
> +        object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7XX_TIMER);
> +    }
> +}
> +
> +static void npcm7xx_realize(DeviceState *dev, Error **errp)
> +{
> +    NPCM7xxState *s = NPCM7XX(dev);
> +    NPCM7xxClass *nc = NPCM7XX_GET_CLASS(s);
> +    int i;
> +
> +    if (memory_region_size(s->dram) > NPCM7XX_DRAM_SZ) {
> +        error_setg(errp, "%s: NPCM7xx cannot address more than %" PRIu64
> +                   " MiB of DRAM", __func__, NPCM7XX_DRAM_SZ / MiB);
> +        return;
> +    }
> +
> +    /* CPUs */
> +    for (i = 0; i < nc->num_cpus; i++) {
> +        object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
> +                                arm_cpu_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
> +                                &error_abort);
> +        object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
> +                                NPCM7XX_GIC_CPU_IF_ADDR, &error_abort);
> +        object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
> +                                 &error_abort);
> +
> +        /* Disable security extensions. */
> +        object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3", false,
> +                                 &error_abort);
> +
> +        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> +            return;
> +        }
> +    }
> +
> +    /* A9MPCORE peripherals. Can only fail if we pass bad parameters here. */
> +    object_property_set_int(OBJECT(&s->a9mpcore), "num-cpu", nc->num_cpus,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&s->a9mpcore), "num-irq", NPCM7XX_NUM_IRQ,
> +                            &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), &error_abort);

shouldn't we test the return value and use errp ? I don't know what
was agreed upon. 

> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->a9mpcore), 0, NPCM7XX_CPUP_BA);
> +
> +    for (i = 0; i < nc->num_cpus; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i,
> +                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_IRQ));
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i + nc->num_cpus,
> +                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
> +    }
> +
> +    /* L2 cache controller */
> +    sysbus_create_simple("l2x0", NPCM7XX_L2C_BA, NULL);
> +
> +    /* System Global Control Registers (GCR). Can fail due to user input. */
> +    object_property_set_int(OBJECT(&s->gcr), "disabled-modules",
> +                            nc->disabled_modules, &error_abort);
> +    object_property_add_const_link(OBJECT(&s->gcr), "dram-mr", OBJECT(s->dram));
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gcr), 0, NPCM7XX_GCR_BA);
> +
> +    /* Clock Control Registers (CLK). Cannot fail. */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->clk), &error_abort);

same here.

> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->clk), 0, NPCM7XX_CLK_BA);
> +
> +    /* Timer Modules (TIM). Cannot fail. */
> +    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_tim_addr) != ARRAY_SIZE(s->tim));
> +    for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
> +        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->tim[i]);
> +        int first_irq;
> +        int j;
> +
> +        sysbus_realize(sbd, &error_abort);

and here.

> +        sysbus_mmio_map(sbd, 0, npcm7xx_tim_addr[i]);
> +
> +        first_irq = NPCM7XX_TIMER0_IRQ + i * NPCM7XX_TIMERS_PER_CTRL;
> +        for (j = 0; j < NPCM7XX_TIMERS_PER_CTRL; j++) {
> +            qemu_irq irq = npcm7xx_irq(s, first_irq + j);
> +            sysbus_connect_irq(sbd, j, irq);
> +        }
> +    }
> +
> +    /* UART0..3 (16550 compatible) */
> +    for (i = 0; i < ARRAY_SIZE(npcm7xx_uart_addr); i++) {
> +        serial_mm_init(get_system_memory(), npcm7xx_uart_addr[i], 2,
> +                       npcm7xx_irq(s, NPCM7XX_UART0_IRQ + i), 115200,
> +                       serial_hd(i), DEVICE_LITTLE_ENDIAN);
> +    }
> +
> +    /* RAM2 (SRAM) */
> +    memory_region_init_ram(&s->sram, OBJECT(dev), "ram2",
> +                           NPCM7XX_RAM2_SZ, &error_abort);
> +    memory_region_add_subregion(get_system_memory(), NPCM7XX_RAM2_BA, &s->sram);
> +
> +    /* RAM3 (SRAM) */
> +    memory_region_init_ram(&s->ram3, OBJECT(dev), "ram3",
> +                           NPCM7XX_RAM3_SZ, &error_abort);
> +    memory_region_add_subregion(get_system_memory(), NPCM7XX_RAM3_BA, &s->ram3);
> +
> +    /* Internal ROM */
> +    memory_region_init_rom(&s->irom, OBJECT(dev), "irom", NPCM7XX_ROM_SZ,
> +                           &error_abort);
> +    memory_region_add_subregion(get_system_memory(), NPCM7XX_ROM_BA, &s->irom);
> +
> +    create_unimplemented_device("npcm7xx.shm",          0xc0001000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.vdmx",         0xe0800000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.pcierc",       0xe1000000,  64 * KiB);
> +    create_unimplemented_device("npcm7xx.kcs",          0xf0007000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.rng",          0xf000b000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.adc",          0xf000c000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.gfxi",         0xf000e000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.gpio[0]",      0xf0010000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.gpio[1]",      0xf0011000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.gpio[2]",      0xf0012000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.gpio[3]",      0xf0013000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.gpio[4]",      0xf0014000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.gpio[5]",      0xf0015000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.gpio[6]",      0xf0016000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.gpio[7]",      0xf0017000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[0]",     0xf0080000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[1]",     0xf0081000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[2]",     0xf0082000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[3]",     0xf0083000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[4]",     0xf0084000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[5]",     0xf0085000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[6]",     0xf0086000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[7]",     0xf0087000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[8]",     0xf0088000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[9]",     0xf0089000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[10]",    0xf008a000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[11]",    0xf008b000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[12]",    0xf008c000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[13]",    0xf008d000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[14]",    0xf008e000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.smbus[15]",    0xf008f000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.espi",         0xf009f000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.peci",         0xf0100000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.siox[1]",      0xf0101000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.siox[2]",      0xf0102000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.pwm[0]",       0xf0103000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.pwm[1]",       0xf0104000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.mft[0]",       0xf0180000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.mft[1]",       0xf0181000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.mft[2]",       0xf0182000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.mft[3]",       0xf0183000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.mft[4]",       0xf0184000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.mft[5]",       0xf0185000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.mft[6]",       0xf0186000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.mft[7]",       0xf0187000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.pspi1",        0xf0200000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.pspi2",        0xf0201000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.ahbpci",       0xf0400000,   1 * MiB);
> +    create_unimplemented_device("npcm7xx.mcphy",        0xf05f0000,  64 * KiB);
> +    create_unimplemented_device("npcm7xx.gmac1",        0xf0802000,   8 * KiB);
> +    create_unimplemented_device("npcm7xx.gmac2",        0xf0804000,   8 * KiB);
> +    create_unimplemented_device("npcm7xx.ehci",         0xf0806000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.ohci",         0xf0807000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.vcd",          0xf0810000,  64 * KiB);
> +    create_unimplemented_device("npcm7xx.ece",          0xf0820000,   8 * KiB);
> +    create_unimplemented_device("npcm7xx.vdma",         0xf0822000,   8 * KiB);
> +    create_unimplemented_device("npcm7xx.emc1",         0xf0825000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.emc2",         0xf0826000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.usbd[0]",      0xf0830000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.usbd[1]",      0xf0831000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.usbd[2]",      0xf0832000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.usbd[3]",      0xf0833000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.usbd[4]",      0xf0834000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.usbd[5]",      0xf0835000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.usbd[6]",      0xf0836000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.usbd[7]",      0xf0837000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.usbd[8]",      0xf0838000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.usbd[9]",      0xf0839000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.sd",           0xf0840000,   8 * KiB);
> +    create_unimplemented_device("npcm7xx.mmc",          0xf0842000,   8 * KiB);
> +    create_unimplemented_device("npcm7xx.pcimbx",       0xf0848000, 512 * KiB);
> +    create_unimplemented_device("npcm7xx.aes",          0xf0858000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.des",          0xf0859000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.sha",          0xf085a000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.secacc",       0xf085b000,   4 * KiB);
> +    create_unimplemented_device("npcm7xx.spixcs0",      0xf8000000,  16 * MiB);
> +    create_unimplemented_device("npcm7xx.spixcs1",      0xf9000000,  16 * MiB);
> +    create_unimplemented_device("npcm7xx.spix",         0xfb001000,   4 * KiB);
> +}
> +
> +static Property npcm7xx_properties[] = {
> +    DEFINE_PROP_LINK("dram-mr", NPCM7xxState, dram, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void npcm7xx_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = npcm7xx_realize;
> +    dc->user_creatable = false;
> +    device_class_set_props(dc, npcm7xx_properties);
> +}
> +
> +static void npcm730_class_init(ObjectClass *oc, void *data)
> +{
> +    NPCM7xxClass *nc = NPCM7XX_CLASS(oc);
> +
> +    /* NPCM730 is optimized for data center use, so no graphics, etc. */
> +    nc->disabled_modules = 0x00300395;
> +    nc->num_cpus = 2;
> +}
> +
> +static void npcm750_class_init(ObjectClass *oc, void *data)
> +{
> +    NPCM7xxClass *nc = NPCM7XX_CLASS(oc);
> +
> +    /* NPCM750 has 2 cores and a full set of peripherals */
> +    nc->disabled_modules = 0x00000000;
> +    nc->num_cpus = 2;
> +}
> +
> +static const TypeInfo npcm7xx_soc_types[] = {
> +    {
> +        .name           = TYPE_NPCM7XX,
> +        .parent         = TYPE_DEVICE,
> +        .instance_size  = sizeof(NPCM7xxState),
> +        .instance_init  = npcm7xx_init,
> +        .class_size     = sizeof(NPCM7xxClass),
> +        .class_init     = npcm7xx_class_init,
> +        .abstract       = true,
> +    }, {
> +        .name           = TYPE_NPCM730,
> +        .parent         = TYPE_NPCM7XX,
> +        .class_init     = npcm730_class_init,
> +    }, {
> +        .name           = TYPE_NPCM750,
> +        .parent         = TYPE_NPCM7XX,
> +        .class_init     = npcm750_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(npcm7xx_soc_types);
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 192a8dec3b..a31d0d282f 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -356,6 +356,11 @@ config XLNX_VERSAL
>  
>  config NPCM7XX
>      bool
> +    select A9MPCORE
> +    select ARM_GIC
> +    select PL310  # cache controller
> +    select SERIAL
> +    select UNIMP
>  
>  config FSL_IMX25
>      bool
> diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> index 534a6a119e..13d163a599 100644
> --- a/hw/arm/Makefile.objs
> +++ b/hw/arm/Makefile.objs
> @@ -41,6 +41,7 @@ obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
>  obj-$(CONFIG_STM32F405_SOC) += stm32f405_soc.o
>  obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
>  obj-$(CONFIG_XLNX_VERSAL) += xlnx-versal.o xlnx-versal-virt.o
> +obj-$(CONFIG_NPCM7XX) += npcm7xx.o
>  obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
>  obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
>  obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o
> 


