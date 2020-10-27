Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F2DC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646D6206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm7Bs5QL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646D6206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTBr-0003ZO-5h
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXTAf-0002EF-Dg; Tue, 27 Oct 2020 13:54:14 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXTAc-0006QH-Hw; Tue, 27 Oct 2020 13:54:09 -0400
Received: by mail-io1-xd44.google.com with SMTP id z17so2481465iog.11;
 Tue, 27 Oct 2020 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MK1nyjVpb5mH/wSl3w10az9W6wuoN9PkyYuHacHe+8k=;
 b=cm7Bs5QL/rstq//2TgSZ92C9MwQ96lAwSo2SNUTJhgBwGygrst5+Bc04QMQ/vQzXVU
 T5YfZKuIvLV4mn3Wh/Q0V+CKNdkVw4czhOVKVgqCgA5MR3/ux0ASS2rK3XiFhkGZz93N
 cp0yj2iwgQpAAluKLnV9sCfcXhZri4KzmFLvvdjK6IctZ+aGEVIwMrsJW6tcXGe6vb+U
 2y3h0p7G56uT+LnryookvbsFF0aC3BRo7pSqQNEZmb8qaF8OhWdOKFMwpdlFSyTZwcQY
 ssectXTIufp8aByQtLZvGm89m5WRf4exaD1YA92u46XKKsJskXut0Z1KHUJZVv7ATZGT
 WCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MK1nyjVpb5mH/wSl3w10az9W6wuoN9PkyYuHacHe+8k=;
 b=FWp6Y7Fb/r2UZ8F9jPCbnusgJ3r5fDnUJhU76dKSuym6QtfGbAI7EL7syEieFXX259
 eBgL5RXA3EGY8DdZBJq/RP+Bp7LNhr0G/LT/d2CU3bMBjgoQzJQMcLVtBLzR1swLcbfN
 /b84nwglF5WdPBkP/yHNAL647ncjIigu+z2VXx3mXW9Dmm9Izf5vQIR42StCmNpMFFbr
 kPBw6t+POqfJD2/3nQwurOl5+WNjpqvOUqjgTx8pIIBc2V6+RgIZ+F8UIhyJRb6iiYeL
 E+pSXeKhjO88Am/w6Lftqejui80nOu4z/k54NCGRLCmhXCrhIzXNiXG7FBpfckUozoyc
 jniQ==
X-Gm-Message-State: AOAM530yg4ZGBUYNPZRQxHbOhYAnbii5Iwluk0BCRcw4vU0qDcHvn2tt
 sOtCnlvd7B5/jjm2Ra9j9X9G2HJ7fydzcYKOKdM=
X-Google-Smtp-Source: ABdhPJz3X52aufkbsKTHvf9Pzfbu3mr9ZcboicNLxwLtAPTEPPsPv4c9G4w77e+ArJidCEn1pJad5J7Js5Brg/t7X+s=
X-Received: by 2002:a02:c956:: with SMTP id u22mr3503446jao.135.1603821244849; 
 Tue, 27 Oct 2020 10:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201027141740.18336-1-bmeng.cn@gmail.com>
 <20201027141740.18336-5-bmeng.cn@gmail.com>
In-Reply-To: <20201027141740.18336-5-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Oct 2020 10:42:15 -0700
Message-ID: <CAKmqyKN73BG3G0+-RW5sDG0UTFT5Wm4K23sUxghwatZgjn_FRw@mail.gmail.com>
Subject: Re: [RESEND PATCH 4/9] hw/riscv: microchip_pfsoc: Connect the IOSCB
 module
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <anup.patel@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Ivan Griffin <ivan.griffin@emdalo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 7:52 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Previously IOSCB_CFG was created as an unimplemented device. With
> the new IOSCB model, its memory range is already covered by the
> IOSCB hence remove the previous unimplemented device creation in
> the SoC codes.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  hw/riscv/Kconfig                   |  1 +
>  hw/riscv/microchip_pfsoc.c         | 13 ++++++++-----
>  include/hw/riscv/microchip_pfsoc.h |  4 +++-
>  3 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index c8e50bde99..8f043e38e0 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -5,6 +5,7 @@ config MICROCHIP_PFSOC
>      bool
>      select CADENCE_SDHCI
>      select MCHP_PFSOC_DMC
> +    select MCHP_PFSOC_IOSCB
>      select MCHP_PFSOC_MMUART
>      select MSI_NONBROKEN
>      select SIFIVE_CLINT
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 85be2bcde8..05fb5004a1 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -16,6 +16,7 @@
>   * 5) SiFive Platform DMA (Direct Memory Access Controller)
>   * 6) GEM (Gigabit Ethernet MAC Controller)
>   * 7) DMC (DDR Memory Controller)
> + * 8) IOSCB modules
>   *
>   * This board currently generates devicetree dynamically that indicates at least
>   * two harts and up to five harts.
> @@ -100,7 +101,7 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_GPIO2] =           { 0x20122000,     0x1000 },
>      [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
>      [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
> -    [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
> +    [MICROCHIP_PFSOC_IOSCB] =           { 0x30000000, 0x10000000 },

This one matches the docs! :)

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>      [MICROCHIP_PFSOC_DRAM] =            { 0x80000000,        0x0 },
>  };
>
> @@ -144,6 +145,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>
>      object_initialize_child(obj, "sd-controller", &s->sdhci,
>                              TYPE_CADENCE_SDHCI);
> +
> +    object_initialize_child(obj, "ioscb", &s->ioscb, TYPE_MCHP_PFSOC_IOSCB);
>  }
>
>  static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
> @@ -355,10 +358,10 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>                                  memmap[MICROCHIP_PFSOC_ENVM_DATA].base,
>                                  envm_data);
>
> -    /* IOSCBCFG */
> -    create_unimplemented_device("microchip.pfsoc.ioscb.cfg",
> -        memmap[MICROCHIP_PFSOC_IOSCB_CFG].base,
> -        memmap[MICROCHIP_PFSOC_IOSCB_CFG].size);
> +    /* IOSCB */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->ioscb), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioscb), 0,
> +                    memmap[MICROCHIP_PFSOC_IOSCB].base);
>  }
>
>  static void microchip_pfsoc_soc_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index 5b81e26241..a244ae6d39 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -25,6 +25,7 @@
>  #include "hw/char/mchp_pfsoc_mmuart.h"
>  #include "hw/dma/sifive_pdma.h"
>  #include "hw/misc/mchp_pfsoc_dmc.h"
> +#include "hw/misc/mchp_pfsoc_ioscb.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/sd/cadence_sdhci.h"
>
> @@ -40,6 +41,7 @@ typedef struct MicrochipPFSoCState {
>      DeviceState *plic;
>      MchpPfSoCDdrSgmiiPhyState ddr_sgmii_phy;
>      MchpPfSoCDdrCfgState ddr_cfg;
> +    MchpPfSoCIoscbState ioscb;
>      MchpPfSoCMMUartState *serial0;
>      MchpPfSoCMMUartState *serial1;
>      MchpPfSoCMMUartState *serial2;
> @@ -99,7 +101,7 @@ enum {
>      MICROCHIP_PFSOC_GPIO2,
>      MICROCHIP_PFSOC_ENVM_CFG,
>      MICROCHIP_PFSOC_ENVM_DATA,
> -    MICROCHIP_PFSOC_IOSCB_CFG,
> +    MICROCHIP_PFSOC_IOSCB,
>      MICROCHIP_PFSOC_DRAM,
>  };
>
> --
> 2.25.1
>
>

