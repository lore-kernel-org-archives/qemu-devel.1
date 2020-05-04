Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59915C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2361224982
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U19tqfnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2361224982
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVk9G-0006ND-4v
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVk8F-0005nC-MQ; Mon, 04 May 2020 19:04:15 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVk8D-0001A2-DX; Mon, 04 May 2020 19:04:15 -0400
Received: by mail-wr1-x441.google.com with SMTP id s8so431243wrt.9;
 Mon, 04 May 2020 16:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jq5Cguse6z/Xl9XgQbDXkFVx3+1CYI9nRcxJ4YbDGJ0=;
 b=U19tqfnPPTe+6QYY9fuIg9flDxUA9V20tw40MwVkWUKqTXFyASXKZed9x3CVCvtprp
 sCI5GwYFzyJMk8WgSnEqlmkOXt+MJ3p44iclO32tbRle3a55ADEm/Jo5LOcCezMC1ABB
 Yd2bOxxJ/d+mJS3UWnvYo/CV7sTXsVgSs+UBC62vAL/06JsVJmIXMWrqEafzorkTCWcx
 8gaFvnHw1VqdZCnR1rxiHAf4Ymz6PcWNa4+/by416l11pBajkAKtlP+xkWKx1RwPviXj
 5mrkY+lAUhJNcSFLMcRQdiTgKghoNFpO9wVqdSoMWi10nTPeyfCWuHIRrmT5e1wgT+Dq
 WDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jq5Cguse6z/Xl9XgQbDXkFVx3+1CYI9nRcxJ4YbDGJ0=;
 b=hE09uqKpI0xHeIFuHrPJlA7/lSbDZ2zOF3v+Qs6XIhIVTq459lvwecnxU0zIbSNJfr
 kZC+PldkyZya3XiDVmikDFz/ZGrvM5kvwQ4w6uHQPZY/mp4kvzzgAjFdXSa3L/vNNyAc
 JjWlyQgyAJlHzhJKQQJesb8FF1+55m0+xG+ZvR2OzizidGSR3j7PPaxUqy7aPwgLGJ6O
 ibkS3IFVWtf7Ri+Mze9qDu8vfaVEQO1R1W1aTFzCZSlFPpZMPbEIkel308wqepHBdoVB
 +pPPSUDFFmxMKgIGcZcx9bF5zolfASK16esTpux9HcViVoiYz872j9+j7LY1K8JAh7BY
 rnQA==
X-Gm-Message-State: AGi0PuahiTjddKpo5h3DELbi3u2yaqv6gQ4AxDxuS2NLRNXDE48kO1MO
 33ved+Q1Wxo1k01uqsVyoNGfvgX4MNFpm3YYUBw=
X-Google-Smtp-Source: APiQypIXayLXIfQX5yV2tZPG9Yh++Ni2NWEQurcXL9+9D2m7wtbiz65NnwTup3O0pr8dEJh0GrRUo+dDwlt9Xxl+KzA=
X-Received: by 2002:adf:a2d7:: with SMTP id t23mr182911wra.402.1588633449837; 
 Mon, 04 May 2020 16:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200504192954.1387-1-luoyonggang@gmail.com>
In-Reply-To: <20200504192954.1387-1-luoyonggang@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 5 May 2020 01:03:57 +0200
Message-ID: <CAHiYmc6vdZt5J1-65iBrq-OSKHpinMaAPajHue-9-SgpN+6ifg@mail.gmail.com>
Subject: Re: [PATCH] ppc: Use hard-float in ppc fp_hlper as early as possible.
 This would increase the performance better than enable hard-float it
 in
 soft-float.c; Just using fadd fsub fmul fdiv as a simple bench demo. With
 this patch, performance are increased 2x. and 1.3x than the one enable
 hard-float in soft-float.c Both version are not considerate inexact fp
 exception yet.
To: luoyonggang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BE=D0=BD, 4. =D0=BC=D0=B0=D1=98 2020. =D1=83 21:31 <luoyonggang@g=
mail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=
=B0:
>
> From: Yonggang Luo <luoyonggang@gmail.com>
>
> Just post as an idea to improve PPC fp performance.
> With this idea, we have no need to adjust the helper orders.
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  target/ppc/fpu_helper.c | 44 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index 2bd49a2cdf..79051e4540 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -926,6 +926,17 @@ static void float_invalid_op_addsub(CPUPPCState *env=
, bool set_fpcc,
>  /* fadd - fadd. */
>  float64 helper_fadd(CPUPPCState *env, float64 arg1, float64 arg2)
>  {
> +    CPU_DoubleU u1, u2;
> +
> +    u1.d =3D arg1;
> +    u2.d =3D arg2;
> +    CPU_DoubleU retDouble;
> +    retDouble.nd =3D u1.nd + u2.nd;

Besides what Richard mentioned, you neglect here "flush-denormals-to-zero"
property of FPUs. You implicitly assume that the host has the same behavior
as the target (ppc). But that simply may not be the case, leading to the wr=
ong
result.

Yours,
Aleksandar

> +    if (likely(float64_is_zero_or_normal(retDouble.d)))
> +    {
> +        /* TODO: Handling inexact */
> +        return retDouble.d;
> +    }
>      float64 ret =3D float64_add(arg1, arg2, &env->fp_status);
>      int status =3D get_float_exception_flags(&env->fp_status);
>
> @@ -941,6 +952,17 @@ float64 helper_fadd(CPUPPCState *env, float64 arg1, =
float64 arg2)
>  /* fsub - fsub. */
>  float64 helper_fsub(CPUPPCState *env, float64 arg1, float64 arg2)
>  {
> +    CPU_DoubleU u1, u2;
> +
> +    u1.d =3D arg1;
> +    u2.d =3D arg2;
> +    CPU_DoubleU retDouble;
> +    retDouble.nd =3D u1.nd - u2.nd;
> +    if (likely(float64_is_zero_or_normal(retDouble.d)))
> +    {
> +        /* TODO: Handling inexact */
> +        return retDouble.d;
> +    }
>      float64 ret =3D float64_sub(arg1, arg2, &env->fp_status);
>      int status =3D get_float_exception_flags(&env->fp_status);
>
> @@ -967,6 +989,17 @@ static void float_invalid_op_mul(CPUPPCState *env, b=
ool set_fprc,
>  /* fmul - fmul. */
>  float64 helper_fmul(CPUPPCState *env, float64 arg1, float64 arg2)
>  {
> +    CPU_DoubleU u1, u2;
> +
> +    u1.d =3D arg1;
> +    u2.d =3D arg2;
> +    CPU_DoubleU retDouble;
> +    retDouble.nd =3D u1.nd * u2.nd;
> +    if (likely(float64_is_zero_or_normal(retDouble.d)))
> +    {
> +        /* TODO: Handling inexact */
> +        return retDouble.d;
> +    }
>      float64 ret =3D float64_mul(arg1, arg2, &env->fp_status);
>      int status =3D get_float_exception_flags(&env->fp_status);
>
> @@ -997,6 +1030,17 @@ static void float_invalid_op_div(CPUPPCState *env, =
bool set_fprc,
>  /* fdiv - fdiv. */
>  float64 helper_fdiv(CPUPPCState *env, float64 arg1, float64 arg2)
>  {
> +    CPU_DoubleU u1, u2;
> +
> +    u1.d =3D arg1;
> +    u2.d =3D arg2;
> +    CPU_DoubleU retDouble;
> +    retDouble.nd =3D u1.nd / u2.nd;
> +    if (likely(float64_is_zero_or_normal(retDouble.d)))
> +    {
> +        /* TODO: Handling inexact */
> +        return retDouble.d;
> +    }
>      float64 ret =3D float64_div(arg1, arg2, &env->fp_status);
>      int status =3D get_float_exception_flags(&env->fp_status);
>
> --
> 2.23.0.windows.1
>
>

