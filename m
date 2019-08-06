Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE0FC0650F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90F120880
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5rXUBzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90F120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hunHy-0001zx-6f
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 20:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36118)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hunHL-0001YL-Mi
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hunHK-0005mT-B3
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:24:39 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hunHJ-0005lv-Un; Mon, 05 Aug 2019 20:24:38 -0400
Received: by mail-lj1-x241.google.com with SMTP id r9so80745081ljg.5;
 Mon, 05 Aug 2019 17:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kzhYmgt/G/LzfwnCUIbFMAD3JWl5Qnrk/KSpZ6BoUb0=;
 b=r5rXUBzSWbRO36gFvzgD+qPYAoJh8GCfwaLHRQkgHq90d1hhaYP/M8AYyUWPUQYhyA
 H2fKPCOqUEW2CqhQvCi4WbN4iNT29FOAobFCDmERnKhED/MrESz6CvbZl10ozTgW3DsN
 fxHL0TBvdzHpDRjh0Kj//l9NTgiR8Togv6Gm68K7s0FEh1eczjdPl9kdJisgmkaBcU4Q
 xnVW2k3mhza14X8mKk5lpK159H3xd/Lk4wKyu26ONBvut3HHXMxcJ/9a8q1oHcMwT9C/
 USDfjgyiECMNS8O7J/IITddVqRFc8riE3aL7k/0lzIbOhl5sRnTtlrceITBDdmzyJJIC
 SGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kzhYmgt/G/LzfwnCUIbFMAD3JWl5Qnrk/KSpZ6BoUb0=;
 b=fXM6MrPDdhg0STEIbI5vGrLG/IQVmLSMPzbAZ0sEHLc5u8qUBPcE/6Vrv3O/dRBVXy
 vA5vLKlcfC8jBp5WHxQqoAH4UZY8dByNoYN0cen4ivlOmQlwxjOt2aodvLIJ3syHExUq
 riCG8YrsJIMNII6XPIEp+ln82HypnCPAppnxGMa8oQ1VKpn32yMMtkT+x4OCWcQwdm6e
 KclL1kYXh7XTmioAlFYm/l/7ja5bz2mKVGsT8CYeIcA+Gf8oiTzhGzwJPt0qpdWxxWIP
 raySXD2eflC+N6mHm4Q6r/U1kwE5lmemN0JOTKUKcPHjIarhEgfkBhKf8PfwSGNPQjQ7
 Lq9g==
X-Gm-Message-State: APjAAAWr7ZhW6oXzRdjbyI0TbT/60lshlqOLEo/+B7053ggC0SlWyhFP
 wNLN5h9Q3aE38x2TYrUYJtZyT4UGJtHH+6Qn8P8=
X-Google-Smtp-Source: APXvYqwWTXdoqepW4hn7Zy34f6VGX4jXjlVLV/4FaqkbA/rdZXOttk53dcYK0kLpLR2qndmhCmVf6/7DdTHfVnUXsSY=
X-Received: by 2002:a2e:480a:: with SMTP id v10mr219234lja.94.1565051076488;
 Mon, 05 Aug 2019 17:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
 <1565020823-24223-18-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565020823-24223-18-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Aug 2019 17:20:57 -0700
Message-ID: <CAKmqyKP8C5ULWNo312VRuwAUypPeOO3R6UCYhvhSNLKvN_-mYQ@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 17/28] riscv: sifive_u: Change UART node
 name in device tree
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 5, 2019 at 9:05 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> OpenSBI for fu540 does DT fix up (see fu540_modify_dt()) by updating
> chosen "stdout-path" to point to "/soc/serial@...", and U-Boot will
> use this information to locate the serial node and probe its driver.
> However currently we generate the UART node name as "/soc/uart@...",
> causing U-Boot fail to find the serial node in DT.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_u.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 20dee52..8044166 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -273,7 +273,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
>      qemu_fdt_setprop_cell(fdt, nodename, "reg", 0x0);
>      g_free(nodename);
>
> -    nodename = g_strdup_printf("/soc/uart@%lx",
> +    nodename = g_strdup_printf("/soc/serial@%lx",
>          (long)memmap[SIFIVE_U_UART0].base);
>      qemu_fdt_add_subnode(fdt, nodename);
>      qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,uart0");
> --
> 2.7.4
>
>

