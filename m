Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F8C28CBC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 00:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6D520735
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 00:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOY338JU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6D520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVPCF-0007uf-3B
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 20:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVPBE-0006oM-SW; Sun, 03 May 2020 20:41:56 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:39086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jVPBC-0006oK-Lu; Sun, 03 May 2020 20:41:56 -0400
Received: by mail-lj1-x22b.google.com with SMTP id u6so8002392ljl.6;
 Sun, 03 May 2020 17:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=nfHqlOpgtzikZSEUA46JbV0dJwAICCWB23dComGmElY=;
 b=uOY338JUiy+mjK3wkCKNWKRZOzmIT6DWwe3qvD4kfTI3/zz5oAVncB0WgNZ2rmUSYN
 s89dW3352UpGE+ayNnzNOC3Wm8Z8wlvv0b45lXajFDhCXG5+kgXW47iwUcCny30o6Ieo
 mDAsyi6Ceo3nDn66QjW1dpgNSYGbhMSeTwO0Rk6WLDKNVBNwKvUfGU6kEM5xZwqArpEJ
 aG4OleGKUY5OpvqMVDwNZTFb3HXU4ynm2xChR+7fL9x+DykcahUs/zqZpa4C3JFAlTIg
 ay1kO4qfOUX584Ulz9f1LHkGsQl3ZAS+dHPTnAxmSYTO2/fao+rM7WBURCq+aPUJLj3L
 xxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=nfHqlOpgtzikZSEUA46JbV0dJwAICCWB23dComGmElY=;
 b=IkeMRlscGGWU2DWUinvVj97/aSgHv43bOEP2SNvt5rymvLdaLSSUA2Ga06j5RvSyit
 AZXqT48Y1+08NGB6MHTbBuiOHXdkJ1xHOFRpYT4WLFMclY7WJwxg4qv7sTcUz641e2aC
 Ogn8Fo55qWoG3JrPZ4NEGo0Wcqn6EdLzzreDRM476K+hQs/BSco+CnR3u+EG3CkOHh/5
 Sbp0yEl0OwAKSqwUj9KO8Y9u0Y7ttpSKWnG23quzRYMXFjp6MO9ncBYMKmDG+guiXREr
 YOLOwpBlG+He3Au7QF8awB7OwUdS3zXyIvHJrrGrt0F9sUa5ys4VQ7z8pKRLzVjDVTQL
 Wa7w==
X-Gm-Message-State: AGi0PuY7gY9rY1gwmue3tSJ0MuJpsh/9X6jd28iNi6BuMzL0gs0GqZAp
 tlrD9wMPbutZs/UWDb1/y6dnjiA7Gzi8cV1SpHw=
X-Google-Smtp-Source: APiQypIXHbiYrTCF1IBXPKAz71L2PChM5a4CU35jVI0NAHZCdB7/OrMEt3Y4IzPqZPOPGc4qtpo2joO6swN5v1HkKgI=
X-Received: by 2002:a2e:800f:: with SMTP id j15mr9009423ljg.27.1588552912342; 
 Sun, 03 May 2020 17:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-XFG8r85yPOhuNS2YUMqhp70q1RXCy+KLT79doW8qHMg@mail.gmail.com>
 <87605674-1cd8-2074-6730-355e20fbf7d0@linaro.org>
 <CAE2XoE8LO-4Ordhxf1-eNZK1taSGnaU4zxQ944-XLvwzmd9rJg@mail.gmail.com>
 <alpine.BSF.2.22.395.2005040128330.7227@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2005040128330.7227@zero.eik.bme.hu>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 4 May 2020 08:41:41 +0800
Message-ID: <CAE2XoE93HqZVvFkZzfuC1VsF-Vw88ggSYMU2t7QjPUPWSU-4-Q@mail.gmail.com>
Subject: Re: An first try to improve PPC float simulation, not even compiled.
 Just ask question.
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="0000000000000c13f105a4c7cccb"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22b.google.com
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000c13f105a4c7cccb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2020 at 7:40 AM BALATON Zoltan <balaton@eik.bme.hu> wrote:

> Hello,
>
> On Mon, 4 May 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > Hello Richard, Can you have a look at the following patch, and was that
> are
> > the right direction?
>
> Formatting of the patch is broken by your mailer, try sending it with
> something that does not change it otherwise it's a bit hard to read.
>
> Richard suggested to add an assert to check the fp_status is correctly
> cleared in place of helper_reset_fpstatus first for debugging so you coul=
d
> change the helper accordingly before deleting it and run a few tests to
> verify it still works. You'll need get some tests and benchmarks working
> to be able to verify your changes that's why I've said that would be step
> 0. If you checked that it still produces the same results and the assert
> does not trigger then you can remove the helper.
>
That's what I need help,
1. How to write a assert to replace helper_reset_fpstatus .
  just directly assert? or something else
2.  a few tests to run
 How to running these tests, and where are these tests.
Do I need to add new tests? Where to start
3.  Benchmarks
Same as 2

>
> Regards,
> BALATON Zoltan
>
> > From b4d6ca1d6376fab1f1be06eb472e10b908887c2b Mon Sep 17 00:00:00 2001
> > From: Yonggang Luo <luoyonggang@gmail.com>
> > Date: Sat, 2 May 2020 05:59:25 +0800
> > Subject: [PATCH] [ppc fp] Step 1. Rearrange the fp helpers to eliminate
> > helper_reset_fpstatus(). I've mentioned this before, that it's possible
> to
> > leave the steady-state of env->fp_status.exception_flags =3D=3D 0, so t=
here's
> > no
> > need for a separate function call.  I suspect this is worth a decent
> > speedup
> > by itself.
> >
> > ---
> > target/ppc/fpu_helper.c            | 53 ++----------------------------
> > target/ppc/helper.h                |  1 -
> > target/ppc/translate/fp-impl.inc.c | 23 -------------
> > 3 files changed, 3 insertions(+), 74 deletions(-)
> >
> > diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> > index d9a8773ee1..4fc5a7ff1c 100644
> > --- a/target/ppc/fpu_helper.c
> > +++ b/target/ppc/fpu_helper.c
> > @@ -821,6 +821,9 @@ static void do_float_check_status(CPUPPCState *env,
> > uintptr_t raddr)
> >                                    env->error_code, raddr);
> >         }
> >     }
> > +    if (status) {
> > +        set_float_exception_flags(0, &env->fp_status);
> > +    }
> > }
> >
> > void helper_float_check_status(CPUPPCState *env)
> > @@ -828,11 +831,6 @@ void helper_float_check_status(CPUPPCState *env)
> >     do_float_check_status(env, GETPC());
> > }
> >
> > -void helper_reset_fpstatus(CPUPPCState *env)
> > -{
> > -    set_float_exception_flags(0, &env->fp_status);
> > -}
> > -
> > static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,
> >                                     uintptr_t retaddr, int classes)
> > {
> > @@ -2110,9 +2108,6 @@ void helper_##name(CPUPPCState *env, ppc_vsr_t *x=
t,
> >                       \
> > {
> >   \
> >     ppc_vsr_t t =3D *xt;
> >  \
> >     int i;
> >  \
> > -
> >  \
> > -    helper_reset_fpstatus(env);
> >   \
> > -
> >  \
> >     for (i =3D 0; i < nels; i++) {
> >  \
> >         float_status tstat =3D env->fp_status;
> >  \
> >         set_float_exception_flags(0, &tstat);
> >   \
> > @@ -2152,8 +2147,6 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t
> opcode,
> >     ppc_vsr_t t =3D *xt;
> >     float_status tstat;
> >
> > -    helper_reset_fpstatus(env);
> > -
> >     tstat =3D env->fp_status;
> >     if (unlikely(Rc(opcode) !=3D 0)) {
> >         tstat.float_rounding_mode =3D float_round_to_odd;
> > @@ -2189,9 +2182,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
> >                       \
> > {
> >   \
> >     ppc_vsr_t t =3D *xt;
> >  \
> >     int i;
> >  \
> > -
> >  \
> > -    helper_reset_fpstatus(env);
> >   \
> > -
> >  \
> >     for (i =3D 0; i < nels; i++) {
> >  \
> >         float_status tstat =3D env->fp_status;
> >  \
> >         set_float_exception_flags(0, &tstat);
> >   \
> > @@ -2228,13 +2218,11 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t
> > opcode,
> >     ppc_vsr_t t =3D *xt;
> >     float_status tstat;
> >
> > -    helper_reset_fpstatus(env);
> >     tstat =3D env->fp_status;
> >     if (unlikely(Rc(opcode) !=3D 0)) {
> >         tstat.float_rounding_mode =3D float_round_to_odd;
> >     }
> >
> > -    set_float_exception_flags(0, &tstat);
> >     t.f128 =3D float128_mul(xa->f128, xb->f128, &tstat);
> >     env->fp_status.float_exception_flags |=3D tstat.float_exception_fla=
gs;
> >
> > @@ -2263,9 +2251,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
> >                        \
> > {
> >    \
> >     ppc_vsr_t t =3D *xt;
> >   \
> >     int i;
> >   \
> > -
> >   \
> > -    helper_reset_fpstatus(env);
> >    \
> > -
> >   \
> >     for (i =3D 0; i < nels; i++) {
> >   \
> >         float_status tstat =3D env->fp_status;
> >   \
> >         set_float_exception_flags(0, &tstat);
> >    \
> > @@ -2305,7 +2290,6 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t
> opcode,
> >     ppc_vsr_t t =3D *xt;
> >     float_status tstat;
> >
> > -    helper_reset_fpstatus(env);
> >     tstat =3D env->fp_status;
> >     if (unlikely(Rc(opcode) !=3D 0)) {
> >         tstat.float_rounding_mode =3D float_round_to_odd;
> > @@ -2342,9 +2326,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
> > ppc_vsr_t *xb)              \
> > {
> >    \
> >     ppc_vsr_t t =3D *xt;
> >   \
> >     int i;
> >   \
> > -
> >   \
> > -    helper_reset_fpstatus(env);
> >    \
> > -
> >   \
> >     for (i =3D 0; i < nels; i++) {
> >   \
> >         if (unlikely(tp##_is_signaling_nan(xb->fld, &env->fp_status))) =
{
> >   \
> >             float_invalid_op_vxsnan(env, GETPC());
> >   \
> > @@ -2382,9 +2363,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
> > ppc_vsr_t *xb)             \
> > {
> >   \
> >     ppc_vsr_t t =3D *xt;
> >  \
> >     int i;
> >  \
> > -
> >  \
> > -    helper_reset_fpstatus(env);
> >   \
> > -
> >  \
> >     for (i =3D 0; i < nels; i++) {
> >  \
> >         float_status tstat =3D env->fp_status;
> >  \
> >         set_float_exception_flags(0, &tstat);
> >   \
> > @@ -2430,9 +2408,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
> > ppc_vsr_t *xb)             \
> > {
> >   \
> >     ppc_vsr_t t =3D *xt;
> >  \
> >     int i;
> >  \
> > -
> >  \
> > -    helper_reset_fpstatus(env);
> >   \
> > -
> >  \
> >     for (i =3D 0; i < nels; i++) {
> >  \
> >         float_status tstat =3D env->fp_status;
> >  \
> >         set_float_exception_flags(0, &tstat);
> >   \
> > @@ -2592,9 +2567,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
> >                        \
> > {
> >    \
> >     ppc_vsr_t t =3D *xt;
> >   \
> >     int i;
> >   \
> > -
> >   \
> > -    helper_reset_fpstatus(env);
> >    \
> > -
> >   \
> >     for (i =3D 0; i < nels; i++) {
> >   \
> >         float_status tstat =3D env->fp_status;
> >   \
> >         set_float_exception_flags(0, &tstat);
> >    \
> > @@ -2765,9 +2737,6 @@ void helper_##op(CPUPPCState *env, uint32_t opcod=
e,
> >                   \
> > {
> \
> >     uint32_t cc =3D 0;
>  \
> >     bool vxsnan_flag =3D false, vxvc_flag =3D false;
>  \
> > -
>  \
> > -    helper_reset_fpstatus(env);
>   \
> > -
>  \
> >     if (float64_is_signaling_nan(xa->VsrD(0), &env->fp_status) ||
> \
> >         float64_is_signaling_nan(xb->VsrD(0), &env->fp_status)) {
> \
> >         vxsnan_flag =3D true;
> \
> > @@ -2813,9 +2782,6 @@ void helper_##op(CPUPPCState *env, uint32_t opcod=
e,
> >                  \
> > {                                                                      =
 \
> >     uint32_t cc =3D 0;                                                 =
   \
> >     bool vxsnan_flag =3D false, vxvc_flag =3D false;                   =
     \
> > -
> \
> > -    helper_reset_fpstatus(env);
>  \
> > -
> \
> >     if (float128_is_signaling_nan(xa->f128, &env->fp_status) ||        =
 \
> >         float128_is_signaling_nan(xb->f128, &env->fp_status)) {        =
 \
> >         vxsnan_flag =3D true;                                          =
   \
> > @@ -3177,9 +3143,6 @@ uint64_t helper_xscvdpspn(CPUPPCState *env,
> uint64_t
> > xb)
> > {
> >     uint64_t result, sign, exp, frac;
> >
> > -    float_status tstat =3D env->fp_status;
> > -    set_float_exception_flags(0, &tstat);
> > -
> >     sign =3D extract64(xb, 63,  1);
> >     exp  =3D extract64(xb, 52, 11);
> >     frac =3D extract64(xb,  0, 52) | 0x10000000000000ULL;
> > @@ -3446,8 +3409,6 @@ VSX_ROUND(xvrspiz, 4, float32, VsrW(i),
> > float_round_to_zero, 0)
> >
> > uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)
> > {
> > -    helper_reset_fpstatus(env);
> > -
> >     uint64_t xt =3D helper_frsp(env, xb);
> >
> >     helper_compute_fprf_float64(env, xt);
> > @@ -3593,8 +3554,6 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t
> opcode,
> >     uint8_t rmode =3D 0;
> >     float_status tstat;
> >
> > -    helper_reset_fpstatus(env);
> > -
> >     if (r =3D=3D 0 && rmc =3D=3D 0) {
> >         rmode =3D float_round_ties_away;
> >     } else if (r =3D=3D 0 && rmc =3D=3D 0x3) {
> > @@ -3650,8 +3609,6 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t
> opcode,
> >     floatx80 round_res;
> >     float_status tstat;
> >
> > -    helper_reset_fpstatus(env);
> > -
> >     if (r =3D=3D 0 && rmc =3D=3D 0) {
> >         rmode =3D float_round_ties_away;
> >     } else if (r =3D=3D 0 && rmc =3D=3D 0x3) {
> > @@ -3700,8 +3657,6 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t
> > opcode,
> >     ppc_vsr_t t =3D { };
> >     float_status tstat;
> >
> > -    helper_reset_fpstatus(env);
> > -
> >     tstat =3D env->fp_status;
> >     if (unlikely(Rc(opcode) !=3D 0)) {
> >         tstat.float_rounding_mode =3D float_round_to_odd;
> > @@ -3734,8 +3689,6 @@ void helper_xssubqp(CPUPPCState *env, uint32_t
> opcode,
> >     ppc_vsr_t t =3D *xt;
> >     float_status tstat;
> >
> > -    helper_reset_fpstatus(env);
> > -
> >     tstat =3D env->fp_status;
> >     if (unlikely(Rc(opcode) !=3D 0)) {
> >         tstat.float_rounding_mode =3D float_round_to_odd;
> > diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> > index 4e192de97b..b486c9991f 100644
> > --- a/target/ppc/helper.h
> > +++ b/target/ppc/helper.h
> > @@ -58,7 +58,6 @@ DEF_HELPER_FLAGS_1(cntlzw32, TCG_CALL_NO_RWG_SE, i32,
> i32)
> > DEF_HELPER_FLAGS_2(brinc, TCG_CALL_NO_RWG_SE, tl, tl, tl)
> >
> > DEF_HELPER_1(float_check_status, void, env)
> > -DEF_HELPER_1(reset_fpstatus, void, env)
> > DEF_HELPER_2(compute_fprf_float64, void, env, i64)
> > DEF_HELPER_3(store_fpscr, void, env, i64, i32)
> > DEF_HELPER_2(fpscr_clrbit, void, env, i32)
> > diff --git a/target/ppc/translate/fp-impl.inc.c
> > b/target/ppc/translate/fp-impl.inc.c
> > index e18e268fe5..5e8cd9970e 100644
> > --- a/target/ppc/translate/fp-impl.inc.c
> > +++ b/target/ppc/translate/fp-impl.inc.c
> > @@ -4,11 +4,6 @@
> >  * Standard FPU translation
> >  */
> >
> > -static inline void gen_reset_fpstatus(void)
> > -{
> > -    gen_helper_reset_fpstatus(cpu_env);
> > -}
> > -
> > static inline void gen_compute_fprf_float64(TCGv_i64 arg)
> > {
> >     gen_helper_compute_fprf_float64(cpu_env, arg);
> > @@ -48,7 +43,6 @@ static void gen_f##name(DisasContext *ctx)
> >                     \
> >     t3 =3D tcg_temp_new_i64();
> >   \
> >     /* NIP cannot be restored if the memory exception comes from an
> helper
> > */ \
> >     gen_update_nip(ctx, ctx->base.pc_next - 4);
> >    \
> > -    gen_reset_fpstatus();
> >    \
> >     get_fpr(t0, rA(ctx->opcode));
> >    \
> >     get_fpr(t1, rC(ctx->opcode));
> >    \
> >     get_fpr(t2, rB(ctx->opcode));
> >    \
> > @@ -88,7 +82,6 @@ static void gen_f##name(DisasContext *ctx)
> >                     \
> >     t2 =3D tcg_temp_new_i64();
> >   \
> >     /* NIP cannot be restored if the memory exception comes from an
> helper
> > */ \
> >     gen_update_nip(ctx, ctx->base.pc_next - 4);
> >    \
> > -    gen_reset_fpstatus();
> >    \
> >     get_fpr(t0, rA(ctx->opcode));
> >    \
> >     get_fpr(t1, rB(ctx->opcode));
> >    \
> >     gen_helper_f##op(t2, cpu_env, t0, t1);
> >   \
> > @@ -123,7 +116,6 @@ static void gen_f##name(DisasContext *ctx)
> >                       \
> >     t0 =3D tcg_temp_new_i64();
> >   \
> >     t1 =3D tcg_temp_new_i64();
> >   \
> >     t2 =3D tcg_temp_new_i64();
> >   \
> > -    gen_reset_fpstatus();
> >    \
> >     get_fpr(t0, rA(ctx->opcode));
> >    \
> >     get_fpr(t1, rC(ctx->opcode));
> >    \
> >     gen_helper_f##op(t2, cpu_env, t0, t1);
> >   \
> > @@ -156,7 +148,6 @@ static void gen_f##name(DisasContext *ctx)
> >                       \
> >     }
> >    \
> >     t0 =3D tcg_temp_new_i64();
> >   \
> >     t1 =3D tcg_temp_new_i64();
> >   \
> > -    gen_reset_fpstatus();
> >    \
> >     get_fpr(t0, rB(ctx->opcode));
> >    \
> >     gen_helper_f##name(t1, cpu_env, t0);
> >   \
> >     set_fpr(rD(ctx->opcode), t1);
> >    \
> > @@ -181,7 +172,6 @@ static void gen_f##name(DisasContext *ctx)
> >                       \
> >     }
> >    \
> >     t0 =3D tcg_temp_new_i64();
> >   \
> >     t1 =3D tcg_temp_new_i64();
> >   \
> > -    gen_reset_fpstatus();
> >    \
> >     get_fpr(t0, rB(ctx->opcode));
> >    \
> >     gen_helper_f##name(t1, cpu_env, t0);
> >   \
> >     set_fpr(rD(ctx->opcode), t1);
> >    \
> > @@ -222,7 +212,6 @@ static void gen_frsqrtes(DisasContext *ctx)
> >     }
> >     t0 =3D tcg_temp_new_i64();
> >     t1 =3D tcg_temp_new_i64();
> > -    gen_reset_fpstatus();
> >     get_fpr(t0, rB(ctx->opcode));
> >     gen_helper_frsqrte(t1, cpu_env, t0);
> >     gen_helper_frsp(t1, cpu_env, t1);
> > @@ -252,7 +241,6 @@ static void gen_fsqrt(DisasContext *ctx)
> >     }
> >     t0 =3D tcg_temp_new_i64();
> >     t1 =3D tcg_temp_new_i64();
> > -    gen_reset_fpstatus();
> >     get_fpr(t0, rB(ctx->opcode));
> >     gen_helper_fsqrt(t1, cpu_env, t0);
> >     set_fpr(rD(ctx->opcode), t1);
> > @@ -274,7 +262,6 @@ static void gen_fsqrts(DisasContext *ctx)
> >     }
> >     t0 =3D tcg_temp_new_i64();
> >     t1 =3D tcg_temp_new_i64();
> > -    gen_reset_fpstatus();
> >     get_fpr(t0, rB(ctx->opcode));
> >     gen_helper_fsqrt(t1, cpu_env, t0);
> >     gen_helper_frsp(t1, cpu_env, t1);
> > @@ -380,7 +367,6 @@ static void gen_fcmpo(DisasContext *ctx)
> >     }
> >     t0 =3D tcg_temp_new_i64();
> >     t1 =3D tcg_temp_new_i64();
> > -    gen_reset_fpstatus();
> >     crf =3D tcg_const_i32(crfD(ctx->opcode));
> >     get_fpr(t0, rA(ctx->opcode));
> >     get_fpr(t1, rB(ctx->opcode));
> > @@ -403,7 +389,6 @@ static void gen_fcmpu(DisasContext *ctx)
> >     }
> >     t0 =3D tcg_temp_new_i64();
> >     t1 =3D tcg_temp_new_i64();
> > -    gen_reset_fpstatus();
> >     crf =3D tcg_const_i32(crfD(ctx->opcode));
> >     get_fpr(t0, rA(ctx->opcode));
> >     get_fpr(t1, rB(ctx->opcode));
> > @@ -612,7 +597,6 @@ static void gen_mffs(DisasContext *ctx)
> >         return;
> >     }
> >     t0 =3D tcg_temp_new_i64();
> > -    gen_reset_fpstatus();
> >     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
> >     set_fpr(rD(ctx->opcode), t0);
> >     if (unlikely(Rc(ctx->opcode))) {
> > @@ -635,7 +619,6 @@ static void gen_mffsl(DisasContext *ctx)
> >         return;
> >     }
> >     t0 =3D tcg_temp_new_i64();
> > -    gen_reset_fpstatus();
> >     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
> >     /* Mask everything except mode, status, and enables.  */
> >     tcg_gen_andi_i64(t0, t0, FP_DRN | FP_STATUS | FP_ENABLES | FP_RN);
> > @@ -660,7 +643,6 @@ static void gen_mffsce(DisasContext *ctx)
> >
> >     t0 =3D tcg_temp_new_i64();
> >
> > -    gen_reset_fpstatus();
> >     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
> >     set_fpr(rD(ctx->opcode), t0);
> >
> > @@ -678,7 +660,6 @@ static void gen_helper_mffscrn(DisasContext *ctx,
> > TCGv_i64 t1)
> >     TCGv_i64 t0 =3D tcg_temp_new_i64();
> >     TCGv_i32 mask =3D tcg_const_i32(0x0001);
> >
> > -    gen_reset_fpstatus();
> >     tcg_gen_extu_tl_i64(t0, cpu_fpscr);
> >     tcg_gen_andi_i64(t0, t0, FP_DRN | FP_ENABLES | FP_RN);
> >     set_fpr(rD(ctx->opcode), t0);
> > @@ -750,7 +731,6 @@ static void gen_mtfsb0(DisasContext *ctx)
> >         return;
> >     }
> >     crb =3D 31 - crbD(ctx->opcode);
> > -    gen_reset_fpstatus();
> >     if (likely(crb !=3D FPSCR_FEX && crb !=3D FPSCR_VX)) {
> >         TCGv_i32 t0;
> >         t0 =3D tcg_const_i32(crb);
> > @@ -773,7 +753,6 @@ static void gen_mtfsb1(DisasContext *ctx)
> >         return;
> >     }
> >     crb =3D 31 - crbD(ctx->opcode);
> > -    gen_reset_fpstatus();
> >     /* XXX: we pretend we can only do IEEE floating-point computations =
*/
> >     if (likely(crb !=3D FPSCR_FEX && crb !=3D FPSCR_VX && crb !=3D FPSC=
R_NI)) {
> >         TCGv_i32 t0;
> > @@ -807,7 +786,6 @@ static void gen_mtfsf(DisasContext *ctx)
> >         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> >         return;
> >     }
> > -    gen_reset_fpstatus();
> >     if (l) {
> >         t0 =3D tcg_const_i32((ctx->insns_flags2 & PPC2_ISA205) ? 0xffff=
 :
> > 0xff);
> >     } else {
> > @@ -844,7 +822,6 @@ static void gen_mtfsfi(DisasContext *ctx)
> >         return;
> >     }
> >     sh =3D (8 * w) + 7 - bf;
> > -    gen_reset_fpstatus();
> >     t0 =3D tcg_const_i64(((uint64_t)FPIMM(ctx->opcode)) << (4 * sh));
> >     t1 =3D tcg_const_i32(1 << sh);
> >     gen_helper_store_fpscr(cpu_env, t0, t1);
> >



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000000c13f105a4c7cccb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 4, 2020 at 7:40 AM BALATO=
N Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,=
<br>
<br>
On Mon, 4 May 2020, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
&gt; Hello Richard, Can you have a look at the following patch, and was tha=
t are<br>
&gt; the right direction?<br>
<br>
Formatting of the patch is broken by your mailer, try sending it with <br>
something that does not change it otherwise it&#39;s a bit hard to read.<br=
>
<br>
Richard suggested to add an assert to check the fp_status is correctly <br>
cleared in place of helper_reset_fpstatus first for debugging so you could =
<br>
change the helper accordingly before deleting it and run a few tests to <br=
>
verify it still works. You&#39;ll need get some tests and benchmarks workin=
g <br>
to be able to verify your changes that&#39;s why I&#39;ve said that would b=
e step <br>
0. If you checked that it still produces the same results and the assert <b=
r>
does not trigger then you can remove the helper.<br></blockquote><div>That&=
#39;s what I need help,</div><div>1. How to write a assert=C2=A0to replace

helper_reset_fpstatus

 .</div><div>=C2=A0 just directly assert? or something else</div><div>2.=C2=
=A0

a few tests to run</div><div>=C2=A0How to running these tests, and where ar=
e these tests.</div><div>Do I need to add new tests? Where to start</div><d=
iv>3.=C2=A0

 Benchmarks

</div><div>Same as 2</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
&gt; From b4d6ca1d6376fab1f1be06eb472e10b908887c2b Mon Sep 17 00:00:00 2001=
<br>
&gt; From: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=
=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; Date: Sat, 2 May 2020 05:59:25 +0800<br>
&gt; Subject: [PATCH] [ppc fp] Step 1. Rearrange the fp helpers to eliminat=
e<br>
&gt; helper_reset_fpstatus(). I&#39;ve mentioned this before, that it&#39;s=
 possible to<br>
&gt; leave the steady-state of env-&gt;fp_status.exception_flags =3D=3D 0, =
so there&#39;s<br>
&gt; no<br>
&gt; need for a separate function call.=C2=A0 I suspect this is worth a dec=
ent<br>
&gt; speedup<br>
&gt; by itself.<br>
&gt;<br>
&gt; ---<br>
&gt; target/ppc/fpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 53 =
++----------------------------<br>
&gt; target/ppc/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1 -<br>
&gt; target/ppc/translate/fp-impl.inc.c | 23 -------------<br>
&gt; 3 files changed, 3 insertions(+), 74 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c<br>
&gt; index d9a8773ee1..4fc5a7ff1c 100644<br>
&gt; --- a/target/ppc/fpu_helper.c<br>
&gt; +++ b/target/ppc/fpu_helper.c<br>
&gt; @@ -821,6 +821,9 @@ static void do_float_check_status(CPUPPCState *env=
,<br>
&gt; uintptr_t raddr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;error_code,=
 raddr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 if (status) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(0, &amp;env-&gt=
;fp_status);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; }<br>
&gt;<br>
&gt; void helper_float_check_status(CPUPPCState *env)<br>
&gt; @@ -828,11 +831,6 @@ void helper_float_check_status(CPUPPCState *env)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0do_float_check_status(env, GETPC());<br>
&gt; }<br>
&gt;<br>
&gt; -void helper_reset_fpstatus(CPUPPCState *env)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;env-&gt;fp_status);<b=
r>
&gt; -}<br>
&gt; -<br>
&gt; static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t ret=
addr, int classes)<br>
&gt; {<br>
&gt; @@ -2110,9 +2108,6 @@ void helper_##name(CPUPPCState *env, ppc_vsr_t *=
xt,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0ppc_vsr_t t =3D *xt;<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 \<br>
&gt; -<br>
&gt;=C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_sta=
tus;<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_float_exception_flags(0, &amp;tst=
at);<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; @@ -2152,8 +2147,6 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t o=
pcode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0ppc_vsr_t t =3D *xt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0float_status tstat;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0tstat =3D env-&gt;fp_status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (unlikely(Rc(opcode) !=3D 0)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tstat.float_rounding_mode =3D float_r=
ound_to_odd;<br>
&gt; @@ -2189,9 +2182,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0ppc_vsr_t t =3D *xt;<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 \<br>
&gt; -<br>
&gt;=C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_sta=
tus;<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_float_exception_flags(0, &amp;tst=
at);<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; @@ -2228,13 +2218,11 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t=
<br>
&gt; opcode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0ppc_vsr_t t =3D *xt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0float_status tstat;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tstat =3D env-&gt;fp_status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (unlikely(Rc(opcode) !=3D 0)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tstat.float_rounding_mode =3D float_r=
ound_to_odd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);<br>
&gt;=C2=A0 =C2=A0 =C2=A0t.f128 =3D float128_mul(xa-&gt;f128, xb-&gt;f128, &=
amp;tstat);<br>
&gt;=C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.float_exception_flags |=3D tstat.=
float_exception_flags;<br>
&gt;<br>
&gt; @@ -2263,9 +2251,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0ppc_vsr_t t =3D *xt;<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_sta=
tus;<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_float_exception_flags(0, &amp;tst=
at);<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt; @@ -2305,7 +2290,6 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t o=
pcode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0ppc_vsr_t t =3D *xt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0float_status tstat;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tstat =3D env-&gt;fp_status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (unlikely(Rc(opcode) !=3D 0)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tstat.float_rounding_mode =3D float_r=
ound_to_odd;<br>
&gt; @@ -2342,9 +2326,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt=
,<br>
&gt; ppc_vsr_t *xb)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0ppc_vsr_t t =3D *xt;<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(tp##_is_signaling_nan(xb=
-&gt;fld, &amp;env-&gt;fp_status))) {<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_invalid_op_vxsnan=
(env, GETPC());<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; @@ -2382,9 +2363,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt=
,<br>
&gt; ppc_vsr_t *xb)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0ppc_vsr_t t =3D *xt;<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 \<br>
&gt; -<br>
&gt;=C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_sta=
tus;<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_float_exception_flags(0, &amp;tst=
at);<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; @@ -2430,9 +2408,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt=
,<br>
&gt; ppc_vsr_t *xb)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0ppc_vsr_t t =3D *xt;<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 \<br>
&gt; -<br>
&gt;=C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_sta=
tus;<br>
&gt;=C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_float_exception_flags(0, &amp;tst=
at);<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; @@ -2592,9 +2567,6 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0ppc_vsr_t t =3D *xt;<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_sta=
tus;<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_float_exception_flags(0, &amp;tst=
at);<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt; @@ -2765,9 +2737,6 @@ void helper_##op(CPUPPCState *env, uint32_t opco=
de,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
&gt; {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t cc =3D 0;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool vxsnan_flag =3D false, vxvc_flag =3D false;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (float64_is_signaling_nan(xa-&gt;VsrD(0), &amp;e=
nv-&gt;fp_status) ||=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float64_is_signaling_nan(xb-&gt;VsrD(=
0), &amp;env-&gt;fp_status)) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vxsnan_flag =3D true;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \=
<br>
&gt; @@ -2813,9 +2782,6 @@ void helper_##op(CPUPPCState *env, uint32_t opco=
de,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint32_t cc =3D 0;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool vxsnan_flag =3D false, vxvc_flag =3D false;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (float128_is_signaling_nan(xa-&gt;f128, &amp;env=
-&gt;fp_status) ||=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float128_is_signaling_nan(xb-&gt;f128=
, &amp;env-&gt;fp_status)) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vxsnan_flag =3D true;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<=
br>
&gt; @@ -3177,9 +3143,6 @@ uint64_t helper_xscvdpspn(CPUPPCState *env, uint=
64_t<br>
&gt; xb)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint64_t result, sign, exp, frac;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 float_status tstat =3D env-&gt;fp_status;<br>
&gt; -=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0sign =3D extract64(xb, 63,=C2=A0 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0exp=C2=A0 =3D extract64(xb, 52, 11);<br>
&gt;=C2=A0 =C2=A0 =C2=A0frac =3D extract64(xb,=C2=A0 0, 52) | 0x10000000000=
000ULL;<br>
&gt; @@ -3446,8 +3409,6 @@ VSX_ROUND(xvrspiz, 4, float32, VsrW(i),<br>
&gt; float_round_to_zero, 0)<br>
&gt;<br>
&gt; uint64_t helper_xsrsp(CPUPPCState *env, uint64_t xb)<br>
&gt; {<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint64_t xt =3D helper_frsp(env, xb);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0helper_compute_fprf_float64(env, xt);<br>
&gt; @@ -3593,8 +3554,6 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t op=
code,<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint8_t rmode =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0float_status tstat;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (r =3D=3D 0 &amp;&amp; rmc =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmode =3D float_round_ties_away;<br>
&gt;=C2=A0 =C2=A0 =C2=A0} else if (r =3D=3D 0 &amp;&amp; rmc =3D=3D 0x3) {<=
br>
&gt; @@ -3650,8 +3609,6 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t o=
pcode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0floatx80 round_res;<br>
&gt;=C2=A0 =C2=A0 =C2=A0float_status tstat;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (r =3D=3D 0 &amp;&amp; rmc =3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rmode =3D float_round_ties_away;<br>
&gt;=C2=A0 =C2=A0 =C2=A0} else if (r =3D=3D 0 &amp;&amp; rmc =3D=3D 0x3) {<=
br>
&gt; @@ -3700,8 +3657,6 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t<=
br>
&gt; opcode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0ppc_vsr_t t =3D { };<br>
&gt;=C2=A0 =C2=A0 =C2=A0float_status tstat;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0tstat =3D env-&gt;fp_status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (unlikely(Rc(opcode) !=3D 0)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tstat.float_rounding_mode =3D float_r=
ound_to_odd;<br>
&gt; @@ -3734,8 +3689,6 @@ void helper_xssubqp(CPUPPCState *env, uint32_t o=
pcode,<br>
&gt;=C2=A0 =C2=A0 =C2=A0ppc_vsr_t t =3D *xt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0float_status tstat;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 helper_reset_fpstatus(env);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0tstat =3D env-&gt;fp_status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (unlikely(Rc(opcode) !=3D 0)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tstat.float_rounding_mode =3D float_r=
ound_to_odd;<br>
&gt; diff --git a/target/ppc/helper.h b/target/ppc/helper.h<br>
&gt; index 4e192de97b..b486c9991f 100644<br>
&gt; --- a/target/ppc/helper.h<br>
&gt; +++ b/target/ppc/helper.h<br>
&gt; @@ -58,7 +58,6 @@ DEF_HELPER_FLAGS_1(cntlzw32, TCG_CALL_NO_RWG_SE, i32=
, i32)<br>
&gt; DEF_HELPER_FLAGS_2(brinc, TCG_CALL_NO_RWG_SE, tl, tl, tl)<br>
&gt;<br>
&gt; DEF_HELPER_1(float_check_status, void, env)<br>
&gt; -DEF_HELPER_1(reset_fpstatus, void, env)<br>
&gt; DEF_HELPER_2(compute_fprf_float64, void, env, i64)<br>
&gt; DEF_HELPER_3(store_fpscr, void, env, i64, i32)<br>
&gt; DEF_HELPER_2(fpscr_clrbit, void, env, i32)<br>
&gt; diff --git a/target/ppc/translate/fp-impl.inc.c<br>
&gt; b/target/ppc/translate/fp-impl.inc.c<br>
&gt; index e18e268fe5..5e8cd9970e 100644<br>
&gt; --- a/target/ppc/translate/fp-impl.inc.c<br>
&gt; +++ b/target/ppc/translate/fp-impl.inc.c<br>
&gt; @@ -4,11 +4,6 @@<br>
&gt;=C2=A0 * Standard FPU translation<br>
&gt;=C2=A0 */<br>
&gt;<br>
&gt; -static inline void gen_reset_fpstatus(void)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 gen_helper_reset_fpstatus(cpu_env);<br>
&gt; -}<br>
&gt; -<br>
&gt; static inline void gen_compute_fprf_float64(TCGv_i64 arg)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_helper_compute_fprf_float64(cpu_env, arg);<br>
&gt; @@ -48,7 +43,6 @@ static void gen_f##name(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0t3 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0/* NIP cannot be restored if the memory exception c=
omes from an helper<br>
&gt; */ \<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_update_nip(ctx, ctx-&gt;base.pc_next - 4);<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t0, rA(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t1, rC(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t2, rB(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt; @@ -88,7 +82,6 @@ static void gen_f##name(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0t2 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0/* NIP cannot be restored if the memory exception c=
omes from an helper<br>
&gt; */ \<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_update_nip(ctx, ctx-&gt;base.pc_next - 4);<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t0, rA(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t1, rB(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_helper_f##op(t2, cpu_env, t0, t1);<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; @@ -123,7 +116,6 @@ static void gen_f##name(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0t0 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0t1 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0t2 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t0, rA(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t1, rC(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_helper_f##op(t2, cpu_env, t0, t1);<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; @@ -156,7 +148,6 @@ static void gen_f##name(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0t0 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0t1 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t0, rB(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_helper_f##name(t1, cpu_env, t0);<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0set_fpr(rD(ctx-&gt;opcode), t1);<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt; @@ -181,7 +172,6 @@ static void gen_f##name(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0t0 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0t1 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0\<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t0, rB(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_helper_f##name(t1, cpu_env, t0);<br>
&gt;=C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0 =C2=A0set_fpr(rD(ctx-&gt;opcode), t1);<br>
&gt;=C2=A0 =C2=A0 \<br>
&gt; @@ -222,7 +212,6 @@ static void gen_frsqrtes(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0t0 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0 =C2=A0t1 =3D tcg_temp_new_i64();<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t0, rB(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_helper_frsqrte(t1, cpu_env, t0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_helper_frsp(t1, cpu_env, t1);<br>
&gt; @@ -252,7 +241,6 @@ static void gen_fsqrt(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0t0 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0 =C2=A0t1 =3D tcg_temp_new_i64();<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t0, rB(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_helper_fsqrt(t1, cpu_env, t0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0set_fpr(rD(ctx-&gt;opcode), t1);<br>
&gt; @@ -274,7 +262,6 @@ static void gen_fsqrts(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0t0 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0 =C2=A0t1 =3D tcg_temp_new_i64();<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t0, rB(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_helper_fsqrt(t1, cpu_env, t0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_helper_frsp(t1, cpu_env, t1);<br>
&gt; @@ -380,7 +367,6 @@ static void gen_fcmpo(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0t0 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0 =C2=A0t1 =3D tcg_temp_new_i64();<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0crf =3D tcg_const_i32(crfD(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t0, rA(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t1, rB(ctx-&gt;opcode));<br>
&gt; @@ -403,7 +389,6 @@ static void gen_fcmpu(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0t0 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0 =C2=A0t1 =3D tcg_temp_new_i64();<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0crf =3D tcg_const_i32(crfD(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t0, rA(ctx-&gt;opcode));<br>
&gt;=C2=A0 =C2=A0 =C2=A0get_fpr(t1, rB(ctx-&gt;opcode));<br>
&gt; @@ -612,7 +597,6 @@ static void gen_mffs(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0t0 =3D tcg_temp_new_i64();<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_extu_tl_i64(t0, cpu_fpscr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0set_fpr(rD(ctx-&gt;opcode), t0);<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (unlikely(Rc(ctx-&gt;opcode))) {<br>
&gt; @@ -635,7 +619,6 @@ static void gen_mffsl(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0t0 =3D tcg_temp_new_i64();<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_extu_tl_i64(t0, cpu_fpscr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0/* Mask everything except mode, status, and enables=
.=C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_andi_i64(t0, t0, FP_DRN | FP_STATUS | FP_EN=
ABLES | FP_RN);<br>
&gt; @@ -660,7 +643,6 @@ static void gen_mffsce(DisasContext *ctx)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0t0 =3D tcg_temp_new_i64();<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_extu_tl_i64(t0, cpu_fpscr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0set_fpr(rD(ctx-&gt;opcode), t0);<br>
&gt;<br>
&gt; @@ -678,7 +660,6 @@ static void gen_helper_mffscrn(DisasContext *ctx,<=
br>
&gt; TCGv_i64 t1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv_i64 t0 =3D tcg_temp_new_i64();<br>
&gt;=C2=A0 =C2=A0 =C2=A0TCGv_i32 mask =3D tcg_const_i32(0x0001);<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_extu_tl_i64(t0, cpu_fpscr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_andi_i64(t0, t0, FP_DRN | FP_ENABLES | FP_R=
N);<br>
&gt;=C2=A0 =C2=A0 =C2=A0set_fpr(rD(ctx-&gt;opcode), t0);<br>
&gt; @@ -750,7 +731,6 @@ static void gen_mtfsb0(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0crb =3D 31 - crbD(ctx-&gt;opcode);<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (likely(crb !=3D FPSCR_FEX &amp;&amp; crb !=3D F=
PSCR_VX)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i32 t0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t0 =3D tcg_const_i32(crb);<br>
&gt; @@ -773,7 +753,6 @@ static void gen_mtfsb1(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0crb =3D 31 - crbD(ctx-&gt;opcode);<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0/* XXX: we pretend we can only do IEEE floating-poi=
nt computations */<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (likely(crb !=3D FPSCR_FEX &amp;&amp; crb !=3D F=
PSCR_VX &amp;&amp; crb !=3D FPSCR_NI)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_i32 t0;<br>
&gt; @@ -807,7 +786,6 @@ static void gen_mtfsf(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_inval_exception(ctx, POWERPC_EXCP=
_INVAL_INVAL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0if (l) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t0 =3D tcg_const_i32((ctx-&gt;insns_f=
lags2 &amp; PPC2_ISA205) ? 0xffff :<br>
&gt; 0xff);<br>
&gt;=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; @@ -844,7 +822,6 @@ static void gen_mtfsfi(DisasContext *ctx)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0sh =3D (8 * w) + 7 - bf;<br>
&gt; -=C2=A0 =C2=A0 gen_reset_fpstatus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0t0 =3D tcg_const_i64(((uint64_t)FPIMM(ctx-&gt;opcod=
e)) &lt;&lt; (4 * sh));<br>
&gt;=C2=A0 =C2=A0 =C2=A0t1 =3D tcg_const_i32(1 &lt;&lt; sh);<br>
&gt;=C2=A0 =C2=A0 =C2=A0gen_helper_store_fpscr(cpu_env, t0, t1);<br>
&gt;</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr" class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=
=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =
=C2=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000000c13f105a4c7cccb--

