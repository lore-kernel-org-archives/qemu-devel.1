Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AD7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B00721734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HluP7eev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B00721734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufKh-000501-S9
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iudVo-0001Cr-NQ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iudVm-0003Fo-Oy
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:31:12 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42051)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iudVm-0003Fb-Jk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 09:31:10 -0500
Received: by mail-ot1-x342.google.com with SMTP id 66so2867515otd.9
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gw09TjH7tBWzYcqXI/iaAePhsXtUyhO08IeAT7167C0=;
 b=HluP7eevD/pwo77TO3LuyOVMOQJZEn+rLmDVtkW0ku6JFYfyvY23OARNT4H+6NRwwn
 7hcr+6f1p2ycTl+7glxlg9xQGvfjtsUKFEDttDweLqq4T5TBAR090WBj1e7SctwRj+q4
 NY0JMwr33Ng6dnhORFrqgyC6zVjElDxNeaCb/DNhSoV6QtdCech//3MKwiV/6Yuxk7kW
 fPBdO7VPy932VxHZt7bPhGUa1dOWsDQHhxwl4GqoGcFR9itLAWMXoqxdFGCLZ6a6X9ux
 xERtBnbMnrpTaTqVO5NLHPyBS3t3ketYHcgJqWUf6Xdes/GjHGCoTMpPB3oZh+1VICti
 K0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gw09TjH7tBWzYcqXI/iaAePhsXtUyhO08IeAT7167C0=;
 b=tUrZVfB3F+ZRQq6Uue3n5YR+KFrV1DBmaTIHH//qpu9zzgz0ZlWBHDEsOXepw1bSab
 2OdgPau+04jI33+nSm5TTcOS/tG2ZYFUrLIRjeg4Sv34tonCrB6+fuD0k/CDHVN83koC
 nWTyjYwF+4tuX267McSNcJ7eqvJ0+8L5JsH//xLKrosuGcbUBPFWBmk90pl7OBcKDxbE
 +8PJgPx2pnHG2GJguXanmrOR8AlZNNUJ3F8+F2dkt8dn68iRMVD0aWlME0tjRnf1k0l0
 NfsQ3SlICk9VCoIFQV5L9OVlGdj/zquALcRiEx5RxjJPXE47r+6F1ZWPqaxwvIt587lZ
 fV/g==
X-Gm-Message-State: APjAAAXoOddYzX279TjasgQ9l+Q1t6DqnAqg4mKhuOElVGosLdBEveYF
 skY+/2hXafwZqYUInGzVElWe20u6bortV6jm1CQ2UOQn
X-Google-Smtp-Source: APXvYqwjVExZ2IozOF6eUXiXIKw/hk9mzQOGb/8cH6Ckmyj7CvmvKTZ8olBS6Ne0Sr3dFR2cPsJpfDM6H+wYy8/0TdQ=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr11432807otp.306.1579789869734; 
 Thu, 23 Jan 2020 06:31:09 -0800 (PST)
MIME-Version: 1.0
References: <1579613937-5774-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579613937-5774-3-git-send-email-aleksandar.markovic@rt-rk.com>
 <BYAPR02MB48865E5EF488E5480E591D2DDE0C0@BYAPR02MB4886.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB48865E5EF488E5480E591D2DDE0C0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 23 Jan 2020 15:30:58 +0100
Message-ID: <CAL1e-=haJ4d5vsnZ_4H=7T+8o0Opx=8d4bEevN8X2Vm71=KGEw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] target/mips: Add support for MIPS<32|64>R6 CRC32
 ISA
To: Taylor Simpson <tsimpson@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 3:17 AM Taylor Simpson <tsimpson@quicinc.com> wrote:
>
>
>
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Add support for eight CRC-related MIPS<32|64>R6 instructions.
> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >  disas/mips.c            |   8 +++
> >  target/mips/helper.h    |   2 +
> >  target/mips/op_helper.c |  19 ++++++++
> >  target/mips/translate.c | 127
> > ++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 156 insertions(+)
> >
> > diff --git a/disas/mips.c b/disas/mips.c index dfefe5e..75c48b3 100644
> > --- a/disas/mips.c
> > +++ b/disas/mips.c
> > @@ -1409,6 +1409,14 @@ const struct mips_opcode mips_builtin_opcodes[]
> > =
> >  {"dvp",        "t",     0x41600024, 0xffe0ffff, TRAP|WR_t,            0, I32R6},
> >  {"evp",        "",      0x41600004, 0xffffffff, TRAP,                 0, I32R6},
> >  {"evp",        "t",     0x41600004, 0xffe0ffff, TRAP|WR_t,            0, I32R6},
> > +{"crc32b",     "t,v,t", 0x7c00000f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I32R6},
> > +{"crc32h",     "t,v,t", 0x7c00004f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I32R6},
> > +{"crc32w",     "t,v,t", 0x7c00008f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I32R6},
> > +{"crc32d",     "t,v,t", 0x7c0000cf, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I64R6},
> > +{"crc32cb",    "t,v,t", 0x7c00010f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I32R6},
> > +{"crc32ch",    "t,v,t", 0x7c00014f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I32R6},
> > +{"crc32cw",    "t,v,t", 0x7c00018f, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I32R6},
> > +{"crc32cd",    "t,v,t", 0x7c0001cf, 0xfc00ff3f, WR_d | RD_s | RD_t,   0, I64R6},
> >
> >  /* MSA */
> >  {"sll.b",   "+d,+e,+f", 0x7800000d, 0xffe0003f, WR_VD|RD_VS|RD_VT,  0,
> > MSA},
> > diff --git a/target/mips/helper.h b/target/mips/helper.h index
> > 7b8ad74..2095330 100644
> > --- a/target/mips/helper.h
> > +++ b/target/mips/helper.h
> > @@ -40,6 +40,8 @@ DEF_HELPER_FLAGS_1(bitswap,
> > TCG_CALL_NO_RWG_SE, tl, tl)  DEF_HELPER_FLAGS_1(dbitswap,
> > TCG_CALL_NO_RWG_SE, tl, tl)  #endif
> >
> > +DEF_HELPER_3(crc32, tl, tl, tl, i32)
> > +DEF_HELPER_3(crc32c, tl, tl, tl, i32)
> >  DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
> >
> >  #ifndef CONFIG_USER_ONLY
> > diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c index
> > 18fcee4..5cd396d 100644
> > --- a/target/mips/op_helper.c
> > +++ b/target/mips/op_helper.c
> > @@ -27,6 +27,8 @@
> >  #include "exec/memop.h"
> >  #include "sysemu/kvm.h"
> >  #include "fpu/softfloat.h"
> > +#include "qemu/crc32c.h"
> > +#include <zlib.h>
> >
> >
> > /**********************************************************
> > *******************/
> >  /* Exceptions processing helpers */
> > @@ -350,6 +352,23 @@ target_ulong helper_rotx(target_ulong rs, uint32_t
> > shift, uint32_t shiftx,
> >      return (int64_t)(int32_t)(uint32_t)tmp5;  }
> >
> > +/* these crc32 functions are based on target/arm/helper-a64.c */
> > +target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t
>
> Shouldn't this be "HELPER(crc32)"?
>

It should.

> > +sz) {
> > +    uint8_t buf[8];
> > +
> > +    stq_le_p(buf, m);
> > +    return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff); }
> > +
> > +target_ulong helper_crc32c(target_ulong val, target_ulong m, uint32_t
>
> Shouldn't this be "HELPER(crc32c)"?
>

You are correct. It should. I will correct this in the next version.
But, I plan also to refactor the code of the entire patch, so that a
each CRC32 instruction (there are eight) has it own helper.

> > +sz) {
> > +    uint8_t buf[8];
> > +
> > +    stq_le_p(buf, m);
> > +    return (int32_t) (crc32c(val, buf, sz) ^ 0xffffffff); }
> > +
> >  #ifndef CONFIG_USER_ONLY
> >
> >  static inline hwaddr do_translate_address(CPUMIPSState *env, diff --git
> > a/target/mips/translate.c b/target/mips/translate.c index 4bff585..1b38356
> > 100644
> > --- a/target/mips/translate.c
> > +++ b/target/mips/translate.c
> > @@ -451,6 +451,7 @@ enum {
> >      OPC_LWE            = 0x2F | OPC_SPECIAL3,
> >
> >      /* R6 */
> > +    OPC_CRC32          = 0x0F | OPC_SPECIAL3,
> >      R6_OPC_PREF        = 0x35 | OPC_SPECIAL3,
> >      R6_OPC_CACHE       = 0x25 | OPC_SPECIAL3,
> >      R6_OPC_LL          = 0x36 | OPC_SPECIAL3,
> > @@ -2547,6 +2548,7 @@ typedef struct DisasContext {
> >      bool nan2008;
> >      bool abs2008;
> >      bool saar;
> > +    bool crcp;
> >  } DisasContext;
> >
> >  #define DISAS_STOP       DISAS_TARGET_0
> > @@ -27117,11 +27119,96 @@ static void
> > decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
> >      }
> >  }
> >
> > +static void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz,
> > +                      int crc32c)
> > +{
> > +    TCGv t0;
> > +    TCGv t1;
> > +    TCGv_i32 tsz = tcg_const_i32(1 << sz);
> > +    uint64_t mask = 0;
>
> Should be uint32_t
>

It could. But, the need for this variable will I think dissapear in
upcoming refactoring that I am going to do for he next version.

> > +
> > +    if (rd == 0) {
> > +        /* Treat as NOP. */
>
> Need to free tsz on this path or wait to assign with t0/t1
>

You are absolutely right. It will be fixed.

> > +        return;
> > +    }
> > +    t0 = tcg_temp_new();
> > +    t1 = tcg_temp_new();
> > +
> > +    gen_load_gpr(t0, rt);
> > +    gen_load_gpr(t1, rs);
> > +
> > +    if (sz != 3) {
> > +        switch (sz) {
> > +        case 0:
> > +            mask = 0xFF;
> > +            break;
> > +        case 1:
> > +            mask = 0xFFFF;
> > +            break;
> > +        case 2:
> > +            mask = 0xFFFFFFFF;
> > +            break;
> > +        }
> > +        tcg_gen_andi_tl(t1, t1, mask);
> > +    }
> > +
> > +    if (crc32c) {
> > +        gen_helper_crc32c(cpu_gpr[rd], t0, t1, tsz);
> > +    } else {
> > +        gen_helper_crc32(cpu_gpr[rd], t0, t1, tsz);
> > +    }
> > +
> > +    tcg_temp_free(t0);
> > +    tcg_temp_free(t1);
> > +    tcg_temp_free_i32(tsz);
> > +}
> > +
> > +static void gen_crc32b(DisasContext *ctx, int rd, int rs, int rt) {
> > +    gen_crc32(ctx, rd, rs, rt, 0, 0);
> > +}
> > +
> > +static void gen_crc32h(DisasContext *ctx, int rd, int rs, int rt) {
> > +    gen_crc32(ctx, rd, rs, rt, 1, 0);
> > +}
> > +
> > +static void gen_crc32w(DisasContext *ctx, int rd, int rs, int rt) {
> > +    gen_crc32(ctx, rd, rs, rt, 2, 0);
> > +}
> > +
> > +static void gen_crc32d(DisasContext *ctx, int rd, int rs, int rt) {
> > +    gen_crc32(ctx, rd, rs, rt, 3, 0);
> > +}
> > +
> > +static void gen_crc32cb(DisasContext *ctx, int rd, int rs, int rt) {
> > +    gen_crc32(ctx, rd, rs, rt, 0, 1);
> > +}
> > +
> > +static void gen_crc32ch(DisasContext *ctx, int rd, int rs, int rt) {
> > +    gen_crc32(ctx, rd, rs, rt, 1, 1);
> > +}
> > +
> > +static void gen_crc32cw(DisasContext *ctx, int rd, int rs, int rt) {
> > +    gen_crc32(ctx, rd, rs, rt, 2, 1);
> > +}
> > +
> > +static void gen_crc32cd(DisasContext *ctx, int rd, int rs, int rt) {
> > +    gen_crc32(ctx, rd, rs, rt, 3, 1);
> > +}
> > +
> >  static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
> > {
> >      int rs, rt, rd, sa;
> >      uint32_t op1, op2;
> >      int16_t imm;
> > +    int sz, crc32c;
> >
> >      rs = (ctx->opcode >> 21) & 0x1f;
> >      rt = (ctx->opcode >> 16) & 0x1f;
> > @@ -27131,6 +27218,45 @@ static void
> > decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
> >
> >      op1 = MASK_SPECIAL3(ctx->opcode);
> >      switch (op1) {
> > +    case OPC_CRC32:
> > +        sz = extract32(ctx->opcode, 6, 2);
> > +        crc32c = extract32(ctx->opcode, 8, 3);
> > +        if (unlikely(!ctx->crcp) ||
> > +            unlikely((sz == 3) && (!(ctx->hflags & MIPS_HFLAG_64))) ||
> > +            unlikely((crc32c >= 2))) {
> > +            generate_exception_end(ctx, EXCP_RI);
> > +        }
> > +        switch (sz) {
> > +        case 0:
> > +            if (crc32c) {
> > +                gen_crc32cb(ctx, rt, rs, rt);
> > +            } else {
> > +                gen_crc32b(ctx, rt, rs, rt);
> > +            }
> > +            break;
> > +        case 1:
> > +            if (crc32c) {
> > +                gen_crc32ch(ctx, rt, rs, rt);
> > +            } else {
> > +                gen_crc32h(ctx, rt, rs, rt);
> > +            }
> > +            break;
> > +        case 2:
> > +            if (crc32c) {
> > +                gen_crc32cw(ctx, rt, rs, rt);
> > +            } else {
> > +                gen_crc32w(ctx, rt, rs, rt);
> > +            }
> > +            break;
> > +        case 3:
> > +            if (crc32c) {
> > +                gen_crc32cd(ctx, rt, rs, rt);
> > +            } else {
> > +                gen_crc32d(ctx, rt, rs, rt);
> > +            }
> > +            break;
> > +        }
> > +        break;
> >      case R6_OPC_PREF:
> >          if (rt >= 24) {
> >              /* hint codes 24-31 are reserved and signal RI */ @@ -30727,6
> > +30853,7 @@ static void mips_tr_init_disas_context(DisasContextBase
> > *dcbase, CPUState *cs)
> >      ctx->mrp = (env->CP0_Config5 >> CP0C5_MRP) & 1;
> >      ctx->nan2008 = (env->active_fpu.fcr31 >> FCR31_NAN2008) & 1;
> >      ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
> > +    ctx->crcp = (env->CP0_Config5 >> CP0C5_CRCP) & 1;
> >      restore_cpu_state(env, ctx);
> >  #ifdef CONFIG_USER_ONLY
> >          ctx->mem_idx = MIPS_HFLAG_UM;
> > --
> > 2.7.4
> >
> >
>
>

