Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43387C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E013A21655
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGDERick"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E013A21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0vqK-00082C-1Y
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 18:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i0vo5-0006SM-HJ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i0vo4-0006w3-AI
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:43:49 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:47033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i0vo4-0006v5-0Z; Thu, 22 Aug 2019 18:43:48 -0400
Received: by mail-lf1-x142.google.com with SMTP id n19so5668170lfe.13;
 Thu, 22 Aug 2019 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wQ/wLYsLBZ4AJYC4nLOvYyuZenC/DykUOq/U3Ax8YYk=;
 b=bGDERickFjBhvwt/oIMgqbeiCACZKpT07n6ifhRqEaPjFzNirDnBuDEWb1x2rKR9cR
 Lvp9UpcHCYTvGlDuFdxNbNGOZARZB8/BG1soVXArv/WDPMRhuY1aitCZqiqAJrNSFiPv
 CpR/qlOmgBMqDbfXXdGb2n8NHoDNRnAfmQ5aHg33vjXphFEeNxDeYNAknSZeoc/29ZP0
 2Qziyxk2ZhXuE/cYAzDqTFwnmzaIUyJsNrUyiX8QJ/dc2BVsUf+P+bNCBLMGrwCicryb
 zLpQ9UwFENwlwHNoiA4CCer7AgufP4k3xMVJGBbOCliv3QO/bFBVmBuR9mr8+HBxDfkI
 m2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wQ/wLYsLBZ4AJYC4nLOvYyuZenC/DykUOq/U3Ax8YYk=;
 b=iR/QZM6G/7+JHOnrYl5qffo+dRZEAZ/s2KpZrwkhMk6NLq0krBRau0yIdByxcyBEQH
 0W9Vwe6vEbjxfkErt5IKsAcc6N0PmL6cJjd/IBa7gsIS1M1px7r5btf/3hUnvhJVnE93
 oZfKlEeh9ZorVyLDMZVTm8TpWiW/BrL3Zx/Bgdwam2WqCFeBgu6GBpSmsa66loVa5RgW
 offSOAJmZtmS5LaZsmsqq6rdfvNK7ivA3DbVWXdRY4AajxDDr1OLNasIf+H78ZDAraTG
 JDwIAGVRrbaTi/6mVmjewHpXwdZdmrpTn86xJIYmYkgHbC+JJnEg+VXNbQgjJq18MnfV
 /oKg==
X-Gm-Message-State: APjAAAWvDjIfTHNxEsZFFtwbx7Obj16VovyuZPHsiNZF2bIwaUl3dq98
 2ogE7CurWPK1FQ7xkgdli77Km75GzpmwY2xLYTh3iHp5
X-Google-Smtp-Source: APXvYqwSJ74OrnCTrqrMplLgnAC991DDvUXnnSgREUCDC5DsyAI5f+zMHO6mUuaAlDhK0cCDfxy5AIxz4Ey6f5BO0hs=
X-Received: by 2002:a19:6904:: with SMTP id e4mr828813lfc.156.1566513826599;
 Thu, 22 Aug 2019 15:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
 <1566191521-7820-28-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1566191521-7820-28-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 Aug 2019 15:39:41 -0700
Message-ID: <CAKmqyKOYZvNsEtH4Vzja1qkSKJyBMCCS_iONdOP90EDjbq7EGg@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v4 27/28] riscv: sifive_u: Remove
 handcrafted clock nodes for UART and ethernet
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 18, 2019 at 10:31 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> In the past we did not have a model for PRCI, hence two handcrafted
> clock nodes ("/soc/ethclk" and "/soc/uartclk") were created for the
> purpose of supplying hard-coded clock frequencies. But now since we
> have added the PRCI support in QEMU, we don't need them any more.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v4:
> - new patch to remove handcrafted clock nodes for UART and ethernet
>
> Changes in v3: None
> Changes in v2: None
>
>  hw/riscv/sifive_u.c         | 24 +-----------------------
>  include/hw/riscv/sifive_u.h |  3 +--
>  2 files changed, 2 insertions(+), 25 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 7a370e9..7d9fb3a 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -89,8 +89,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      uint32_t *cells;
>      char *nodename;
>      char ethclk_names[] = "pclk\0hclk";
> -    uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
> -    uint32_t uartclk_phandle;
> +    uint32_t plic_phandle, prci_phandle, phandle = 1;
>      uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
>
>      fdt = s->fdt = create_device_tree(&s->fdt_size);
> @@ -250,17 +249,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      g_free(cells);
>      g_free(nodename);
>
> -    ethclk_phandle = phandle++;
> -    nodename = g_strdup_printf("/soc/ethclk");
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
> -    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
> -    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
> -        SIFIVE_U_GEM_CLOCK_FREQ);
> -    qemu_fdt_setprop_cell(fdt, nodename, "phandle", ethclk_phandle);
> -    ethclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
> -    g_free(nodename);
> -
>      phy_phandle = phandle++;
>      nodename = g_strdup_printf("/soc/ethernet@%lx",
>          (long)memmap[SIFIVE_U_GEM].base);
> @@ -292,16 +280,6 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cell(fdt, nodename, "reg", 0x0);
>      g_free(nodename);
>
> -    uartclk_phandle = phandle++;
> -    nodename = g_strdup_printf("/soc/uartclk");
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
> -    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
> -    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 3686400);
> -    qemu_fdt_setprop_cell(fdt, nodename, "phandle", uartclk_phandle);
> -    uartclk_phandle = qemu_fdt_get_phandle(fdt, nodename);
> -    g_free(nodename);
> -
>      nodename = g_strdup_printf("/soc/serial@%lx",
>          (long)memmap[SIFIVE_U_UART0].base);
>      qemu_fdt_add_subnode(fdt, nodename);
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index cba29e1..8880f9c 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -72,8 +72,7 @@ enum {
>  enum {
>      SIFIVE_U_CLOCK_FREQ = 1000000000,
>      SIFIVE_U_HFCLK_FREQ = 33333333,
> -    SIFIVE_U_RTCCLK_FREQ = 1000000,
> -    SIFIVE_U_GEM_CLOCK_FREQ = 125000000
> +    SIFIVE_U_RTCCLK_FREQ = 1000000
>  };
>
>  #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
> --
> 2.7.4
>
>

