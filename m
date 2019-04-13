Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B95C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A8C2084D
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsNxzI8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A8C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFLAy-0006oz-Gl
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 12:06:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hFL9q-0006Fu-Sn
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hFL9p-0000ma-EZ
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:05:34 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hFL9p-0000m2-0r
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:05:33 -0400
Received: by mail-ot1-x344.google.com with SMTP id m10so11024690otp.2
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=V1zU//57mAmo6gi8ER9zQ0lK1fQaRca3zaROrkSt+uw=;
	b=ZsNxzI8SGLlkDdl0Op1h64KvqUVx/7zO2yT4A/aPVewffe8opejOTckSKoL4w7YbLd
	92q9RHaI3wtqUSTyZxCA62mWqxZXlgPZe5FU7iPB1TqkVh2lol1GSzZ1AkoE6kAxDk5S
	q66goi2pW7GILlIydHlJKzm52xRgrnjyFNDzThJbs9CR4Z5ulepZKuc5rp34QV9h/gYI
	siJYSN50KHqSNl4SJ1bqatmp+Sufg7GbyghPFMsMNxwipJ3H8O6XPY7EKDz39MWy1kd9
	y3rqoKSakGIsrJm10kRimF87hjh4XMa0Pymmda052h5iKCf/gv68P6HEwieW8+N7+Fzd
	oDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=V1zU//57mAmo6gi8ER9zQ0lK1fQaRca3zaROrkSt+uw=;
	b=OSyBjr5451gflG1Wu5bTXnVLysbNSCAD9Lq67gGZJW0Fx5mhwEeicmWgQUXqhAV58K
	+Lj7/nwjEoVPxUJIIYuBt2LYJVNSQiRttUZEbIq6SHSRCDIrHXMRerLGk0XbVWFdVeMu
	kQp2FOFzjdD6lufxmu4JqaY6anqyECT93uiI0UNIdaJCpDuwqLYcFooOIT1jyLeuyTCb
	6ZPuPVlFFrrh8H+IKiYbHezJGxUW8Y/ma9sOAXHGZB7Gn/gTRABbg60qkG1QVJ3v+kej
	1bc36gHhmcCQXi5Mz3OKl71lJoKXHx5BDlxbJSfTxINclgpHQxdBlzCzI5suEBv6UI+k
	91HA==
X-Gm-Message-State: APjAAAW7s8I+n1MAZFpAYPaR42eFCps6UezPJJkiGT8QTiquuDOxA9Uo
	WYYu47S+W+5sXOrCQUIWo/CAHy5/R0TF7/XsgJU=
X-Google-Smtp-Source: APXvYqxhp4Cp9dsnPD6JRZbxkyzhxkOynKmwCopXlRhwTSAKXRt9z3MCvvmU/w0ePLoI61C/hR68pRAcgCcnRAtAk50=
X-Received: by 2002:a05:6830:1418:: with SMTP id
	v24mr24496657otp.273.1555171532092; 
	Sat, 13 Apr 2019 09:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554383690-28338-5-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554383690-28338-5-git-send-email-mateja.marjanovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 13 Apr 2019 18:05:21 +0200
Message-ID:
 <CAL1e-=i3H+aMaOCqMBkK4r9E4Ezqtyqw=VbwNmJZ6Wnc3in5PA@mail.gmail.com>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v6 4/4] target/mips: Optimize
 ILVR.<B|H|W|D> MSA instructions
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413160521.whwuQx9kS7B0hcdwa26gAulXsRKhRjXrAH0kehmG9I4@z>

On Thu, Apr 4, 2019 at 3:16 PM Mateja Marjanovic
<mateja.marjanovic@rt-rk.com> wrote:
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> Optimized ILVR.<B|H|W|D> instructions, using a hybrid

Optimized -> Optimize

> approach. For byte data elements, use a helper with an
> unrolled loop (much better performance), for halfword,

(much better performance) -> (having much better performance
than direct tcg translation)

> word and doubleword data elements use directly tcg
> registers and logic performed on them.
>
> Performance measurement is done by executing the
> instructions a large number of times on a computer
> with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> ||  instr  ||  helper  ||    tcg    ||   hybrid  ||
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> || ilvr.b: || 62.87 ms ||  74.76 ms ||  61.52 ms || <-- helper
> || ilvr.h: || 44.11 ms ||  33.00 ms ||  33.55 ms || <-- tcg
> || ilvr.w: || 34.97 ms ||  23.06 ms ||  22.67 ms || <-- tcg
> || ilvr.d: || 27.33 ms ||  19.87 ms ||  20.02 ms || <-- tcg
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>

instr -> instruction

||  61.52 ms || <-- helper  ->  ||  61.52 ms (helper) ||

and similar for other three raws.

> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/helper.h     |   2 +-
>  target/mips/msa_helper.c |  33 +++++++++++----
>  target/mips/translate.c  | 107 +++++++++++++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 132 insertions(+), 10 deletions(-)
>
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index cd73723..d4755ef 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -862,7 +862,6 @@ DEF_HELPER_5(msa_sld_df, void, env, i32, i32, i32, i3=
2)
>  DEF_HELPER_5(msa_splat_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
> -DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
> @@ -946,6 +945,7 @@ DEF_HELPER_4(msa_insert_w, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_insert_d, void, env, i32, i32, i32)
>
>  DEF_HELPER_4(msa_ilvl_b, void, env, i32, i32, i32)
> +DEF_HELPER_4(msa_ilvr_b, void, env, i32, i32, i32)
>
>  DEF_HELPER_4(msa_fclass_df, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_ftrunc_s_df, void, env, i32, i32, i32)
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index 84bbe6f..2470cef 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -1181,14 +1181,6 @@ MSA_FN_DF(pckev_df)
>      } while (0)
>  MSA_FN_DF(pckod_df)
>  #undef MSA_DO
> -
> -#define MSA_DO(DF)                      \
> -    do {                                \
> -        pwx->DF[2*i]   =3D R##DF(pwt, i); \
> -        pwx->DF[2*i+1] =3D R##DF(pws, i); \
> -    } while (0)
> -MSA_FN_DF(ilvr_df)
> -#undef MSA_DO
>  #undef MSA_LOOP_COND
>
>  #define MSA_LOOP_COND(DF) \
> @@ -1249,6 +1241,31 @@ void helper_msa_ilvl_b(CPUMIPSState *env, uint32_t=
 wd,
>      pwd->b[15] =3D pws->b[15];
>  }
>
> +void helper_msa_ilvr_b(CPUMIPSState *env, uint32_t wd,
> +                       uint32_t ws, uint32_t wt)
> +{
> +    wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
> +    wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
> +    wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
> +

Why do we use here env->active_fpu.fpr[wd].wr, while for other instructions=
 in
this patch, we access msa_wr_d<b|h|w|d[] directly?

> +    pwd->b[15] =3D pws->b[7];
> +    pwd->b[14] =3D pwt->b[7];
> +    pwd->b[13] =3D pws->b[6];
> +    pwd->b[12] =3D pwt->b[6];
> +    pwd->b[11] =3D pws->b[5];
> +    pwd->b[10] =3D pwt->b[5];
> +    pwd->b[9]  =3D pws->b[4];
> +    pwd->b[8]  =3D pwt->b[4];
> +    pwd->b[7]  =3D pws->b[3];
> +    pwd->b[6]  =3D pwt->b[3];
> +    pwd->b[5]  =3D pws->b[2];
> +    pwd->b[4]  =3D pwt->b[2];
> +    pwd->b[3]  =3D pws->b[1];
> +    pwd->b[2]  =3D pwt->b[1];
> +    pwd->b[1]  =3D pws->b[0];
> +    pwd->b[0]  =3D pwt->b[0];
> +}
> +
>  void helper_msa_copy_s_b(CPUMIPSState *env, uint32_t rd,
>                           uint32_t ws, uint32_t n)
>  {
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 6c6811e..90332fb 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -28885,6 +28885,96 @@ static void gen_msa_bit(CPUMIPSState *env, Disas=
Context *ctx)
>  }
>
>  /*
> + * [MSA] ILVR.H wd, ws, wt
> + *
> + *   Vector Interleave Right (halfword data elements)
> + *
> + */
> +static inline void gen_ilvr_h(CPUMIPSState *env, uint32_t wd,
> +                              uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    uint64_t mask =3D 0x000000000000ffffULL;
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_mov_i64(t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
> +    tcg_gen_shli_i64(t1, t1, 16);
> +    tcg_gen_or_i64(t2, t2, t1);
> +
> +    mask <<=3D 16;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_shli_i64(t1, t1, 16);
> +    tcg_gen_or_i64(t2, t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
> +    tcg_gen_shli_i64(t1, t1, 32);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
> +
> +    mask <<=3D 16;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_shri_i64(t1, t1, 32);
> +    tcg_gen_mov_i64(t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
> +    tcg_gen_shri_i64(t1, t1, 16);
> +    tcg_gen_or_i64(t2, t2, t1);
> +
> +    mask <<=3D 16;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_shri_i64(t1, t1, 16);
> +    tcg_gen_or_i64(t2, t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t2, t1);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
> +/*
> + * [MSA] ILVR.W wd, ws, wt
> + *
> + *   Vector Interleave Right (word data elements)
> + *
> + */
> +static inline void gen_ilvr_w(CPUMIPSState *env, uint32_t wd,
> +                              uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    uint64_t mask =3D 0x00000000ffffffffULL;

Use tcg_const_i64(). The same for the previous function.

> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_mov_i64(t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
> +    tcg_gen_shli_i64(t1, t1, 32);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
> +
> +    mask <<=3D 32;

Just assign the constant value to the mask, no need for shift operation.
The same applies for other similar cases in this patch.

> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_shri_i64(t1, t1, 32);
> +    tcg_gen_mov_i64(t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2], mask);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t2, t1);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
> +/*
> + * [MSA] ILVR.D wd, ws, wt
> + *
> + *   Vector Interleave Right (doubleword data elements)
> + *
> + */
> +static inline void gen_ilvr_d(CPUMIPSState *env, uint32_t wd,
> +                              uint32_t ws, uint32_t wt)
> +{
> +    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
> +    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
> +}
> +

This function seems to be identical to the gen_ilvev_d(). Please,
if that is the case, in this patch rename gen_ilvev_d() to gen_ilvev_ilvr_d=
(),
and  use it both for hanlding ILVEV.D and ILVR.D.

> +
> +/*
>   * [MSA] ILVL.B wd, ws, wt
>   *
>   *   Vector Interleave Left (byte data elements)
> @@ -29380,7 +29470,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasC=
ontext *ctx)
>          gen_helper_msa_div_u_df(cpu_env, tdf, twd, tws, twt);
>          break;
>      case OPC_ILVR_df:
> -        gen_helper_msa_ilvr_df(cpu_env, tdf, twd, tws, twt);
> +        switch (df) {
> +        case DF_BYTE:
> +            gen_helper_msa_ilvr_b(cpu_env, twd, tws, twt);
> +            break;
> +        case DF_HALF:
> +            gen_ilvr_h(env, wd, ws, wt);
> +            break;
> +        case DF_WORD:
> +            gen_ilvr_w(env, wd, ws, wt);
> +            break;
> +        case DF_DOUBLE:
> +            gen_ilvr_d(env, wd, ws, wt);
> +            break;
> +        default:
> +            assert(0);
> +        }
>          break;
>      case OPC_BINSL_df:
>          gen_helper_msa_binsl_df(cpu_env, tdf, twd, tws, twt);
> --
> 2.7.4
>
>

Thanks,
Aleksandar

