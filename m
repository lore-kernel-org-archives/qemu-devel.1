Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C4AC10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B612084D
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdisuZmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B612084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53344 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFLBB-0006wh-AG
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 12:06:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hFL9x-0006IV-DY
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hFL9v-0000qq-RQ
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:05:41 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hFL9v-0000q8-HD
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:05:39 -0400
Received: by mail-oi1-x243.google.com with SMTP id e5so10496730oii.0
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=12jIJ0JBgWwPqBjxoI4b+PLKZPqO2mR6nHoOJEvqIII=;
	b=AdisuZmKiWOeenGXrv11ngh+lvPvveX19nENggFwwSylkXJeO43wqmtmQ8aOMu8dcG
	5NLbeXbL3zOv8wGOV4dG01gm+6l9NkZ6AqNWNA3+spJc4d7Edyc7NQRqB5e9YifM+YdB
	J7KT8gFXlXeaegsBSFlq0U1rhifp6E1UoqOtBzwIlSnb8N2/EcJGAvZpFPEP4VGSrO9S
	HMtdbCtC9X0gvrW4yrSgdHD3pKN+pQwZPcU46qSHiITMqnXc5t0UC3jirVXsNuvv5img
	CIGgRd/CIkfI+82RjpNC/fDe1vjC0dtp8FZCfnIPgAOXYB6dgR8UQ+fUDCUCGTZeEB4C
	fJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=12jIJ0JBgWwPqBjxoI4b+PLKZPqO2mR6nHoOJEvqIII=;
	b=o0tx6rcxTdRvOICtFFZQ1mOOeT6qcu13RbtRYIVPqfcG5L+Djf709Fc4G703TpIP6F
	9gnci67/mhMcUpdp1THQcC8GVpyAy5usdlz9wGyt+LoX9PURM5xvBWiW5g63pB/LxLEv
	Iw305d7BaRNlWO/g3dNtvJU9msQwu30molRVdyVton20NfQDZNO92CVGMKroeMNtfYAW
	3GfAMAbROGuHWeK7dIjLYapuQzUmyqvTyWX4UhIVfsD6hJoTcZw2Qs5axxypekEY/hcA
	X6nBM71GGEKGvaa+PhSolFT3dMOxgFcmNsFQGXEoJ4QfdgKJ0QQa6h5PEsA+VdcD9WgC
	iB2Q==
X-Gm-Message-State: APjAAAWIb2TOsrgzRnmeIci2p8JZnBvjl20e+GfWHI1OILaSDIm2BBoM
	fw6DBSpsp3jxesfFHu3QoCugMBkm4lW1XBTq6/c=
X-Google-Smtp-Source: APXvYqxr/Fg9OerO+rec99zsfy/dpRHy842H624luf6UOJb7fw8gShtkq092Eh7XsDE1mQk0MxQfVVNWjOuop/2EO7o=
X-Received: by 2002:aca:ed4e:: with SMTP id l75mr13864973oih.62.1555171538728; 
	Sat, 13 Apr 2019 09:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554383690-28338-3-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554383690-28338-3-git-send-email-mateja.marjanovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 13 Apr 2019 18:05:27 +0200
Message-ID:
 <CAL1e-=i8US6_BnsksTFwJq-hrMN5t77ysRhPdsotsRvGch5jiw@mail.gmail.com>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v6 2/4] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
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
Message-ID: <20190413160527.yAUVDV4UUWj1R2uSAy8a5NlNR-zX8LCxUrxSGWbIMWE@z>

On Thu, Apr 4, 2019 at 3:18 PM Mateja Marjanovic
<mateja.marjanovic@rt-rk.com> wrote:
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> Optimize set of MSA instructions ILVEV.<B|H|W|D>, using
> directly tcg registers and performing logic on them
> instead of using helpers.
>
> In the following table, the first column is the performance
> before this patch. The second represents the performance,
> after converting from helpers to tcg, but without using
> tcg_gen_deposit function. The third one is the solution
> which is implemented in this patch.
>
> Performance measurement is done by executing the
> instructions a large number of times on a computer

What is the exact number of times?

> with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> || instr    ||   before    || no-deposit ||  with-deposit ||
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> || ilvev.b  ||  126.92 ms  ||  24.52 ms  ||   24.43 ms    ||
> || ilvev.h  ||   93.67 ms  ||  23.92 ms  ||   23.86 ms    ||
> || ilvev.w  ||  117.86 ms  ||  23.83 ms  ||   22.17 ms    ||
> || ilvev.d  ||   45.49 ms  ||  19.74 ms  ||   19.71 ms    ||
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

"With-deposit" for ilvev.w can't be the same as in the previous
version (22.17 ms), since you eliminated one tcg_gen_andi_i64() in
this version compared to the previous one. "With-deposit" for ilvev.wb
and ilvev.h also can't be the same. It looks you just copy-pasted the
numbers. Please retest the performance and attach the accurate
numbers.

Also, there should be five columns and their meanings should be:

  - instruction
  - before
  - no-deposit-no-mask-as-tcg-constant
  - with-deposit-no-mask-as-tcg-constant
  - with-deposit-with-mask-as-tcg-constant (final)

> No-deposit column and with-deposit column have the
> same statistical values in every row, except ILVEV.W,
> which is the only function which uses the deposit
> function.
>
> No-deposit version of the ILVEV.W implementation:
>
> static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
>                                uint32_t ws, uint32_t wt)
> {
>     TCGv_i64 t1 =3D tcg_temp_new_i64();
>     TCGv_i64 t2 =3D tcg_temp_new_i64();
>     uint64_t mask =3D 0x00000000ffffffffULL;
>
>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2], mask);
>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2], mask);
>     tcg_gen_shli_i64(t2, t2, 32);
>     tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
>
>     tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
>     tcg_gen_andi_i64(t2, msa_wr_d[ws * 2 + 1], mask);
>     tcg_gen_shli_i64(t2, t2, 32);
>     tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
>
>     tcg_temp_free_i64(t1);
>     tcg_temp_free_i64(t2);
> }
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>

You forgot Philippe.

> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/helper.h     |   1 -
>  target/mips/msa_helper.c |   9 -----
>  target/mips/translate.c  | 101 +++++++++++++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 100 insertions(+), 11 deletions(-)
>
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index 02e16c7..82f6a40 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -864,7 +864,6 @@ DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32, =
i32)
>  DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
> -DEF_HELPER_5(msa_ilvev_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_srlr_df, void, env, i32, i32, i32, i32)
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index a7ea6aa..d5c3842 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -1197,15 +1197,6 @@ MSA_FN_DF(ilvl_df)
>      } while (0)
>  MSA_FN_DF(ilvr_df)
>  #undef MSA_DO
> -
> -#define MSA_DO(DF)                      \
> -    do {                                \
> -        pwx->DF[2*i]   =3D pwt->DF[2*i];  \
> -        pwx->DF[2*i+1] =3D pws->DF[2*i];  \
> -    } while (0)
> -MSA_FN_DF(ilvev_df)
> -#undef MSA_DO
> -
>  #undef MSA_LOOP_COND
>
>  #define MSA_LOOP_COND(DF) \
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index df685e4..3057669 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -28973,6 +28973,90 @@ static inline void gen_ilvod_d(CPUMIPSState *env=
, uint32_t wd,
>      tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
>  }
>
> +/*
> + * [MSA] ILVEV.B wd, ws, wt
> + *
> + *   Vector Interleave Even (byte data elements)
> + *
> + */
> +static inline void gen_ilvev_b(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    TCGv_i64 mask =3D tcg_const_i64(0x00ff00ff00ff00ffULL);
> +
> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
> +    tcg_gen_shli_i64(t2, t2, 8);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> +
> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shli_i64(t2, t2, 8);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> +
> +    tcg_temp_free_i64(mask);
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
> +/*
> + * [MSA] ILVEV.H wd, ws, wt
> + *
> + *   Vector Interleave Even (halfword data elements)
> + *
> + */
> +static inline void gen_ilvev_h(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    TCGv_i64 mask =3D tcg_const_i64(0x0000ffff0000ffffULL);
> +
> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2], mask);
> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2], mask);
> +    tcg_gen_shli_i64(t2, t2, 16);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t1, t2);
> +
> +    tcg_gen_and_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_and_i64(t2, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shli_i64(t2, t2, 16);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t1, t2);
> +
> +    tcg_temp_free_i64(mask);
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}

Please apply Philippe's refactoring for the preceding two functions.

> +
> +/*
> + * [MSA] ILVEV.W wd, ws, wt
> + *
> + *   Vector Interleave Even (word data elements)
> + *
> + */
> +static inline void gen_ilvev_w(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2],
> +                        msa_wr_d[ws * 2], 32, 32);
> +    tcg_gen_deposit_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[wt * 2 + 1],
> +                        msa_wr_d[ws * 2 + 1], 32, 32);
> +}
> +
> +/*
> + * [MSA] ILVEV.D wd, ws, wt
> + *
> + *   Vector Interleave Even (Doubleword data elements)

Doubleword -> doubleword

> + *
> + */
> +static inline void gen_ilvev_d(CPUMIPSState *env, uint32_t wd,
> +                               uint32_t ws, uint32_t wt)
> +{
> +    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2]);
> +    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2]);
> +}
> +
>  static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
>  {
>  #define MASK_MSA_3R(op)    (MASK_MSA_MINOR(op) | (op & (0x7 << 23)))
> @@ -29129,7 +29213,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasC=
ontext *ctx)
>          gen_helper_msa_mod_s_df(cpu_env, tdf, twd, tws, twt);
>          break;
>      case OPC_ILVEV_df:
> -        gen_helper_msa_ilvev_df(cpu_env, tdf, twd, tws, twt);
> +        switch (df) {
> +        case DF_BYTE:
> +            gen_ilvev_b(env, wd, ws, wt);
> +            break;
> +        case DF_HALF:
> +            gen_ilvev_h(env, wd, ws, wt);
> +            break;
> +        case DF_WORD:
> +            gen_ilvev_w(env, wd, ws, wt);
> +            break;
> +        case DF_DOUBLE:
> +            gen_ilvev_d(env, wd, ws, wt);
> +            break;
> +        default:
> +            assert(0);
> +        }
>          break;
>      case OPC_BINSR_df:
>          gen_helper_msa_binsr_df(cpu_env, tdf, twd, tws, twt);
> --
> 2.7.4
>
>

Thanks,
Aleksandar

