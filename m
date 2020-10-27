Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBD2C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1484124197
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSOn6IeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1484124197
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXT7i-0007js-1P
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXT5v-0005t8-6P; Tue, 27 Oct 2020 13:49:15 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:38047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXT5q-0005Q9-GN; Tue, 27 Oct 2020 13:49:14 -0400
Received: by mail-io1-xd42.google.com with SMTP id y20so2486040iod.5;
 Tue, 27 Oct 2020 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=onx8aWS3JSsRvz7twCqULyHhgjMXYAppBpKGCxhrckE=;
 b=kSOn6IeX4AGvX0A/GeF2TNlXkt96NO8ci5+MWufwDdyl7n3RJhnjDgrh9ktbGq+hqK
 NnLpec0LIdxrjz0uckpLGBA43VuRqpAu65eSPj5ZvBMWN6LNg4vQzG2JJgJ9GT2yAztf
 Yq3zqx/TxuzjC8xUi8xyKhTW6n+Nz2UFpG6MrShONgGUPrbcVM+cFCCYLKylsIUJDyoW
 WiQbARt00RzHOZzdD6tmRoLXveKeaGXY//Rj3p0xlDnMBvETQKvQwdtC2bbMo3tnM1PV
 QeZ/1o15RG8lWTQ6as0W8pNnU6m3fYBaif7dR7ij2pJSkQ2KX9dCDK8mN6niIzq90bk2
 ghMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=onx8aWS3JSsRvz7twCqULyHhgjMXYAppBpKGCxhrckE=;
 b=aFxkef2KqWZFP4M5qfcyQnjnn6rT3UPdTfD+sEd4zuCbsUgrQJeOU0e3ZW/zX/rasS
 cRetymWSYTEExqTdHEyzQ1zc8qw3yENb/rIGFGggcUAMm4Hp2lLYOwzN0q04OiJnZ0RL
 09Cj8S62fRQ6tG9vTNx6uX8d0sUozUGk4PwKDE2k5mbp4Alhwe95nzBg3NlcED2rC7j1
 6Umqbs9JcKzXRpK+10UBxw0v1C6B1Ze1hPs/mVqKs8NmWEcATdpRmpPjHpF/YIkCq46V
 RLO6/DtdUpMUM9z8asmg9nHQ2oTCnRfkvI8qV+nz92ZUfa0/A74z5+h4PT4CoWKGc+6X
 AuYg==
X-Gm-Message-State: AOAM53004//+wIX1Tes8QTqqZi9yLvrsZRzNLzccgwp7V78W/iuqZcqF
 L18LfIyguHQOVeDNacZMwZPAe+Q10gq9QsO6DuY=
X-Google-Smtp-Source: ABdhPJwpj2K6YlNvETSSPo6xOrJtbFhoVA0BDMgohqG+ziy4JyAkiXr2T4DQBqdtod6jGS3681CrThJ6kb9g0wARgIo=
X-Received: by 2002:a05:6638:ec3:: with SMTP id
 q3mr2032119jas.106.1603820948092; 
 Tue, 27 Oct 2020 10:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201027141740.18336-1-bmeng.cn@gmail.com>
 <20201027141740.18336-3-bmeng.cn@gmail.com>
In-Reply-To: <20201027141740.18336-3-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Oct 2020 10:37:18 -0700
Message-ID: <CAKmqyKMyHCZCLZOqVVZ4n4C0_rAY-WO5-J+Y=dqi0qtZsLXjpw@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/9] hw/riscv: microchip_pfsoc: Connect DDR memory
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

On Tue, Oct 27, 2020 at 7:46 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Connect DDR SGMII PHY module and CFG module to the PolarFire SoC.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  hw/riscv/Kconfig                   |  1 +
>  hw/riscv/microchip_pfsoc.c         | 18 ++++++++++++++++++
>  include/hw/riscv/microchip_pfsoc.h |  5 +++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 2df978fe8d..c8e50bde99 100644
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
> index 4627179cd3..85be2bcde8 100644
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
> @@ -85,7 +86,9 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
>      [MICROCHIP_PFSOC_SYSREG] =          { 0x20002000,     0x2000 },
>      [MICROCHIP_PFSOC_MPUCFG] =          { 0x20005000,     0x1000 },
> +    [MICROCHIP_PFSOC_DDR_SGMII_PHY] =   { 0x20007000,     0x1000 },
>      [MICROCHIP_PFSOC_EMMC_SD] =         { 0x20008000,     0x1000 },
> +    [MICROCHIP_PFSOC_DDR_CFG] =         { 0x20080000,    0x40000 },

Neither of these are documented....

Maybe just add a single comment above the memory layout clarifying
that this is not what is documented from the SoC but is instead based
on what guests do?

It seems to be a constant problem with this board, unless I am really
misreading the memory map.

Alistair

>      [MICROCHIP_PFSOC_MMUART1] =         { 0x20100000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
> @@ -131,6 +134,11 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
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
> @@ -260,6 +268,16 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
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
> index 8bfc7e1a85..5b81e26241 100644
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
> 2.25.1
>
>

