Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED2EC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB0D2084E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 18:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2UpEOKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB0D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58998 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnS7-0006ys-Q1
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 14:07:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnQQ-0005jx-Sp
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hOnQO-0005EG-4g
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:05:46 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hOnQN-0005DU-Jl
	for qemu-devel@nongnu.org; Thu, 09 May 2019 14:05:44 -0400
Received: by mail-lj1-x244.google.com with SMTP id h21so1070238ljk.13
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=C1BqNbN5DA/bjOPAjcfII7zqHTyg2gGIDEpeI3WZUc0=;
	b=c2UpEOKtTWWbMwHo2AKdmXzBcXAo6jF01uWPn7a448nVwh4GHxilv2vOeEcZgzjGTP
	zynkPhugG/5bVYNeP8d2bn8p6mr2BGoZ/rWD+F5VsSULElklb0Btuc5rMSHWegK8ktmq
	kzQd0t/QmCE975IuLSoeYZb59ZKfqui5LufN3qZfl92VD/VkLePh0IT/tDTcEU13Sr1x
	Z8UFEZFn+Iz+B1fUwb0a4+VIFC8SyPzagjV+sWoUrTw4sr7FvpEDNtOnXeJZj21+gFRk
	TdopibyCCEx2aWNVT41CPnbRvmf7Sql8RTrjK5D28EZoFEaefQYSa5cGUmQmTMFpfLsU
	4gEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=C1BqNbN5DA/bjOPAjcfII7zqHTyg2gGIDEpeI3WZUc0=;
	b=DtkpnbugnEZ8yu26Egbaf4UYLnXqPJbhQN12sv8bUzXjc0VRTwuXM1rXR/WigvcmTD
	pqNR7W+JDN4k1EeHoZzRn3uWsIMzFsPkgMPfeI5MGJqUvmjqhRpyirjd6Sk/dFZvbJXK
	fsiv41vjsKfT4af9sL1A5uSn+AN65Xxxt2I4LhKjq6ijgeGZNsr8nUYOSDZXDyVRQgS2
	bMctM2S/F0laYI0UpAAwnuF1/Gjidr9CtBUxd1+tChEie+p2nObwXutKz50CLD5bZShV
	3hZ7BjiLpKwy6ayMFfcCIxEqNOcLGS577Y7kL+91b+c05yIsUTOpPBMZ+Ues0XrFmsxB
	y46A==
X-Gm-Message-State: APjAAAV7LKHcBhGkCLLmfx11Ozhj3ypHZiF1/aakaGF6aw62ktGharLB
	DMmyiiqPfLdoWwfys0UINdp3+YFnn7eYLP8bkgk=
X-Google-Smtp-Source: APXvYqzvBH5xVGd36NxfdsdGVqBhUZ8EghAVuD8mhOLG6WYpHj20z14ZLGv/FPAc3Lg5YRFRv3bhc+LKHYy6hKwrkDU=
X-Received: by 2002:a2e:824b:: with SMTP id j11mr3062416ljh.197.1557425142106; 
	Thu, 09 May 2019 11:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-12-richard.henderson@linaro.org>
In-Reply-To: <20190508000641.19090-12-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 May 2019 11:03:33 -0700
Message-ID: <CAKmqyKNch7DxFU8SUUTD2=bS7rYPWsSacOcEBr0khiwJvdcVeg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v3 11/39] target/cris: Reindent op_helper.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 7, 2019 at 5:13 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fix all of the coding style errors in this file at once.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/cris/op_helper.c | 817 +++++++++++++++++++---------------------
>  1 file changed, 398 insertions(+), 419 deletions(-)
>
> diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
> index 0ee3a3117b..d4479167a5 100644
> --- a/target/cris/op_helper.c
> +++ b/target/cris/op_helper.c
> @@ -76,9 +76,10 @@ void helper_raise_exception(CPUCRISState *env, uint32_t index)
>  void helper_tlb_flush_pid(CPUCRISState *env, uint32_t pid)
>  {
>  #if !defined(CONFIG_USER_ONLY)
> -       pid &= 0xff;
> -       if (pid != (env->pregs[PR_PID] & 0xff))
> -               cris_mmu_flush_pid(env, env->pregs[PR_PID]);
> +    pid &= 0xff;
> +    if (pid != (env->pregs[PR_PID] & 0xff)) {
> +        cris_mmu_flush_pid(env, env->pregs[PR_PID]);
> +    }
>  #endif
>  }
>
> @@ -94,541 +95,519 @@ void helper_spc_write(CPUCRISState *env, uint32_t new_spc)
>  }
>
>  /* Used by the tlb decoder.  */
> -#define EXTRACT_FIELD(src, start, end) \
> -           (((src) >> start) & ((1 << (end - start + 1)) - 1))
> +#define EXTRACT_FIELD(src, start, end)                  \
> +    (((src) >> start) & ((1 << (end - start + 1)) - 1))
>
>  void helper_movl_sreg_reg(CPUCRISState *env, uint32_t sreg, uint32_t reg)
>  {
>  #if !defined(CONFIG_USER_ONLY)
>      CRISCPU *cpu = cris_env_get_cpu(env);
>  #endif
> -       uint32_t srs;
> -       srs = env->pregs[PR_SRS];
> -       srs &= 3;
> -       env->sregs[srs][sreg] = env->regs[reg];
> +    uint32_t srs;
> +    srs = env->pregs[PR_SRS];
> +    srs &= 3;
> +    env->sregs[srs][sreg] = env->regs[reg];
>
>  #if !defined(CONFIG_USER_ONLY)
> -       if (srs == 1 || srs == 2) {
> -               if (sreg == 6) {
> -                       /* Writes to tlb-hi write to mm_cause as a side
> -                          effect.  */
> -                       env->sregs[SFR_RW_MM_TLB_HI] = env->regs[reg];
> -                       env->sregs[SFR_R_MM_CAUSE] = env->regs[reg];
> -               }
> -               else if (sreg == 5) {
> -                       uint32_t set;
> -                       uint32_t idx;
> -                       uint32_t lo, hi;
> -                       uint32_t vaddr;
> -                       int tlb_v;
> +    if (srs == 1 || srs == 2) {
> +        if (sreg == 6) {
> +            /* Writes to tlb-hi write to mm_cause as a side effect.  */
> +            env->sregs[SFR_RW_MM_TLB_HI] = env->regs[reg];
> +            env->sregs[SFR_R_MM_CAUSE] = env->regs[reg];
> +        } else if (sreg == 5) {
> +            uint32_t set;
> +            uint32_t idx;
> +            uint32_t lo, hi;
> +            uint32_t vaddr;
> +            int tlb_v;
>
> -                       idx = set = env->sregs[SFR_RW_MM_TLB_SEL];
> -                       set >>= 4;
> -                       set &= 3;
> +            idx = set = env->sregs[SFR_RW_MM_TLB_SEL];
> +            set >>= 4;
> +            set &= 3;
>
> -                       idx &= 15;
> -                       /* We've just made a write to tlb_lo.  */
> -                       lo = env->sregs[SFR_RW_MM_TLB_LO];
> -                       /* Writes are done via r_mm_cause.  */
> -                       hi = env->sregs[SFR_R_MM_CAUSE];
> +            idx &= 15;
> +            /* We've just made a write to tlb_lo.  */
> +            lo = env->sregs[SFR_RW_MM_TLB_LO];
> +            /* Writes are done via r_mm_cause.  */
> +            hi = env->sregs[SFR_R_MM_CAUSE];
>
> -                       vaddr = EXTRACT_FIELD(env->tlbsets[srs-1][set][idx].hi,
> -                                             13, 31);
> -                       vaddr <<= TARGET_PAGE_BITS;
> -                       tlb_v = EXTRACT_FIELD(env->tlbsets[srs-1][set][idx].lo,
> -                                           3, 3);
> -                       env->tlbsets[srs - 1][set][idx].lo = lo;
> -                       env->tlbsets[srs - 1][set][idx].hi = hi;
> +            vaddr = EXTRACT_FIELD(env->tlbsets[srs - 1][set][idx].hi, 13, 31);
> +            vaddr <<= TARGET_PAGE_BITS;
> +            tlb_v = EXTRACT_FIELD(env->tlbsets[srs - 1][set][idx].lo, 3, 3);
> +            env->tlbsets[srs - 1][set][idx].lo = lo;
> +            env->tlbsets[srs - 1][set][idx].hi = hi;
>
> -                       D_LOG("tlb flush vaddr=%x v=%d pc=%x\n",
> -                                 vaddr, tlb_v, env->pc);
> -                       if (tlb_v) {
> +            D_LOG("tlb flush vaddr=%x v=%d pc=%x\n",
> +                  vaddr, tlb_v, env->pc);
> +            if (tlb_v) {
>                  tlb_flush_page(CPU(cpu), vaddr);
> -                       }
> -               }
> -       }
> +            }
> +        }
> +    }
>  #endif
>  }
>
>  void helper_movl_reg_sreg(CPUCRISState *env, uint32_t reg, uint32_t sreg)
>  {
> -       uint32_t srs;
> -       env->pregs[PR_SRS] &= 3;
> -       srs = env->pregs[PR_SRS];
> -
> +    uint32_t srs;
> +    env->pregs[PR_SRS] &= 3;
> +    srs = env->pregs[PR_SRS];
> +
>  #if !defined(CONFIG_USER_ONLY)
> -       if (srs == 1 || srs == 2)
> -       {
> -               uint32_t set;
> -               uint32_t idx;
> -               uint32_t lo, hi;
> +    if (srs == 1 || srs == 2) {
> +        uint32_t set;
> +        uint32_t idx;
> +        uint32_t lo, hi;
>
> -               idx = set = env->sregs[SFR_RW_MM_TLB_SEL];
> -               set >>= 4;
> -               set &= 3;
> -               idx &= 15;
> +        idx = set = env->sregs[SFR_RW_MM_TLB_SEL];
> +        set >>= 4;
> +        set &= 3;
> +        idx &= 15;
>
> -               /* Update the mirror regs.  */
> -               hi = env->tlbsets[srs - 1][set][idx].hi;
> -               lo = env->tlbsets[srs - 1][set][idx].lo;
> -               env->sregs[SFR_RW_MM_TLB_HI] = hi;
> -               env->sregs[SFR_RW_MM_TLB_LO] = lo;
> -       }
> +        /* Update the mirror regs.  */
> +        hi = env->tlbsets[srs - 1][set][idx].hi;
> +        lo = env->tlbsets[srs - 1][set][idx].lo;
> +        env->sregs[SFR_RW_MM_TLB_HI] = hi;
> +        env->sregs[SFR_RW_MM_TLB_LO] = lo;
> +    }
>  #endif
> -       env->regs[reg] = env->sregs[srs][sreg];
> +    env->regs[reg] = env->sregs[srs][sreg];
>  }
>
>  static void cris_ccs_rshift(CPUCRISState *env)
>  {
> -       uint32_t ccs;
> +    uint32_t ccs;
>
> -       /* Apply the ccs shift.  */
> -       ccs = env->pregs[PR_CCS];
> -       ccs = (ccs & 0xc0000000) | ((ccs & 0x0fffffff) >> 10);
> -       if (ccs & U_FLAG)
> -       {
> -               /* Enter user mode.  */
> -               env->ksp = env->regs[R_SP];
> -               env->regs[R_SP] = env->pregs[PR_USP];
> -       }
> +    /* Apply the ccs shift.  */
> +    ccs = env->pregs[PR_CCS];
> +    ccs = (ccs & 0xc0000000) | ((ccs & 0x0fffffff) >> 10);
> +    if (ccs & U_FLAG) {
> +        /* Enter user mode.  */
> +        env->ksp = env->regs[R_SP];
> +        env->regs[R_SP] = env->pregs[PR_USP];
> +    }
>
> -       env->pregs[PR_CCS] = ccs;
> +    env->pregs[PR_CCS] = ccs;
>  }
>
>  void helper_rfe(CPUCRISState *env)
>  {
> -       int rflag = env->pregs[PR_CCS] & R_FLAG;
> +    int rflag = env->pregs[PR_CCS] & R_FLAG;
>
> -       D_LOG("rfe: erp=%x pid=%x ccs=%x btarget=%x\n",
> -                env->pregs[PR_ERP], env->pregs[PR_PID],
> -                env->pregs[PR_CCS],
> -                env->btarget);
> +    D_LOG("rfe: erp=%x pid=%x ccs=%x btarget=%x\n",
> +          env->pregs[PR_ERP], env->pregs[PR_PID],
> +          env->pregs[PR_CCS],
> +          env->btarget);
>
> -       cris_ccs_rshift(env);
> +    cris_ccs_rshift(env);
>
> -       /* RFE sets the P_FLAG only if the R_FLAG is not set.  */
> -       if (!rflag)
> -               env->pregs[PR_CCS] |= P_FLAG;
> +    /* RFE sets the P_FLAG only if the R_FLAG is not set.  */
> +    if (!rflag) {
> +        env->pregs[PR_CCS] |= P_FLAG;
> +    }
>  }
>
>  void helper_rfn(CPUCRISState *env)
>  {
> -       int rflag = env->pregs[PR_CCS] & R_FLAG;
> +    int rflag = env->pregs[PR_CCS] & R_FLAG;
>
> -       D_LOG("rfn: erp=%x pid=%x ccs=%x btarget=%x\n",
> -                env->pregs[PR_ERP], env->pregs[PR_PID],
> -                env->pregs[PR_CCS],
> -                env->btarget);
> +    D_LOG("rfn: erp=%x pid=%x ccs=%x btarget=%x\n",
> +          env->pregs[PR_ERP], env->pregs[PR_PID],
> +          env->pregs[PR_CCS],
> +          env->btarget);
>
> -       cris_ccs_rshift(env);
> +    cris_ccs_rshift(env);
>
> -       /* Set the P_FLAG only if the R_FLAG is not set.  */
> -       if (!rflag)
> -               env->pregs[PR_CCS] |= P_FLAG;
> +    /* Set the P_FLAG only if the R_FLAG is not set.  */
> +    if (!rflag) {
> +        env->pregs[PR_CCS] |= P_FLAG;
> +    }
>
> -       /* Always set the M flag.  */
> -       env->pregs[PR_CCS] |= M_FLAG_V32;
> +    /* Always set the M flag.  */
> +    env->pregs[PR_CCS] |= M_FLAG_V32;
>  }
>
>  uint32_t helper_btst(CPUCRISState *env, uint32_t t0, uint32_t t1, uint32_t ccs)
>  {
> -       /* FIXME: clean this up.  */
> +    /* FIXME: clean this up.  */
>
> -       /* des ref:
> -          The N flag is set according to the selected bit in the dest reg.
> -          The Z flag is set if the selected bit and all bits to the right are
> -          zero.
> -          The X flag is cleared.
> -          Other flags are left untouched.
> -          The destination reg is not affected.*/
> -       unsigned int fz, sbit, bset, mask, masked_t0;
> +    /*
> +     * des ref:
> +     *  The N flag is set according to the selected bit in the dest reg.
> +     *  The Z flag is set if the selected bit and all bits to the right are
> +     *  zero.
> +     *  The X flag is cleared.
> +     *  Other flags are left untouched.
> +     *  The destination reg is not affected.
> +     */
> +    unsigned int fz, sbit, bset, mask, masked_t0;
>
> -       sbit = t1 & 31;
> -       bset = !!(t0 & (1 << sbit));
> -       mask = sbit == 31 ? -1 : (1 << (sbit + 1)) - 1;
> -       masked_t0 = t0 & mask;
> -       fz = !(masked_t0 | bset);
> +    sbit = t1 & 31;
> +    bset = !!(t0 & (1 << sbit));
> +    mask = sbit == 31 ? -1 : (1 << (sbit + 1)) - 1;
> +    masked_t0 = t0 & mask;
> +    fz = !(masked_t0 | bset);
>
> -       /* Clear the X, N and Z flags.  */
> -       ccs = ccs & ~(X_FLAG | N_FLAG | Z_FLAG);
> -       if (env->pregs[PR_VR] < 32)
> -               ccs &= ~(V_FLAG | C_FLAG);
> -       /* Set the N and Z flags accordingly.  */
> -       ccs |= (bset << 3) | (fz << 2);
> -       return ccs;
> +    /* Clear the X, N and Z flags.  */
> +    ccs = ccs & ~(X_FLAG | N_FLAG | Z_FLAG);
> +    if (env->pregs[PR_VR] < 32) {
> +        ccs &= ~(V_FLAG | C_FLAG);
> +    }
> +    /* Set the N and Z flags accordingly.  */
> +    ccs |= (bset << 3) | (fz << 2);
> +    return ccs;
>  }
>
>  static inline uint32_t evaluate_flags_writeback(CPUCRISState *env,
>                                                  uint32_t flags, uint32_t ccs)
>  {
> -       unsigned int x, z, mask;
> +    unsigned int x, z, mask;
>
> -       /* Extended arithmetics, leave the z flag alone.  */
> -       x = env->cc_x;
> -       mask = env->cc_mask | X_FLAG;
> -        if (x) {
> -               z = flags & Z_FLAG;
> -               mask = mask & ~z;
> -       }
> -       flags &= mask;
> +    /* Extended arithmetics, leave the z flag alone.  */
> +    x = env->cc_x;
> +    mask = env->cc_mask | X_FLAG;
> +    if (x) {
> +        z = flags & Z_FLAG;
> +        mask = mask & ~z;
> +    }
> +    flags &= mask;
>
> -       /* all insn clear the x-flag except setf or clrf.  */
> -       ccs &= ~mask;
> -       ccs |= flags;
> -       return ccs;
> +    /* all insn clear the x-flag except setf or clrf.  */
> +    ccs &= ~mask;
> +    ccs |= flags;
> +    return ccs;
>  }
>
>  uint32_t helper_evaluate_flags_muls(CPUCRISState *env,
>                                      uint32_t ccs, uint32_t res, uint32_t mof)
>  {
> -       uint32_t flags = 0;
> -       int64_t tmp;
> -       int dneg;
> +    uint32_t flags = 0;
> +    int64_t tmp;
> +    int dneg;
>
> -       dneg = ((int32_t)res) < 0;
> +    dneg = ((int32_t)res) < 0;
>
> -       tmp = mof;
> -       tmp <<= 32;
> -       tmp |= res;
> -       if (tmp == 0)
> -               flags |= Z_FLAG;
> -       else if (tmp < 0)
> -               flags |= N_FLAG;
> -       if ((dneg && mof != -1)
> -           || (!dneg && mof != 0))
> -               flags |= V_FLAG;
> -        return evaluate_flags_writeback(env, flags, ccs);
> +    tmp = mof;
> +    tmp <<= 32;
> +    tmp |= res;
> +    if (tmp == 0) {
> +        flags |= Z_FLAG;
> +    } else if (tmp < 0) {
> +        flags |= N_FLAG;
> +    }
> +    if ((dneg && mof != -1) || (!dneg && mof != 0)) {
> +        flags |= V_FLAG;
> +    }
> +    return evaluate_flags_writeback(env, flags, ccs);
>  }
>
>  uint32_t helper_evaluate_flags_mulu(CPUCRISState *env,
>                                      uint32_t ccs, uint32_t res, uint32_t mof)
>  {
> -       uint32_t flags = 0;
> -       uint64_t tmp;
> +    uint32_t flags = 0;
> +    uint64_t tmp;
>
> -       tmp = mof;
> -       tmp <<= 32;
> -       tmp |= res;
> -       if (tmp == 0)
> -               flags |= Z_FLAG;
> -       else if (tmp >> 63)
> -               flags |= N_FLAG;
> -       if (mof)
> -               flags |= V_FLAG;
> +    tmp = mof;
> +    tmp <<= 32;
> +    tmp |= res;
> +    if (tmp == 0) {
> +        flags |= Z_FLAG;
> +    } else if (tmp >> 63) {
> +        flags |= N_FLAG;
> +    }
> +    if (mof) {
> +        flags |= V_FLAG;
> +    }
>
> -        return evaluate_flags_writeback(env, flags, ccs);
> +    return evaluate_flags_writeback(env, flags, ccs);
>  }
>
>  uint32_t helper_evaluate_flags_mcp(CPUCRISState *env, uint32_t ccs,
>                                    uint32_t src, uint32_t dst, uint32_t res)
>  {
> -       uint32_t flags = 0;
> +    uint32_t flags = 0;
>
> -       src = src & 0x80000000;
> -       dst = dst & 0x80000000;
> +    src = src & 0x80000000;
> +    dst = dst & 0x80000000;
>
> -       if ((res & 0x80000000L) != 0L)
> -       {
> -               flags |= N_FLAG;
> -               if (!src && !dst)
> -                       flags |= V_FLAG;
> -               else if (src & dst)
> -                       flags |= R_FLAG;
> -       }
> -       else
> -       {
> -               if (res == 0L)
> -                       flags |= Z_FLAG;
> -               if (src & dst)
> -                       flags |= V_FLAG;
> -               if (dst | src)
> -                       flags |= R_FLAG;
> -       }
> +    if ((res & 0x80000000L) != 0L) {
> +        flags |= N_FLAG;
> +        if (!src && !dst) {
> +            flags |= V_FLAG;
> +        } else if (src & dst) {
> +            flags |= R_FLAG;
> +        }
> +    } else {
> +        if (res == 0L) {
> +            flags |= Z_FLAG;
> +        }
> +        if (src & dst) {
> +            flags |= V_FLAG;
> +        }
> +        if (dst | src) {
> +            flags |= R_FLAG;
> +        }
> +    }
>
> -        return evaluate_flags_writeback(env, flags, ccs);
> +    return evaluate_flags_writeback(env, flags, ccs);
>  }
>
>  uint32_t helper_evaluate_flags_alu_4(CPUCRISState *env, uint32_t ccs,
>                                      uint32_t src, uint32_t dst, uint32_t res)
>  {
> -       uint32_t flags = 0;
> +    uint32_t flags = 0;
>
> -       src = src & 0x80000000;
> -       dst = dst & 0x80000000;
> +    src = src & 0x80000000;
> +    dst = dst & 0x80000000;
>
> -       if ((res & 0x80000000L) != 0L)
> -       {
> -               flags |= N_FLAG;
> -               if (!src && !dst)
> -                       flags |= V_FLAG;
> -               else if (src & dst)
> -                       flags |= C_FLAG;
> -       }
> -       else
> -       {
> -               if (res == 0L)
> -                       flags |= Z_FLAG;
> -               if (src & dst)
> -                       flags |= V_FLAG;
> -               if (dst | src)
> -                       flags |= C_FLAG;
> -       }
> +    if ((res & 0x80000000L) != 0L) {
> +        flags |= N_FLAG;
> +        if (!src && !dst) {
> +            flags |= V_FLAG;
> +        } else if (src & dst) {
> +            flags |= C_FLAG;
> +        }
> +    } else {
> +        if (res == 0L) {
> +            flags |= Z_FLAG;
> +        }
> +        if (src & dst) {
> +            flags |= V_FLAG;
> +        }
> +        if (dst | src) {
> +            flags |= C_FLAG;
> +        }
> +    }
>
> -        return evaluate_flags_writeback(env, flags, ccs);
> +    return evaluate_flags_writeback(env, flags, ccs);
>  }
>
>  uint32_t helper_evaluate_flags_sub_4(CPUCRISState *env, uint32_t ccs,
>                                      uint32_t src, uint32_t dst, uint32_t res)
>  {
> -       uint32_t flags = 0;
> +    uint32_t flags = 0;
>
> -       src = (~src) & 0x80000000;
> -       dst = dst & 0x80000000;
> +    src = (~src) & 0x80000000;
> +    dst = dst & 0x80000000;
>
> -       if ((res & 0x80000000L) != 0L)
> -       {
> -               flags |= N_FLAG;
> -               if (!src && !dst)
> -                       flags |= V_FLAG;
> -               else if (src & dst)
> -                       flags |= C_FLAG;
> -       }
> -       else
> -       {
> -               if (res == 0L)
> -                       flags |= Z_FLAG;
> -               if (src & dst)
> -                       flags |= V_FLAG;
> -               if (dst | src)
> -                       flags |= C_FLAG;
> -       }
> +    if ((res & 0x80000000L) != 0L) {
> +        flags |= N_FLAG;
> +        if (!src && !dst) {
> +            flags |= V_FLAG;
> +        } else if (src & dst) {
> +            flags |= C_FLAG;
> +        }
> +    } else {
> +        if (res == 0L) {
> +            flags |= Z_FLAG;
> +        }
> +        if (src & dst) {
> +            flags |= V_FLAG;
> +        }
> +        if (dst | src) {
> +            flags |= C_FLAG;
> +        }
> +    }
>
> -       flags ^= C_FLAG;
> -        return evaluate_flags_writeback(env, flags, ccs);
> +    flags ^= C_FLAG;
> +    return evaluate_flags_writeback(env, flags, ccs);
>  }
>
>  uint32_t helper_evaluate_flags_move_4(CPUCRISState *env,
>                                        uint32_t ccs, uint32_t res)
>  {
> -       uint32_t flags = 0;
> +    uint32_t flags = 0;
>
> -       if ((int32_t)res < 0)
> -               flags |= N_FLAG;
> -       else if (res == 0L)
> -               flags |= Z_FLAG;
> +    if ((int32_t)res < 0) {
> +        flags |= N_FLAG;
> +    } else if (res == 0L) {
> +        flags |= Z_FLAG;
> +    }
>
> -        return evaluate_flags_writeback(env, flags, ccs);
> +    return evaluate_flags_writeback(env, flags, ccs);
>  }
> +
>  uint32_t helper_evaluate_flags_move_2(CPUCRISState *env,
>                                        uint32_t ccs, uint32_t res)
>  {
> -       uint32_t flags = 0;
> +    uint32_t flags = 0;
>
> -       if ((int16_t)res < 0L)
> -               flags |= N_FLAG;
> -       else if (res == 0)
> -               flags |= Z_FLAG;
> +    if ((int16_t)res < 0L) {
> +        flags |= N_FLAG;
> +    } else if (res == 0) {
> +        flags |= Z_FLAG;
> +    }
>
> -        return evaluate_flags_writeback(env, flags, ccs);
> +    return evaluate_flags_writeback(env, flags, ccs);
>  }
>
> -/* TODO: This is expensive. We could split things up and only evaluate part of
> -   CCR on a need to know basis. For now, we simply re-evaluate everything.  */
> +/*
> + * TODO: This is expensive. We could split things up and only evaluate part of
> + * CCR on a need to know basis. For now, we simply re-evaluate everything.
> + */
>  void helper_evaluate_flags(CPUCRISState *env)
>  {
> -       uint32_t src, dst, res;
> -       uint32_t flags = 0;
> +    uint32_t src, dst, res;
> +    uint32_t flags = 0;
>
> -       src = env->cc_src;
> -       dst = env->cc_dest;
> -       res = env->cc_result;
> +    src = env->cc_src;
> +    dst = env->cc_dest;
> +    res = env->cc_result;
>
> -       if (env->cc_op == CC_OP_SUB || env->cc_op == CC_OP_CMP)
> -               src = ~src;
> +    if (env->cc_op == CC_OP_SUB || env->cc_op == CC_OP_CMP) {
> +        src = ~src;
> +    }
>
> -       /* Now, evaluate the flags. This stuff is based on
> -          Per Zander's CRISv10 simulator.  */
> -       switch (env->cc_size)
> -       {
> -               case 1:
> -                       if ((res & 0x80L) != 0L)
> -                       {
> -                               flags |= N_FLAG;
> -                               if (((src & 0x80L) == 0L)
> -                                   && ((dst & 0x80L) == 0L))
> -                               {
> -                                       flags |= V_FLAG;
> -                               }
> -                               else if (((src & 0x80L) != 0L)
> -                                        && ((dst & 0x80L) != 0L))
> -                               {
> -                                       flags |= C_FLAG;
> -                               }
> -                       }
> -                       else
> -                       {
> -                               if ((res & 0xFFL) == 0L)
> -                               {
> -                                       flags |= Z_FLAG;
> -                               }
> -                               if (((src & 0x80L) != 0L)
> -                                   && ((dst & 0x80L) != 0L))
> -                               {
> -                                       flags |= V_FLAG;
> -                               }
> -                               if ((dst & 0x80L) != 0L
> -                                   || (src & 0x80L) != 0L)
> -                               {
> -                                       flags |= C_FLAG;
> -                               }
> -                       }
> -                       break;
> -               case 2:
> -                       if ((res & 0x8000L) != 0L)
> -                       {
> -                               flags |= N_FLAG;
> -                               if (((src & 0x8000L) == 0L)
> -                                   && ((dst & 0x8000L) == 0L))
> -                               {
> -                                       flags |= V_FLAG;
> -                               }
> -                               else if (((src & 0x8000L) != 0L)
> -                                        && ((dst & 0x8000L) != 0L))
> -                               {
> -                                       flags |= C_FLAG;
> -                               }
> -                       }
> -                       else
> -                       {
> -                               if ((res & 0xFFFFL) == 0L)
> -                               {
> -                                       flags |= Z_FLAG;
> -                               }
> -                               if (((src & 0x8000L) != 0L)
> -                                   && ((dst & 0x8000L) != 0L))
> -                               {
> -                                       flags |= V_FLAG;
> -                               }
> -                               if ((dst & 0x8000L) != 0L
> -                                   || (src & 0x8000L) != 0L)
> -                               {
> -                                       flags |= C_FLAG;
> -                               }
> -                       }
> -                       break;
> -               case 4:
> -                       if ((res & 0x80000000L) != 0L)
> -                       {
> -                               flags |= N_FLAG;
> -                               if (((src & 0x80000000L) == 0L)
> -                                   && ((dst & 0x80000000L) == 0L))
> -                               {
> -                                       flags |= V_FLAG;
> -                               }
> -                               else if (((src & 0x80000000L) != 0L) &&
> -                                        ((dst & 0x80000000L) != 0L))
> -                               {
> -                                       flags |= C_FLAG;
> -                               }
> -                       }
> -                       else
> -                       {
> -                               if (res == 0L)
> -                                       flags |= Z_FLAG;
> -                               if (((src & 0x80000000L) != 0L)
> -                                   && ((dst & 0x80000000L) != 0L))
> -                                       flags |= V_FLAG;
> -                               if ((dst & 0x80000000L) != 0L
> -                                   || (src & 0x80000000L) != 0L)
> -                                       flags |= C_FLAG;
> -                       }
> -                       break;
> -               default:
> -                       break;
> -       }
> +    /*
> +     * Now, evaluate the flags. This stuff is based on
> +     * Per Zander's CRISv10 simulator.
> +     */
> +    switch (env->cc_size) {
> +    case 1:
> +        if ((res & 0x80L) != 0L) {
> +            flags |= N_FLAG;
> +            if (((src & 0x80L) == 0L) && ((dst & 0x80L) == 0L)) {
> +                flags |= V_FLAG;
> +            } else if (((src & 0x80L) != 0L) && ((dst & 0x80L) != 0L)) {
> +                flags |= C_FLAG;
> +            }
> +        } else {
> +            if ((res & 0xFFL) == 0L) {
> +                flags |= Z_FLAG;
> +            }
> +            if (((src & 0x80L) != 0L) && ((dst & 0x80L) != 0L)) {
> +                flags |= V_FLAG;
> +            }
> +            if ((dst & 0x80L) != 0L || (src & 0x80L) != 0L) {
> +                flags |= C_FLAG;
> +            }
> +        }
> +        break;
> +    case 2:
> +        if ((res & 0x8000L) != 0L) {
> +            flags |= N_FLAG;
> +            if (((src & 0x8000L) == 0L) && ((dst & 0x8000L) == 0L)) {
> +                flags |= V_FLAG;
> +            } else if (((src & 0x8000L) != 0L) && ((dst & 0x8000L) != 0L)) {
> +                flags |= C_FLAG;
> +            }
> +        } else {
> +            if ((res & 0xFFFFL) == 0L) {
> +                flags |= Z_FLAG;
> +            }
> +            if (((src & 0x8000L) != 0L) && ((dst & 0x8000L) != 0L)) {
> +                flags |= V_FLAG;
> +            }
> +            if ((dst & 0x8000L) != 0L || (src & 0x8000L) != 0L) {
> +                flags |= C_FLAG;
> +            }
> +        }
> +        break;
> +    case 4:
> +        if ((res & 0x80000000L) != 0L) {
> +            flags |= N_FLAG;
> +            if (((src & 0x80000000L) == 0L) && ((dst & 0x80000000L) == 0L)) {
> +                flags |= V_FLAG;
> +            } else if (((src & 0x80000000L) != 0L) &&
> +                       ((dst & 0x80000000L) != 0L)) {
> +                flags |= C_FLAG;
> +            }
> +        } else {
> +            if (res == 0L) {
> +                flags |= Z_FLAG;
> +            }
> +            if (((src & 0x80000000L) != 0L) && ((dst & 0x80000000L) != 0L)) {
> +                flags |= V_FLAG;
> +            }
> +            if ((dst & 0x80000000L) != 0L || (src & 0x80000000L) != 0L) {
> +                flags |= C_FLAG;
> +            }
> +        }
> +        break;
> +    default:
> +        break;
> +    }
>
> -       if (env->cc_op == CC_OP_SUB || env->cc_op == CC_OP_CMP)
> -               flags ^= C_FLAG;
> +    if (env->cc_op == CC_OP_SUB || env->cc_op == CC_OP_CMP) {
> +        flags ^= C_FLAG;
> +    }
>
> -        env->pregs[PR_CCS] = evaluate_flags_writeback(env, flags,
> -                                                      env->pregs[PR_CCS]);
> +    env->pregs[PR_CCS] = evaluate_flags_writeback(env, flags,
> +                                                  env->pregs[PR_CCS]);
>  }
>
>  void helper_top_evaluate_flags(CPUCRISState *env)
>  {
> -       switch (env->cc_op)
> -       {
> -               case CC_OP_MCP:
> -                        env->pregs[PR_CCS] = helper_evaluate_flags_mcp(env,
> -                                       env->pregs[PR_CCS], env->cc_src,
> -                                       env->cc_dest, env->cc_result);
> -                       break;
> -               case CC_OP_MULS:
> -                        env->pregs[PR_CCS] = helper_evaluate_flags_muls(env,
> -                                       env->pregs[PR_CCS], env->cc_result,
> -                                       env->pregs[PR_MOF]);
> -                       break;
> -               case CC_OP_MULU:
> -                        env->pregs[PR_CCS] = helper_evaluate_flags_mulu(env,
> -                                       env->pregs[PR_CCS], env->cc_result,
> -                                       env->pregs[PR_MOF]);
> -                       break;
> -               case CC_OP_MOVE:
> -               case CC_OP_AND:
> -               case CC_OP_OR:
> -               case CC_OP_XOR:
> -               case CC_OP_ASR:
> -               case CC_OP_LSR:
> -               case CC_OP_LSL:
> -               switch (env->cc_size)
> -               {
> -                       case 4:
> -                               env->pregs[PR_CCS] =
> -                                        helper_evaluate_flags_move_4(env,
> -                                                       env->pregs[PR_CCS],
> -                                                       env->cc_result);
> -                               break;
> -                       case 2:
> -                               env->pregs[PR_CCS] =
> -                                        helper_evaluate_flags_move_2(env,
> -                                                       env->pregs[PR_CCS],
> -                                                       env->cc_result);
> -                               break;
> -                       default:
> -                                helper_evaluate_flags(env);
> -                               break;
> -               }
> -               break;
> -               case CC_OP_FLAGS:
> -                       /* live.  */
> -                       break;
> -               case CC_OP_SUB:
> -               case CC_OP_CMP:
> -                       if (env->cc_size == 4)
> -                               env->pregs[PR_CCS] =
> -                                        helper_evaluate_flags_sub_4(env,
> -                                               env->pregs[PR_CCS],
> -                                               env->cc_src, env->cc_dest,
> -                                               env->cc_result);
> -                       else
> -                                helper_evaluate_flags(env);
> -                       break;
> -               default:
> -               {
> -                       switch (env->cc_size)
> -                       {
> -                       case 4:
> -                               env->pregs[PR_CCS] =
> -                                        helper_evaluate_flags_alu_4(env,
> -                                               env->pregs[PR_CCS],
> -                                               env->cc_src, env->cc_dest,
> -                                               env->cc_result);
> -                               break;
> -                       default:
> -                                helper_evaluate_flags(env);
> -                               break;
> -                       }
> -               }
> -               break;
> -       }
> +    switch (env->cc_op) {
> +    case CC_OP_MCP:
> +        env->pregs[PR_CCS]
> +            = helper_evaluate_flags_mcp(env, env->pregs[PR_CCS],
> +                                        env->cc_src, env->cc_dest,
> +                                        env->cc_result);
> +        break;
> +    case CC_OP_MULS:
> +        env->pregs[PR_CCS]
> +            = helper_evaluate_flags_muls(env, env->pregs[PR_CCS],
> +                                         env->cc_result, env->pregs[PR_MOF]);
> +        break;
> +    case CC_OP_MULU:
> +        env->pregs[PR_CCS]
> +            = helper_evaluate_flags_mulu(env, env->pregs[PR_CCS],
> +                                         env->cc_result, env->pregs[PR_MOF]);
> +        break;
> +    case CC_OP_MOVE:
> +    case CC_OP_AND:
> +    case CC_OP_OR:
> +    case CC_OP_XOR:
> +    case CC_OP_ASR:
> +    case CC_OP_LSR:
> +    case CC_OP_LSL:
> +        switch (env->cc_size) {
> +        case 4:
> +            env->pregs[PR_CCS] =
> +                helper_evaluate_flags_move_4(env,
> +                                             env->pregs[PR_CCS],
> +                                             env->cc_result);
> +            break;
> +        case 2:
> +            env->pregs[PR_CCS] =
> +                helper_evaluate_flags_move_2(env,
> +                                             env->pregs[PR_CCS],
> +                                             env->cc_result);
> +            break;
> +        default:
> +            helper_evaluate_flags(env);
> +            break;
> +        }
> +        break;
> +    case CC_OP_FLAGS:
> +        /* live.  */
> +        break;
> +    case CC_OP_SUB:
> +    case CC_OP_CMP:
> +        if (env->cc_size == 4) {
> +            env->pregs[PR_CCS] =
> +                helper_evaluate_flags_sub_4(env,
> +                                            env->pregs[PR_CCS],
> +                                            env->cc_src, env->cc_dest,
> +                                            env->cc_result);
> +        } else {
> +            helper_evaluate_flags(env);
> +        }
> +        break;
> +    default:
> +        switch (env->cc_size) {
> +        case 4:
> +            env->pregs[PR_CCS] =
> +                helper_evaluate_flags_alu_4(env,
> +                                            env->pregs[PR_CCS],
> +                                            env->cc_src, env->cc_dest,
> +                                            env->cc_result);
> +            break;
> +        default:
> +            helper_evaluate_flags(env);
> +            break;
> +        }
> +        break;
> +    }
>  }
> --
> 2.17.1
>
>

