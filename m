Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84039C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551712077D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 15:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnQmO+uO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551712077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxu7A-0004ky-Iy
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 11:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jxu6V-0004Dj-1h; Tue, 21 Jul 2020 11:22:51 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:39216)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jxu6T-0005Hm-Du; Tue, 21 Jul 2020 11:22:50 -0400
Received: by mail-io1-xd44.google.com with SMTP id z6so4317739iow.6;
 Tue, 21 Jul 2020 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dg6ywj0QsHTflwHtlgnpMJUCnmY3aA89oiRMLeeCkVU=;
 b=WnQmO+uOxBMCf2Qrld2/ZKoWKpxx+hc+mjYLZQgsWMLP7iwHnKQVtwCvyScPSvZIBc
 EMpgACiOcUFifMDHX/GNzjkQuSt+gPx6vOrK7ZcLuSsvfBohcD8+bGP/+HNgYWcXnkex
 HbH1ubhKS1eLrJt40llhuZi2zLdAvq/WeIB+gWHpGqfmm9oKPQPvNYhrT0hZHJ1RrRWm
 WX1NkUEUqSMDsEvsoRqJAsHqmGWukmmN3tTLaN0Plgu0u6IV2SVur9GQB+lyJBGCpjRR
 zMOvJqik0UPF3ycm+kCAnwkWZqWvl57v1tgCuNuA3vGweie9HtVjybJ/i62jtW/k7UEV
 +XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dg6ywj0QsHTflwHtlgnpMJUCnmY3aA89oiRMLeeCkVU=;
 b=s1hLAD8tW4bCDAAyWYbJ3F8PFzAr4AfjdnWPhjfd8dA64ySeomuR5ReHBXlYFfXzgm
 pDz3GAprxVyC+N2QkKywR9tOMGWBPqMZfdjOHCBMOb6kpJNQkJQVuAsDZHPOt3zYzuuq
 WqGGXnYkOZWMplqjWeTFAU7Z+Po3n4KTSGoub545bh4ROzzUtuyTQc0TZbl/wAYBneYy
 RgJxHIoHllbUGbLMcoXPhpddfzUkhLzgnCOTL4sXED3yX4pi+5GO4oJZdLPNvSkkNavV
 Zd5IoLHTn6IWb/d8qMhI9aD9U5tVgDUowSfp9vJxmPKUXMkPiS0s1/WfJCQKI2lGmJwH
 vB7Q==
X-Gm-Message-State: AOAM531g5TA1rtko54qS2nylGEjkAKfXwR+USWEvWuxzHgLCLZ9O8oZn
 IswNr2IyIqNlNA+x8anrGhIb4d65v7PD8CuLilo=
X-Google-Smtp-Source: ABdhPJyusPRk8SfzFFbnFVCo73IoZ/dyg8Vrrtp9uKeqPr7+Bk5VyNT3Q4sltslhsvVD28hIDXPwJeVKI+ruY7iLUm0=
X-Received: by 2002:a5d:9306:: with SMTP id l6mr28810280ion.105.1595344967830; 
 Tue, 21 Jul 2020 08:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <1594891856-15474-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1594891856-15474-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Jul 2020 08:12:42 -0700
Message-ID: <CAKmqyKOGVqFxh7azqo95TwPtCyBtVLE34x6UFfmqvmbNZWDDXA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: sifive_e: Correct debug block size
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 2:31 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Currently the debug region size is set to 0x100, but according to
> FE310-G000 and FE310-G002 manuals:
>
>   FE310-G000: 0x100 - 0xFFF
>   FE310-G002: 0x0   - 0xFFF
>
> Change the size to 0x1000 that applies to both.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_e.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 7bb97b4..c8b0604 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -54,7 +54,7 @@ static const struct MemmapEntry {
>      hwaddr base;
>      hwaddr size;
>  } sifive_e_memmap[] = {
> -    [SIFIVE_E_DEBUG] =    {        0x0,      0x100 },
> +    [SIFIVE_E_DEBUG] =    {        0x0,     0x1000 },
>      [SIFIVE_E_MROM] =     {     0x1000,     0x2000 },
>      [SIFIVE_E_OTP] =      {    0x20000,     0x2000 },
>      [SIFIVE_E_CLINT] =    {  0x2000000,    0x10000 },
> --
> 2.7.4
>
>

