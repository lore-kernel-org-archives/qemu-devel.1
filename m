Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C9BC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 19:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D914C206E9
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 19:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeAjjHuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D914C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVKbG-0004xB-W5
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 15:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVKZI-0003cP-PT; Sun, 03 May 2020 15:46:28 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:32924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVKZG-0003Oc-Ep; Sun, 03 May 2020 15:46:28 -0400
Received: by mail-lj1-x233.google.com with SMTP id w20so7678926ljj.0;
 Sun, 03 May 2020 12:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=eKerPi60E29unvOuuth9izTCARN9ATaho3qu/BJb2fM=;
 b=XeAjjHuAw+KKPBYy0qkq4VT1hP6zkQa6eEXbItBc5/jqFI1Aa3ArlDK5ClDhFKEy18
 Jf0DKM3EoEuTEjb8bGzIqld/Zcu4QhxmwhpJ9ahztAU757NQjNoJoWgrFbashiJdjtdV
 Wdw89yPcmS5ff6zsXH5Z+SSjH+D6f/g0HMgDFo4Gb0grd7BvOnbDdl2HiALF/IT4MJvY
 NV/Eikoa6V+tlFFLF8nxogmNzsb9l+HatmDbvT74rJX9fM77CdpnjCKopn9TJ2eAFFVw
 ZonDLh1uHt+grRdMq8TwGobWmeOEkLPwZZAz2SfOYMXb/VSwTcJAV3vm9+48aAtYods2
 KfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=eKerPi60E29unvOuuth9izTCARN9ATaho3qu/BJb2fM=;
 b=gMvODciI5OSqQKruurXAVQ37YHAxE6owTeSWtGOWjheZqBnvrn9UtKcsqsI0/733sX
 xfQN0ZQWNf0GGhSKnRo+UQztSbeXhpm8l5X6C03V8dgEENwt4AmOSF4od2RYcTh+tq0v
 FiCCYBcgDmeHnJmMjwRNp3tPHE5h/t09ly0tjnFPl5Im/7cIfE2+9IOg9aM92vtCPZd6
 aqsjy58USuTAtBNs0dEHEL338ZWwgg3RkBsfVZO40PsvH9hP4wt9gF9rqpczb4hsyonL
 zyztHu9wDFdH/fzBMLOSeAiTKYnVUthKGsvRUhCcJKpat6XRZ6DiQHpiS1P9JSeooE60
 jzDQ==
X-Gm-Message-State: AGi0Pub9dFJTREVOszEduttTElY7MEh5Kb2nEecO4HUSH34APYJNaMnc
 6j0fXnP5VH8AK5a0loz8IgzhbQtJlRnNdTWR8k0=
X-Google-Smtp-Source: APiQypIufE17palAO8GyQNMTqirELYI9xFQDiSlIfXdc7o2/60aPwujMvz+51cnk0PzCoaAgvl+MIVMP7bHwXGrw3j4=
X-Received: by 2002:a2e:800f:: with SMTP id j15mr8559891ljg.27.1588535184089; 
 Sun, 03 May 2020 12:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-XFG8r85yPOhuNS2YUMqhp70q1RXCy+KLT79doW8qHMg@mail.gmail.com>
 <87605674-1cd8-2074-6730-355e20fbf7d0@linaro.org>
In-Reply-To: <87605674-1cd8-2074-6730-355e20fbf7d0@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 4 May 2020 03:46:12 +0800
Message-ID: <CAE2XoE8LO-4Ordhxf1-eNZK1taSGnaU4zxQ944-XLvwzmd9rJg@mail.gmail.com>
Subject: Re: An first try to improve PPC float simulation, not even compiled.
 Just ask question.
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005c64d405a4c3ab85"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x233.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.979, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: luoyonggang@gmail.com
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005c64d405a4c3ab85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Richard, Can you have a look at the following patch, and was that are
the right direction?
From b4d6ca1d6376fab1f1be06eb472e10b908887c2b Mon Sep 17 00:00:00 2001
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 2 May 2020 05:59:25 +0800
Subject: [PATCH] [ppc fp] Step 1. Rearrange the fp helpers to eliminate
 helper_reset_fpstatus(). I've mentioned this before, that it's possible to
 leave the steady-state of env->fp_status.exception_flags =3D=3D 0, so ther=
e's
no
 need for a separate function call.  I suspect this is worth a decent
speedup
 by itself.

---
 target/ppc/fpu_helper.c            | 53 ++----------------------------
 target/ppc/helper.h                |  1 -
 target/ppc/translate/fp-impl.inc.c | 23 -------------
 3 files changed, 3 insertions(+), 74 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index d9a8773ee1..4fc5a7ff1c 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -821,6 +821,9 @@ static void do_float_check_status(CPUPPCState *env,
uintptr_t raddr)
                                    env->error_code, raddr);
         }
     }
+    if (status) {
+        set_float_exception_flags(0, &env->fp_status);
+    }
 }

 void helper_float_check_status(CPUPPCState *env)
@@ -828,11 +831,6 @@ void helper_float_check_status(CPUPPCState *env)
     do_float_check_status(env, GETPC());
 }

-void helper_reset_fpstatus(CPUPPCState *env)
-{
-    set_float_exception_flags(0, &env->fp_status);
-}
-
 static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,
                                     uintptr_t retaddr, int classes)
 {
@@ -2110,9 +2108,6 @@ void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,
                       \
 {
   \
     ppc_vsr_t t =3D *xt;
  \
     int i;
  \
-
  \
-    helper_reset_fpstatus(env);
   \
-
  \
     for (i =3D 0; i < nels; i++) {
  \
         float_status tstat =3D env->fp_status;
  \
         set_float_exception_flags(0, &tstat);
   \
@@ -2152,8 +2147,6 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode=
,
     ppc_vsr_t t =3D *xt;
     float_status tstat;

-    helper_reset_fpstatus(env);
-
     tstat =3D env->fp_status;
     if (unlikely(Rc(opcode) !=3D 0)) {
         tstat.float_rounding_mode =3D float_round_to_odd;
@@ -2189,9 +2182,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
                       \
 {
   \
     ppc_vsr_t t =3D *xt;
  \
     int i;
  \
-
  \
-    helper_reset_fpstatus(env);
   \
-
  \
     for (i =3D 0; i < nels; i++) {
  \
         float_status tstat =3D env->fp_status;
  \
         set_float_exception_flags(0, &tstat);
   \
@@ -2228,13 +2218,11 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t
opcode,
     ppc_vsr_t t =3D *xt;
     float_status tstat;

-    helper_reset_fpstatus(env);
     tstat =3D env->fp_status;
     if (unlikely(Rc(opcode) !=3D 0)) {
         tstat.float_rounding_mode =3D float_round_to_odd;
     }

-    set_float_exception_flags(0, &tstat);
     t.f128 =3D float128_mul(xa->f128, xb->f128, &tstat);
     env->fp_status.float_exception_flags |=3D tstat.float_exception_flags;

@@ -2263,9 +2251,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
                        \
 {
    \
     ppc_vsr_t t =3D *xt;
   \
     int i;
   \
-
   \
-    helper_reset_fpstatus(env);
    \
-
   \
     for (i =3D 0; i < nels; i++) {
   \
         float_status tstat =3D env->fp_status;
   \
         set_float_exception_flags(0, &tstat);
    \
@@ -2305,7 +2290,6 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode=
,
     ppc_vsr_t t =3D *xt;
     float_status tstat;

-    helper_reset_fpstatus(env);
     tstat =3D env->fp_status;
     if (unlikely(Rc(opcode) !=3D 0)) {
         tstat.float_rounding_mode =3D float_round_to_odd;
@@ -2342,9 +2326,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
ppc_vsr_t *xb)              \
 {
    \
     ppc_vsr_t t =3D *xt;
   \
     int i;
   \
-
   \
-    helper_reset_fpstatus(env);
    \
-
   \
     for (i =3D 0; i < nels; i++) {
   \
         if (unlikely(tp##_is_signaling_nan(xb->fld, &env->fp_status))) {
   \
             float_invalid_op_vxsnan(env, GETPC());
   \
@@ -2382,9 +2363,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
ppc_vsr_t *xb)             \
 {
   \
     ppc_vsr_t t =3D *xt;
  \
     int i;
  \
-
  \
-    helper_reset_fpstatus(env);
   \
-
  \
     for (i =3D 0; i < nels; i++) {
  \
         float_status tstat =3D env->fp_status;
  \
         set_float_exception_flags(0, &tstat);
   \
@@ -2430,9 +2408,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
ppc_vsr_t *xb)             \
 {
   \
     ppc_vsr_t t =3D *xt;
  \
     int i;
  \
-
  \
-    helper_reset_fpstatus(env);
   \
-
  \
     for (i =3D 0; i < nels; i++) {
  \
         float_status tstat =3D env->fp_status;
  \
         set_float_exception_flags(0, &tstat);
   \
@@ -2592,9 +2567,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
                        \
 {
    \
     ppc_vsr_t t =3D *xt;
   \
     int i;
   \
-
   \
-    helper_reset_fpstatus(env);
    \
-
   \
     for (i =3D 0; i < nels; i++) {
   \
         float_status tstat =3D env->fp_status;
   \
         set_float_exception_flags(0, &tstat);
    \
@@ -2765,9 +2737,6 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,
                   \
 {                                                                        \
     uint32_t cc =3D 0;                                                    =
 \
     bool vxsnan_flag =3D false, vxvc_flag =3D false;                      =
   \
-                                                                         \
-    helper_reset_fpstatus(env);                                          \
-                                                                         \
     if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||        \
         float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {        \
         vxsnan_flag =3D true;                                             =
 \
@@ -2813,9 +2782,6 @@ void helper_##op(CPUPPCState *env, uint32_t opcode,
                  \
 {                                                                       \
     uint32_t cc =3D 0;                                                    =
\
     bool vxsnan_flag =3D false, vxvc_flag =3D false;                      =
  \
-                                                                        \
-    helper_reset_fpstatus(env);                                         \
-                                                                        \
     if (float128_is_signaling_nan(xa->f128, &env->fp_status) ||         \
         float128_is_signaling_nan(xb->f128, &env->fp_status)) {         \
         vxsnan_flag =3D true;                                             =
\
@@ -3177,9 +3143,6 @@ uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t
xb)
 {
     uint64_t result, sign, exp, frac;

-    float_status tstat =3D env->fp_status;
-    set_float_exception_flags(0, &tstat);
-
     sign =3D extract64(xb, 63,  1);
     exp  =3D extract64(xb, 52, 11);
     frac =3D extract64(xb,  0, 52) | 0x10000000000000ULL;
@@ -3446,8 +3409,6 @@ VSX_ROUND(xvrspiz, 4, float32, VsrW(i),
float_round_to_zero, 0)

 uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
 {
-    helper_reset_fpstatus(env);
-
     uint64_t xt =3D helper_frsp(env, xb);

     helper_compute_fprf_float64(env, xt);
@@ -3593,8 +3554,6 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode,
     uint8_t rmode =3D 0;
     float_status tstat;

-    helper_reset_fpstatus(env);
-
     if (r =3D=3D 0 && rmc =3D=3D 0) {
         rmode =3D float_round_ties_away;
     } else if (r =3D=3D 0 && rmc =3D=3D 0x3) {
@@ -3650,8 +3609,6 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode=
,
     floatx80 round_res;
     float_status tstat;

-    helper_reset_fpstatus(env);
-
     if (r =3D=3D 0 && rmc =3D=3D 0) {
         rmode =3D float_round_ties_away;
     } else if (r =3D=3D 0 && rmc =3D=3D 0x3) {
@@ -3700,8 +3657,6 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t
opcode,
     ppc_vsr_t t =3D { };
     float_status tstat;

-    helper_reset_fpstatus(env);
-
     tstat =3D env->fp_status;
     if (unlikely(Rc(opcode) !=3D 0)) {
         tstat.float_rounding_mode =3D float_round_to_odd;
@@ -3734,8 +3689,6 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opcode=
,
     ppc_vsr_t t =3D *xt;
     float_status tstat;

-    helper_reset_fpstatus(env);
-
     tstat =3D env->fp_status;
     if (unlikely(Rc(opcode) !=3D 0)) {
         tstat.float_rounding_mode =3D float_round_to_odd;
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 4e192de97b..b486c9991f 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -58,7 +58,6 @@ DEF_HELPER_FLAGS_1(cntlzw32, TCG_CALL_NO_RWG_SE, i32, i32=
)
 DEF_HELPER_FLAGS_2(brinc, TCG_CALL_NO_RWG_SE, tl, tl, tl)

 DEF_HELPER_1(float_check_status, void, env)
-DEF_HELPER_1(reset_fpstatus, void, env)
 DEF_HELPER_2(compute_fprf_float64, void, env, i64)
 DEF_HELPER_3(store_fpscr, void, env, i64, i32)
 DEF_HELPER_2(fpscr_clrbit, void, env, i32)
diff --git a/target/ppc/translate/fp-impl.inc.c
b/target/ppc/translate/fp-impl.inc.c
index e18e268fe5..5e8cd9970e 100644
--- a/target/ppc/translate/fp-impl.inc.c
+++ b/target/ppc/translate/fp-impl.inc.c
@@ -4,11 +4,6 @@
  * Standard FPU translation
  */

-static inline void gen_reset_fpstatus(void)
-{
-    gen_helper_reset_fpstatus(cpu_env);
-}
-
 static inline void gen_compute_fprf_float64(TCGv_i64 arg)
 {
     gen_helper_compute_fprf_float64(cpu_env, arg);
@@ -48,7 +43,6 @@ static void gen_f##name(DisasContext *ctx)
                     \
     t3 =3D tcg_temp_new_i64();
   \
     /* NIP cannot be restored if the memory exception comes from an helper
*/ \
     gen_update_nip(ctx, ctx->base.pc_next - 4);
    \
-    gen_reset_fpstatus();
    \
     get_fpr(t0, rA(ctx->opcode));
    \
     get_fpr(t1, rC(ctx->opcode));
    \
     get_fpr(t2, rB(ctx->opcode));
    \
@@ -88,7 +82,6 @@ static void gen_f##name(DisasContext *ctx)
                     \
     t2 =3D tcg_temp_new_i64();
   \
     /* NIP cannot be restored if the memory exception comes from an helper
*/ \
     gen_update_nip(ctx, ctx->base.pc_next - 4);
    \
-    gen_reset_fpstatus();
    \
     get_fpr(t0, rA(ctx->opcode));
    \
     get_fpr(t1, rB(ctx->opcode));
    \
     gen_helper_f##op(t2, cpu_env, t0, t1);
   \
@@ -123,7 +116,6 @@ static void gen_f##name(DisasContext *ctx)
                       \
     t0 =3D tcg_temp_new_i64();
   \
     t1 =3D tcg_temp_new_i64();
   \
     t2 =3D tcg_temp_new_i64();
   \
-    gen_reset_fpstatus();
    \
     get_fpr(t0, rA(ctx->opcode));
    \
     get_fpr(t1, rC(ctx->opcode));
    \
     gen_helper_f##op(t2, cpu_env, t0, t1);
   \
@@ -156,7 +148,6 @@ static void gen_f##name(DisasContext *ctx)
                       \
     }
    \
     t0 =3D tcg_temp_new_i64();
   \
     t1 =3D tcg_temp_new_i64();
   \
-    gen_reset_fpstatus();
    \
     get_fpr(t0, rB(ctx->opcode));
    \
     gen_helper_f##name(t1, cpu_env, t0);
   \
     set_fpr(rD(ctx->opcode), t1);
    \
@@ -181,7 +172,6 @@ static void gen_f##name(DisasContext *ctx)
                       \
     }
    \
     t0 =3D tcg_temp_new_i64();
   \
     t1 =3D tcg_temp_new_i64();
   \
-    gen_reset_fpstatus();
    \
     get_fpr(t0, rB(ctx->opcode));
    \
     gen_helper_f##name(t1, cpu_env, t0);
   \
     set_fpr(rD(ctx->opcode), t1);
    \
@@ -222,7 +212,6 @@ static void gen_frsqrtes(DisasContext *ctx)
     }
     t0 =3D tcg_temp_new_i64();
     t1 =3D tcg_temp_new_i64();
-    gen_reset_fpstatus();
     get_fpr(t0, rB(ctx->opcode));
     gen_helper_frsqrte(t1, cpu_env, t0);
     gen_helper_frsp(t1, cpu_env, t1);
@@ -252,7 +241,6 @@ static void gen_fsqrt(DisasContext *ctx)
     }
     t0 =3D tcg_temp_new_i64();
     t1 =3D tcg_temp_new_i64();
-    gen_reset_fpstatus();
     get_fpr(t0, rB(ctx->opcode));
     gen_helper_fsqrt(t1, cpu_env, t0);
     set_fpr(rD(ctx->opcode), t1);
@@ -274,7 +262,6 @@ static void gen_fsqrts(DisasContext *ctx)
     }
     t0 =3D tcg_temp_new_i64();
     t1 =3D tcg_temp_new_i64();
-    gen_reset_fpstatus();
     get_fpr(t0, rB(ctx->opcode));
     gen_helper_fsqrt(t1, cpu_env, t0);
     gen_helper_frsp(t1, cpu_env, t1);
@@ -380,7 +367,6 @@ static void gen_fcmpo(DisasContext *ctx)
     }
     t0 =3D tcg_temp_new_i64();
     t1 =3D tcg_temp_new_i64();
-    gen_reset_fpstatus();
     crf =3D tcg_const_i32(crfD(ctx->opcode));
     get_fpr(t0, rA(ctx->opcode));
     get_fpr(t1, rB(ctx->opcode));
@@ -403,7 +389,6 @@ static void gen_fcmpu(DisasContext *ctx)
     }
     t0 =3D tcg_temp_new_i64();
     t1 =3D tcg_temp_new_i64();
-    gen_reset_fpstatus();
     crf =3D tcg_const_i32(crfD(ctx->opcode));
     get_fpr(t0, rA(ctx->opcode));
     get_fpr(t1, rB(ctx->opcode));
@@ -612,7 +597,6 @@ static void gen_mffs(DisasContext *ctx)
         return;
     }
     t0 =3D tcg_temp_new_i64();
-    gen_reset_fpstatus();
     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
     set_fpr(rD(ctx->opcode), t0);
     if (unlikely(Rc(ctx->opcode))) {
@@ -635,7 +619,6 @@ static void gen_mffsl(DisasContext *ctx)
         return;
     }
     t0 =3D tcg_temp_new_i64();
-    gen_reset_fpstatus();
     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
     /* Mask everything except mode, status, and enables.  */
     tcg_gen_andi_i64(t0, t0, FP_DRN | FP_STATUS | FP_ENABLES | FP_RN);
@@ -660,7 +643,6 @@ static void gen_mffsce(DisasContext *ctx)

     t0 =3D tcg_temp_new_i64();

-    gen_reset_fpstatus();
     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
     set_fpr(rD(ctx->opcode), t0);

@@ -678,7 +660,6 @@ static void gen_helper_mffscrn(DisasContext *ctx,
TCGv_i64 t1)
     TCGv_i64 t0 =3D tcg_temp_new_i64();
     TCGv_i32 mask =3D tcg_const_i32(0x0001);

-    gen_reset_fpstatus();
     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
     tcg_gen_andi_i64(t0, t0, FP_DRN | FP_ENABLES | FP_RN);
     set_fpr(rD(ctx->opcode), t0);
@@ -750,7 +731,6 @@ static void gen_mtfsb0(DisasContext *ctx)
         return;
     }
     crb =3D 31 - crbD(ctx->opcode);
-    gen_reset_fpstatus();
     if (likely(crb !=3D FPSCR_FEX && crb !=3D FPSCR_VX)) {
         TCGv_i32 t0;
         t0 =3D tcg_const_i32(crb);
@@ -773,7 +753,6 @@ static void gen_mtfsb1(DisasContext *ctx)
         return;
     }
     crb =3D 31 - crbD(ctx->opcode);
-    gen_reset_fpstatus();
     /* XXX: we pretend we can only do IEEE floating-point computations */
     if (likely(crb !=3D FPSCR_FEX && crb !=3D FPSCR_VX && crb !=3D FPSCR_N=
I)) {
         TCGv_i32 t0;
@@ -807,7 +786,6 @@ static void gen_mtfsf(DisasContext *ctx)
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
     }
-    gen_reset_fpstatus();
     if (l) {
         t0 =3D tcg_const_i32((ctx->insns_flags2 & PPC2_ISA205) ? 0xffff :
0xff);
     } else {
@@ -844,7 +822,6 @@ static void gen_mtfsfi(DisasContext *ctx)
         return;
     }
     sh =3D (8 * w) + 7 - bf;
-    gen_reset_fpstatus();
     t0 =3D tcg_const_i64(((uint64_t)FPIMM(ctx->opcode)) << (4 * sh));
     t1 =3D tcg_const_i32(1 << sh);
     gen_helper_store_fpscr(cpu_env, t0, t1);
--=20
2.23.0.windows.1


On Sat, May 2, 2020 at 4:49 AM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 5/1/20 1:04 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > And  fp_status can not represent all the  Invalid Operation Exception
> flags.
> > What I need to do to represent all the  Invalid Operation Exception
>
> Ideally, we add them to include/fpu/softfloat-types.h, expand the
> float_exception_flags field in float_status to match, and generate the ne=
w
> flags in fpu/softfloat.c.
>
> This would actually help target/tricore as well.
>
>
> r~
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000005c64d405a4c3ab85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGVsbG8gUmljaGFyZCwgQ2FuIHlvdSBoYXZlIGEgbG9vayBhdCB0aGUg
Zm9sbG93aW5nIHBhdGNoLCBhbmQgd2FzIHRoYXQgYXJlIHRoZSByaWdodCBkaXJlY3Rpb24/PGRp
dj5Gcm9tIGI0ZDZjYTFkNjM3NmZhYjFmMWJlMDZlYjQ3MmUxMGI5MDg4ODdjMmIgTW9uIFNlcCAx
NyAwMDowMDowMCAyMDAxPGJyPkZyb206IFlvbmdnYW5nIEx1byAmbHQ7PGEgaHJlZj0ibWFpbHRv
Omx1b3lvbmdnYW5nQGdtYWlsLmNvbSI+bHVveW9uZ2dhbmdAZ21haWwuY29tPC9hPiZndDs8YnI+
RGF0ZTogU2F0LCAyIE1heSAyMDIwIDA1OjU5OjI1ICswODAwPGJyPlN1YmplY3Q6IFtQQVRDSF0g
W3BwYyBmcF0gU3RlcCAxLiBSZWFycmFuZ2UgdGhlIGZwIGhlbHBlcnMgdG8gZWxpbWluYXRlPGJy
PsKgaGVscGVyX3Jlc2V0X2Zwc3RhdHVzKCkuIEkmIzM5O3ZlIG1lbnRpb25lZCB0aGlzIGJlZm9y
ZSwgdGhhdCBpdCYjMzk7cyBwb3NzaWJsZSB0bzxicj7CoGxlYXZlIHRoZSBzdGVhZHktc3RhdGUg
b2YgZW52LSZndDtmcF9zdGF0dXMuZXhjZXB0aW9uX2ZsYWdzID09IDAsIHNvIHRoZXJlJiMzOTtz
IG5vPGJyPsKgbmVlZCBmb3IgYSBzZXBhcmF0ZSBmdW5jdGlvbiBjYWxsLsKgIEkgc3VzcGVjdCB0
aGlzIGlzIHdvcnRoIGEgZGVjZW50IHNwZWVkdXA8YnI+wqBieSBpdHNlbGYuPGJyPjxicj4tLS08
YnI+wqB0YXJnZXQvcHBjL2ZwdV9oZWxwZXIuYyDCoCDCoCDCoCDCoCDCoCDCoHwgNTMgKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPsKgdGFyZ2V0L3BwYy9oZWxwZXIuaCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHwgwqAxIC08YnI+wqB0YXJnZXQvcHBjL3RyYW5zbGF0ZS9mcC1pbXBs
LmluYy5jIHwgMjMgLS0tLS0tLS0tLS0tLTxicj7CoDMgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCA3NCBkZWxldGlvbnMoLSk8YnI+PGJyPmRpZmYgLS1naXQgYS90YXJnZXQvcHBjL2Zw
dV9oZWxwZXIuYyBiL3RhcmdldC9wcGMvZnB1X2hlbHBlci5jPGJyPmluZGV4IGQ5YTg3NzNlZTEu
LjRmYzVhN2ZmMWMgMTAwNjQ0PGJyPi0tLSBhL3RhcmdldC9wcGMvZnB1X2hlbHBlci5jPGJyPisr
KyBiL3RhcmdldC9wcGMvZnB1X2hlbHBlci5jPGJyPkBAIC04MjEsNiArODIxLDkgQEAgc3RhdGlj
IHZvaWQgZG9fZmxvYXRfY2hlY2tfc3RhdHVzKENQVVBQQ1N0YXRlICplbnYsIHVpbnRwdHJfdCBy
YWRkcik8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgZW52LSZndDtlcnJvcl9jb2RlLCByYWRkcik7PGJyPsKgIMKgIMKgIMKgIMKgfTxicj7C
oCDCoCDCoH08YnI+KyDCoCDCoGlmIChzdGF0dXMpIHs8YnI+KyDCoCDCoCDCoCDCoHNldF9mbG9h
dF9leGNlcHRpb25fZmxhZ3MoMCwgJmFtcDtlbnYtJmd0O2ZwX3N0YXR1cyk7PGJyPisgwqAgwqB9
PGJyPsKgfTxicj7CoDxicj7CoHZvaWQgaGVscGVyX2Zsb2F0X2NoZWNrX3N0YXR1cyhDUFVQUENT
dGF0ZSAqZW52KTxicj5AQCAtODI4LDExICs4MzEsNiBAQCB2b2lkIGhlbHBlcl9mbG9hdF9jaGVj
a19zdGF0dXMoQ1BVUFBDU3RhdGUgKmVudik8YnI+wqAgwqAgwqBkb19mbG9hdF9jaGVja19zdGF0
dXMoZW52LCBHRVRQQygpKTs8YnI+wqB9PGJyPsKgPGJyPi12b2lkIGhlbHBlcl9yZXNldF9mcHN0
YXR1cyhDUFVQUENTdGF0ZSAqZW52KTxicj4tezxicj4tIMKgIMKgc2V0X2Zsb2F0X2V4Y2VwdGlv
bl9mbGFncygwLCAmYW1wO2Vudi0mZ3Q7ZnBfc3RhdHVzKTs8YnI+LX08YnI+LTxicj7CoHN0YXRp
YyB2b2lkIGZsb2F0X2ludmFsaWRfb3BfYWRkc3ViKENQVVBQQ1N0YXRlICplbnYsIGJvb2wgc2V0
X2ZwY2MsPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgdWludHB0cl90IHJldGFkZHIsIGludCBjbGFzc2VzKTxicj7CoHs8YnI+QEAgLTIx
MTAsOSArMjEwOCw2IEBAIHZvaWQgaGVscGVyXyMjbmFtZShDUFVQUENTdGF0ZSAqZW52LCBwcGNf
dnNyX3QgKnh0LCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqB7
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
XDxicj7CoCDCoCDCoHBwY192c3JfdCB0ID0gKnh0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBc
PGJyPsKgIMKgIMKgaW50IGk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFw8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBcPGJyPi0gwqAgwqBoZWxwZXJfcmVzZXRfZnBzdGF0dXMoZW52KTsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBcPGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBuZWxzOyBpKyspIHsg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgXDxicj7CoCDCoCDCoCDCoCDCoGZsb2F0X3N0YXR1cyB0c3RhdCA9IGVudi0mZ3Q7
ZnBfc3RhdHVzOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBcPGJyPsKgIMKgIMKgIMKgIMKgc2V0X2Zsb2F0X2V4Y2VwdGlvbl9mbGFncygwLCAmYW1wO3Rz
dGF0KTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJy
PkBAIC0yMTUyLDggKzIxNDcsNiBAQCB2b2lkIGhlbHBlcl94c2FkZHFwKENQVVBQQ1N0YXRlICpl
bnYsIHVpbnQzMl90IG9wY29kZSw8YnI+wqAgwqAgwqBwcGNfdnNyX3QgdCA9ICp4dDs8YnI+wqAg
wqAgwqBmbG9hdF9zdGF0dXMgdHN0YXQ7PGJyPsKgPGJyPi0gwqAgwqBoZWxwZXJfcmVzZXRfZnBz
dGF0dXMoZW52KTs8YnI+LTxicj7CoCDCoCDCoHRzdGF0ID0gZW52LSZndDtmcF9zdGF0dXM7PGJy
PsKgIMKgIMKgaWYgKHVubGlrZWx5KFJjKG9wY29kZSkgIT0gMCkpIHs8YnI+wqAgwqAgwqAgwqAg
wqB0c3RhdC5mbG9hdF9yb3VuZGluZ19tb2RlID0gZmxvYXRfcm91bmRfdG9fb2RkOzxicj5AQCAt
MjE4OSw5ICsyMTgyLDYgQEAgdm9pZCBoZWxwZXJfIyNvcChDUFVQUENTdGF0ZSAqZW52LCBwcGNf
dnNyX3QgKnh0LCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
wqB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXDxicj7CoCDCoCDCoHBwY192c3JfdCB0ID0gKnh0OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBcPGJyPsKgIMKgIMKgaW50IGk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFw8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBcPGJyPi0gwqAgwqBoZWxwZXJfcmVzZXRfZnBzdGF0dXMoZW52KTsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBcPGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBuZWxzOyBpKysp
IHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoCDCoCDCoGZsb2F0X3N0YXR1cyB0c3RhdCA9IGVudi0m
Z3Q7ZnBfc3RhdHVzOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBcPGJyPsKgIMKgIMKgIMKgIMKgc2V0X2Zsb2F0X2V4Y2VwdGlvbl9mbGFncygwLCAmYW1w
O3RzdGF0KTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBc
PGJyPkBAIC0yMjI4LDEzICsyMjE4LDExIEBAIHZvaWQgaGVscGVyX3hzbXVscXAoQ1BVUFBDU3Rh
dGUgKmVudiwgdWludDMyX3Qgb3Bjb2RlLDxicj7CoCDCoCDCoHBwY192c3JfdCB0ID0gKnh0Ozxi
cj7CoCDCoCDCoGZsb2F0X3N0YXR1cyB0c3RhdDs8YnI+wqA8YnI+LSDCoCDCoGhlbHBlcl9yZXNl
dF9mcHN0YXR1cyhlbnYpOzxicj7CoCDCoCDCoHRzdGF0ID0gZW52LSZndDtmcF9zdGF0dXM7PGJy
PsKgIMKgIMKgaWYgKHVubGlrZWx5KFJjKG9wY29kZSkgIT0gMCkpIHs8YnI+wqAgwqAgwqAgwqAg
wqB0c3RhdC5mbG9hdF9yb3VuZGluZ19tb2RlID0gZmxvYXRfcm91bmRfdG9fb2RkOzxicj7CoCDC
oCDCoH08YnI+wqA8YnI+LSDCoCDCoHNldF9mbG9hdF9leGNlcHRpb25fZmxhZ3MoMCwgJmFtcDt0
c3RhdCk7PGJyPsKgIMKgIMKgdC5mMTI4ID0gZmxvYXQxMjhfbXVsKHhhLSZndDtmMTI4LCB4Yi0m
Z3Q7ZjEyOCwgJmFtcDt0c3RhdCk7PGJyPsKgIMKgIMKgZW52LSZndDtmcF9zdGF0dXMuZmxvYXRf
ZXhjZXB0aW9uX2ZsYWdzIHw9IHRzdGF0LmZsb2F0X2V4Y2VwdGlvbl9mbGFnczs8YnI+wqA8YnI+
QEAgLTIyNjMsOSArMjI1MSw2IEBAIHZvaWQgaGVscGVyXyMjb3AoQ1BVUFBDU3RhdGUgKmVudiwg
cHBjX3Zzcl90ICp4dCwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
XDxicj7CoHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgXDxicj7CoCDCoCDCoHBwY192c3JfdCB0ID0gKnh0OyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoFw8YnI+wqAgwqAgwqBpbnQgaTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBcPGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPi0gwqAgwqBoZWxwZXJfcmVzZXRfZnBzdGF0
dXMoZW52KTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoCDCoCDCoGZvciAoaSA9IDA7IGkg
Jmx0OyBuZWxzOyBpKyspIHsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKgIMKgIMKgIMKgZmxvYXRfc3Rh
dHVzIHRzdGF0ID0gZW52LSZndDtmcF9zdGF0dXM7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoCDCoCDCoCDCoCDCoHNldF9mbG9hdF9leGNl
cHRpb25fZmxhZ3MoMCwgJmFtcDt0c3RhdCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+QEAgLTIzMDUsNyArMjI5MCw2IEBAIHZvaWQgaGVscGVy
X3hzZGl2cXAoQ1BVUFBDU3RhdGUgKmVudiwgdWludDMyX3Qgb3Bjb2RlLDxicj7CoCDCoCDCoHBw
Y192c3JfdCB0ID0gKnh0Ozxicj7CoCDCoCDCoGZsb2F0X3N0YXR1cyB0c3RhdDs8YnI+wqA8YnI+
LSDCoCDCoGhlbHBlcl9yZXNldF9mcHN0YXR1cyhlbnYpOzxicj7CoCDCoCDCoHRzdGF0ID0gZW52
LSZndDtmcF9zdGF0dXM7PGJyPsKgIMKgIMKgaWYgKHVubGlrZWx5KFJjKG9wY29kZSkgIT0gMCkp
IHs8YnI+wqAgwqAgwqAgwqAgwqB0c3RhdC5mbG9hdF9yb3VuZGluZ19tb2RlID0gZmxvYXRfcm91
bmRfdG9fb2RkOzxicj5AQCAtMjM0Miw5ICsyMzI2LDYgQEAgdm9pZCBoZWxwZXJfIyNvcChDUFVQ
UENTdGF0ZSAqZW52LCBwcGNfdnNyX3QgKnh0LCBwcGNfdnNyX3QgKnhiKSDCoCDCoCDCoCDCoCDC
oCDCoCDCoFw8YnI+wqB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqBwcGNfdnNyX3QgdCA9ICp4dDsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKgIMKgaW50IGk7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4tIMKgIMKgaGVscGVyX3Jlc2V0
X2Zwc3RhdHVzKGVudik7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqBmb3IgKGkg
PSAwOyBpICZsdDsgbmVsczsgaSsrKSB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoCDCoCDCoCDCoCDCoGlm
ICh1bmxpa2VseSh0cCMjX2lzX3NpZ25hbGluZ19uYW4oeGItJmd0O2ZsZCwgJmFtcDtlbnYtJmd0
O2ZwX3N0YXR1cykpKSB7IMKgIMKgIMKgXDxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoGZsb2F0X2lu
dmFsaWRfb3BfdnhzbmFuKGVudiwgR0VUUEMoKSk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgXDxicj5AQCAtMjM4Miw5ICsyMzYzLDYgQEAgdm9pZCBoZWxwZXJfIyNv
cChDUFVQUENTdGF0ZSAqZW52LCBwcGNfdnNyX3QgKnh0LCBwcGNfdnNyX3QgKnhiKSDCoCDCoCDC
oCDCoCDCoCDCoCBcPGJyPsKgeyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqBwcGNfdnNyX3QgdCA9ICp4dDsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoGludCBpOyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4tIMKgIMKgaGVscGVyX3Jlc2V0X2Zw
c3RhdHVzKGVudik7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqBmb3IgKGkgPSAwOyBp
ICZsdDsgbmVsczsgaSsrKSB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqAgwqAgwqBmbG9hdF9zdGF0
dXMgdHN0YXQgPSBlbnYtJmd0O2ZwX3N0YXR1czsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoCDCoCDCoHNldF9mbG9hdF9leGNlcHRp
b25fZmxhZ3MoMCwgJmFtcDt0c3RhdCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgXDxicj5AQCAtMjQzMCw5ICsyNDA4LDYgQEAgdm9pZCBoZWxwZXJfIyNv
cChDUFVQUENTdGF0ZSAqZW52LCBwcGNfdnNyX3QgKnh0LCBwcGNfdnNyX3QgKnhiKSDCoCDCoCDC
oCDCoCDCoCDCoCBcPGJyPsKgeyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqBwcGNfdnNyX3QgdCA9ICp4dDsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoGludCBpOyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4tIMKgIMKgaGVscGVyX3Jlc2V0X2Zw
c3RhdHVzKGVudik7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqBmb3IgKGkgPSAwOyBp
ICZsdDsgbmVsczsgaSsrKSB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqAgwqAgwqBmbG9hdF9zdGF0
dXMgdHN0YXQgPSBlbnYtJmd0O2ZwX3N0YXR1czsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDCoCDCoCDCoCDCoHNldF9mbG9hdF9leGNlcHRp
b25fZmxhZ3MoMCwgJmFtcDt0c3RhdCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgXDxicj5AQCAtMjU5Miw5ICsyNTY3LDYgQEAgdm9pZCBoZWxwZXJfIyNv
cChDUFVQUENTdGF0ZSAqZW52LCBwcGNfdnNyX3QgKnh0LCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKgeyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKgIMKgIMKgcHBjX3Zzcl90IHQgPSAq
eHQ7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoCDCoCDCoGludCBpOyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+LSDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+LSDCoCDC
oGhlbHBlcl9yZXNldF9mcHN0YXR1cyhlbnYpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPi0gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKg
IMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IG5lbHM7IGkrKykgeyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAg
wqAgwqAgwqAgwqBmbG9hdF9zdGF0dXMgdHN0YXQgPSBlbnYtJmd0O2ZwX3N0YXR1czsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKgIMKg
IMKgIMKgc2V0X2Zsb2F0X2V4Y2VwdGlvbl9mbGFncygwLCAmYW1wO3RzdGF0KTsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj5AQCAtMjc2NSw5ICsy
NzM3LDYgQEAgdm9pZCBoZWxwZXJfIyNvcChDUFVQUENTdGF0ZSAqZW52LCB1aW50MzJfdCBvcGNv
ZGUsIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoHsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKgIMKgdWludDMy
X3QgY2MgPSAwOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKgIMKgIMKgYm9vbCB2eHNuYW5f
ZmxhZyA9IGZhbHNlLCB2eHZjX2ZsYWcgPSBmYWxzZTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4tIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIFw8YnI+LSDCoCDCoGhlbHBlcl9yZXNldF9mcHN0YXR1cyhlbnYpOyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oFw8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBcPGJyPsKgIMKgIMKgaWYgKGZsb2F0NjRfaXNfc2lnbmFsaW5nX25hbih4YS0mZ3Q7VnNyRCgw
KSwgJmFtcDtlbnYtJmd0O2ZwX3N0YXR1cykgfHwgwqAgwqAgwqAgwqBcPGJyPsKgIMKgIMKgIMKg
IMKgZmxvYXQ2NF9pc19zaWduYWxpbmdfbmFuKHhiLSZndDtWc3JEKDApLCAmYW1wO2Vudi0mZ3Q7
ZnBfc3RhdHVzKSkgeyDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqAgwqAgwqB2eHNuYW5fZmxhZyA9
IHRydWU7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgXDxicj5AQCAtMjgxMyw5ICsyNzgyLDYgQEAgdm9pZCBoZWxwZXJf
IyNvcChDUFVQUENTdGF0ZSAqZW52LCB1aW50MzJfdCBvcGNvZGUsIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIFw8YnI+wqB7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAgwqB1aW50MzJfdCBjYyA9IDA7IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgXDxicj7CoCDCoCDCoGJvb2wgdnhzbmFuX2ZsYWcgPSBmYWxzZSwgdnh2Y19mbGFnID0g
ZmFsc2U7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4tIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4tIMKgIMKgaGVs
cGVyX3Jlc2V0X2Zwc3RhdHVzKGVudik7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqBpZiAoZmxvYXQxMjhfaXNf
c2lnbmFsaW5nX25hbih4YS0mZ3Q7ZjEyOCwgJmFtcDtlbnYtJmd0O2ZwX3N0YXR1cykgfHwgwqAg
wqAgwqAgwqAgXDxicj7CoCDCoCDCoCDCoCDCoGZsb2F0MTI4X2lzX3NpZ25hbGluZ19uYW4oeGIt
Jmd0O2YxMjgsICZhbXA7ZW52LSZndDtmcF9zdGF0dXMpKSB7IMKgIMKgIMKgIMKgIFw8YnI+wqAg
wqAgwqAgwqAgwqB2eHNuYW5fZmxhZyA9IHRydWU7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+QEAgLTMxNzcsOSAr
MzE0Myw2IEBAIHVpbnQ2NF90IGhlbHBlcl94c2N2ZHBzcG4oQ1BVUFBDU3RhdGUgKmVudiwgdWlu
dDY0X3QgeGIpPGJyPsKgezxicj7CoCDCoCDCoHVpbnQ2NF90IHJlc3VsdCwgc2lnbiwgZXhwLCBm
cmFjOzxicj7CoDxicj4tIMKgIMKgZmxvYXRfc3RhdHVzIHRzdGF0ID0gZW52LSZndDtmcF9zdGF0
dXM7PGJyPi0gwqAgwqBzZXRfZmxvYXRfZXhjZXB0aW9uX2ZsYWdzKDAsICZhbXA7dHN0YXQpOzxi
cj4tPGJyPsKgIMKgIMKgc2lnbiA9IGV4dHJhY3Q2NCh4YiwgNjMsIMKgMSk7PGJyPsKgIMKgIMKg
ZXhwIMKgPSBleHRyYWN0NjQoeGIsIDUyLCAxMSk7PGJyPsKgIMKgIMKgZnJhYyA9IGV4dHJhY3Q2
NCh4YiwgwqAwLCA1MikgfCAweDEwMDAwMDAwMDAwMDAwVUxMOzxicj5AQCAtMzQ0Niw4ICszNDA5
LDYgQEAgVlNYX1JPVU5EKHh2cnNwaXosIDQsIGZsb2F0MzIsIFZzclcoaSksIGZsb2F0X3JvdW5k
X3RvX3plcm8sIDApPGJyPsKgPGJyPsKgdWludDY0X3QgaGVscGVyX3hzcnNwKENQVVBQQ1N0YXRl
ICplbnYsIHVpbnQ2NF90IHhiKTxicj7CoHs8YnI+LSDCoCDCoGhlbHBlcl9yZXNldF9mcHN0YXR1
cyhlbnYpOzxicj4tPGJyPsKgIMKgIMKgdWludDY0X3QgeHQgPSBoZWxwZXJfZnJzcChlbnYsIHhi
KTs8YnI+wqA8YnI+wqAgwqAgwqBoZWxwZXJfY29tcHV0ZV9mcHJmX2Zsb2F0NjQoZW52LCB4dCk7
PGJyPkBAIC0zNTkzLDggKzM1NTQsNiBAQCB2b2lkIGhlbHBlcl94c3JxcGkoQ1BVUFBDU3RhdGUg
KmVudiwgdWludDMyX3Qgb3Bjb2RlLDxicj7CoCDCoCDCoHVpbnQ4X3Qgcm1vZGUgPSAwOzxicj7C
oCDCoCDCoGZsb2F0X3N0YXR1cyB0c3RhdDs8YnI+wqA8YnI+LSDCoCDCoGhlbHBlcl9yZXNldF9m
cHN0YXR1cyhlbnYpOzxicj4tPGJyPsKgIMKgIMKgaWYgKHIgPT0gMCAmYW1wOyZhbXA7IHJtYyA9
PSAwKSB7PGJyPsKgIMKgIMKgIMKgIMKgcm1vZGUgPSBmbG9hdF9yb3VuZF90aWVzX2F3YXk7PGJy
PsKgIMKgIMKgfSBlbHNlIGlmIChyID09IDAgJmFtcDsmYW1wOyBybWMgPT0gMHgzKSB7PGJyPkBA
IC0zNjUwLDggKzM2MDksNiBAQCB2b2lkIGhlbHBlcl94c3JxcHhwKENQVVBQQ1N0YXRlICplbnYs
IHVpbnQzMl90IG9wY29kZSw8YnI+wqAgwqAgwqBmbG9hdHg4MCByb3VuZF9yZXM7PGJyPsKgIMKg
IMKgZmxvYXRfc3RhdHVzIHRzdGF0Ozxicj7CoDxicj4tIMKgIMKgaGVscGVyX3Jlc2V0X2Zwc3Rh
dHVzKGVudik7PGJyPi08YnI+wqAgwqAgwqBpZiAociA9PSAwICZhbXA7JmFtcDsgcm1jID09IDAp
IHs8YnI+wqAgwqAgwqAgwqAgwqBybW9kZSA9IGZsb2F0X3JvdW5kX3RpZXNfYXdheTs8YnI+wqAg
wqAgwqB9IGVsc2UgaWYgKHIgPT0gMCAmYW1wOyZhbXA7IHJtYyA9PSAweDMpIHs8YnI+QEAgLTM3
MDAsOCArMzY1Nyw2IEBAIHZvaWQgaGVscGVyX3hzc3FydHFwKENQVVBQQ1N0YXRlICplbnYsIHVp
bnQzMl90IG9wY29kZSw8YnI+wqAgwqAgwqBwcGNfdnNyX3QgdCA9IHsgfTs8YnI+wqAgwqAgwqBm
bG9hdF9zdGF0dXMgdHN0YXQ7PGJyPsKgPGJyPi0gwqAgwqBoZWxwZXJfcmVzZXRfZnBzdGF0dXMo
ZW52KTs8YnI+LTxicj7CoCDCoCDCoHRzdGF0ID0gZW52LSZndDtmcF9zdGF0dXM7PGJyPsKgIMKg
IMKgaWYgKHVubGlrZWx5KFJjKG9wY29kZSkgIT0gMCkpIHs8YnI+wqAgwqAgwqAgwqAgwqB0c3Rh
dC5mbG9hdF9yb3VuZGluZ19tb2RlID0gZmxvYXRfcm91bmRfdG9fb2RkOzxicj5AQCAtMzczNCw4
ICszNjg5LDYgQEAgdm9pZCBoZWxwZXJfeHNzdWJxcChDUFVQUENTdGF0ZSAqZW52LCB1aW50MzJf
dCBvcGNvZGUsPGJyPsKgIMKgIMKgcHBjX3Zzcl90IHQgPSAqeHQ7PGJyPsKgIMKgIMKgZmxvYXRf
c3RhdHVzIHRzdGF0Ozxicj7CoDxicj4tIMKgIMKgaGVscGVyX3Jlc2V0X2Zwc3RhdHVzKGVudik7
PGJyPi08YnI+wqAgwqAgwqB0c3RhdCA9IGVudi0mZ3Q7ZnBfc3RhdHVzOzxicj7CoCDCoCDCoGlm
ICh1bmxpa2VseShSYyhvcGNvZGUpICE9IDApKSB7PGJyPsKgIMKgIMKgIMKgIMKgdHN0YXQuZmxv
YXRfcm91bmRpbmdfbW9kZSA9IGZsb2F0X3JvdW5kX3RvX29kZDs8YnI+ZGlmZiAtLWdpdCBhL3Rh
cmdldC9wcGMvaGVscGVyLmggYi90YXJnZXQvcHBjL2hlbHBlci5oPGJyPmluZGV4IDRlMTkyZGU5
N2IuLmI0ODZjOTk5MWYgMTAwNjQ0PGJyPi0tLSBhL3RhcmdldC9wcGMvaGVscGVyLmg8YnI+Kysr
IGIvdGFyZ2V0L3BwYy9oZWxwZXIuaDxicj5AQCAtNTgsNyArNTgsNiBAQCBERUZfSEVMUEVSX0ZM
QUdTXzEoY250bHp3MzIsIFRDR19DQUxMX05PX1JXR19TRSwgaTMyLCBpMzIpPGJyPsKgREVGX0hF
TFBFUl9GTEFHU18yKGJyaW5jLCBUQ0dfQ0FMTF9OT19SV0dfU0UsIHRsLCB0bCwgdGwpPGJyPsKg
PGJyPsKgREVGX0hFTFBFUl8xKGZsb2F0X2NoZWNrX3N0YXR1cywgdm9pZCwgZW52KTxicj4tREVG
X0hFTFBFUl8xKHJlc2V0X2Zwc3RhdHVzLCB2b2lkLCBlbnYpPGJyPsKgREVGX0hFTFBFUl8yKGNv
bXB1dGVfZnByZl9mbG9hdDY0LCB2b2lkLCBlbnYsIGk2NCk8YnI+wqBERUZfSEVMUEVSXzMoc3Rv
cmVfZnBzY3IsIHZvaWQsIGVudiwgaTY0LCBpMzIpPGJyPsKgREVGX0hFTFBFUl8yKGZwc2NyX2Ns
cmJpdCwgdm9pZCwgZW52LCBpMzIpPGJyPmRpZmYgLS1naXQgYS90YXJnZXQvcHBjL3RyYW5zbGF0
ZS9mcC1pbXBsLmluYy5jIGIvdGFyZ2V0L3BwYy90cmFuc2xhdGUvZnAtaW1wbC5pbmMuYzxicj5p
bmRleCBlMThlMjY4ZmU1Li41ZThjZDk5NzBlIDEwMDY0NDxicj4tLS0gYS90YXJnZXQvcHBjL3Ry
YW5zbGF0ZS9mcC1pbXBsLmluYy5jPGJyPisrKyBiL3RhcmdldC9wcGMvdHJhbnNsYXRlL2ZwLWlt
cGwuaW5jLmM8YnI+QEAgLTQsMTEgKzQsNiBAQDxicj7CoCAqIFN0YW5kYXJkIEZQVSB0cmFuc2xh
dGlvbjxicj7CoCAqLzxicj7CoDxicj4tc3RhdGljIGlubGluZSB2b2lkIGdlbl9yZXNldF9mcHN0
YXR1cyh2b2lkKTxicj4tezxicj4tIMKgIMKgZ2VuX2hlbHBlcl9yZXNldF9mcHN0YXR1cyhjcHVf
ZW52KTs8YnI+LX08YnI+LTxicj7CoHN0YXRpYyBpbmxpbmUgdm9pZCBnZW5fY29tcHV0ZV9mcHJm
X2Zsb2F0NjQoVENHdl9pNjQgYXJnKTxicj7CoHs8YnI+wqAgwqAgwqBnZW5faGVscGVyX2NvbXB1
dGVfZnByZl9mbG9hdDY0KGNwdV9lbnYsIGFyZyk7PGJyPkBAIC00OCw3ICs0Myw2IEBAIHN0YXRp
YyB2b2lkIGdlbl9mIyNuYW1lKERpc2FzQ29udGV4dCAqY3R4KSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqB0MyA9IHRjZ190
ZW1wX25ld19pNjQoKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKgIMKgLyogTklQIGNhbm5v
dCBiZSByZXN0b3JlZCBpZiB0aGUgbWVtb3J5IGV4Y2VwdGlvbiBjb21lcyBmcm9tIGFuIGhlbHBl
ciAqLyBcPGJyPsKgIMKgIMKgZ2VuX3VwZGF0ZV9uaXAoY3R4LCBjdHgtJmd0O2Jhc2UucGNfbmV4
dCAtIDQpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJy
Pi0gwqAgwqBnZW5fcmVzZXRfZnBzdGF0dXMoKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7C
oCDCoCDCoGdldF9mcHIodDAsIHJBKGN0eC0mZ3Q7b3Bjb2RlKSk7IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAg
wqAgwqBnZXRfZnByKHQxLCByQyhjdHgtJmd0O29wY29kZSkpOyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKgIMKg
IMKgZ2V0X2Zwcih0MiwgckIoY3R4LSZndDtvcGNvZGUpKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj5AQCAtODgs
NyArODIsNiBAQCBzdGF0aWMgdm9pZCBnZW5fZiMjbmFtZShEaXNhc0NvbnRleHQgKmN0eCkgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKg
IMKgIMKgdDIgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoCDC
oCDCoC8qIE5JUCBjYW5ub3QgYmUgcmVzdG9yZWQgaWYgdGhlIG1lbW9yeSBleGNlcHRpb24gY29t
ZXMgZnJvbSBhbiBoZWxwZXIgKi8gXDxicj7CoCDCoCDCoGdlbl91cGRhdGVfbmlwKGN0eCwgY3R4
LSZndDtiYXNlLnBjX25leHQgLSA0KTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4tIMKgIMKgZ2VuX3Jlc2V0X2Zwc3RhdHVzKCk7IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIFw8YnI+wqAgwqAgwqBnZXRfZnByKHQwLCByQShjdHgtJmd0O29wY29kZSkpOyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBcPGJyPsKgIMKgIMKgZ2V0X2Zwcih0MSwgckIoY3R4LSZndDtvcGNvZGUpKTsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgXDxicj7CoCDCoCDCoGdlbl9oZWxwZXJfZiMjb3AodDIsIGNwdV9lbnYsIHQwLCB0MSk7
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxi
cj5AQCAtMTIzLDcgKzExNiw2IEBAIHN0YXRpYyB2b2lkIGdlbl9mIyNuYW1lKERpc2FzQ29udGV4
dCAqY3R4KSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoFw8YnI+wqAgwqAgwqB0MCA9IHRjZ190ZW1wX25ld19pNjQoKTsgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBcPGJyPsKgIMKgIMKgdDEgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
XDxicj7CoCDCoCDCoHQyID0gdGNnX3RlbXBfbmV3X2k2NCgpOyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8
YnI+LSDCoCDCoGdlbl9yZXNldF9mcHN0YXR1cygpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJy
PsKgIMKgIMKgZ2V0X2Zwcih0MCwgckEoY3R4LSZndDtvcGNvZGUpKTsgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7C
oCDCoCDCoGdldF9mcHIodDEsIHJDKGN0eC0mZ3Q7b3Bjb2RlKSk7IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAg
wqAgwqBnZW5faGVscGVyX2YjI29wKHQyLCBjcHVfZW52LCB0MCwgdDEpOyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+QEAgLTE1Niw3ICsx
NDgsNiBAQCBzdGF0aWMgdm9pZCBnZW5fZiMjbmFtZShEaXNhc0NvbnRleHQgKmN0eCkgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKg
IMKgfSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBc
PGJyPsKgIMKgIMKgdDAgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxi
cj7CoCDCoCDCoHQxID0gdGNnX3RlbXBfbmV3X2k2NCgpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
LSDCoCDCoGdlbl9yZXNldF9mcHN0YXR1cygpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPsKg
IMKgIMKgZ2V0X2Zwcih0MCwgckIoY3R4LSZndDtvcGNvZGUpKTsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDC
oCDCoGdlbl9oZWxwZXJfZiMjbmFtZSh0MSwgY3B1X2VudiwgdDApOyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+wqAgwqAgwqBzZXRf
ZnByKHJEKGN0eC0mZ3Q7b3Bjb2RlKSwgdDEpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPkBAIC0xODEsNyArMTcy
LDYgQEAgc3RhdGljIHZvaWQgZ2VuX2YjI25hbWUoRGlzYXNDb250ZXh0ICpjdHgpIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj7CoCDCoCDC
oH0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxi
cj7CoCDCoCDCoHQwID0gdGNnX3RlbXBfbmV3X2k2NCgpOyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+
wqAgwqAgwqB0MSA9IHRjZ190ZW1wX25ld19pNjQoKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPi0g
wqAgwqBnZW5fcmVzZXRfZnBzdGF0dXMoKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj7CoCDC
oCDCoGdldF9mcHIodDAsIHJCKGN0eC0mZ3Q7b3Bjb2RlKSk7IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+wqAgwqAg
wqBnZW5faGVscGVyX2YjI25hbWUodDEsIGNwdV9lbnYsIHQwKTsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPsKgIMKgIMKgc2V0X2Zw
cihyRChjdHgtJmd0O29wY29kZSksIHQxKTsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj5AQCAtMjIyLDcgKzIxMiw2
IEBAIHN0YXRpYyB2b2lkIGdlbl9mcnNxcnRlcyhEaXNhc0NvbnRleHQgKmN0eCk8YnI+wqAgwqAg
wqB9PGJyPsKgIMKgIMKgdDAgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7PGJyPsKgIMKgIMKgdDEgPSB0
Y2dfdGVtcF9uZXdfaTY0KCk7PGJyPi0gwqAgwqBnZW5fcmVzZXRfZnBzdGF0dXMoKTs8YnI+wqAg
wqAgwqBnZXRfZnByKHQwLCByQihjdHgtJmd0O29wY29kZSkpOzxicj7CoCDCoCDCoGdlbl9oZWxw
ZXJfZnJzcXJ0ZSh0MSwgY3B1X2VudiwgdDApOzxicj7CoCDCoCDCoGdlbl9oZWxwZXJfZnJzcCh0
MSwgY3B1X2VudiwgdDEpOzxicj5AQCAtMjUyLDcgKzI0MSw2IEBAIHN0YXRpYyB2b2lkIGdlbl9m
c3FydChEaXNhc0NvbnRleHQgKmN0eCk8YnI+wqAgwqAgwqB9PGJyPsKgIMKgIMKgdDAgPSB0Y2df
dGVtcF9uZXdfaTY0KCk7PGJyPsKgIMKgIMKgdDEgPSB0Y2dfdGVtcF9uZXdfaTY0KCk7PGJyPi0g
wqAgwqBnZW5fcmVzZXRfZnBzdGF0dXMoKTs8YnI+wqAgwqAgwqBnZXRfZnByKHQwLCByQihjdHgt
Jmd0O29wY29kZSkpOzxicj7CoCDCoCDCoGdlbl9oZWxwZXJfZnNxcnQodDEsIGNwdV9lbnYsIHQw
KTs8YnI+wqAgwqAgwqBzZXRfZnByKHJEKGN0eC0mZ3Q7b3Bjb2RlKSwgdDEpOzxicj5AQCAtMjc0
LDcgKzI2Miw2IEBAIHN0YXRpYyB2b2lkIGdlbl9mc3FydHMoRGlzYXNDb250ZXh0ICpjdHgpPGJy
PsKgIMKgIMKgfTxicj7CoCDCoCDCoHQwID0gdGNnX3RlbXBfbmV3X2k2NCgpOzxicj7CoCDCoCDC
oHQxID0gdGNnX3RlbXBfbmV3X2k2NCgpOzxicj4tIMKgIMKgZ2VuX3Jlc2V0X2Zwc3RhdHVzKCk7
PGJyPsKgIMKgIMKgZ2V0X2Zwcih0MCwgckIoY3R4LSZndDtvcGNvZGUpKTs8YnI+wqAgwqAgwqBn
ZW5faGVscGVyX2ZzcXJ0KHQxLCBjcHVfZW52LCB0MCk7PGJyPsKgIMKgIMKgZ2VuX2hlbHBlcl9m
cnNwKHQxLCBjcHVfZW52LCB0MSk7PGJyPkBAIC0zODAsNyArMzY3LDYgQEAgc3RhdGljIHZvaWQg
Z2VuX2ZjbXBvKERpc2FzQ29udGV4dCAqY3R4KTxicj7CoCDCoCDCoH08YnI+wqAgwqAgwqB0MCA9
IHRjZ190ZW1wX25ld19pNjQoKTs8YnI+wqAgwqAgwqB0MSA9IHRjZ190ZW1wX25ld19pNjQoKTs8
YnI+LSDCoCDCoGdlbl9yZXNldF9mcHN0YXR1cygpOzxicj7CoCDCoCDCoGNyZiA9IHRjZ19jb25z
dF9pMzIoY3JmRChjdHgtJmd0O29wY29kZSkpOzxicj7CoCDCoCDCoGdldF9mcHIodDAsIHJBKGN0
eC0mZ3Q7b3Bjb2RlKSk7PGJyPsKgIMKgIMKgZ2V0X2Zwcih0MSwgckIoY3R4LSZndDtvcGNvZGUp
KTs8YnI+QEAgLTQwMyw3ICszODksNiBAQCBzdGF0aWMgdm9pZCBnZW5fZmNtcHUoRGlzYXNDb250
ZXh0ICpjdHgpPGJyPsKgIMKgIMKgfTxicj7CoCDCoCDCoHQwID0gdGNnX3RlbXBfbmV3X2k2NCgp
Ozxicj7CoCDCoCDCoHQxID0gdGNnX3RlbXBfbmV3X2k2NCgpOzxicj4tIMKgIMKgZ2VuX3Jlc2V0
X2Zwc3RhdHVzKCk7PGJyPsKgIMKgIMKgY3JmID0gdGNnX2NvbnN0X2kzMihjcmZEKGN0eC0mZ3Q7
b3Bjb2RlKSk7PGJyPsKgIMKgIMKgZ2V0X2Zwcih0MCwgckEoY3R4LSZndDtvcGNvZGUpKTs8YnI+
wqAgwqAgwqBnZXRfZnByKHQxLCByQihjdHgtJmd0O29wY29kZSkpOzxicj5AQCAtNjEyLDcgKzU5
Nyw2IEBAIHN0YXRpYyB2b2lkIGdlbl9tZmZzKERpc2FzQ29udGV4dCAqY3R4KTxicj7CoCDCoCDC
oCDCoCDCoHJldHVybjs8YnI+wqAgwqAgwqB9PGJyPsKgIMKgIMKgdDAgPSB0Y2dfdGVtcF9uZXdf
aTY0KCk7PGJyPi0gwqAgwqBnZW5fcmVzZXRfZnBzdGF0dXMoKTs8YnI+wqAgwqAgwqB0Y2dfZ2Vu
X2V4dHVfdGxfaTY0KHQwLCBjcHVfZnBzY3IpOzxicj7CoCDCoCDCoHNldF9mcHIockQoY3R4LSZn
dDtvcGNvZGUpLCB0MCk7PGJyPsKgIMKgIMKgaWYgKHVubGlrZWx5KFJjKGN0eC0mZ3Q7b3Bjb2Rl
KSkpIHs8YnI+QEAgLTYzNSw3ICs2MTksNiBAQCBzdGF0aWMgdm9pZCBnZW5fbWZmc2woRGlzYXND
b250ZXh0ICpjdHgpPGJyPsKgIMKgIMKgIMKgIMKgcmV0dXJuOzxicj7CoCDCoCDCoH08YnI+wqAg
wqAgwqB0MCA9IHRjZ190ZW1wX25ld19pNjQoKTs8YnI+LSDCoCDCoGdlbl9yZXNldF9mcHN0YXR1
cygpOzxicj7CoCDCoCDCoHRjZ19nZW5fZXh0dV90bF9pNjQodDAsIGNwdV9mcHNjcik7PGJyPsKg
IMKgIMKgLyogTWFzayBldmVyeXRoaW5nIGV4Y2VwdCBtb2RlLCBzdGF0dXMsIGFuZCBlbmFibGVz
LiDCoCovPGJyPsKgIMKgIMKgdGNnX2dlbl9hbmRpX2k2NCh0MCwgdDAsIEZQX0RSTiB8IEZQX1NU
QVRVUyB8IEZQX0VOQUJMRVMgfCBGUF9STik7PGJyPkBAIC02NjAsNyArNjQzLDYgQEAgc3RhdGlj
IHZvaWQgZ2VuX21mZnNjZShEaXNhc0NvbnRleHQgKmN0eCk8YnI+wqA8YnI+wqAgwqAgwqB0MCA9
IHRjZ190ZW1wX25ld19pNjQoKTs8YnI+wqA8YnI+LSDCoCDCoGdlbl9yZXNldF9mcHN0YXR1cygp
Ozxicj7CoCDCoCDCoHRjZ19nZW5fZXh0dV90bF9pNjQodDAsIGNwdV9mcHNjcik7PGJyPsKgIMKg
IMKgc2V0X2ZwcihyRChjdHgtJmd0O29wY29kZSksIHQwKTs8YnI+wqA8YnI+QEAgLTY3OCw3ICs2
NjAsNiBAQCBzdGF0aWMgdm9pZCBnZW5faGVscGVyX21mZnNjcm4oRGlzYXNDb250ZXh0ICpjdHgs
IFRDR3ZfaTY0IHQxKTxicj7CoCDCoCDCoFRDR3ZfaTY0IHQwID0gdGNnX3RlbXBfbmV3X2k2NCgp
Ozxicj7CoCDCoCDCoFRDR3ZfaTMyIG1hc2sgPSB0Y2dfY29uc3RfaTMyKDB4MDAwMSk7PGJyPsKg
PGJyPi0gwqAgwqBnZW5fcmVzZXRfZnBzdGF0dXMoKTs8YnI+wqAgwqAgwqB0Y2dfZ2VuX2V4dHVf
dGxfaTY0KHQwLCBjcHVfZnBzY3IpOzxicj7CoCDCoCDCoHRjZ19nZW5fYW5kaV9pNjQodDAsIHQw
LCBGUF9EUk4gfCBGUF9FTkFCTEVTIHwgRlBfUk4pOzxicj7CoCDCoCDCoHNldF9mcHIockQoY3R4
LSZndDtvcGNvZGUpLCB0MCk7PGJyPkBAIC03NTAsNyArNzMxLDYgQEAgc3RhdGljIHZvaWQgZ2Vu
X210ZnNiMChEaXNhc0NvbnRleHQgKmN0eCk8YnI+wqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPsKg
IMKgIMKgfTxicj7CoCDCoCDCoGNyYiA9IDMxIC0gY3JiRChjdHgtJmd0O29wY29kZSk7PGJyPi0g
wqAgwqBnZW5fcmVzZXRfZnBzdGF0dXMoKTs8YnI+wqAgwqAgwqBpZiAobGlrZWx5KGNyYiAhPSBG
UFNDUl9GRVggJmFtcDsmYW1wOyBjcmIgIT0gRlBTQ1JfVlgpKSB7PGJyPsKgIMKgIMKgIMKgIMKg
VENHdl9pMzIgdDA7PGJyPsKgIMKgIMKgIMKgIMKgdDAgPSB0Y2dfY29uc3RfaTMyKGNyYik7PGJy
PkBAIC03NzMsNyArNzUzLDYgQEAgc3RhdGljIHZvaWQgZ2VuX210ZnNiMShEaXNhc0NvbnRleHQg
KmN0eCk8YnI+wqAgwqAgwqAgwqAgwqByZXR1cm47PGJyPsKgIMKgIMKgfTxicj7CoCDCoCDCoGNy
YiA9IDMxIC0gY3JiRChjdHgtJmd0O29wY29kZSk7PGJyPi0gwqAgwqBnZW5fcmVzZXRfZnBzdGF0
dXMoKTs8YnI+wqAgwqAgwqAvKiBYWFg6IHdlIHByZXRlbmQgd2UgY2FuIG9ubHkgZG8gSUVFRSBm
bG9hdGluZy1wb2ludCBjb21wdXRhdGlvbnMgKi88YnI+wqAgwqAgwqBpZiAobGlrZWx5KGNyYiAh
PSBGUFNDUl9GRVggJmFtcDsmYW1wOyBjcmIgIT0gRlBTQ1JfVlggJmFtcDsmYW1wOyBjcmIgIT0g
RlBTQ1JfTkkpKSB7PGJyPsKgIMKgIMKgIMKgIMKgVENHdl9pMzIgdDA7PGJyPkBAIC04MDcsNyAr
Nzg2LDYgQEAgc3RhdGljIHZvaWQgZ2VuX210ZnNmKERpc2FzQ29udGV4dCAqY3R4KTxicj7CoCDC
oCDCoCDCoCDCoGdlbl9pbnZhbF9leGNlcHRpb24oY3R4LCBQT1dFUlBDX0VYQ1BfSU5WQUxfSU5W
QUwpOzxicj7CoCDCoCDCoCDCoCDCoHJldHVybjs8YnI+wqAgwqAgwqB9PGJyPi0gwqAgwqBnZW5f
cmVzZXRfZnBzdGF0dXMoKTs8YnI+wqAgwqAgwqBpZiAobCkgezxicj7CoCDCoCDCoCDCoCDCoHQw
ID0gdGNnX2NvbnN0X2kzMigoY3R4LSZndDtpbnNuc19mbGFnczIgJmFtcDsgUFBDMl9JU0EyMDUp
ID8gMHhmZmZmIDogMHhmZik7PGJyPsKgIMKgIMKgfSBlbHNlIHs8YnI+QEAgLTg0NCw3ICs4MjIs
NiBAQCBzdGF0aWMgdm9pZCBnZW5fbXRmc2ZpKERpc2FzQ29udGV4dCAqY3R4KTxicj7CoCDCoCDC
oCDCoCDCoHJldHVybjs8YnI+wqAgwqAgwqB9PGJyPsKgIMKgIMKgc2ggPSAoOCAqIHcpICsgNyAt
IGJmOzxicj4tIMKgIMKgZ2VuX3Jlc2V0X2Zwc3RhdHVzKCk7PGJyPsKgIMKgIMKgdDAgPSB0Y2df
Y29uc3RfaTY0KCgodWludDY0X3QpRlBJTU0oY3R4LSZndDtvcGNvZGUpKSAmbHQ7Jmx0OyAoNCAq
IHNoKSk7PGJyPsKgIMKgIMKgdDEgPSB0Y2dfY29uc3RfaTMyKDEgJmx0OyZsdDsgc2gpOzxicj7C
oCDCoCDCoGdlbl9oZWxwZXJfc3RvcmVfZnBzY3IoY3B1X2VudiwgdDAsIHQxKTs8YnI+LS0gPGJy
PjIuMjMuMC53aW5kb3dzLjE8YnI+PGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFp
bF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFNhdCwgTWF5IDIs
IDIwMjAgYXQgNDo0OSBBTSBSaWNoYXJkIEhlbmRlcnNvbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOnJp
Y2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmciPnJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc8
L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2Io
MjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPk9uIDUvMS8yMCAxOjA0IFBNLCDnvZfli4fl
iJooWW9uZ2dhbmcgTHVvKSB3cm90ZTo8YnI+DQomZ3Q7IEFuZMKgIGZwX3N0YXR1cyBjYW4gbm90
IHJlcHJlc2VudCBhbGwgdGhlwqAgSW52YWxpZCBPcGVyYXRpb24gRXhjZXB0aW9uIGZsYWdzLjxi
cj4NCiZndDsgV2hhdCBJIG5lZWQgdG8gZG8gdG8gcmVwcmVzZW50IGFsbCB0aGXCoCBJbnZhbGlk
IE9wZXJhdGlvbiBFeGNlcHRpb248YnI+DQo8YnI+DQpJZGVhbGx5LCB3ZSBhZGQgdGhlbSB0byBp
bmNsdWRlL2ZwdS9zb2Z0ZmxvYXQtdHlwZXMuaCwgZXhwYW5kIHRoZTxicj4NCmZsb2F0X2V4Y2Vw
dGlvbl9mbGFncyBmaWVsZCBpbiBmbG9hdF9zdGF0dXMgdG8gbWF0Y2gsIGFuZCBnZW5lcmF0ZSB0
aGUgbmV3PGJyPg0KZmxhZ3MgaW4gZnB1L3NvZnRmbG9hdC5jLjxicj4NCjxicj4NClRoaXMgd291
bGQgYWN0dWFsbHkgaGVscCB0YXJnZXQvdHJpY29yZSBhcyB3ZWxsLjxicj4NCjxicj4NCjxicj4N
CnJ+PGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2PjxiciBjbGVhcj0iYWxsIj48ZGl2Pjxicj48L2Rp
dj4tLSA8YnI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX3NpZ25hdHVyZSI+wqAgwqAgwqAg
wqDCoCDmraToh7Q8YnI+56S8PGJyPue9l+WLh+WImjxicj5Zb3Vyczxicj7CoCDCoCBzaW5jZXJl
bHksPGJyPllvbmdnYW5nIEx1bzxicj48L2Rpdj4NCg==
--0000000000005c64d405a4c3ab85--

