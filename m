Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0685C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 23:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B89206EB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 23:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B89206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVOF8-0001xc-Hf
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 19:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jVOEP-0001XN-E1; Sun, 03 May 2020 19:41:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:43738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jVOEG-00074X-Vs; Sun, 03 May 2020 19:41:08 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 427E1746353;
 Mon,  4 May 2020 01:40:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 077AB746351; Mon,  4 May 2020 01:40:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 05E9A746324;
 Mon,  4 May 2020 01:40:44 +0200 (CEST)
Date: Mon, 4 May 2020 01:40:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?GB2312?Q?=C2=DE=D3=C2=B8=D5=28Yonggang_Luo=29?= <luoyonggang@gmail.com>
Subject: Re: An first try to improve PPC float simulation, not even compiled.
 Just ask question.
In-Reply-To: <CAE2XoE8LO-4Ordhxf1-eNZK1taSGnaU4zxQ944-XLvwzmd9rJg@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2005040128330.7227@zero.eik.bme.hu>
References: <CAE2XoE-XFG8r85yPOhuNS2YUMqhp70q1RXCy+KLT79doW8qHMg@mail.gmail.com>
 <87605674-1cd8-2074-6730-355e20fbf7d0@linaro.org>
 <CAE2XoE8LO-4Ordhxf1-eNZK1taSGnaU4zxQ944-XLvwzmd9rJg@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1000107849-1588548640=:7227"
Content-ID: <alpine.BSF.2.22.395.2005040133090.7227@zero.eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/03 19:40:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1000107849-1588548640=:7227
Content-Type: text/plain; CHARSET=GB2312; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.BSF.2.22.395.2005040133091.7227@zero.eik.bme.hu>

Hello,

On Mon, 4 May 2020, ÂÞÓÂ¸Õ(Yonggang Luo) wrote:
> Hello Richard, Can you have a look at the following patch, and was that are
> the right direction?

Formatting of the patch is broken by your mailer, try sending it with 
something that does not change it otherwise it's a bit hard to read.

Richard suggested to add an assert to check the fp_status is correctly 
cleared in place of helper_reset_fpstatus first for debugging so you could 
change the helper accordingly before deleting it and run a few tests to 
verify it still works. You'll need get some tests and benchmarks working 
to be able to verify your changes that's why I've said that would be step 
0. If you checked that it still produces the same results and the assert 
does not trigger then you can remove the helper.

Regards,
BALATON Zoltan

> From b4d6ca1d6376fab1f1be06eb472e10b908887c2b Mon Sep 17 00:00:00 2001
> From: Yonggang Luo <luoyonggang@gmail.com>
> Date: Sat, 2 May 2020 05:59:25 +0800
> Subject: [PATCH] [ppc fp] Step 1. Rearrange the fp helpers to eliminate
> helper_reset_fpstatus(). I've mentioned this before, that it's possible to
> leave the steady-state of env->fp_status.exception_flags == 0, so there's
> no
> need for a separate function call.  I suspect this is worth a decent
> speedup
> by itself.
>
> ---
> target/ppc/fpu_helper.c            | 53 ++----------------------------
> target/ppc/helper.h                |  1 -
> target/ppc/translate/fp-impl.inc.c | 23 -------------
> 3 files changed, 3 insertions(+), 74 deletions(-)
>
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index d9a8773ee1..4fc5a7ff1c 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -821,6 +821,9 @@ static void do_float_check_status(CPUPPCState *env,
> uintptr_t raddr)
>                                    env->error_code, raddr);
>         }
>     }
> +    if (status) {
> +        set_float_exception_flags(0, &env->fp_status);
> +    }
> }
>
> void helper_float_check_status(CPUPPCState *env)
> @@ -828,11 +831,6 @@ void helper_float_check_status(CPUPPCState *env)
>     do_float_check_status(env, GETPC());
> }
>
> -void helper_reset_fpstatus(CPUPPCState *env)
> -{
> -    set_float_exception_flags(0, &env->fp_status);
> -}
> -
> static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,
>                                     uintptr_t retaddr, int classes)
> {
> @@ -2110,9 +2108,6 @@ void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,
>                       \
> {
>   \
>     ppc_vsr_t t = *xt;
>  \
>     int i;
>  \
> -
>  \
> -    helper_reset_fpstatus(env);
>   \
> -
>  \
>     for (i = 0; i < nels; i++) {
>  \
>         float_status tstat = env->fp_status;
>  \
>         set_float_exception_flags(0, &tstat);
>   \
> @@ -2152,8 +2147,6 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode,
>     ppc_vsr_t t = *xt;
>     float_status tstat;
>
> -    helper_reset_fpstatus(env);
> -
>     tstat = env->fp_status;
>     if (unlikely(Rc(opcode) != 0)) {
>         tstat.float_rounding_mode = float_round_to_odd;
> @@ -2189,9 +2182,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
>                       \
> {
>   \
>     ppc_vsr_t t = *xt;
>  \
>     int i;
>  \
> -
>  \
> -    helper_reset_fpstatus(env);
>   \
> -
>  \
>     for (i = 0; i < nels; i++) {
>  \
>         float_status tstat = env->fp_status;
>  \
>         set_float_exception_flags(0, &tstat);
>   \
> @@ -2228,13 +2218,11 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t
> opcode,
>     ppc_vsr_t t = *xt;
>     float_status tstat;
>
> -    helper_reset_fpstatus(env);
>     tstat = env->fp_status;
>     if (unlikely(Rc(opcode) != 0)) {
>         tstat.float_rounding_mode = float_round_to_odd;
>     }
>
> -    set_float_exception_flags(0, &tstat);
>     t.f128 = float128_mul(xa->f128, xb->f128, &tstat);
>     env->fp_status.float_exception_flags |= tstat.float_exception_flags;
>
> @@ -2263,9 +2251,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
>                        \
> {
>    \
>     ppc_vsr_t t = *xt;
>   \
>     int i;
>   \
> -
>   \
> -    helper_reset_fpstatus(env);
>    \
> -
>   \
>     for (i = 0; i < nels; i++) {
>   \
>         float_status tstat = env->fp_status;
>   \
>         set_float_exception_flags(0, &tstat);
>    \
> @@ -2305,7 +2290,6 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode,
>     ppc_vsr_t t = *xt;
>     float_status tstat;
>
> -    helper_reset_fpstatus(env);
>     tstat = env->fp_status;
>     if (unlikely(Rc(opcode) != 0)) {
>         tstat.float_rounding_mode = float_round_to_odd;
> @@ -2342,9 +2326,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
> ppc_vsr_t *xb)              \
> {
>    \
>     ppc_vsr_t t = *xt;
>   \
>     int i;
>   \
> -
>   \
> -    helper_reset_fpstatus(env);
>    \
> -
>   \
>     for (i = 0; i < nels; i++) {
>   \
>         if (unlikely(tp##_is_signaling_nan(xb->fld, &env->fp_status))) {
>   \
>             float_invalid_op_vxsnan(env, GETPC());
>   \
> @@ -2382,9 +2363,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
> ppc_vsr_t *xb)             \
> {
>   \
>     ppc_vsr_t t = *xt;
>  \
>     int i;
>  \
> -
>  \
> -    helper_reset_fpstatus(env);
>   \
> -
>  \
>     for (i = 0; i < nels; i++) {
>  \
>         float_status tstat = env->fp_status;
>  \
>         set_float_exception_flags(0, &tstat);
>   \
> @@ -2430,9 +2408,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
> ppc_vsr_t *xb)             \
> {
>   \
>     ppc_vsr_t t = *xt;
>  \
>     int i;
>  \
> -
>  \
> -    helper_reset_fpstatus(env);
>   \
> -
>  \
>     for (i = 0; i < nels; i++) {
>  \
>         float_status tstat = env->fp_status;
>  \
>         set_float_exception_flags(0, &tstat);
>   \
> @@ -2592,9 +2567,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
>                        \
> {
>    \
>     ppc_vsr_t t = *xt;
>   \
>     int i;
>   \
> -
>   \
> -    helper_reset_fpstatus(env);
>    \
> -
>   \
>     for (i = 0; i < nels; i++) {
>   \
>         float_status tstat = env->fp_status;
>   \
>         set_float_exception_flags(0, &tstat);
>    \
> @@ -2765,9 +2737,6 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,
>                   \
> {                                                                        \
>     uint32_t cc = 0;                                                     \
>     bool vxsnan_flag = false, vxvc_flag = false;                         \
> -                                                                         \
> -    helper_reset_fpstatus(env);                                          \
> -                                                                         \
>     if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||        \
>         float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {        \
>         vxsnan_flag = true;                                              \
> @@ -2813,9 +2782,6 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,
>                  \
> {                                                                       \
>     uint32_t cc = 0;                                                    \
>     bool vxsnan_flag = false, vxvc_flag = false;                        \
> -                                                                        \
> -    helper_reset_fpstatus(env);                                         \
> -                                                                        \
>     if (float128_is_signaling_nan(xa->f128, &env->fp_status) ||         \
>         float128_is_signaling_nan(xb->f128, &env->fp_status)) {         \
>         vxsnan_flag = true;                                             \
> @@ -3177,9 +3143,6 @@ uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t
> xb)
> {
>     uint64_t result, sign, exp, frac;
>
> -    float_status tstat = env->fp_status;
> -    set_float_exception_flags(0, &tstat);
> -
>     sign = extract64(xb, 63,  1);
>     exp  = extract64(xb, 52, 11);
>     frac = extract64(xb,  0, 52) | 0x10000000000000ULL;
> @@ -3446,8 +3409,6 @@ VSX_ROUND(xvrspiz, 4, float32, VsrW(i),
> float_round_to_zero, 0)
>
> uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
> {
> -    helper_reset_fpstatus(env);
> -
>     uint64_t xt = helper_frsp(env, xb);
>
>     helper_compute_fprf_float64(env, xt);
> @@ -3593,8 +3554,6 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode,
>     uint8_t rmode = 0;
>     float_status tstat;
>
> -    helper_reset_fpstatus(env);
> -
>     if (r == 0 && rmc == 0) {
>         rmode = float_round_ties_away;
>     } else if (r == 0 && rmc == 0x3) {
> @@ -3650,8 +3609,6 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode,
>     floatx80 round_res;
>     float_status tstat;
>
> -    helper_reset_fpstatus(env);
> -
>     if (r == 0 && rmc == 0) {
>         rmode = float_round_ties_away;
>     } else if (r == 0 && rmc == 0x3) {
> @@ -3700,8 +3657,6 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t
> opcode,
>     ppc_vsr_t t = { };
>     float_status tstat;
>
> -    helper_reset_fpstatus(env);
> -
>     tstat = env->fp_status;
>     if (unlikely(Rc(opcode) != 0)) {
>         tstat.float_rounding_mode = float_round_to_odd;
> @@ -3734,8 +3689,6 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opcode,
>     ppc_vsr_t t = *xt;
>     float_status tstat;
>
> -    helper_reset_fpstatus(env);
> -
>     tstat = env->fp_status;
>     if (unlikely(Rc(opcode) != 0)) {
>         tstat.float_rounding_mode = float_round_to_odd;
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 4e192de97b..b486c9991f 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -58,7 +58,6 @@ DEF_HELPER_FLAGS_1(cntlzw32, TCG_CALL_NO_RWG_SE, i32, i32)
> DEF_HELPER_FLAGS_2(brinc, TCG_CALL_NO_RWG_SE, tl, tl, tl)
>
> DEF_HELPER_1(float_check_status, void, env)
> -DEF_HELPER_1(reset_fpstatus, void, env)
> DEF_HELPER_2(compute_fprf_float64, void, env, i64)
> DEF_HELPER_3(store_fpscr, void, env, i64, i32)
> DEF_HELPER_2(fpscr_clrbit, void, env, i32)
> diff --git a/target/ppc/translate/fp-impl.inc.c
> b/target/ppc/translate/fp-impl.inc.c
> index e18e268fe5..5e8cd9970e 100644
> --- a/target/ppc/translate/fp-impl.inc.c
> +++ b/target/ppc/translate/fp-impl.inc.c
> @@ -4,11 +4,6 @@
>  * Standard FPU translation
>  */
>
> -static inline void gen_reset_fpstatus(void)
> -{
> -    gen_helper_reset_fpstatus(cpu_env);
> -}
> -
> static inline void gen_compute_fprf_float64(TCGv_i64 arg)
> {
>     gen_helper_compute_fprf_float64(cpu_env, arg);
> @@ -48,7 +43,6 @@ static void gen_f##name(DisasContext *ctx)
>                     \
>     t3 = tcg_temp_new_i64();
>   \
>     /* NIP cannot be restored if the memory exception comes from an helper
> */ \
>     gen_update_nip(ctx, ctx->base.pc_next - 4);
>    \
> -    gen_reset_fpstatus();
>    \
>     get_fpr(t0, rA(ctx->opcode));
>    \
>     get_fpr(t1, rC(ctx->opcode));
>    \
>     get_fpr(t2, rB(ctx->opcode));
>    \
> @@ -88,7 +82,6 @@ static void gen_f##name(DisasContext *ctx)
>                     \
>     t2 = tcg_temp_new_i64();
>   \
>     /* NIP cannot be restored if the memory exception comes from an helper
> */ \
>     gen_update_nip(ctx, ctx->base.pc_next - 4);
>    \
> -    gen_reset_fpstatus();
>    \
>     get_fpr(t0, rA(ctx->opcode));
>    \
>     get_fpr(t1, rB(ctx->opcode));
>    \
>     gen_helper_f##op(t2, cpu_env, t0, t1);
>   \
> @@ -123,7 +116,6 @@ static void gen_f##name(DisasContext *ctx)
>                       \
>     t0 = tcg_temp_new_i64();
>   \
>     t1 = tcg_temp_new_i64();
>   \
>     t2 = tcg_temp_new_i64();
>   \
> -    gen_reset_fpstatus();
>    \
>     get_fpr(t0, rA(ctx->opcode));
>    \
>     get_fpr(t1, rC(ctx->opcode));
>    \
>     gen_helper_f##op(t2, cpu_env, t0, t1);
>   \
> @@ -156,7 +148,6 @@ static void gen_f##name(DisasContext *ctx)
>                       \
>     }
>    \
>     t0 = tcg_temp_new_i64();
>   \
>     t1 = tcg_temp_new_i64();
>   \
> -    gen_reset_fpstatus();
>    \
>     get_fpr(t0, rB(ctx->opcode));
>    \
>     gen_helper_f##name(t1, cpu_env, t0);
>   \
>     set_fpr(rD(ctx->opcode), t1);
>    \
> @@ -181,7 +172,6 @@ static void gen_f##name(DisasContext *ctx)
>                       \
>     }
>    \
>     t0 = tcg_temp_new_i64();
>   \
>     t1 = tcg_temp_new_i64();
>   \
> -    gen_reset_fpstatus();
>    \
>     get_fpr(t0, rB(ctx->opcode));
>    \
>     gen_helper_f##name(t1, cpu_env, t0);
>   \
>     set_fpr(rD(ctx->opcode), t1);
>    \
> @@ -222,7 +212,6 @@ static void gen_frsqrtes(DisasContext *ctx)
>     }
>     t0 = tcg_temp_new_i64();
>     t1 = tcg_temp_new_i64();
> -    gen_reset_fpstatus();
>     get_fpr(t0, rB(ctx->opcode));
>     gen_helper_frsqrte(t1, cpu_env, t0);
>     gen_helper_frsp(t1, cpu_env, t1);
> @@ -252,7 +241,6 @@ static void gen_fsqrt(DisasContext *ctx)
>     }
>     t0 = tcg_temp_new_i64();
>     t1 = tcg_temp_new_i64();
> -    gen_reset_fpstatus();
>     get_fpr(t0, rB(ctx->opcode));
>     gen_helper_fsqrt(t1, cpu_env, t0);
>     set_fpr(rD(ctx->opcode), t1);
> @@ -274,7 +262,6 @@ static void gen_fsqrts(DisasContext *ctx)
>     }
>     t0 = tcg_temp_new_i64();
>     t1 = tcg_temp_new_i64();
> -    gen_reset_fpstatus();
>     get_fpr(t0, rB(ctx->opcode));
>     gen_helper_fsqrt(t1, cpu_env, t0);
>     gen_helper_frsp(t1, cpu_env, t1);
> @@ -380,7 +367,6 @@ static void gen_fcmpo(DisasContext *ctx)
>     }
>     t0 = tcg_temp_new_i64();
>     t1 = tcg_temp_new_i64();
> -    gen_reset_fpstatus();
>     crf = tcg_const_i32(crfD(ctx->opcode));
>     get_fpr(t0, rA(ctx->opcode));
>     get_fpr(t1, rB(ctx->opcode));
> @@ -403,7 +389,6 @@ static void gen_fcmpu(DisasContext *ctx)
>     }
>     t0 = tcg_temp_new_i64();
>     t1 = tcg_temp_new_i64();
> -    gen_reset_fpstatus();
>     crf = tcg_const_i32(crfD(ctx->opcode));
>     get_fpr(t0, rA(ctx->opcode));
>     get_fpr(t1, rB(ctx->opcode));
> @@ -612,7 +597,6 @@ static void gen_mffs(DisasContext *ctx)
>         return;
>     }
>     t0 = tcg_temp_new_i64();
> -    gen_reset_fpstatus();
>     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
>     set_fpr(rD(ctx->opcode), t0);
>     if (unlikely(Rc(ctx->opcode))) {
> @@ -635,7 +619,6 @@ static void gen_mffsl(DisasContext *ctx)
>         return;
>     }
>     t0 = tcg_temp_new_i64();
> -    gen_reset_fpstatus();
>     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
>     /* Mask everything except mode, status, and enables.  */
>     tcg_gen_andi_i64(t0, t0, FP_DRN | FP_STATUS | FP_ENABLES | FP_RN);
> @@ -660,7 +643,6 @@ static void gen_mffsce(DisasContext *ctx)
>
>     t0 = tcg_temp_new_i64();
>
> -    gen_reset_fpstatus();
>     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
>     set_fpr(rD(ctx->opcode), t0);
>
> @@ -678,7 +660,6 @@ static void gen_helper_mffscrn(DisasContext *ctx,
> TCGv_i64 t1)
>     TCGv_i64 t0 = tcg_temp_new_i64();
>     TCGv_i32 mask = tcg_const_i32(0x0001);
>
> -    gen_reset_fpstatus();
>     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
>     tcg_gen_andi_i64(t0, t0, FP_DRN | FP_ENABLES | FP_RN);
>     set_fpr(rD(ctx->opcode), t0);
> @@ -750,7 +731,6 @@ static void gen_mtfsb0(DisasContext *ctx)
>         return;
>     }
>     crb = 31 - crbD(ctx->opcode);
> -    gen_reset_fpstatus();
>     if (likely(crb != FPSCR_FEX && crb != FPSCR_VX)) {
>         TCGv_i32 t0;
>         t0 = tcg_const_i32(crb);
> @@ -773,7 +753,6 @@ static void gen_mtfsb1(DisasContext *ctx)
>         return;
>     }
>     crb = 31 - crbD(ctx->opcode);
> -    gen_reset_fpstatus();
>     /* XXX: we pretend we can only do IEEE floating-point computations */
>     if (likely(crb != FPSCR_FEX && crb != FPSCR_VX && crb != FPSCR_NI)) {
>         TCGv_i32 t0;
> @@ -807,7 +786,6 @@ static void gen_mtfsf(DisasContext *ctx)
>         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>         return;
>     }
> -    gen_reset_fpstatus();
>     if (l) {
>         t0 = tcg_const_i32((ctx->insns_flags2 & PPC2_ISA205) ? 0xffff :
> 0xff);
>     } else {
> @@ -844,7 +822,6 @@ static void gen_mtfsfi(DisasContext *ctx)
>         return;
>     }
>     sh = (8 * w) + 7 - bf;
> -    gen_reset_fpstatus();
>     t0 = tcg_const_i64(((uint64_t)FPIMM(ctx->opcode)) << (4 * sh));
>     t1 = tcg_const_i32(1 << sh);
>     gen_helper_store_fpscr(cpu_env, t0, t1);
>
--3866299591-1000107849-1588548640=:7227--

