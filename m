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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C54CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6992083B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmLfer8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6992083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEHdl-0001BO-2W
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEHdC-0000i0-OM; Fri, 04 Sep 2020 15:44:18 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:36585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEHdB-0005GY-1a; Fri, 04 Sep 2020 15:44:18 -0400
Received: by mail-io1-xd44.google.com with SMTP id d190so8336932iof.3;
 Fri, 04 Sep 2020 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z06fgPfVlnym5NeSaDSJ8s8GX/ji8uTmv+bCCT03y0E=;
 b=TmLfer8Op7H8VzhvyKZ2vJGh7hbmdrZVWL4ef/P6na8NMPfkmPntI/L+594QYsTv6J
 m1KlC+/U95bwOv5OzCB6N/NVUg4CdW59SwKoxwFlH85PWnDvearkXFeFtbefME4zHU/W
 ahIBQXKqGQW/ZPwO9GqCqoTtQi2ULKHew3GS8qL5OodMfHCxpJeDm1m2rX3VAFV72Cxi
 ENzUkQmgRZF1WT4hfcdfBTAUXtrHwePuu2tsyoacUZpiDUHtk0ggDxJQbB7P4pWuoAqf
 GFCroFMcS6G/3gDYao9K8ofpbXw650sweSIqrkX+rsuNFu0dosZKJpsX7uTOE7r+/a4Y
 56WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z06fgPfVlnym5NeSaDSJ8s8GX/ji8uTmv+bCCT03y0E=;
 b=VaWo0QtyzO+zqHQJxkfHAlFnQ2UDISPr0iUSmapfmwRbsU5bvDrDGQa1H9NHI6Bu12
 ZKa1rwWuGBcT19DAUo2VsBNV7lCAbvzafesOxTlKXQSNRS1P0+Pe36XxBIH3JDdkCWon
 t08LdDI5ZJNLzuG74gkKQLTau+gxGO64EZjMwZkhxZ+C4sGpM64V1oLnZlAdIW88Bs3b
 wQWfheGTE2h7c/uTh+9vWAV1Hag1eBwGsCyLIq5eKIxq1aX/Qr+1/IPGLZ8qdybf5QVp
 Xs0/+4SH8oHJRDFAPzIJozyxoroO7op/zcHj3xGPam7bcRDOBl/xgQgxw7ObA1s2Q3Zq
 JdKw==
X-Gm-Message-State: AOAM533eVDmghsDsT4e8NjNn9bjZhVstyLz8FF68yoNtWpv2v8Xv8xPb
 MsjF1IIqjSpfTv4pOt30Dwj7mkmcCSgqFcKeYRc=
X-Google-Smtp-Source: ABdhPJzMXV5Qm+69l54yWjFGjGsNE/6wnqOI2qcwZto+V+IdTEryIBHKLDtJTLcBfhycyWFMaDlaiHFAxItIEQAJnXw=
X-Received: by 2002:a02:85e1:: with SMTP id d88mr9759515jai.8.1599248655575;
 Fri, 04 Sep 2020 12:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-11-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1598924352-89526-11-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 12:33:20 -0700
Message-ID: <CAKmqyKNPFmzxiiWkNHwYR94HmxdPuvwoZK+fZ-DnVoCKbeAHKA@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] hw/riscv: microchip_pfsoc: Connect a DMA
 controller
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

On Mon, Aug 31, 2020 at 6:49 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> On the Icicle Kit board, the HSS firmware utilizes the on-chip DMA
> controller to move the 2nd stage bootloader in the system memory.
> Let's connect a DMA controller to Microchip PolarFire SoC.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - connect 8 IRQs to the PLIC
>
>  include/hw/riscv/microchip_pfsoc.h | 11 +++++++++++
>  hw/riscv/microchip_pfsoc.c         | 15 +++++++++++++++
>  hw/riscv/Kconfig                   |  1 +
>  3 files changed, 27 insertions(+)
>
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index d810ee8..63e7860 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -23,6 +23,7 @@
>  #define HW_MICROCHIP_PFSOC_H
>
>  #include "hw/char/mchp_pfsoc_mmuart.h"
> +#include "hw/dma/sifive_pdma.h"
>  #include "hw/sd/cadence_sdhci.h"
>
>  typedef struct MicrochipPFSoCState {
> @@ -40,6 +41,7 @@ typedef struct MicrochipPFSoCState {
>      MchpPfSoCMMUartState *serial2;
>      MchpPfSoCMMUartState *serial3;
>      MchpPfSoCMMUartState *serial4;
> +    SiFivePDMAState dma;
>      CadenceSDHCIState sdhci;
>  } MicrochipPFSoCState;
>
> @@ -71,6 +73,7 @@ enum {
>      MICROCHIP_PFSOC_BUSERR_UNIT4,
>      MICROCHIP_PFSOC_CLINT,
>      MICROCHIP_PFSOC_L2CC,
> +    MICROCHIP_PFSOC_DMA,
>      MICROCHIP_PFSOC_L2LIM,
>      MICROCHIP_PFSOC_PLIC,
>      MICROCHIP_PFSOC_MMUART0,
> @@ -88,6 +91,14 @@ enum {
>  };
>
>  enum {
> +    MICROCHIP_PFSOC_DMA_IRQ0 = 5,
> +    MICROCHIP_PFSOC_DMA_IRQ1 = 6,
> +    MICROCHIP_PFSOC_DMA_IRQ2 = 7,
> +    MICROCHIP_PFSOC_DMA_IRQ3 = 8,
> +    MICROCHIP_PFSOC_DMA_IRQ4 = 9,
> +    MICROCHIP_PFSOC_DMA_IRQ5 = 10,
> +    MICROCHIP_PFSOC_DMA_IRQ6 = 11,
> +    MICROCHIP_PFSOC_DMA_IRQ7 = 12,
>      MICROCHIP_PFSOC_EMMC_SD_IRQ = 88,
>      MICROCHIP_PFSOC_MMUART0_IRQ = 90,
>      MICROCHIP_PFSOC_MMUART1_IRQ = 91,
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 0b2e9ca..d8ec973 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -13,6 +13,7 @@
>   * 2) eNVM (Embedded Non-Volatile Memory)
>   * 3) MMUARTs (Multi-Mode UART)
>   * 4) Cadence eMMC/SDHC controller and an SD card connected to it
> + * 5) SiFive Platform DMA (Direct Memory Access Controller)
>   *
>   * This board currently generates devicetree dynamically that indicates at least
>   * two harts and up to five harts.
> @@ -71,6 +72,7 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_BUSERR_UNIT4] =    {  0x1704000,     0x1000 },
>      [MICROCHIP_PFSOC_CLINT] =           {  0x2000000,    0x10000 },
>      [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,     0x1000 },
> +    [MICROCHIP_PFSOC_DMA] =             {  0x3000000,   0x100000 },
>      [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,  0x2000000 },
>      [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,  0x4000000 },
>      [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
> @@ -114,6 +116,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>                           TYPE_RISCV_CPU_SIFIVE_U54);
>      qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", RESET_VECTOR);
>
> +    object_initialize_child(obj, "dma-controller", &s->dma,
> +                            TYPE_SIFIVE_PDMA);
> +
>      object_initialize_child(obj, "sd-controller", &s->sdhci,
>                              TYPE_CADENCE_SDHCI);
>  }
> @@ -218,6 +223,16 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>          memmap[MICROCHIP_PFSOC_PLIC].size);
>      g_free(plic_hart_config);
>
> +    /* DMA */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dma), 0,
> +                    memmap[MICROCHIP_PFSOC_DMA].base);
> +    for (i = 0; i < SIFIVE_PDMA_IRQS; i++) {
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->dma), i,
> +                           qdev_get_gpio_in(DEVICE(s->plic),
> +                                            MICROCHIP_PFSOC_DMA_IRQ0 + i));
> +    }
> +
>      /* SYSREG */
>      create_unimplemented_device("microchip.pfsoc.sysreg",
>          memmap[MICROCHIP_PFSOC_SYSREG].base,
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 7412db9..9032cb0 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -55,4 +55,5 @@ config MICROCHIP_PFSOC
>      select SIFIVE
>      select UNIMP
>      select MCHP_PFSOC_MMUART
> +    select SIFIVE_PDMA
>      select CADENCE_SDHCI
> --
> 2.7.4
>
>

