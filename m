Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448CFC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4E822CEB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+qOJned"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4E822CEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzoTp-0006K8-QN
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1hzoF3-0004LC-3p
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hzoF1-000762-NN
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:27:01 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:41417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hzoF1-00075V-G8; Mon, 19 Aug 2019 16:26:59 -0400
Received: by mail-lj1-x243.google.com with SMTP id m24so2987426ljg.8;
 Mon, 19 Aug 2019 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2tHNO/2YKUjne/eJzPQiDdmnwhtdEyOWxg+vIIKrmiU=;
 b=h+qOJnedymDCFRkXHbSBUcKRjlBCfxwQ+1OgDC4O6V3URkVhTUhaiT2X7EgbrED8xx
 +8wsYyFWBjwOxLS6kTvhfNt5wvktdiEh09pNlM6efHWpaUtxVmu/CfOMpbj3AkLXz4+4
 sdEMRbIwA6dUWmnhF9hjcOTee6+L26wgnyH4yk//U8mQjbiL/vB+psvJSBaM67E3/eqL
 MTCc3wpwpiMzIdLDlDSTYHVN7QXzmYhnxtagYQ+Riu/wsgcks7uqhe6tPLiCPLxkoPpE
 ZTudqB6H6PsLObNYozRnWr4+zt72Qm+h/fKZad7NoFTJBET45FXbWaXaohzordxCluNj
 4zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2tHNO/2YKUjne/eJzPQiDdmnwhtdEyOWxg+vIIKrmiU=;
 b=GEUgzasR8GxIyUoXsxiKt99bt/Mq+cF/hosAxyMzWNP84KA/07oivFTcdp+ospu/Qq
 fTrG11SLjcsK7IBOP/INTDHHnDRuNGgkni2yude5d17/0PySpPz4ysoXk9cuOd7ny9PJ
 Kh6WsiQE2pDj8fiM/0qdv5YLUB3VLNb3nZ7WP75Iuh2LyKv9yaNSsUJVEhpNwlsykAlO
 VJHvAFcXoKHpsvbTiUrRIsuMURdmWkZutx5BOSu3Qk2eF5PRZJXbTbwFyjbvnFtZ07FI
 td7Brpr3Koitv9guXUz4J2Yr8TwzuUkkN2JVmenYWYVV/AruufqjoR6AxxNsNWM9k3eC
 LFxg==
X-Gm-Message-State: APjAAAWRgjyjU1xETZtpfck2fHEQPnBDujpzFt44BSpyIlelKdP0uhR4
 uojsvrztjfhG3ffFUgf0r0hof8zWg3xBXlo+lql7u0dF
X-Google-Smtp-Source: APXvYqwMM8H9nwYDKsmsiYIQLimupad8z1NumoibTiI9icIsS6Ebb752Dqeipum+Oy+fW7dEpLh4/jG4V0NQUe1awMo=
X-Received: by 2002:a05:651c:1023:: with SMTP id
 w3mr12949411ljm.94.1566246418221; 
 Mon, 19 Aug 2019 13:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <1566191521-7820-1-git-send-email-bmeng.cn@gmail.com>
 <1566191521-7820-19-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1566191521-7820-19-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2019 13:22:57 -0700
Message-ID: <CAKmqyKNoxtymAE84qdvKG-wsXcEF9oiWfYhvjrRPMtn2Gbwa=Q@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v4 18/28] riscv: sifive_u: Generate hfclk
 and rtcclk nodes
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

On Sun, Aug 18, 2019 at 10:29 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> To keep in sync with Linux kernel device tree, generate hfclk and
> rtcclk nodes in the device tree, to be referenced by PRCI node.
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
>  hw/riscv/sifive_u.c         | 23 +++++++++++++++++++++++
>  include/hw/riscv/sifive_u.h |  2 ++
>  2 files changed, 25 insertions(+)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 284f7a5..08db741 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -80,6 +80,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      char ethclk_names[] = "pclk\0hclk\0tx_clk";
>      uint32_t plic_phandle, ethclk_phandle, phandle = 1;
>      uint32_t uartclk_phandle;
> +    uint32_t hfclk_phandle, rtcclk_phandle;
>
>      fdt = s->fdt = create_device_tree(&s->fdt_size);
>      if (!fdt) {
> @@ -98,6 +99,28 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
>
> +    hfclk_phandle = phandle++;
> +    nodename = g_strdup_printf("/hfclk");
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_cell(fdt, nodename, "phandle", hfclk_phandle);
> +    qemu_fdt_setprop_string(fdt, nodename, "clock-output-names", "hfclk");
> +    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
> +        SIFIVE_U_HFCLK_FREQ);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
> +    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
> +    g_free(nodename);
> +
> +    rtcclk_phandle = phandle++;
> +    nodename = g_strdup_printf("/rtcclk");
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_cell(fdt, nodename, "phandle", rtcclk_phandle);
> +    qemu_fdt_setprop_string(fdt, nodename, "clock-output-names", "rtcclk");
> +    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency",
> +        SIFIVE_U_RTCCLK_FREQ);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "fixed-clock");
> +    qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
> +    g_free(nodename);
> +
>      nodename = g_strdup_printf("/memory@%lx",
>          (long)memmap[SIFIVE_U_DRAM].base);
>      qemu_fdt_add_subnode(fdt, nodename);
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 7a1a4f3..debbf28 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -68,6 +68,8 @@ enum {
>
>  enum {
>      SIFIVE_U_CLOCK_FREQ = 1000000000,
> +    SIFIVE_U_HFCLK_FREQ = 33333333,
> +    SIFIVE_U_RTCCLK_FREQ = 1000000,
>      SIFIVE_U_GEM_CLOCK_FREQ = 125000000
>  };
>
> --
> 2.7.4
>
>

