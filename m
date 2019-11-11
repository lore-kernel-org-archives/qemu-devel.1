Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF9DC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 19:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AF152184C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 19:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd0saf5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF152184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUFGA-00064M-CF
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 14:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iUFF4-0005dT-Es
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 14:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iUFF2-0004oa-HF
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 14:20:50 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40887)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iUFEu-0004cg-Mh; Mon, 11 Nov 2019 14:20:42 -0500
Received: by mail-lj1-x242.google.com with SMTP id q2so15058483ljg.7;
 Mon, 11 Nov 2019 11:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ETdMemaZTfeFpM+B3101O42yHml/IcoDH78rrl1aWNQ=;
 b=Dd0saf5A02IMXZKmZyyJ3V4nIGHo6eoAhbRA9iTLuiHLd8KEsKelJwtKJuEgGRqlFx
 q9RMCBGtnk6++91xJTzdvqY70NBrRH9Wxm4kBSvPtvzd3qWnoIklfnQ8M0V2wXkWneM4
 1tZpRyG7j0hRT3dcO6HI+ktciC9rTBhNti/aIdK80Wiiv593flZebfeshNa9PqGhAI5P
 RNbEeIgeG+QAy+G1Yr7Lu+HZ0ig5owo966cLjW7y1NDu91/vde9uQalArm97rgIAkc6k
 oSu90KdWOY3wKtfvdkIt0oVxvpI3toUURB9jqkTaNhGNnxIoWcG2AQhGQQEgUua3YIuK
 oWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ETdMemaZTfeFpM+B3101O42yHml/IcoDH78rrl1aWNQ=;
 b=OkPuEu3zw1Lr7NEIuaS7EpVXr3v7EmsrWqJ75zQIlhfUplpPy6ESbZYxNaRAUVOJvB
 KA/mc3xM8Nfpz1Hu+qbnuPrrujdPT6qmA4b5yib1XMNBG+CatbsE4BduNP5OXSBgcc9z
 D+ztgXuxn8VdEWx7+IsYoQnps3waGyAoMGJ86tPvN512kC/aOoFPQ8Fqskf+T39I8pfL
 DkT2G/qEMEPFdhKFIXRqQyGJxNB6XwxERnqDXHs3nPJgZWzG2JqIbbfJHUL6Y8a707cP
 PVwTSlNDR3ZYBxpNx7HhyN3JqjkYKucpHKCnz7MMCQoMSHwSAqEC3YlG4pb1qLd8qtmI
 ec/w==
X-Gm-Message-State: APjAAAXFRdJn+C9CJG9CW+MIST4nV5TjuypkscWsn2TPQ8z+u1I4+kL4
 p2ucsKIcbSQjkGksXBeSmV0TrOtWfx/rn1dFSEg=
X-Google-Smtp-Source: APXvYqze95lG99GsJO8TEhahnnLdKOaXMiDzfjw4RiTnnNFdfPQpazOuqmfJMLkXTH8Ot+cNkxwZdSb+EOhcIIYfZ7g=
X-Received: by 2002:a2e:6a19:: with SMTP id f25mr671381ljc.147.1573500031997; 
 Mon, 11 Nov 2019 11:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20191111133804.14454-1-anup.patel@wdc.com>
In-Reply-To: <20191111133804.14454-1-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 11 Nov 2019 11:14:44 -0800
Message-ID: <CAKmqyKNxYY81ZS-G9p4Ne+kY0_mUhuo+6zCAPqbmdRB9hmJN+Q@mail.gmail.com>
Subject: Re: [PATCH] riscv/virt: Add syscon reboot and poweroff DT nodes
To: Anup Patel <Anup.Patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 5:38 AM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> The SiFive test device found on virt machine can be used by
> generic syscon reboot and poweroff drivers available in Linux
> kernel.
>
> This patch updates FDT generation in virt machine so that
> Linux kernel can probe and use generic syscon drivers.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Overall this looks fine. Palmer currently has a patch on list changing
the sifive test string as well. It's probably best to rebase this on
that patch.

We probably also need to make sure this is accepted in the RISC-V
kernel tree first.

Alistair

> ---
>  hw/riscv/virt.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index cc8f311e6b..fdfa359713 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -182,11 +182,11 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      uint64_t mem_size, const char *cmdline)
>  {
>      void *fdt;
> -    int cpu;
> +    int cpu, i;
>      uint32_t *cells;
>      char *nodename;
> -    uint32_t plic_phandle, phandle = 1;
> -    int i;
> +    const char test_compat[] = "sifive,test0\0syscon";
> +    uint32_t plic_phandle, test_phandle, phandle = 1;
>      hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
>      hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
>
> @@ -356,13 +356,33 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      create_pcie_irq_map(fdt, nodename, plic_phandle);
>      g_free(nodename);
>
> +    test_phandle = phandle++;
>      nodename = g_strdup_printf("/test@%lx",
>          (long)memmap[VIRT_TEST].base);
>      qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,test0");
> +    qemu_fdt_setprop(fdt, nodename, "compatible",
> +                     test_compat, sizeof(test_compat));
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[VIRT_TEST].base,
>          0x0, memmap[VIRT_TEST].size);
> +    qemu_fdt_setprop_cell(fdt, nodename, "phandle", test_phandle);
> +    test_phandle = qemu_fdt_get_phandle(fdt, nodename);
> +    g_free(nodename);
> +
> +    nodename = g_strdup_printf("/reboot");
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-reboot");
> +    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
> +    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_RESET);
> +    g_free(nodename);
> +
> +    nodename = g_strdup_printf("/poweroff");
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-poweroff");
> +    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
> +    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_PASS);
>      g_free(nodename);
>
>      nodename = g_strdup_printf("/uart@%lx",
> --
> 2.17.1
>
>

