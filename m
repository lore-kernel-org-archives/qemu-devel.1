Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB29C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314BC222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luTRAq+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314BC222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irrlc-0006Sl-Cw
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 18:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1irrks-00060s-Hh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1irrkr-0007M3-DV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:07:18 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1irrko-0007K1-Vc; Wed, 15 Jan 2020 18:07:15 -0500
Received: by mail-lj1-x244.google.com with SMTP id z22so20471699ljg.1;
 Wed, 15 Jan 2020 15:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AVWycBN+UnjNQg37ENptLAweD7Domm2t4W/Oj6IcFsY=;
 b=luTRAq+ZyGZ7n/VCVEzwXljQfP59CNoMroNZu4raSk1qECK7CD1s0Wo0af262A7vPG
 AYS7obSQaOI7zsK+c8J3CCtbkDAzHSHzEfTB9xt1yAtVyMyXEKtdvvJDMOidEW004iEu
 jg6g9wTp8OFGUm/U2+C2aBocAGnubGyCvJqC2X9Fu0sfLi4lqD1mcZFQBx85Fo/O71tK
 6i0SUEG3ARfQA/m7JSTxTlA3KxkyDlZf9lxachYiUARxWKTmotaX3vF+beX+Y/dyy+3q
 D0p7HQKQsBWIH/zMKPwmjw/tm0H1uXlqZ7CYInT3HweBHq/ivUzYZn1c72X7gD/TWPF7
 SdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AVWycBN+UnjNQg37ENptLAweD7Domm2t4W/Oj6IcFsY=;
 b=Wu080W7dZBx0On6Cn33EegU/e1YlbiLQlSNww5QZECwLa14DFQHZ6Q8z1NZHkOw2g1
 lvQWkwN3i2o7NvuwOKORbZhzzATkhHKAImKvrmv5ba51Tm1fViDiTZvIv1QWwt1044ZQ
 ZvpMSOqlEzt8I+SXniZRGGls8nEj7DxeHtqgWRtK5mhV7kl4RXmU5TQmkro2JCOP0UUq
 4/cw4Qs5GOZOmvcX9dM2BpsqX46EIK/ump4ektwtlGiifcRF1JcK2k1yTLNnMS9lkPlX
 gHvkObh6Q6OYMdgmlsgd9XdrBx2oemUoh1fdPTdGyhB0WT95sr9LsmehoKepEI2b6q2A
 bLjg==
X-Gm-Message-State: APjAAAXkduxe3H3FJJqzuQggKehPBdYBGQnGfS5MMHkImFV86zc5PAGq
 OA8PuzLjVVhg/zfULf+H1OH5drzOwAB4F5xvq1g=
X-Google-Smtp-Source: APXvYqzIKpg5HcVrHiupiZtgwyJOv3RBK/lxuIW3WbKXMmRBKBeQCQWtzCLA3bcodRghJHT1K4FTITTxUDDW4maeKm8=
X-Received: by 2002:a2e:8755:: with SMTP id q21mr438329ljj.156.1579129633255; 
 Wed, 15 Jan 2020 15:07:13 -0800 (PST)
MIME-Version: 1.0
References: <1579069053-22190-1-git-send-email-shihpo.hung@sifive.com>
 <CAKmqyKNeAFRP7eCLtw1b0P53ub3k--+dROpPRynzCwM8DF15ng@mail.gmail.com>
 <8d63e90b-0779-6432-3a35-1b759f5ae279@linaro.org>
In-Reply-To: <8d63e90b-0779-6432-3a35-1b759f5ae279@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Jan 2020 09:06:46 +1000
Message-ID: <CAKmqyKPQQPJsTiBmRtQ7hZOk0Ly62qKSmmFY_m8G2S9Pw20k5Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] target/riscv: Fix tb->flags FS status
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
 Palmer Dabbelt <palmer@dabbelt.com>, shihpo.hung@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 16, 2020 at 7:46 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/14/20 8:28 PM, Alistair Francis wrote:
> > On Wed, Jan 15, 2020 at 4:18 PM <shihpo.hung@sifive.com> wrote:
> >>
> >> It was found that running libquantum on riscv-linux qemu produced an
> >> incorrect result. After investigation, FP registers are not saved
> >> during context switch due to incorrect mstatus.FS.
> >>
> >> In current implementation tb->flags merges all non-disabled state to
> >> dirty. This means the code in mark_fs_dirty in translate.c that
> >> handles initial and clean states is unreachable.
> >>
> >> This patch fixes it and is successfully tested with:
> >>   libquantum
> >>
> >> Thanks to Richard for pointing out the actual bug.
> >>
> >> v3: remove the redundant condition
> >> v2: root cause FS problem
> >>
> >> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> >> Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>  target/riscv/cpu.h | 5 +----
> >>  1 file changed, 1 insertion(+), 4 deletions(-)
> >>
> >> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> >> index e59343e..de0a8d8 100644
> >> --- a/target/riscv/cpu.h
> >> +++ b/target/riscv/cpu.h
> >> @@ -293,10 +293,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
> >>  #ifdef CONFIG_USER_ONLY
> >>      *flags = TB_FLAGS_MSTATUS_FS;
> >>  #else
> >> -    *flags = cpu_mmu_index(env, 0);
> >> -    if (riscv_cpu_fp_enabled(env)) {
> >> -        *flags |= TB_FLAGS_MSTATUS_FS;
> >> -    }
> >> +    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
> >
> > I don't think this is right, you should use the riscv_cpu_fp_enabled() function.
> >
> > Right now it's the same as env->mstatus & MSTATUS_FS but when the
> > Hypervisor extension goes in riscv_cpu_fp_enabled() will be more
> > complex.
>
> Hmm.  Are you sure something like
>
>   flags |= riscv_cpu_effective_mstatus(env) & MSTATUS_FS;
>
> wouldn't be more appropriate for the hypervisor extension?

I was more thinking:

    if (riscv_cpu_fp_enabled(env)) {
        *flags |= env->mstatus & MSTATUS_FS;
    }

as floating point can be disabled from multiple places when we have
the H extension.

>
> I guess I should have another browse through your hv patchset, but I worry now
> about bare uses of env->mstatus, if they no longer mean what they appear to mean.

That was why this was all refacted in the first place as we now need
to check against env->vsstatus as well (depending on virt status).

Alistair

>
>
> r~

