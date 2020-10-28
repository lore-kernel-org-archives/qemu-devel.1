Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07D0C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C14B24771
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzsZ8sRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C14B24771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmOE-0007z1-4k
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXmJf-0003nS-Ax; Wed, 28 Oct 2020 10:20:44 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:44988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXmJb-0006wA-MQ; Wed, 28 Oct 2020 10:20:42 -0400
Received: by mail-io1-xd42.google.com with SMTP id z17so5473707iog.11;
 Wed, 28 Oct 2020 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w2yWf7divgcX0hOBgLXcDpemaHcbR2900vMAlldyl10=;
 b=EzsZ8sRhplGYqHlovIwbYH6zb2BEpvzfOmgqqVrbvdfI2Bs79lytqLog2D79/PaT/D
 16TDi9gxLfaVa0bR93AHDnXd/kbH70HoSFQoVjwq4evqltX07DnzZeOgFD+8Z26ap7Pk
 3pvo9TzpoVnNQ1RwIdU0AOtIVWvvsRfgDD+LzBy9K3Le9uSunq/UFBmBT3g7AZ7BHyRV
 lcK+lQmUXcQ9tHQW+3vzOk6UYzAM97VKIwbtT0EEc59dy1UA2QAZGviKzzWrqYWTuSw9
 7FIlxxu0JSz8GdkRz5DKYygUnDjzopxY0ivl+SmDez0z4VDuk7mww0mCrg6mdY63xJF4
 7bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w2yWf7divgcX0hOBgLXcDpemaHcbR2900vMAlldyl10=;
 b=fp7cli3gh8sDelQYgrL+ux4Ju/w/oHsy5wjBlDY4ZSbN7tmooChVebTezkxsc7pIJg
 EB5ECedhRa7ChH0W4lpgrKwIRrOv4rJh8JEY9WbmkCNCXAVuU0w0O1/gwOHnxnitGVgR
 eTz5eNVZHtG2dBmYcRVXrCeFaXYK00iIOFbu9mA2lS6FeN4f2RQ1/4DBYuiyb9baXTZp
 NbljpLrdunkcvb/9Qq333gCd3JVLfafKCddFdOOkd0uyufEATB499Yl1UbRjjPtz5uZH
 IPliD0xTYNBHlNMTRVb3xtDPWBtGQg1vtt9r6zS8GSHCwNs0xKRjO54M1G0nWAv3HpFU
 5X2g==
X-Gm-Message-State: AOAM5316kbPbyMboiGZRApQX7FVffKRH5qUYX494TUzah3a1S3nyVRG5
 nBN3Mx4G2TuY+ngiHrhi3NeRQIfEVLBgyf3Ty+I=
X-Google-Smtp-Source: ABdhPJxud1IFcJ6DDQmk1bY5SF5iw3WS5SD4sWm1yVUtVsMU5h0Lfhk5bi2/kwlOC1rO5rdwHucMpNCqflSyTW7dYhk=
X-Received: by 2002:a05:6638:ec3:: with SMTP id
 q3mr5438972jas.106.1603894835881; 
 Wed, 28 Oct 2020 07:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
 <1603863010-15807-4-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1603863010-15807-4-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Oct 2020 07:08:44 -0700
Message-ID: <CAKmqyKMeeFrZOznHbzZZabEY1gs6ZwKMwCGs-6+Dxp5=83nB+w@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] hw/riscv: microchip_pfsoc: Connect DDR memory
 controller modules
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
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

On Tue, Oct 27, 2020 at 10:34 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Connect DDR SGMII PHY module and CFG module to the PolarFire SoC.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> (no changes since v1)
>
>  hw/riscv/Kconfig                   |  1 +
>  hw/riscv/microchip_pfsoc.c         | 18 ++++++++++++++++++
>  include/hw/riscv/microchip_pfsoc.h |  5 +++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 2df978f..c8e50bd 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -4,6 +4,7 @@ config IBEX
>  config MICROCHIP_PFSOC
>      bool
>      select CADENCE_SDHCI
> +    select MCHP_PFSOC_DMC
>      select MCHP_PFSOC_MMUART
>      select MSI_NONBROKEN
>      select SIFIVE_CLINT
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 6aac849..3c504f7 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -15,6 +15,7 @@
>   * 4) Cadence eMMC/SDHC controller and an SD card connected to it
>   * 5) SiFive Platform DMA (Direct Memory Access Controller)
>   * 6) GEM (Gigabit Ethernet MAC Controller)
> + * 7) DMC (DDR Memory Controller)
>   *
>   * This board currently generates devicetree dynamically that indicates at least
>   * two harts and up to five harts.
> @@ -103,7 +104,9 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
>      [MICROCHIP_PFSOC_SYSREG] =          { 0x20002000,     0x2000 },
>      [MICROCHIP_PFSOC_MPUCFG] =          { 0x20005000,     0x1000 },
> +    [MICROCHIP_PFSOC_DDR_SGMII_PHY] =   { 0x20007000,     0x1000 },
>      [MICROCHIP_PFSOC_EMMC_SD] =         { 0x20008000,     0x1000 },
> +    [MICROCHIP_PFSOC_DDR_CFG] =         { 0x20080000,    0x40000 },
>      [MICROCHIP_PFSOC_MMUART1] =         { 0x20100000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
> @@ -149,6 +152,11 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>      object_initialize_child(obj, "dma-controller", &s->dma,
>                              TYPE_SIFIVE_PDMA);
>
> +    object_initialize_child(obj, "ddr-sgmii-phy", &s->ddr_sgmii_phy,
> +                            TYPE_MCHP_PFSOC_DDR_SGMII_PHY);
> +    object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
> +                            TYPE_MCHP_PFSOC_DDR_CFG);
> +
>      object_initialize_child(obj, "gem0", &s->gem0, TYPE_CADENCE_GEM);
>      object_initialize_child(obj, "gem1", &s->gem1, TYPE_CADENCE_GEM);
>
> @@ -278,6 +286,16 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>          memmap[MICROCHIP_PFSOC_MPUCFG].base,
>          memmap[MICROCHIP_PFSOC_MPUCFG].size);
>
> +    /* DDR SGMII PHY */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->ddr_sgmii_phy), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ddr_sgmii_phy), 0,
> +                    memmap[MICROCHIP_PFSOC_DDR_SGMII_PHY].base);
> +
> +    /* DDR CFG */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->ddr_cfg), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ddr_cfg), 0,
> +                    memmap[MICROCHIP_PFSOC_DDR_CFG].base);
> +
>      /* SDHCI */
>      sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index 8bfc7e1..5b81e26 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -24,6 +24,7 @@
>
>  #include "hw/char/mchp_pfsoc_mmuart.h"
>  #include "hw/dma/sifive_pdma.h"
> +#include "hw/misc/mchp_pfsoc_dmc.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/sd/cadence_sdhci.h"
>
> @@ -37,6 +38,8 @@ typedef struct MicrochipPFSoCState {
>      RISCVHartArrayState e_cpus;
>      RISCVHartArrayState u_cpus;
>      DeviceState *plic;
> +    MchpPfSoCDdrSgmiiPhyState ddr_sgmii_phy;
> +    MchpPfSoCDdrCfgState ddr_cfg;
>      MchpPfSoCMMUartState *serial0;
>      MchpPfSoCMMUartState *serial1;
>      MchpPfSoCMMUartState *serial2;
> @@ -82,7 +85,9 @@ enum {
>      MICROCHIP_PFSOC_MMUART0,
>      MICROCHIP_PFSOC_SYSREG,
>      MICROCHIP_PFSOC_MPUCFG,
> +    MICROCHIP_PFSOC_DDR_SGMII_PHY,
>      MICROCHIP_PFSOC_EMMC_SD,
> +    MICROCHIP_PFSOC_DDR_CFG,
>      MICROCHIP_PFSOC_MMUART1,
>      MICROCHIP_PFSOC_MMUART2,
>      MICROCHIP_PFSOC_MMUART3,
> --
> 2.7.4
>
>

