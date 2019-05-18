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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1605DC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B847820645
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLQJ8E7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B847820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35608 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS1cn-0000M6-S3
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 11:51:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hS1Yq-00062u-N0
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hS1Yn-0001xQ-9m
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:47:47 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hS1Yn-0001x0-3L
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:47:45 -0400
Received: by mail-ot1-x343.google.com with SMTP id g18so9358302otj.11
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=JBCYry9G7+mxhtyVvGVmrlhdYP+r+GY7nokLlnEBCBw=;
	b=fLQJ8E7eNbGWqM4lBYPZI3kp7FsKxV9bJjXHKRivzxhdoPaq6Dm5oxEfE+w/aKuoQt
	+EfKPHtashT6prYkru6oVS4ZRskQ1f1b6DPKhor2m6fyIPwZnqKzuXkUVQDWBMabaA4F
	c1WK6JF5S9iLWtdrJmN4USVHmuKZUJPGNmprCGQtt0Eni6cCAQvb18Q6ASnyEEl6ueHx
	WV7DpMq8lfLGjgSPmzUSBpiEgIl8XVh6aecNYjhHavqkEQ4o0X02Sfeu7SmAU3G8oExz
	WsCqaUvnmA+DnERSXv3wsb0/JDqA62J4Kb3cNkBQGqFl4EuG0yRAWwMdCdV5VQ0sawyw
	8ySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=JBCYry9G7+mxhtyVvGVmrlhdYP+r+GY7nokLlnEBCBw=;
	b=NaVlG02MaBLNnzEKxJQNpWmUXzTheaLY7W49LP/X5sxOLTSJuZo+hE4fzdOxYY9MHc
	xKs2PjZNhso69Fi/lEKUyDZy8mlq+lr5JA+R14wT+l3wY1XrJtUTDzSHfH6zks09KVy6
	r4tphrFEo1FgG0foePli2jeXEtBgKxsvAy7bz5qWoN42fgHeGl+EL5RmpSMjKP4Bzjge
	kTe8dQeNxRD1cQUN4FypeL1xlsmE9BSpynfI6Co7wGYQS4ANarHGDb4XgF1q71yXGBTf
	P9anTA+UTmX2KjrYnGlvPA+9wkZHWTT43RmVFVRjljJ/ebj7PIen/nvktApwSo5hkyjG
	IMPg==
X-Gm-Message-State: APjAAAWfSr87qjbLbEIgVswARHD7+Ko+I4B+y9+VSrjPdkcumwaiGCZU
	BE5xgPz41/Iz8j/C1oVbXXqIugVj/XWuJWgkns+AMA==
X-Google-Smtp-Source: APXvYqxZ4tdjz2IHd+0ilLx1rlH15t1tbXdoJwm7CkMULi1/IOjJC4hfnLCaDwcQf3d74kBBD43zwqIeXrI3B36gNbc=
X-Received: by 2002:a9d:7858:: with SMTP id c24mr363378otm.64.1558194464179;
	Sat, 18 May 2019 08:47:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 18 May 2019 08:47:43
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 18 May 2019 08:47:43
	-0700 (PDT)
In-Reply-To: <1554212605-16457-5-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554212605-16457-5-git-send-email-mateja.marjanovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 18 May 2019 17:47:43 +0200
Message-ID: <CAL1e-=jvhQQQ8XZ5Sv=gpuCh500A5e1JNtFuxkH1cMk910QRkA@mail.gmail.com>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 4/5] target/mips: Refactor and fix
 COPY_U.<B|H|W> instructions
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
> The old version of the helper for the COPY_U.<B|H|W> MSA instructions
> has been replaced with four helpers that don't use switch, and change
> the endianness of the given index, when executed on a big endian host.
>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  target/mips/helper.h     |  4 +++-
>  target/mips/msa_helper.c | 55
+++++++++++++++++++++++++++++++-----------------
>  target/mips/translate.c  | 21 +++++++++++++++++-
>  3 files changed, 59 insertions(+), 21 deletions(-)
>
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index 4e49618..8b6703c 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -875,7 +875,6 @@ DEF_HELPER_5(msa_hsub_u_df, void, env, i32, i32, i32,
i32)
>  DEF_HELPER_5(msa_sldi_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_splati_df, void, env, i32, i32, i32, i32)
>
> -DEF_HELPER_5(msa_copy_u_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_insert_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_insve_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_3(msa_ctcmsa, void, env, tl, i32)
> @@ -940,6 +939,9 @@ DEF_HELPER_4(msa_copy_s_b, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_copy_s_h, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_copy_s_w, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_copy_s_d, void, env, i32, i32, i32)
> +DEF_HELPER_4(msa_copy_u_b, void, env, i32, i32, i32)
> +DEF_HELPER_4(msa_copy_u_h, void, env, i32, i32, i32)
> +DEF_HELPER_4(msa_copy_u_w, void, env, i32, i32, i32)
>
>  DEF_HELPER_4(msa_fclass_df, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_ftrunc_s_df, void, env, i32, i32, i32)
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index 5a06579..d5bf4dc 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -1281,29 +1281,46 @@ void helper_msa_copy_s_d(CPUMIPSState *env,
uint32_t rd,
>      env->active_tc.gpr[rd] = (int64_t)env->active_fpu.fpr[ws].wr.d[n];
>  }
>
> -void helper_msa_copy_u_df(CPUMIPSState *env, uint32_t df, uint32_t rd,
> -                          uint32_t ws, uint32_t n)
> +void helper_msa_copy_u_b(CPUMIPSState *env, uint32_t rd,
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
> +    env->active_tc.gpr[rd] = (uint8_t)env->active_fpu.fpr[ws].wr.b[n];
> +}
>
> -    switch (df) {
> -    case DF_BYTE:
> -        env->active_tc.gpr[rd] =
(uint8_t)env->active_fpu.fpr[ws].wr.b[n];
> -        break;
> -    case DF_HALF:
> -        env->active_tc.gpr[rd] =
(uint16_t)env->active_fpu.fpr[ws].wr.h[n];
> -        break;
> -    case DF_WORD:
> -        env->active_tc.gpr[rd] =
(uint32_t)env->active_fpu.fpr[ws].wr.w[n];
> -        break;
> -#ifdef TARGET_MIPS64
> -    case DF_DOUBLE:
> -        env->active_tc.gpr[rd] =
(uint64_t)env->active_fpu.fpr[ws].wr.d[n];
> -        break;
> +void helper_msa_copy_u_h(CPUMIPSState *env, uint32_t rd,
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
> +    env->active_tc.gpr[rd] = (uint16_t)env->active_fpu.fpr[ws].wr.h[n];
> +}
> +
> +void helper_msa_copy_u_w(CPUMIPSState *env, uint32_t rd,
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
> +    env->active_tc.gpr[rd] = (uint32_t)env->active_fpu.fpr[ws].wr.w[n];
>  }
>
>  void helper_msa_insert_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index f2ea378..72ed0a8 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -29397,6 +29397,11 @@ static void gen_msa_elm_df(CPUMIPSState *env,
DisasContext *ctx, uint32_t df,
>              generate_exception_end(ctx, EXCP_RI);
>              break;
>          }
> +        if ((MASK_MSA_ELM(ctx->opcode) == OPC_COPY_U_df) &&
> +              (df == DF_WORD)) {
> +            generate_exception_end(ctx, EXCP_RI);
> +            break;
> +        }
>  #endif
>          switch (MASK_MSA_ELM(ctx->opcode)) {
>          case OPC_COPY_S_df:
> @@ -29423,7 +29428,21 @@ static void gen_msa_elm_df(CPUMIPSState *env,
DisasContext *ctx, uint32_t df,
>              break;
>          case OPC_COPY_U_df:
>              if (likely(wd != 0)) {
> -                gen_helper_msa_copy_u_df(cpu_env, tdf, twd, tws, tn);
> +                switch (df) {
> +                case DF_BYTE:
> +                    gen_helper_msa_copy_u_b(cpu_env, twd, tws, tn);
> +                    break;
> +                case DF_HALF:
> +                    gen_helper_msa_copy_u_h(cpu_env, twd, tws, tn);
> +                    break;
> +#if defined(TARGET_MIPS64)
> +                case DF_WORD:
> +                    gen_helper_msa_copy_u_w(cpu_env, twd, tws, tn);
> +                    break;
> +#endif
> +                default:
> +                    assert(0);
> +                }
>              }
>              break;
>          case OPC_INSERT_df:
> --
> 2.7.4
>
>
