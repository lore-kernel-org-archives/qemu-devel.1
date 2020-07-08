Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582ADC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9D0206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcJPbder"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9D0206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDvw-0003VP-CF
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtDv2-0002cU-PT; Wed, 08 Jul 2020 13:31:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtDux-0005qC-E1; Wed, 08 Jul 2020 13:31:40 -0400
Received: by mail-wm1-x341.google.com with SMTP id l17so4122886wmj.0;
 Wed, 08 Jul 2020 10:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PazJKzqPpFj0CiJOqvhiVgUkpbLnlaw6zKZjlJg7qXQ=;
 b=dcJPbder3Odz/TcTWkO2fc1xZqfcwB+UnjcCwz5Op0ZhydmYZye8xMEdNa3W8eJJV5
 A+QRlZZCT98w1w8SwtWIgVOYinO/dwgYwh07bqMvHJYsH9Eiomps472ZnvyuFnJM5hfM
 a4vCeFpahFxz+8jlT+UpM6sMkqN2zge0UIMb0v399TylIJwzGcNR7moRrq6Mb+JZstBJ
 s2MNGMPfJ8aeuRGeu5qs/+5zLDqwHxqSDdP6k92RZrNmItpsrcnRZvhVByxtuDS+pcDo
 db5SEKZjHp6l2VAEjtmPdnFVvuRE3WyRnLZZalce82E9P/hV1fgv+7O69aOx9Amf4eGf
 wCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=PazJKzqPpFj0CiJOqvhiVgUkpbLnlaw6zKZjlJg7qXQ=;
 b=P5ygnZFiYb1KHB986cg1nlaX+HG/DsANspYdv7KbJVc0LsZ+8ejIDKkuHrBN0gHg3/
 RE2eeJTjMpG/PxjlN0wKkvPmNu4rtUKxx86T92FbBnyOFx/P2HchEPhIEpNlHhN+76Yx
 D7morVZYWET+1BGB2lLULUfFrDrs9Lahb59pmuVRL48fgKudxqwOtZei5wJtYPCE8O6y
 SlTU1k8zPiGAEoj82EdQ7xQazzJvHxuQc0JTLbE7N5GNOdSDUQ96kuVwe0ymLv/EikNm
 iUQIRchq9xPi9COrb5XS3u1rMUC5aD9so5udtLI005zTA3xAUbm+xGI85Sou1ShCNo9Q
 l0Xg==
X-Gm-Message-State: AOAM532kffRzWIdbMTOXbp9zQGp8Oy8aG6b8+ALhIPrgi3hxdnRvBRkf
 fG7Y4tfNh88/Ny3OCe/5Kzc=
X-Google-Smtp-Source: ABdhPJx2pRPoNWTfzomqorPI0gzufs9Le/Zxs4UCf/BM5qUjaKAXFTZjLwHN6q2nMHhmkXn7CMWRzQ==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr10219546wmo.169.1594229493150; 
 Wed, 08 Jul 2020 10:31:33 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k14sm816657wrn.76.2020.07.08.10.31.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 10:31:32 -0700 (PDT)
Subject: Re: [PATCH v4 05/12] hw/arm: Add NPCM730 and NPCM750 SoC models
To: Havard Skinnemoen <hskinnemoen@google.com>, peter.maydell@linaro.org
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-6-hskinnemoen@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <4b7130f2-032c-3067-b2b6-876a2b17b707@amsat.org>
Date: Wed, 8 Jul 2020 19:31:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200707184730.3047754-6-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: kfting@nuvoton.com, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Havard,

On 7/7/20 8:47 PM, Havard Skinnemoen wrote:
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
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  hw/arm/Makefile.objs     |   1 +
>  hw/arm/npcm7xx.c         | 328 +++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/npcm7xx.h |  81 ++++++++++

Please have a look at the scripts/git.orderfile, using it would
ease our reviews.

>  3 files changed, 410 insertions(+)
>  create mode 100644 hw/arm/npcm7xx.c
>  create mode 100644 include/hw/arm/npcm7xx.h
> 
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
> diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
> new file mode 100644
> index 0000000000..0a9e30f66f
> --- /dev/null
> +++ b/hw/arm/npcm7xx.c
> @@ -0,0 +1,328 @@
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
> +#include "hw/arm/npcm7xx.h"
> +#include "hw/char/serial.h"
> +#include "hw/loader.h"
> +#include "hw/misc/unimp.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qemu/units.h"
> +#include "sysemu/sysemu.h"
> +
> +/* The first half of the address space is reserved for DDR4 DRAM. */
> +#define NPCM7XX_DRAM_BA         (0x00000000)
> +#define NPCM7XX_DRAM_SZ         (2 * GiB)
> +
> +/*
> + * This covers the whole MMIO space. We'll use this to catch any MMIO accesses
> + * that aren't handled by any device.
> + */
> +#define NPCM7XX_MMIO_BA         (0x80000000)
> +#define NPCM7XX_MMIO_SZ         (0x7FFD0000)
> +
> +/* Core system modules. */
> +#define NPCM7XX_L2C_BA          (0xF03FC000)
> +#define NPCM7XX_CPUP_BA         (0xF03FE000)
> +#define NPCM7XX_GCR_BA          (0xF0800000)
> +#define NPCM7XX_CLK_BA          (0xF0801000)
> +
> +/* Memory blocks at the end of the address space */
> +#define NPCM7XX_RAM2_BA         (0xFFFD0000)
> +#define NPCM7XX_RAM2_SZ         (128 * KiB)
> +#define NPCM7XX_ROM_BA          (0xFFFF0000)
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
> +    0xF0008000,
> +    0xF0009000,
> +    0xF000A000,

Here caps hex ...

> +};
> +
> +/* Register base address for each 16550 UART */
> +static const hwaddr npcm7xx_uart_addr[] = {
> +    0xF0001000,
> +    0xF0002000,
> +    0xF0003000,
> +    0xF0004000,
> +};
> +
> +void npcm7xx_write_secondary_boot(ARMCPU *cpu, const struct arm_boot_info *info)
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

... here small hex. Pick one style?

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
> +    Error *err = NULL;
> +    int i;
> +
> +    /* I/O space -- unimplemented unless overridden below. */
> +    create_unimplemented_device("npcm7xx.io", NPCM7XX_MMIO_BA, NPCM7XX_MMIO_SZ);

I still insist this is not the best, but as "The data sheet for these
SoCs is not generally available" there is not much I can suggest to
improve.

> +
> +    /* CPUs */
> +    for (i = 0; i < nc->num_cpus; i++) {
> +        object_property_set_int(OBJECT(&s->cpu[i]),
> +                                arm_cpu_mp_affinity(i, NPCM7XX_MAX_NUM_CPUS),
> +                                "mp-affinity", &error_abort);
> +        object_property_set_int(OBJECT(&s->cpu[i]), NPCM7XX_GIC_CPU_IF_ADDR,
> +                                "reset-cbar", &error_abort);
> +        object_property_set_bool(OBJECT(&s->cpu[i]), true,
> +                                 "reset-hivecs", &error_abort);
> +
> +        /* Disable security extensions. */
> +        if (object_property_find(OBJECT(&s->cpu[i]), "has_el3", NULL)) {

You know these are cortex-a9 right? Why bother checking?

> +            object_property_set_bool(OBJECT(&s->cpu[i]), false, "has_el3",
> +                                     &error_abort);
> +        }
> +
> +        qdev_realize(DEVICE(&s->cpu[i]), NULL, &err);
> +        if (err) {
> +            error_propagate(errp, err);

Since you don't plan to create a SoC at runtime and hot-plug it, I'd
simplify by using &error_abort everywhere in this function, and forget
about propagating.

> +            return;
> +        }
> +    }
> +
> +    /* A9MPCORE peripherals */
> +    object_property_set_int(OBJECT(&s->a9mpcore), nc->num_cpus, "num-cpu",
> +                            &error_abort);

See, you already use &error_abort ;)

> +    object_property_set_int(OBJECT(&s->a9mpcore), NPCM7XX_NUM_IRQ, "num-irq",
> +                            &error_abort);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +    }
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
> +    /* System Global Control Registers (GCR) */
> +    object_property_set_int(OBJECT(&s->gcr), nc->disabled_modules,
> +                            "disabled-modules", &error_abort);
> +    object_property_set_link(OBJECT(&s->gcr), OBJECT(s->dram), "dram",
> +                             &error_abort);

I guess you can simplify using in npcm7xx_init():

      object_property_add_const_link(obj, "dram-mr", OBJECT(&s->gcr));

And in npcm7xx_gcr_realize()

    obj = object_property_get_link(OBJECT(dev), "dram-mr", &err);
    if (obj == NULL) {
        error_setg(errp, "%s: required dram-mr link not found: %s",
                   __func__, error_get_pretty(err));
        return;
    }
    s->dram = MEMORY_REGION(obj);

> +    sysbus_realize(SYS_BUS_DEVICE(&s->gcr), &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gcr), 0, NPCM7XX_GCR_BA);
> +
> +    /* Clock Control Registers (CLK) */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->clk), &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->clk), 0, NPCM7XX_CLK_BA);
> +
> +    /* Timer Modules (TIM) */
> +    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm7xx_tim_addr) != ARRAY_SIZE(s->tim));
> +    for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
> +        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->tim[i]);
> +        int first_irq;
> +        int j;
> +
> +        sysbus_realize(sbd, &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
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
> +                           NPCM7XX_RAM2_SZ, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(get_system_memory(), NPCM7XX_RAM2_BA, &s->sram);
> +
> +    /* Internal ROM */
> +    memory_region_init_rom(&s->irom, OBJECT(dev), "irom", NPCM7XX_ROM_SZ, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    memory_region_add_subregion(get_system_memory(), NPCM7XX_ROM_BA, &s->irom);
> +
> +    /* External DDR4 SDRAM */
> +    memory_region_add_subregion(get_system_memory(), NPCM7XX_DRAM_BA, s->dram);

This doesn't look correct, the DRAM is an external component, not
embedded within the SoC. See the manual ;)
https://www.nuvoton.com/products/cloud-computing/ibmc/

You should call that in npcm7xx_create_soc() (and eventually rename it)
or add npcm7xx_create_dram(), maybe cleaner (and call it in each
mc->init).

> +}
> +
> +static Property npcm7xx_properties[] = {
> +    DEFINE_PROP_LINK("dram", NPCM7xxState, dram, TYPE_MEMORY_REGION,
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

This confirms you can safely use &error_abort in realize().

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
> diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
> new file mode 100644
> index 0000000000..2ffa573b11
> --- /dev/null
> +++ b/include/hw/arm/npcm7xx.h
> @@ -0,0 +1,81 @@
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
> +/* Magic addresses for setting up direct kernel booting and SMP boot stubs. */
> +#define NPCM7XX_LOADER_START            (0x00000000)  /* Start of SDRAM */
> +#define NPCM7XX_SMP_LOADER_START        (0xFFFF0000)  /* Boot ROM */
> +#define NPCM7XX_SMP_BOOTREG_ADDR        (0xF080013C)  /* GCR.SCRPAD */
> +#define NPCM7XX_GIC_CPU_IF_ADDR         (0xF03FE100)  /* GIC within A9 */
> +
> +typedef struct NPCM7xxState {
> +    DeviceState         parent;
> +
> +    ARMCPU              cpu[NPCM7XX_MAX_NUM_CPUS];
> +    A9MPPrivState       a9mpcore;
> +
> +    MemoryRegion        sram;
> +    MemoryRegion        irom;
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

Similar comment that elsewhere on this series, if NPCM7xxClass not used
outside of npcm7xx.c, keep it local.

Very good patch, I wanted to R-b it but the DRAM part makes me think
it might be worth a v5...

Regards,

Phil.

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
> + * npcm7xx_write_secondary_boot - Write stub for booting secondary CPU.
> + * @cpu: The CPU to be booted.
> + * @info: Boot info structure for the board.
> + *
> + * This will write a short code stub to the internal ROM that will keep the
> + * secondary CPU spinning until the primary CPU writes an address to the SCRPAD
> + * register in the GCR, after which the secondary CPU will jump there.
> + */
> +extern void npcm7xx_write_secondary_boot(ARMCPU *cpu,
> +                                         const struct arm_boot_info *info);
> +
> +#endif /* NPCM7XX_H */
> 


