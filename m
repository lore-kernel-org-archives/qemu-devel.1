Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347F9C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E770420645
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjzaFHLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E770420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35549 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS1aI-0006sQ-8A
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 11:49:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hS1YT-0005lM-HT
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hS1YR-0001ko-Pr
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:47:25 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hS1YR-0001jv-Iz
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:47:23 -0400
Received: by mail-oi1-x241.google.com with SMTP id y124so2925339oiy.3
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=WkwU95LzPiehZ1TlhjVWM9ZXxwSRMu7DD9Hl3ThSfjM=;
	b=cjzaFHLuW6rhYko8kgQchzcRlo+GjOIwH/n91P1hSmCFVIZ42gxrtyjlcSwocaRvMI
	Ow4WRUhYyVpnej6pUP2u1NhOtYSe1S2/AC9gAKRY3mRksSWyxKrUTusB8zf5qEd3Nypo
	ANE32sxZe47u5RbZdryHKRFrwoXwf5MfuzAdAIT2A6vqu/DJtFPKfN9Gsg20ypH3lVmA
	BrFmm5hZ83d/2VxXrtGAgafUGh6Lb0f/ROJSAl9UmIsjVoUxppSLBglI/2D2bw1zrUrF
	dg4XwdaFe5Vud0Vc0awiLKaMiffoab5W4G6xlYo6qVd+rlT/jMqmz2ICr/4M1KvcmGOy
	/HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=WkwU95LzPiehZ1TlhjVWM9ZXxwSRMu7DD9Hl3ThSfjM=;
	b=h6JrQfRQRdkMv19LbKFDSneKw7J087499Z2SE1sFzhAOuoSRClra0gNnYdggXDFK4E
	b22XLB9KgCPKSwCRhrKllmGsLure4ODhOaN5WuUwsP7230rz9s73SAuuGsRldI8kOXBD
	JWjP0ixV7kv5qlT+f24X1vNygFAJ46MhXibzt7e2v1M3+aHAs07eW6auwwvEGUCPzkzY
	KZcf/AoHlIwXrK7FNltILL/kTsyt98hZ5zTG8yTcizQEyTkSQKqMYLV3sXsuo5+Roze6
	E4T73ycDdbxr7lUv6scD9n9nYWeqwDRP0Irhln/QKlMO5oxSgiT4HkugPPc6bllciIBC
	6vmw==
X-Gm-Message-State: APjAAAVsrP2HRGwjHFfOMLg7RkkSEPBg3h8T5MEL4GkT8HafHYjhU4O/
	EQGqcxjOYlXohVK0Gx75WPQnJwjYueITGzhqtpg=
X-Google-Smtp-Source: APXvYqzhwTB5w2Xn85W9YHpvXygaNYiVi8A2XwqJs0XcTzEJuGmmg/W4SKcZTn5gqpx57vtEhx9uABqEqtfKpkinBwM=
X-Received: by 2002:aca:6086:: with SMTP id u128mr1926417oib.79.1558194442011; 
	Sat, 18 May 2019 08:47:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 18 May 2019 08:47:21
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 18 May 2019 08:47:21
	-0700 (PDT)
In-Reply-To: <1554212605-16457-4-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554212605-16457-4-git-send-email-mateja.marjanovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 18 May 2019 17:47:21 +0200
Message-ID: <CAL1e-=hntLN8fp_Su5hJD0ivxe7aAvbeyD1qvqMqq7oDUkwLng@mail.gmail.com>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 3/5] target/mips: Refactor and fix
 COPY_S.<B|H|W|D> instructions
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
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Apr 2, 2019 3:44 PM, "Mateja Marjanovic" <mateja.marjanovic@rt-rk.com>
wrote:
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> The old version of the helper for the COPY_S.<B|H|W|D> MSA instructions
> has been replaced with four helpers that don't use switch, and change
> the endianness of the given index, when executed on a big endian host.
>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  target/mips/helper.h     |  7 +++++-
>  target/mips/msa_helper.c | 62
+++++++++++++++++++++++++++++++++---------------
>  target/mips/translate.c  | 19 ++++++++++++++-
>  3 files changed, 67 insertions(+), 21 deletions(-)
>
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index 2f23b0d..4e49618 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -874,7 +874,7 @@ DEF_HELPER_5(msa_hsub_u_df, void, env, i32, i32, i32,
i32)
>
>  DEF_HELPER_5(msa_sldi_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_splati_df, void, env, i32, i32, i32, i32)
> -DEF_HELPER_5(msa_copy_s_df, void, env, i32, i32, i32, i32)
> +
>  DEF_HELPER_5(msa_copy_u_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_insert_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_insve_df, void, env, i32, i32, i32, i32)
> @@ -936,6 +936,11 @@ DEF_HELPER_4(msa_pcnt_df, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_nloc_df, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_nlzc_df, void, env, i32, i32, i32)
>
> +DEF_HELPER_4(msa_copy_s_b, void, env, i32, i32, i32)
> +DEF_HELPER_4(msa_copy_s_h, void, env, i32, i32, i32)
> +DEF_HELPER_4(msa_copy_s_w, void, env, i32, i32, i32)
> +DEF_HELPER_4(msa_copy_s_d, void, env, i32, i32, i32)
> +
>  DEF_HELPER_4(msa_fclass_df, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_ftrunc_s_df, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_ftrunc_u_df, void, env, i32, i32, i32)
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index a500c59..5a06579 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -1232,29 +1232,53 @@ void helper_msa_splati_df(CPUMIPSState *env,
uint32_t df, uint32_t wd,
>      msa_splat_df(df, pwd, pws, n);
>  }
>
> -void helper_msa_copy_s_df(CPUMIPSState *env, uint32_t df, uint32_t rd,
> -                          uint32_t ws, uint32_t n)
> +void helper_msa_copy_s_b(CPUMIPSState *env, uint32_t rd,
> +                         uint32_t ws, uint32_t n)
>  {
> -    n %= DF_ELEMENTS(df);
> +    n %= 16;
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    if (n < 8) {
> +        n = 8 - n - 1;
> +    } else {
> +        n = 24 - n - 1;
> +    }
> +#endif
> +    env->active_tc.gpr[rd] = (int8_t)env->active_fpu.fpr[ws].wr.b[n];
> +}
>
> -    switch (df) {
> -    case DF_BYTE:
> -        env->active_tc.gpr[rd] = (int8_t)env->active_fpu.fpr[ws].wr.b[n];
> -        break;
> -    case DF_HALF:
> -        env->active_tc.gpr[rd] =
(int16_t)env->active_fpu.fpr[ws].wr.h[n];
> -        break;
> -    case DF_WORD:
> -        env->active_tc.gpr[rd] =
(int32_t)env->active_fpu.fpr[ws].wr.w[n];
> -        break;
> -#ifdef TARGET_MIPS64
> -    case DF_DOUBLE:
> -        env->active_tc.gpr[rd] =
(int64_t)env->active_fpu.fpr[ws].wr.d[n];
> -        break;
> +void helper_msa_copy_s_h(CPUMIPSState *env, uint32_t rd,
> +                         uint32_t ws, uint32_t n)
> +{
> +    n %= 8;
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    if (n < 4) {
> +        n = 4 - n - 1;
> +    } else {
> +        n = 12 - n - 1;
> +    }
>  #endif
> -    default:
> -        assert(0);
> +    env->active_tc.gpr[rd] = (int16_t)env->active_fpu.fpr[ws].wr.h[n];
> +}
> +
> +void helper_msa_copy_s_w(CPUMIPSState *env, uint32_t rd,
> +                         uint32_t ws, uint32_t n)
> +{
> +    n %= 4;
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    if (n < 2) {
> +        n = 2 - n - 1;
> +    } else {
> +        n = 6 - n - 1;
>      }
> +#endif
> +    env->active_tc.gpr[rd] = (int32_t)env->active_fpu.fpr[ws].wr.w[n];
> +}
> +
> +void helper_msa_copy_s_d(CPUMIPSState *env, uint32_t rd,
> +                         uint32_t ws, uint32_t n)
> +{
> +    n %= 2;
> +    env->active_tc.gpr[rd] = (int64_t)env->active_fpu.fpr[ws].wr.d[n];
>  }
>
>  void helper_msa_copy_u_df(CPUMIPSState *env, uint32_t df, uint32_t rd,
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 189bbc4..f2ea378 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -29401,7 +29401,24 @@ static void gen_msa_elm_df(CPUMIPSState *env,
DisasContext *ctx, uint32_t df,
>          switch (MASK_MSA_ELM(ctx->opcode)) {
>          case OPC_COPY_S_df:
>              if (likely(wd != 0)) {
> -                gen_helper_msa_copy_s_df(cpu_env, tdf, twd, tws, tn);
> +                switch (df) {
> +                case DF_BYTE:
> +                    gen_helper_msa_copy_s_b(cpu_env, twd, tws, tn);
> +                    break;
> +                case DF_HALF:
> +                    gen_helper_msa_copy_s_h(cpu_env, twd, tws, tn);
> +                    break;
> +                case DF_WORD:
> +                    gen_helper_msa_copy_s_w(cpu_env, twd, tws, tn);
> +                    break;
> +#if defined(TARGET_MIPS64)
> +                case DF_DOUBLE:
> +                    gen_helper_msa_copy_s_d(cpu_env, twd, tws, tn);
> +                    break;
> +#endif
> +                default:
> +                    assert(0);
> +                }
>              }
>              break;
>          case OPC_COPY_U_df:
> --
> 2.7.4
>
>
