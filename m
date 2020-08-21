Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B10C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65EFA20714
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKabJKGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EFA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9CFA-0007zS-ND
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 14:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k9CDt-0007QP-Vg; Fri, 21 Aug 2020 14:57:10 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:46969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k9CDs-0004Ig-5o; Fri, 21 Aug 2020 14:57:09 -0400
Received: by mail-io1-xd41.google.com with SMTP id 4so2712772ion.13;
 Fri, 21 Aug 2020 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/7TCHOUJN5psz1qKuB5aTkaFDEXQBiISdiUA2hpBvVo=;
 b=aKabJKGaH60pRdfMNqGWVl8YIOjQcwvvkQ2UWZdb++nVtNtE8iA6LP4hUquIlLtKWC
 Jgu2+scpzmfHcwTSUfZg0ykleJEyRx5Gr09pFH8nmnkHX6AffALK3ie7Y6L9wp1KKiTF
 ENRZmFUPbtoqdvpGAY7d+F54AZMvaOQikHEaQPjF0bv0RSptNf2Rcc7LiS72zLxqMvBA
 d5BA0Np+fH0GKRwKAwCBGetcnLpu2X+IfwNcfFR5c5+NW4uVXoYx2Zg+ZTo+6CXz21Sj
 eOzO53F40KbrgKCxHcq2LIlArqgVD7uazwb30sXY4AmPMlINLNVI9NJNp5BSqZ3duUWK
 SrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/7TCHOUJN5psz1qKuB5aTkaFDEXQBiISdiUA2hpBvVo=;
 b=EJHMvh2JIgX6Bu854mPYHI4wfdQqHCgvResS8mFebwCGu/t/rFZFuVF3Jgrsr7gjH1
 gifQ/+rjWIcndZ/k26T0RxNj/TONkoIFcvNOCHNt8i9qYbwGuW/BOQRbFyq0AMWX6OD5
 VPbWOmV9t6chWaJboRnPH1HhffbLa17Irr+5Z5k2p2vB4MRCMCPWnEW4jJP84vEOLOCR
 axZwhFFDRinewtoUKqRHWUUi13ECyCUbNfxPo/XDdWUfoTJZtgjzbz6I38/QUbdPn7or
 sCWjMjRB5L8TIhlOTcmCoUmXaXTHRyKfW3Vg/VCt588gLLAUsXWNFRSzKmsQvO433IbM
 xkWA==
X-Gm-Message-State: AOAM530SknYVZrJ9V+FjpbWOZKJ98AhSGXtkszzOdFaicESJNSfJi3Rr
 Fs2TS1ggEmezzt0mQAsVySwcVizd9fzmULZY3cE=
X-Google-Smtp-Source: ABdhPJzjf8PiKtGJGk1VVHuHCsdhiEA809LtQK2XLoyqvJM5CJvGZtWAku5Ioxewsn5+cFo7avjPYVZJHdSozJuumCo=
X-Received: by 2002:a02:84c1:: with SMTP id f59mr3845481jai.106.1598036226512; 
 Fri, 21 Aug 2020 11:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-16-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1597423256-14847-16-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Aug 2020 11:46:29 -0700
Message-ID: <CAKmqyKNV02XKsf4oGS8cguC7=+mofj-EpEmsHG6a73BR_6YqMA@mail.gmail.com>
Subject: Re: [PATCH 15/18] hw/riscv: microchip_pfsoc: Connect 2 Cadence GEMs
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
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

On Fri, Aug 14, 2020 at 9:51 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Microchip PolarFire SoC integrates 2 Candence GEMs to provide
> IEEE 802.3 standard-compliant 10/100/1000 Mbps ethernet interface.
>
> On the Icicle Kit board, GEM0 connects to a PHY at address 8 while
> GEM1 connects to a PHY at address 9.
>
> The 2nd stage bootloader (U-Boot) is using GEM1 by default, so we
> must specify 2 '-nic' options from the command line in order to get
> a working ethernet.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/microchip_pfsoc.c         | 39 ++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/microchip_pfsoc.h |  7 +++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 1c67cbc..625b511 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -14,6 +14,7 @@
>   * 3) MMUARTs (Multi-Mode UART)
>   * 4) Cadence eMMC/SDHC controller and an SD card connected to it
>   * 5) DMA (Direct Memory Access Controller)
> + * 6) GEM (Gigabit Ethernet MAC Controller)
>   *
>   * This board currently generates devicetree dynamically that indicates at least
>   * two harts and up to five harts.
> @@ -59,6 +60,9 @@
>  #define BIOS_FILENAME   "hss.bin"
>  #define RESET_VECTOR    0x20220000
>
> +/* GEM version */
> +#define GEM_REVISION    0x0107010c
> +
>  static const struct MemmapEntry {
>      hwaddr base;
>      hwaddr size;
> @@ -83,6 +87,8 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART4] =         { 0x20106000,     0x1000 },
> +    [MICROCHIP_PFSOC_GEM0] =            { 0x20110000,     0x2000 },
> +    [MICROCHIP_PFSOC_GEM1] =            { 0x20112000,     0x2000 },
>      [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
>      [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
>      [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
> @@ -119,6 +125,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>      object_initialize_child(obj, "dma-controller", &s->dma,
>                              TYPE_MCHP_PFSOC_DMA);
>
> +    object_initialize_child(obj, "gem0", &s->gem0, TYPE_CADENCE_GEM);
> +    object_initialize_child(obj, "gem1", &s->gem1, TYPE_CADENCE_GEM);
> +
>      object_initialize_child(obj, "sd-controller", &s->sdhci,
>                              TYPE_CADENCE_SDHCI);
>      object_initialize_child(OBJECT(&s->sdhci), "sd-controller.sdhci",
> @@ -136,6 +145,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>      MemoryRegion *envm_data = g_new(MemoryRegion, 1);
>      char *plic_hart_config;
>      size_t plic_hart_config_len;
> +    NICInfo *nd;
>      int i;
>
>      sysbus_realize(SYS_BUS_DEVICE(&s->e_cpus), &error_abort);
> @@ -269,6 +279,35 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>          qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART4_IRQ),
>          serial_hd(4));
>
> +    /* GEMs */
> +
> +    nd = &nd_table[0];
> +    if (nd->used) {
> +        qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
> +        qdev_set_nic_properties(DEVICE(&s->gem0), nd);
> +    }
> +    nd = &nd_table[1];
> +    if (nd->used) {
> +        qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
> +        qdev_set_nic_properties(DEVICE(&s->gem1), nd);
> +    }
> +
> +    object_property_set_int(OBJECT(&s->gem0), "revision", GEM_REVISION, errp);
> +    object_property_set_int(OBJECT(&s->gem0), "phy-addr", 8, errp);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->gem0), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem0), 0,
> +                    memmap[MICROCHIP_PFSOC_GEM0].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem0), 0,
> +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_GEM0_IRQ));
> +
> +    object_property_set_int(OBJECT(&s->gem1), "revision", GEM_REVISION, errp);
> +    object_property_set_int(OBJECT(&s->gem1), "phy-addr", 9, errp);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->gem1), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem1), 0,
> +                    memmap[MICROCHIP_PFSOC_GEM1].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem1), 0,
> +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_GEM1_IRQ));
> +
>      /* eNVM */
>      memory_region_init_rom(envm_data, OBJECT(dev), "microchip.pfsoc.envm.data",
>                             memmap[MICROCHIP_PFSOC_ENVM_DATA].size,
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index 7825935..60f994c 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -24,6 +24,7 @@
>
>  #include "hw/char/mchp_pfsoc_mmuart.h"
>  #include "hw/dma/mchp_pfsoc_dma.h"
> +#include "hw/net/cadence_gem.h"
>  #include "hw/sd/cadence_sdhci.h"
>
>  typedef struct MicrochipPFSoCState {
> @@ -42,6 +43,8 @@ typedef struct MicrochipPFSoCState {
>      MchpPfSoCMMUartState *serial3;
>      MchpPfSoCMMUartState *serial4;
>      MchpPfSoCDMAState dma;
> +    CadenceGEMState gem0;
> +    CadenceGEMState gem1;
>      CadenceSDHCIState sdhci;
>  } MicrochipPFSoCState;
>
> @@ -84,6 +87,8 @@ enum {
>      MICROCHIP_PFSOC_MMUART2,
>      MICROCHIP_PFSOC_MMUART3,
>      MICROCHIP_PFSOC_MMUART4,
> +    MICROCHIP_PFSOC_GEM0,
> +    MICROCHIP_PFSOC_GEM1,
>      MICROCHIP_PFSOC_ENVM_CFG,
>      MICROCHIP_PFSOC_ENVM_DATA,
>      MICROCHIP_PFSOC_IOSCB_CFG,
> @@ -91,6 +96,8 @@ enum {
>  };
>
>  enum {
> +    MICROCHIP_PFSOC_GEM0_IRQ = 64,
> +    MICROCHIP_PFSOC_GEM1_IRQ = 70,
>      MICROCHIP_PFSOC_EMMC_SD_IRQ = 88,
>      MICROCHIP_PFSOC_MMUART0_IRQ = 90,
>      MICROCHIP_PFSOC_MMUART1_IRQ = 91,
> --
> 2.7.4
>
>

