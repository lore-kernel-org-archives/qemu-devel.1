Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC5AECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD44206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/yD0CU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD44206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIviv-0004pI-Cj
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iIvfO-0001Qz-MZ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iIvfE-00079M-J5
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:13:14 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iIvfE-000792-4E
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:13:04 -0400
Received: by mail-oi1-x244.google.com with SMTP id w65so8086925oiw.8
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=4kpHhGfqF8hUgI9j0SRN5mzyR9E5h0Fk0G2EO40CY5I=;
 b=R/yD0CU4zebp8WWAb404OlR8UaWxhI1/qScId2T/GT0HKQQXL5hneZiXtbQUULE5uX
 BumTsJ0mjeH6XaOf1UduOUqwKhGBouUgKHuj9zjgAV6ctluOrJYmHBmWZqPlfxa1Jlj6
 qYLsWHd2ywnyDCA0/thBe0Me+IXkr5ZdA/tjh82zlsJLiumwOaPAW+QQHx2YNFbmFJDY
 X1pZvaoxUeoACq0nY1593C0kKCeubzuHF7U8iBNujqf6atwiiuec6MEfsRSR2J8mxjNd
 Dkr87GFWGvgiJM46ensnBFH4YsYlwOon7FUMj/Pe3Tv7zqGOFpkOhl32PsF9hiLDVkJo
 WEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=4kpHhGfqF8hUgI9j0SRN5mzyR9E5h0Fk0G2EO40CY5I=;
 b=jlUZGmwC+32+Cr8aJsAuUuxhDk1jWPwUBvYFQdGGqzqb6xakYZ6Lw0zpN9ew7HzwuT
 l/UWtuMfODNDbD1L4Zcr+MXCj/5gGhdTnvy4AzaB3YFYNs3Abjh3LsBHJTFnnDgH0G+L
 LHNh3QdS/H5ryXv4UZwYxhcsMn183xjd2NJXgmWaK4R7gQCLZ7Ha5RfKJyYO+W2uniQs
 cNakBYeq/pt3NCsIawG0kXEW6AC0B3ce4sBmA7XZc3ugkDRwMNKwTDH3fZoegxFExCoM
 wJ82CCvhvyBWF7XpQljnVWXVPoJ7SQpNepvnmga/TrLfa2lSVfpCfLONlZvh3iNmviSK
 ZScg==
X-Gm-Message-State: APjAAAUL55aA/g8CYJ54jkm2MsJ/UqQnugB1cPWLnyUQe2WId0uUJBh/
 +SKMrEhi/bhPPCbiHERow8BiO1tRDFi+hxwMWpk=
X-Google-Smtp-Source: APXvYqwfoLS19XxH8UcwE6Gt19lJ0NtsIi+7vrUTXEFJYhtgBDIiHMNZb0RKkBrqTAVIYrv4qzjtcEkWZ15Vs6sRcvs=
X-Received: by 2002:a54:460c:: with SMTP id p12mr12458180oip.62.1570803182703; 
 Fri, 11 Oct 2019 07:13:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 11 Oct 2019 07:13:01
 -0700 (PDT)
In-Reply-To: <20190902140134.74081-5-mrolnik@gmail.com>
References: <20190902140134.74081-1-mrolnik@gmail.com>
 <20190902140134.74081-5-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 11 Oct 2019 16:13:01 +0200
Message-ID: <CAL1e-=jMDpeku_7GB5H5Xv1=5cChZJLoz7fCmem3upds9QEtvQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v30 4/8] target/avr: Add instruction
 translation
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b7984e0594a31d30"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b7984e0594a31d30
Content-Type: text/plain; charset="UTF-8"

On Monday, September 2, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> This includes:
> - TCG translations for each instruction
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  target/avr/translate.c | 2888 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 2888 insertions(+)
>  create mode 100644 target/avr/translate.c
>
>
Hi, Michael,


This patch is way too large. I suggest splitting it into:

- register definitions
- load instruction handling
- store instruction handling
- logic instruction handling

etc.

Thanks, Aleksandar

P.S. One more hurdle with your communication on the list is that you don't
use "inline responding" while replaying, please use it in future. See other
messages in the mailing list how "inline responding" looks.





> diff --git a/target/avr/translate.c b/target/avr/translate.c
> new file mode 100644
> index 0000000000..42cb4a690c
> --- /dev/null
> +++ b/target/avr/translate.c
> @@ -0,0 +1,2888 @@
> +/*
> + * QEMU AVR CPU
> + *
> + * Copyright (c) 2019 Michael Rolnik
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see
> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/qemu-print.h"
> +#include "tcg/tcg.h"
> +#include "cpu.h"
> +#include "exec/exec-all.h"
> +#include "disas/disas.h"
> +#include "tcg-op.h"
> +#include "exec/cpu_ldst.h"
> +#include "exec/helper-proto.h"
> +#include "exec/helper-gen.h"
> +#include "exec/log.h"
> +#include "exec/gdbstub.h"
> +#include "exec/translator.h"
> +
> +/*
> + *  Define if you want a BREAK instruction translated to a breakpoint
> + *  Active debugging connection is assumed
> + *  This is for
> + *  https://github.com/seharris/qemu-avr-tests/tree/master/
> instruction-tests
> + *  tests
> + */
> +#undef BREAKPOINT_ON_BREAK
> +
> +static TCGv cpu_pc;
> +
> +static TCGv cpu_Cf;
> +static TCGv cpu_Zf;
> +static TCGv cpu_Nf;
> +static TCGv cpu_Vf;
> +static TCGv cpu_Sf;
> +static TCGv cpu_Hf;
> +static TCGv cpu_Tf;
> +static TCGv cpu_If;
> +
> +static TCGv cpu_rampD;
> +static TCGv cpu_rampX;
> +static TCGv cpu_rampY;
> +static TCGv cpu_rampZ;
> +
> +static TCGv cpu_r[NO_CPU_REGISTERS];
> +static TCGv cpu_eind;
> +static TCGv cpu_sp;
> +
> +static TCGv cpu_skip;
> +
> +static const char reg_names[NO_CPU_REGISTERS][8] = {
> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
> +};
> +#define REG(x) (cpu_r[x])
> +
> +enum {
> +    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the cpu main
> loop.  */
> +    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable condition
> exit.  */
> +    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single condition exit.
> */
> +};
> +
> +typedef struct DisasContext DisasContext;
> +
> +/* This is the state at translation time. */
> +struct DisasContext {
> +    TranslationBlock *tb;
> +
> +    CPUAVRState *env;
> +    CPUState *cs;
> +
> +    target_long npc;
> +    uint32_t opcode;
> +
> +    /* Routine used to access memory */
> +    int memidx;
> +    int bstate;
> +    int singlestep;
> +
> +    TCGv skip_var0;
> +    TCGv skip_var1;
> +    TCGCond skip_cond;
> +    bool free_skip_var0;
> +};
> +
> +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); }
> +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
> +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) *
> 2; }
> +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }
> +
> +static uint16_t next_word(DisasContext *ctx)
> +{
> +    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
> +}
> +
> +static int append_16(DisasContext *ctx, int x)
> +{
> +    return x << 16 | next_word(ctx);
> +}
> +
> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
> +#include "decode_insn.inc.c"
> +
> +static bool avr_have_feature(DisasContext *ctx, int feature)
> +{
> +    if (!avr_feature(ctx->env, feature)) {
> +        gen_helper_unsupported(cpu_env);
> +        ctx->bstate = DISAS_NORETURN;
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
> +{
> +    TranslationBlock *tb = ctx->tb;
> +
> +    if (ctx->singlestep == 0) {
> +        tcg_gen_goto_tb(n);
> +        tcg_gen_movi_i32(cpu_pc, dest);
> +        tcg_gen_exit_tb(tb, n);
> +    } else {
> +        tcg_gen_movi_i32(cpu_pc, dest);
> +        gen_helper_debug(cpu_env);
> +        tcg_gen_exit_tb(NULL, 0);
> +    }
> +    ctx->bstate = DISAS_NORETURN;
> +}
> +
> +#include "exec/gen-icount.h"
> +
> +static void gen_add_CHf(TCGv R, TCGv Rd, TCGv Rr)
> +{
> +    TCGv t1 = tcg_temp_new_i32();
> +    TCGv t2 = tcg_temp_new_i32();
> +    TCGv t3 = tcg_temp_new_i32();
> +
> +    tcg_gen_and_tl(t1, Rd, Rr); /* t1 = Rd & Rr */
> +    tcg_gen_andc_tl(t2, Rd, R); /* t2 = Rd & ~R */
> +    tcg_gen_andc_tl(t3, Rr, R); /* t3 = Rr & ~R */
> +    tcg_gen_or_tl(t1, t1, t2); /* t1 = t1 | t2 | t3 */
> +    tcg_gen_or_tl(t1, t1, t3);
> +
> +    tcg_gen_shri_tl(cpu_Cf, t1, 7); /* Cf = t1(7) */
> +    tcg_gen_shri_tl(cpu_Hf, t1, 3); /* Hf = t1(3) */
> +    tcg_gen_andi_tl(cpu_Hf, cpu_Hf, 1);
> +
> +    tcg_temp_free_i32(t3);
> +    tcg_temp_free_i32(t2);
> +    tcg_temp_free_i32(t1);
> +}
> +
> +static void gen_add_Vf(TCGv R, TCGv Rd, TCGv Rr)
> +{
> +    TCGv t1 = tcg_temp_new_i32();
> +    TCGv t2 = tcg_temp_new_i32();
> +
> +    /* t1 = Rd & Rr & ~R | ~Rd & ~Rr & R = (Rd ^ R) & ~(Rd ^ Rr) */
> +    tcg_gen_xor_tl(t1, Rd, R);
> +    tcg_gen_xor_tl(t2, Rd, Rr);
> +    tcg_gen_andc_tl(t1, t1, t2);
> +
> +    tcg_gen_shri_tl(cpu_Vf, t1, 7); /* Vf = t1(7) */
> +
> +    tcg_temp_free_i32(t2);
> +    tcg_temp_free_i32(t1);
> +}
> +
> +static void gen_sub_CHf(TCGv R, TCGv Rd, TCGv Rr)
> +{
> +    TCGv t1 = tcg_temp_new_i32();
> +    TCGv t2 = tcg_temp_new_i32();
> +    TCGv t3 = tcg_temp_new_i32();
> +
> +    /* Cf & Hf */
> +    tcg_gen_not_tl(t1, Rd); /* t1 = ~Rd */
> +    tcg_gen_and_tl(t2, t1, Rr); /* t2 = ~Rd & Rr */
> +    tcg_gen_or_tl(t3, t1, Rr); /* t3 = (~Rd | Rr) & R */
> +    tcg_gen_and_tl(t3, t3, R);
> +    tcg_gen_or_tl(t2, t2, t3); /* t2 = ~Rd & Rr | ~Rd & R | R & Rr */
> +    tcg_gen_shri_tl(cpu_Cf, t2, 7); /* Cf = t2(7) */
> +    tcg_gen_shri_tl(cpu_Hf, t2, 3); /* Hf = t2(3) */
> +    tcg_gen_andi_tl(cpu_Hf, cpu_Hf, 1);
> +
> +    tcg_temp_free_i32(t3);
> +    tcg_temp_free_i32(t2);
> +    tcg_temp_free_i32(t1);
> +}
> +
> +static void gen_sub_Vf(TCGv R, TCGv Rd, TCGv Rr)
> +{
> +    TCGv t1 = tcg_temp_new_i32();
> +    TCGv t2 = tcg_temp_new_i32();
> +
> +    /* Vf */
> +    /* t1 = Rd & ~Rr & ~R | ~Rd & Rr & R = (Rd ^ R) & (Rd ^ R) */
> +    tcg_gen_xor_tl(t1, Rd, R);
> +    tcg_gen_xor_tl(t2, Rd, Rr);
> +    tcg_gen_and_tl(t1, t1, t2);
> +    tcg_gen_shri_tl(cpu_Vf, t1, 7); /* Vf = t1(7) */
> +
> +    tcg_temp_free_i32(t2);
> +    tcg_temp_free_i32(t1);
> +}
> +
> +static void gen_rshift_ZNVSf(TCGv R)
> +{
> +    tcg_gen_mov_tl(cpu_Zf, R); /* Zf = R */
> +    tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf = R(7) */
> +    tcg_gen_xor_tl(cpu_Vf, cpu_Nf, cpu_Cf);
> +    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
> +}
> +
> +static void gen_NSf(TCGv R)
> +{
> +    tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf = R(7) */
> +    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
> +}
> +
> +static void gen_ZNSf(TCGv R)
> +{
> +    tcg_gen_mov_tl(cpu_Zf, R); /* Zf = R */
> +    tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf = R(7) */
> +    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf = Nf ^ Vf */
> +}
> +
> +static void gen_push_ret(DisasContext *ctx, int ret)
> +{
> +    if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
> +
> +        TCGv t0 = tcg_const_i32((ret & 0x0000ff));
> +
> +        tcg_gen_qemu_st_tl(t0, cpu_sp, MMU_DATA_IDX, MO_UB);
> +        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
> +
> +        tcg_temp_free_i32(t0);
> +    } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
> +
> +        TCGv t0 = tcg_const_i32((ret & 0x00ffff));
> +
> +        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
> +        tcg_gen_qemu_st_tl(t0, cpu_sp, MMU_DATA_IDX, MO_BEUW);
> +        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
> +
> +        tcg_temp_free_i32(t0);
> +
> +    } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
> +
> +        TCGv lo = tcg_const_i32((ret & 0x0000ff));
> +        TCGv hi = tcg_const_i32((ret & 0xffff00) >> 8);
> +
> +        tcg_gen_qemu_st_tl(lo, cpu_sp, MMU_DATA_IDX, MO_UB);
> +        tcg_gen_subi_tl(cpu_sp, cpu_sp, 2);
> +        tcg_gen_qemu_st_tl(hi, cpu_sp, MMU_DATA_IDX, MO_BEUW);
> +        tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);
> +
> +        tcg_temp_free_i32(lo);
> +        tcg_temp_free_i32(hi);
> +    }
> +}
> +
> +static void gen_pop_ret(DisasContext *ctx, TCGv ret)
> +{
> +    if (avr_feature(ctx->env, AVR_FEATURE_1_BYTE_PC)) {
> +        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
> +        tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, MO_UB);
> +    } else if (avr_feature(ctx->env, AVR_FEATURE_2_BYTE_PC)) {
> +        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
> +        tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, MO_BEUW);
> +        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
> +    } else if (avr_feature(ctx->env, AVR_FEATURE_3_BYTE_PC)) {
> +        TCGv lo = tcg_temp_new_i32();
> +        TCGv hi = tcg_temp_new_i32();
> +
> +        tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);
> +        tcg_gen_qemu_ld_tl(hi, cpu_sp, MMU_DATA_IDX, MO_BEUW);
> +
> +        tcg_gen_addi_tl(cpu_sp, cpu_sp, 2);
> +        tcg_gen_qemu_ld_tl(lo, cpu_sp, MMU_DATA_IDX, MO_UB);
> +
> +        tcg_gen_deposit_tl(ret, lo, hi, 8, 16);
> +
> +        tcg_temp_free_i32(lo);
> +        tcg_temp_free_i32(hi);
> +    }
> +}
> +
> +static void gen_jmp_ez(DisasContext *ctx)
> +{
> +    tcg_gen_deposit_tl(cpu_pc, cpu_r[30], cpu_r[31], 8, 8);
> +    tcg_gen_or_tl(cpu_pc, cpu_pc, cpu_eind);
> +    ctx->bstate = DISAS_LOOKUP;
> +}
> +
> +static void gen_jmp_z(DisasContext *ctx)
> +{
> +    tcg_gen_deposit_tl(cpu_pc, cpu_r[30], cpu_r[31], 8, 8);
> +    ctx->bstate = DISAS_LOOKUP;
> +}
> +
> +/*
> + *  in the gen_set_addr & gen_get_addr functions
> + *  H assumed to be in 0x00ff0000 format
> + *  M assumed to be in 0x000000ff format
> + *  L assumed to be in 0x000000ff format
> + */
> +static void gen_set_addr(TCGv addr, TCGv H, TCGv M, TCGv L)
> +{
> +
> +    tcg_gen_andi_tl(L, addr, 0x000000ff);
> +
> +    tcg_gen_andi_tl(M, addr, 0x0000ff00);
> +    tcg_gen_shri_tl(M, M, 8);
> +
> +    tcg_gen_andi_tl(H, addr, 0x00ff0000);
> +}
> +
> +static void gen_set_xaddr(TCGv addr)
> +{
> +    gen_set_addr(addr, cpu_rampX, cpu_r[27], cpu_r[26]);
> +}
> +
> +static void gen_set_yaddr(TCGv addr)
> +{
> +    gen_set_addr(addr, cpu_rampY, cpu_r[29], cpu_r[28]);
> +}
> +
> +static void gen_set_zaddr(TCGv addr)
> +{
> +    gen_set_addr(addr, cpu_rampZ, cpu_r[31], cpu_r[30]);
> +}
> +
> +static TCGv gen_get_addr(TCGv H, TCGv M, TCGv L)
> +{
> +    TCGv addr = tcg_temp_new_i32();
> +
> +    tcg_gen_deposit_tl(addr, M, H, 8, 8);
> +    tcg_gen_deposit_tl(addr, L, addr, 8, 16);
> +
> +    return addr;
> +}
> +
> +static TCGv gen_get_xaddr(void)
> +{
> +    return gen_get_addr(cpu_rampX, cpu_r[27], cpu_r[26]);
> +}
> +
> +static TCGv gen_get_yaddr(void)
> +{
> +    return gen_get_addr(cpu_rampY, cpu_r[29], cpu_r[28]);
> +}
> +
> +static TCGv gen_get_zaddr(void)
> +{
> +    return gen_get_addr(cpu_rampZ, cpu_r[31], cpu_r[30]);
> +}
> +
> +/*
> + *  Adds two registers and the contents of the C Flag and places the
> result in
> + *  the destination register Rd.
> + */
> +static bool trans_ADC(DisasContext *ctx, arg_ADC *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +
> +    /* op */
> +    tcg_gen_add_tl(R, Rd, Rr); /* R = Rd + Rr + Cf */
> +    tcg_gen_add_tl(R, R, cpu_Cf);
> +    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
> +
> +    gen_add_CHf(R, Rd, Rr);
> +    gen_add_Vf(R, Rd, Rr);
> +    gen_ZNSf(R);
> +
> +    /* R */
> +    tcg_gen_mov_tl(Rd, R);
> +
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  Adds two registers without the C Flag and places the result in the
> + *  destination register Rd.
> + */
> +static bool trans_ADD(DisasContext *ctx, arg_ADD *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +
> +    /* op */
> +    tcg_gen_add_tl(R, Rd, Rr); /* Rd = Rd + Rr */
> +    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
> +
> +    gen_add_CHf(R, Rd, Rr);
> +    gen_add_Vf(R, Rd, Rr);
> +    gen_ZNSf(R);
> +
> +    /* R */
> +    tcg_gen_mov_tl(Rd, R);
> +
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  Adds an immediate value (0 - 63) to a register pair and places the
> result
> + *  in the register pair. This instruction operates on the upper four
> register
> + *  pairs, and is well suited for operations on the pointer registers.
> This
> + *  instruction is not available in all devices. Refer to the device
> specific
> + *  instruction set summary.
> + */
> +static bool trans_ADIW(DisasContext *ctx, arg_ADIW *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_ADIW_SBIW)) {
> +        return true;
> +    }
> +
> +    TCGv RdL = cpu_r[a->rd];
> +    TCGv RdH = cpu_r[a->rd + 1];
> +    int Imm = (a->imm);
> +    TCGv R = tcg_temp_new_i32();
> +    TCGv Rd = tcg_temp_new_i32();
> +
> +    /* op */
> +    tcg_gen_deposit_tl(Rd, RdL, RdH, 8, 8); /* Rd = RdH:RdL */
> +    tcg_gen_addi_tl(R, Rd, Imm); /* R = Rd + Imm */
> +    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
> +
> +    /* Cf */
> +    tcg_gen_andc_tl(cpu_Cf, Rd, R); /* Cf = Rd & ~R */
> +    tcg_gen_shri_tl(cpu_Cf, cpu_Cf, 15);
> +
> +    /* Vf */
> +    tcg_gen_andc_tl(cpu_Vf, R, Rd); /* Vf = R & ~Rd */
> +    tcg_gen_shri_tl(cpu_Vf, cpu_Vf, 15);
> +
> +    /* Zf */
> +    tcg_gen_mov_tl(cpu_Zf, R); /* Zf = R */
> +
> +    /* Nf */
> +    tcg_gen_shri_tl(cpu_Nf, R, 15); /* Nf = R(15) */
> +
> +    /* Sf */
> +    tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf);/* Sf = Nf ^ Vf */
> +
> +    /* R */
> +    tcg_gen_andi_tl(RdL, R, 0xff);
> +    tcg_gen_shri_tl(RdH, R, 8);
> +
> +    tcg_temp_free_i32(Rd);
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  Performs the logical AND between the contents of register Rd and
> register
> + *  Rr and places the result in the destination register Rd.
> + */
> +static bool trans_AND(DisasContext *ctx, arg_AND *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +
> +    /* op */
> +    tcg_gen_and_tl(R, Rd, Rr); /* Rd = Rd and Rr */
> +
> +    /* Vf */
> +    tcg_gen_movi_tl(cpu_Vf, 0x00); /* Vf = 0 */
> +
> +    /* Zf */
> +    tcg_gen_mov_tl(cpu_Zf, R); /* Zf = R */
> +
> +    gen_ZNSf(R);
> +
> +    /* R */
> +    tcg_gen_mov_tl(Rd, R);
> +
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  Performs the logical AND between the contents of register Rd and a
> constant
> + *  and places the result in the destination register Rd.
> + */
> +static bool trans_ANDI(DisasContext *ctx, arg_ANDI *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    int Imm = (a->imm);
> +
> +    /* op */
> +    tcg_gen_andi_tl(Rd, Rd, Imm); /* Rd = Rd & Imm */
> +
> +    tcg_gen_movi_tl(cpu_Vf, 0x00); /* Vf = 0 */
> +    gen_ZNSf(Rd);
> +
> +    return true;
> +}
> +
> +/*
> + *  Shifts all bits in Rd one place to the right. Bit 7 is held constant.
> Bit 0
> + *  is loaded into the C Flag of the SREG. This operation effectively
> divides a
> + *  signed value by two without changing its sign. The Carry Flag can be
> used to
> + *  round the result.
> + */
> +static bool trans_ASR(DisasContext *ctx, arg_ASR *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv t0 = tcg_temp_new_i32();
> +
> +    /* Cf */
> +    tcg_gen_andi_tl(cpu_Cf, Rd, 1); /* Cf = Rd(0) */
> +
> +    /* op */
> +    tcg_gen_andi_tl(t0, Rd, 0x80); /* Rd = (Rd & 0x80) | (Rd >> 1) */
> +    tcg_gen_shri_tl(Rd, Rd, 1);
> +    tcg_gen_or_tl(Rd, Rd, t0);
> +
> +    gen_rshift_ZNVSf(Rd);
> +
> +    tcg_temp_free_i32(t0);
> +
> +    return true;
> +}
> +
> +/*
> + *  Clears a single Flag in SREG.
> + */
> +static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)
> +{
> +    switch (a->bit) {
> +    case 0x00:
> +        tcg_gen_movi_tl(cpu_Cf, 0x00);
> +        break;
> +    case 0x01:
> +        tcg_gen_movi_tl(cpu_Zf, 0x01);
> +        break;
> +    case 0x02:
> +        tcg_gen_movi_tl(cpu_Nf, 0x00);
> +        break;
> +    case 0x03:
> +        tcg_gen_movi_tl(cpu_Vf, 0x00);
> +        break;
> +    case 0x04:
> +        tcg_gen_movi_tl(cpu_Sf, 0x00);
> +        break;
> +    case 0x05:
> +        tcg_gen_movi_tl(cpu_Hf, 0x00);
> +        break;
> +    case 0x06:
> +        tcg_gen_movi_tl(cpu_Tf, 0x00);
> +        break;
> +    case 0x07:
> +        tcg_gen_movi_tl(cpu_If, 0x00);
> +        break;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + *  Copies the T Flag in the SREG (Status Register) to bit b in register
> Rd.
> + */
> +static bool trans_BLD(DisasContext *ctx, arg_BLD *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv t1 = tcg_temp_new_i32();
> +
> +    tcg_gen_andi_tl(Rd, Rd, ~(1u << a->bit)); /* clear bit */
> +    tcg_gen_shli_tl(t1, cpu_Tf, a->bit); /* create mask */
> +    tcg_gen_or_tl(Rd, Rd, t1);
> +
> +    tcg_temp_free_i32(t1);
> +
> +    return true;
> +}
> +
> +/*
> + *  Conditional relative branch. Tests a single bit in SREG and branches
> + *  relatively to PC if the bit is cleared. This instruction branches
> relatively
> + *  to PC in either direction (PC - 63 < = destination <= PC + 64). The
> + *  parameter k is the offset from PC and is represented in two's
> complement
> + *  form.
> + */
> +static bool trans_BRBC(DisasContext *ctx, arg_BRBC *a)
> +{
> +    TCGLabel *not_taken = gen_new_label();
> +    TCGCond cond = TCG_COND_EQ;
> +    TCGv var;
> +
> +    switch (a->bit) {
> +    case 0x00:
> +        var = cpu_Cf;
> +        break;
> +    case 0x01:
> +        cond = TCG_COND_NE;
> +        var = cpu_Zf;
> +        break;
> +    case 0x02:
> +        var = cpu_Nf;
> +        break;
> +    case 0x03:
> +        var = cpu_Vf;
> +        break;
> +    case 0x04:
> +        var = cpu_Sf;
> +        break;
> +    case 0x05:
> +        var = cpu_Hf;
> +        break;
> +    case 0x06:
> +        var = cpu_Tf;
> +        break;
> +    case 0x07:
> +        var = cpu_If;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    tcg_gen_brcondi_i32(tcg_invert_cond(cond), var, 0, not_taken);
> +    gen_goto_tb(ctx, 0, ctx->npc + a->imm);
> +    gen_set_label(not_taken);
> +
> +    ctx->bstate = DISAS_CHAIN;
> +    return true;
> +}
> +
> +/*
> + *  Conditional relative branch. Tests a single bit in SREG and branches
> + *  relatively to PC if the bit is set. This instruction branches
> relatively to
> + *  PC in either direction (PC - 63 < = destination <= PC + 64). The
> parameter k
> + *  is the offset from PC and is represented in two's complement form.
> + */
> +static bool trans_BRBS(DisasContext *ctx, arg_BRBS *a)
> +{
> +    TCGLabel *not_taken = gen_new_label();
> +    TCGCond cond = TCG_COND_NE;
> +    TCGv var;
> +
> +    switch (a->bit) {
> +    case 0x00:
> +        var = cpu_Cf;
> +        break;
> +    case 0x01:
> +        cond = TCG_COND_EQ;
> +        var = cpu_Zf;
> +        break;
> +    case 0x02:
> +        var = cpu_Nf;
> +        break;
> +    case 0x03:
> +        var = cpu_Vf;
> +        break;
> +    case 0x04:
> +        var = cpu_Sf;
> +        break;
> +    case 0x05:
> +        var = cpu_Hf;
> +        break;
> +    case 0x06:
> +        var = cpu_Tf;
> +        break;
> +    case 0x07:
> +        var = cpu_If;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    tcg_gen_brcondi_i32(tcg_invert_cond(cond), var, 0, not_taken);
> +    gen_goto_tb(ctx, 0, ctx->npc + a->imm);
> +    gen_set_label(not_taken);
> +
> +    ctx->bstate = DISAS_CHAIN;
> +    return true;
> +}
> +
> +/*
> + *  Sets a single Flag or bit in SREG.
> + */
> +static bool trans_BSET(DisasContext *ctx, arg_BSET *a)
> +{
> +    switch (a->bit) {
> +    case 0x00:
> +        tcg_gen_movi_tl(cpu_Cf, 0x01);
> +        break;
> +    case 0x01:
> +        tcg_gen_movi_tl(cpu_Zf, 0x00);
> +        break;
> +    case 0x02:
> +        tcg_gen_movi_tl(cpu_Nf, 0x01);
> +        break;
> +    case 0x03:
> +        tcg_gen_movi_tl(cpu_Vf, 0x01);
> +        break;
> +    case 0x04:
> +        tcg_gen_movi_tl(cpu_Sf, 0x01);
> +        break;
> +    case 0x05:
> +        tcg_gen_movi_tl(cpu_Hf, 0x01);
> +        break;
> +    case 0x06:
> +        tcg_gen_movi_tl(cpu_Tf, 0x01);
> +        break;
> +    case 0x07:
> +        tcg_gen_movi_tl(cpu_If, 0x01);
> +        break;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + *  The BREAK instruction is used by the On-chip Debug system, and is
> + *  normally not used in the application software. When the BREAK
> instruction is
> + *  executed, the AVR CPU is set in the Stopped Mode. This gives the
> On-chip
> + *  Debugger access to internal resources.  If any Lock bits are set, or
> either
> + *  the JTAGEN or OCDEN Fuses are unprogrammed, the CPU will treat the
> BREAK
> + *  instruction as a NOP and will not enter the Stopped mode.  This
> instruction
> + *  is not available in all devices. Refer to the device specific
> instruction
> + *  set summary.
> + */
> +static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_BREAK)) {
> +        return true;
> +    }
> +
> +#ifdef BREAKPOINT_ON_BREAK
> +    tcg_gen_movi_tl(cpu_pc, ctx->npc - 1);
> +    gen_helper_debug(cpu_env);
> +    ctx->bstate = DISAS_EXIT;
> +#else
> +    /* NOP */
> +#endif
> +
> +    return true;
> +}
> +
> +/*
> + *  Stores bit b from Rd to the T Flag in SREG (Status Register).
> + */
> +static bool trans_BST(DisasContext *ctx, arg_BST *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +
> +    tcg_gen_andi_tl(cpu_Tf, Rd, 1 << a->bit);
> +    tcg_gen_shri_tl(cpu_Tf, cpu_Tf, a->bit);
> +
> +    return true;
> +}
> +
> +/*
> + *  Calls to a subroutine within the entire Program memory. The return
> + *  address (to the instruction after the CALL) will be stored onto the
> Stack.
> + *  (See also RCALL). The Stack Pointer uses a post-decrement scheme
> during
> + *  CALL.  This instruction is not available in all devices. Refer to the
> device
> + *  specific instruction set summary.
> + */
> +static bool trans_CALL(DisasContext *ctx, arg_CALL *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_JMP_CALL)) {
> +        return true;
> +    }
> +
> +    int Imm = a->imm;
> +    int ret = ctx->npc;
> +
> +    gen_push_ret(ctx, ret);
> +    gen_goto_tb(ctx, 0, Imm);
> +
> +    return true;
> +}
> +
> +/*
> + *  Clears a specified bit in an I/O Register. This instruction operates
> on
> + *  the lower 32 I/O Registers -- addresses 0-31.
> + */
> +static bool trans_CBI(DisasContext *ctx, arg_CBI *a)
> +{
> +    TCGv data = tcg_temp_new_i32();
> +    TCGv port = tcg_const_i32(a->reg);
> +
> +    gen_helper_inb(data, cpu_env, port);
> +    tcg_gen_andi_tl(data, data, ~(1 << a->bit));
> +    gen_helper_outb(cpu_env, port, data);
> +
> +    tcg_temp_free_i32(data);
> +    tcg_temp_free_i32(port);
> +
> +    return true;
> +}
> +
> +/*
> + *  Clears the specified bits in register Rd. Performs the logical AND
> + *  between the contents of register Rd and the complement of the
> constant mask
> + *  K. The result will be placed in register Rd.
> + */
> +static bool trans_COM(DisasContext *ctx, arg_COM *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv R = tcg_temp_new_i32();
> +
> +    tcg_gen_xori_tl(Rd, Rd, 0xff);
> +
> +    tcg_gen_movi_tl(cpu_Cf, 1); /* Cf = 1 */
> +    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
> +    gen_ZNSf(Rd);
> +
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  This instruction performs a compare between two registers Rd and Rr.
> + *  None of the registers are changed. All conditional branches can be
> used
> + *  after this instruction.
> + */
> +static bool trans_CP(DisasContext *ctx, arg_CP *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +
> +    /* op */
> +    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr */
> +    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
> +
> +    gen_sub_CHf(R, Rd, Rr);
> +    gen_sub_Vf(R, Rd, Rr);
> +    gen_ZNSf(R);
> +
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  This instruction performs a compare between two registers Rd and Rr
> and
> + *  also takes into account the previous carry. None of the registers are
> + *  changed. All conditional branches can be used after this instruction.
> + */
> +static bool trans_CPC(DisasContext *ctx, arg_CPC *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +
> +    /* op */
> +    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr - Cf */
> +    tcg_gen_sub_tl(R, R, cpu_Cf);
> +    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
> +
> +    gen_sub_CHf(R, Rd, Rr);
> +    gen_sub_Vf(R, Rd, Rr);
> +    gen_NSf(R);
> +
> +    /*
> +     * Previous value remains unchanged when the result is zero;
> +     * cleared otherwise.
> +     */
> +    tcg_gen_or_tl(cpu_Zf, cpu_Zf, R);
> +
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  This instruction performs a compare between register Rd and a
> constant.
> + *  The register is not changed. All conditional branches can be used
> after this
> + *  instruction.
> + */
> +static bool trans_CPI(DisasContext *ctx, arg_CPI *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    int Imm = a->imm;
> +    TCGv Rr = tcg_const_i32(Imm);
> +    TCGv R = tcg_temp_new_i32();
> +
> +    /* op */
> +    tcg_gen_sub_tl(R, Rd, Rr); /* R = Rd - Rr */
> +    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
> +
> +    gen_sub_CHf(R, Rd, Rr);
> +    gen_sub_Vf(R, Rd, Rr);
> +    gen_ZNSf(R);
> +
> +    tcg_temp_free_i32(R);
> +    tcg_temp_free_i32(Rr);
> +
> +    return true;
> +}
> +
> +/*
> + *  This instruction performs a compare between two registers Rd and Rr,
> and
> + *  skips the next instruction if Rd = Rr.
> + */
> +static bool trans_CPSE(DisasContext *ctx, arg_CPSE *a)
> +{
> +    ctx->skip_cond = TCG_COND_EQ;
> +    ctx->skip_var0 = cpu_r[a->rd];
> +    ctx->skip_var1 = cpu_r[a->rr];
> +    return true;
> +}
> +
> +/*
> + *  Subtracts one -1- from the contents of register Rd and places the
> result
> + *  in the destination register Rd.  The C Flag in SREG is not affected
> by the
> + *  operation, thus allowing the DEC instruction to be used on a loop
> counter in
> + *  multiple-precision computations.  When operating on unsigned values,
> only
> + *  BREQ and BRNE branches can be expected to perform consistently.  When
> + *  operating on two's complement values, all signed branches are
> available.
> + */
> +static bool trans_DEC(DisasContext *ctx, arg_DEC *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +
> +    tcg_gen_subi_tl(Rd, Rd, 1); /* Rd = Rd - 1 */
> +    tcg_gen_andi_tl(Rd, Rd, 0xff); /* make it 8 bits */
> +
> +    /* cpu_Vf = Rd == 0x7f */
> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Vf, Rd, 0x7f);
> +    gen_ZNSf(Rd);
> +
> +    return true;
> +}
> +
> +/*
> + *  The module is an instruction set extension to the AVR CPU, performing
> + *  DES iterations. The 64-bit data block (plaintext or ciphertext) is
> placed in
> + *  the CPU register file, registers R0-R7, where LSB of data is placed
> in LSB
> + *  of R0 and MSB of data is placed in MSB of R7. The full 64-bit key
> (including
> + *  parity bits) is placed in registers R8- R15, organized in the
> register file
> + *  with LSB of key in LSB of R8 and MSB of key in MSB of R15. Executing
> one DES
> + *  instruction performs one round in the DES algorithm. Sixteen rounds
> must be
> + *  executed in increasing order to form the correct DES ciphertext or
> + *  plaintext. Intermediate results are stored in the register file
> (R0-R15)
> + *  after each DES instruction. The instruction's operand (K) determines
> which
> + *  round is executed, and the half carry flag (H) determines whether
> encryption
> + *  or decryption is performed.  The DES algorithm is described in
> + *  "Specifications for the Data Encryption Standard" (Federal Information
> + *  Processing Standards Publication 46). Intermediate results in this
> + *  implementation differ from the standard because the initial
> permutation and
> + *  the inverse initial permutation are performed each iteration. This
> does not
> + *  affect the result in the final ciphertext or plaintext, but reduces
> + *  execution time.
> + */
> +static bool trans_DES(DisasContext *ctx, arg_DES *a)
> +{
> +    /* TODO */
> +    if (!avr_have_feature(ctx, AVR_FEATURE_DES)) {
> +        return true;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + *  Indirect call of a subroutine pointed to by the Z (16 bits) Pointer
> + *  Register in the Register File and the EIND Register in the I/O space.
> This
> + *  instruction allows for indirect calls to the entire 4M (words) Program
> + *  memory space. See also ICALL. The Stack Pointer uses a post-decrement
> scheme
> + *  during EICALL.  This instruction is not available in all devices.
> Refer to
> + *  the device specific instruction set summary.
> + */
> +static bool trans_EICALL(DisasContext *ctx, arg_EICALL *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_EIJMP_EICALL)) {
> +        return true;
> +    }
> +
> +    int ret = ctx->npc;
> +
> +    gen_push_ret(ctx, ret);
> +    gen_jmp_ez(ctx);
> +    return true;
> +}
> +
> +/*
> + *  Indirect jump to the address pointed to by the Z (16 bits) Pointer
> + *  Register in the Register File and the EIND Register in the I/O space.
> This
> + *  instruction allows for indirect jumps to the entire 4M (words) Program
> + *  memory space. See also IJMP.  This instruction is not available in all
> + *  devices. Refer to the device specific instruction set summary.
> + */
> +static bool trans_EIJMP(DisasContext *ctx, arg_EIJMP *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_EIJMP_EICALL)) {
> +        return true;
> +    }
> +
> +    gen_jmp_ez(ctx);
> +    return true;
> +}
> +
> +/*
> + *  Loads one byte pointed to by the Z-register and the RAMPZ Register in
> + *  the I/O space, and places this byte in the destination register Rd.
> This
> + *  instruction features a 100% space effective constant initialization or
> + *  constant data fetch. The Program memory is organized in 16-bit words
> while
> + *  the Z-pointer is a byte address. Thus, the least significant bit of
> the
> + *  Z-pointer selects either low byte (ZLSB = 0) or high byte (ZLSB = 1).
> This
> + *  instruction can address the entire Program memory space. The Z-pointer
> + *  Register can either be left unchanged by the operation, or it can be
> + *  incremented. The incrementation applies to the entire 24-bit
> concatenation
> + *  of the RAMPZ and Z-pointer Registers.  Devices with Self-Programming
> + *  capability can use the ELPM instruction to read the Fuse and Lock bit
> value.
> + *  Refer to the device documentation for a detailed description.  This
> + *  instruction is not available in all devices. Refer to the device
> specific
> + *  instruction set summary.
> + */
> +static bool trans_ELPM1(DisasContext *ctx, arg_ELPM1 *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[0];
> +    TCGv addr = gen_get_zaddr();
> +
> +    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +static bool trans_ELPM2(DisasContext *ctx, arg_ELPM2 *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +static bool trans_ELPMX(DisasContext *ctx, arg_ELPMX *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_ELPMX)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
> +
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +
> +    gen_set_zaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +/*
> + *  Performs the logical EOR between the contents of register Rd and
> + *  register Rr and places the result in the destination register Rd.
> + */
> +static bool trans_EOR(DisasContext *ctx, arg_EOR *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +
> +    tcg_gen_xor_tl(Rd, Rd, Rr);
> +
> +    tcg_gen_movi_tl(cpu_Vf, 0);
> +    gen_ZNSf(Rd);
> +
> +    return true;
> +}
> +
> +/*
> + *  This instruction performs 8-bit x 8-bit -> 16-bit unsigned
> + *  multiplication and shifts the result one bit left.
> + */
> +static bool trans_FMUL(DisasContext *ctx, arg_FMUL *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
> +        return true;
> +    }
> +
> +    TCGv R0 = cpu_r[0];
> +    TCGv R1 = cpu_r[1];
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +
> +    tcg_gen_mul_tl(R, Rd, Rr); /* R = Rd *Rr */
> +    tcg_gen_shli_tl(R, R, 1);
> +
> +    tcg_gen_andi_tl(R0, R, 0xff);
> +    tcg_gen_shri_tl(R1, R, 8);
> +    tcg_gen_andi_tl(R1, R1, 0xff);
> +
> +    tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf = R(16) */
> +    tcg_gen_andi_tl(cpu_Zf, R, 0x0000ffff);
> +
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  This instruction performs 8-bit x 8-bit -> 16-bit signed
> multiplication
> + *  and shifts the result one bit left.
> + */
> +static bool trans_FMULS(DisasContext *ctx, arg_FMULS *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
> +        return true;
> +    }
> +
> +    TCGv R0 = cpu_r[0];
> +    TCGv R1 = cpu_r[1];
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +    TCGv t0 = tcg_temp_new_i32();
> +    TCGv t1 = tcg_temp_new_i32();
> +
> +    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
> +    tcg_gen_ext8s_tl(t1, Rr); /* make Rr full 32 bit signed */
> +    tcg_gen_mul_tl(R, t0, t1); /* R = Rd *Rr */
> +    tcg_gen_shli_tl(R, R, 1);
> +
> +    tcg_gen_andi_tl(R0, R, 0xff);
> +    tcg_gen_shri_tl(R1, R, 8);
> +    tcg_gen_andi_tl(R1, R1, 0xff);
> +
> +    tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf = R(16) */
> +    tcg_gen_andi_tl(cpu_Zf, R, 0x0000ffff);
> +
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  This instruction performs 8-bit x 8-bit -> 16-bit signed
> multiplication
> + *  and shifts the result one bit left.
> + */
> +static bool trans_FMULSU(DisasContext *ctx, arg_FMULSU *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
> +        return true;
> +    }
> +
> +    TCGv R0 = cpu_r[0];
> +    TCGv R1 = cpu_r[1];
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +    TCGv t0 = tcg_temp_new_i32();
> +
> +    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
> +    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd *Rr */
> +    tcg_gen_shli_tl(R, R, 1);
> +
> +    tcg_gen_andi_tl(R0, R, 0xff);
> +    tcg_gen_shri_tl(R1, R, 8);
> +    tcg_gen_andi_tl(R1, R1, 0xff);
> +
> +    tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf = R(16) */
> +    tcg_gen_andi_tl(cpu_Zf, R, 0x0000ffff);
> +
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  Calls to a subroutine within the entire 4M (words) Program memory. The
> + *  return address (to the instruction after the CALL) will be stored
> onto the
> + *  Stack. See also RCALL. The Stack Pointer uses a post-decrement scheme
> during
> + *  CALL.  This instruction is not available in all devices. Refer to the
> device
> + *  specific instruction set summary.
> + */
> +static bool trans_ICALL(DisasContext *ctx, arg_ICALL *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_IJMP_ICALL)) {
> +        return true;
> +    }
> +
> +    int ret = ctx->npc;
> +
> +    gen_push_ret(ctx, ret);
> +    gen_jmp_z(ctx);
> +
> +    return true;
> +}
> +
> +/*
> + *  Indirect jump to the address pointed to by the Z (16 bits) Pointer
> + *  Register in the Register File. The Z-pointer Register is 16 bits wide
> and
> + *  allows jump within the lowest 64K words (128KB) section of Program
> memory.
> + *  This instruction is not available in all devices. Refer to the device
> + *  specific instruction set summary.
> + */
> +static bool trans_IJMP(DisasContext *ctx, arg_IJMP *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_IJMP_ICALL)) {
> +        return true;
> +    }
> +
> +    gen_jmp_z(ctx);
> +
> +    return true;
> +}
> +
> +/*
> + *  Loads data from the I/O Space (Ports, Timers, Configuration Registers,
> + *  etc.) into register Rd in the Register File.
> + */
> +static bool trans_IN(DisasContext *ctx, arg_IN *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv port = tcg_const_i32(a->imm);
> +
> +    gen_helper_inb(Rd, cpu_env, port);
> +
> +    tcg_temp_free_i32(port);
> +
> +    return true;
> +}
> +
> +/*
> + *  Adds one -1- to the contents of register Rd and places the result in
> the
> + *  destination register Rd.  The C Flag in SREG is not affected by the
> + *  operation, thus allowing the INC instruction to be used on a loop
> counter in
> + *  multiple-precision computations.  When operating on unsigned numbers,
> only
> + *  BREQ and BRNE branches can be expected to perform consistently. When
> + *  operating on two's complement values, all signed branches are
> available.
> + */
> +static bool trans_INC(DisasContext *ctx, arg_INC *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +
> +    tcg_gen_addi_tl(Rd, Rd, 1);
> +    tcg_gen_andi_tl(Rd, Rd, 0xff);
> +
> +    /* cpu_Vf = Rd == 0x80 */
> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Vf, Rd, 0x80);
> +    gen_ZNSf(Rd);
> +
> +    return true;
> +}
> +
> +/*
> + *  Jump to an address within the entire 4M (words) Program memory. See
> also
> + *  RJMP.  This instruction is not available in all devices. Refer to the
> device
> + *  specific instruction set summary.0
> + */
> +static bool trans_JMP(DisasContext *ctx, arg_JMP *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_JMP_CALL)) {
> +        return true;
> +    }
> +
> +    gen_goto_tb(ctx, 0, a->imm);
> +
> +    return true;
> +}
> +
> +/*
> + *  Load one byte indirect from data space to register and stores an clear
> + *  the bits in data space specified by the register. The instruction can
> only
> + *  be used towards internal SRAM.  The data location is pointed to by
> the Z (16
> + *  bits) Pointer Register in the Register File. Memory access is limited
> to the
> + *  current data segment of 64KB. To access another data segment in
> devices with
> + *  more than 64KB data space, the RAMPZ in register in the I/O area has
> to be
> + *  changed.  The Z-pointer Register is left unchanged by the operation.
> This
> + *  instruction is especially suited for clearing status bits stored in
> SRAM.
> + */
> +static void gen_data_store(DisasContext *ctx, TCGv data, TCGv addr)
> +{
> +    if (ctx->tb->flags & TB_FLAGS_FULL_ACCESS) {
> +        gen_helper_fullwr(cpu_env, data, addr);
> +    } else {
> +        tcg_gen_qemu_st8(data, addr, MMU_DATA_IDX); /* mem[addr] = data */
> +    }
> +}
> +
> +static void gen_data_load(DisasContext *ctx, TCGv data, TCGv addr)
> +{
> +    if (ctx->tb->flags & TB_FLAGS_FULL_ACCESS) {
> +        gen_helper_fullrd(data, cpu_env, addr);
> +    } else {
> +        tcg_gen_qemu_ld8u(data, addr, MMU_DATA_IDX); /* data = mem[addr]
> */
> +    }
> +}
> +
> +static bool trans_LAC(DisasContext *ctx, arg_LAC *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
> +        return true;
> +    }
> +
> +    TCGv Rr = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +    TCGv t0 = tcg_temp_new_i32();
> +    TCGv t1 = tcg_temp_new_i32();
> +
> +    gen_data_load(ctx, t0, addr); /* t0 = mem[addr] */
> +        /* t1 = t0 & (0xff - Rr) = t0 and ~Rr */
> +    tcg_gen_andc_tl(t1, t0, Rr);
> +
> +    tcg_gen_mov_tl(Rr, t0); /* Rr = t0 */
> +    gen_data_store(ctx, t1, addr); /* mem[addr] = t1 */
> +
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +/*
> + *  Load one byte indirect from data space to register and set bits in
> data
> + *  space specified by the register. The instruction can only be used
> towards
> + *  internal SRAM.  The data location is pointed to by the Z (16 bits)
> Pointer
> + *  Register in the Register File. Memory access is limited to the
> current data
> + *  segment of 64KB. To access another data segment in devices with more
> than
> + *  64KB data space, the RAMPZ in register in the I/O area has to be
> changed.
> + *  The Z-pointer Register is left unchanged by the operation. This
> instruction
> + *  is especially suited for setting status bits stored in SRAM.
> + */
> +static bool trans_LAS(DisasContext *ctx, arg_LAS *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
> +        return true;
> +    }
> +
> +    TCGv Rr = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +    TCGv t0 = tcg_temp_new_i32();
> +    TCGv t1 = tcg_temp_new_i32();
> +
> +    gen_data_load(ctx, t0, addr); /* t0 = mem[addr] */
> +    tcg_gen_or_tl(t1, t0, Rr);
> +
> +    tcg_gen_mov_tl(Rr, t0); /* Rr = t0 */
> +    gen_data_store(ctx, t1, addr); /* mem[addr] = t1 */
> +
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +/*
> + *  Load one byte indirect from data space to register and toggles bits in
> + *  the data space specified by the register.  The instruction can only
> be used
> + *  towards SRAM.  The data location is pointed to by the Z (16 bits)
> Pointer
> + *  Register in the Register File. Memory access is limited to the
> current data
> + *  segment of 64KB. To access another data segment in devices with more
> than
> + *  64KB data space, the RAMPZ in register in the I/O area has to be
> changed.
> + *  The Z-pointer Register is left unchanged by the operation. This
> instruction
> + *  is especially suited for changing status bits stored in SRAM.
> + */
> +static bool trans_LAT(DisasContext *ctx, arg_LAT *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +    TCGv t0 = tcg_temp_new_i32();
> +    TCGv t1 = tcg_temp_new_i32();
> +
> +    gen_data_load(ctx, t0, addr); /* t0 = mem[addr] */
> +    tcg_gen_xor_tl(t1, t0, Rd);
> +
> +    tcg_gen_mov_tl(Rd, t0); /* Rd = t0 */
> +    gen_data_store(ctx, t1, addr); /* mem[addr] = t1 */
> +
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +/*
> + *  Loads one byte indirect from the data space to a register. For parts
> + *  with SRAM, the data space consists of the Register File, I/O memory
> and
> + *  internal SRAM (and external SRAM if applicable). For parts without
> SRAM, the
> + *  data space consists of the Register File only. In some parts the Flash
> + *  Memory has been mapped to the data space and can be read using this
> command.
> + *  The EEPROM has a separate address space.  The data location is
> pointed to by
> + *  the X (16 bits) Pointer Register in the Register File. Memory access
> is
> + *  limited to the current data segment of 64KB. To access another data
> segment
> + *  in devices with more than 64KB data space, the RAMPX in register in
> the I/O
> + *  area has to be changed.  The X-pointer Register can either be left
> unchanged
> + *  by the operation, or it can be post-incremented or predecremented.
> These
> + *  features are especially suited for accessing arrays, tables, and Stack
> + *  Pointer usage of the X-pointer Register. Note that only the low byte
> of the
> + *  X-pointer is updated in devices with no more than 256 bytes data
> space. For
> + *  such devices, the high byte of the pointer is not used by this
> instruction
> + *  and can be used for other purposes. The RAMPX Register in the I/O
> area is
> + *  updated in parts with more than 64KB data space or more than 64KB
> Program
> + *  memory, and the increment/decrement is added to the entire 24-bit
> address on
> + *  such devices.  Not all variants of this instruction is available in
> all
> + *  devices. Refer to the device specific instruction set summary.  In the
> + *  Reduced Core tinyAVR the LD instruction can be used to achieve the
> same
> + *  operation as LPM since the program memory is mapped to the data memory
> + *  space.
> + */
> +static bool trans_LDX1(DisasContext *ctx, arg_LDX1 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_xaddr();
> +
> +    gen_data_load(ctx, Rd, addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +static bool trans_LDX2(DisasContext *ctx, arg_LDX2 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_xaddr();
> +
> +    gen_data_load(ctx, Rd, addr);
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +
> +    gen_set_xaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +static bool trans_LDX3(DisasContext *ctx, arg_LDX3 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_xaddr();
> +
> +    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
> +    gen_data_load(ctx, Rd, addr);
> +    gen_set_xaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +/*
> + *  Loads one byte indirect with or without displacement from the data
> space
> + *  to a register. For parts with SRAM, the data space consists of the
> Register
> + *  File, I/O memory and internal SRAM (and external SRAM if applicable).
> For
> + *  parts without SRAM, the data space consists of the Register File
> only. In
> + *  some parts the Flash Memory has been mapped to the data space and can
> be
> + *  read using this command. The EEPROM has a separate address space.
> The data
> + *  location is pointed to by the Y (16 bits) Pointer Register in the
> Register
> + *  File. Memory access is limited to the current data segment of 64KB. To
> + *  access another data segment in devices with more than 64KB data
> space, the
> + *  RAMPY in register in the I/O area has to be changed.  The Y-pointer
> Register
> + *  can either be left unchanged by the operation, or it can be
> post-incremented
> + *  or predecremented.  These features are especially suited for accessing
> + *  arrays, tables, and Stack Pointer usage of the Y-pointer Register.
> Note that
> + *  only the low byte of the Y-pointer is updated in devices with no more
> than
> + *  256 bytes data space. For such devices, the high byte of the pointer
> is not
> + *  used by this instruction and can be used for other purposes. The RAMPY
> + *  Register in the I/O area is updated in parts with more than 64KB data
> space
> + *  or more than 64KB Program memory, and the increment/decrement/
> displacement
> + *  is added to the entire 24-bit address on such devices.  Not all
> variants of
> + *  this instruction is available in all devices. Refer to the device
> specific
> + *  instruction set summary.  In the Reduced Core tinyAVR the LD
> instruction can
> + *  be used to achieve the same operation as LPM since the program memory
> is
> + *  mapped to the data memory space.
> + */
> +static bool trans_LDY2(DisasContext *ctx, arg_LDY2 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_yaddr();
> +
> +    gen_data_load(ctx, Rd, addr);
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +
> +    gen_set_yaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +static bool trans_LDY3(DisasContext *ctx, arg_LDY3 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_yaddr();
> +
> +    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
> +    gen_data_load(ctx, Rd, addr);
> +    gen_set_yaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +static bool trans_LDDY(DisasContext *ctx, arg_LDDY *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_yaddr();
> +
> +    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
> +    gen_data_load(ctx, Rd, addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +/*
> + *  Loads one byte indirect with or without displacement from the data
> space
> + *  to a register. For parts with SRAM, the data space consists of the
> Register
> + *  File, I/O memory and internal SRAM (and external SRAM if applicable).
> For
> + *  parts without SRAM, the data space consists of the Register File
> only. In
> + *  some parts the Flash Memory has been mapped to the data space and can
> be
> + *  read using this command. The EEPROM has a separate address space.
> The data
> + *  location is pointed to by the Z (16 bits) Pointer Register in the
> Register
> + *  File. Memory access is limited to the current data segment of 64KB. To
> + *  access another data segment in devices with more than 64KB data
> space, the
> + *  RAMPZ in register in the I/O area has to be changed.  The Z-pointer
> Register
> + *  can either be left unchanged by the operation, or it can be
> post-incremented
> + *  or predecremented.  These features are especially suited for Stack
> Pointer
> + *  usage of the Z-pointer Register, however because the Z-pointer
> Register can
> + *  be used for indirect subroutine calls, indirect jumps and table
> lookup, it
> + *  is often more convenient to use the X or Y-pointer as a dedicated
> Stack
> + *  Pointer. Note that only the low byte of the Z-pointer is updated in
> devices
> + *  with no more than 256 bytes data space. For such devices, the high
> byte of
> + *  the pointer is not used by this instruction and can be used for other
> + *  purposes. The RAMPZ Register in the I/O area is updated in parts with
> more
> + *  than 64KB data space or more than 64KB Program memory, and the
> + *  increment/decrement/displacement is added to the entire 24-bit
> address on
> + *  such devices.  Not all variants of this instruction is available in
> all
> + *  devices. Refer to the device specific instruction set summary.  In the
> + *  Reduced Core tinyAVR the LD instruction can be used to achieve the
> same
> + *  operation as LPM since the program memory is mapped to the data memory
> + *  space.  For using the Z-pointer for table lookup in Program memory
> see the
> + *  LPM and ELPM instructions.
> + */
> +static bool trans_LDZ2(DisasContext *ctx, arg_LDZ2 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    gen_data_load(ctx, Rd, addr);
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +
> +    gen_set_zaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +static bool trans_LDZ3(DisasContext *ctx, arg_LDZ3 *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    tcg_gen_subi_tl(addr, addr, 1); /* addr = addr - 1 */
> +    gen_data_load(ctx, Rd, addr);
> +
> +    gen_set_zaddr(addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +static bool trans_LDDZ(DisasContext *ctx, arg_LDDZ *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = gen_get_zaddr();
> +
> +    tcg_gen_addi_tl(addr, addr, a->imm); /* addr = addr + q */
> +    gen_data_load(ctx, Rd, addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +/*
> + * Loads an 8 bit constant directly to register 16 to 31.
> + */
> +static bool trans_LDI(DisasContext *ctx, arg_LDI *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    int imm = a->imm;
> +
> +    tcg_gen_movi_tl(Rd, imm);
> +
> +    return true;
> +}
> +
> +/*
> + *  Loads one byte from the data space to a register. For parts with SRAM,
> + *  the data space consists of the Register File, I/O memory and internal
> SRAM
> + *  (and external SRAM if applicable). For parts without SRAM, the data
> space
> + *  consists of the register file only. The EEPROM has a separate address
> space.
> + *  A 16-bit address must be supplied. Memory access is limited to the
> current
> + *  data segment of 64KB. The LDS instruction uses the RAMPD Register to
> access
> + *  memory above 64KB. To access another data segment in devices with
> more than
> + *  64KB data space, the RAMPD in register in the I/O area has to be
> changed.
> + *  This instruction is not available in all devices. Refer to the device
> + *  specific instruction set summary.
> + */
> +static bool trans_LDS(DisasContext *ctx, arg_LDS *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = tcg_temp_new_i32();
> +    TCGv H = cpu_rampD;
> +    a->imm = next_word(ctx);
> +
> +    tcg_gen_mov_tl(addr, H); /* addr = H:M:L */
> +    tcg_gen_shli_tl(addr, addr, 16);
> +    tcg_gen_ori_tl(addr, addr, a->imm);
> +
> +    gen_data_load(ctx, Rd, addr);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +/*
> + *  Loads one byte pointed to by the Z-register into the destination
> + *  register Rd. This instruction features a 100% space effective constant
> + *  initialization or constant data fetch. The Program memory is
> organized in
> + *  16-bit words while the Z-pointer is a byte address. Thus, the least
> + *  significant bit of the Z-pointer selects either low byte (ZLSB = 0)
> or high
> + *  byte (ZLSB = 1). This instruction can address the first 64KB (32K
> words) of
> + *  Program memory. The Zpointer Register can either be left unchanged by
> the
> + *  operation, or it can be incremented. The incrementation does not
> apply to
> + *  the RAMPZ Register.  Devices with Self-Programming capability can use
> the
> + *  LPM instruction to read the Fuse and Lock bit values.  Refer to the
> device
> + *  documentation for a detailed description.  The LPM instruction is not
> + *  available in all devices. Refer to the device specific instruction set
> + *  summary
> + */
> +static bool trans_LPM1(DisasContext *ctx, arg_LPM1 *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[0];
> +    TCGv addr = tcg_temp_new_i32();
> +    TCGv H = cpu_r[31];
> +    TCGv L = cpu_r[30];
> +
> +    tcg_gen_shli_tl(addr, H, 8); /* addr = H:L */
> +    tcg_gen_or_tl(addr, addr, L);
> +
> +    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +static bool trans_LPM2(DisasContext *ctx, arg_LPM2 *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = tcg_temp_new_i32();
> +    TCGv H = cpu_r[31];
> +    TCGv L = cpu_r[30];
> +
> +    tcg_gen_shli_tl(addr, H, 8); /* addr = H:L */
> +    tcg_gen_or_tl(addr, addr, L);
> +
> +    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +static bool trans_LPMX(DisasContext *ctx, arg_LPMX *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_LPMX)) {
> +        return true;
> +    }
> +
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv addr = tcg_temp_new_i32();
> +    TCGv H = cpu_r[31];
> +    TCGv L = cpu_r[30];
> +
> +    tcg_gen_shli_tl(addr, H, 8); /* addr = H:L */
> +    tcg_gen_or_tl(addr, addr, L);
> +
> +    tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd = mem[addr] */
> +
> +    tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
> +
> +    tcg_gen_andi_tl(L, addr, 0xff);
> +
> +    tcg_gen_shri_tl(addr, addr, 8);
> +    tcg_gen_andi_tl(H, addr, 0xff);
> +
> +    tcg_temp_free_i32(addr);
> +
> +    return true;
> +}
> +
> +/*
> + *  Shifts all bits in Rd one place to the right. Bit 7 is cleared. Bit 0
> is
> + *  loaded into the C Flag of the SREG. This operation effectively
> divides an
> + *  unsigned value by two. The C Flag can be used to round the result.
> + */
> +static bool trans_LSR(DisasContext *ctx, arg_LSR *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +
> +    tcg_gen_andi_tl(cpu_Cf, Rd, 1);
> +
> +    tcg_gen_shri_tl(Rd, Rd, 1);
> +
> +    tcg_gen_mov_tl(cpu_Zf, Rd);
> +    tcg_gen_movi_tl(cpu_Nf, 0);
> +    tcg_gen_mov_tl(cpu_Vf, cpu_Cf);
> +    tcg_gen_mov_tl(cpu_Sf, cpu_Vf);
> +
> +    return true;
> +}
> +
> +/*
> + *  This instruction makes a copy of one register into another. The source
> + *  register Rr is left unchanged, while the destination register Rd is
> loaded
> + *  with a copy of Rr.
> + */
> +static bool trans_MOV(DisasContext *ctx, arg_MOV *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +
> +    tcg_gen_mov_tl(Rd, Rr);
> +
> +    return true;
> +}
> +
> +/*
> + *  This instruction makes a copy of one register pair into another
> register
> + *  pair. The source register pair Rr+1:Rr is left unchanged, while the
> + *  destination register pair Rd+1:Rd is loaded with a copy of Rr +
> 1:Rr.  This
> + *  instruction is not available in all devices. Refer to the device
> specific
> + *  instruction set summary.
> + */
> +static bool trans_MOVW(DisasContext *ctx, arg_MOVW *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_MOVW)) {
> +        return true;
> +    }
> +
> +    TCGv RdL = cpu_r[a->rd];
> +    TCGv RdH = cpu_r[a->rd + 1];
> +    TCGv RrL = cpu_r[a->rr];
> +    TCGv RrH = cpu_r[a->rr + 1];
> +
> +    tcg_gen_mov_tl(RdH, RrH);
> +    tcg_gen_mov_tl(RdL, RrL);
> +
> +    return true;
> +}
> +
> +/*
> + *  This instruction performs 8-bit x 8-bit -> 16-bit unsigned
> multiplication.
> + */
> +static bool trans_MUL(DisasContext *ctx, arg_MUL *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
> +        return true;
> +    }
> +
> +    TCGv R0 = cpu_r[0];
> +    TCGv R1 = cpu_r[1];
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +
> +    tcg_gen_mul_tl(R, Rd, Rr); /* R = Rd *Rr */
> +
> +    tcg_gen_andi_tl(R0, R, 0xff);
> +    tcg_gen_shri_tl(R1, R, 8);
> +
> +    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(16) */
> +    tcg_gen_mov_tl(cpu_Zf, R);
> +
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  This instruction performs 8-bit x 8-bit -> 16-bit signed
> multiplication.
> + */
> +static bool trans_MULS(DisasContext *ctx, arg_MULS *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
> +        return true;
> +    }
> +
> +    TCGv R0 = cpu_r[0];
> +    TCGv R1 = cpu_r[1];
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +    TCGv t0 = tcg_temp_new_i32();
> +    TCGv t1 = tcg_temp_new_i32();
> +
> +    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
> +    tcg_gen_ext8s_tl(t1, Rr); /* make Rr full 32 bit signed */
> +    tcg_gen_mul_tl(R, t0, t1); /* R = Rd * Rr */
> +
> +    tcg_gen_andi_tl(R0, R, 0xff);
> +    tcg_gen_shri_tl(R1, R, 8);
> +
> +    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(16) */
> +    tcg_gen_mov_tl(cpu_Zf, R);
> +
> +    tcg_temp_free_i32(t1);
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  This instruction performs 8-bit x 8-bit -> 16-bit multiplication of a
> + *  signed and an unsigned number.
> + */
> +static bool trans_MULSU(DisasContext *ctx, arg_MULSU *a)
> +{
> +    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
> +        return true;
> +    }
> +
> +    TCGv R0 = cpu_r[0];
> +    TCGv R1 = cpu_r[1];
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +    TCGv t0 = tcg_temp_new_i32();
> +
> +    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
> +    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd *Rr */
> +
> +    tcg_gen_andi_tl(R0, R, 0xff);
> +    tcg_gen_shri_tl(R1, R, 8);
> +
> +    tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf = R(16) */
> +    tcg_gen_mov_tl(cpu_Zf, R);
> +
> +    tcg_temp_free_i32(t0);
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +/*
> + *  Replaces the contents of register Rd with its two's complement; the
> + *  value $80 is left unchanged.
> + */
> +static bool trans_NEG(DisasContext *ctx, arg_NEG *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv t0 = tcg_const_i32(0);
> +    TCGv R = tcg_temp_new_i32();
> +
> +    /* op */
> +    tcg_gen_sub_tl(R, t0, Rd); /* R = 0 - Rd */
> +    tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */
> +
> +    gen_sub_CHf(R, t0, Rd);
> +    gen_sub_Vf(R, t0, Rd);
> +    gen_ZNSf(R);
> +
> +    /* R */
> +    tcg_gen_mov_tl(Rd,--
> 2.17.2 (Apple Git-113)
>
>
>

--000000000000b7984e0594a31d30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, September 2, 2019, Michael Rolnik &lt;<a href=3D"mailto:=
mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">This includes:<br>
- TCG translations for each instruction<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/avr/translate.c | 2888 ++++++++++++++++++++++++++++++<wbr>++++=
++++++<br>
=C2=A01 file changed, 2888 insertions(+)<br>
=C2=A0create mode 100644 target/avr/translate.c<br><br></blockquote><div><b=
r></div><div>Hi, Michael,</div><div><br></div><div><br></div><div>This patc=
h is way too large. I suggest splitting it into:</div><div><br></div><div>-=
 register definitions</div><div>- load instruction handling</div><div>- sto=
re instruction handling</div><div>- logic instruction handling</div><div><b=
r></div><div>etc.</div><div><br></div><div>Thanks, Aleksandar</div><div><br=
></div><div>P.S. One more hurdle with your communication on the list is tha=
t you don&#39;t use &quot;inline responding&quot; while replaying, please u=
se it in future. See other messages in the mailing list how &quot;inline re=
sponding&quot; looks.</div><div><br></div><div><br></div><div><br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
diff --git a/target/avr/translate.c b/target/avr/translate.c<br>
new file mode 100644<br>
index 0000000000..42cb4a690c<br>
--- /dev/null<br>
+++ b/target/avr/translate.c<br>
@@ -0,0 +1,2888 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" target=3D"_bl=
ank">http://www.gnu.org/licenses/<wbr>lgpl-2.1.html</a>&gt;<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/qemu-print.h&quot;<br>
+#include &quot;tcg/tcg.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+#include &quot;exec/exec-all.h&quot;<br>
+#include &quot;disas/disas.h&quot;<br>
+#include &quot;tcg-op.h&quot;<br>
+#include &quot;exec/cpu_ldst.h&quot;<br>
+#include &quot;exec/helper-proto.h&quot;<br>
+#include &quot;exec/helper-gen.h&quot;<br>
+#include &quot;exec/log.h&quot;<br>
+#include &quot;exec/gdbstub.h&quot;<br>
+#include &quot;exec/translator.h&quot;<br>
+<br>
+/*<br>
+ *=C2=A0 Define if you want a BREAK instruction translated to a breakpoint=
<br>
+ *=C2=A0 Active debugging connection is assumed<br>
+ *=C2=A0 This is for<br>
+ *=C2=A0 <a href=3D"https://github.com/seharris/qemu-avr-tests/tree/master=
/instruction-tests" target=3D"_blank">https://github.com/seharris/<wbr>qemu=
-avr-tests/tree/master/<wbr>instruction-tests</a><br>
+ *=C2=A0 tests<br>
+ */<br>
+#undef BREAKPOINT_ON_BREAK<br>
+<br>
+static TCGv cpu_pc;<br>
+<br>
+static TCGv cpu_Cf;<br>
+static TCGv cpu_Zf;<br>
+static TCGv cpu_Nf;<br>
+static TCGv cpu_Vf;<br>
+static TCGv cpu_Sf;<br>
+static TCGv cpu_Hf;<br>
+static TCGv cpu_Tf;<br>
+static TCGv cpu_If;<br>
+<br>
+static TCGv cpu_rampD;<br>
+static TCGv cpu_rampX;<br>
+static TCGv cpu_rampY;<br>
+static TCGv cpu_rampZ;<br>
+<br>
+static TCGv cpu_r[NO_CPU_REGISTERS];<br>
+static TCGv cpu_eind;<br>
+static TCGv cpu_sp;<br>
+<br>
+static TCGv cpu_skip;<br>
+<br>
+static const char reg_names[NO_CPU_REGISTERS][8] =3D {<br>
+=C2=A0 =C2=A0 &quot;r0&quot;,=C2=A0 &quot;r1&quot;,=C2=A0 &quot;r2&quot;,=
=C2=A0 &quot;r3&quot;,=C2=A0 &quot;r4&quot;,=C2=A0 &quot;r5&quot;,=C2=A0 &q=
uot;r6&quot;,=C2=A0 &quot;r7&quot;,<br>
+=C2=A0 =C2=A0 &quot;r8&quot;,=C2=A0 &quot;r9&quot;,=C2=A0 &quot;r10&quot;,=
 &quot;r11&quot;, &quot;r12&quot;, &quot;r13&quot;, &quot;r14&quot;, &quot;=
r15&quot;,<br>
+=C2=A0 =C2=A0 &quot;r16&quot;, &quot;r17&quot;, &quot;r18&quot;, &quot;r19=
&quot;, &quot;r20&quot;, &quot;r21&quot;, &quot;r22&quot;, &quot;r23&quot;,=
<br>
+=C2=A0 =C2=A0 &quot;r24&quot;, &quot;r25&quot;, &quot;r26&quot;, &quot;r27=
&quot;, &quot;r28&quot;, &quot;r29&quot;, &quot;r30&quot;, &quot;r31&quot;,=
<br>
+};<br>
+#define REG(x) (cpu_r[x])<br>
+<br>
+enum {<br>
+=C2=A0 =C2=A0 DISAS_EXIT=C2=A0 =C2=A0=3D DISAS_TARGET_0,=C2=A0 /* We want =
return to the cpu main loop.=C2=A0 */<br>
+=C2=A0 =C2=A0 DISAS_LOOKUP =3D DISAS_TARGET_1,=C2=A0 /* We have a variable=
 condition exit.=C2=A0 */<br>
+=C2=A0 =C2=A0 DISAS_CHAIN=C2=A0 =3D DISAS_TARGET_2,=C2=A0 /* We have a sin=
gle condition exit.=C2=A0 */<br>
+};<br>
+<br>
+typedef struct DisasContext DisasContext;<br>
+<br>
+/* This is the state at translation time. */<br>
+struct DisasContext {<br>
+=C2=A0 =C2=A0 TranslationBlock *tb;<br>
+<br>
+=C2=A0 =C2=A0 CPUAVRState *env;<br>
+=C2=A0 =C2=A0 CPUState *cs;<br>
+<br>
+=C2=A0 =C2=A0 target_long npc;<br>
+=C2=A0 =C2=A0 uint32_t opcode;<br>
+<br>
+=C2=A0 =C2=A0 /* Routine used to access memory */<br>
+=C2=A0 =C2=A0 int memidx;<br>
+=C2=A0 =C2=A0 int bstate;<br>
+=C2=A0 =C2=A0 int singlestep;<br>
+<br>
+=C2=A0 =C2=A0 TCGv skip_var0;<br>
+=C2=A0 =C2=A0 TCGv skip_var1;<br>
+=C2=A0 =C2=A0 TCGCond skip_cond;<br>
+=C2=A0 =C2=A0 bool free_skip_var0;<br>
+};<br>
+<br>
+static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); }<=
br>
+static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }<b=
r>
+static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) * 2;=
 }<br>
+static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }<b=
r>
+<br>
+static uint16_t next_word(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 return cpu_lduw_code(ctx-&gt;env, ctx-&gt;npc++ * 2);<br>
+}<br>
+<br>
+static int append_16(DisasContext *ctx, int x)<br>
+{<br>
+=C2=A0 =C2=A0 return x &lt;&lt; 16 | next_word(ctx);<br>
+}<br>
+<br>
+static bool decode_insn(DisasContext *ctx, uint16_t insn);<br>
+#include &quot;decode_insn.inc.c&quot;<br>
+<br>
+static bool avr_have_feature(DisasContext *ctx, int feature)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_feature(ctx-&gt;env, feature)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_unsupported(cpu_<wbr>env);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-&gt;bstate =3D DISAS_NORETURN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)<br>
+{<br>
+=C2=A0 =C2=A0 TranslationBlock *tb =3D ctx-&gt;tb;<br>
+<br>
+=C2=A0 =C2=A0 if (ctx-&gt;singlestep =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_goto_tb(n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(cpu_pc, dest);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_exit_tb(tb, n);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_i32(cpu_pc, dest);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_debug(cpu_env);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_exit_tb(NULL, 0);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ctx-&gt;bstate =3D DISAS_NORETURN;<br>
+}<br>
+<br>
+#include &quot;exec/gen-icount.h&quot;<br>
+<br>
+static void gen_add_CHf(TCGv R, TCGv Rd, TCGv Rr)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t2 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t3 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_and_tl(t1, Rd, Rr); /* t1 =3D Rd &amp; Rr */<br>
+=C2=A0 =C2=A0 tcg_gen_andc_tl(t2, Rd, R); /* t2 =3D Rd &amp; ~R */<br>
+=C2=A0 =C2=A0 tcg_gen_andc_tl(t3, Rr, R); /* t3 =3D Rr &amp; ~R */<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(t1, t1, t2); /* t1 =3D t1 | t2 | t3 */<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(t1, t1, t3);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Cf, t1, 7); /* Cf =3D t1(7) */<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Hf, t1, 3); /* Hf =3D t1(3) */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(cpu_Hf, cpu_Hf, 1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t3);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t2);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+}<br>
+<br>
+static void gen_add_Vf(TCGv R, TCGv Rd, TCGv Rr)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t2 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* t1 =3D Rd &amp; Rr &amp; ~R | ~Rd &amp; ~Rr &amp; R =3D (=
Rd ^ R) &amp; ~(Rd ^ Rr) */<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(t1, Rd, R);<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(t2, Rd, Rr);<br>
+=C2=A0 =C2=A0 tcg_gen_andc_tl(t1, t1, t2);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Vf, t1, 7); /* Vf =3D t1(7) */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t2);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+}<br>
+<br>
+static void gen_sub_CHf(TCGv R, TCGv Rd, TCGv Rr)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t2 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t3 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* Cf &amp; Hf */<br>
+=C2=A0 =C2=A0 tcg_gen_not_tl(t1, Rd); /* t1 =3D ~Rd */<br>
+=C2=A0 =C2=A0 tcg_gen_and_tl(t2, t1, Rr); /* t2 =3D ~Rd &amp; Rr */<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(t3, t1, Rr); /* t3 =3D (~Rd | Rr) &amp; R */<b=
r>
+=C2=A0 =C2=A0 tcg_gen_and_tl(t3, t3, R);<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(t2, t2, t3); /* t2 =3D ~Rd &amp; Rr | ~Rd &amp=
; R | R &amp; Rr */<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Cf, t2, 7); /* Cf =3D t2(7) */<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Hf, t2, 3); /* Hf =3D t2(3) */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(cpu_Hf, cpu_Hf, 1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t3);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t2);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+}<br>
+<br>
+static void gen_sub_Vf(TCGv R, TCGv Rd, TCGv Rr)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t2 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* Vf */<br>
+=C2=A0 =C2=A0 /* t1 =3D Rd &amp; ~Rr &amp; ~R | ~Rd &amp; Rr &amp; R =3D (=
Rd ^ R) &amp; (Rd ^ R) */<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(t1, Rd, R);<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(t2, Rd, Rr);<br>
+=C2=A0 =C2=A0 tcg_gen_and_tl(t1, t1, t2);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Vf, t1, 7); /* Vf =3D t1(7) */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t2);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+}<br>
+<br>
+static void gen_rshift_ZNVSf(TCGv R)<br>
+{<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_Zf, R); /* Zf =3D R */<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf =3D R(7) */<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(cpu_Vf, cpu_Nf, cpu_Cf);<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf =3D Nf ^ Vf */=
<br>
+}<br>
+<br>
+static void gen_NSf(TCGv R)<br>
+{<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf =3D R(7) */<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf =3D Nf ^ Vf */=
<br>
+}<br>
+<br>
+static void gen_ZNSf(TCGv R)<br>
+{<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_Zf, R); /* Zf =3D R */<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Nf, R, 7); /* Nf =3D R(7) */<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf); /* Sf =3D Nf ^ Vf */=
<br>
+}<br>
+<br>
+static void gen_push_ret(DisasContext *ctx, int ret)<br>
+{<br>
+=C2=A0 =C2=A0 if (avr_feature(ctx-&gt;env, AVR_FEATURE_1_BYTE_PC)) {<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv t0 =3D tcg_const_i32((ret &amp; 0x0000ff)=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_qemu_st_tl(t0, cpu_sp, MMU_DATA_IDX, M=
O_UB);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 } else if (avr_feature(ctx-&gt;env, AVR_FEATURE_2_BYTE_PC)) =
{<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv t0 =3D tcg_const_i32((ret &amp; 0x00ffff)=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_qemu_st_tl(t0, cpu_sp, MMU_DATA_IDX, M=
O_BEUW);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+<br>
+=C2=A0 =C2=A0 } else if (avr_feature(ctx-&gt;env, AVR_FEATURE_3_BYTE_PC)) =
{<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv lo =3D tcg_const_i32((ret &amp; 0x0000ff)=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv hi =3D tcg_const_i32((ret &amp; 0xffff00)=
 &gt;&gt; 8);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_qemu_st_tl(lo, cpu_sp, MMU_DATA_IDX, M=
O_UB);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_subi_tl(cpu_sp, cpu_sp, 2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_qemu_st_tl(hi, cpu_sp, MMU_DATA_IDX, M=
O_BEUW);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_subi_tl(cpu_sp, cpu_sp, 1);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i32(lo);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i32(hi);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void gen_pop_ret(DisasContext *ctx, TCGv ret)<br>
+{<br>
+=C2=A0 =C2=A0 if (avr_feature(ctx-&gt;env, AVR_FEATURE_1_BYTE_PC)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, =
MO_UB);<br>
+=C2=A0 =C2=A0 } else if (avr_feature(ctx-&gt;env, AVR_FEATURE_2_BYTE_PC)) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_qemu_ld_tl(ret, cpu_sp, MMU_DATA_IDX, =
MO_BEUW);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);<br>
+=C2=A0 =C2=A0 } else if (avr_feature(ctx-&gt;env, AVR_FEATURE_3_BYTE_PC)) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv lo =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TCGv hi =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_addi_tl(cpu_sp, cpu_sp, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_qemu_ld_tl(hi, cpu_sp, MMU_DATA_IDX, M=
O_BEUW);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_addi_tl(cpu_sp, cpu_sp, 2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_qemu_ld_tl(lo, cpu_sp, MMU_DATA_IDX, M=
O_UB);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_deposit_tl(ret, lo, hi, 8, 16);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i32(lo);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_temp_free_i32(hi);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void gen_jmp_ez(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 tcg_gen_deposit_tl(cpu_pc, cpu_r[30], cpu_r[31], 8, 8);<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(cpu_pc, cpu_pc, cpu_eind);<br>
+=C2=A0 =C2=A0 ctx-&gt;bstate =3D DISAS_LOOKUP;<br>
+}<br>
+<br>
+static void gen_jmp_z(DisasContext *ctx)<br>
+{<br>
+=C2=A0 =C2=A0 tcg_gen_deposit_tl(cpu_pc, cpu_r[30], cpu_r[31], 8, 8);<br>
+=C2=A0 =C2=A0 ctx-&gt;bstate =3D DISAS_LOOKUP;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 in the gen_set_addr &amp; gen_get_addr functions<br>
+ *=C2=A0 H assumed to be in 0x00ff0000 format<br>
+ *=C2=A0 M assumed to be in 0x000000ff format<br>
+ *=C2=A0 L assumed to be in 0x000000ff format<br>
+ */<br>
+static void gen_set_addr(TCGv addr, TCGv H, TCGv M, TCGv L)<br>
+{<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(L, addr, 0x000000ff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(M, addr, 0x0000ff00);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(M, M, 8);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(H, addr, 0x00ff0000);<br>
+}<br>
+<br>
+static void gen_set_xaddr(TCGv addr)<br>
+{<br>
+=C2=A0 =C2=A0 gen_set_addr(addr, cpu_rampX, cpu_r[27], cpu_r[26]);<br>
+}<br>
+<br>
+static void gen_set_yaddr(TCGv addr)<br>
+{<br>
+=C2=A0 =C2=A0 gen_set_addr(addr, cpu_rampY, cpu_r[29], cpu_r[28]);<br>
+}<br>
+<br>
+static void gen_set_zaddr(TCGv addr)<br>
+{<br>
+=C2=A0 =C2=A0 gen_set_addr(addr, cpu_rampZ, cpu_r[31], cpu_r[30]);<br>
+}<br>
+<br>
+static TCGv gen_get_addr(TCGv H, TCGv M, TCGv L)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv addr =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_deposit_tl(addr, M, H, 8, 8);<br>
+=C2=A0 =C2=A0 tcg_gen_deposit_tl(addr, L, addr, 8, 16);<br>
+<br>
+=C2=A0 =C2=A0 return addr;<br>
+}<br>
+<br>
+static TCGv gen_get_xaddr(void)<br>
+{<br>
+=C2=A0 =C2=A0 return gen_get_addr(cpu_rampX, cpu_r[27], cpu_r[26]);<br>
+}<br>
+<br>
+static TCGv gen_get_yaddr(void)<br>
+{<br>
+=C2=A0 =C2=A0 return gen_get_addr(cpu_rampY, cpu_r[29], cpu_r[28]);<br>
+}<br>
+<br>
+static TCGv gen_get_zaddr(void)<br>
+{<br>
+=C2=A0 =C2=A0 return gen_get_addr(cpu_rampZ, cpu_r[31], cpu_r[30]);<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Adds two registers and the contents of the C Flag and places the =
result in<br>
+ *=C2=A0 the destination register Rd.<br>
+ */<br>
+static bool trans_ADC(DisasContext *ctx, arg_ADC *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* op */<br>
+=C2=A0 =C2=A0 tcg_gen_add_tl(R, Rd, Rr); /* R =3D Rd + Rr + Cf */<br>
+=C2=A0 =C2=A0 tcg_gen_add_tl(R, R, cpu_Cf);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */<br>
+<br>
+=C2=A0 =C2=A0 gen_add_CHf(R, Rd, Rr);<br>
+=C2=A0 =C2=A0 gen_add_Vf(R, Rd, Rr);<br>
+=C2=A0 =C2=A0 gen_ZNSf(R);<br>
+<br>
+=C2=A0 =C2=A0 /* R */<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rd, R);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Adds two registers without the C Flag and places the result in th=
e<br>
+ *=C2=A0 destination register Rd.<br>
+ */<br>
+static bool trans_ADD(DisasContext *ctx, arg_ADD *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* op */<br>
+=C2=A0 =C2=A0 tcg_gen_add_tl(R, Rd, Rr); /* Rd =3D Rd + Rr */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */<br>
+<br>
+=C2=A0 =C2=A0 gen_add_CHf(R, Rd, Rr);<br>
+=C2=A0 =C2=A0 gen_add_Vf(R, Rd, Rr);<br>
+=C2=A0 =C2=A0 gen_ZNSf(R);<br>
+<br>
+=C2=A0 =C2=A0 /* R */<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rd, R);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Adds an immediate value (0 - 63) to a register pair and places th=
e result<br>
+ *=C2=A0 in the register pair. This instruction operates on the upper four=
 register<br>
+ *=C2=A0 pairs, and is well suited for operations on the pointer registers=
.=C2=A0 This<br>
+ *=C2=A0 instruction is not available in all devices. Refer to the device =
specific<br>
+ *=C2=A0 instruction set summary.<br>
+ */<br>
+static bool trans_ADIW(DisasContext *ctx, arg_ADIW *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_ADIW_SBIW)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv RdL =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv RdH =3D cpu_r[a-&gt;rd + 1];<br>
+=C2=A0 =C2=A0 int Imm =3D (a-&gt;imm);<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv Rd =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* op */<br>
+=C2=A0 =C2=A0 tcg_gen_deposit_tl(Rd, RdL, RdH, 8, 8); /* Rd =3D RdH:RdL */=
<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(R, Rd, Imm); /* R =3D Rd + Imm */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */<br>
+<br>
+=C2=A0 =C2=A0 /* Cf */<br>
+=C2=A0 =C2=A0 tcg_gen_andc_tl(cpu_Cf, Rd, R); /* Cf =3D Rd &amp; ~R */<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Cf, cpu_Cf, 15);<br>
+<br>
+=C2=A0 =C2=A0 /* Vf */<br>
+=C2=A0 =C2=A0 tcg_gen_andc_tl(cpu_Vf, R, Rd); /* Vf =3D R &amp; ~Rd */<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Vf, cpu_Vf, 15);<br>
+<br>
+=C2=A0 =C2=A0 /* Zf */<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_Zf, R); /* Zf =3D R */<br>
+<br>
+=C2=A0 =C2=A0 /* Nf */<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Nf, R, 15); /* Nf =3D R(15) */<br>
+<br>
+=C2=A0 =C2=A0 /* Sf */<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(cpu_Sf, cpu_Nf, cpu_Vf);/* Sf =3D Nf ^ Vf */<=
br>
+<br>
+=C2=A0 =C2=A0 /* R */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(RdL, R, 0xff);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(RdH, R, 8);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(Rd);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Performs the logical AND between the contents of register Rd and =
register<br>
+ *=C2=A0 Rr and places the result in the destination register Rd.<br>
+ */<br>
+static bool trans_AND(DisasContext *ctx, arg_AND *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* op */<br>
+=C2=A0 =C2=A0 tcg_gen_and_tl(R, Rd, Rr); /* Rd =3D Rd and Rr */<br>
+<br>
+=C2=A0 =C2=A0 /* Vf */<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Vf, 0x00); /* Vf =3D 0 */<br>
+<br>
+=C2=A0 =C2=A0 /* Zf */<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_Zf, R); /* Zf =3D R */<br>
+<br>
+=C2=A0 =C2=A0 gen_ZNSf(R);<br>
+<br>
+=C2=A0 =C2=A0 /* R */<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rd, R);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Performs the logical AND between the contents of register Rd and =
a constant<br>
+ *=C2=A0 and places the result in the destination register Rd.<br>
+ */<br>
+static bool trans_ANDI(DisasContext *ctx, arg_ANDI *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 int Imm =3D (a-&gt;imm);<br>
+<br>
+=C2=A0 =C2=A0 /* op */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(Rd, Rd, Imm); /* Rd =3D Rd &amp; Imm */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Vf, 0x00); /* Vf =3D 0 */<br>
+=C2=A0 =C2=A0 gen_ZNSf(Rd);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Shifts all bits in Rd one place to the right. Bit 7 is held const=
ant. Bit 0<br>
+ *=C2=A0 is loaded into the C Flag of the SREG. This operation effectively=
 divides a<br>
+ *=C2=A0 signed value by two without changing its sign. The Carry Flag can=
 be used to<br>
+ *=C2=A0 round the result.<br>
+ */<br>
+static bool trans_ASR(DisasContext *ctx, arg_ASR *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* Cf */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(cpu_Cf, Rd, 1); /* Cf =3D Rd(0) */<br>
+<br>
+=C2=A0 =C2=A0 /* op */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(t0, Rd, 0x80); /* Rd =3D (Rd &amp; 0x80) | (=
Rd &gt;&gt; 1) */<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(Rd, Rd, 1);<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(Rd, Rd, t0);<br>
+<br>
+=C2=A0 =C2=A0 gen_rshift_ZNVSf(Rd);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Clears a single Flag in SREG.<br>
+ */<br>
+static bool trans_BCLR(DisasContext *ctx, arg_BCLR *a)<br>
+{<br>
+=C2=A0 =C2=A0 switch (a-&gt;bit) {<br>
+=C2=A0 =C2=A0 case 0x00:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Cf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x01:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Zf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x02:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Nf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x03:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Vf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x04:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Sf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x05:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Hf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x06:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Tf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x07:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_If, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Copies the T Flag in the SREG (Status Register) to bit b in regis=
ter Rd.<br>
+ */<br>
+static bool trans_BLD(DisasContext *ctx, arg_BLD *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(Rd, Rd, ~(1u &lt;&lt; a-&gt;bit)); /* clear =
bit */<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(t1, cpu_Tf, a-&gt;bit); /* create mask */<br=
>
+=C2=A0 =C2=A0 tcg_gen_or_tl(Rd, Rd, t1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Conditional relative branch. Tests a single bit in SREG and branc=
hes<br>
+ *=C2=A0 relatively to PC if the bit is cleared. This instruction branches=
 relatively<br>
+ *=C2=A0 to PC in either direction (PC - 63 &lt; =3D destination &lt;=3D P=
C + 64). The<br>
+ *=C2=A0 parameter k is the offset from PC and is represented in two&#39;s=
 complement<br>
+ *=C2=A0 form.<br>
+ */<br>
+static bool trans_BRBC(DisasContext *ctx, arg_BRBC *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGLabel *not_taken =3D gen_new_label();<br>
+=C2=A0 =C2=A0 TCGCond cond =3D TCG_COND_EQ;<br>
+=C2=A0 =C2=A0 TCGv var;<br>
+<br>
+=C2=A0 =C2=A0 switch (a-&gt;bit) {<br>
+=C2=A0 =C2=A0 case 0x00:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Cf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x01:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D TCG_COND_NE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Zf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x02:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Nf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x03:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Vf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x04:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Sf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x05:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Hf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x06:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Tf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x07:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_If;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_brcondi_i32(tcg_<wbr>invert_cond(cond), var, 0, not_=
taken);<br>
+=C2=A0 =C2=A0 gen_goto_tb(ctx, 0, ctx-&gt;npc + a-&gt;imm);<br>
+=C2=A0 =C2=A0 gen_set_label(not_taken);<br>
+<br>
+=C2=A0 =C2=A0 ctx-&gt;bstate =3D DISAS_CHAIN;<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Conditional relative branch. Tests a single bit in SREG and branc=
hes<br>
+ *=C2=A0 relatively to PC if the bit is set. This instruction branches rel=
atively to<br>
+ *=C2=A0 PC in either direction (PC - 63 &lt; =3D destination &lt;=3D PC +=
 64). The parameter k<br>
+ *=C2=A0 is the offset from PC and is represented in two&#39;s complement =
form.<br>
+ */<br>
+static bool trans_BRBS(DisasContext *ctx, arg_BRBS *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGLabel *not_taken =3D gen_new_label();<br>
+=C2=A0 =C2=A0 TCGCond cond =3D TCG_COND_NE;<br>
+=C2=A0 =C2=A0 TCGv var;<br>
+<br>
+=C2=A0 =C2=A0 switch (a-&gt;bit) {<br>
+=C2=A0 =C2=A0 case 0x00:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Cf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x01:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cond =3D TCG_COND_EQ;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Zf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x02:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Nf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x03:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Vf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x04:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Sf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x05:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Hf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x06:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_Tf;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x07:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 var =3D cpu_If;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_brcondi_i32(tcg_<wbr>invert_cond(cond), var, 0, not_=
taken);<br>
+=C2=A0 =C2=A0 gen_goto_tb(ctx, 0, ctx-&gt;npc + a-&gt;imm);<br>
+=C2=A0 =C2=A0 gen_set_label(not_taken);<br>
+<br>
+=C2=A0 =C2=A0 ctx-&gt;bstate =3D DISAS_CHAIN;<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Sets a single Flag or bit in SREG.<br>
+ */<br>
+static bool trans_BSET(DisasContext *ctx, arg_BSET *a)<br>
+{<br>
+=C2=A0 =C2=A0 switch (a-&gt;bit) {<br>
+=C2=A0 =C2=A0 case 0x00:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Cf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x01:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Zf, 0x00);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x02:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Nf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x03:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Vf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x04:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Sf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x05:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Hf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x06:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Tf, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 0x07:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_If, 0x01);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 The BREAK instruction is used by the On-chip Debug system, and is=
<br>
+ *=C2=A0 normally not used in the application software. When the BREAK ins=
truction is<br>
+ *=C2=A0 executed, the AVR CPU is set in the Stopped Mode. This gives the =
On-chip<br>
+ *=C2=A0 Debugger access to internal resources.=C2=A0 If any Lock bits are=
 set, or either<br>
+ *=C2=A0 the JTAGEN or OCDEN Fuses are unprogrammed, the CPU will treat th=
e BREAK<br>
+ *=C2=A0 instruction as a NOP and will not enter the Stopped mode.=C2=A0 T=
his instruction<br>
+ *=C2=A0 is not available in all devices. Refer to the device specific ins=
truction<br>
+ *=C2=A0 set summary.<br>
+ */<br>
+static bool trans_BREAK(DisasContext *ctx, arg_BREAK *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_BREAK)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+#ifdef BREAKPOINT_ON_BREAK<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_pc, ctx-&gt;npc - 1);<br>
+=C2=A0 =C2=A0 gen_helper_debug(cpu_env);<br>
+=C2=A0 =C2=A0 ctx-&gt;bstate =3D DISAS_EXIT;<br>
+#else<br>
+=C2=A0 =C2=A0 /* NOP */<br>
+#endif<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Stores bit b from Rd to the T Flag in SREG (Status Register).<br>
+ */<br>
+static bool trans_BST(DisasContext *ctx, arg_BST *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(cpu_Tf, Rd, 1 &lt;&lt; a-&gt;bit);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Tf, cpu_Tf, a-&gt;bit);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Calls to a subroutine within the entire Program memory. The retur=
n<br>
+ *=C2=A0 address (to the instruction after the CALL) will be stored onto t=
he Stack.<br>
+ *=C2=A0 (See also RCALL). The Stack Pointer uses a post-decrement scheme =
during<br>
+ *=C2=A0 CALL.=C2=A0 This instruction is not available in all devices. Ref=
er to the device<br>
+ *=C2=A0 specific instruction set summary.<br>
+ */<br>
+static bool trans_CALL(DisasContext *ctx, arg_CALL *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_JMP_CALL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 int Imm =3D a-&gt;imm;<br>
+=C2=A0 =C2=A0 int ret =3D ctx-&gt;npc;<br>
+<br>
+=C2=A0 =C2=A0 gen_push_ret(ctx, ret);<br>
+=C2=A0 =C2=A0 gen_goto_tb(ctx, 0, Imm);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Clears a specified bit in an I/O Register. This instruction opera=
tes on<br>
+ *=C2=A0 the lower 32 I/O Registers -- addresses 0-31.<br>
+ */<br>
+static bool trans_CBI(DisasContext *ctx, arg_CBI *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv data =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv port =3D tcg_const_i32(a-&gt;reg);<br>
+<br>
+=C2=A0 =C2=A0 gen_helper_inb(data, cpu_env, port);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(data, data, ~(1 &lt;&lt; a-&gt;bit));<br>
+=C2=A0 =C2=A0 gen_helper_outb(cpu_env, port, data);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(data);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(port);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Clears the specified bits in register Rd. Performs the logical AN=
D<br>
+ *=C2=A0 between the contents of register Rd and the complement of the con=
stant mask<br>
+ *=C2=A0 K. The result will be placed in register Rd.<br>
+ */<br>
+static bool trans_COM(DisasContext *ctx, arg_COM *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_xori_tl(Rd, Rd, 0xff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Cf, 1); /* Cf =3D 1 */<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Vf, 0); /* Vf =3D 0 */<br>
+=C2=A0 =C2=A0 gen_ZNSf(Rd);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction performs a compare between two registers Rd and =
Rr.<br>
+ *=C2=A0 None of the registers are changed. All conditional branches can b=
e used<br>
+ *=C2=A0 after this instruction.<br>
+ */<br>
+static bool trans_CP(DisasContext *ctx, arg_CP *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* op */<br>
+=C2=A0 =C2=A0 tcg_gen_sub_tl(R, Rd, Rr); /* R =3D Rd - Rr */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */<br>
+<br>
+=C2=A0 =C2=A0 gen_sub_CHf(R, Rd, Rr);<br>
+=C2=A0 =C2=A0 gen_sub_Vf(R, Rd, Rr);<br>
+=C2=A0 =C2=A0 gen_ZNSf(R);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction performs a compare between two registers Rd and =
Rr and<br>
+ *=C2=A0 also takes into account the previous carry. None of the registers=
 are<br>
+ *=C2=A0 changed. All conditional branches can be used after this instruct=
ion.<br>
+ */<br>
+static bool trans_CPC(DisasContext *ctx, arg_CPC *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* op */<br>
+=C2=A0 =C2=A0 tcg_gen_sub_tl(R, Rd, Rr); /* R =3D Rd - Rr - Cf */<br>
+=C2=A0 =C2=A0 tcg_gen_sub_tl(R, R, cpu_Cf);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */<br>
+<br>
+=C2=A0 =C2=A0 gen_sub_CHf(R, Rd, Rr);<br>
+=C2=A0 =C2=A0 gen_sub_Vf(R, Rd, Rr);<br>
+=C2=A0 =C2=A0 gen_NSf(R);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Previous value remains unchanged when the result is =
zero;<br>
+=C2=A0 =C2=A0 =C2=A0* cleared otherwise.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(cpu_Zf, cpu_Zf, R);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction performs a compare between register Rd and a con=
stant.<br>
+ *=C2=A0 The register is not changed. All conditional branches can be used=
 after this<br>
+ *=C2=A0 instruction.<br>
+ */<br>
+static bool trans_CPI(DisasContext *ctx, arg_CPI *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 int Imm =3D a-&gt;imm;<br>
+=C2=A0 =C2=A0 TCGv Rr =3D tcg_const_i32(Imm);<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* op */<br>
+=C2=A0 =C2=A0 tcg_gen_sub_tl(R, Rd, Rr); /* R =3D Rd - Rr */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */<br>
+<br>
+=C2=A0 =C2=A0 gen_sub_CHf(R, Rd, Rr);<br>
+=C2=A0 =C2=A0 gen_sub_Vf(R, Rd, Rr);<br>
+=C2=A0 =C2=A0 gen_ZNSf(R);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(Rr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction performs a compare between two registers Rd and =
Rr, and<br>
+ *=C2=A0 skips the next instruction if Rd =3D Rr.<br>
+ */<br>
+static bool trans_CPSE(DisasContext *ctx, arg_CPSE *a)<br>
+{<br>
+=C2=A0 =C2=A0 ctx-&gt;skip_cond =3D TCG_COND_EQ;<br>
+=C2=A0 =C2=A0 ctx-&gt;skip_var0 =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 ctx-&gt;skip_var1 =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Subtracts one -1- from the contents of register Rd and places the=
 result<br>
+ *=C2=A0 in the destination register Rd.=C2=A0 The C Flag in SREG is not a=
ffected by the<br>
+ *=C2=A0 operation, thus allowing the DEC instruction to be used on a loop=
 counter in<br>
+ *=C2=A0 multiple-precision computations.=C2=A0 When operating on unsigned=
 values, only<br>
+ *=C2=A0 BREQ and BRNE branches can be expected to perform consistently.=
=C2=A0 When<br>
+ *=C2=A0 operating on two&#39;s complement values, all signed branches are=
 available.<br>
+ */<br>
+static bool trans_DEC(DisasContext *ctx, arg_DEC *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_subi_tl(Rd, Rd, 1); /* Rd =3D Rd - 1 */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(Rd, Rd, 0xff); /* make it 8 bits */<br>
+<br>
+=C2=A0 =C2=A0 /* cpu_Vf =3D Rd =3D=3D 0x7f */<br>
+=C2=A0 =C2=A0 tcg_gen_setcondi_tl(TCG_COND_<wbr>EQ, cpu_Vf, Rd, 0x7f);<br>
+=C2=A0 =C2=A0 gen_ZNSf(Rd);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 The module is an instruction set extension to the AVR CPU, perfor=
ming<br>
+ *=C2=A0 DES iterations. The 64-bit data block (plaintext or ciphertext) i=
s placed in<br>
+ *=C2=A0 the CPU register file, registers R0-R7, where LSB of data is plac=
ed in LSB<br>
+ *=C2=A0 of R0 and MSB of data is placed in MSB of R7. The full 64-bit key=
 (including<br>
+ *=C2=A0 parity bits) is placed in registers R8- R15, organized in the reg=
ister file<br>
+ *=C2=A0 with LSB of key in LSB of R8 and MSB of key in MSB of R15. Execut=
ing one DES<br>
+ *=C2=A0 instruction performs one round in the DES algorithm. Sixteen roun=
ds must be<br>
+ *=C2=A0 executed in increasing order to form the correct DES ciphertext o=
r<br>
+ *=C2=A0 plaintext. Intermediate results are stored in the register file (=
R0-R15)<br>
+ *=C2=A0 after each DES instruction. The instruction&#39;s operand (K) det=
ermines which<br>
+ *=C2=A0 round is executed, and the half carry flag (H) determines whether=
 encryption<br>
+ *=C2=A0 or decryption is performed.=C2=A0 The DES algorithm is described =
in<br>
+ *=C2=A0 &quot;Specifications for the Data Encryption Standard&quot; (Fede=
ral Information<br>
+ *=C2=A0 Processing Standards Publication 46). Intermediate results in thi=
s<br>
+ *=C2=A0 implementation differ from the standard because the initial permu=
tation and<br>
+ *=C2=A0 the inverse initial permutation are performed each iteration. Thi=
s does not<br>
+ *=C2=A0 affect the result in the final ciphertext or plaintext, but reduc=
es<br>
+ *=C2=A0 execution time.<br>
+ */<br>
+static bool trans_DES(DisasContext *ctx, arg_DES *a)<br>
+{<br>
+=C2=A0 =C2=A0 /* TODO */<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_DES)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Indirect call of a subroutine pointed to by the Z (16 bits) Point=
er<br>
+ *=C2=A0 Register in the Register File and the EIND Register in the I/O sp=
ace. This<br>
+ *=C2=A0 instruction allows for indirect calls to the entire 4M (words) Pr=
ogram<br>
+ *=C2=A0 memory space. See also ICALL. The Stack Pointer uses a post-decre=
ment scheme<br>
+ *=C2=A0 during EICALL.=C2=A0 This instruction is not available in all dev=
ices. Refer to<br>
+ *=C2=A0 the device specific instruction set summary.<br>
+ */<br>
+static bool trans_EICALL(DisasContext *ctx, arg_EICALL *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_EIJMP_EICALL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 int ret =3D ctx-&gt;npc;<br>
+<br>
+=C2=A0 =C2=A0 gen_push_ret(ctx, ret);<br>
+=C2=A0 =C2=A0 gen_jmp_ez(ctx);<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Indirect jump to the address pointed to by the Z (16 bits) Pointe=
r<br>
+ *=C2=A0 Register in the Register File and the EIND Register in the I/O sp=
ace. This<br>
+ *=C2=A0 instruction allows for indirect jumps to the entire 4M (words) Pr=
ogram<br>
+ *=C2=A0 memory space. See also IJMP.=C2=A0 This instruction is not availa=
ble in all<br>
+ *=C2=A0 devices. Refer to the device specific instruction set summary.<br=
>
+ */<br>
+static bool trans_EIJMP(DisasContext *ctx, arg_EIJMP *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_EIJMP_EICALL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 gen_jmp_ez(ctx);<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Loads one byte pointed to by the Z-register and the RAMPZ Registe=
r in<br>
+ *=C2=A0 the I/O space, and places this byte in the destination register R=
d. This<br>
+ *=C2=A0 instruction features a 100% space effective constant initializati=
on or<br>
+ *=C2=A0 constant data fetch. The Program memory is organized in 16-bit wo=
rds while<br>
+ *=C2=A0 the Z-pointer is a byte address. Thus, the least significant bit =
of the<br>
+ *=C2=A0 Z-pointer selects either low byte (ZLSB =3D 0) or high byte (ZLSB=
 =3D 1). This<br>
+ *=C2=A0 instruction can address the entire Program memory space. The Z-po=
inter<br>
+ *=C2=A0 Register can either be left unchanged by the operation, or it can=
 be<br>
+ *=C2=A0 incremented. The incrementation applies to the entire 24-bit conc=
atenation<br>
+ *=C2=A0 of the RAMPZ and Z-pointer Registers.=C2=A0 Devices with Self-Pro=
gramming<br>
+ *=C2=A0 capability can use the ELPM instruction to read the Fuse and Lock=
 bit value.<br>
+ *=C2=A0 Refer to the device documentation for a detailed description.=C2=
=A0 This<br>
+ *=C2=A0 instruction is not available in all devices. Refer to the device =
specific<br>
+ *=C2=A0 instruction set summary.<br>
+ */<br>
+static bool trans_ELPM1(DisasContext *ctx, arg_ELPM1 *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[0];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[add=
r] */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_ELPM2(DisasContext *ctx, arg_ELPM2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_ELPM)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[add=
r] */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_ELPMX(DisasContext *ctx, arg_ELPMX *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_ELPMX)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[add=
r] */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+<br>
+=C2=A0 =C2=A0 gen_set_zaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Performs the logical EOR between the contents of register Rd and<=
br>
+ *=C2=A0 register Rr and places the result in the destination register Rd.=
<br>
+ */<br>
+static bool trans_EOR(DisasContext *ctx, arg_EOR *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(Rd, Rd, Rr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Vf, 0);<br>
+=C2=A0 =C2=A0 gen_ZNSf(Rd);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction performs 8-bit x 8-bit -&gt; 16-bit unsigned<br>
+ *=C2=A0 multiplication and shifts the result one bit left.<br>
+ */<br>
+static bool trans_FMUL(DisasContext *ctx, arg_FMUL *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv R0 =3D cpu_r[0];<br>
+=C2=A0 =C2=A0 TCGv R1 =3D cpu_r[1];<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mul_tl(R, Rd, Rr); /* R =3D Rd *Rr */<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(R, R, 1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R0, R, 0xff);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(R1, R, 8);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R1, R1, 0xff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf =3D R(16) */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(cpu_Zf, R, 0x0000ffff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction performs 8-bit x 8-bit -&gt; 16-bit signed multi=
plication<br>
+ *=C2=A0 and shifts the result one bit left.<br>
+ */<br>
+static bool trans_FMULS(DisasContext *ctx, arg_FMULS *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv R0 =3D cpu_r[0];<br>
+=C2=A0 =C2=A0 TCGv R1 =3D cpu_r[1];<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */<b=
r>
+=C2=A0 =C2=A0 tcg_gen_ext8s_tl(t1, Rr); /* make Rr full 32 bit signed */<b=
r>
+=C2=A0 =C2=A0 tcg_gen_mul_tl(R, t0, t1); /* R =3D Rd *Rr */<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(R, R, 1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R0, R, 0xff);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(R1, R, 8);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R1, R1, 0xff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf =3D R(16) */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(cpu_Zf, R, 0x0000ffff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction performs 8-bit x 8-bit -&gt; 16-bit signed multi=
plication<br>
+ *=C2=A0 and shifts the result one bit left.<br>
+ */<br>
+static bool trans_FMULSU(DisasContext *ctx, arg_FMULSU *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv R0 =3D cpu_r[0];<br>
+=C2=A0 =C2=A0 TCGv R1 =3D cpu_r[1];<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */<b=
r>
+=C2=A0 =C2=A0 tcg_gen_mul_tl(R, t0, Rr); /* R =3D Rd *Rr */<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(R, R, 1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R0, R, 0xff);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(R1, R, 8);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R1, R1, 0xff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf =3D R(16) */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(cpu_Zf, R, 0x0000ffff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Calls to a subroutine within the entire 4M (words) Program memory=
. The<br>
+ *=C2=A0 return address (to the instruction after the CALL) will be stored=
 onto the<br>
+ *=C2=A0 Stack. See also RCALL. The Stack Pointer uses a post-decrement sc=
heme during<br>
+ *=C2=A0 CALL.=C2=A0 This instruction is not available in all devices. Ref=
er to the device<br>
+ *=C2=A0 specific instruction set summary.<br>
+ */<br>
+static bool trans_ICALL(DisasContext *ctx, arg_ICALL *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_IJMP_ICALL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 int ret =3D ctx-&gt;npc;<br>
+<br>
+=C2=A0 =C2=A0 gen_push_ret(ctx, ret);<br>
+=C2=A0 =C2=A0 gen_jmp_z(ctx);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Indirect jump to the address pointed to by the Z (16 bits) Pointe=
r<br>
+ *=C2=A0 Register in the Register File. The Z-pointer Register is 16 bits =
wide and<br>
+ *=C2=A0 allows jump within the lowest 64K words (128KB) section of Progra=
m memory.<br>
+ *=C2=A0 This instruction is not available in all devices. Refer to the de=
vice<br>
+ *=C2=A0 specific instruction set summary.<br>
+ */<br>
+static bool trans_IJMP(DisasContext *ctx, arg_IJMP *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_IJMP_ICALL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 gen_jmp_z(ctx);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Loads data from the I/O Space (Ports, Timers, Configuration Regis=
ters,<br>
+ *=C2=A0 etc.) into register Rd in the Register File.<br>
+ */<br>
+static bool trans_IN(DisasContext *ctx, arg_IN *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv port =3D tcg_const_i32(a-&gt;imm);<br>
+<br>
+=C2=A0 =C2=A0 gen_helper_inb(Rd, cpu_env, port);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(port);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Adds one -1- to the contents of register Rd and places the result=
 in the<br>
+ *=C2=A0 destination register Rd.=C2=A0 The C Flag in SREG is not affected=
 by the<br>
+ *=C2=A0 operation, thus allowing the INC instruction to be used on a loop=
 counter in<br>
+ *=C2=A0 multiple-precision computations.=C2=A0 When operating on unsigned=
 numbers, only<br>
+ *=C2=A0 BREQ and BRNE branches can be expected to perform consistently. W=
hen<br>
+ *=C2=A0 operating on two&#39;s complement values, all signed branches are=
 available.<br>
+ */<br>
+static bool trans_INC(DisasContext *ctx, arg_INC *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(Rd, Rd, 1);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(Rd, Rd, 0xff);<br>
+<br>
+=C2=A0 =C2=A0 /* cpu_Vf =3D Rd =3D=3D 0x80 */<br>
+=C2=A0 =C2=A0 tcg_gen_setcondi_tl(TCG_COND_<wbr>EQ, cpu_Vf, Rd, 0x80);<br>
+=C2=A0 =C2=A0 gen_ZNSf(Rd);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Jump to an address within the entire 4M (words) Program memory. S=
ee also<br>
+ *=C2=A0 RJMP.=C2=A0 This instruction is not available in all devices. Ref=
er to the device<br>
+ *=C2=A0 specific instruction set summary.0<br>
+ */<br>
+static bool trans_JMP(DisasContext *ctx, arg_JMP *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_JMP_CALL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 gen_goto_tb(ctx, 0, a-&gt;imm);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Load one byte indirect from data space to register and stores an =
clear<br>
+ *=C2=A0 the bits in data space specified by the register. The instruction=
 can only<br>
+ *=C2=A0 be used towards internal SRAM.=C2=A0 The data location is pointed=
 to by the Z (16<br>
+ *=C2=A0 bits) Pointer Register in the Register File. Memory access is lim=
ited to the<br>
+ *=C2=A0 current data segment of 64KB. To access another data segment in d=
evices with<br>
+ *=C2=A0 more than 64KB data space, the RAMPZ in register in the I/O area =
has to be<br>
+ *=C2=A0 changed.=C2=A0 The Z-pointer Register is left unchanged by the op=
eration. This<br>
+ *=C2=A0 instruction is especially suited for clearing status bits stored =
in SRAM.<br>
+ */<br>
+static void gen_data_store(DisasContext *ctx, TCGv data, TCGv addr)<br>
+{<br>
+=C2=A0 =C2=A0 if (ctx-&gt;tb-&gt;flags &amp; TB_FLAGS_FULL_ACCESS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_fullwr(cpu_env, data, addr);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_qemu_st8(data, addr, MMU_DATA_IDX); /*=
 mem[addr] =3D data */<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void gen_data_load(DisasContext *ctx, TCGv data, TCGv addr)<br>
+{<br>
+=C2=A0 =C2=A0 if (ctx-&gt;tb-&gt;flags &amp; TB_FLAGS_FULL_ACCESS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_helper_fullrd(data, cpu_env, addr);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_qemu_ld8u(data, addr, MMU_DATA_IDX); /=
* data =3D mem[addr] */<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static bool trans_LAC(DisasContext *ctx, arg_LAC *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, t0, addr); /* t0 =3D mem[addr] */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* t1 =3D t0 &amp; (0xff - Rr) =3D t0 and ~Rr =
*/<br>
+=C2=A0 =C2=A0 tcg_gen_andc_tl(t1, t0, Rr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rr, t0); /* Rr =3D t0 */<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, t1, addr); /* mem[addr] =3D t1 */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Load one byte indirect from data space to register and set bits i=
n data<br>
+ *=C2=A0 space specified by the register. The instruction can only be used=
 towards<br>
+ *=C2=A0 internal SRAM.=C2=A0 The data location is pointed to by the Z (16=
 bits) Pointer<br>
+ *=C2=A0 Register in the Register File. Memory access is limited to the cu=
rrent data<br>
+ *=C2=A0 segment of 64KB. To access another data segment in devices with m=
ore than<br>
+ *=C2=A0 64KB data space, the RAMPZ in register in the I/O area has to be =
changed.<br>
+ *=C2=A0 The Z-pointer Register is left unchanged by the operation. This i=
nstruction<br>
+ *=C2=A0 is especially suited for setting status bits stored in SRAM.<br>
+ */<br>
+static bool trans_LAS(DisasContext *ctx, arg_LAS *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, t0, addr); /* t0 =3D mem[addr] */<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(t1, t0, Rr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rr, t0); /* Rr =3D t0 */<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, t1, addr); /* mem[addr] =3D t1 */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Load one byte indirect from data space to register and toggles bi=
ts in<br>
+ *=C2=A0 the data space specified by the register.=C2=A0 The instruction c=
an only be used<br>
+ *=C2=A0 towards SRAM.=C2=A0 The data location is pointed to by the Z (16 =
bits) Pointer<br>
+ *=C2=A0 Register in the Register File. Memory access is limited to the cu=
rrent data<br>
+ *=C2=A0 segment of 64KB. To access another data segment in devices with m=
ore than<br>
+ *=C2=A0 64KB data space, the RAMPZ in register in the I/O area has to be =
changed.<br>
+ *=C2=A0 The Z-pointer Register is left unchanged by the operation. This i=
nstruction<br>
+ *=C2=A0 is especially suited for changing status bits stored in SRAM.<br>
+ */<br>
+static bool trans_LAT(DisasContext *ctx, arg_LAT *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_RMW)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, t0, addr); /* t0 =3D mem[addr] */<br>
+=C2=A0 =C2=A0 tcg_gen_xor_tl(t1, t0, Rd);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rd, t0); /* Rd =3D t0 */<br>
+=C2=A0 =C2=A0 gen_data_store(ctx, t1, addr); /* mem[addr] =3D t1 */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Loads one byte indirect from the data space to a register. For pa=
rts<br>
+ *=C2=A0 with SRAM, the data space consists of the Register File, I/O memo=
ry and<br>
+ *=C2=A0 internal SRAM (and external SRAM if applicable). For parts withou=
t SRAM, the<br>
+ *=C2=A0 data space consists of the Register File only. In some parts the =
Flash<br>
+ *=C2=A0 Memory has been mapped to the data space and can be read using th=
is command.<br>
+ *=C2=A0 The EEPROM has a separate address space.=C2=A0 The data location =
is pointed to by<br>
+ *=C2=A0 the X (16 bits) Pointer Register in the Register File. Memory acc=
ess is<br>
+ *=C2=A0 limited to the current data segment of 64KB. To access another da=
ta segment<br>
+ *=C2=A0 in devices with more than 64KB data space, the RAMPX in register =
in the I/O<br>
+ *=C2=A0 area has to be changed.=C2=A0 The X-pointer Register can either b=
e left unchanged<br>
+ *=C2=A0 by the operation, or it can be post-incremented or predecremented=
.=C2=A0 These<br>
+ *=C2=A0 features are especially suited for accessing arrays, tables, and =
Stack<br>
+ *=C2=A0 Pointer usage of the X-pointer Register. Note that only the low b=
yte of the<br>
+ *=C2=A0 X-pointer is updated in devices with no more than 256 bytes data =
space. For<br>
+ *=C2=A0 such devices, the high byte of the pointer is not used by this in=
struction<br>
+ *=C2=A0 and can be used for other purposes. The RAMPX Register in the I/O=
 area is<br>
+ *=C2=A0 updated in parts with more than 64KB data space or more than 64KB=
 Program<br>
+ *=C2=A0 memory, and the increment/decrement is added to the entire 24-bit=
 address on<br>
+ *=C2=A0 such devices.=C2=A0 Not all variants of this instruction is avail=
able in all<br>
+ *=C2=A0 devices. Refer to the device specific instruction set summary.=C2=
=A0 In the<br>
+ *=C2=A0 Reduced Core tinyAVR the LD instruction can be used to achieve th=
e same<br>
+ *=C2=A0 operation as LPM since the program memory is mapped to the data m=
emory<br>
+ *=C2=A0 space.<br>
+ */<br>
+static bool trans_LDX1(DisasContext *ctx, arg_LDX1 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_xaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_LDX2(DisasContext *ctx, arg_LDX2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_xaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+<br>
+=C2=A0 =C2=A0 gen_set_xaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_LDX3(DisasContext *ctx, arg_LDX3 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_xaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 gen_set_xaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Loads one byte indirect with or without displacement from the dat=
a space<br>
+ *=C2=A0 to a register. For parts with SRAM, the data space consists of th=
e Register<br>
+ *=C2=A0 File, I/O memory and internal SRAM (and external SRAM if applicab=
le). For<br>
+ *=C2=A0 parts without SRAM, the data space consists of the Register File =
only. In<br>
+ *=C2=A0 some parts the Flash Memory has been mapped to the data space and=
 can be<br>
+ *=C2=A0 read using this command. The EEPROM has a separate address space.=
=C2=A0 The data<br>
+ *=C2=A0 location is pointed to by the Y (16 bits) Pointer Register in the=
 Register<br>
+ *=C2=A0 File. Memory access is limited to the current data segment of 64K=
B. To<br>
+ *=C2=A0 access another data segment in devices with more than 64KB data s=
pace, the<br>
+ *=C2=A0 RAMPY in register in the I/O area has to be changed.=C2=A0 The Y-=
pointer Register<br>
+ *=C2=A0 can either be left unchanged by the operation, or it can be post-=
incremented<br>
+ *=C2=A0 or predecremented.=C2=A0 These features are especially suited for=
 accessing<br>
+ *=C2=A0 arrays, tables, and Stack Pointer usage of the Y-pointer Register=
. Note that<br>
+ *=C2=A0 only the low byte of the Y-pointer is updated in devices with no =
more than<br>
+ *=C2=A0 256 bytes data space. For such devices, the high byte of the poin=
ter is not<br>
+ *=C2=A0 used by this instruction and can be used for other purposes. The =
RAMPY<br>
+ *=C2=A0 Register in the I/O area is updated in parts with more than 64KB =
data space<br>
+ *=C2=A0 or more than 64KB Program memory, and the increment/decrement/<wb=
r>displacement<br>
+ *=C2=A0 is added to the entire 24-bit address on such devices.=C2=A0 Not =
all variants of<br>
+ *=C2=A0 this instruction is available in all devices. Refer to the device=
 specific<br>
+ *=C2=A0 instruction set summary.=C2=A0 In the Reduced Core tinyAVR the LD=
 instruction can<br>
+ *=C2=A0 be used to achieve the same operation as LPM since the program me=
mory is<br>
+ *=C2=A0 mapped to the data memory space.<br>
+ */<br>
+static bool trans_LDY2(DisasContext *ctx, arg_LDY2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_yaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+<br>
+=C2=A0 =C2=A0 gen_set_yaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_LDY3(DisasContext *ctx, arg_LDY3 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_yaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 gen_set_yaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_LDDY(DisasContext *ctx, arg_LDDY *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_yaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, a-&gt;imm); /* addr =3D addr + q=
 */<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Loads one byte indirect with or without displacement from the dat=
a space<br>
+ *=C2=A0 to a register. For parts with SRAM, the data space consists of th=
e Register<br>
+ *=C2=A0 File, I/O memory and internal SRAM (and external SRAM if applicab=
le). For<br>
+ *=C2=A0 parts without SRAM, the data space consists of the Register File =
only. In<br>
+ *=C2=A0 some parts the Flash Memory has been mapped to the data space and=
 can be<br>
+ *=C2=A0 read using this command. The EEPROM has a separate address space.=
=C2=A0 The data<br>
+ *=C2=A0 location is pointed to by the Z (16 bits) Pointer Register in the=
 Register<br>
+ *=C2=A0 File. Memory access is limited to the current data segment of 64K=
B. To<br>
+ *=C2=A0 access another data segment in devices with more than 64KB data s=
pace, the<br>
+ *=C2=A0 RAMPZ in register in the I/O area has to be changed.=C2=A0 The Z-=
pointer Register<br>
+ *=C2=A0 can either be left unchanged by the operation, or it can be post-=
incremented<br>
+ *=C2=A0 or predecremented.=C2=A0 These features are especially suited for=
 Stack Pointer<br>
+ *=C2=A0 usage of the Z-pointer Register, however because the Z-pointer Re=
gister can<br>
+ *=C2=A0 be used for indirect subroutine calls, indirect jumps and table l=
ookup, it<br>
+ *=C2=A0 is often more convenient to use the X or Y-pointer as a dedicated=
 Stack<br>
+ *=C2=A0 Pointer. Note that only the low byte of the Z-pointer is updated =
in devices<br>
+ *=C2=A0 with no more than 256 bytes data space. For such devices, the hig=
h byte of<br>
+ *=C2=A0 the pointer is not used by this instruction and can be used for o=
ther<br>
+ *=C2=A0 purposes. The RAMPZ Register in the I/O area is updated in parts =
with more<br>
+ *=C2=A0 than 64KB data space or more than 64KB Program memory, and the<br=
>
+ *=C2=A0 increment/decrement/<wbr>displacement is added to the entire 24-b=
it address on<br>
+ *=C2=A0 such devices.=C2=A0 Not all variants of this instruction is avail=
able in all<br>
+ *=C2=A0 devices. Refer to the device specific instruction set summary.=C2=
=A0 In the<br>
+ *=C2=A0 Reduced Core tinyAVR the LD instruction can be used to achieve th=
e same<br>
+ *=C2=A0 operation as LPM since the program memory is mapped to the data m=
emory<br>
+ *=C2=A0 space.=C2=A0 For using the Z-pointer for table lookup in Program =
memory see the<br>
+ *=C2=A0 LPM and ELPM instructions.<br>
+ */<br>
+static bool trans_LDZ2(DisasContext *ctx, arg_LDZ2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+<br>
+=C2=A0 =C2=A0 gen_set_zaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_LDZ3(DisasContext *ctx, arg_LDZ3 *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_subi_tl(addr, addr, 1); /* addr =3D addr - 1 */<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 gen_set_zaddr(addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_LDDZ(DisasContext *ctx, arg_LDDZ *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D gen_get_zaddr();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, a-&gt;imm); /* addr =3D addr + q=
 */<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ * Loads an 8 bit constant directly to register 16 to 31.<br>
+ */<br>
+static bool trans_LDI(DisasContext *ctx, arg_LDI *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 int imm =3D a-&gt;imm;<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(Rd, imm);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Loads one byte from the data space to a register. For parts with =
SRAM,<br>
+ *=C2=A0 the data space consists of the Register File, I/O memory and inte=
rnal SRAM<br>
+ *=C2=A0 (and external SRAM if applicable). For parts without SRAM, the da=
ta space<br>
+ *=C2=A0 consists of the register file only. The EEPROM has a separate add=
ress space.<br>
+ *=C2=A0 A 16-bit address must be supplied. Memory access is limited to th=
e current<br>
+ *=C2=A0 data segment of 64KB. The LDS instruction uses the RAMPD Register=
 to access<br>
+ *=C2=A0 memory above 64KB. To access another data segment in devices with=
 more than<br>
+ *=C2=A0 64KB data space, the RAMPD in register in the I/O area has to be =
changed.<br>
+ *=C2=A0 This instruction is not available in all devices. Refer to the de=
vice<br>
+ *=C2=A0 specific instruction set summary.<br>
+ */<br>
+static bool trans_LDS(DisasContext *ctx, arg_LDS *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv H =3D cpu_rampD;<br>
+=C2=A0 =C2=A0 a-&gt;imm =3D next_word(ctx);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(addr, H); /* addr =3D H:M:L */<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(addr, addr, 16);<br>
+=C2=A0 =C2=A0 tcg_gen_ori_tl(addr, addr, a-&gt;imm);<br>
+<br>
+=C2=A0 =C2=A0 gen_data_load(ctx, Rd, addr);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Loads one byte pointed to by the Z-register into the destination<=
br>
+ *=C2=A0 register Rd. This instruction features a 100% space effective con=
stant<br>
+ *=C2=A0 initialization or constant data fetch. The Program memory is orga=
nized in<br>
+ *=C2=A0 16-bit words while the Z-pointer is a byte address. Thus, the lea=
st<br>
+ *=C2=A0 significant bit of the Z-pointer selects either low byte (ZLSB =
=3D 0) or high<br>
+ *=C2=A0 byte (ZLSB =3D 1). This instruction can address the first 64KB (3=
2K words) of<br>
+ *=C2=A0 Program memory. The Zpointer Register can either be left unchange=
d by the<br>
+ *=C2=A0 operation, or it can be incremented. The incrementation does not =
apply to<br>
+ *=C2=A0 the RAMPZ Register.=C2=A0 Devices with Self-Programming capabilit=
y can use the<br>
+ *=C2=A0 LPM instruction to read the Fuse and Lock bit values.=C2=A0 Refer=
 to the device<br>
+ *=C2=A0 documentation for a detailed description.=C2=A0 The LPM instructi=
on is not<br>
+ *=C2=A0 available in all devices. Refer to the device specific instructio=
n set<br>
+ *=C2=A0 summary<br>
+ */<br>
+static bool trans_LPM1(DisasContext *ctx, arg_LPM1 *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[0];<br>
+=C2=A0 =C2=A0 TCGv addr =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv H =3D cpu_r[31];<br>
+=C2=A0 =C2=A0 TCGv L =3D cpu_r[30];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(addr, H, 8); /* addr =3D H:L */<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(addr, addr, L);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[add=
r] */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_LPM2(DisasContext *ctx, arg_LPM2 *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_LPM)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv H =3D cpu_r[31];<br>
+=C2=A0 =C2=A0 TCGv L =3D cpu_r[30];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(addr, H, 8); /* addr =3D H:L */<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(addr, addr, L);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[add=
r] */<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static bool trans_LPMX(DisasContext *ctx, arg_LPMX *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_LPMX)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv addr =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv H =3D cpu_r[31];<br>
+=C2=A0 =C2=A0 TCGv L =3D cpu_r[30];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(addr, H, 8); /* addr =3D H:L */<br>
+=C2=A0 =C2=A0 tcg_gen_or_tl(addr, addr, L);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_qemu_ld8u(Rd, addr, MMU_CODE_IDX); /* Rd =3D mem[add=
r] */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_addi_tl(addr, addr, 1); /* addr =3D addr + 1 */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(L, addr, 0xff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(addr, addr, 8);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(H, addr, 0xff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(addr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Shifts all bits in Rd one place to the right. Bit 7 is cleared. B=
it 0 is<br>
+ *=C2=A0 loaded into the C Flag of the SREG. This operation effectively di=
vides an<br>
+ *=C2=A0 unsigned value by two. The C Flag can be used to round the result=
.<br>
+ */<br>
+static bool trans_LSR(DisasContext *ctx, arg_LSR *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(cpu_Cf, Rd, 1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(Rd, Rd, 1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_Zf, Rd);<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Nf, 0);<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_Vf, cpu_Cf);<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_Sf, cpu_Vf);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction makes a copy of one register into another. The s=
ource<br>
+ *=C2=A0 register Rr is left unchanged, while the destination register Rd =
is loaded<br>
+ *=C2=A0 with a copy of Rr.<br>
+ */<br>
+static bool trans_MOV(DisasContext *ctx, arg_MOV *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rd, Rr);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction makes a copy of one register pair into another r=
egister<br>
+ *=C2=A0 pair. The source register pair Rr+1:Rr is left unchanged, while t=
he<br>
+ *=C2=A0 destination register pair Rd+1:Rd is loaded with a copy of Rr + 1=
:Rr.=C2=A0 This<br>
+ *=C2=A0 instruction is not available in all devices. Refer to the device =
specific<br>
+ *=C2=A0 instruction set summary.<br>
+ */<br>
+static bool trans_MOVW(DisasContext *ctx, arg_MOVW *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_MOVW)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv RdL =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv RdH =3D cpu_r[a-&gt;rd + 1];<br>
+=C2=A0 =C2=A0 TCGv RrL =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv RrH =3D cpu_r[a-&gt;rr + 1];<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(RdH, RrH);<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(RdL, RrL);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction performs 8-bit x 8-bit -&gt; 16-bit unsigned mul=
tiplication.<br>
+ */<br>
+static bool trans_MUL(DisasContext *ctx, arg_MUL *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv R0 =3D cpu_r[0];<br>
+=C2=A0 =C2=A0 TCGv R1 =3D cpu_r[1];<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_mul_tl(R, Rd, Rr); /* R =3D Rd *Rr */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R0, R, 0xff);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(R1, R, 8);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf =3D R(16) */<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_Zf, R);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction performs 8-bit x 8-bit -&gt; 16-bit signed multi=
plication.<br>
+ */<br>
+static bool trans_MULS(DisasContext *ctx, arg_MULS *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv R0 =3D cpu_r[0];<br>
+=C2=A0 =C2=A0 TCGv R1 =3D cpu_r[1];<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t1 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */<b=
r>
+=C2=A0 =C2=A0 tcg_gen_ext8s_tl(t1, Rr); /* make Rr full 32 bit signed */<b=
r>
+=C2=A0 =C2=A0 tcg_gen_mul_tl(R, t0, t1); /* R =3D Rd * Rr */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R0, R, 0xff);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(R1, R, 8);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf =3D R(16) */<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_Zf, R);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t1);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 This instruction performs 8-bit x 8-bit -&gt; 16-bit multiplicati=
on of a<br>
+ *=C2=A0 signed and an unsigned number.<br>
+ */<br>
+static bool trans_MULSU(DisasContext *ctx, arg_MULSU *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv R0 =3D cpu_r[0];<br>
+=C2=A0 =C2=A0 TCGv R1 =3D cpu_r[1];<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */<b=
r>
+=C2=A0 =C2=A0 tcg_gen_mul_tl(R, t0, Rr); /* R =3D Rd *Rr */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R0, R, 0xff);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(R1, R, 8);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Cf, R, 16); /* Cf =3D R(16) */<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(cpu_Zf, R);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ *=C2=A0 Replaces the contents of register Rd with its two&#39;s complemen=
t; the<br>
+ *=C2=A0 value $80 is left unchanged.<br>
+ */<br>
+static bool trans_NEG(DisasContext *ctx, arg_NEG *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_const_i32(0);<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* op */<br>
+=C2=A0 =C2=A0 tcg_gen_sub_tl(R, t0, Rd); /* R =3D 0 - Rd */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R, R, 0xff); /* make it 8 bits */<br>
+<br>
+=C2=A0 =C2=A0 gen_sub_CHf(R, t0, Rd);<br>
+=C2=A0 =C2=A0 gen_sub_Vf(R, t0, Rd);<br>
+=C2=A0 =C2=A0 gen_ZNSf(R);<br>
+<br>
+=C2=A0 =C2=A0 /* R */<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rd,-- <br>
2.17.2 (Apple Git-113)<br>
<br>
<br>
</blockquote>

--000000000000b7984e0594a31d30--

