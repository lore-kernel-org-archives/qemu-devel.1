Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8530FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C1020771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNsMPtrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C1020771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5too-0007RV-FK
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 12:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5toE-0006y9-67; Wed, 12 Aug 2020 12:41:02 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:40459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5toB-00045o-A5; Wed, 12 Aug 2020 12:41:01 -0400
Received: by mail-il1-x142.google.com with SMTP id x1so2367571ilp.7;
 Wed, 12 Aug 2020 09:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WNvNPXWPfE9l3sTS7CTrUl9KyStKg4151mJXx5lyPYE=;
 b=HNsMPtrnzMWl1k0qes1OS5/5Dz6Oq00ZF5r25U0tSNr+v7xUjU5fdlRLVOjc+i9Dn8
 HG8oy3D30/2m3WTlSDEk0qB2ciItGR7KsAaTA3ytKqQapzstsFZ0QZdh34RZOjhTwCqH
 r1BhUCfe32kTWYTUM5h1vWFCxrpmLLSwoKgvpF4Xf0vGV8wfCBlQiEXtw6jlvd3/PUxT
 D4aFl3OKaAs70wcswdGubuiOM9e4kfZlqoEZx6kgn2zbCt1QvaOaq6SlgYG0o/FUvosq
 FoJrlSc8TY2hq7TclXL6HoPWDUk26OEPElnfal274Z1jBvESLbJ2aWquqVk7mRW/DSHb
 QzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WNvNPXWPfE9l3sTS7CTrUl9KyStKg4151mJXx5lyPYE=;
 b=fseoJKpogq54ZkVRYHJFbIz2qxTG0nXJ8qch3xF+M/Z26x+gKflUjcJTCinm8YhGlY
 Ck9t2sD9KQT/qF3dyQ+NLP38f7sE9G3E/0U+NksBwC8QTHiah97l6udyz4pJkJ0qm12g
 9uWsiEFJA5++tRaQH3FiChlSZJBW+pYciYPTpT4/FvZ9M8q5T9wLwY9XOVbfLhuzSHr9
 E9OH2USVtsPcIuJo4/Gspf3WX8kapmE1+yLIdryH4hkAg8VvkIDPYxHe6/xNx6fGxZ/v
 KEuXFDlIwAejK37YPo5T4H+wXf3VFlT7jaKLDwbMXpQMFx/TJQqUx+A4TKImK+T1cjXd
 WWcg==
X-Gm-Message-State: AOAM532ndB0drB80nmhfcuYR7LBhP6Iodml8DZvm1FiYb4zHL/B4DCUU
 FF/iHGdKNEU2+qNuWCMaHVL0REmk+m3U9sZwTSI=
X-Google-Smtp-Source: ABdhPJyolds156rpD+dvZp44J0V29bWq9jMHvXf4a6TvhCnYP/Uyk2Jne6WU9PlcAnfE0bald6jZauEzZNTEOLxACRQ=
X-Received: by 2002:a05:6e02:ef3:: with SMTP id
 j19mr512952ilk.227.1597250457293; 
 Wed, 12 Aug 2020 09:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <1596102747-20226-1-git-send-email-chihmin.chao@sifive.com>
 <1596102747-20226-2-git-send-email-chihmin.chao@sifive.com>
In-Reply-To: <1596102747-20226-2-git-send-email-chihmin.chao@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Aug 2020 09:30:31 -0700
Message-ID: <CAKmqyKM8nKVKW6iae7kZ2Ouq6LQ-cvQPo7eSm3PKC_dDOU9QSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] softfloat: target/riscv: implement full set fp16
 comparision
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Kito Cheng <kito.cheng@sifive.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 2:54 AM Chih-Min Chao <chihmin.chao@sifive.com> wro=
te:
>
> From: Kito Cheng <kito.cheng@sifive.com>
>
> Implement them in softfloat and remove local version in riscv
>
> Signed-off-by: Kito Cheng <kito.cheng@sifive.com>
> Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/fpu/softfloat.h      | 41 ++++++++++++++++++++++++++++++++++++++=
+++
>  target/riscv/vector_helper.c | 25 -------------------------
>  2 files changed, 41 insertions(+), 25 deletions(-)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 659218b..573fce9 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -285,6 +285,47 @@ static inline float16 float16_set_sign(float16 a, in=
t sign)
>      return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
>  }
>
> +static inline bool float16_eq(float16 a, float16 b, float_status *s)
> +{
> +    return float16_compare(a, b, s) =3D=3D float_relation_equal;
> +}
> +
> +static inline bool float16_le(float16 a, float16 b, float_status *s)
> +{
> +    return float16_compare(a, b, s) <=3D float_relation_equal;
> +}
> +
> +static inline bool float16_lt(float16 a, float16 b, float_status *s)
> +{
> +    return float16_compare(a, b, s) < float_relation_equal;
> +}
> +
> +static inline bool float16_unordered(float16 a, float16 b, float_status =
*s)
> +{
> +    return float16_compare(a, b, s) =3D=3D float_relation_unordered;
> +}
> +
> +static inline bool float16_eq_quiet(float16 a, float16 b, float_status *=
s)
> +{
> +    return float16_compare_quiet(a, b, s) =3D=3D float_relation_equal;
> +}
> +
> +static inline bool float16_le_quiet(float16 a, float16 b, float_status *=
s)
> +{
> +    return float16_compare_quiet(a, b, s) <=3D float_relation_equal;
> +}
> +
> +static inline bool float16_lt_quiet(float16 a, float16 b, float_status *=
s)
> +{
> +    return float16_compare_quiet(a, b, s) < float_relation_equal;
> +}
> +
> +static inline bool float16_unordered_quiet(float16 a, float16 b,
> +                                           float_status *s)
> +{
> +    return float16_compare_quiet(a, b, s) =3D=3D float_relation_unordere=
d;
> +}
> +
>  #define float16_zero make_float16(0)
>  #define float16_half make_float16(0x3800)
>  #define float16_one make_float16(0x3c00)
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 39f44d1..c68e6c4 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -3955,12 +3955,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, v=
oid *vs2,   \
>      }                                                         \
>  }
>
> -static bool float16_eq_quiet(uint16_t a, uint16_t b, float_status *s)
> -{
> -    FloatRelation compare =3D float16_compare_quiet(a, b, s);
> -    return compare =3D=3D float_relation_equal;
> -}
> -
>  GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h, uint16_t, H2, float16_eq_quiet)
>  GEN_VEXT_CMP_VV_ENV(vmfeq_vv_w, uint32_t, H4, float32_eq_quiet)
>  GEN_VEXT_CMP_VV_ENV(vmfeq_vv_d, uint64_t, H8, float64_eq_quiet)
> @@ -4017,12 +4011,6 @@ GEN_VEXT_CMP_VF(vmfne_vf_h, uint16_t, H2, vmfne16)
>  GEN_VEXT_CMP_VF(vmfne_vf_w, uint32_t, H4, vmfne32)
>  GEN_VEXT_CMP_VF(vmfne_vf_d, uint64_t, H8, vmfne64)
>
> -static bool float16_lt(uint16_t a, uint16_t b, float_status *s)
> -{
> -    FloatRelation compare =3D float16_compare(a, b, s);
> -    return compare =3D=3D float_relation_less;
> -}
> -
>  GEN_VEXT_CMP_VV_ENV(vmflt_vv_h, uint16_t, H2, float16_lt)
>  GEN_VEXT_CMP_VV_ENV(vmflt_vv_w, uint32_t, H4, float32_lt)
>  GEN_VEXT_CMP_VV_ENV(vmflt_vv_d, uint64_t, H8, float64_lt)
> @@ -4030,13 +4018,6 @@ GEN_VEXT_CMP_VF(vmflt_vf_h, uint16_t, H2, float16_=
lt)
>  GEN_VEXT_CMP_VF(vmflt_vf_w, uint32_t, H4, float32_lt)
>  GEN_VEXT_CMP_VF(vmflt_vf_d, uint64_t, H8, float64_lt)
>
> -static bool float16_le(uint16_t a, uint16_t b, float_status *s)
> -{
> -    FloatRelation compare =3D float16_compare(a, b, s);
> -    return compare =3D=3D float_relation_less ||
> -           compare =3D=3D float_relation_equal;
> -}
> -
>  GEN_VEXT_CMP_VV_ENV(vmfle_vv_h, uint16_t, H2, float16_le)
>  GEN_VEXT_CMP_VV_ENV(vmfle_vv_w, uint32_t, H4, float32_le)
>  GEN_VEXT_CMP_VV_ENV(vmfle_vv_d, uint64_t, H8, float64_le)
> @@ -4091,12 +4072,6 @@ GEN_VEXT_CMP_VF(vmfge_vf_h, uint16_t, H2, vmfge16)
>  GEN_VEXT_CMP_VF(vmfge_vf_w, uint32_t, H4, vmfge32)
>  GEN_VEXT_CMP_VF(vmfge_vf_d, uint64_t, H8, vmfge64)
>
> -static bool float16_unordered_quiet(uint16_t a, uint16_t b, float_status=
 *s)
> -{
> -    FloatRelation compare =3D float16_compare_quiet(a, b, s);
> -    return compare =3D=3D float_relation_unordered;
> -}
> -
>  GEN_VEXT_CMP_VV_ENV(vmford_vv_h, uint16_t, H2, !float16_unordered_quiet)
>  GEN_VEXT_CMP_VV_ENV(vmford_vv_w, uint32_t, H4, !float32_unordered_quiet)
>  GEN_VEXT_CMP_VV_ENV(vmford_vv_d, uint64_t, H8, !float64_unordered_quiet)
> --
> 2.7.4
>
>

