Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556C7C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 19:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED1820732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 19:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkmFCoZw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED1820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j72NC-0000uJ-6X
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 14:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j72ML-0000T5-EG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 14:28:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j72MJ-0000GH-8S
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 14:28:41 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:36241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j72MI-0000DF-Ra; Wed, 26 Feb 2020 14:28:39 -0500
Received: by mail-lf1-x142.google.com with SMTP id f24so204548lfh.3;
 Wed, 26 Feb 2020 11:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n5mom7NgDbO9O2cTt1zf4XRX2KlpfXOovDY95q21jTc=;
 b=IkmFCoZwOLpHgkJw93OOH+bwSd/6tf9OTlehQPH60O9wBHQRZJg7jbhXCPtJbft4P0
 WzWCWkoGN1nRT3USNbDJ8p25gbqYVcPttaDGjwCTdVuUB0ILcn2QflItHpQl9uXxSa7l
 NFi9q+u+8bJW4JqAYF9GTEYVEnfu4Y0p35p1kP18ujY1qjeSjNBbNvNvBFpG4iVBpxwk
 LTXOH9qtEHWI/Tx1NzTYXC42k7YrIE9onMG6+4wWLtun5Oq4rY8v//7/oxwQ6UsTPMW/
 dHoTBRXM4PXWMpA6M8WPD6h0iqkxEvQXIKWyHG6oQ7HKMP7ZP9kTx1Havb3GwMl+Ak2A
 CvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n5mom7NgDbO9O2cTt1zf4XRX2KlpfXOovDY95q21jTc=;
 b=eJMJsHjZGV7gA65EvMUtWIIiBqg6/T6xfUBEoCtGfcz9wizHqqQ2DlpAzqHS8QvTCE
 HDo7DCAa80HDEEaT/t5z5B72e0wC3zu9/b+h2+uwIAzRoIZnQUu8A+GE7+z2MaQOGWgX
 Qj2PzRXQBjqSo5/mgsWiV4pF7Q4N6CCF5p9DTZb1lqnN2VqFaVRzsisDif4LWcNd1aOc
 pn6FBinbDY5lq6wt7VWu9r+oiLsSJojFO9UvLflDp/+oGcvkWbqOZXc7UEB7w214ydJj
 3NMVNrKdtTyKvJa/XZ2OMlAA5y5ce34LpTGnrkv8aK0leyMlFdR84sWyJYxmgB5r/3Cb
 lAnw==
X-Gm-Message-State: ANhLgQ2nlTPrAIdt0//Ngp/YbjSzTjZIoAlmYl6L0Yi4DZ1Tu9X+NiLn
 iiui5+LaS2U++FovWlLfrzv5t9zyKcfB7GWcDM4=
X-Google-Smtp-Source: ADFU+vuHnz0hxhoPIwaBBXxnmwnmYsGXXRJKz+whyvs20Jf48yI+0LOsNiJISApp/yBBFDBr2F6xvSvADLAlRuicU/g=
X-Received: by 2002:a05:6512:3048:: with SMTP id
 b8mr109513lfb.102.1582745317264; 
 Wed, 26 Feb 2020 11:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20200221094531.61894-1-zhiwei_liu@c-sky.com>
 <20200221094531.61894-5-zhiwei_liu@c-sky.com>
In-Reply-To: <20200221094531.61894-5-zhiwei_liu@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 11:20:57 -0800
Message-ID: <CAKmqyKP81rcQ_meiqij-DLWvvqtH2N-zLZjkrpq+MM05ALhLhQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] target/riscv: add vector configure instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 On Fri, Feb 21, 2020 at 1:45 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>
> vsetvl and vsetvli are two configure instructions for vl, vtype. TB flags
> should update after configure instructions. The (ill, lmul, sew ) of vtype
> and the bit of (VSTART == 0 && VL == VLMAX) will be placed within tb_flags.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  MAINTAINERS                             |  1 +
>  target/riscv/Makefile.objs              |  2 +-
>  target/riscv/cpu.h                      | 61 +++++++++++++++++++---
>  target/riscv/helper.h                   |  2 +
>  target/riscv/insn32.decode              |  5 ++
>  target/riscv/insn_trans/trans_rvv.inc.c | 69 +++++++++++++++++++++++++
>  target/riscv/translate.c                | 17 +++++-
>  target/riscv/vector_helper.c            | 53 +++++++++++++++++++
>  8 files changed, 199 insertions(+), 11 deletions(-)
>  create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>  create mode 100644 target/riscv/vector_helper.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1740a4fddc..cd2e200db9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -266,6 +266,7 @@ M: Palmer Dabbelt <palmer@dabbelt.com>
>  M: Alistair Francis <Alistair.Francis@wdc.com>
>  M: Sagar Karandikar <sagark@eecs.berkeley.edu>
>  M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> +M: LIU Zhiwei <zhiwei_liu@c-sky.com>

I don't think you should add yourself here. MAINTAINERS is more for
people doing active patch review.

RISC-V QEMU can really do with more maintainers though, so if you do
want to be involved you could help review patches.

>  L: qemu-riscv@nongnu.org
>  S: Supported
>  F: target/riscv/
> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> index ff651f69f6..ff38df6219 100644
> --- a/target/riscv/Makefile.objs
> +++ b/target/riscv/Makefile.objs
> @@ -1,4 +1,4 @@
> -obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o
> +obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o vector_helper.o gdbstub.o
>  obj-$(CONFIG_SOFTMMU) += pmp.o
>
>  ifeq ($(CONFIG_SOFTMMU),y)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 748bd557f9..f7003edb86 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -21,6 +21,7 @@
>  #define RISCV_CPU_H
>
>  #include "hw/core/cpu.h"
> +#include "hw/registerfields.h"
>  #include "exec/cpu-defs.h"
>  #include "fpu/softfloat-types.h"
>
> @@ -98,6 +99,12 @@ typedef struct CPURISCVState CPURISCVState;
>
>  #define RV_VLEN_MAX 512
>
> +FIELD(VTYPE, LMUL, 0, 2)

Shouldn't this be VLMUL?

> +FIELD(VTYPE, SEW, 2, 3)

VSEW?

> +FIELD(VTYPE, EDIV, 5, 2)

VEDIV?

> +FIELD(VTYPE, RESERVED, 7, sizeof(target_ulong) * 8 - 9)
> +FIELD(VTYPE, VILL, sizeof(target_ulong) * 8 - 2, 1)
> +
>  struct CPURISCVState {
>      target_ulong gpr[32];
>      uint64_t fpr[32]; /* assume both F and D extensions */
> @@ -302,16 +309,59 @@ void riscv_cpu_set_fflags(CPURISCVState *env, target_ulong);
>  #define TB_FLAGS_MMU_MASK   3
>  #define TB_FLAGS_MSTATUS_FS MSTATUS_FS
>
> +typedef CPURISCVState CPUArchState;
> +typedef RISCVCPU ArchCPU;
> +#include "exec/cpu-all.h"

Why do you need this? Shouldn't the TB_FLAGS fields work without this.

> +
> +FIELD(TB_FLAGS, VL_EQ_VLMAX, 2, 1)
> +FIELD(TB_FLAGS, LMUL, 3, 2)
> +FIELD(TB_FLAGS, SEW, 5, 3)
> +FIELD(TB_FLAGS, VILL, 8, 1)

These should probably be defined with the other TB_FLAGS (or if you
need them here you can move the others up here).


> +
> +/*
> + * A simplification for VLMAX
> + * = (1 << LMUL) * VLEN / (8 * (1 << SEW))
> + * = (VLEN << LMUL) / (8 << SEW)
> + * = (VLEN << LMUL) >> (SEW + 3)
> + * = VLEN >> (SEW + 3 - LMUL)
> + */
> +static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
> +{
> +    uint8_t sew, lmul;
> +
> +    sew = FIELD_EX64(vtype, VTYPE, SEW);
> +    lmul = FIELD_EX64(vtype, VTYPE, LMUL);
> +    return cpu->cfg.vlen >> (sew + 3 - lmul);

Shouldn't we assert this isn't over RV_VLEN_MAX?

Alistair

> +}
> +
>  static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
> -                                        target_ulong *cs_base, uint32_t *flags)
> +                                        target_ulong *cs_base, uint32_t *pflags)
>  {
> +    uint32_t flags = 0;
> +
>      *pc = env->pc;
>      *cs_base = 0;
> +
> +    if (env->misa & RVV) {
> +        uint32_t vlmax = vext_get_vlmax(env_archcpu(env), env->vtype);
> +        bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl);
> +        flags = FIELD_DP32(flags, TB_FLAGS, VILL,
> +                    FIELD_EX64(env->vtype, VTYPE, VILL));
> +        flags = FIELD_DP32(flags, TB_FLAGS, SEW,
> +                    FIELD_EX64(env->vtype, VTYPE, SEW));
> +        flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
> +                    FIELD_EX64(env->vtype, VTYPE, LMUL));
> +        flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
> +    } else {
> +        flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
> +    }
> +
>  #ifdef CONFIG_USER_ONLY
> -    *flags = TB_FLAGS_MSTATUS_FS;
> +    flags |= TB_FLAGS_MSTATUS_FS;
>  #else
> -    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
> +    flags |= cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
>  #endif
> +    *pflags = flags;
>  }
>
>  int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
> @@ -352,9 +402,4 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
>
>  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
>
> -typedef CPURISCVState CPUArchState;
> -typedef RISCVCPU ArchCPU;
> -
> -#include "exec/cpu-all.h"
> -
>  #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index debb22a480..3c28c7e407 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -76,3 +76,5 @@ DEF_HELPER_2(mret, tl, env, tl)
>  DEF_HELPER_1(wfi, void, env)
>  DEF_HELPER_1(tlb_flush, void, env)
>  #endif
> +/* Vector functions */
> +DEF_HELPER_3(vsetvl, tl, env, tl, tl)
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 77f794ed70..5dc009c3cd 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -62,6 +62,7 @@
>  @r_rm    .......   ..... ..... ... ..... ....... %rs2 %rs1 %rm %rd
>  @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
>  @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
> +@r2_zimm . zimm:11  ..... ... ..... ....... %rs1 %rd
>
>  @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
>  @sfence_vm  ....... ..... .....   ... ..... ....... %rs1
> @@ -203,3 +204,7 @@ fcvt_w_d   1100001  00000 ..... ... ..... 1010011 @r2_rm
>  fcvt_wu_d  1100001  00001 ..... ... ..... 1010011 @r2_rm
>  fcvt_d_w   1101001  00000 ..... ... ..... 1010011 @r2_rm
>  fcvt_d_wu  1101001  00001 ..... ... ..... 1010011 @r2_rm
> +
> +# *** RV32V Extension ***
> +vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
> +vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> new file mode 100644
> index 0000000000..da82c72bbf
> --- /dev/null
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -0,0 +1,69 @@
> +/*
> + * RISC-V translation routines for the RVV Standard Extension.
> + *
> + * Copyright (c) 2020 C-SKY Limited. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl * a)
> +{
> +    TCGv s1, s2, dst;
> +    s2 = tcg_temp_new();
> +    dst = tcg_temp_new();
> +
> +    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
> +    if (a->rs1 == 0) {
> +        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
> +        s1 = tcg_const_tl(RV_VLEN_MAX);
> +    } else {
> +        s1 = tcg_temp_new();
> +        gen_get_gpr(s1, a->rs1);
> +    }
> +    gen_get_gpr(s2, a->rs2);
> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
> +    gen_set_gpr(a->rd, dst);
> +    tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn);
> +    exit_tb(ctx);
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +
> +    tcg_temp_free(s1);
> +    tcg_temp_free(s2);
> +    tcg_temp_free(dst);
> +    return true;
> +}
> +
> +static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli * a)
> +{
> +    TCGv s1, s2, dst;
> +    s2 = tcg_const_tl(a->zimm);
> +    dst = tcg_temp_new();
> +
> +    /* Using x0 as the rs1 register specifier, encodes an infinite AVL */
> +    if (a->rs1 == 0) {
> +        /* As the mask is at least one bit, RV_VLEN_MAX is >= VLMAX */
> +        s1 = tcg_const_tl(RV_VLEN_MAX);
> +    } else {
> +        s1 = tcg_temp_new();
> +        gen_get_gpr(s1, a->rs1);
> +    }
> +    gen_helper_vsetvl(dst, cpu_env, s1, s2);
> +    gen_set_gpr(a->rd, dst);
> +    gen_goto_tb(ctx, 0, ctx->pc_succ_insn);
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +
> +    tcg_temp_free(s1);
> +    tcg_temp_free(s2);
> +    tcg_temp_free(dst);
> +    return true;
> +}
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 14dc71156b..cc356aabd8 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -55,6 +55,12 @@ typedef struct DisasContext {
>         to reset this known value.  */
>      int frm;
>      bool ext_ifencei;
> +    /* vector extension */
> +    bool vill;
> +    uint8_t lmul;
> +    uint8_t sew;
> +    uint16_t vlen;
> +    bool vl_eq_vlmax;
>  } DisasContext;
>
>  #ifdef TARGET_RISCV64
> @@ -704,6 +710,7 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>  #include "insn_trans/trans_rva.inc.c"
>  #include "insn_trans/trans_rvf.inc.c"
>  #include "insn_trans/trans_rvd.inc.c"
> +#include "insn_trans/trans_rvv.inc.c"
>  #include "insn_trans/trans_privileged.inc.c"
>
>  /* Include the auto-generated decoder for 16 bit insn */
> @@ -735,14 +742,20 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>      CPURISCVState *env = cs->env_ptr;
>      RISCVCPU *cpu = RISCV_CPU(cs);
> +    uint32_t tb_flags = ctx->base.tb->flags;
>
>      ctx->pc_succ_insn = ctx->base.pc_first;
> -    ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
> -    ctx->mstatus_fs = ctx->base.tb->flags & TB_FLAGS_MSTATUS_FS;
> +    ctx->mem_idx = tb_flags & TB_FLAGS_MMU_MASK;
> +    ctx->mstatus_fs = tb_flags & TB_FLAGS_MSTATUS_FS;
>      ctx->priv_ver = env->priv_ver;
>      ctx->misa = env->misa;
>      ctx->frm = -1;  /* unknown rounding mode */
>      ctx->ext_ifencei = cpu->cfg.ext_ifencei;
> +    ctx->vlen = cpu->cfg.vlen;
> +    ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
> +    ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
> +    ctx->lmul = FIELD_EX32(tb_flags, TB_FLAGS, LMUL);
> +    ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
>  }
>
>  static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> new file mode 100644
> index 0000000000..07db704656
> --- /dev/null
> +++ b/target/riscv/vector_helper.c
> @@ -0,0 +1,53 @@
> +/*
> + * RISC-V Vector Extension Helpers for QEMU.
> + *
> + * Copyright (c) 2020 C-SKY Limited. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "exec/exec-all.h"
> +#include "exec/helper-proto.h"
> +#include <math.h>
> +
> +target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
> +    target_ulong s2)
> +{
> +    int vlmax, vl;
> +    RISCVCPU *cpu = env_archcpu(env);
> +    uint16_t sew = 1 << FIELD_EX64(s2, VTYPE, SEW);
> +    uint8_t ediv = FIELD_EX64(s2, VTYPE, EDIV);
> +    bool vill = FIELD_EX64(s2, VTYPE, VILL);
> +    target_ulong reserved = FIELD_EX64(s2, VTYPE, RESERVED);
> +
> +    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
> +        /* only set vill bit. */
> +        env->vtype = FIELD_DP64(0, VTYPE, VILL, 1);
> +        env->vl = 0;
> +        env->vstart = 0;
> +        return 0;
> +    }
> +
> +    vlmax = vext_get_vlmax(cpu, s2);
> +    if (s1 <= vlmax) {
> +        vl = s1;
> +    } else {
> +        vl = vlmax;
> +    }
> +    env->vl = vl;
> +    env->vtype = s2;
> +    env->vstart = 0;
> +    return vl;
> +}
> --
> 2.23.0
>

