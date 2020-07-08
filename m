Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A024C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 18:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF03E206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 18:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQyWSMf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF03E206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtEaD-00049D-2a
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 14:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtEZN-0003Yx-Sk
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 14:13:21 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41]:36416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtEZJ-0002Hg-EG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 14:13:21 -0400
Received: by mail-vk1-xa41.google.com with SMTP id s192so10471806vkh.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yDThkRf8qv8XPk+C8dV8crx+G7M8tywNgr+kPEIKt+0=;
 b=sQyWSMf/YVHCtACPzRtunGczvMT66lZ14IgQakSQIoeQbk2DDogqdQX79mHRH//PBl
 Ukz7j90Fwe/PJQgFUXvPYysdYsrzg8ANF8tWIfoOqenn5FaIZRpfAlzRDqwrfaWUWo4m
 i/KPiv7AFWVhbmSOR6Dg6UqRTTCzO48UsR7Mt3RyfkNEfrcsF3fF7ZfUgx3jOv+xgzVz
 Osk01XtGpqU2BDsC9VDLUL+BpArP7gK2xTXsjwypxgwBox+BYmOgUYaQytwyfJH9ygL6
 WTPhJb30iLt9rxOVcIdpiPke7vIw7irUF90x+bmgfVJfl2tp1/m2WrEudW9LoMRFmZuQ
 QfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yDThkRf8qv8XPk+C8dV8crx+G7M8tywNgr+kPEIKt+0=;
 b=OHXE79taBLOSRS4rQU51es5wMuYctDr6+XbKoTpGOzFCY0L0p3ppPce6+kS7vWwMiq
 YgEdCseKxjntbvPnkUzzKqM+2jCF6kYKUCFeT18DEN3mghwCvhB+XXEAoGcDVCcevI+c
 SQ1Pkt0lHpf2kdd0TyTqZZFLfh7gme5HGSIdCmfvxtRfE1RDQRW8A6pWD4MttZ9qEUbK
 clvHQJgaaNjN+pmWCA8SxljzT39Tl1cgehaTPB492bMZ4Zpt9QHtO4IVWiVVIqlikpJG
 WPih3xkEATyEdJuy89Qm08cIq8vY/CWGcxq6bjlUiI8Ww72Df27eWidxGK/csrp1cemW
 omNw==
X-Gm-Message-State: AOAM5337C2JQUvh1vB76b+mbBbhFxR7RDalNpMrDClhddqlqt0JddFdn
 4lWj4ZRqvsXsjceRJSKA5UpRLmbinoH9pRRHKmrQig==
X-Google-Smtp-Source: ABdhPJwBPGFab60xetBlXn7Igtk0Vus/TRLZhP395triO/a9ny0dF3XZNM7xZwjLVgqJvF7/2fJrjFkzifiJ+v82oMg=
X-Received: by 2002:a05:6122:130b:: with SMTP id
 e11mr11063088vkp.20.1594231995788; 
 Wed, 08 Jul 2020 11:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-6-hskinnemoen@google.com>
 <4b7130f2-032c-3067-b2b6-876a2b17b707@amsat.org>
In-Reply-To: <4b7130f2-032c-3067-b2b6-876a2b17b707@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Wed, 8 Jul 2020 11:13:04 -0700
Message-ID: <CAFQmdRYi5QFHbcWQH-bWqAsSCidzYMedC8n+mib1DPpJuEy-Rw@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] hw/arm: Add NPCM730 and NPCM750 SoC models
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a41;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 8, 2020 at 10:31 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Hi Havard,
>
> On 7/7/20 8:47 PM, Havard Skinnemoen wrote:
> > The Nuvoton NPCM7xx SoC family are used to implement Baseboard
> > Management Controllers in servers. While the family includes four SoCs,
> > this patch implements limited support for two of them: NPCM730 (targete=
d
> > for Data Center applications) and NPCM750 (targeted for Enterprise
> > applications).
> >
> > This patch includes little more than the bare minimum needed to boot a
> > Linux kernel built with NPCM7xx support in direct-kernel mode:
> >
> >   - Two Cortex-A9 CPU cores with built-in periperhals.
> >   - Global Configuration Registers.
> >   - Clock Management.
> >   - 3 Timer Modules with 5 timers each.
> >   - 4 serial ports.
> >
> > The chips themselves have a lot more features, some of which will be
> > added to the model at a later stage.
> >
> > Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> > ---
> >  hw/arm/Makefile.objs     |   1 +
> >  hw/arm/npcm7xx.c         | 328 +++++++++++++++++++++++++++++++++++++++
> >  include/hw/arm/npcm7xx.h |  81 ++++++++++
>
> Please have a look at the scripts/git.orderfile, using it would
> ease our reviews.

Oh cool.

git config diff.orderFile scripts/git.orderfile

>
> >  3 files changed, 410 insertions(+)
> >  create mode 100644 hw/arm/npcm7xx.c
> >  create mode 100644 include/hw/arm/npcm7xx.h
> >
> > diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
> > index 534a6a119e..13d163a599 100644
> > --- a/hw/arm/Makefile.objs
> > +++ b/hw/arm/Makefile.objs
> > @@ -41,6 +41,7 @@ obj-$(CONFIG_STM32F205_SOC) +=3D stm32f205_soc.o
> >  obj-$(CONFIG_STM32F405_SOC) +=3D stm32f405_soc.o
> >  obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zynqmp.o xlnx-zcu102.o
> >  obj-$(CONFIG_XLNX_VERSAL) +=3D xlnx-versal.o xlnx-versal-virt.o
> > +obj-$(CONFIG_NPCM7XX) +=3D npcm7xx.o
> >  obj-$(CONFIG_FSL_IMX25) +=3D fsl-imx25.o imx25_pdk.o
> >  obj-$(CONFIG_FSL_IMX31) +=3D fsl-imx31.o kzm.o
> >  obj-$(CONFIG_FSL_IMX6) +=3D fsl-imx6.o
> > diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> > new file mode 100644
> > index 0000000000..0a9e30f66f
> > --- /dev/null
> > +++ b/hw/arm/npcm7xx.c
> > @@ -0,0 +1,328 @@
> > +/*
> > + * Nuvoton NPCM7xx SoC family.
> > + *
> > + * Copyright 2020 Google LLC
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License as published by t=
he
> > + * Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful, but=
 WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licens=
e
> > + * for more details.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "exec/address-spaces.h"
> > +#include "hw/arm/npcm7xx.h"
> > +#include "hw/char/serial.h"
> > +#include "hw/loader.h"
> > +#include "hw/misc/unimp.h"
> > +#include "hw/qdev-properties.h"
> > +#include "qapi/error.h"
> > +#include "qemu/units.h"
> > +#include "sysemu/sysemu.h"
> > +
> > +/* The first half of the address space is reserved for DDR4 DRAM. */
> > +#define NPCM7XX_DRAM_BA         (0x00000000)
> > +#define NPCM7XX_DRAM_SZ         (2 * GiB)
> > +
> > +/*
> > + * This covers the whole MMIO space. We'll use this to catch any MMIO =
accesses
> > + * that aren't handled by any device.
> > + */
> > +#define NPCM7XX_MMIO_BA         (0x80000000)
> > +#define NPCM7XX_MMIO_SZ         (0x7FFD0000)
> > +
> > +/* Core system modules. */
> > +#define NPCM7XX_L2C_BA          (0xF03FC000)
> > +#define NPCM7XX_CPUP_BA         (0xF03FE000)
> > +#define NPCM7XX_GCR_BA          (0xF0800000)
> > +#define NPCM7XX_CLK_BA          (0xF0801000)
> > +
> > +/* Memory blocks at the end of the address space */
> > +#define NPCM7XX_RAM2_BA         (0xFFFD0000)
> > +#define NPCM7XX_RAM2_SZ         (128 * KiB)
> > +#define NPCM7XX_ROM_BA          (0xFFFF0000)
> > +#define NPCM7XX_ROM_SZ          (64 * KiB)
> > +
> > +/*
> > + * Interrupt lines going into the GIC. This does not include internal =
Cortex-A9
> > + * interrupts.
> > + */
> > +enum NPCM7xxInterrupt {
> > +    NPCM7XX_UART0_IRQ           =3D 2,
> > +    NPCM7XX_UART1_IRQ,
> > +    NPCM7XX_UART2_IRQ,
> > +    NPCM7XX_UART3_IRQ,
> > +    NPCM7XX_TIMER0_IRQ          =3D 32,   /* Timer Module 0 */
> > +    NPCM7XX_TIMER1_IRQ,
> > +    NPCM7XX_TIMER2_IRQ,
> > +    NPCM7XX_TIMER3_IRQ,
> > +    NPCM7XX_TIMER4_IRQ,
> > +    NPCM7XX_TIMER5_IRQ,                 /* Timer Module 1 */
> > +    NPCM7XX_TIMER6_IRQ,
> > +    NPCM7XX_TIMER7_IRQ,
> > +    NPCM7XX_TIMER8_IRQ,
> > +    NPCM7XX_TIMER9_IRQ,
> > +    NPCM7XX_TIMER10_IRQ,                /* Timer Module 2 */
> > +    NPCM7XX_TIMER11_IRQ,
> > +    NPCM7XX_TIMER12_IRQ,
> > +    NPCM7XX_TIMER13_IRQ,
> > +    NPCM7XX_TIMER14_IRQ,
> > +};
> > +
> > +/* Total number of GIC interrupts, including internal Cortex-A9 interr=
upts. */
> > +#define NPCM7XX_NUM_IRQ         (160)
> > +
> > +/* Register base address for each Timer Module */
> > +static const hwaddr npcm7xx_tim_addr[] =3D {
> > +    0xF0008000,
> > +    0xF0009000,
> > +    0xF000A000,
>
> Here caps hex ...
>
> > +};
> > +
> > +/* Register base address for each 16550 UART */
> > +static const hwaddr npcm7xx_uart_addr[] =3D {
> > +    0xF0001000,
> > +    0xF0002000,
> > +    0xF0003000,
> > +    0xF0004000,
> > +};
> > +
> > +void npcm7xx_write_secondary_boot(ARMCPU *cpu, const struct arm_boot_i=
nfo *info)
> > +{
> > +    /*
> > +     * The default smpboot stub halts the secondary CPU with a 'wfi'
> > +     * instruction, but the arch/arm/mach-npcm/platsmp.c in the Linux =
kernel
> > +     * does not send an IPI to wake it up, so the second CPU fails to =
boot. So
> > +     * we need to provide our own smpboot stub that can not use 'wfi',=
 it has
> > +     * to spin the secondary CPU until the first CPU writes to the SCR=
PAD reg.
> > +     */
> > +    uint32_t smpboot[] =3D {
> > +        0xe59f2018,     /* ldr r2, bootreg_addr */
> > +        0xe3a00000,     /* mov r0, #0 */
> > +        0xe5820000,     /* str r0, [r2] */
> > +        0xe320f002,     /* wfe */
> > +        0xe5921000,     /* ldr r1, [r2] */
> > +        0xe1110001,     /* tst r1, r1 */
> > +        0x0afffffb,     /* beq <wfe> */
> > +        0xe12fff11,     /* bx r1 */
>
> ... here small hex. Pick one style?

Oh wow, I'm being super inconsistent. I'll standardize on small hex through=
out.

>
> > +        NPCM7XX_SMP_BOOTREG_ADDR,
> > +    };
> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(smpboot); i++) {
> > +        smpboot[i] =3D tswap32(smpboot[i]);
> > +    }
> > +
> > +    rom_add_blob_fixed("smpboot", smpboot, sizeof(smpboot),
> > +                       NPCM7XX_SMP_LOADER_START);
> > +}
> > +
> > +static qemu_irq npcm7xx_irq(NPCM7xxState *s, int n)
> > +{
> > +    return qdev_get_gpio_in(DEVICE(&s->a9mpcore), n);
> > +}
> > +
> > +static void npcm7xx_init(Object *obj)
> > +{
> > +    NPCM7xxState *s =3D NPCM7XX(obj);
> > +    int i;
> > +
> > +    for (i =3D 0; i < NPCM7XX_MAX_NUM_CPUS; i++) {
> > +        object_initialize_child(obj, "cpu[*]", &s->cpu[i],
> > +                                ARM_CPU_TYPE_NAME("cortex-a9"));
> > +    }
> > +
> > +    object_initialize_child(obj, "a9mpcore", &s->a9mpcore, TYPE_A9MPCO=
RE_PRIV);
> > +    object_initialize_child(obj, "gcr", &s->gcr, TYPE_NPCM7XX_GCR);
> > +    object_property_add_alias(obj, "power-on-straps", OBJECT(&s->gcr),
> > +                              "power-on-straps");
> > +    object_initialize_child(obj, "clk", &s->clk, TYPE_NPCM7XX_CLK);
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(s->tim); i++) {
> > +        object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7X=
X_TIMER);
> > +    }
> > +}
> > +
> > +static void npcm7xx_realize(DeviceState *dev, Error **errp)
> > +{
> > +    NPCM7xxState *s =3D NPCM7XX(dev);
> > +    NPCM7xxClass *nc =3D NPCM7XX_GET_CLASS(s);
> > +    Error *err =3D NULL;
> > +    int i;
> > +
> > +    /* I/O space -- unimplemented unless overridden below. */
> > +    create_unimplemented_device("npcm7xx.io", NPCM7XX_MMIO_BA, NPCM7XX=
_MMIO_SZ);
>
> I still insist this is not the best, but as "The data sheet for these
> SoCs is not generally available" there is not much I can suggest to
> improve.

OK, I'll try what you suggested in the next message.

> > +
> > +    /* CPUs */
> > +    for (i =3D 0; i < nc->num_cpus; i++) {
> > +        object_property_set_int(OBJECT(&s->cpu[i]),
> > +                                arm_cpu_mp_affinity(i, NPCM7XX_MAX_NUM=
_CPUS),
> > +                                "mp-affinity", &error_abort);
> > +        object_property_set_int(OBJECT(&s->cpu[i]), NPCM7XX_GIC_CPU_IF=
_ADDR,
> > +                                "reset-cbar", &error_abort);
> > +        object_property_set_bool(OBJECT(&s->cpu[i]), true,
> > +                                 "reset-hivecs", &error_abort);
> > +
> > +        /* Disable security extensions. */
> > +        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3", NULL))=
 {
>
> You know these are cortex-a9 right? Why bother checking?

Most other SoCs do, but you're right, might be better to abort if the
CPU isn't what we expect.

>
> > +            object_property_set_bool(OBJECT(&s->cpu[i]), false, "has_e=
l3",
> > +                                     &error_abort);
> > +        }
> > +
> > +        qdev_realize(DEVICE(&s->cpu[i]), NULL, &err);
> > +        if (err) {
> > +            error_propagate(errp, err);
>
> Since you don't plan to create a SoC at runtime and hot-plug it, I'd
> simplify by using &error_abort everywhere in this function, and forget
> about propagating.

Is it safe to assume we'll never hot-plug SoCs?

I can't think of a good use case for it, and removing error
propagation will make the code significantly shorter and easier to
follow, so I'll do what you suggest.

> > +            return;
> > +        }
> > +    }
> > +
> > +    /* A9MPCORE peripherals */
> > +    object_property_set_int(OBJECT(&s->a9mpcore), nc->num_cpus, "num-c=
pu",
> > +                            &error_abort);
>
> See, you already use &error_abort ;)

Right, I generally only propagate errors from realize(), but I guess
that's not necessary either.

> > +    object_property_set_int(OBJECT(&s->a9mpcore), NPCM7XX_NUM_IRQ, "nu=
m-irq",
> > +                            &error_abort);
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), &err);
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +    }
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->a9mpcore), 0, NPCM7XX_CPUP_BA);
> > +
> > +    for (i =3D 0; i < nc->num_cpus; i++) {
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i,
> > +                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CP=
U_IRQ));
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i + nc->num_c=
pus,
> > +                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CP=
U_FIQ));
> > +    }
> > +
> > +    /* L2 cache controller */
> > +    sysbus_create_simple("l2x0", NPCM7XX_L2C_BA, NULL);
> > +
> > +    /* System Global Control Registers (GCR) */
> > +    object_property_set_int(OBJECT(&s->gcr), nc->disabled_modules,
> > +                            "disabled-modules", &error_abort);
> > +    object_property_set_link(OBJECT(&s->gcr), OBJECT(s->dram), "dram",
> > +                             &error_abort);
>
> I guess you can simplify using in npcm7xx_init():
>
>       object_property_add_const_link(obj, "dram-mr", OBJECT(&s->gcr));
>
> And in npcm7xx_gcr_realize()
>
>     obj =3D object_property_get_link(OBJECT(dev), "dram-mr", &err);
>     if (obj =3D=3D NULL) {
>         error_setg(errp, "%s: required dram-mr link not found: %s",
>                    __func__, error_get_pretty(err));
>         return;
>     }
>     s->dram =3D MEMORY_REGION(obj);

OK, I'll try that, thanks!

> > +    sysbus_realize(SYS_BUS_DEVICE(&s->gcr), &err);
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gcr), 0, NPCM7XX_GCR_BA);
> > +
> > +    /* Clock Control Registers (CLK) */
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->clk), &err);
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->clk), 0, NPCM7XX_CLK_BA);
> > +
> > +    /* Timer Modules (TIM) */
> > +    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_tim_addr) !=3D ARRAY_SIZE(s->=
tim));
> > +    for (i =3D 0; i < ARRAY_SIZE(s->tim); i++) {
> > +        SysBusDevice *sbd =3D SYS_BUS_DEVICE(&s->tim[i]);
> > +        int first_irq;
> > +        int j;
> > +
> > +        sysbus_realize(sbd, &err);
> > +        if (err) {
> > +            error_propagate(errp, err);
> > +            return;
> > +        }
> > +        sysbus_mmio_map(sbd, 0, npcm7xx_tim_addr[i]);
> > +
> > +        first_irq =3D NPCM7XX_TIMER0_IRQ + i * NPCM7XX_TIMERS_PER_CTRL=
;
> > +        for (j =3D 0; j < NPCM7XX_TIMERS_PER_CTRL; j++) {
> > +            qemu_irq irq =3D npcm7xx_irq(s, first_irq + j);
> > +            sysbus_connect_irq(sbd, j, irq);
> > +        }
> > +    }
> > +
> > +    /* UART0..3 (16550 compatible) */
> > +    for (i =3D 0; i < ARRAY_SIZE(npcm7xx_uart_addr); i++) {
> > +        serial_mm_init(get_system_memory(), npcm7xx_uart_addr[i], 2,
> > +                       npcm7xx_irq(s, NPCM7XX_UART0_IRQ + i), 115200,
> > +                       serial_hd(i), DEVICE_LITTLE_ENDIAN);
> > +    }
> > +
> > +    /* RAM2 (SRAM) */
> > +    memory_region_init_ram(&s->sram, OBJECT(dev), "ram2",
> > +                           NPCM7XX_RAM2_SZ, &err);
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +    memory_region_add_subregion(get_system_memory(), NPCM7XX_RAM2_BA, =
&s->sram);
> > +
> > +    /* Internal ROM */
> > +    memory_region_init_rom(&s->irom, OBJECT(dev), "irom", NPCM7XX_ROM_=
SZ, &err);
> > +    if (err) {
> > +        error_propagate(errp, err);
> > +        return;
> > +    }
> > +    memory_region_add_subregion(get_system_memory(), NPCM7XX_ROM_BA, &=
s->irom);
> > +
> > +    /* External DDR4 SDRAM */
> > +    memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, =
s->dram);
>
> This doesn't look correct, the DRAM is an external component, not
> embedded within the SoC. See the manual ;)
> https://www.nuvoton.com/products/cloud-computing/ibmc/
>
> You should call that in npcm7xx_create_soc() (and eventually rename it)
> or add npcm7xx_create_dram(), maybe cleaner (and call it in each
> mc->init).

OK, will do.


> > +}
> > +
> > +static Property npcm7xx_properties[] =3D {
> > +    DEFINE_PROP_LINK("dram", NPCM7xxState, dram, TYPE_MEMORY_REGION,
> > +                     MemoryRegion *),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void npcm7xx_class_init(ObjectClass *oc, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> > +
> > +    dc->realize =3D npcm7xx_realize;
> > +    dc->user_creatable =3D false;
>
> This confirms you can safely use &error_abort in realize().

Got it.

> > +    device_class_set_props(dc, npcm7xx_properties);
> > +}
> > +
> > +static void npcm730_class_init(ObjectClass *oc, void *data)
> > +{
> > +    NPCM7xxClass *nc =3D NPCM7XX_CLASS(oc);
> > +
> > +    /* NPCM730 is optimized for data center use, so no graphics, etc. =
*/
> > +    nc->disabled_modules =3D 0x00300395;
> > +    nc->num_cpus =3D 2;
> > +}
> > +
> > +static void npcm750_class_init(ObjectClass *oc, void *data)
> > +{
> > +    NPCM7xxClass *nc =3D NPCM7XX_CLASS(oc);
> > +
> > +    /* NPCM750 has 2 cores and a full set of peripherals */
> > +    nc->disabled_modules =3D 0x00000000;
> > +    nc->num_cpus =3D 2;
> > +}
> > +
> > +static const TypeInfo npcm7xx_soc_types[] =3D {
> > +    {
> > +        .name           =3D TYPE_NPCM7XX,
> > +        .parent         =3D TYPE_DEVICE,
> > +        .instance_size  =3D sizeof(NPCM7xxState),
> > +        .instance_init  =3D npcm7xx_init,
> > +        .class_size     =3D sizeof(NPCM7xxClass),
> > +        .class_init     =3D npcm7xx_class_init,
> > +        .abstract       =3D true,
> > +    }, {
> > +        .name           =3D TYPE_NPCM730,
> > +        .parent         =3D TYPE_NPCM7XX,
> > +        .class_init     =3D npcm730_class_init,
> > +    }, {
> > +        .name           =3D TYPE_NPCM750,
> > +        .parent         =3D TYPE_NPCM7XX,
> > +        .class_init     =3D npcm750_class_init,
> > +    },
> > +};
> > +
> > +DEFINE_TYPES(npcm7xx_soc_types);
> > diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
> > new file mode 100644
> > index 0000000000..2ffa573b11
> > --- /dev/null
> > +++ b/include/hw/arm/npcm7xx.h
> > @@ -0,0 +1,81 @@
> > +/*
> > + * Nuvoton NPCM7xx SoC family.
> > + *
> > + * Copyright 2020 Google LLC
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y it
> > + * under the terms of the GNU General Public License as published by t=
he
> > + * Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful, but=
 WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public Licens=
e
> > + * for more details.
> > + */
> > +#ifndef NPCM7XX_H
> > +#define NPCM7XX_H
> > +
> > +#include "hw/boards.h"
> > +#include "hw/cpu/a9mpcore.h"
> > +#include "hw/misc/npcm7xx_clk.h"
> > +#include "hw/misc/npcm7xx_gcr.h"
> > +#include "hw/timer/npcm7xx_timer.h"
> > +#include "target/arm/cpu.h"
> > +
> > +#define NPCM7XX_MAX_NUM_CPUS    (2)
> > +
> > +/* Magic addresses for setting up direct kernel booting and SMP boot s=
tubs. */
> > +#define NPCM7XX_LOADER_START            (0x00000000)  /* Start of SDRA=
M */
> > +#define NPCM7XX_SMP_LOADER_START        (0xFFFF0000)  /* Boot ROM */
> > +#define NPCM7XX_SMP_BOOTREG_ADDR        (0xF080013C)  /* GCR.SCRPAD */
> > +#define NPCM7XX_GIC_CPU_IF_ADDR         (0xF03FE100)  /* GIC within A9=
 */
> > +
> > +typedef struct NPCM7xxState {
> > +    DeviceState         parent;
> > +
> > +    ARMCPU              cpu[NPCM7XX_MAX_NUM_CPUS];
> > +    A9MPPrivState       a9mpcore;
> > +
> > +    MemoryRegion        sram;
> > +    MemoryRegion        irom;
> > +    MemoryRegion        *dram;
> > +
> > +    NPCM7xxGCRState     gcr;
> > +    NPCM7xxCLKState     clk;
> > +    NPCM7xxTimerCtrlState tim[3];
> > +} NPCM7xxState;
> > +
> > +#define TYPE_NPCM7XX    "npcm7xx"
> > +#define NPCM7XX(obj)    OBJECT_CHECK(NPCM7xxState, (obj), TYPE_NPCM7XX=
)
> > +
> > +#define TYPE_NPCM730    "npcm730"
> > +#define TYPE_NPCM750    "npcm750"
> > +
> > +typedef struct NPCM7xxClass {
> > +    DeviceClass         parent;
>
> Similar comment that elsewhere on this series, if NPCM7xxClass not used
> outside of npcm7xx.c, keep it local.

OK, will do.

>
> Very good patch, I wanted to R-b it but the DRAM part makes me think
> it might be worth a v5...

Sure, I'll do a v5. Thanks a lot for reviewing!

Havard

