Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA47C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA8F20673
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTWWjnaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA8F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT7qw-0006KK-VX
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 12:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iT7pr-0005O2-Cp
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:14:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iT7pq-0004Yv-Ae
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:14:11 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iT7pn-0004Ws-Ma; Fri, 08 Nov 2019 12:14:07 -0500
Received: by mail-lj1-x243.google.com with SMTP id n5so6995386ljc.9;
 Fri, 08 Nov 2019 09:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0ocDzkZHmhvsS6TvCA5Pl7NkzPwEh956pZ5jNBEqhfU=;
 b=MTWWjnaS4E7pkj0Tx3m/JrAcxC8YSYzFLtIocgrPGCVlN8MbFBDmOUtIgoYBjS7bQI
 Z7TDPk/pPUfUNUC90g61p8Rl/ALM0zY0xcGV+LrLeLLRNELKw5nAeaCnUQrETJjCXZ8m
 ztgZyrALavj4SQT1jOPU3TfMFzlivUjOlhW3fYbkcI1Tf313lQHcyu8EhVllygbl8OSj
 XA/c+wMSuJt7hEpc7PnBAikMpKp/VYzArTmWy3rz/hg+VomR7HYULPII138JktjmDJni
 uUV4AZD/EYmqtzVEu8D2b7rqjMY8f4Ik99cRu8/HF1YOqo9rXbF8m/Adk22FElBIkpa7
 RpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0ocDzkZHmhvsS6TvCA5Pl7NkzPwEh956pZ5jNBEqhfU=;
 b=NWztUdrGJ9cxjHDurf9G/4lRFXB5GG0gs15GwtOFJQVlbgUAptv9pL5qqjRAyiEAyt
 K3SXoprGKxscaX/8/70X1E1wdZnU7WPnfwzNyiyOhPdbfQXsb+4VKhEYcJq4f/h+h+gU
 V3M9Nj0zR+srEgBuPqy4XZ3WajQ6QEhJuWD3XNk7b8dxFu2rlHGPPinj16ZPYkDCPLIt
 0ytd0AbWy1WX4IvPJaMeOnmZsc7m/7jYelGvRL8ZDn/4OGzj2Cp/0xqMZr+L8Xd3JM00
 Udl5bGbShEsi/9oJlH/BWwAlttuoz1guLl8N+kEbLMjwbX44arluJUVAFX4miOTAQIoy
 38aw==
X-Gm-Message-State: APjAAAWldwCGIOfZNoq4QKQdL7P2K3SVtRzraX9V7AJrdbGP9QyYfolx
 CWn/o7jd3lBIiz1PVThRYCF+x+8PHJashHHMTWg=
X-Google-Smtp-Source: APXvYqzcd+srBV0OEzSaOc9EYCKzKmICjhXH3lIdI5cHFHY3zNgUpKNcc3RG+fh3CjZbEvqXp5MYdCfPPqKZ8rIdlGo=
X-Received: by 2002:a2e:9151:: with SMTP id q17mr2787929ljg.156.1573233245997; 
 Fri, 08 Nov 2019 09:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20191107222500.8018-1-palmer@sifive.com>
In-Reply-To: <20191107222500.8018-1-palmer@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 8 Nov 2019 09:13:39 -0800
Message-ID: <CAKmqyKOodh3tPUGBM92ZRWFLoeo9E=kcaqO9F9dHz1wBMP9ywA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: virt: This is a "sifive,test1" test finisher
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Christoph Hellwig <hch@infradead.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 8, 2019 at 9:05 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The test finisher implements the reset command, which means it's a
> "sifive,test1" device.  This is a backwards compatible change, so it's
> also a "sifive,test0" device.  I copied the odd idiom for adding a
> two-string compatible field from the ARM virt board.
>
> Fixes: 9a2551ed6f ("riscv: sifive_test: Add reset functionality")
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  hw/riscv/virt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 23f340df19..74f2dce81c 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -359,7 +359,10 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      nodename = g_strdup_printf("/test@%lx",
>          (long)memmap[VIRT_TEST].base);
>      qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,test0");
> +    {
> +        const char compat[] = "sifive,test1\0sifive,test0";

Does this really work? Why not use qemu_fdt_setprop_cells()?

Alistair

> +        qemu_fdt_setprop(fdt, nodename, "compatible", compat, sizeof(compat));
> +    }
>      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>          0x0, memmap[VIRT_TEST].base,
>          0x0, memmap[VIRT_TEST].size);
> --
> 2.21.0
>
>

