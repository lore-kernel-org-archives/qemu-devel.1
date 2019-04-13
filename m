Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7609C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC62208E3
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 16:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiHBpLfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC62208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFLKT-00048V-Ma
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 12:16:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hFLJf-0003hf-2k
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hFLJd-0002cK-CH
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:15:43 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hFLJc-0002bs-Uu
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:15:41 -0400
Received: by mail-ot1-x341.google.com with SMTP id j10so11040575otq.0
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 09:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=CILDkwutwPGc7Fz5gXIlRfL+Bt+lRTfu4bgOc0+XPFw=;
	b=DiHBpLfDZrdP6CZlq7F0cxVcCPkfAawxI09c3JmnXd7EN8WyICos97Z/EO7vWR6+Gg
	4jML2svIt0VYZ1rjTJf1G17H10Areb3pOzwk3octo8ubMG8AHQQ6kjTgbEVJt6N+4X5A
	qqnpxHmi5yVGHC9Q3ej8SM08qottlrr7A7ZgCtsc7ElFK7G/6vq8+lonxpKTM0QpRQy0
	4bVfPCavQhIapeaBwI2niCdsqX/zdVdt17OlcRwT6aXLOfI95W4g2XU0rYOkXJfa6eNd
	88TCDo1YwefPvpA8nzbJfMQ82i5dzhSNgXg15HfH84M1Yo4VMEu8Q8yi3CV/dgEb2/r3
	P1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=CILDkwutwPGc7Fz5gXIlRfL+Bt+lRTfu4bgOc0+XPFw=;
	b=ROUREriaDHy7zWQJHWguNVV9bpJ9Tm6iFHrXghKhDNQOOx+vw1Eg3BVfKQKv9RnyTP
	6KKTlTURz5fdqwBqf8xXjceSSvf6ojJ8BvXczl873zqU68vuLXXaawwaSl6/BC+j2anr
	AdIz+xws9Z7m8XxtXBi0bGuD6hz000wvqfiUxpQctiVinJC2myHOXhmd5jaYQM6ZAv2U
	5sl48YZWK4Ew6NQAICQydccsxCXM54BnR7k65+ORoZChBfeEGTvwGqR/uQo3IxPK0kHV
	8BdpAwt3uVFDa0Ht1evlvYJLCgtqxH10c2Raq2lxImVSny/+81X1EFTpIkZ9wqE0TNsu
	Mb8w==
X-Gm-Message-State: APjAAAXVgXe2pziZ/oz3mNUg3cM7WxQMZWzXwzC4k4BH1QronGHm+F22
	JW3nTXwiuuDjcqw7uR1lNi3h/qNpetoioEgPTvk=
X-Google-Smtp-Source: APXvYqxE1AS1h2CK/NC3cWvaGJX/pChKe9ZhjmKI3N4ZZ2Qvbv20PYrbPkIY+dulYF2WmIJt6fOuqf9DsqhfaHis5pE=
X-Received: by 2002:a05:6830:1342:: with SMTP id
	r2mr42504939otq.105.1555172140055; 
	Sat, 13 Apr 2019 09:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554383690-28338-4-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554383690-28338-4-git-send-email-mateja.marjanovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 13 Apr 2019 18:15:29 +0200
Message-ID:
 <CAL1e-=h4HXc4601oU2ZRfBNSe1yQ_zKDvpMtAmE6zOuzSMxryA@mail.gmail.com>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v6 3/4] target/mips: Optimize
 ILVL.<B|H|W|D> MSA instructions
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
Message-ID: <20190413161529.Zv837AefgjhxebmFFfLelPKbiJdy57nBjoaOEJjKRa8@z>

On Thu, Apr 4, 2019 at 3:16 PM Mateja Marjanovic
<mateja.marjanovic@rt-rk.com> wrote:
>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>
> Optimized ILVL.<B|H|W|D> instructions, using a hybrid
> approach. For byte data elements, use a helper with an
> unrolled loop (much better performance), for halfword,
> word and doubleword data elements use directly tcg
> registers and logic performed on them.
>
> Performance measurement is done by executing the
> instructions a large number of times on a computer
> with Intel Core i7-3770 CPU @ 3.40GHz=C3=978.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> ||  instr  ||  helper  ||   tcg    ||  hybrid   ||
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> || ilvl.b: || 59.91 ms || 74.41 ms ||  59.24 ms || <-- helper
> || ilvl.h: || 41.33 ms || 33.08 ms ||  32.96 ms || <-- tcg
> || ilvl.w: || 30.99 ms || 22.87 ms ||  22.81 ms || <-- tcg
> || ilvl.d: || 26.40 ms || 19.64 ms ||  19.45 ms || <-- tcg
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---
>  target/mips/helper.h     |   3 +-
>  target/mips/msa_helper.c |  33 ++++++---
>  target/mips/translate.c  | 184 +++++++++++++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 210 insertions(+), 10 deletions(-)
>
> diff --git a/target/mips/helper.h b/target/mips/helper.h
> index 82f6a40..cd73723 100644
> --- a/target/mips/helper.h
> +++ b/target/mips/helper.h
> @@ -862,7 +862,6 @@ DEF_HELPER_5(msa_sld_df, void, env, i32, i32, i32, i3=
2)
>  DEF_HELPER_5(msa_splat_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_pckev_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_pckod_df, void, env, i32, i32, i32, i32)
> -DEF_HELPER_5(msa_ilvl_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_ilvr_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_vshf_df, void, env, i32, i32, i32, i32)
>  DEF_HELPER_5(msa_srar_df, void, env, i32, i32, i32, i32)
> @@ -946,6 +945,8 @@ DEF_HELPER_4(msa_insert_h, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_insert_w, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_insert_d, void, env, i32, i32, i32)
>
> +DEF_HELPER_4(msa_ilvl_b, void, env, i32, i32, i32)
> +
>  DEF_HELPER_4(msa_fclass_df, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_ftrunc_s_df, void, env, i32, i32, i32)
>  DEF_HELPER_4(msa_ftrunc_u_df, void, env, i32, i32, i32)
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index d5c3842..84bbe6f 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -1184,14 +1184,6 @@ MSA_FN_DF(pckod_df)
>
>  #define MSA_DO(DF)                      \
>      do {                                \
> -        pwx->DF[2*i]   =3D L##DF(pwt, i); \
> -        pwx->DF[2*i+1] =3D L##DF(pws, i); \
> -    } while (0)
> -MSA_FN_DF(ilvl_df)
> -#undef MSA_DO
> -
> -#define MSA_DO(DF)                      \
> -    do {                                \
>          pwx->DF[2*i]   =3D R##DF(pwt, i); \
>          pwx->DF[2*i+1] =3D R##DF(pws, i); \
>      } while (0)
> @@ -1232,6 +1224,31 @@ void helper_msa_splati_df(CPUMIPSState *env, uint3=
2_t df, uint32_t wd,
>      msa_splat_df(df, pwd, pws, n);
>  }
>
> +void helper_msa_ilvl_b(CPUMIPSState *env, uint32_t wd,
> +                       uint32_t ws, uint32_t wt)
> +{
> +    wr_t *pwd =3D &(env->active_fpu.fpr[wd].wr);
> +    wr_t *pws =3D &(env->active_fpu.fpr[ws].wr);
> +    wr_t *pwt =3D &(env->active_fpu.fpr[wt].wr);
> +
> +    pwd->b[0]  =3D pwt->b[8];
> +    pwd->b[1]  =3D pws->b[8];
> +    pwd->b[2]  =3D pwt->b[9];
> +    pwd->b[3]  =3D pws->b[9];
> +    pwd->b[4]  =3D pwt->b[10];
> +    pwd->b[5]  =3D pws->b[10];
> +    pwd->b[6]  =3D pwt->b[11];
> +    pwd->b[7]  =3D pws->b[11];
> +    pwd->b[8]  =3D pwt->b[12];
> +    pwd->b[9]  =3D pws->b[12];
> +    pwd->b[10] =3D pwt->b[13];
> +    pwd->b[11] =3D pws->b[13];
> +    pwd->b[12] =3D pwt->b[14];
> +    pwd->b[13] =3D pws->b[14];
> +    pwd->b[14] =3D pwt->b[15];
> +    pwd->b[15] =3D pws->b[15];
> +}
> +
>  void helper_msa_copy_s_b(CPUMIPSState *env, uint32_t rd,
>                           uint32_t ws, uint32_t n)
>  {
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 3057669..6c6811e 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -28885,6 +28885,173 @@ static void gen_msa_bit(CPUMIPSState *env, Disa=
sContext *ctx)
>  }
>
>  /*
> + * [MSA] ILVL.B wd, ws, wt
> + *
> + *   Vector Interleave Left (byte data elements)
> + *
> + */
> +static inline void gen_ilvl_b(CPUMIPSState *env, uint32_t wd,
> +                              uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    uint64_t mask =3D 0x00000000000000ffULL;
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_mov_i64(t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shli_i64(t1, t1, 8);
> +    tcg_gen_or_i64(t2, t2, t1);
> +
> +    mask <<=3D 8;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_shli_i64(t1, t1, 8);
> +    tcg_gen_or_i64(t2, t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shli_i64(t1, t1, 16);
> +    tcg_gen_or_i64(t2, t2, t1);
> +
> +    mask <<=3D 8;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_shli_i64(t1, t1, 16);
> +    tcg_gen_or_i64(t2, t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shli_i64(t1, t1, 24);
> +    tcg_gen_or_i64(t2, t2, t1);
> +
> +    mask <<=3D 8;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_shli_i64(t1, t1, 24);
> +    tcg_gen_or_i64(t2, t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shli_i64(t1, t1, 32);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
> +
> +    mask <<=3D 8;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_shri_i64(t1, t1, 32);
> +    tcg_gen_mov_i64(t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shri_i64(t1, t1, 24);
> +    tcg_gen_or_i64(t2, t2, t1);
> +
> +    mask <<=3D 8;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_shri_i64(t1, t1, 24);
> +    tcg_gen_or_i64(t2, t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shri_i64(t1, t1, 16);
> +    tcg_gen_or_i64(t2, t2, t1);
> +
> +    mask <<=3D 8;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_shri_i64(t1, t1, 16);
> +    tcg_gen_or_i64(t2, t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shri_i64(t1, t1, 8);
> +    tcg_gen_or_i64(t2, t2, t1);
> +
> +    mask <<=3D 8;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_shri_i64(t1, t1, 8);
> +    tcg_gen_or_i64(t2, t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t2, t1);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
> +/*
> + * [MSA] ILVL.H wd, ws, wt
> + *
> + *   Vector Interleave Left (halfword data elements)
> + *
> + */
> +static inline void gen_ilvl_h(CPUMIPSState *env, uint32_t wd,
> +                              uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    uint64_t mask =3D 0x000000000000ffffULL;
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_mov_i64(t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shli_i64(t1, t1, 16);
> +    tcg_gen_or_i64(t2, t2, t1);
> +
> +    mask <<=3D 16;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_shli_i64(t1, t1, 16);
> +    tcg_gen_or_i64(t2, t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shli_i64(t1, t1, 32);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
> +
> +    mask <<=3D 16;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_shri_i64(t1, t1, 32);
> +    tcg_gen_mov_i64(t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shri_i64(t1, t1, 16);
> +    tcg_gen_or_i64(t2, t2, t1);
> +
> +    mask <<=3D 16;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_shri_i64(t1, t1, 16);
> +    tcg_gen_or_i64(t2, t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t2, t1);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
> +/*
> + * [MSA] ILVL.W wd, ws, wt
> + *
> + *   Vector Interleave Left (word data elements)
> + *
> + */
> +static inline void gen_ilvl_w(CPUMIPSState *env, uint32_t wd,
> +                              uint32_t ws, uint32_t wt)
> +{
> +    TCGv_i64 t1 =3D tcg_temp_new_i64();
> +    TCGv_i64 t2 =3D tcg_temp_new_i64();
> +    uint64_t mask =3D 0x00000000ffffffffULL;
> +
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_mov_i64(t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_shli_i64(t1, t1, 32);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2], t2, t1);
> +
> +    mask <<=3D 32;
> +    tcg_gen_andi_i64(t1, msa_wr_d[wt * 2 + 1], mask);
> +    tcg_gen_shri_i64(t1, t1, 32);
> +    tcg_gen_mov_i64(t2, t1);
> +    tcg_gen_andi_i64(t1, msa_wr_d[ws * 2 + 1], mask);
> +    tcg_gen_or_i64(msa_wr_d[wd * 2 + 1], t2, t1);
> +
> +    tcg_temp_free_i64(t1);
> +    tcg_temp_free_i64(t2);
> +}
> +
> +/*
> + * [MSA] ILVL.D wd, ws, wt
> + *
> + *   Vector Interleave Left (doubleword data elements)
> + *
> + */
> +static inline void gen_ilvl_d(CPUMIPSState *env, uint32_t wd,
> +                              uint32_t ws, uint32_t wt)
> +{
> +    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
> +    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2 + 1]);

This code introduces the bug for the case wd =3D=3D wt. You keep repeating =
the same
mistake on and on and on.

Please see also my comments for ILVR.D.

Thanks,
Aleksandar

> +}
> +
> +/*
>   * [MSA] ILVOD.B wd, ws, wt
>   *
>   *   Vector Interleave Odd (byte data elements)
> @@ -29177,7 +29344,22 @@ static void gen_msa_3r(CPUMIPSState *env, DisasC=
ontext *ctx)
>          gen_helper_msa_div_s_df(cpu_env, tdf, twd, tws, twt);
>          break;
>      case OPC_ILVL_df:
> -        gen_helper_msa_ilvl_df(cpu_env, tdf, twd, tws, twt);
> +        switch (df) {
> +        case DF_BYTE:
> +            gen_helper_msa_ilvl_b(cpu_env, twd, tws, twt);
> +            break;
> +        case DF_HALF:
> +            gen_ilvl_h(env, wd, ws, wt);
> +            break;
> +        case DF_WORD:
> +            gen_ilvl_w(env, wd, ws, wt);
> +            break;
> +        case DF_DOUBLE:
> +            gen_ilvl_d(env, wd, ws, wt);
> +            break;
> +        default:
> +            assert(0);
> +        }
>          break;
>      case OPC_BNEG_df:
>          gen_helper_msa_bneg_df(cpu_env, tdf, twd, tws, twt);
> --
> 2.7.4
>
>

