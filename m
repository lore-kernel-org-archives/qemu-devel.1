Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38904C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B3120637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSqEC4Pv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B3120637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCW7y-0003ib-2S
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 18:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jCW75-0001Bi-1g
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jCW73-00060p-Pl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:15:34 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41]:43938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jCW73-0005z6-Kr; Thu, 12 Mar 2020 18:15:33 -0400
Received: by mail-vk1-xa41.google.com with SMTP id t3so2060899vkm.10;
 Thu, 12 Mar 2020 15:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o/HkkMcrEHAWXFQusdHwU8phyQPq6T2aBZNnkj4Us1o=;
 b=ZSqEC4PvT0GZFzmU4AK4rWA9/tvtmakdAKfiamMEQz5BJnmcJYT57GuxATFINlwgL7
 ejksZfREkoG/0KFcEAndhMM7gNxxPYqZMJVf3uRFxDKQSThQGSlwWnVfW+4dtNqAc3ff
 OZstFgyheUoT4xRGkVGTaN7q+Fhv40a3aPMz7lH0NtEPVeY5gN0GYyMzV5EcbaZNM2Ny
 bhOBVzqZLv8M+0VwUICt/2rB7lDPy1r1/qnsf9eCfw8WxcEPMvyaJa0b62qrfC0plwhw
 XXP2dhrp/RnNferAU5GvpLW+Y/id+22rgXasKcWiZn5LMTnnsbJjDAhoZp+jd3IW9MIb
 irqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o/HkkMcrEHAWXFQusdHwU8phyQPq6T2aBZNnkj4Us1o=;
 b=BNgOQmC+t++6OSOY6JSV9sk99bVfDhXuvwlJFyTIL3UjOIfO9KtfQpAbjwEMYoCcgw
 UUoODBjdIxDeyORy1he41FD8YYl1Vf5hcs6INeFc2tIxQPMQPy0YKiBDj8nlKrj1zYmX
 LbuCg74aDFU6EXaxN+G0WzCB5sNht+2izBxRi/VCSoa7liimHcOFvj3izDrpskTDIhyG
 yLmlC4/mO0PVQ8eJlUGp39QNIUvyU4PMtEn909JRn8+Zl6j6v6XDIW2KctVbUpXbhbWI
 Cu3oLuVFQgH0I+gXJrRV+N8N0cGj8FJax/YXUEb6Z3xOXaYnlWjV96bct38PB4i16roL
 sHsg==
X-Gm-Message-State: ANhLgQ1miDC1ESSQNGCHnni/0Ajq9/jiRS/IRroqjK8hFQbE69X/tYj3
 EVwjaV2Agie5PwUqrUOAkBsg/nnGdNd7yfPeEH4=
X-Google-Smtp-Source: ADFU+vst7lZRwIQtqa7jjyRuEzM36EzZeLMJfvzNJesRQfOZDgnUezlLvgol61/g2gWX0R5W1frrhD7DzxhrAx9TAf8=
X-Received: by 2002:ac5:c1ca:: with SMTP id g10mr7059195vkk.16.1584051333014; 
 Thu, 12 Mar 2020 15:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-5-zhiwei_liu@c-sky.com>
 <CAKmqyKOA2xH+wCZ2L1TGDoL+3kfdEVGFKcqARua_e7GdN_iTuQ@mail.gmail.com>
 <ae6e17bd-bd61-2365-1451-da4a05b82ee1@c-sky.com>
In-Reply-To: <ae6e17bd-bd61-2365-1451-da4a05b82ee1@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2020 15:07:41 -0700
Message-ID: <CAKmqyKOjeB3cnypSjm46WrfYAkwN9Uxonf0cKyCERKs5hcc-CA@mail.gmail.com>
Subject: Re: [PATCH v5 04/60] target/riscv: add vector configure instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a41
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
Cc: guoren@linux.alibaba.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 3:00 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
>
>
> On 2020/3/13 5:23, Alistair Francis wrote:
> > On Thu, Mar 12, 2020 at 8:07 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> >> vsetvl and vsetvli are two configure instructions for vl, vtype. TB flags
> >> should update after configure instructions. The (ill, lmul, sew ) of vtype
> >> and the bit of (VSTART == 0 && VL == VLMAX) will be placed within tb_flags.
> >>
> >> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> >> ---
> >>   target/riscv/Makefile.objs              |  2 +-
> >>   target/riscv/cpu.h                      | 63 ++++++++++++++++++----
> >>   target/riscv/helper.h                   |  2 +
> >>   target/riscv/insn32.decode              |  5 ++
> >>   target/riscv/insn_trans/trans_rvv.inc.c | 69 +++++++++++++++++++++++++
> >>   target/riscv/translate.c                | 17 +++++-
> >>   target/riscv/vector_helper.c            | 53 +++++++++++++++++++
> >>   7 files changed, 199 insertions(+), 12 deletions(-)
> >>   create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
> >>   create mode 100644 target/riscv/vector_helper.c
> >>

...

> >> +    gen_get_gpr(s2, a->rs2);
> >> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
> >> +    gen_set_gpr(a->rd, dst);
> >> +    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
> >> +    exit_tb(ctx);
> > Why does this
> As the vsetvl will change vtype, the tb flags of the instructions next
> to the vsetvl
> will change(some tb flags  are from vtype, like LMUL).
> >
> >> +    ctx->base.is_jmp = DISAS_NORETURN;
> >> +
> >> +    tcg_temp_free(s1);
> >> +    tcg_temp_free(s2);
> >> +    tcg_temp_free(dst);
> >> +    return true;
> >> +}
> >> +
> >> +static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
> >> +{
> >> +    TCGv s1, s2, dst;
> >> +    s2 = tcg_const_tl(a->zimm);
> >> +    dst = tcg_temp_new();
> >> +
> >> +    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
> >> +    if (a->rs1 == 0) {
> >> +        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
> >> +        s1 = tcg_const_tl(RV_VLEN_MAX);
> >> +    } else {
> >> +        s1 = tcg_temp_new();
> >> +        gen_get_gpr(s1, a->rs1);
> >> +    }
> >> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
> >> +    gen_set_gpr(a->rd, dst);
> >> +    gen_goto_tb(ctx, 0, ctx->pc_succ_insn);
> > Need to be different to this?
> Although vsetvli will also change vtype, the vtype will be a constant.
> So the tb flags of  the instruction(A) next to
> it will always be same with the tb flags at first translation of A.
> That's why gen_goto_tb is enough.

Ah ok. Makes sense.

Once you fix the one nit pick I had you can add my reviewed by:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> Zhiwei

