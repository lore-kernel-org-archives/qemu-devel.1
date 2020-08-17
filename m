Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCE5C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 21:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383BC2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 21:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVfhrlQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383BC2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7mVq-0006XZ-FJ
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 17:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7mV6-00063Y-FW; Mon, 17 Aug 2020 17:17:04 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:34998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7mV4-0006YF-HU; Mon, 17 Aug 2020 17:17:04 -0400
Received: by mail-io1-xd44.google.com with SMTP id s189so19140316iod.2;
 Mon, 17 Aug 2020 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mQSWZ4OL8kptnsLiqBLKFUgG5/0K0ZeOyTGLKyi74kw=;
 b=hVfhrlQ3CArPhbOGKmQIfLO/uM3CBNHgBcevrD4f6vm28JYtuhLt7VZm94pGmu5/Tu
 vhqR3nueWdz60NFoEjNySuwDbQvvzEGXeiM6eR/se9dDKvAKlOslCPImAWDmddQVRUaf
 Fg1Mc96AH35MJnbhyf8gDxDeAQxdtDsuAm2zR4B4Gylnkt1rDhIowcnyACaSmFhf4i8I
 rjwMltDF2zg6gUpTfb6WXF+5ri6VoycrFwXTjuUrVVFUrE26kipKn+ekvdYzm722Vvr+
 Vtn2o1U3FRX5bb5bE8L/1wBakXiDV2JTFDqZOYQfh84pCA4cyfx016obMA9JR2SOpf8r
 Q5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mQSWZ4OL8kptnsLiqBLKFUgG5/0K0ZeOyTGLKyi74kw=;
 b=HOmAvcQXkAjj0Ax7aG0iJpbe/u9mun9g98czEzLvjTmY6ukCVH6kcCEiT1dp8d/BNs
 ecm60aN8Yhi+mBol07oY+2VHLAGHnpaTacnvEzXqvxqkzgFIYpRtylCYKh0BsE7nmzAZ
 gXy1oHZcxeP6V+boC1i3Q97/N8IAa2TOub1/yHe93dtRPhsWIE2tuqMoXqj8w80bp3PM
 1HGogNh7P75p0P6OmNp1HDi9sYtTbUuS9XVmCYEJe1953dQdaqA3HS2aaMYAF+CzoVWF
 MMd+FOj+vCaCBPkEj3tZ3xmz5SgT3E64S9amTo2IYnHRJ7XI3ceFVSGaKwvg/iv84Y5y
 UEzg==
X-Gm-Message-State: AOAM533aRPj50qk84ek4A45fc3tuHTf2012UGRGQnXPXGURaTYrI6ZGS
 eLvWqgf32YeJilgbx1/s1I61ucycE6Tu+LHVwaw=
X-Google-Smtp-Source: ABdhPJy0NKIK5UsIVizWEoJiljf6UNa0mOLEihfYvd3K/0Tj8Yt6RoRpP+hXPkxBiWS5TwdcdouISpDBz0E9AevftB0=
X-Received: by 2002:a5d:995a:: with SMTP id v26mr13585090ios.176.1597699021032; 
 Mon, 17 Aug 2020 14:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-7-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1597423256-14847-7-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Aug 2020 14:06:29 -0700
Message-ID: <CAKmqyKOj89059O5jBsLCu=eQsPoQJ-suvzP1y1kKR0VJDg1tTw@mail.gmail.com>
Subject: Re: [PATCH 06/18] hw/riscv: microchip_pfsoc: Connect 5 MMUARTs
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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

On Fri, Aug 14, 2020 at 9:49 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Microchip PolarFire SoC has 5 MMUARTs, and the Icicle Kit board
> wires 4 of them out. Let's connect all 5 MMUARTs.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/Kconfig                   |  1 +
>  hw/riscv/microchip_pfsoc.c         | 30 ++++++++++++++++++++++++++++++
>  include/hw/riscv/microchip_pfsoc.h | 20 ++++++++++++++++++++
>  3 files changed, 51 insertions(+)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 3292fae..ceb7c16 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -54,3 +54,4 @@ config MICROCHIP_PFSOC
>      select HART
>      select SIFIVE
>      select UNIMP
> +    select MCHP_PFSOC_MMUART
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 20a642c..f6b375c 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -11,6 +11,7 @@
>   * 0) CLINT (Core Level Interruptor)
>   * 1) PLIC (Platform Level Interrupt Controller)
>   * 2) eNVM (Embedded Non-Volatile Memory)
> + * 3) MMUARTs (Multi-Mode UART)
>   *
>   * This board currently generates devicetree dynamically that indicates at least
>   * two harts and up to five harts.
> @@ -38,6 +39,7 @@
>  #include "hw/irq.h"
>  #include "hw/loader.h"
>  #include "hw/sysbus.h"
> +#include "chardev/char.h"
>  #include "hw/cpu/cluster.h"
>  #include "target/riscv/cpu.h"
>  #include "hw/misc/unimp.h"
> @@ -46,6 +48,7 @@
>  #include "hw/riscv/sifive_clint.h"
>  #include "hw/riscv/sifive_plic.h"
>  #include "hw/riscv/microchip_pfsoc.h"
> +#include "sysemu/sysemu.h"
>
>  /*
>   * The BIOS image used by this machine is called Hart Software Services (HSS).
> @@ -69,8 +72,13 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,     0x1000 },
>      [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,  0x2000000 },
>      [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,  0x4000000 },
> +    [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
>      [MICROCHIP_PFSOC_SYSREG] =          { 0x20002000,     0x2000 },
>      [MICROCHIP_PFSOC_MPUCFG] =          { 0x20005000,     0x1000 },
> +    [MICROCHIP_PFSOC_MMUART1] =         { 0x20100000,     0x1000 },
> +    [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
> +    [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
> +    [MICROCHIP_PFSOC_MMUART4] =         { 0x20106000,     0x1000 },
>      [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
>      [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
>      [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
> @@ -215,6 +223,28 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>          memmap[MICROCHIP_PFSOC_MPUCFG].base,
>          memmap[MICROCHIP_PFSOC_MPUCFG].size);
>
> +    /* MMUARTs */
> +    s->serial0 = mchp_pfsoc_mmuart_create(system_memory,
> +        memmap[MICROCHIP_PFSOC_MMUART0].base,
> +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART0_IRQ),
> +        serial_hd(0));
> +    s->serial1 = mchp_pfsoc_mmuart_create(system_memory,
> +        memmap[MICROCHIP_PFSOC_MMUART1].base,
> +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART1_IRQ),
> +        serial_hd(1));
> +    s->serial2 = mchp_pfsoc_mmuart_create(system_memory,
> +        memmap[MICROCHIP_PFSOC_MMUART2].base,
> +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART2_IRQ),
> +        serial_hd(2));
> +    s->serial3 = mchp_pfsoc_mmuart_create(system_memory,
> +        memmap[MICROCHIP_PFSOC_MMUART3].base,
> +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART3_IRQ),
> +        serial_hd(3));
> +    s->serial4 = mchp_pfsoc_mmuart_create(system_memory,
> +        memmap[MICROCHIP_PFSOC_MMUART4].base,
> +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART4_IRQ),
> +        serial_hd(4));
> +
>      /* eNVM */
>      memory_region_init_rom(envm_data, OBJECT(dev), "microchip.pfsoc.envm.data",
>                             memmap[MICROCHIP_PFSOC_ENVM_DATA].size,
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index 1953ef1..a5efa1d 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -22,6 +22,8 @@
>  #ifndef HW_MICROCHIP_PFSOC_H
>  #define HW_MICROCHIP_PFSOC_H
>
> +#include "hw/char/mchp_pfsoc_mmuart.h"
> +
>  typedef struct MicrochipPFSoCState {
>      /*< private >*/
>      DeviceState parent_obj;
> @@ -32,6 +34,11 @@ typedef struct MicrochipPFSoCState {
>      RISCVHartArrayState e_cpus;
>      RISCVHartArrayState u_cpus;
>      DeviceState *plic;
> +    MchpPfSoCMMUartState *serial0;
> +    MchpPfSoCMMUartState *serial1;
> +    MchpPfSoCMMUartState *serial2;
> +    MchpPfSoCMMUartState *serial3;
> +    MchpPfSoCMMUartState *serial4;
>  } MicrochipPFSoCState;
>
>  #define TYPE_MICROCHIP_PFSOC    "microchip.pfsoc"
> @@ -64,14 +71,27 @@ enum {
>      MICROCHIP_PFSOC_L2CC,
>      MICROCHIP_PFSOC_L2LIM,
>      MICROCHIP_PFSOC_PLIC,
> +    MICROCHIP_PFSOC_MMUART0,
>      MICROCHIP_PFSOC_SYSREG,
>      MICROCHIP_PFSOC_MPUCFG,
> +    MICROCHIP_PFSOC_MMUART1,
> +    MICROCHIP_PFSOC_MMUART2,
> +    MICROCHIP_PFSOC_MMUART3,
> +    MICROCHIP_PFSOC_MMUART4,
>      MICROCHIP_PFSOC_ENVM_CFG,
>      MICROCHIP_PFSOC_ENVM_DATA,
>      MICROCHIP_PFSOC_IOSCB_CFG,
>      MICROCHIP_PFSOC_DRAM,
>  };
>
> +enum {
> +    MICROCHIP_PFSOC_MMUART0_IRQ = 90,
> +    MICROCHIP_PFSOC_MMUART1_IRQ = 91,
> +    MICROCHIP_PFSOC_MMUART2_IRQ = 92,
> +    MICROCHIP_PFSOC_MMUART3_IRQ = 93,
> +    MICROCHIP_PFSOC_MMUART4_IRQ = 94,
> +};
> +
>  #define MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT    1
>  #define MICROCHIP_PFSOC_COMPUTE_CPU_COUNT       4
>
> --
> 2.7.4
>
>

