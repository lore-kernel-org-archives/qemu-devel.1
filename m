Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96673C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D632146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v+nEK+4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D632146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCfq8-0001NU-G3
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 04:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoren@kernel.org>) id 1iCfmE-0007hO-M4
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoren@kernel.org>) id 1iCfmD-0005HF-Bk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38282)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoren@kernel.org>)
 id 1iCfmD-0005Gt-6M; Tue, 24 Sep 2019 04:02:25 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 06645214DA;
 Tue, 24 Sep 2019 08:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569312144;
 bh=1ZiYWI6zpc/T/IrpNHuqqmG0tT4483zjxG7GaqOGz9c=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=v+nEK+4tPaWB4WxiCboJ1KuDE8SbBQRpMGNNNeAyzca+zbgu10JnxNqyr4AmF2X11
 MwjyXcnAnRA8lqd3+29I7V/u6HhX+yX5YKy8vnbpUGZ3uEf9OKm70vLMfot7op+g2Z
 7vMw50bOXnsMAWTgJkqkUNuU3Pb7FEg99Dues0l0=
Received: by mail-wr1-f46.google.com with SMTP id i18so783362wru.11;
 Tue, 24 Sep 2019 01:02:23 -0700 (PDT)
X-Gm-Message-State: APjAAAW/98Ix1mAXesmdDrs2vwAyfK4SXln/aSbcTT6nOJBivLZpr+lD
 Nu9QG8Iz+xv0Bq7WqBMdBDEf4adxzEbW2jqnASk=
X-Google-Smtp-Source: APXvYqyEjj1yyvM1tuDRQ/kHPBHfXfNdRRZolhDBCgT0vf0zpAQZEyH7D3kQjXEJfwUybiHLUxEhYx4PGoZ/HTp8tsU=
X-Received: by 2002:adf:fac3:: with SMTP id a3mr1151180wrs.24.1569312142490;
 Tue, 24 Sep 2019 01:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <1569311902-12173-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1569311902-12173-1-git-send-email-guoren@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 24 Sep 2019 16:02:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT6mXQ7dP+C_MdT==kCoreYWVBEV1bRO+143Ar8AbEuyg@mail.gmail.com>
Message-ID: <CAJF2gTT6mXQ7dP+C_MdT==kCoreYWVBEV1bRO+143Ar8AbEuyg@mail.gmail.com>
Subject: Re: [PATCH V2] target/riscv: Bugfix reserved bits in PTE for RV64
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: alistair23@gmail.com, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I only tested it on qemu-3.1.0, pls have a try before merge.

On Tue, Sep 24, 2019 at 4:00 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
> need to ignore them. They can not be a part of ppn.
>
> 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
>    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
>    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
>
> Changelog V2:
>  - Bugfix pte destroyed cause boot fail
>  - Change to AND with a mask instead of shifting both directions
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu_bits.h   | 3 +++
>  target/riscv/cpu_helper.c | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index e998348..ae8aa0f 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -470,6 +470,9 @@
>  #define PTE_D               0x080 /* Dirty */
>  #define PTE_SOFT            0x300 /* Reserved for Software */
>
> +/* Reserved highest 10 bits in PTE */
> +#define PTE_RESERVED        ((target_ulong)0x3ff << 54)
> +
>  /* Page table PPN shift amount */
>  #define PTE_PPN_SHIFT       10
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 87dd6a6..7a540cc 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -258,10 +258,11 @@ restart:
>          }
>  #if defined(TARGET_RISCV32)
>          target_ulong pte = ldl_phys(cs->as, pte_addr);
> +        hwaddr ppn = pte >> PTE_PPN_SHIFT;
>  #elif defined(TARGET_RISCV64)
>          target_ulong pte = ldq_phys(cs->as, pte_addr);
> +        hwaddr ppn = (pte & ~PTE_RESERVED) >> PTE_PPN_SHIFT;
>  #endif
> -        hwaddr ppn = pte >> PTE_PPN_SHIFT;
>
>          if (!(pte & PTE_V)) {
>              /* Invalid PTE */
> --
> 2.7.4
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

