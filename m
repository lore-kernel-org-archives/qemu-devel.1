Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5DAC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 18:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8BC22D6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 18:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sM3Az+iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8BC22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i08xE-0001Oo-52
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 14:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i08uK-0007y3-RB
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 14:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i08uJ-0002rz-JZ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 14:31:00 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:43083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i08uJ-0002qe-Bx; Tue, 20 Aug 2019 14:30:59 -0400
Received: by mail-lf1-x142.google.com with SMTP id c19so4875738lfm.10;
 Tue, 20 Aug 2019 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gwOr14KGaGz9a1KxZ5kvmL2cBh45zg0ovh8E45LSHcA=;
 b=sM3Az+iz/8aEM8yxHRFVU8pGlqRRu1UlpswT0DedcfIa7GNFX+d03/DwndDpddqVqa
 DXXVY0KebJ5o+Vr/gl0lFNCKx4yeAqNMPRTTE4JOEYMRMSxdvQ/7+SYyNhzWoa5Ka2ly
 hL+CfO4nFqAn1/3NhZbgoNLgWwfGoH7Kw3HI3R6IwyTA/01ka3DlFMZ6vwzttdbUconw
 9VLBPseE2MtnEl+ED40ByZdt1mtkydYzIc2N7SCiYmokvONpqviYEC8Chi8EBIB/mReT
 RnRxdjTFXTwxLQoMrfyhyAXe49AbthTmzKpS+vuvfnCvpR7n8oRkzUcFtJq0JGVusPfO
 lK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gwOr14KGaGz9a1KxZ5kvmL2cBh45zg0ovh8E45LSHcA=;
 b=YnSQ6UlDre3sZNYSwpbUdhy+F4GDtJwAJXCdKugBdz8Lpcz9DHHxpi2mksM69uC+7y
 FeDBkbKSgat8jk310taWfFZ+3eM0i5qVgY/YMjC9m48t6nm3KEyFus3OW0ZXbJ/mPGBx
 hWpiRVTGXBvTSr4QIcZ8fjfcU0P3Vs9FurALzkCteZy56TYExKMv+4RfURd2eS0AJM6d
 0NzCzCmClvIeEqLeyTs4NHnaQEyb7sjxyujQX+BPXmweMzUlKT1Lypc3GdcKXeKHLWQ+
 AO7Pv6orsNNNk1Pkjveu+KdRLb4pCeXNdU/7ok1b6jxTTWKTnbLSbux+n31CVJBB2LCi
 W7VQ==
X-Gm-Message-State: APjAAAU2yTkVPrE1aoMqePGnRsvwcBOW8m7F5hZws3d19e+FfzvCGfig
 V3gUcX9iiSA+ZoDunax1Wf1SbwsKIiHV/T+ixuU=
X-Google-Smtp-Source: APXvYqzDNS0eNhrUsQdLXRIDOu2uVOVCW2u7uKOTWB5YiyG3LK+n6FQxCmrSzkMMQdCBhazrcmj9+Rnb3jtRPSJ8004=
X-Received: by 2002:a19:ed11:: with SMTP id y17mr16106170lfy.141.1566325857684; 
 Tue, 20 Aug 2019 11:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
 <1566191521-7820-21-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1566191521-7820-21-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 Aug 2019 11:26:55 -0700
Message-ID: <CAKmqyKPu8=VB5AnbC3nqbc889T5oYZOwsdymkk=yjTz_jjsqYA@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v4 20/28] riscv: sifive_u: Reference PRCI
 clocks in UART and ethernet nodes
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

On Sun, Aug 18, 2019 at 10:24 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Now that we have added a PRCI node, update existing UART and ethernet
> nodes to reference PRCI as their clock sources, to keep in sync with
> the Linux kernel device tree.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  hw/riscv/sifive_u.c              |  7 ++++---
>  include/hw/riscv/sifive_u_prci.h | 10 ++++++++++
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index bd5551c..8818fd6 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -80,7 +80,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      int cpu;
>      uint32_t *cells;
>      char *nodename;
> -    char ethclk_names[] = "pclk\0hclk\0tx_clk";
> +    char ethclk_names[] = "pclk\0hclk";
>      uint32_t plic_phandle, prci_phandle, ethclk_phandle, phandle = 1;
>      uint32_t uartclk_phandle;
>      uint32_t hfclk_phandle, rtcclk_phandle;
> @@ -265,7 +265,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
>      qemu_fdt_setprop_cell(fdt, nodename, "interrupts", SIFIVE_U_GEM_IRQ);
>      qemu_fdt_setprop_cells(fdt, nodename, "clocks",
> -        ethclk_phandle, ethclk_phandle, ethclk_phandle);
> +        prci_phandle, PRCI_CLK_GEMGXLPLL, prci_phandle, PRCI_CLK_GEMGXLPLL);
>      qemu_fdt_setprop(fdt, nodename, "clock-names", ethclk_names,
>          sizeof(ethclk_names));
>      qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", 1);
> @@ -295,7 +295,8 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[SIFIVE_U_UART0].base,
>          0x0, memmap[SIFIVE_U_UART0].size);
> -    qemu_fdt_setprop_cell(fdt, nodename, "clocks", uartclk_phandle);
> +    qemu_fdt_setprop_cells(fdt, nodename, "clocks",
> +        prci_phandle, PRCI_CLK_TLCLK);
>      qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
>      qemu_fdt_setprop_cell(fdt, nodename, "interrupts", SIFIVE_U_UART0_IRQ);
>
> diff --git a/include/hw/riscv/sifive_u_prci.h b/include/hw/riscv/sifive_u_prci.h
> index 66eacb5..cdf1d33 100644
> --- a/include/hw/riscv/sifive_u_prci.h
> +++ b/include/hw/riscv/sifive_u_prci.h
> @@ -87,4 +87,14 @@ typedef struct SiFiveUPRCIState {
>
>  DeviceState *sifive_u_prci_create(hwaddr addr);
>
> +/*
> + * Clock indexes for use by Device Tree data and the PRCI driver.
> + *
> + * These values are from sifive-fu540-prci.h in the Linux kernel.
> + */
> +#define PRCI_CLK_COREPLL        0
> +#define PRCI_CLK_DDRPLL         1
> +#define PRCI_CLK_GEMGXLPLL      2
> +#define PRCI_CLK_TLCLK          3
> +
>  #endif /* HW_SIFIVE_U_PRCI_H */
> --
> 2.7.4
>
>

