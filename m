Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B524DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B99206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+bB1Up9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B99206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClXX-0007T4-KN
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jClWZ-00065Z-Fp
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1jClWY-0004Ec-7n
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:42:55 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:34107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1jClWY-0004EB-42; Fri, 13 Mar 2020 10:42:54 -0400
Received: by mail-qk1-x741.google.com with SMTP id f3so12861446qkh.1;
 Fri, 13 Mar 2020 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Lhs5M5RF6Irfg5/8Tr2QKI3TibURWqz0tQXtnJQFmiQ=;
 b=P+bB1Up9lLBMBTbnwhXno66SDsfTzpDUn1gvrFWiPfLHMhPB42LpqgqKT0paOXcnpD
 9yS5kcAJDeon/NTOrr5Ef8UXDA9VfTohtpC7UWX7uT1+otYZWCbr35JWyObceqhstJkD
 Y1wEW/paatMM+BjW73iEkoHCsrObA7NiOgyt69HLdG9foIRFjP2yp9PQ/S6F4tQaf8m1
 iFC27SEGOXAYGBOA2cPETUP/c8aJHmmVY7VyP4ub4RIZdOYMjaLBjQpZd4VuAwU2kC3D
 kyDMSFa9q1LhUvx7bOzF7LKMUnb9RiER2s1FuhB71eBfcRYTLizrhehZCTWJ3Mhh47Y4
 6oBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Lhs5M5RF6Irfg5/8Tr2QKI3TibURWqz0tQXtnJQFmiQ=;
 b=Jt0XgCCLJlg6Zn0x4s+Vr7DeYp+8Dvcpr01QHBRNP1Ya1yZ6TrXYkAnLIHgXy8aE/M
 4qpsZiDZ8Of2qoxR9hACvWQ5ElREetOT+aPTYQdN9oePNCjJujfVvkiJdjVHLEt8wpAU
 UW3pezZZpAz0WaGu2A25PCMOiPXxWJ8Uvc+PmJ90NF3chEeKobEa+Sc05lHFqoGQ05md
 cySp0rCTuNb7HBWBC/QzsgwDevn1XdLfMsyiXKmAP+BqAcYw0XNtNuw4AKafZ7hHTWkK
 12CEkr9qnyEaTCWtb3/f4EC5x4uBgV0jXlNn1myXvytirw8F9JqXN5wd+ZvZ2UKau/a3
 7bQg==
X-Gm-Message-State: ANhLgQ1a7ygbPAG4rtQf4tEhx6wDr1V68Rn1ucJ2bdym63T4ibOwLo6U
 tKQinykwfvlDAOIJS3wrO/r9F6Tx2TXWFhG3b+4=
X-Google-Smtp-Source: ADFU+vuKC5EMT5QTHxKxYuKJKIgoBVW37c0lpgzbJLCbZUWztjLJ5NGGpG/jn6Ew7BMrptaNL/rWwkvbNkF6sJUCzMs=
X-Received: by 2002:a25:e7c5:: with SMTP id e188mr15706035ybh.65.1584110573124; 
 Fri, 13 Mar 2020 07:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200313005508.1906-1-coreyw7@fb.com>
 <20200313005508.1906-3-coreyw7@fb.com>
In-Reply-To: <20200313005508.1906-3-coreyw7@fb.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 13 Mar 2020 22:42:42 +0800
Message-ID: <CAEUhbmVwSgXMUM9kwby5quRfye-N4aPkB=wOA75m9fwmuKE4HA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Add a sifive-e34 cpu type
To: Corey Wharton <coreyw7@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 9:00 AM Corey Wharton <coreyw7@fb.com> wrote:
>
> The sifive-e34 cpu type is the same as the sifive-e31 with the
> single precision floating-point extension enabled.
>
> Signed-off-by: Corey Wharton <coreyw7@fb.com>
> ---
>  target/riscv/cpu.c | 10 ++++++++++
>  target/riscv/cpu.h |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c0b7023100..d415cd06eb 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -164,6 +164,15 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
>      set_feature(env, RISCV_FEATURE_PMP);
>  }
>
> +static void rv32imafcu_nommu_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env = &RISCV_CPU(obj)->env;
> +    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC);

This is missing RVU.

> +    set_priv_version(env, PRIV_VERSION_1_10_0);
> +    set_resetvec(env, DEFAULT_RSTVEC);
> +    set_feature(env, RISCV_FEATURE_PMP);
> +}
> +
>  #elif defined(TARGET_RISCV64)
>

[snip]

Regards,
Bin

