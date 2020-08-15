Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E524CC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEEF423101
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD+Tbwl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEF423101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xqK-0001jS-T9
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6xl0-0001i0-4l; Sat, 15 Aug 2020 11:06:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6xkw-0007P7-Ne; Sat, 15 Aug 2020 11:06:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id c15so10776133wrs.11;
 Sat, 15 Aug 2020 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rzvzX/q48G/5lbz2V3/I6m58sYU6eRhRCBMzPGbBvao=;
 b=MD+Tbwl/NiEmrNjqFUYF2dly6NDOMm1VPajKXKAPw+3E/sAH/X6HLRE4CoUL+0VDfD
 NgT1OG4PrvCQhigqDcT4kGZfETMYdG5RdtSkTmbSrIF/hy3zUL7okuVo0iVyPoWvHIKj
 zNFEMLHEvdgYVR/MIKBynYdi+C7N/9PF5hpLs/dvfLqp2p1FbO7oLrtDJYTzh+6ZrDYZ
 iDJreeTwpQP0wV85IAoLOiTAnOfAQJXGRIzFvqLtQguP2cwu/Lb5Ta+R6wCldIe3YvE9
 h6dGMRpG8DOoxiIy5M9UfIqQtCYZN+//zAKoTAU8z67LN4stcNrYzwF8REFU27LaEVWM
 uNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rzvzX/q48G/5lbz2V3/I6m58sYU6eRhRCBMzPGbBvao=;
 b=N1JAeHZCfCXUCQzULfW+V13Iir+yJUQvbnj6ijyC19tzEG8ZGs3hc/Nri+AAWlNyyc
 u/ebBjWb+N6KWhYFntHmOwMK0RQzeym/kLgLOI6RW1rVLnVD1SvlAvQ3wYrS4c69nEr5
 JrXXRwjt4Gz+sbp0b19M5THIP9lSPqGza/H2uI3xESnqznePqEW5WZvKzOjg4+IAB5ho
 QzR7YYsUG5//4Ox+53PpWm7yyfkSwJaLN2rchX8hgrXvUV3+Z34TfeR0Th+2gxvdciJe
 Rqami9QdDnjw4U3wjbbaOq228DkrU0fj7cGAgFXKbHtolu0MN+8fil3CFEANTLGwWtw0
 TcoA==
X-Gm-Message-State: AOAM531s/MeVfBiK7eSSgkr37PK0RorZP3BpbEcZdpS41ErWLlNcyuC8
 5VhNH2DlfZ46PCKco+A72uefehu++Fk=
X-Google-Smtp-Source: ABdhPJzhefN+OqShOL9GDpbiANzbWKZ4wXJUOIyepQWiEuxyVvcecVH0FzabPr26p5jWgKmbtJOliw==
X-Received: by 2002:adf:e6cc:: with SMTP id y12mr6070223wrm.391.1597482001665; 
 Sat, 15 Aug 2020 02:00:01 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 69sm21639810wmb.8.2020.08.15.02.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2020 02:00:01 -0700 (PDT)
Subject: Re: [PATCH 13/18] hw/riscv: microchip_pfsoc: Connect a DMA controller
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-14-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e96742b4-3d58-e9b7-def9-3fb1fb89f750@amsat.org>
Date: Sat, 15 Aug 2020 11:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1597423256-14847-14-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 6:40 PM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> Connect a DMA controller to Microchip PolarFire SoC. Note interrupt
> has not been connected due to missing information in the manual how
> interrupts are routed to PLIC.
> 
> On the Icicle Kit board, the HSS firmware utilizes the on-chip DMA
> controller to move the 2nd stage bootloader in the system memory.
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
> 
>  hw/riscv/Kconfig                   |  1 +
>  hw/riscv/microchip_pfsoc.c         | 10 ++++++++++
>  include/hw/riscv/microchip_pfsoc.h |  3 +++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 7412db9..9323701 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -55,4 +55,5 @@ config MICROCHIP_PFSOC
>      select SIFIVE
>      select UNIMP
>      select MCHP_PFSOC_MMUART
> +    select MCHP_PFSOC_DMA
>      select CADENCE_SDHCI
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 7c09078..1c67cbc 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -13,6 +13,7 @@
>   * 2) eNVM (Embedded Non-Volatile Memory)
>   * 3) MMUARTs (Multi-Mode UART)
>   * 4) Cadence eMMC/SDHC controller and an SD card connected to it
> + * 5) DMA (Direct Memory Access Controller)
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
> +                            TYPE_MCHP_PFSOC_DMA);
> +
>      object_initialize_child(obj, "sd-controller", &s->sdhci,
>                              TYPE_CADENCE_SDHCI);

I haven't looked at the chip specs, but maybe you can add the SD
controller after the DMA controller so so you can directly link
a DMA address space to it.

>      object_initialize_child(OBJECT(&s->sdhci), "sd-controller.sdhci",
> @@ -220,6 +225,11 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>          memmap[MICROCHIP_PFSOC_PLIC].size);
>      g_free(plic_hart_config);
>  
> +    /* DMA */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dma), 0,
> +                    memmap[MICROCHIP_PFSOC_DMA].base);
> +
>      /* SYSREG */
>      create_unimplemented_device("microchip.pfsoc.sysreg",
>          memmap[MICROCHIP_PFSOC_SYSREG].base,
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index d810ee8..7825935 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -23,6 +23,7 @@
>  #define HW_MICROCHIP_PFSOC_H
>  
>  #include "hw/char/mchp_pfsoc_mmuart.h"
> +#include "hw/dma/mchp_pfsoc_dma.h"
>  #include "hw/sd/cadence_sdhci.h"
>  
>  typedef struct MicrochipPFSoCState {
> @@ -40,6 +41,7 @@ typedef struct MicrochipPFSoCState {
>      MchpPfSoCMMUartState *serial2;
>      MchpPfSoCMMUartState *serial3;
>      MchpPfSoCMMUartState *serial4;
> +    MchpPfSoCDMAState dma;
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
> 


