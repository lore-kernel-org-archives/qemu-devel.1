Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3579C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95705218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS5HazQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95705218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIwB-0002du-Q4
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44444)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent.desnogues@gmail.com>) id 1hjIaI-0005gx-6x
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent.desnogues@gmail.com>) id 1hjIaC-0006BB-Uq
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:24:41 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:45072)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
 id 1hjIa1-00062R-MT; Fri, 05 Jul 2019 03:24:26 -0400
Received: by mail-io1-xd43.google.com with SMTP id g20so7594241ioc.12;
 Fri, 05 Jul 2019 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IjGf5hNWQm08OtryUebrjRhmhxhPnac79iYEIeA7DjI=;
 b=fS5HazQWYSOfktSzBSzz0xEUanj4PkV2VJNWiZCdqzJuZKQrAuNcPU0t/xig5QnzEX
 GxDTBpUkCiyvsQQqtWpuIhmcMVMYTxmXYeVnBl9Fx+j2VRRXPcaBBSpZKv5obBM/aDLk
 kGhWJFYojLjHgHW1NRvs3+Io+fvkhp7MT1VJ6I02RfD+KfAWIcW2bMHNKp4m/OTr3+Lc
 P/rmoZ0pEI8oasK2O2ZVEOlofePsuDhElKfteBpI8gcMS65RKaj3Vams1NdOKYBSLmE1
 +6Mc60QTqzNy40HFC45wi2kzhUMcXtHOKlt5HDCE4eklvXKax+xN2AMxEDncLdlAWsNJ
 ceAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IjGf5hNWQm08OtryUebrjRhmhxhPnac79iYEIeA7DjI=;
 b=fysX7pG29NC6pEwNbp2tdHfqNOi9VyJQGNPMgCvPYWlu0UhvqI9UesK9Oj9t+B5qBi
 Y6oS5+kXr+QgUDIMgEv0ThM2AqiMnXud5TeGmbmtDAtnVdgEKgD+rKqUeBSgD2P+G3/i
 stU2tZUXdHL/m/PR+Cc8oEZ38B00drhZPJb/+BmccPwQAOhXMrA8oV9ZiyZyXhCjRYHi
 GOZ+rF9OxB+JPU0DmkhR7oScckvh6RMEfkGtRNYufoDuUSU9ap916xWOgoOy6T6WcJMu
 Zj7e6O1En1MXm8nT5HdSYMrxBjlt+QBd1WghmEnNuWaKwWTozWkrcrBJrausZ0+I77fz
 pTBg==
X-Gm-Message-State: APjAAAXHjB1anSseRdcRzVA2jOFp27em89+t6rpcYsr2h0b9xOnwqyoF
 umSv1NsZn/3uM3Ifs8ayZV4UfNKC98OgI6qcGvQ=
X-Google-Smtp-Source: APXvYqysjHjvC/NfRRYxwFnieFmUnkUUNJKGVryAJ1oBNo5XJ/56gVhRdDn+3MPjGAz/otF8bdZjRb0Yst45IwaqmMo=
X-Received: by 2002:a5d:97d8:: with SMTP id k24mr2679207ios.84.1562311463293; 
 Fri, 05 Jul 2019 00:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190701163943.22313-1-peter.maydell@linaro.org>
 <20190701163943.22313-42-peter.maydell@linaro.org>
In-Reply-To: <20190701163943.22313-42-peter.maydell@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Fri, 5 Jul 2019 09:24:21 +0200
Message-ID: <CABoDooMcKUS0BuS1z2o_z+cRc0tK5SXyrns=4s8MaZQW7LDtKQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
Subject: Re: [Qemu-devel] [PULL 41/46] target/arm/vfp_helper: Extract
 vfp_set_fpscr_to_host()
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
Cc: philmd@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On Tue, Jul 2, 2019 at 4:18 AM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> The vfp_set_fpscr() helper contains code specific to the host
> floating point implementation (here the SoftFloat library).
> Extract this code to vfp_set_fpscr_to_host().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-id: 20190701132516.26392-16-philmd@redhat.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/vfp_helper.c | 127 +++++++++++++++++++++-------------------
>  1 file changed, 66 insertions(+), 61 deletions(-)
>
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index d54e3253240..b19a395b67d 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -81,71 +81,11 @@ static inline int vfp_exceptbits_to_host(int target_b=
its)
>      return host_bits;
>  }
>
> -uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
> -{
> -    uint32_t i, fpscr;
> -
> -    fpscr =3D env->vfp.xregs[ARM_VFP_FPSCR]
> -            | (env->vfp.vec_len << 16)
> -            | (env->vfp.vec_stride << 20);
> -
> -    i =3D get_float_exception_flags(&env->vfp.fp_status);
> -    i |=3D get_float_exception_flags(&env->vfp.standard_fp_status);
> -    /* FZ16 does not generate an input denormal exception.  */
> -    i |=3D (get_float_exception_flags(&env->vfp.fp_status_f16)
> -          & ~float_flag_input_denormal);
> -    fpscr |=3D vfp_exceptbits_from_host(i);
> -
> -    i =3D env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc=
[3];
> -    fpscr |=3D i ? FPCR_QC : 0;
> -
> -    return fpscr;
> -}
> -
> -uint32_t vfp_get_fpscr(CPUARMState *env)
> -{
> -    return HELPER(vfp_get_fpscr)(env);
> -}
> -
> -void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
> +static void vfp_set_fpscr_to_host(CPUARMState *env, uint32_t val)
>  {
>      int i;
>      uint32_t changed =3D env->vfp.xregs[ARM_VFP_FPSCR];
>
> -    /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
> -    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
> -        val &=3D ~FPCR_FZ16;
> -    }
> -
> -    if (arm_feature(env, ARM_FEATURE_M)) {
> -        /*
> -         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
> -         * and also for the trapped-exception-handling bits IxE.
> -         */
> -        val &=3D 0xf7c0009f;
> -    }
> -
> -    /*
> -     * We don't implement trapped exception handling, so the
> -     * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES=
0!)
> -     *
> -     * If we exclude the exception flags, IOC|DZC|OFC|UFC|IXC|IDC
> -     * (which are stored in fp_status), and the other RES0 bits
> -     * in between, then we clear all of the low 16 bits.
> -     */
> -    env->vfp.xregs[ARM_VFP_FPSCR] =3D val & 0xf7c80000;
> -    env->vfp.vec_len =3D (val >> 16) & 7;
> -    env->vfp.vec_stride =3D (val >> 20) & 3;
> -
> -    /*
> -     * The bit we set within fpscr_q is arbitrary; the register as a
> -     * whole being zero/non-zero is what counts.
> -     */
> -    env->vfp.qc[0] =3D val & FPCR_QC;
> -    env->vfp.qc[1] =3D 0;
> -    env->vfp.qc[2] =3D 0;
> -    env->vfp.qc[3] =3D 0;
> -
>      changed ^=3D val;
>      if (changed & (3 << 22)) {
>          i =3D (val >> 22) & 3;
> @@ -193,6 +133,71 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_=
t val)
>      set_float_exception_flags(0, &env->vfp.standard_fp_status);
>  }
>
> +uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
> +{
> +    uint32_t i, fpscr;
> +
> +    fpscr =3D env->vfp.xregs[ARM_VFP_FPSCR]
> +            | (env->vfp.vec_len << 16)
> +            | (env->vfp.vec_stride << 20);
> +
> +    i =3D get_float_exception_flags(&env->vfp.fp_status);
> +    i |=3D get_float_exception_flags(&env->vfp.standard_fp_status);
> +    /* FZ16 does not generate an input denormal exception.  */
> +    i |=3D (get_float_exception_flags(&env->vfp.fp_status_f16)
> +          & ~float_flag_input_denormal);
> +    fpscr |=3D vfp_exceptbits_from_host(i);
> +
> +    i =3D env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc=
[3];
> +    fpscr |=3D i ? FPCR_QC : 0;
> +
> +    return fpscr;
> +}
> +
> +uint32_t vfp_get_fpscr(CPUARMState *env)
> +{
> +    return HELPER(vfp_get_fpscr)(env);
> +}
> +
> +void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
> +{
> +    /* When ARMv8.2-FP16 is not supported, FZ16 is RES0.  */
> +    if (!cpu_isar_feature(aa64_fp16, env_archcpu(env))) {
> +        val &=3D ~FPCR_FZ16;
> +    }
> +
> +    if (arm_feature(env, ARM_FEATURE_M)) {
> +        /*
> +         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
> +         * and also for the trapped-exception-handling bits IxE.
> +         */
> +        val &=3D 0xf7c0009f;
> +    }
> +
> +    /*
> +     * We don't implement trapped exception handling, so the
> +     * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES=
0!)
> +     *
> +     * If we exclude the exception flags, IOC|DZC|OFC|UFC|IXC|IDC
> +     * (which are stored in fp_status), and the other RES0 bits
> +     * in between, then we clear all of the low 16 bits.
> +     */
> +    env->vfp.xregs[ARM_VFP_FPSCR] =3D val & 0xf7c80000;
> +    env->vfp.vec_len =3D (val >> 16) & 7;
> +    env->vfp.vec_stride =3D (val >> 20) & 3;
> +
> +    /*
> +     * The bit we set within fpscr_q is arbitrary; the register as a
> +     * whole being zero/non-zero is what counts.
> +     */
> +    env->vfp.qc[0] =3D val & FPCR_QC;
> +    env->vfp.qc[1] =3D 0;
> +    env->vfp.qc[2] =3D 0;
> +    env->vfp.qc[3] =3D 0;
> +
> +    vfp_set_fpscr_to_host(env, val);
> +}
> +
>  void vfp_set_fpscr(CPUARMState *env, uint32_t val)
>  {
>      HELPER(vfp_set_fpscr)(env, val);

This patch breaks flag settings because at the point where
vfp_set_fpscr_to_host is called, the value in
env->vfp.xregs[ARM_VFP_FPSCR] has already been changed.

A possible fix to that issue to is to save FPCR value when entering
the helper and passing it to vfp_set_fpscr_to_host.

Thanks,

Laurent

> --
> 2.20.1
>
>

