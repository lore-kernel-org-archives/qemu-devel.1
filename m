Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C8AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CD920679
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e49CxYh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CD920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jks9p-0000Wb-DW
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jks5j-0004db-NX; Mon, 15 Jun 2020 12:36:11 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:41893)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jks5Y-000866-7c; Mon, 15 Jun 2020 12:36:10 -0400
Received: by mail-il1-x142.google.com with SMTP id c75so15889989ila.8;
 Mon, 15 Jun 2020 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1FfcsUCEPsTQru4RMbM6Ct+uStqLhgT5r5WtCZkqnhc=;
 b=e49CxYh3o08wSweeet18/meOqvgswFFXcslJumGUJv8wRlA+9pLeiEugWg/n3b7d3b
 1zACh7YtuS5jCD967nbNQPya1+10xo+b0pmrrH7tXyrvA/ojKwNCuXvmu4V5o7d1ucvh
 5IwuRcyW7Jk7dfc7mmBHgSURE1BF6xQ6tYhQ9oossPhrg4yqu1bdmLGhnBEsVBFaFleN
 Twom+FaMGSjIr8jE4N7CwtzXPvwtsUCukjp4b1ETjHAelR+lWN5TiPivxGmmiYYNBR0B
 rDw2l9I5DJV2puBc0qUlXscIly07ARZjX8edSxZTAqG/DXkaD0YgVMo/+sQlw1DxarxB
 WxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1FfcsUCEPsTQru4RMbM6Ct+uStqLhgT5r5WtCZkqnhc=;
 b=rp8uYnO1ZO2xSTz1Ksn9134Xm6JpoCMvTdSS0ToYvvfFDjfA7KORa77oJLmvbYshpg
 8ZN1VicOJKmBCydNnIdLEmH629rektQO6kwUfCT/GET+xkBV7LPlx05uY0udBgOJGNpW
 239aahA/lW0/gGydZci18nwDxoZHTiua3Ra9O3d7ZNzHcFYt0GOGjSjTSBD2ocV1Jfm6
 ITpndABOZGlTDu5+6OJLUOKaX2uWpUU/TBqGsJX6/SlVxy8L34KtI1PGJGzqStWqHT8v
 aaOJqwPY9yMz55CdxiTKOOin3cNbM46aE+LU2SwKo9E79l9bssEAP/BaCeQes7su04I1
 KTBA==
X-Gm-Message-State: AOAM530AJ23G/ORKzalOgbg8hIFOLTATmRSlkzAujfQRSaghOmJeuUii
 /w3mP2JNmIEfQ4sdmB25P0tXRshq98gGNF+2MXE=
X-Google-Smtp-Source: ABdhPJzhkvE6+bl2S8SK1jjcMJTAe6659sNToiZJ4UzNkv2KzSzUecml+I0IkATVOOHspverLAdvfOmoUNCqXN/jAUY=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr27627729ili.40.1592238958090; 
 Mon, 15 Jun 2020 09:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-8-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-8-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 09:26:34 -0700
Message-ID: <CAKmqyKOMW5r-K-G=rftzrfvCgF_Pw6T40CH+Sjmetn4zjrivYg@mail.gmail.com>
Subject: Re: [PATCH 07/15] hw/riscv: sifive_u: Hook a GPIO controller
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 7:24 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> SiFive FU540 SoC integrates a GPIO controller with 16 GPIO lines.
> This hooks the exsiting SiFive GPIO model to the SoC, and adds its
> device tree data as well.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c         | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  include/hw/riscv/sifive_u.h | 19 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 8dc6842..881949b 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -11,8 +11,9 @@
>   * 1) CLINT (Core Level Interruptor)
>   * 2) PLIC (Platform Level Interrupt Controller)
>   * 3) PRCI (Power, Reset, Clock, Interrupt)
> - * 4) OTP (One-Time Programmable) memory with stored serial number
> - * 5) GEM (Gigabit Ethernet Controller) and management block
> + * 4) GPIO (General Purpose Input/Output Controller)
> + * 5) OTP (One-Time Programmable) memory with stored serial number
> + * 6) GEM (Gigabit Ethernet Controller) and management block
>   *
>   * This board currently generates devicetree dynamically that indicates at least
>   * two harts and up to five harts.
> @@ -75,6 +76,7 @@ static const struct MemmapEntry {
>      [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
>      [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
>      [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
> +    [SIFIVE_U_GPIO] =     { 0x10060000,     0x1000 },
>      [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
>      [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
>      [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
> @@ -268,6 +270,28 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      g_free(cells);
>      g_free(nodename);
>
> +    nodename = g_strdup_printf("/soc/gpio@%lx",
> +        (long)memmap[SIFIVE_U_GPIO].base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_cells(fdt, nodename, "clocks",
> +        prci_phandle, PRCI_CLK_TLCLK);
> +    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 2);
> +    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop_cell(fdt, nodename, "#gpio-cells", 2);
> +    qemu_fdt_setprop(fdt, nodename, "gpio-controller", NULL, 0);
> +    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +        0x0, memmap[SIFIVE_U_GPIO].base,
> +        0x0, memmap[SIFIVE_U_GPIO].size);
> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupts", SIFIVE_U_GPIO_IRQ0,
> +        SIFIVE_U_GPIO_IRQ1, SIFIVE_U_GPIO_IRQ2, SIFIVE_U_GPIO_IRQ3,
> +        SIFIVE_U_GPIO_IRQ4, SIFIVE_U_GPIO_IRQ5, SIFIVE_U_GPIO_IRQ6,
> +        SIFIVE_U_GPIO_IRQ7, SIFIVE_U_GPIO_IRQ8, SIFIVE_U_GPIO_IRQ9,
> +        SIFIVE_U_GPIO_IRQ10, SIFIVE_U_GPIO_IRQ11, SIFIVE_U_GPIO_IRQ12,
> +        SIFIVE_U_GPIO_IRQ13, SIFIVE_U_GPIO_IRQ14, SIFIVE_U_GPIO_IRQ15);
> +    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,gpio0");
> +    g_free(nodename);
> +
>      phy_phandle = phandle++;
>      nodename = g_strdup_printf("/soc/ethernet@%lx",
>          (long)memmap[SIFIVE_U_GEM].base);
> @@ -525,6 +549,8 @@ static void sifive_u_soc_instance_init(Object *obj)
>
>      sysbus_init_child_obj(obj, "prci", &s->prci, sizeof(s->prci),
>                            TYPE_SIFIVE_U_PRCI);
> +    sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
> +                          TYPE_SIFIVE_GPIO);
>      sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
>                            TYPE_SIFIVE_U_OTP);
>      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
> @@ -618,6 +644,20 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
>
> +    qdev_prop_set_uint32(DEVICE(&s->gpio), "ngpio", 16);
> +    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_U_GPIO].base);
> +
> +    /* Pass all GPIOs to the SOC layer so they are available to the board */
> +    qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
> +
> +    /* Connect GPIO interrupts to the PLIC */
> +    for (i = 0; i < 16; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), i,
> +                           qdev_get_gpio_in(DEVICE(s->plic),
> +                                            SIFIVE_U_GPIO_IRQ0 + i));
> +    }
> +
>      qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
>      object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 16c297e..dcf7f3b 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -22,6 +22,7 @@
>  #include "hw/net/cadence_gem.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/riscv/sifive_cpu.h"
> +#include "hw/riscv/sifive_gpio.h"
>  #include "hw/riscv/sifive_u_prci.h"
>  #include "hw/riscv/sifive_u_otp.h"
>
> @@ -40,6 +41,7 @@ typedef struct SiFiveUSoCState {
>      RISCVHartArrayState u_cpus;
>      DeviceState *plic;
>      SiFiveUPRCIState prci;
> +    SIFIVEGPIOState gpio;
>      SiFiveUOTPState otp;
>      CadenceGEMState gem;
>
> @@ -73,6 +75,7 @@ enum {
>      SIFIVE_U_PRCI,
>      SIFIVE_U_UART0,
>      SIFIVE_U_UART1,
> +    SIFIVE_U_GPIO,
>      SIFIVE_U_OTP,
>      SIFIVE_U_FLASH0,
>      SIFIVE_U_DRAM,
> @@ -83,6 +86,22 @@ enum {
>  enum {
>      SIFIVE_U_UART0_IRQ = 4,
>      SIFIVE_U_UART1_IRQ = 5,
> +    SIFIVE_U_GPIO_IRQ0 = 7,
> +    SIFIVE_U_GPIO_IRQ1 = 8,
> +    SIFIVE_U_GPIO_IRQ2 = 9,
> +    SIFIVE_U_GPIO_IRQ3 = 10,
> +    SIFIVE_U_GPIO_IRQ4 = 11,
> +    SIFIVE_U_GPIO_IRQ5 = 12,
> +    SIFIVE_U_GPIO_IRQ6 = 13,
> +    SIFIVE_U_GPIO_IRQ7 = 14,
> +    SIFIVE_U_GPIO_IRQ8 = 15,
> +    SIFIVE_U_GPIO_IRQ9 = 16,
> +    SIFIVE_U_GPIO_IRQ10 = 17,
> +    SIFIVE_U_GPIO_IRQ11 = 18,
> +    SIFIVE_U_GPIO_IRQ12 = 19,
> +    SIFIVE_U_GPIO_IRQ13 = 20,
> +    SIFIVE_U_GPIO_IRQ14 = 21,
> +    SIFIVE_U_GPIO_IRQ15 = 22,
>      SIFIVE_U_GEM_IRQ = 0x35
>  };
>
> --
> 2.7.4
>
>

