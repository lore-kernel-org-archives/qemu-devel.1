Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748F1C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40756206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsvX8jEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40756206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Rbr-0001qo-Hm
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0Rb9-0000vR-CV; Tue, 28 Jul 2020 11:32:59 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:35779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k0Rb7-0003M7-PF; Tue, 28 Jul 2020 11:32:59 -0400
Received: by mail-io1-xd42.google.com with SMTP id s189so13929831iod.2;
 Tue, 28 Jul 2020 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aFiggvsybxP7Q+K3MUxmqRhc2eENIdqqqh2Sgg6FwSA=;
 b=HsvX8jEPFGV1imUvxGXB6TqbHibeXL99BAweT80B49/e6Silh0P87mtljdW7uS7zz7
 njG/bQ65jmYThbJm7IhazJxFaeoOR05jphXbfktp/UOXX3biVeMnhfaXL9FEwEws6Jgr
 LfmVvSM2xZIS5MSDFre+ExrlwWS7O2DWzBkSNqln4LQRP3by6tSEiKFJSkwE+PUANGGk
 wehp9VtXOodEWpjdcxAdYSMP37O7kz+EQF+NVdzUgeE15Wod9LxG7bKiIb9LGyf68VWI
 h7CmjtqE/nznt6Dgq13bY3NcNzYeY1stkT5rWWPOWRyxJ3uajXpUDB30gMzTJCca1brm
 6EpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aFiggvsybxP7Q+K3MUxmqRhc2eENIdqqqh2Sgg6FwSA=;
 b=Cez/u8JIuvvCI4e835ACSSC0WjoDuEI8ZEEB7hlEXJE2Z1Z4XUVPxf+9jLysWAxNnq
 deQ7EA0paha0eZVLcxNfYPss6iUNX+9IWEac1eKAY9J++QjLRQrpC28fMaGu4k/jmql5
 jjklKL2JeOsCTkotSk5KJrUrEGZV+RC6NHQQICFHdJzEo3TmWIydXVFOQhEM9qETKgZU
 r5eKAbF6vusexnznLs8GC7izjpFZEGC/p5oeVLdajGBJMJo/5PbbjLe0GX9ZYpriAoPB
 1UprjtJC3ajlF9ZTxHcZdp6PJ9mlepv3u3RMQwH49Rb+iqc0+0Ax/1xEwa0zC97x6oA3
 avFA==
X-Gm-Message-State: AOAM530VDZRZHvKK/fUcLe6j5PDoOVk/B6r0gi9HFvHgSuiYSOCDXM5e
 VEx84PSLCvABChpxbjjGXbGRGLLuHZhBskMoBPc=
X-Google-Smtp-Source: ABdhPJxoj7UHLrYCkgoHrAXLwuILv1cnBNW9I9zIU1rE4GFVStbxrpSGQDZ2xi5a+lLTMdvZH1b5bD/99osMfo4fJPE=
X-Received: by 2002:a02:5b83:: with SMTP id g125mr33368303jab.91.1595950376114; 
 Tue, 28 Jul 2020 08:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <1595227748-24720-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1595227748-24720-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Jul 2020 08:22:37 -0700
Message-ID: <CAKmqyKPSaB_GVM7K6BTzFApSEBWE0xE4_wXi0GbHnwfT0kRXig@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: sifive_u: Add a dummy L2 cache controller device
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
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 19, 2020 at 11:50 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> It is enough to simply map the SiFive FU540 L2 cache controller
> into the MMIO space using create_unimplemented_device(), with an
> FDT fragment generated, to make the latest upstream U-Boot happy.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Applied to riscv-to-apply.next tree for 5.2.

Alistair

> ---
>
>  hw/riscv/sifive_u.c         | 22 ++++++++++++++++++++++
>  include/hw/riscv/sifive_u.h |  4 ++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 6487d5e..f771cb0 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -72,6 +72,7 @@ static const struct MemmapEntry {
>      [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
>      [SIFIVE_U_MROM] =     {     0x1000,     0xf000 },
>      [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
> +    [SIFIVE_U_L2CC] =     {  0x2010000,     0x1000 },
>      [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
>      [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
>      [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
> @@ -302,6 +303,24 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_string(fdt, nodename, "compatible", "gpio-restart");
>      g_free(nodename);
>
> +    nodename = g_strdup_printf("/soc/cache-controller@%lx",
> +        (long)memmap[SIFIVE_U_L2CC].base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> +        0x0, memmap[SIFIVE_U_L2CC].base,
> +        0x0, memmap[SIFIVE_U_L2CC].size);
> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
> +        SIFIVE_U_L2CC_IRQ0, SIFIVE_U_L2CC_IRQ1, SIFIVE_U_L2CC_IRQ2);
> +    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
> +    qemu_fdt_setprop(fdt, nodename, "cache-unified", NULL, 0);
> +    qemu_fdt_setprop_cell(fdt, nodename, "cache-size", 2097152);
> +    qemu_fdt_setprop_cell(fdt, nodename, "cache-sets", 1024);
> +    qemu_fdt_setprop_cell(fdt, nodename, "cache-level", 2);
> +    qemu_fdt_setprop_cell(fdt, nodename, "cache-block-size", 64);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible",
> +                            "sifive,fu540-c000-ccache");
> +    g_free(nodename);
> +
>      phy_phandle = phandle++;
>      nodename = g_strdup_printf("/soc/ethernet@%lx",
>          (long)memmap[SIFIVE_U_GEM].base);
> @@ -732,6 +751,9 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>
>      create_unimplemented_device("riscv.sifive.u.dmc",
>          memmap[SIFIVE_U_DMC].base, memmap[SIFIVE_U_DMC].size);
> +
> +    create_unimplemented_device("riscv.sifive.u.l2cc",
> +        memmap[SIFIVE_U_L2CC].base, memmap[SIFIVE_U_L2CC].size);
>  }
>
>  static Property sifive_u_soc_props[] = {
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index aba4d01..d3c0c00 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -71,6 +71,7 @@ enum {
>      SIFIVE_U_DEBUG,
>      SIFIVE_U_MROM,
>      SIFIVE_U_CLINT,
> +    SIFIVE_U_L2CC,
>      SIFIVE_U_L2LIM,
>      SIFIVE_U_PLIC,
>      SIFIVE_U_PRCI,
> @@ -86,6 +87,9 @@ enum {
>  };
>
>  enum {
> +    SIFIVE_U_L2CC_IRQ0 = 1,
> +    SIFIVE_U_L2CC_IRQ1 = 2,
> +    SIFIVE_U_L2CC_IRQ2 = 3,
>      SIFIVE_U_UART0_IRQ = 4,
>      SIFIVE_U_UART1_IRQ = 5,
>      SIFIVE_U_GPIO_IRQ0 = 7,
> --
> 2.7.4
>
>

