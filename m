Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831B7C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 05:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333B92082C
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 05:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+zS0cV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333B92082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44150 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSEKe-0003mI-Vd
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 01:26:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSEJu-0003Vm-OJ
	for qemu-devel@nongnu.org; Sun, 19 May 2019 01:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSEJt-0003YC-2F
	for qemu-devel@nongnu.org; Sun, 19 May 2019 01:25:14 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hSEJs-0003WG-Rm
	for qemu-devel@nongnu.org; Sun, 19 May 2019 01:25:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id l25so1848840otp.8
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 22:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=o+f04d6ZyjzIwCUMKAIO/MoYhu3fjifqV+PjDhm24L8=;
	b=g+zS0cV8IEudgzS/iz1GbIzHKsHbmh7DxyK8IXQe7wfywQwo5pfltOiPgB+TsaKth+
	UWekzpYnFgNL4O2qLKRLB6Xgp5Ha2omaiuywJNy7p3pRhxmNbAoDKzZrV0dwncFbVtwD
	8gvMBfnQsM7sqrCwtFwKWDOjeORvETxqG3CkEFp81EYlYsshdQoaN4Fwp48iGw/ReQD+
	dTavCfdT4XHmEUWslbKwWPsNyq26YO27De80WVIt8afBATnEIUXHNv6MN52pIW9bRSg4
	0jejAwK/05CVffHmVGMHy7i7touQNnew/yux8lrwMq3qOioJcfhOZaMaSL49YFkPUMbk
	Gq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=o+f04d6ZyjzIwCUMKAIO/MoYhu3fjifqV+PjDhm24L8=;
	b=YVnrWVPXoKjDDVau4Hebs0iCaaBXZQthYjZGbMALYVjBpyV+0V7vU74Bl1UxfvGa8r
	YiFGzovaxCTflf61jzuNDLWbJkGueddQPOHnAmb4TcEMy7TPs5xiHD5DDkLvdxpg0npG
	YR74JsrWubYuX3VcOpAdOZTncnYNj0GK2p4S+E6gyB3ZyQawK68naC7lHtRVv+qocTQc
	pmyq6WF6LCm0KuS+pQnsNtOpnswKHxiBx/3PtiGE0FLTeyZE378M8FPDZCytc5OtJpMm
	jUsA2OVP4wIsYQOxXrK4xAoJsSNGeMjX+9pNyLdMcd3s+FCfjcRfz21LTgiDa9dh7Pfa
	DC5A==
X-Gm-Message-State: APjAAAVjWUR/pShe6K/42YBgcOwwgAVvU3LgmmTcMwCOoFsE2DC2Iu6Z
	38o9REFJ8xx4CtC5bF4QRz0oyNPwUNeRRNnUruu/lg==
X-Google-Smtp-Source: APXvYqyrYEHpu64n7To7gnuPkPHzMdi0MNIr9J8FWprw1vcTghr8jB7zYWx8oO0LF9A1ANUxmgX5Atp6O+PCsbRYSnc=
X-Received: by 2002:a9d:63c1:: with SMTP id e1mr6901995otl.341.1558243511907; 
	Sat, 18 May 2019 22:25:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 18 May 2019 22:25:11
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 18 May 2019 22:25:11
	-0700 (PDT)
In-Reply-To: <1554212605-16457-6-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1554212605-16457-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554212605-16457-6-git-send-email-mateja.marjanovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 19 May 2019 07:25:11 +0200
Message-ID: <CAL1e-=gRi9fioR4n4pfC-ZuzrgfbNMXobVugyTKZMGvR8TwRfA@mail.gmail.com>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 5/5] target/mips: Refactor and fix
 INSERT.<B|H|W|D> instructions
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

On Apr 2, 2019 3:49 PM, "Mateja Marjanovic" <mateja.marjanovic@rt-rk.com>
wrote:
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> The old version of the helper for the INSERT.<B|H|W|D> MSA instructions
> has been replaced with four helpers that don't use switch, and change
> the endianness of the given index, when executed on a big endian host.
>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

I'll do minor corrections (resulting from this mail thread discussion)
while applying to my pull request.

>  target/mips/helper.h     |  5 +++-
>  target/mips/msa_helper.c | 65
++++++++++++++++++++++++++++++++++++------------
>  target/mips/translate.c  | 19 +++++++++++++-
>  3 files changed, 71 insertions(+), 18 deletions(-)
>
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index 8b6703c..82f6a40 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -875,7 +875,6 @@ DEF_HELPER_5(msa_hsub_u_df, void, env, i32, i32, i32,
i32)
>  DEF_HELPER_5(msa_sldi_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_splati_df, void, env, i32, i32, i32, i32)
>
> -DEF_HELPER_5(msa_insert_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_insve_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_3(msa_ctcmsa, void, env, tl, i32)
>  DEF_HELPER_2(msa_cfcmsa, tl, env, i32)
> @@ -942,6 +941,10 @@ DEF_HELPER_4(msa_copy_s_d, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_copy_u_b, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_copy_u_h, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_copy_u_w, void, env, i32, i32, i32)
> +DEF_HELPER_4(msa_insert_b, void, env, i32, i32, i32)
> +DEF_HELPER_4(msa_insert_h, void, env, i32, i32, i32)
> +DEF_HELPER_4(msa_insert_w, void, env, i32, i32, i32)
> +DEF_HELPER_4(msa_insert_d, void, env, i32, i32, i32)
>
>  DEF_HELPER_4(msa_fclass_df, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_ftrunc_s_df, void, env, i32, i32, i32)
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index d5bf4dc..d5c3842 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -1323,28 +1323,61 @@ void helper_msa_copy_u_w(CPUMIPSState *env,
uint32_t rd,
>      env->active_tc.gpr[rd] = (uint32_t)env->active_fpu.fpr[ws].wr.w[n];
>  }
>
> -void helper_msa_insert_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
> +void helper_msa_insert_b(CPUMIPSState *env, uint32_t wd,
>                            uint32_t rs_num, uint32_t n)
>  {
>      wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
>      target_ulong rs = env->active_tc.gpr[rs_num];
> +    n %= 16;
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    if (n < 8) {
> +        n = 8 - n - 1;
> +    } else {
> +        n = 24 - n - 1;
> +    }
> +#endif
> +    pwd->b[n] = (int8_t)rs;
> +}
>
> -    switch (df) {
> -    case DF_BYTE:
> -        pwd->b[n] = (int8_t)rs;
> -        break;
> -    case DF_HALF:
> -        pwd->h[n] = (int16_t)rs;
> -        break;
> -    case DF_WORD:
> -        pwd->w[n] = (int32_t)rs;
> -        break;
> -    case DF_DOUBLE:
> -        pwd->d[n] = (int64_t)rs;
> -        break;
> -    default:
> -        assert(0);
> +void helper_msa_insert_h(CPUMIPSState *env, uint32_t wd,
> +                          uint32_t rs_num, uint32_t n)
> +{
> +    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
> +    target_ulong rs = env->active_tc.gpr[rs_num];
> +    n %= 8;
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    if (n < 4) {
> +        n = 4 - n - 1;
> +    } else {
> +        n = 12 - n - 1;
> +    }
> +#endif
> +    pwd->h[n] = (int16_t)rs;
> +}
> +
> +void helper_msa_insert_w(CPUMIPSState *env, uint32_t wd,
> +                          uint32_t rs_num, uint32_t n)
> +{
> +    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
> +    target_ulong rs = env->active_tc.gpr[rs_num];
> +    n %= 4;
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    if (n < 2) {
> +        n = 2 - n - 1;
> +    } else {
> +        n = 6 - n - 1;
>      }
> +#endif
> +    pwd->w[n] = (int32_t)rs;
> +}
> +
> +void helper_msa_insert_d(CPUMIPSState *env, uint32_t wd,
> +                          uint32_t rs_num, uint32_t n)
> +{
> +    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
> +    target_ulong rs = env->active_tc.gpr[rs_num];
> +    n %= 2;
> +    pwd->d[n] = (int64_t)rs;
>  }
>
>  void helper_msa_insve_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 72ed0a8..64587c4 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -29446,7 +29446,24 @@ static void gen_msa_elm_df(CPUMIPSState *env,
DisasContext *ctx, uint32_t df,
>              }
>              break;
>          case OPC_INSERT_df:
> -            gen_helper_msa_insert_df(cpu_env, tdf, twd, tws, tn);
> +            switch (df) {
> +            case DF_BYTE:
> +                gen_helper_msa_insert_b(cpu_env, twd, tws, tn);
> +                break;
> +            case DF_HALF:
> +                gen_helper_msa_insert_h(cpu_env, twd, tws, tn);
> +                break;
> +            case DF_WORD:
> +                gen_helper_msa_insert_w(cpu_env, twd, tws, tn);
> +                break;
> +#if defined(TARGET_MIPS64)
> +            case DF_DOUBLE:
> +                gen_helper_msa_insert_d(cpu_env, twd, tws, tn);
> +                break;
> +#endif
> +            default:
> +                assert(0);
> +            }
>              break;
>          }
>          break;
> --
> 2.7.4
>
>
