Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921FDC2BB84
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE582084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEpJk+24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE582084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEHi8-00052l-AJ
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEHgb-0003Qu-3q; Fri, 04 Sep 2020 15:47:49 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:36576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEHgY-0005ez-Uf; Fri, 04 Sep 2020 15:47:48 -0400
Received: by mail-il1-x143.google.com with SMTP id p13so7400117ils.3;
 Fri, 04 Sep 2020 12:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y/7BEGdDmB1KinVoVuLSRtc/+pMk2QLRHR4+GOO40r4=;
 b=UEpJk+24C0Ys/JUuZZYIDVYj+cqSUvosehU/IcsDfFSM0OECxeiqFlSptAPK9J8/ek
 7hncs5c+8kWLxTil6qGso+zk+0pEGjGsiZXpZIcLgIJyiYON7As+BdI/ANHuYkAFm0RD
 OqNnp74RVbcz7wGMsk38UabpdvUl0SRXaFM1fyZreFz/xdskrXRxmiG2v57bpNlKAiw7
 WV57fPN06TqgOhG49oEyOaVnj++E/xbULB1Ne8kOXtAla/RLwKbhP/ZLe4eMD/vj8dqp
 cIRoUwwvx0YEFhTsU3V0Kieck9L1VhiCmgWNuqtrooWq/+3xKQ+65EO0i+ilAMMnwLfV
 Yrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y/7BEGdDmB1KinVoVuLSRtc/+pMk2QLRHR4+GOO40r4=;
 b=LKjuOMKwa45sMaxYWG/eiY56w5Qh+WDGWF6iBRDQq5yYbEXrupTDS6ela5NdFOC/Zn
 obH3XFiHYjK9KUuzABO9xjB6CcSBZohc7oiEbqFszrRfaLAk0iJR/kJQeUcAxwSBWHPN
 V8hUCyDmLO5MjCZUP9j9Wzv18PdI5sPcxwuxdT24H9Dyu7n7vpH0vpBNj218uRf0KkSg
 +ee7Jw6MI5UnEQJM+lwgHo32GQDBzCytxHNq3BlRbuRM2MLjyYrsH+FJCChP2y6Mpqft
 d8NCd3vqfaCcijk7yOm+cAxKpsfFkJBQ5CGsgDnChhGdF1yBIv19kf2AdyyN5RhsHPrl
 VG+g==
X-Gm-Message-State: AOAM532vj+Oxw6pu/bGD3Ncoj8odKya296+LePCWwgGZFUdfKvmyB/2W
 nmsZx8bFVDq+H/SsRyztwGtlALpTgaYLXiyb2bw=
X-Google-Smtp-Source: ABdhPJwxMJfUSF3fIHqw6RtqYHMiDA7deeywxNYrJOb0UTkdP8NlWNOogJWdUllF5JNQa75N2wPHcGLwIKv0+dvGUVs=
X-Received: by 2002:a92:8b52:: with SMTP id i79mr9788670ild.177.1599248865300; 
 Fri, 04 Sep 2020 12:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-17-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1598924352-89526-17-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 12:36:50 -0700
Message-ID: <CAKmqyKPu-3qgGy2G_Rfo5DNA4FoFXQKG38hhjWmnqa=Tyq3DCw@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] hw/riscv: sifive_u: Connect a DMA controller
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 6:46 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> SiFive FU540 SoC integrates a platform DMA controller with 4 DMA
> channels. This connects the exsiting SiFive PDMA model to the SoC,
> and adds its device tree data as well.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> (no changes since v1)
>
>  include/hw/riscv/sifive_u.h | 11 +++++++++++
>  hw/riscv/sifive_u.c         | 30 ++++++++++++++++++++++++++++++
>  hw/riscv/Kconfig            |  1 +
>  3 files changed, 42 insertions(+)
>
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index d3c0c00..793000a 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -19,6 +19,7 @@
>  #ifndef HW_SIFIVE_U_H
>  #define HW_SIFIVE_U_H
>
> +#include "hw/dma/sifive_pdma.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/riscv/sifive_cpu.h"
> @@ -43,6 +44,7 @@ typedef struct SiFiveUSoCState {
>      SiFiveUPRCIState prci;
>      SIFIVEGPIOState gpio;
>      SiFiveUOTPState otp;
> +    SiFivePDMAState dma;
>      CadenceGEMState gem;
>
>      uint32_t serial;
> @@ -72,6 +74,7 @@ enum {
>      SIFIVE_U_MROM,
>      SIFIVE_U_CLINT,
>      SIFIVE_U_L2CC,
> +    SIFIVE_U_PDMA,
>      SIFIVE_U_L2LIM,
>      SIFIVE_U_PLIC,
>      SIFIVE_U_PRCI,
> @@ -108,6 +111,14 @@ enum {
>      SIFIVE_U_GPIO_IRQ13 = 20,
>      SIFIVE_U_GPIO_IRQ14 = 21,
>      SIFIVE_U_GPIO_IRQ15 = 22,
> +    SIFIVE_U_PDMA_IRQ0 = 23,
> +    SIFIVE_U_PDMA_IRQ1 = 24,
> +    SIFIVE_U_PDMA_IRQ2 = 25,
> +    SIFIVE_U_PDMA_IRQ3 = 26,
> +    SIFIVE_U_PDMA_IRQ4 = 27,
> +    SIFIVE_U_PDMA_IRQ5 = 28,
> +    SIFIVE_U_PDMA_IRQ6 = 29,
> +    SIFIVE_U_PDMA_IRQ7 = 30,
>      SIFIVE_U_GEM_IRQ = 0x35
>  };
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 2bc3992..7997537 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -14,6 +14,7 @@
>   * 4) GPIO (General Purpose Input/Output Controller)
>   * 5) OTP (One-Time Programmable) memory with stored serial number
>   * 6) GEM (Gigabit Ethernet Controller) and management block
> + * 7) DMA (Direct Memory Access Controller)
>   *
>   * This board currently generates devicetree dynamically that indicates at least
>   * two harts and up to five harts.
> @@ -73,6 +74,7 @@ static const struct MemmapEntry {
>      [SIFIVE_U_MROM] =     {     0x1000,     0xf000 },
>      [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
>      [SIFIVE_U_L2CC] =     {  0x2010000,     0x1000 },
> +    [SIFIVE_U_PDMA] =     {  0x3000000,   0x100000 },
>      [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
>      [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
>      [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
> @@ -303,6 +305,22 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_string(fdt, nodename, "compatible", "gpio-restart");
>      g_free(nodename);
>
> +    nodename = g_strdup_printf("/soc/dma@%lx",
> +        (long)memmap[SIFIVE_U_PDMA].base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_cell(fdt, nodename, "#dma-cells", 1);
> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
> +        SIFIVE_U_PDMA_IRQ0, SIFIVE_U_PDMA_IRQ1, SIFIVE_U_PDMA_IRQ2,
> +        SIFIVE_U_PDMA_IRQ3, SIFIVE_U_PDMA_IRQ4, SIFIVE_U_PDMA_IRQ5,
> +        SIFIVE_U_PDMA_IRQ6, SIFIVE_U_PDMA_IRQ7);
> +    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
> +    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +        0x0, memmap[SIFIVE_U_PDMA].base,
> +        0x0, memmap[SIFIVE_U_PDMA].size);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible",
> +                            "sifive,fu540-c000-pdma");
> +    g_free(nodename);
> +
>      nodename = g_strdup_printf("/soc/cache-controller@%lx",
>          (long)memmap[SIFIVE_U_L2CC].base);
>      qemu_fdt_add_subnode(fdt, nodename);
> @@ -627,6 +645,7 @@ static void sifive_u_soc_instance_init(Object *obj)
>      object_initialize_child(obj, "otp", &s->otp, TYPE_SIFIVE_U_OTP);
>      object_initialize_child(obj, "gem", &s->gem, TYPE_CADENCE_GEM);
>      object_initialize_child(obj, "gpio", &s->gpio, TYPE_SIFIVE_GPIO);
> +    object_initialize_child(obj, "pdma", &s->dma, TYPE_SIFIVE_PDMA);
>  }
>
>  static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
> @@ -730,6 +749,17 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>                                              SIFIVE_U_GPIO_IRQ0 + i));
>      }
>
> +    /* PDMA */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dma), 0, memmap[SIFIVE_U_PDMA].base);
> +
> +    /* Connect PDMA interrupts to the PLIC */
> +    for (i = 0; i < SIFIVE_PDMA_IRQS; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->dma), i,
> +                           qdev_get_gpio_in(DEVICE(s->plic),
> +                                            SIFIVE_U_PDMA_IRQ0 + i));
> +    }
> +
>      qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
>          return;
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 9032cb0..e53ab1e 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -22,6 +22,7 @@ config SIFIVE_U
>      select CADENCE
>      select HART
>      select SIFIVE
> +    select SIFIVE_PDMA
>      select UNIMP
>
>  config SPIKE
> --
> 2.7.4
>
>

