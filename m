Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36EDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A02206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tSS/nUgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A02206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxy4-0005Z6-1h
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaxvf-0003kS-Hf
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:48:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaxve-0003tF-8M
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:48:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id l18so14915016wrn.6
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LDJWJyYqrmdQ1aWK0zusv+m9ZEQ//2hXslcZw1/YlsI=;
 b=tSS/nUgBY9cV8OHjF0jO6QbGE31gRck4d0njJuAcVSRVTyv/hl9Mrd481f9Zs1H/V1
 QSXAxGbFJusSzcP9AVOBqEw2bPHTRzqaUJQxRFc45V7/IlWoocOyyPfjNCJbvRUc9gBY
 HQCazuyUtOOdXs2Ce1LKuhHel/Bn8kcy5wWw3i8ll33FiPNdh3vImrnLomOEH/G52YmI
 5hHsPa8gZPsAD29n9Wq6DWJoW4lmV16PEbaMT5UzPTnwfAPg6PkFGGTHslvJiyiJ/Uzx
 gcIQZce5tcFZMrYPunYlPungttGU+2vFAexyZ08A5B2xiZgqnP2cQ9Q7NssJtVzlKRT6
 GDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LDJWJyYqrmdQ1aWK0zusv+m9ZEQ//2hXslcZw1/YlsI=;
 b=HhID//qQ6VREPfBIheSvbj07WjZHdDmKD4/AfJAxkmJitXBKTJYl5uhOLcvAAYjl24
 h1fftTrvQKFaZsZ8fAEBY+WRQ8MsmyY9yGYjfIlo7ogUZgkDxQ83DtI1b1Ai7h41Lfou
 vCP9F0wniu8Oqw6M4BZVFrtH6/0ogfHrk26oEZISVCVfsmep/wdH3NmnfCpcEeHlRi6O
 E7UJGQxMeS0Gm8yGDiwtNkqEJ51KFwOWWq9rSrSk0V6WSkqPo59TLLxOQt6qASN17m9V
 HQqyus148EX08A44pulb57j2llF56tyk3l0+6jqEkrCNNiixQVVOqXHI3S3bKDtZXZmo
 vx1A==
X-Gm-Message-State: AOAM530LnmX+98Z++cP5s/QszVsFHJfIcs45fIkqRidvq/+wjxbM/wRZ
 NMLSO2et/lU8R0oziUDVuWePPg==
X-Google-Smtp-Source: ABdhPJygTz7lTFLEgRrmmAoPg8j07eO3XNzKINMvIuHIpMImqPq1IWENyckGX5Ki901XSHm1/Ptpjg==
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr24192330wrm.404.1589878128478; 
 Tue, 19 May 2020 01:48:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x17sm19582669wrp.71.2020.05.19.01.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 01:48:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ACEC61FF7E;
 Tue, 19 May 2020 09:48:45 +0100 (BST)
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-2-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 01/10] softfloat: Use post test for floatN_mul
In-reply-to: <20200515190153.6017-2-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 09:48:45 +0100
Message-ID: <87a724jonm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The existing f{32,64}_addsub_post test, which checks for zero
> inputs, is identical to f{32,64}_mul_fast_test.  Which means
> we can eliminate the fast_test/fast_op hooks in favor of
> reusing the same post hook.
>
> This means we have one fewer test along the fast path for multiply.

I was worried that we were missing an opportunity for the early fast
path but fp-bench disagrees.

Before:
  ./fp-bench -o mul=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
  139.01 MFlops

After:
  ./fp-bench -o mul=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20
  155.28 MFlops

So:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c | 65 +++++++++++--------------------------------------
>  1 file changed, 14 insertions(+), 51 deletions(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index a362bf89ca..5fb4ef75bb 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -339,12 +339,10 @@ static inline bool f64_is_inf(union_float64 a)
>      return float64_is_infinity(a.s);
>  }
>=20=20
> -/* Note: @fast_test and @post can be NULL */
>  static inline float32
>  float32_gen2(float32 xa, float32 xb, float_status *s,
>               hard_f32_op2_fn hard, soft_f32_op2_fn soft,
> -             f32_check_fn pre, f32_check_fn post,
> -             f32_check_fn fast_test, soft_f32_op2_fn fast_op)
> +             f32_check_fn pre, f32_check_fn post)
>  {
>      union_float32 ua, ub, ur;
>=20=20
> @@ -359,17 +357,12 @@ float32_gen2(float32 xa, float32 xb, float_status *=
s,
>      if (unlikely(!pre(ua, ub))) {
>          goto soft;
>      }
> -    if (fast_test && fast_test(ua, ub)) {
> -        return fast_op(ua.s, ub.s, s);
> -    }
>=20=20
>      ur.h =3D hard(ua.h, ub.h);
>      if (unlikely(f32_is_inf(ur))) {
>          s->float_exception_flags |=3D float_flag_overflow;
> -    } else if (unlikely(fabsf(ur.h) <=3D FLT_MIN)) {
> -        if (post =3D=3D NULL || post(ua, ub)) {
> -            goto soft;
> -        }
> +    } else if (unlikely(fabsf(ur.h) <=3D FLT_MIN) && post(ua, ub)) {
> +        goto soft;
>      }
>      return ur.s;
>=20=20
> @@ -380,8 +373,7 @@ float32_gen2(float32 xa, float32 xb, float_status *s,
>  static inline float64
>  float64_gen2(float64 xa, float64 xb, float_status *s,
>               hard_f64_op2_fn hard, soft_f64_op2_fn soft,
> -             f64_check_fn pre, f64_check_fn post,
> -             f64_check_fn fast_test, soft_f64_op2_fn fast_op)
> +             f64_check_fn pre, f64_check_fn post)
>  {
>      union_float64 ua, ub, ur;
>=20=20
> @@ -396,17 +388,12 @@ float64_gen2(float64 xa, float64 xb, float_status *=
s,
>      if (unlikely(!pre(ua, ub))) {
>          goto soft;
>      }
> -    if (fast_test && fast_test(ua, ub)) {
> -        return fast_op(ua.s, ub.s, s);
> -    }
>=20=20
>      ur.h =3D hard(ua.h, ub.h);
>      if (unlikely(f64_is_inf(ur))) {
>          s->float_exception_flags |=3D float_flag_overflow;
> -    } else if (unlikely(fabs(ur.h) <=3D DBL_MIN)) {
> -        if (post =3D=3D NULL || post(ua, ub)) {
> -            goto soft;
> -        }
> +    } else if (unlikely(fabs(ur.h) <=3D DBL_MIN) && post(ua, ub)) {
> +        goto soft;
>      }
>      return ur.s;
>=20=20
> @@ -1115,7 +1102,7 @@ static double hard_f64_sub(double a, double b)
>      return a - b;
>  }
>=20=20
> -static bool f32_addsub_post(union_float32 a, union_float32 b)
> +static bool f32_addsubmul_post(union_float32 a, union_float32 b)
>  {
>      if (QEMU_HARDFLOAT_2F32_USE_FP) {
>          return !(fpclassify(a.h) =3D=3D FP_ZERO && fpclassify(b.h) =3D=
=3D FP_ZERO);
> @@ -1123,7 +1110,7 @@ static bool f32_addsub_post(union_float32 a, union_=
float32 b)
>      return !(float32_is_zero(a.s) && float32_is_zero(b.s));
>  }
>=20=20
> -static bool f64_addsub_post(union_float64 a, union_float64 b)
> +static bool f64_addsubmul_post(union_float64 a, union_float64 b)
>  {
>      if (QEMU_HARDFLOAT_2F64_USE_FP) {
>          return !(fpclassify(a.h) =3D=3D FP_ZERO && fpclassify(b.h) =3D=
=3D FP_ZERO);
> @@ -1136,14 +1123,14 @@ static float32 float32_addsub(float32 a, float32 =
b, float_status *s,
>                                hard_f32_op2_fn hard, soft_f32_op2_fn soft)
>  {
>      return float32_gen2(a, b, s, hard, soft,
> -                        f32_is_zon2, f32_addsub_post, NULL, NULL);
> +                        f32_is_zon2, f32_addsubmul_post);
>  }
>=20=20
>  static float64 float64_addsub(float64 a, float64 b, float_status *s,
>                                hard_f64_op2_fn hard, soft_f64_op2_fn soft)
>  {
>      return float64_gen2(a, b, s, hard, soft,
> -                        f64_is_zon2, f64_addsub_post, NULL, NULL);
> +                        f64_is_zon2, f64_addsubmul_post);
>  }
>=20=20
>  float32 QEMU_FLATTEN
> @@ -1258,42 +1245,18 @@ static double hard_f64_mul(double a, double b)
>      return a * b;
>  }
>=20=20
> -static bool f32_mul_fast_test(union_float32 a, union_float32 b)
> -{
> -    return float32_is_zero(a.s) || float32_is_zero(b.s);
> -}
> -
> -static bool f64_mul_fast_test(union_float64 a, union_float64 b)
> -{
> -    return float64_is_zero(a.s) || float64_is_zero(b.s);
> -}
> -
> -static float32 f32_mul_fast_op(float32 a, float32 b, float_status *s)
> -{
> -    bool signbit =3D float32_is_neg(a) ^ float32_is_neg(b);
> -
> -    return float32_set_sign(float32_zero, signbit);
> -}
> -
> -static float64 f64_mul_fast_op(float64 a, float64 b, float_status *s)
> -{
> -    bool signbit =3D float64_is_neg(a) ^ float64_is_neg(b);
> -
> -    return float64_set_sign(float64_zero, signbit);
> -}
> -
>  float32 QEMU_FLATTEN
>  float32_mul(float32 a, float32 b, float_status *s)
>  {
>      return float32_gen2(a, b, s, hard_f32_mul, soft_f32_mul,
> -                        f32_is_zon2, NULL, f32_mul_fast_test, f32_mul_fa=
st_op);
> +                        f32_is_zon2, f32_addsubmul_post);
>  }
>=20=20
>  float64 QEMU_FLATTEN
>  float64_mul(float64 a, float64 b, float_status *s)
>  {
>      return float64_gen2(a, b, s, hard_f64_mul, soft_f64_mul,
> -                        f64_is_zon2, NULL, f64_mul_fast_test, f64_mul_fa=
st_op);
> +                        f64_is_zon2, f64_addsubmul_post);
>  }
>=20=20
>  /*
> @@ -1834,14 +1797,14 @@ float32 QEMU_FLATTEN
>  float32_div(float32 a, float32 b, float_status *s)
>  {
>      return float32_gen2(a, b, s, hard_f32_div, soft_f32_div,
> -                        f32_div_pre, f32_div_post, NULL, NULL);
> +                        f32_div_pre, f32_div_post);
>  }
>=20=20
>  float64 QEMU_FLATTEN
>  float64_div(float64 a, float64 b, float_status *s)
>  {
>      return float64_gen2(a, b, s, hard_f64_div, soft_f64_div,
> -                        f64_div_pre, f64_div_post, NULL, NULL);
> +                        f64_div_pre, f64_div_post);
>  }
>=20=20
>  /*


--=20
Alex Benn=C3=A9e

