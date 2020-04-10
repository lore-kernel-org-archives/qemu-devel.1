Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AD9C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 13:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B45320CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 13:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smTB9+qh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B45320CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMu4J-0006y2-Hd
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 09:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jMu3E-00066V-9c
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luoyonggang@gmail.com>) id 1jMu3A-0004XT-Ip
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:50:32 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:43824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <luoyonggang@gmail.com>)
 id 1jMu3A-0004X4-4J; Fri, 10 Apr 2020 09:50:28 -0400
Received: by mail-lj1-x242.google.com with SMTP id h25so1991503lja.10;
 Fri, 10 Apr 2020 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=z6XrEDUBTneDEWXqILqwOqRT/ZGTHdfVJaJ8LKQMqIM=;
 b=smTB9+qhSTB3jwSlN+tlMpKMd+GBC0WR3WM2pfoAJQoCw2y+tnJD+IlMwnx3S8Olku
 nLi32+4/FOzjG0b28mbjUabN/5TAadf4attq0cNwQTJc4HxP9ca5UL1Vj5ksPKx1z5Te
 j4/ADBSPD8iyka0oXtDjAP3bav35Rmypssj3LsxSaCUib6QEpWnszQa8QPV7PPvJKe9N
 bbUqrd2+l2ImNlJbZ1g1OvF6BDyZ6yINgSNAFVVCciReyG1tdNRgMCWYb2E7ELuW7LOR
 Og/ippCCKd51O0y2GLkPdnU7ZQwxLP0W6qZrAOc1Hr8gWJSOvmk1OFFyFP8TVJqvYxwE
 v1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=z6XrEDUBTneDEWXqILqwOqRT/ZGTHdfVJaJ8LKQMqIM=;
 b=SAide/t4bJxNE9WAAbLVMqsEc9EeCU/c7brPZSgq0+2QMYzGGTHdJMo+XyAjSOADU5
 M5zAAM9oNFl4Jqr6kXZHxJhXsawd4Qa9U3DjHloka4nY/tUBnWdrHC3waoai4QWes7wO
 XJaFRYW1SOjg0gNdzev/T/RqCR8clEVYH2xyBICCf2+I18w8axluCkZiUFxpVAiCHz7i
 ucmbZdgEk95iyGYg1XxaW53d7hdIrkff7/3+NYH4wR2GQke3rVKRQ4E1icdc7M7qFGT4
 2l/xbBvFtVgbh1hnWLBcrdVGm+O3fUHVjhpmglAt/Up0GcV29soXyvvRrO2dfBFjsQkp
 VLRQ==
X-Gm-Message-State: AGi0PuZgVhVaL32feVckW+ANmsyEvA805iloSSmCtGrJaGuAAdBy1TZJ
 Ilg5PNXpPuhlDNDI0LHaXohXSlnYnX2wnly3CV8=
X-Google-Smtp-Source: APiQypJA/7Jaa8mOckzVQTHvqRRA5DPZ8fsDAXYz1BMbi656Lg/Pha4I+q89nnUJITcTBjYH9QewqB7y+0leNo1gH3g=
X-Received: by 2002:a2e:9247:: with SMTP id v7mr2901819ljg.215.1586526626024; 
 Fri, 10 Apr 2020 06:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200218171702.979F074637D@zero.eik.bme.hu>
In-Reply-To: <20200218171702.979F074637D@zero.eik.bme.hu>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 10 Apr 2020 21:50:13 +0800
Message-ID: <CAE2XoE9dd3NL3sNUNhR1VhntZX37UFUv7Lqf5HbDTi_0t0_Krg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="000000000000f8923605a2f0036e"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc@nongnu.org,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f8923605a2f0036e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Are this stable now? I'd like to see hard float to be landed:)

On Wed, Feb 19, 2020 at 1:19 AM BALATON Zoltan <balaton@eik.bme.hu> wrote:

> While other targets take advantage of using host FPU to do floating
> point computations, this was disabled for PPC target because always
> clearing exception flags before every FP op made it slightly slower
> than emulating everyting with softfloat. To emulate some FPSCR bits,
> clearing of fp_status may be necessary (unless these could be handled
> e.g. using FP exceptions on host but there's no API for that in QEMU
> yet) but preserving at least the inexact flag makes hardfloat usable
> and faster than softfloat. Since most clients don't actually care
> about this flag, we can gain some speed trading some emulation
> accuracy.
>
> This patch implements a simple way to keep the inexact flag set for
> hardfloat while still allowing to revert to softfloat for workloads
> that need more accurate albeit slower emulation. (Set hardfloat
> property of CPU, i.e. -cpu name,hardfloat=3Dfalse for that.) There may
> still be room for further improvement but this seems to increase
> floating point performance. Unfortunately the softfloat case is slower
> than before this patch so this patch only makes sense if the default
> is also set to enable hardfloat.
>
> Because of the above this patch at the moment is mainly for testing
> different workloads to evaluate how viable would this be in practice.
> Thus, RFC and not ready for merge yet.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v2: use different approach to avoid needing if () in
> helper_reset_fpstatus() but this does not seem to change overhead
> much, also make it a single patch as adding the hardfloat option is
> only a few lines; with this we can use same value at other places where
> float_status is reset and maybe enable hardfloat for a few more places
> for a little more performance but not too much. With this I got:
>
> lame: 3:13, lame_vmx: 1:55 (this is probably within jitter though and
> still far from the results on real hardware) also tried mplayer test
> and got results between 144-146s (this test is more VMX bound).
>
> I've also done some profiling for hardfloat=3Dtrue and false cases with
> this patch to see what are the hot functions. Results are:
>
> Overhead  Command          Symbol
> -cpu G4,hardfloat=3Dfalse, lame:
>    9.82%  qemu-system-ppc  [.] round_canonical
>    8.35%  qemu-system-ppc  [.] soft_f64_muladd
>    7.16%  qemu-system-ppc  [.] soft_f64_addsub
>    5.27%  qemu-system-ppc  [.] float32_to_float64
>    5.20%  qemu-system-ppc  [.] helper_compute_fprf_float64
>    4.61%  qemu-system-ppc  [.] helper_frsp
>    4.59%  qemu-system-ppc  [.] soft_f64_mul
>    4.01%  qemu-system-ppc  [.] float_to_float.isra.26
>    3.84%  qemu-system-ppc  [.] float64_classify
>    2.97%  qemu-system-ppc  [.] do_float_check_status
>
> -cpu G4,hardfloat=3Dfalse, lame_vmx:
> Overhead  Command          Symbol
>   10.04%  qemu-system-ppc  [.] float32_muladd
>    9.49%  qemu-system-ppc  [.] helper_vperm
>    6.10%  qemu-system-ppc  [.] round_canonical
>    4.13%  qemu-system-ppc  [.] soft_f64_addsub
>    3.23%  qemu-system-ppc  [.] helper_frsp
>    3.13%  qemu-system-ppc  [.] soft_f64_muladd
>    2.88%  qemu-system-ppc  [.] helper_vmaddfp
>    2.69%  qemu-system-ppc  [.] float32_add
>    2.60%  qemu-system-ppc  [.] float32_to_float64
>    2.52%  qemu-system-ppc  [.] helper_compute_fprf_float64
>
> -cpu G4,hardfloat=3Dtrue, lame:
>   11.59%  qemu-system-ppc  [.] round_canonical
>    6.18%  qemu-system-ppc  [.] helper_compute_fprf_float64
>    6.01%  qemu-system-ppc  [.] float32_to_float64
>    4.58%  qemu-system-ppc  [.] float64_classify
>    3.87%  qemu-system-ppc  [.] helper_frsp
>    3.75%  qemu-system-ppc  [.] float_to_float.isra.26
>    3.48%  qemu-system-ppc  [.] helper_todouble
>    3.31%  qemu-system-ppc  [.] float64_muladd
>    3.21%  qemu-system-ppc  [.] do_float_check_status
>    3.01%  qemu-system-ppc  [.] float64_mul
>
> -cpu G4,hardfloat=3Dtrue, lame_vmx:
>    9.34%  qemu-system-ppc  [.] float32_muladd
>    8.83%  qemu-system-ppc  [.] helper_vperm
>    5.41%  qemu-system-ppc  [.] round_canonical
>    4.51%  qemu-system-ppc  [.] page_collection_lock
>    3.58%  qemu-system-ppc  [.] page_trylock_add.isra.17
>    2.71%  qemu-system-ppc  [.] helper_vmaddfp
>    2.53%  qemu-system-ppc  [.] float32_add
>    2.30%  qemu-system-ppc  [.] helper_compute_fprf_float64
>    2.21%  qemu-system-ppc  [.] float32_to_float64
>    2.06%  qemu-system-ppc  [.] helper_frsp
>
> round_canonical seems to come up frequently in this with large overhead.
>
> Could those with better test cases or benchmarks give it a test please
> on different CPUs to see what else this would break?
>
> ---
> fpu/softfloat.c                 | 14 +++++++-------
>  target/ppc/cpu.h                |  2 ++
>  target/ppc/fpu_helper.c         | 32 ++++++++++++++++----------------
>  target/ppc/translate_init.inc.c |  3 +++
>  4 files changed, 28 insertions(+), 23 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 301ce3b537..6d3f4af72a 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -216,15 +216,15 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)
>  #endif
>
>  /*
> - * Some targets clear the FP flags before most FP operations. This
> prevents
> - * the use of hardfloat, since hardfloat relies on the inexact flag bein=
g
> - * already set.
> + * Disable hardfloat for known problem cases.
> + * Additionally, some targets clear the FP flags before most FP
> operations.
> + * This prevents the use of hardfloat, since it relies on the inexact fl=
ag
> + * being already set and clearing it often may result in slower
> computations.
> + * Those targets could also be listed here.
>   */
> -#if defined(TARGET_PPC) || defined(__FAST_MATH__)
> -# if defined(__FAST_MATH__)
> -#  warning disabling hardfloat due to -ffast-math: hardfloat requires an
> exact \
> +#if defined(__FAST_MATH__)
> +# warning disabling hardfloat due to -ffast-math: hardfloat requires an
> exact \
>      IEEE implementation
> -# endif
>  # define QEMU_NO_HARDFLOAT 1
>  # define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN
>  #else
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index b283042515..5f412f9fba 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1033,6 +1033,7 @@ struct CPUPPCState {
>      float_status vec_status;
>      float_status fp_status; /* Floating point execution context */
>      target_ulong fpscr;     /* Floating point status and control registe=
r
> */
> +    int default_fp_excpt_flags;
>
>      /* Internal devices resources */
>      ppc_tb_t *tb_env;      /* Time base and decrementer */
> @@ -1163,6 +1164,7 @@ struct PowerPCCPU {
>      void *machine_data;
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;
> +    bool hardfloat;  /* use hardfloat (this breaks FPSCR[FI] bit
> emulation) */
>
>      /* Those resources are used only during code translation */
>      /* opcode handlers */
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index ae43b08eb5..bbbd1cb987 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -659,7 +659,7 @@ void helper_float_check_status(CPUPPCState *env)
>
>  void helper_reset_fpstatus(CPUPPCState *env)
>  {
> -    set_float_exception_flags(0, &env->fp_status);
> +    set_float_exception_flags(env->default_fp_excpt_flags,
> &env->fp_status);
>  }
>
>  static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,
> @@ -1823,7 +1823,7 @@ void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,
>                         \
>
>     \
>      for (i =3D 0; i < nels; i++) {
>    \
>          float_status tstat =3D env->fp_status;
>    \
> -        set_float_exception_flags(0, &tstat);
>     \
> +        set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>     \
>          t.fld =3D tp##_##op(xa->fld, xb->fld, &tstat);
>    \
>          env->fp_status.float_exception_flags |=3D
> tstat.float_exception_flags; \
>
>     \
> @@ -1867,7 +1867,7 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t
> opcode,
>          tstat.float_rounding_mode =3D float_round_to_odd;
>      }
>
> -    set_float_exception_flags(0, &tstat);
> +    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>      t.f128 =3D float128_add(xa->f128, xb->f128, &tstat);
>      env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
>
> @@ -1902,7 +1902,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
>                         \
>
>     \
>      for (i =3D 0; i < nels; i++) {
>    \
>          float_status tstat =3D env->fp_status;
>    \
> -        set_float_exception_flags(0, &tstat);
>     \
> +        set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>     \
>          t.fld =3D tp##_mul(xa->fld, xb->fld, &tstat);
>     \
>          env->fp_status.float_exception_flags |=3D
> tstat.float_exception_flags; \
>
>     \
> @@ -1942,7 +1942,7 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t
> opcode,
>          tstat.float_rounding_mode =3D float_round_to_odd;
>      }
>
> -    set_float_exception_flags(0, &tstat);
> +    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>      t.f128 =3D float128_mul(xa->f128, xb->f128, &tstat);
>      env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
>
> @@ -1976,7 +1976,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
>                          \
>
>      \
>      for (i =3D 0; i < nels; i++) {
>     \
>          float_status tstat =3D env->fp_status;
>     \
> -        set_float_exception_flags(0, &tstat);
>      \
> +        set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>      \
>          t.fld =3D tp##_div(xa->fld, xb->fld, &tstat);
>      \
>          env->fp_status.float_exception_flags |=3D
> tstat.float_exception_flags;  \
>
>      \
> @@ -2019,7 +2019,7 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t
> opcode,
>          tstat.float_rounding_mode =3D float_round_to_odd;
>      }
>
> -    set_float_exception_flags(0, &tstat);
> +    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>      t.f128 =3D float128_div(xa->f128, xb->f128, &tstat);
>      env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
>
> @@ -2095,7 +2095,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
> ppc_vsr_t *xb)             \
>
>     \
>      for (i =3D 0; i < nels; i++) {
>    \
>          float_status tstat =3D env->fp_status;
>    \
> -        set_float_exception_flags(0, &tstat);
>     \
> +        set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>     \
>          t.fld =3D tp##_sqrt(xb->fld, &tstat);
>     \
>          env->fp_status.float_exception_flags |=3D
> tstat.float_exception_flags; \
>
>     \
> @@ -2143,7 +2143,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
> ppc_vsr_t *xb)             \
>
>     \
>      for (i =3D 0; i < nels; i++) {
>    \
>          float_status tstat =3D env->fp_status;
>    \
> -        set_float_exception_flags(0, &tstat);
>     \
> +        set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>     \
>          t.fld =3D tp##_sqrt(xb->fld, &tstat);
>     \
>          t.fld =3D tp##_div(tp##_one, t.fld, &tstat);
>    \
>          env->fp_status.float_exception_flags |=3D
> tstat.float_exception_flags; \
> @@ -2305,7 +2305,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,
>                          \
>
>      \
>      for (i =3D 0; i < nels; i++) {
>     \
>          float_status tstat =3D env->fp_status;
>     \
> -        set_float_exception_flags(0, &tstat);
>      \
> +        set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>      \
>          if (r2sp && (tstat.float_rounding_mode =3D=3D
> float_round_nearest_even)) {\
>              /*
>     \
>               * Avoid double rounding errors by rounding the intermediate
>     \
> @@ -2886,7 +2886,7 @@ uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_=
t
> xb)
>      uint64_t result, sign, exp, frac;
>
>      float_status tstat =3D env->fp_status;
> -    set_float_exception_flags(0, &tstat);
> +    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>
>      sign =3D extract64(xb, 63,  1);
>      exp  =3D extract64(xb, 52, 11);
> @@ -2924,7 +2924,7 @@ uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_=
t
> xb)
>  uint64_t helper_xscvspdpn(CPUPPCState *env, uint64_t xb)
>  {
>      float_status tstat =3D env->fp_status;
> -    set_float_exception_flags(0, &tstat);
> +    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>
>      return float32_to_float64(xb >> 32, &tstat);
>  }
> @@ -3327,7 +3327,7 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcod=
e,
>      }
>
>      tstat =3D env->fp_status;
> -    set_float_exception_flags(0, &tstat);
> +    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>      set_float_rounding_mode(rmode, &tstat);
>      t.f128 =3D float128_round_to_int(xb->f128, &tstat);
>      env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
> @@ -3384,7 +3384,7 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t
> opcode,
>      }
>
>      tstat =3D env->fp_status;
> -    set_float_exception_flags(0, &tstat);
> +    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>      set_float_rounding_mode(rmode, &tstat);
>      round_res =3D float128_to_floatx80(xb->f128, &tstat);
>      t.f128 =3D floatx80_to_float128(round_res, &tstat);
> @@ -3415,7 +3415,7 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t
> opcode,
>          tstat.float_rounding_mode =3D float_round_to_odd;
>      }
>
> -    set_float_exception_flags(0, &tstat);
> +    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>      t.f128 =3D float128_sqrt(xb->f128, &tstat);
>      env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
>
> @@ -3449,7 +3449,7 @@ void helper_xssubqp(CPUPPCState *env, uint32_t
> opcode,
>          tstat.float_rounding_mode =3D float_round_to_odd;
>      }
>
> -    set_float_exception_flags(0, &tstat);
> +    set_float_exception_flags(env->default_fp_excpt_flags, &tstat);
>      t.f128 =3D float128_sub(xa->f128, xb->f128, &tstat);
>      env->fp_status.float_exception_flags |=3D tstat.float_exception_flag=
s;
>
> diff --git a/target/ppc/translate_init.inc.c
> b/target/ppc/translate_init.inc.c
> index 53995f62ea..ab1a6db4f1 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10736,6 +10736,8 @@ static void ppc_cpu_reset(CPUState *s)
>      /* tininess for underflow is detected before rounding */
>      set_float_detect_tininess(float_tininess_before_rounding,
>                                &env->fp_status);
> +    /* hardfloat needs inexact flag already set */
> +    env->default_fp_excpt_flags =3D (cpu->hardfloat ? float_flag_inexact=
 :
> 0);
>
>      for (i =3D 0; i < ARRAY_SIZE(env->spr_cb); i++) {
>          ppc_spr_t *spr =3D &env->spr_cb[i];
> @@ -10868,6 +10870,7 @@ static Property ppc_cpu_properties[] =3D {
>                       false),
>      DEFINE_PROP_BOOL("pre-3.0-migration", PowerPCCPU, pre_3_0_migration,
>                       false),
> +    DEFINE_PROP_BOOL("hardfloat", PowerPCCPU, hardfloat, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> --
> 2.21.1
>
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000f8923605a2f0036e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Are this stable now? I&#39;d like to see hard float to be =
landed:)</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Wed, Feb 19, 2020 at 1:19 AM BALATON Zoltan &lt;<a href=3D"mailt=
o:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">While other targets take advantage =
of using host FPU to do floating<br>
point computations, this was disabled for PPC target because always<br>
clearing exception flags before every FP op made it slightly slower<br>
than emulating everyting with softfloat. To emulate some FPSCR bits,<br>
clearing of fp_status may be necessary (unless these could be handled<br>
e.g. using FP exceptions on host but there&#39;s no API for that in QEMU<br=
>
yet) but preserving at least the inexact flag makes hardfloat usable<br>
and faster than softfloat. Since most clients don&#39;t actually care<br>
about this flag, we can gain some speed trading some emulation<br>
accuracy.<br>
<br>
This patch implements a simple way to keep the inexact flag set for<br>
hardfloat while still allowing to revert to softfloat for workloads<br>
that need more accurate albeit slower emulation. (Set hardfloat<br>
property of CPU, i.e. -cpu name,hardfloat=3Dfalse for that.) There may<br>
still be room for further improvement but this seems to increase<br>
floating point performance. Unfortunately the softfloat case is slower<br>
than before this patch so this patch only makes sense if the default<br>
is also set to enable hardfloat.<br>
<br>
Because of the above this patch at the moment is mainly for testing<br>
different workloads to evaluate how viable would this be in practice.<br>
Thus, RFC and not ready for merge yet.<br>
<br>
Signed-off-by: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" tar=
get=3D"_blank">balaton@eik.bme.hu</a>&gt;<br>
---<br>
v2: use different approach to avoid needing if () in<br>
helper_reset_fpstatus() but this does not seem to change overhead<br>
much, also make it a single patch as adding the hardfloat option is<br>
only a few lines; with this we can use same value at other places where<br>
float_status is reset and maybe enable hardfloat for a few more places<br>
for a little more performance but not too much. With this I got:<br>
<br>
lame: 3:13, lame_vmx: 1:55 (this is probably within jitter though and<br>
still far from the results on real hardware) also tried mplayer test<br>
and got results between 144-146s (this test is more VMX bound).<br>
<br>
I&#39;ve also done some profiling for hardfloat=3Dtrue and false cases with=
<br>
this patch to see what are the hot functions. Results are:<br>
<br>
Overhead=C2=A0 Command=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Symbol<br>
-cpu G4,hardfloat=3Dfalse, lame:<br>
=C2=A0 =C2=A09.82%=C2=A0 qemu-system-ppc=C2=A0 [.] round_canonical<br>
=C2=A0 =C2=A08.35%=C2=A0 qemu-system-ppc=C2=A0 [.] soft_f64_muladd<br>
=C2=A0 =C2=A07.16%=C2=A0 qemu-system-ppc=C2=A0 [.] soft_f64_addsub<br>
=C2=A0 =C2=A05.27%=C2=A0 qemu-system-ppc=C2=A0 [.] float32_to_float64<br>
=C2=A0 =C2=A05.20%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_compute_fprf_floa=
t64<br>
=C2=A0 =C2=A04.61%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_frsp<br>
=C2=A0 =C2=A04.59%=C2=A0 qemu-system-ppc=C2=A0 [.] soft_f64_mul<br>
=C2=A0 =C2=A04.01%=C2=A0 qemu-system-ppc=C2=A0 [.] float_to_float.isra.26<b=
r>
=C2=A0 =C2=A03.84%=C2=A0 qemu-system-ppc=C2=A0 [.] float64_classify<br>
=C2=A0 =C2=A02.97%=C2=A0 qemu-system-ppc=C2=A0 [.] do_float_check_status<br=
>
<br>
-cpu G4,hardfloat=3Dfalse, lame_vmx:<br>
Overhead=C2=A0 Command=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Symbol<br>
=C2=A0 10.04%=C2=A0 qemu-system-ppc=C2=A0 [.] float32_muladd<br>
=C2=A0 =C2=A09.49%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_vperm<br>
=C2=A0 =C2=A06.10%=C2=A0 qemu-system-ppc=C2=A0 [.] round_canonical<br>
=C2=A0 =C2=A04.13%=C2=A0 qemu-system-ppc=C2=A0 [.] soft_f64_addsub<br>
=C2=A0 =C2=A03.23%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_frsp<br>
=C2=A0 =C2=A03.13%=C2=A0 qemu-system-ppc=C2=A0 [.] soft_f64_muladd<br>
=C2=A0 =C2=A02.88%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_vmaddfp<br>
=C2=A0 =C2=A02.69%=C2=A0 qemu-system-ppc=C2=A0 [.] float32_add<br>
=C2=A0 =C2=A02.60%=C2=A0 qemu-system-ppc=C2=A0 [.] float32_to_float64<br>
=C2=A0 =C2=A02.52%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_compute_fprf_floa=
t64<br>
<br>
-cpu G4,hardfloat=3Dtrue, lame:<br>
=C2=A0 11.59%=C2=A0 qemu-system-ppc=C2=A0 [.] round_canonical<br>
=C2=A0 =C2=A06.18%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_compute_fprf_floa=
t64<br>
=C2=A0 =C2=A06.01%=C2=A0 qemu-system-ppc=C2=A0 [.] float32_to_float64<br>
=C2=A0 =C2=A04.58%=C2=A0 qemu-system-ppc=C2=A0 [.] float64_classify<br>
=C2=A0 =C2=A03.87%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_frsp<br>
=C2=A0 =C2=A03.75%=C2=A0 qemu-system-ppc=C2=A0 [.] float_to_float.isra.26<b=
r>
=C2=A0 =C2=A03.48%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_todouble<br>
=C2=A0 =C2=A03.31%=C2=A0 qemu-system-ppc=C2=A0 [.] float64_muladd<br>
=C2=A0 =C2=A03.21%=C2=A0 qemu-system-ppc=C2=A0 [.] do_float_check_status<br=
>
=C2=A0 =C2=A03.01%=C2=A0 qemu-system-ppc=C2=A0 [.] float64_mul<br>
<br>
-cpu G4,hardfloat=3Dtrue, lame_vmx:<br>
=C2=A0 =C2=A09.34%=C2=A0 qemu-system-ppc=C2=A0 [.] float32_muladd<br>
=C2=A0 =C2=A08.83%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_vperm<br>
=C2=A0 =C2=A05.41%=C2=A0 qemu-system-ppc=C2=A0 [.] round_canonical<br>
=C2=A0 =C2=A04.51%=C2=A0 qemu-system-ppc=C2=A0 [.] page_collection_lock<br>
=C2=A0 =C2=A03.58%=C2=A0 qemu-system-ppc=C2=A0 [.] page_trylock_add.isra.17=
<br>
=C2=A0 =C2=A02.71%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_vmaddfp<br>
=C2=A0 =C2=A02.53%=C2=A0 qemu-system-ppc=C2=A0 [.] float32_add<br>
=C2=A0 =C2=A02.30%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_compute_fprf_floa=
t64<br>
=C2=A0 =C2=A02.21%=C2=A0 qemu-system-ppc=C2=A0 [.] float32_to_float64<br>
=C2=A0 =C2=A02.06%=C2=A0 qemu-system-ppc=C2=A0 [.] helper_frsp<br>
<br>
round_canonical seems to come up frequently in this with large overhead.<br=
>
<br>
Could those with better test cases or benchmarks give it a test please<br>
on different CPUs to see what else this would break?<br>
<br>
---<br>
fpu/softfloat.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 14 +++++++-------<br>
=C2=A0target/ppc/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 ++<br>
=C2=A0target/ppc/fpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 32 +++++++=
+++++++++----------------<br>
=C2=A0target/ppc/translate_init.inc.c |=C2=A0 3 +++<br>
=C2=A04 files changed, 28 insertions(+), 23 deletions(-)<br>
<br>
diff --git a/fpu/softfloat.c b/fpu/softfloat.c<br>
index 301ce3b537..6d3f4af72a 100644<br>
--- a/fpu/softfloat.c<br>
+++ b/fpu/softfloat.c<br>
@@ -216,15 +216,15 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)<br>
=C2=A0#endif<br>
<br>
=C2=A0/*<br>
- * Some targets clear the FP flags before most FP operations. This prevent=
s<br>
- * the use of hardfloat, since hardfloat relies on the inexact flag being<=
br>
- * already set.<br>
+ * Disable hardfloat for known problem cases.<br>
+ * Additionally, some targets clear the FP flags before most FP operations=
.<br>
+ * This prevents the use of hardfloat, since it relies on the inexact flag=
<br>
+ * being already set and clearing it often may result in slower computatio=
ns.<br>
+ * Those targets could also be listed here.<br>
=C2=A0 */<br>
-#if defined(TARGET_PPC) || defined(__FAST_MATH__)<br>
-# if defined(__FAST_MATH__)<br>
-#=C2=A0 warning disabling hardfloat due to -ffast-math: hardfloat requires=
 an exact \<br>
+#if defined(__FAST_MATH__)<br>
+# warning disabling hardfloat due to -ffast-math: hardfloat requires an ex=
act \<br>
=C2=A0 =C2=A0 =C2=A0IEEE implementation<br>
-# endif<br>
=C2=A0# define QEMU_NO_HARDFLOAT 1<br>
=C2=A0# define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN<br>
=C2=A0#else<br>
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h<br>
index b283042515..5f412f9fba 100644<br>
--- a/target/ppc/cpu.h<br>
+++ b/target/ppc/cpu.h<br>
@@ -1033,6 +1033,7 @@ struct CPUPPCState {<br>
=C2=A0 =C2=A0 =C2=A0float_status vec_status;<br>
=C2=A0 =C2=A0 =C2=A0float_status fp_status; /* Floating point execution con=
text */<br>
=C2=A0 =C2=A0 =C2=A0target_ulong fpscr;=C2=A0 =C2=A0 =C2=A0/* Floating poin=
t status and control register */<br>
+=C2=A0 =C2=A0 int default_fp_excpt_flags;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Internal devices resources */<br>
=C2=A0 =C2=A0 =C2=A0ppc_tb_t *tb_env;=C2=A0 =C2=A0 =C2=A0 /* Time base and =
decrementer */<br>
@@ -1163,6 +1164,7 @@ struct PowerPCCPU {<br>
=C2=A0 =C2=A0 =C2=A0void *machine_data;<br>
=C2=A0 =C2=A0 =C2=A0int32_t node_id; /* NUMA node this CPU belongs to */<br=
>
=C2=A0 =C2=A0 =C2=A0PPCHash64Options *hash64_opts;<br>
+=C2=A0 =C2=A0 bool hardfloat;=C2=A0 /* use hardfloat (this breaks FPSCR[FI=
] bit emulation) */<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Those resources are used only during code translatio=
n */<br>
=C2=A0 =C2=A0 =C2=A0/* opcode handlers */<br>
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c<br>
index ae43b08eb5..bbbd1cb987 100644<br>
--- a/target/ppc/fpu_helper.c<br>
+++ b/target/ppc/fpu_helper.c<br>
@@ -659,7 +659,7 @@ void helper_float_check_status(CPUPPCState *env)<br>
<br>
=C2=A0void helper_reset_fpstatus(CPUPPCState *env)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;env-&gt;fp_status);<br>
+=C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_excpt_flags, &a=
mp;env-&gt;fp_status);<br>
=C2=A0}<br>
<br>
=C2=A0static void float_invalid_op_addsub(CPUPPCState *env, bool set_fpcc,<=
br>
@@ -1823,7 +1823,7 @@ void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_status;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_e=
xcpt_flags, &amp;tstat);=C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t.fld =3D tp##_##op(xa-&gt;fld, xb-&gt;fl=
d, &amp;tstat);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.float_exception_flags |=
=3D tstat.float_exception_flags; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
@@ -1867,7 +1867,7 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tstat.float_rounding_mode =3D float_round=
_to_odd;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);<br>
+=C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_excpt_flags, &a=
mp;tstat);<br>
=C2=A0 =C2=A0 =C2=A0t.f128 =3D float128_add(xa-&gt;f128, xb-&gt;f128, &amp;=
tstat);<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.float_exception_flags |=3D tstat.floa=
t_exception_flags;<br>
<br>
@@ -1902,7 +1902,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_status;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_e=
xcpt_flags, &amp;tstat);=C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t.fld =3D tp##_mul(xa-&gt;fld, xb-&gt;fld=
, &amp;tstat);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.float_exception_flags |=
=3D tstat.float_exception_flags; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
@@ -1942,7 +1942,7 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opcode=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tstat.float_rounding_mode =3D float_round=
_to_odd;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);<br>
+=C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_excpt_flags, &a=
mp;tstat);<br>
=C2=A0 =C2=A0 =C2=A0t.f128 =3D float128_mul(xa-&gt;f128, xb-&gt;f128, &amp;=
tstat);<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.float_exception_flags |=3D tstat.floa=
t_exception_flags;<br>
<br>
@@ -1976,7 +1976,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_status;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_e=
xcpt_flags, &amp;tstat);=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t.fld =3D tp##_div(xa-&gt;fld, xb-&gt;fld=
, &amp;tstat);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.float_exception_flags |=
=3D tstat.float_exception_flags;=C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
@@ -2019,7 +2019,7 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tstat.float_rounding_mode =3D float_round=
_to_odd;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);<br>
+=C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_excpt_flags, &a=
mp;tstat);<br>
=C2=A0 =C2=A0 =C2=A0t.f128 =3D float128_div(xa-&gt;f128, xb-&gt;f128, &amp;=
tstat);<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.float_exception_flags |=3D tstat.floa=
t_exception_flags;<br>
<br>
@@ -2095,7 +2095,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc=
_vsr_t *xb)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_status;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_e=
xcpt_flags, &amp;tstat);=C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t.fld =3D tp##_sqrt(xb-&gt;fld, &amp;tsta=
t);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.float_exception_flags |=
=3D tstat.float_exception_flags; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
@@ -2143,7 +2143,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc=
_vsr_t *xb)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_status;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_e=
xcpt_flags, &amp;tstat);=C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t.fld =3D tp##_sqrt(xb-&gt;fld, &amp;tsta=
t);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t.fld =3D tp##_div(tp##_one, t.fld, &amp;=
tstat);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.float_exception_flags |=
=3D tstat.float_exception_flags; \<br>
@@ -2305,7 +2305,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nels; i++) {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_status;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_e=
xcpt_flags, &amp;tstat);=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r2sp &amp;&amp; (tstat.float_rounding=
_mode =3D=3D float_round_nearest_even)) {\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Avoid double rounding er=
rors by rounding the intermediate=C2=A0 =C2=A0 =C2=A0 \<br>
@@ -2886,7 +2886,7 @@ uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t =
xb)<br>
=C2=A0 =C2=A0 =C2=A0uint64_t result, sign, exp, frac;<br>
<br>
=C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_status;<br>
-=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);<br>
+=C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_excpt_flags, &a=
mp;tstat);<br>
<br>
=C2=A0 =C2=A0 =C2=A0sign =3D extract64(xb, 63,=C2=A0 1);<br>
=C2=A0 =C2=A0 =C2=A0exp=C2=A0 =3D extract64(xb, 52, 11);<br>
@@ -2924,7 +2924,7 @@ uint64_t helper_xscvdpspn(CPUPPCState *env, uint64_t =
xb)<br>
=C2=A0uint64_t helper_xscvspdpn(CPUPPCState *env, uint64_t xb)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0float_status tstat =3D env-&gt;fp_status;<br>
-=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);<br>
+=C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_excpt_flags, &a=
mp;tstat);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return float32_to_float64(xb &gt;&gt; 32, &amp;tstat);<=
br>
=C2=A0}<br>
@@ -3327,7 +3327,7 @@ void helper_xsrqpi(CPUPPCState *env, uint32_t opcode,=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0tstat =3D env-&gt;fp_status;<br>
-=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);<br>
+=C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_excpt_flags, &a=
mp;tstat);<br>
=C2=A0 =C2=A0 =C2=A0set_float_rounding_mode(rmode, &amp;tstat);<br>
=C2=A0 =C2=A0 =C2=A0t.f128 =3D float128_round_to_int(xb-&gt;f128, &amp;tsta=
t);<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.float_exception_flags |=3D tstat.floa=
t_exception_flags;<br>
@@ -3384,7 +3384,7 @@ void helper_xsrqpxp(CPUPPCState *env, uint32_t opcode=
,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0tstat =3D env-&gt;fp_status;<br>
-=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);<br>
+=C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_excpt_flags, &a=
mp;tstat);<br>
=C2=A0 =C2=A0 =C2=A0set_float_rounding_mode(rmode, &amp;tstat);<br>
=C2=A0 =C2=A0 =C2=A0round_res =3D float128_to_floatx80(xb-&gt;f128, &amp;ts=
tat);<br>
=C2=A0 =C2=A0 =C2=A0t.f128 =3D floatx80_to_float128(round_res, &amp;tstat);=
<br>
@@ -3415,7 +3415,7 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcod=
e,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tstat.float_rounding_mode =3D float_round=
_to_odd;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);<br>
+=C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_excpt_flags, &a=
mp;tstat);<br>
=C2=A0 =C2=A0 =C2=A0t.f128 =3D float128_sqrt(xb-&gt;f128, &amp;tstat);<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.float_exception_flags |=3D tstat.floa=
t_exception_flags;<br>
<br>
@@ -3449,7 +3449,7 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opcode=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tstat.float_rounding_mode =3D float_round=
_to_odd;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 set_float_exception_flags(0, &amp;tstat);<br>
+=C2=A0 =C2=A0 set_float_exception_flags(env-&gt;default_fp_excpt_flags, &a=
mp;tstat);<br>
=C2=A0 =C2=A0 =C2=A0t.f128 =3D float128_sub(xa-&gt;f128, xb-&gt;f128, &amp;=
tstat);<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;fp_status.float_exception_flags |=3D tstat.floa=
t_exception_flags;<br>
<br>
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.in=
c.c<br>
index 53995f62ea..ab1a6db4f1 100644<br>
--- a/target/ppc/translate_init.inc.c<br>
+++ b/target/ppc/translate_init.inc.c<br>
@@ -10736,6 +10736,8 @@ static void ppc_cpu_reset(CPUState *s)<br>
=C2=A0 =C2=A0 =C2=A0/* tininess for underflow is detected before rounding *=
/<br>
=C2=A0 =C2=A0 =C2=A0set_float_detect_tininess(float_tininess_before_roundin=
g,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;env-&gt;fp_status);<br>
+=C2=A0 =C2=A0 /* hardfloat needs inexact flag already set */<br>
+=C2=A0 =C2=A0 env-&gt;default_fp_excpt_flags =3D (cpu-&gt;hardfloat ? floa=
t_flag_inexact : 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(env-&gt;spr_cb); i++) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ppc_spr_t *spr =3D &amp;env-&gt;spr_cb[i]=
;<br>
@@ -10868,6 +10870,7 @@ static Property ppc_cpu_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 false),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;pre-3.0-migration&quot;, PowerPC=
CPU, pre_3_0_migration,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 false),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;hardfloat&quot;, PowerPCCPU, hardfloa=
t, true),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
=C2=A0};<br>
<br>
-- <br>
2.21.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000f8923605a2f0036e--

