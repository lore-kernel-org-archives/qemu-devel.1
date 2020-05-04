Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CF4C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C34220721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaZNrW8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C34220721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXyV-00013V-Hz
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jVXxN-000068-0S
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:04:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:38491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jVXxK-0001Sf-Ov
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:04:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id g12so8317914wmh.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 03:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
 :date:mime-version:content-transfer-encoding;
 bh=RYxKIwn0G/aWlhAhk8evwDKbORQN+7I7j2SlpuDqiEM=;
 b=AaZNrW8fxTmM8jLY5KhtgbzSwMIWRzDy9djxeQFnTQKQH3nVBZXB1igeZ/vWuHs3Nf
 kszqWJdmMusv7DR4BPTu7hci/1yFGaFzSp1NtwBdJYJtRD+tpQXHAjZ1q/k6V4fOV/9h
 ZStBsBVSnZc+wikoeop4QJDM9VrRsaaLHMV+Tzz3kjL/gfwmWW1LBPWo2cI+nI5ysx4C
 wkFELls8iuHKNs2ZY9w8HwzTd3nJpbeZl1Vats15t/SYS3vqoL5mnoFa7m5mUXuuhp4W
 LJXx+kdD4vOrQgjMroDfkijoFQdcCAa2LHfhWuqUFmF+FGINoqExncnBxuUyd7MMarbw
 T/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:message-id:date:mime-version:content-transfer-encoding;
 bh=RYxKIwn0G/aWlhAhk8evwDKbORQN+7I7j2SlpuDqiEM=;
 b=QpI5jsm+00S58/TTNK5KPtn+Kk1RXc2YEmQeQjgDgtPh8VjN6Y5oBrDAWsJu+7X5vM
 erWqgi+OOw9lYjMec87VBM0rbjhIKJ3TKwsSFqueoH/sFVadf9ZTJ9VcNYRfVvu4Y4WW
 puX2CKYWrL6pW9eblUOJdglhsxKbRzEJOuY/Z8inIi2Dkdv5ADXSWkk2jEmgh5IuCCDw
 thJn4ghAc+EBk6GxYkvGIKSwZa/rTbtP3SraJ5xo5Ygru3aWWPVIGLDC1GKid5N+LC+Z
 BtCpbD8rMQN2wXnyfo2iM4JzJtcF9VWXo58IFEKd3fJiX+3502hqS/TVfrsiaohMQXI3
 iibA==
X-Gm-Message-State: AGi0PubDoEPZTxw5ZRF2+mElovpqto3faWFHTaHMNS+wJJ67WNyKu+Rd
 obzcGdcRA+0IXwwe+DxtFCStcg==
X-Google-Smtp-Source: APiQypJgBPyMJBuX63AhUbvzYUnvyNR9jvsHkN78DSnB9dld4lhGQ7oegDje/IQreckrZmvHOTGfhg==
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr13501019wme.0.1588586647998; 
 Mon, 04 May 2020 03:04:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 1sm13133134wmz.13.2020.05.04.03.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 03:04:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D9B221FF7E;
 Mon,  4 May 2020 11:04:05 +0100 (BST)
References: <CAE2XoE-XFG8r85yPOhuNS2YUMqhp70q1RXCy+KLT79doW8qHMg@mail.gmail.com>
 <87605674-1cd8-2074-6730-355e20fbf7d0@linaro.org>
 <CAE2XoE8LO-4Ordhxf1-eNZK1taSGnaU4zxQ944-XLvwzmd9rJg@mail.gmail.com>
 <alpine.BSF.2.22.395.2005040128330.7227@zero.eik.bme.hu>
 <CAE2XoE93HqZVvFkZzfuC1VsF-Vw88ggSYMU2t7QjPUPWSU-4-Q@mail.gmail.com>
User-agent: mu4e 1.4.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: luoyonggang@gmail.com
Subject: Re: An first try to improve PPC float simulation, not even
 compiled. Just ask question.
In-reply-to: <CAE2XoE93HqZVvFkZzfuC1VsF-Vw88ggSYMU2t7QjPUPWSU-4-Q@mail.gmail.com>
Message-ID: <87v9lc584q.fsf@linaro.org>
Date: Mon, 04 May 2020 11:04:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyonggang@gmail.com> writes:

> On Mon, May 4, 2020 at 7:40 AM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
>> Hello,
>>
>> On Mon, 4 May 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
>> > Hello Richard, Can you have a look at the following patch, and was that
>> are
>> > the right direction?
>>
>> Formatting of the patch is broken by your mailer, try sending it with
>> something that does not change it otherwise it's a bit hard to read.
>>
>> Richard suggested to add an assert to check the fp_status is correctly
>> cleared in place of helper_reset_fpstatus first for debugging so you cou=
ld
>> change the helper accordingly before deleting it and run a few tests to
>> verify it still works. You'll need get some tests and benchmarks working
>> to be able to verify your changes that's why I've said that would be step
>> 0. If you checked that it still produces the same results and the assert
>> does not trigger then you can remove the helper.
>>
> That's what I need help,
> 1. How to write a assert to replace helper_reset_fpstatus .
>   just directly assert? or something else
> 2.  a few tests to run
>  How to running these tests, and where are these tests.

All the softfloat testing is currently done in tests/fp. I think you
need to make a new version of fp-test.c (fp-test-native.c?) that instead
of comparing the qemu softfloat functions with TestFloats runs the
native functions (as emitted by the compiler). That should pass when run
on real hardware and we can compare when run under emulation.=20

> Do I need to add new tests? Where to start
> 3.  Benchmarks

fp-bench is the raw benchmarking app which again can be built for a
guest architecture to measure throughput under emulation.

> Same as 2
>
>>
>> Regards,
>> BALATON Zoltan
>>
>> > From b4d6ca1d6376fab1f1be06eb472e10b908887c2b Mon Sep 17 00:00:00 2001
>> > From: Yonggang Luo <luoyonggang@gmail.com>
>> > Date: Sat, 2 May 2020 05:59:25 +0800
>> > Subject: [PATCH] [ppc fp] Step 1. Rearrange the fp helpers to eliminate
>> > helper_reset_fpstatus(). I've mentioned this before, that it's possible
>> to
>> > leave the steady-state of env->fp_status.exception_flags =3D=3D 0, so =
there's
>> > no
>> > need for a separate function call.  I suspect this is worth a decent
>> > speedup
>> > by itself.
>> >
>> > ---
>> > target/ppc/fpu_helper.c            | 53 ++----------------------------
>> > target/ppc/helper.h                |  1 -
>> > target/ppc/translate/fp-impl.inc.c | 23 -------------
>> > 3 files changed, 3 insertions(+), 74 deletions(-)
>> >
>> > diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
>> > index d9a8773ee1..4fc5a7ff1c 100644
>> > --- a/target/ppc/fpu_helper.c
>> > +++ b/target/ppc/fpu_helper.c
>> > @@ -821,6 +821,9 @@ static void do_float_check_status(CPUPPCState *env,
>> > uintptr_t raddr)
>> >                                    env->error_code, raddr);
>> >         }
>> >     }
>> > +    if (status) {
>> > +        set_float_exception_flags(0, &env->fp_status);
>> > +    }
>> > }
>> >
>> > void helper_float_check_status(CPUPPCState *env)
>> > @@ -828,11 +831,6 @@ void helper_float_check_status(CPUPPCState *env)
>> >     do_float_check_status(env, GETPC());
>> > }
>> >
>> > -void helper_reset_fpstatus(CPUPPCState *env)
>> > -{
>> > -    set_float_exception_flags(0, &env->fp_status);
>> > -}
>> > -
>> > static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,
>> >                                     uintptr_t retaddr, int classes)
>> > {
>> > @@ -2110,9 +2108,6 @@ void helper_##name(CPUPPCState *env, ppc_vsr_t *=
xt,
>> >                       \
>> > {
>> >   \
>> >     ppc_vsr_t t =3D *xt;
>> >  \
>> >     int i;
>> >  \
>> > -
>> >  \
>> > -    helper_reset_fpstatus(env);
>> >   \
>> > -
>> >  \
>> >     for (i =3D 0; i < nels; i++) {
>> >  \
>> >         float_status tstat =3D env->fp_status;
>> >  \
>> >         set_float_exception_flags(0, &tstat);
>> >   \
>> > @@ -2152,8 +2147,6 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t
>> opcode,
>> >     ppc_vsr_t t =3D *xt;
>> >     float_status tstat;
>> >
>> > -    helper_reset_fpstatus(env);
>> > -
>> >     tstat =3D env->fp_status;
>> >     if (unlikely(Rc(opcode) !=3D 0)) {
>> >         tstat.float_rounding_mode =3D float_round_to_odd;
>> > @@ -2189,9 +2182,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
>> >                       \
>> > {
>> >   \
>> >     ppc_vsr_t t =3D *xt;
>> >  \
>> >     int i;
>> >  \
>> > -
>> >  \
>> > -    helper_reset_fpstatus(env);
>> >   \
>> > -
>> >  \
>> >     for (i =3D 0; i < nels; i++) {
>> >  \
>> >         float_status tstat =3D env->fp_status;
>> >  \
>> >         set_float_exception_flags(0, &tstat);
>> >   \
>> > @@ -2228,13 +2218,11 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t
>> > opcode,
>> >     ppc_vsr_t t =3D *xt;
>> >     float_status tstat;
>> >
>> > -    helper_reset_fpstatus(env);
>> >     tstat =3D env->fp_status;
>> >     if (unlikely(Rc(opcode) !=3D 0)) {
>> >         tstat.float_rounding_mode =3D float_round_to_odd;
>> >     }
>> >
>> > -    set_float_exception_flags(0, &tstat);
>> >     t.f128 =3D float128_mul(xa->f128, xb->f128, &tstat);
>> >     env->fp_status.float_exception_flags |=3D tstat.float_exception_fl=
ags;
>> >
>> > @@ -2263,9 +2251,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
>> >                        \
>> > {
>> >    \
>> >     ppc_vsr_t t =3D *xt;
>> >   \
>> >     int i;
>> >   \
>> > -
>> >   \
>> > -    helper_reset_fpstatus(env);
>> >    \
>> > -
>> >   \
>> >     for (i =3D 0; i < nels; i++) {
>> >   \
>> >         float_status tstat =3D env->fp_status;
>> >   \
>> >         set_float_exception_flags(0, &tstat);
>> >    \
>> > @@ -2305,7 +2290,6 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t
>> opcode,
>> >     ppc_vsr_t t =3D *xt;
>> >     float_status tstat;
>> >
>> > -    helper_reset_fpstatus(env);
>> >     tstat =3D env->fp_status;
>> >     if (unlikely(Rc(opcode) !=3D 0)) {
>> >         tstat.float_rounding_mode =3D float_round_to_odd;
>> > @@ -2342,9 +2326,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
>> > ppc_vsr_t *xb)              \
>> > {
>> >    \
>> >     ppc_vsr_t t =3D *xt;
>> >   \
>> >     int i;
>> >   \
>> > -
>> >   \
>> > -    helper_reset_fpstatus(env);
>> >    \
>> > -
>> >   \
>> >     for (i =3D 0; i < nels; i++) {
>> >   \
>> >         if (unlikely(tp##_is_signaling_nan(xb->fld, &env->fp_status)))=
 {
>> >   \
>> >             float_invalid_op_vxsnan(env, GETPC());
>> >   \
>> > @@ -2382,9 +2363,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
>> > ppc_vsr_t *xb)             \
>> > {
>> >   \
>> >     ppc_vsr_t t =3D *xt;
>> >  \
>> >     int i;
>> >  \
>> > -
>> >  \
>> > -    helper_reset_fpstatus(env);
>> >   \
>> > -
>> >  \
>> >     for (i =3D 0; i < nels; i++) {
>> >  \
>> >         float_status tstat =3D env->fp_status;
>> >  \
>> >         set_float_exception_flags(0, &tstat);
>> >   \
>> > @@ -2430,9 +2408,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
>> > ppc_vsr_t *xb)             \
>> > {
>> >   \
>> >     ppc_vsr_t t =3D *xt;
>> >  \
>> >     int i;
>> >  \
>> > -
>> >  \
>> > -    helper_reset_fpstatus(env);
>> >   \
>> > -
>> >  \
>> >     for (i =3D 0; i < nels; i++) {
>> >  \
>> >         float_status tstat =3D env->fp_status;
>> >  \
>> >         set_float_exception_flags(0, &tstat);
>> >   \
>> > @@ -2592,9 +2567,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
>> >                        \
>> > {
>> >    \
>> >     ppc_vsr_t t =3D *xt;
>> >   \
>> >     int i;
>> >   \
>> > -
>> >   \
>> > -    helper_reset_fpstatus(env);
>> >    \
>> > -
>> >   \
>> >     for (i =3D 0; i < nels; i++) {
>> >   \
>> >         float_status tstat =3D env->fp_status;
>> >   \
>> >         set_float_exception_flags(0, &tstat);
>> >    \
>> > @@ -2765,9 +2737,6 @@ void helper_##op(CPUPPCState *env, uint32_t opco=
de,
>> >                   \
>> > {
>> \
>> >     uint32_t cc =3D 0;
>>  \
>> >     bool vxsnan_flag =3D false, vxvc_flag =3D false;
>>  \
>> > -
>>  \
>> > -    helper_reset_fpstatus(env);
>>   \
>> > -
>>  \
>> >     if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||
>> \
>> >         float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {
>> \
>> >         vxsnan_flag =3D true;
>> \
>> > @@ -2813,9 +2782,6 @@ void helper_##op(CPUPPCState *env, uint32_t opco=
de,
>> >                  \
>> > {                                                                     =
  \
>> >     uint32_t cc =3D 0;                                                =
    \
>> >     bool vxsnan_flag =3D false, vxvc_flag =3D false;                  =
      \
>> > -
>> \
>> > -    helper_reset_fpstatus(env);
>>  \
>> > -
>> \
>> >     if (float128_is_signaling_nan(xa->f128, &env->fp_status) ||       =
  \
>> >         float128_is_signaling_nan(xb->f128, &env->fp_status)) {       =
  \
>> >         vxsnan_flag =3D true;                                         =
    \
>> > @@ -3177,9 +3143,6 @@ uint64_t helper_xscvdpspn(CPUPPCState *env,
>> uint64_t
>> > xb)
>> > {
>> >     uint64_t result, sign, exp, frac;
>> >
>> > -    float_status tstat =3D env->fp_status;
>> > -    set_float_exception_flags(0, &tstat);
>> > -
>> >     sign =3D extract64(xb, 63,  1);
>> >     exp  =3D extract64(xb, 52, 11);
>> >     frac =3D extract64(xb,  0, 52) | 0x10000000000000ULL;
>> > @@ -3446,8 +3409,6 @@ VSX_ROUND(xvrspiz, 4, float32, VsrW(i),
>> > float_round_to_zero, 0)
>> >
>> > uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
>> > {
>> > -    helper_reset_fpstatus(env);
>> > -
>> >     uint64_t xt =3D helper_frsp(env, xb);
>> >
>> >     helper_compute_fprf_float64(env, xt);
>> > @@ -3593,8 +3554,6 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t
>> opcode,
>> >     uint8_t rmode =3D 0;
>> >     float_status tstat;
>> >
>> > -    helper_reset_fpstatus(env);
>> > -
>> >     if (r =3D=3D 0 && rmc =3D=3D 0) {
>> >         rmode =3D float_round_ties_away;
>> >     } else if (r =3D=3D 0 && rmc =3D=3D 0x3) {
>> > @@ -3650,8 +3609,6 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t
>> opcode,
>> >     floatx80 round_res;
>> >     float_status tstat;
>> >
>> > -    helper_reset_fpstatus(env);
>> > -
>> >     if (r =3D=3D 0 && rmc =3D=3D 0) {
>> >         rmode =3D float_round_ties_away;
>> >     } else if (r =3D=3D 0 && rmc =3D=3D 0x3) {
>> > @@ -3700,8 +3657,6 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t
>> > opcode,
>> >     ppc_vsr_t t =3D { };
>> >     float_status tstat;
>> >
>> > -    helper_reset_fpstatus(env);
>> > -
>> >     tstat =3D env->fp_status;
>> >     if (unlikely(Rc(opcode) !=3D 0)) {
>> >         tstat.float_rounding_mode =3D float_round_to_odd;
>> > @@ -3734,8 +3689,6 @@ void helper_xssubqp(CPUPPCState *env, uint32_t
>> opcode,
>> >     ppc_vsr_t t =3D *xt;
>> >     float_status tstat;
>> >
>> > -    helper_reset_fpstatus(env);
>> > -
>> >     tstat =3D env->fp_status;
>> >     if (unlikely(Rc(opcode) !=3D 0)) {
>> >         tstat.float_rounding_mode =3D float_round_to_odd;
>> > diff --git a/target/ppc/helper.h b/target/ppc/helper.h
>> > index 4e192de97b..b486c9991f 100644
>> > --- a/target/ppc/helper.h
>> > +++ b/target/ppc/helper.h
>> > @@ -58,7 +58,6 @@ DEF_HELPER_FLAGS_1(cntlzw32, TCG_CALL_NO_RWG_SE, i32,
>> i32)
>> > DEF_HELPER_FLAGS_2(brinc, TCG_CALL_NO_RWG_SE, tl, tl, tl)
>> >
>> > DEF_HELPER_1(float_check_status, void, env)
>> > -DEF_HELPER_1(reset_fpstatus, void, env)
>> > DEF_HELPER_2(compute_fprf_float64, void, env, i64)
>> > DEF_HELPER_3(store_fpscr, void, env, i64, i32)
>> > DEF_HELPER_2(fpscr_clrbit, void, env, i32)
>> > diff --git a/target/ppc/translate/fp-impl.inc.c
>> > b/target/ppc/translate/fp-impl.inc.c
>> > index e18e268fe5..5e8cd9970e 100644
>> > --- a/target/ppc/translate/fp-impl.inc.c
>> > +++ b/target/ppc/translate/fp-impl.inc.c
>> > @@ -4,11 +4,6 @@
>> >  * Standard FPU translation
>> >  */
>> >
>> > -static inline void gen_reset_fpstatus(void)
>> > -{
>> > -    gen_helper_reset_fpstatus(cpu_env);
>> > -}
>> > -
>> > static inline void gen_compute_fprf_float64(TCGv_i64 arg)
>> > {
>> >     gen_helper_compute_fprf_float64(cpu_env, arg);
>> > @@ -48,7 +43,6 @@ static void gen_f##name(DisasContext *ctx)
>> >                     \
>> >     t3 =3D tcg_temp_new_i64();
>> >   \
>> >     /* NIP cannot be restored if the memory exception comes from an
>> helper
>> > */ \
>> >     gen_update_nip(ctx, ctx->base.pc_next - 4);
>> >    \
>> > -    gen_reset_fpstatus();
>> >    \
>> >     get_fpr(t0, rA(ctx->opcode));
>> >    \
>> >     get_fpr(t1, rC(ctx->opcode));
>> >    \
>> >     get_fpr(t2, rB(ctx->opcode));
>> >    \
>> > @@ -88,7 +82,6 @@ static void gen_f##name(DisasContext *ctx)
>> >                     \
>> >     t2 =3D tcg_temp_new_i64();
>> >   \
>> >     /* NIP cannot be restored if the memory exception comes from an
>> helper
>> > */ \
>> >     gen_update_nip(ctx, ctx->base.pc_next - 4);
>> >    \
>> > -    gen_reset_fpstatus();
>> >    \
>> >     get_fpr(t0, rA(ctx->opcode));
>> >    \
>> >     get_fpr(t1, rB(ctx->opcode));
>> >    \
>> >     gen_helper_f##op(t2, cpu_env, t0, t1);
>> >   \
>> > @@ -123,7 +116,6 @@ static void gen_f##name(DisasContext *ctx)
>> >                       \
>> >     t0 =3D tcg_temp_new_i64();
>> >   \
>> >     t1 =3D tcg_temp_new_i64();
>> >   \
>> >     t2 =3D tcg_temp_new_i64();
>> >   \
>> > -    gen_reset_fpstatus();
>> >    \
>> >     get_fpr(t0, rA(ctx->opcode));
>> >    \
>> >     get_fpr(t1, rC(ctx->opcode));
>> >    \
>> >     gen_helper_f##op(t2, cpu_env, t0, t1);
>> >   \
>> > @@ -156,7 +148,6 @@ static void gen_f##name(DisasContext *ctx)
>> >                       \
>> >     }
>> >    \
>> >     t0 =3D tcg_temp_new_i64();
>> >   \
>> >     t1 =3D tcg_temp_new_i64();
>> >   \
>> > -    gen_reset_fpstatus();
>> >    \
>> >     get_fpr(t0, rB(ctx->opcode));
>> >    \
>> >     gen_helper_f##name(t1, cpu_env, t0);
>> >   \
>> >     set_fpr(rD(ctx->opcode), t1);
>> >    \
>> > @@ -181,7 +172,6 @@ static void gen_f##name(DisasContext *ctx)
>> >                       \
>> >     }
>> >    \
>> >     t0 =3D tcg_temp_new_i64();
>> >   \
>> >     t1 =3D tcg_temp_new_i64();
>> >   \
>> > -    gen_reset_fpstatus();
>> >    \
>> >     get_fpr(t0, rB(ctx->opcode));
>> >    \
>> >     gen_helper_f##name(t1, cpu_env, t0);
>> >   \
>> >     set_fpr(rD(ctx->opcode), t1);
>> >    \
>> > @@ -222,7 +212,6 @@ static void gen_frsqrtes(DisasContext *ctx)
>> >     }
>> >     t0 =3D tcg_temp_new_i64();
>> >     t1 =3D tcg_temp_new_i64();
>> > -    gen_reset_fpstatus();
>> >     get_fpr(t0, rB(ctx->opcode));
>> >     gen_helper_frsqrte(t1, cpu_env, t0);
>> >     gen_helper_frsp(t1, cpu_env, t1);
>> > @@ -252,7 +241,6 @@ static void gen_fsqrt(DisasContext *ctx)
>> >     }
>> >     t0 =3D tcg_temp_new_i64();
>> >     t1 =3D tcg_temp_new_i64();
>> > -    gen_reset_fpstatus();
>> >     get_fpr(t0, rB(ctx->opcode));
>> >     gen_helper_fsqrt(t1, cpu_env, t0);
>> >     set_fpr(rD(ctx->opcode), t1);
>> > @@ -274,7 +262,6 @@ static void gen_fsqrts(DisasContext *ctx)
>> >     }
>> >     t0 =3D tcg_temp_new_i64();
>> >     t1 =3D tcg_temp_new_i64();
>> > -    gen_reset_fpstatus();
>> >     get_fpr(t0, rB(ctx->opcode));
>> >     gen_helper_fsqrt(t1, cpu_env, t0);
>> >     gen_helper_frsp(t1, cpu_env, t1);
>> > @@ -380,7 +367,6 @@ static void gen_fcmpo(DisasContext *ctx)
>> >     }
>> >     t0 =3D tcg_temp_new_i64();
>> >     t1 =3D tcg_temp_new_i64();
>> > -    gen_reset_fpstatus();
>> >     crf =3D tcg_const_i32(crfD(ctx->opcode));
>> >     get_fpr(t0, rA(ctx->opcode));
>> >     get_fpr(t1, rB(ctx->opcode));
>> > @@ -403,7 +389,6 @@ static void gen_fcmpu(DisasContext *ctx)
>> >     }
>> >     t0 =3D tcg_temp_new_i64();
>> >     t1 =3D tcg_temp_new_i64();
>> > -    gen_reset_fpstatus();
>> >     crf =3D tcg_const_i32(crfD(ctx->opcode));
>> >     get_fpr(t0, rA(ctx->opcode));
>> >     get_fpr(t1, rB(ctx->opcode));
>> > @@ -612,7 +597,6 @@ static void gen_mffs(DisasContext *ctx)
>> >         return;
>> >     }
>> >     t0 =3D tcg_temp_new_i64();
>> > -    gen_reset_fpstatus();
>> >     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
>> >     set_fpr(rD(ctx->opcode), t0);
>> >     if (unlikely(Rc(ctx->opcode))) {
>> > @@ -635,7 +619,6 @@ static void gen_mffsl(DisasContext *ctx)
>> >         return;
>> >     }
>> >     t0 =3D tcg_temp_new_i64();
>> > -    gen_reset_fpstatus();
>> >     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
>> >     /* Mask everything except mode, status, and enables.  */
>> >     tcg_gen_andi_i64(t0, t0, FP_DRN | FP_STATUS | FP_ENABLES | FP_RN);
>> > @@ -660,7 +643,6 @@ static void gen_mffsce(DisasContext *ctx)
>> >
>> >     t0 =3D tcg_temp_new_i64();
>> >
>> > -    gen_reset_fpstatus();
>> >     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
>> >     set_fpr(rD(ctx->opcode), t0);
>> >
>> > @@ -678,7 +660,6 @@ static void gen_helper_mffscrn(DisasContext *ctx,
>> > TCGv_i64 t1)
>> >     TCGv_i64 t0 =3D tcg_temp_new_i64();
>> >     TCGv_i32 mask =3D tcg_const_i32(0x0001);
>> >
>> > -    gen_reset_fpstatus();
>> >     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
>> >     tcg_gen_andi_i64(t0, t0, FP_DRN | FP_ENABLES | FP_RN);
>> >     set_fpr(rD(ctx->opcode), t0);
>> > @@ -750,7 +731,6 @@ static void gen_mtfsb0(DisasContext *ctx)
>> >         return;
>> >     }
>> >     crb =3D 31 - crbD(ctx->opcode);
>> > -    gen_reset_fpstatus();
>> >     if (likely(crb !=3D FPSCR_FEX && crb !=3D FPSCR_VX)) {
>> >         TCGv_i32 t0;
>> >         t0 =3D tcg_const_i32(crb);
>> > @@ -773,7 +753,6 @@ static void gen_mtfsb1(DisasContext *ctx)
>> >         return;
>> >     }
>> >     crb =3D 31 - crbD(ctx->opcode);
>> > -    gen_reset_fpstatus();
>> >     /* XXX: we pretend we can only do IEEE floating-point computations=
 */
>> >     if (likely(crb !=3D FPSCR_FEX && crb !=3D FPSCR_VX && crb !=3D FPS=
CR_NI)) {
>> >         TCGv_i32 t0;
>> > @@ -807,7 +786,6 @@ static void gen_mtfsf(DisasContext *ctx)
>> >         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
>> >         return;
>> >     }
>> > -    gen_reset_fpstatus();
>> >     if (l) {
>> >         t0 =3D tcg_const_i32((ctx->insns_flags2 & PPC2_ISA205) ? 0xfff=
f :
>> > 0xff);
>> >     } else {
>> > @@ -844,7 +822,6 @@ static void gen_mtfsfi(DisasContext *ctx)
>> >         return;
>> >     }
>> >     sh =3D (8 * w) + 7 - bf;
>> > -    gen_reset_fpstatus();
>> >     t0 =3D tcg_const_i64(((uint64_t)FPIMM(ctx->opcode)) << (4 * sh));
>> >     t1 =3D tcg_const_i32(1 << sh);
>> >     gen_helper_store_fpscr(cpu_env, t0, t1);
>> >


--=20
Alex Benn=C3=A9e

