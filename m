Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FD1C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890F421D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 22:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvAl5Wsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890F421D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDGC0-0001Pu-41
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 18:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iDGAK-0000hm-L5
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iDGAJ-00020e-Ew
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 18:53:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iDGAJ-0001zU-6g; Wed, 25 Sep 2019 18:53:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id m13so69077ljj.11;
 Wed, 25 Sep 2019 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8YSZqvZRVm6mPxrLNB2HHNM677pfww4S8zrRN1tTG6s=;
 b=IvAl5WspjGUeCiWqOcXU1pAem0+ZiB806Q1C9RZ1WJk/ujm+31Tp7FGqsxXrvZamhw
 sAGsoRGzoC8dU/598CyNDSDygkfvmiHvyb0hI5lQyE2LBRUvTbpDQUF8APUA3TgpBvfm
 tEHOj5NPnfXKL/ev7GTVlEZl1V5cRBLM4EqXYemJ/9uoOOUxlPd13VaVaVoYXXJ35i/e
 6PzCiS2Icqpmm/IYdMiWdyR6nlVYfeZLfyzQ2HUtWW5wleH3uAEzqIuKLrbkHfTq21wS
 Vv/hvUTv6Qns5mJo9C0WZgIsW+qLW5c1ZxhUucYyDwtP8Ka0nBcRNOk0LjDvuU+Cmzy8
 /g3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8YSZqvZRVm6mPxrLNB2HHNM677pfww4S8zrRN1tTG6s=;
 b=Z4oK7X55yxDP5q6pQu+sWlGN/YpLHP9I/B5H2iOwyLBswizx63CXghojTfQw9bTABm
 ON89vdacE3zcHNlNlrPltSZIDud1uHGoHcIcJqgPiw2/OX9vs0oCxeIUR0C5QL066syY
 +jSONEqVRGy88VxIxbQ3qEI5j25lIwQV3Qk3SRiR1GoXizMxh0ljklg8+7j8S/7bdA5/
 7kBWYgMK7HcRjNwV+QbcJIQEfN3ZNkx4mPWL2cEh+4MaenGsssKRfoCqsT5nSteySwKH
 LPMbt4yY90/PE/OQMC8nIdhZLHeXLtpAh7wjUFMKZ5NyAxB5l9ClAWmKMD3/7cK5AVOo
 b01A==
X-Gm-Message-State: APjAAAUehanIVQ+YJcGAJu0SiLMbexihVNeYipsa+BZjfYoHeJRfWQsW
 lbtcI8FddRWQVrzAWGcyK0/jRPx0XtbseJyFlyI=
X-Google-Smtp-Source: APXvYqzzYtAVajqpdZ2h9uzAoiYG5QwvjPGWkqstmqrYlZIzfGKfJ+Bj/opNhN5Ehn0z1UiaYD2bOW2xLxQWHjp9mOg=
X-Received: by 2002:a2e:3902:: with SMTP id g2mr426547lja.196.1569451961701;
 Wed, 25 Sep 2019 15:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <1569413099-6859-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1569413099-6859-1-git-send-email-guoren@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Sep 2019 15:47:58 -0700
Message-ID: <CAKmqyKNYZWRoWFPUofTw0JpVrAG8eZOT8QDWeOgj5GB4gCt7ZA@mail.gmail.com>
Subject: Re: [PATCH V5] target/riscv: Ignore reserved bits in PTE for RV64
To: Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.193
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>,
 Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 25, 2019 at 5:05 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
> need to ignore them. They cannot be a part of ppn.
>
> 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
>    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
>    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Tested-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h   | 7 +++++++
>  target/riscv/cpu_helper.c | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
>  Changelog V5:
>   - Update Reviewer and Tester.
>
>  Changelog V4:
>   - Change title to Ignore not Bugfix
>   - Use PTE_PPN_MASK for RV32 and RV64
>
>  Changelog V3:
>   - Use UUL define for PTE_RESERVED
>   - Keep ppn >> PTE_PPN_SHIFT
>
>  Changelog V2:
>   - Bugfix pte destroyed cause boot fail
>   - Change to AND with a mask instead of shifting both directions
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index e998348..399c2c6 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -473,6 +473,13 @@
>  /* Page table PPN shift amount */
>  #define PTE_PPN_SHIFT       10
>
> +/* Page table PPN mask */
> +#if defined(TARGET_RISCV32)
> +#define PTE_PPN_MASK        0xffffffffUL
> +#elif defined(TARGET_RISCV64)
> +#define PTE_PPN_MASK        0x3fffffffffffffULL
> +#endif
> +
>  /* Leaf page shift amount */
>  #define PGSHIFT             12
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 87dd6a6..9961b37 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -261,7 +261,7 @@ restart:
>  #elif defined(TARGET_RISCV64)
>          target_ulong pte = ldq_phys(cs->as, pte_addr);
>  #endif
> -        hwaddr ppn = pte >> PTE_PPN_SHIFT;
> +        hwaddr ppn = (pte & PTE_PPN_MASK) >> PTE_PPN_SHIFT;
>
>          if (!(pte & PTE_V)) {
>              /* Invalid PTE */
> --
> 2.7.4
>

