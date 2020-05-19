Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DBFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12151206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P83spx8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12151206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jazDT-00013Z-9i
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 06:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jazCV-0000Mk-HT
 for qemu-devel@nongnu.org; Tue, 19 May 2020 06:10:19 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jazCU-0006a0-3J
 for qemu-devel@nongnu.org; Tue, 19 May 2020 06:10:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id g14so2055952wme.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 03:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EfVt2QWD9IK8vTDJitPChgPw70PRkgPEhCTdB6CKkEQ=;
 b=P83spx8jw1Ey8CrfXnGRs5KqcHbQWISJr4333Fd+LUYytR1g61qWvQDUzpwiR+nX4u
 dXwlXDMCifTLHhYDLhULY+Z/OJUQ6f49kvoxcdHGXeIhIAbDdmgS1VkwwBf/L39SkVRj
 aZP5CvTyEgI2U03UJjxKcGsCDOgE29padVVZXU5KOFIB3QLRHKWoGAGmaj1Qr+ZgIPPC
 /LMTSNKKqlETd8wJvWClemkV3VDM17dlmQN1zFsOL6TwxF2dkqZ4oP9yu7IfGYcZYVD4
 rgKepV8CHWPDD4pALKBehBga1GFh6ykbYfHAzeVIxqp/BG0l7JQMjdBGe385CJ5Ig0sS
 MWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EfVt2QWD9IK8vTDJitPChgPw70PRkgPEhCTdB6CKkEQ=;
 b=J2v+onfPNOpLEp1IokkakS+Vpiurx2zQUz16Mhj6uEy8Frgmx1R+PDKu/MmoyIFQNQ
 5H9h3TDwAxCJkkjemV6tdATbPJjw7Hf8KUxO7ni0fpj0O0o7Eq+SSKq/8/W7b+Jps2AS
 jAFem8IEBBzNWT7fu+K4H2SlORp3RL4jBfKJ66AndWF2K4HB/GuJYrJRGHf3B9EVKge7
 sFnuYLoEAXU1Wiqhm7zegnetltfSgu267pAIQQzR3BaC54jGM7PzOwYYr9ZrTstsibuT
 uIy4bWVjnMEZnkDdPPshS6KNduLHJbOHMsVtCqQVO/iscFdLncKbUfiiInCwIXKsAAmF
 3chQ==
X-Gm-Message-State: AOAM533NZ+QlYfkXCdfD0qQpu3nb9Rq7JPBsNexe204Z7qwuP1SSZGv1
 QqnRU8JF1YaKjkW4ZaKTcGkMHg==
X-Google-Smtp-Source: ABdhPJwijOvOOIMRSVfj8STUvgn7CRJda9k7t/mc+1L/m5Xzno7XvZk+0E21QTUXCUSS7CnnEzAGYw==
X-Received: by 2002:a7b:caf2:: with SMTP id t18mr4504312wml.35.1589883015924; 
 Tue, 19 May 2020 03:10:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x184sm3308847wmg.38.2020.05.19.03.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 03:10:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AF2391FF7E;
 Tue, 19 May 2020 11:10:13 +0100 (BST)
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-11-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 10/10] softfloat: Return bool from all classification
 predicates
In-reply-to: <20200515190153.6017-11-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 11:10:13 +0100
Message-ID: <87k118i6be.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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

> This includes *_is_any_nan, *_is_neg, *_is_inf, etc.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

As an aside do you think we'll see any benefit from rolling up the
classifications with the decomposed versions? I would hope the compiler
could drop the stuff it doesn't need but I guess we loose the ability to
inline in the target helpers?

> ---
>  include/fpu/softfloat.h        | 66 +++++++++++++++++-----------------
>  fpu/softfloat-specialize.inc.c | 16 ++++-----
>  2 files changed, 41 insertions(+), 41 deletions(-)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 37217d9b9b..16ca697a73 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -235,31 +235,31 @@ float16 float16_sqrt(float16, float_status *status);
>  FloatRelation float16_compare(float16, float16, float_status *status);
>  FloatRelation float16_compare_quiet(float16, float16, float_status *stat=
us);
>=20=20
> -int float16_is_quiet_nan(float16, float_status *status);
> -int float16_is_signaling_nan(float16, float_status *status);
> +bool float16_is_quiet_nan(float16, float_status *status);
> +bool float16_is_signaling_nan(float16, float_status *status);
>  float16 float16_silence_nan(float16, float_status *status);
>=20=20
> -static inline int float16_is_any_nan(float16 a)
> +static inline bool float16_is_any_nan(float16 a)
>  {
>      return ((float16_val(a) & ~0x8000) > 0x7c00);
>  }
>=20=20
> -static inline int float16_is_neg(float16 a)
> +static inline bool float16_is_neg(float16 a)
>  {
>      return float16_val(a) >> 15;
>  }
>=20=20
> -static inline int float16_is_infinity(float16 a)
> +static inline bool float16_is_infinity(float16 a)
>  {
>      return (float16_val(a) & 0x7fff) =3D=3D 0x7c00;
>  }
>=20=20
> -static inline int float16_is_zero(float16 a)
> +static inline bool float16_is_zero(float16 a)
>  {
>      return (float16_val(a) & 0x7fff) =3D=3D 0;
>  }
>=20=20
> -static inline int float16_is_zero_or_denormal(float16 a)
> +static inline bool float16_is_zero_or_denormal(float16 a)
>  {
>      return (float16_val(a) & 0x7c00) =3D=3D 0;
>  }
> @@ -351,8 +351,8 @@ float32 float32_minnum(float32, float32, float_status=
 *status);
>  float32 float32_maxnum(float32, float32, float_status *status);
>  float32 float32_minnummag(float32, float32, float_status *status);
>  float32 float32_maxnummag(float32, float32, float_status *status);
> -int float32_is_quiet_nan(float32, float_status *status);
> -int float32_is_signaling_nan(float32, float_status *status);
> +bool float32_is_quiet_nan(float32, float_status *status);
> +bool float32_is_signaling_nan(float32, float_status *status);
>  float32 float32_silence_nan(float32, float_status *status);
>  float32 float32_scalbn(float32, int, float_status *status);
>=20=20
> @@ -372,27 +372,27 @@ static inline float32 float32_chs(float32 a)
>      return make_float32(float32_val(a) ^ 0x80000000);
>  }
>=20=20
> -static inline int float32_is_infinity(float32 a)
> +static inline bool float32_is_infinity(float32 a)
>  {
>      return (float32_val(a) & 0x7fffffff) =3D=3D 0x7f800000;
>  }
>=20=20
> -static inline int float32_is_neg(float32 a)
> +static inline bool float32_is_neg(float32 a)
>  {
>      return float32_val(a) >> 31;
>  }
>=20=20
> -static inline int float32_is_zero(float32 a)
> +static inline bool float32_is_zero(float32 a)
>  {
>      return (float32_val(a) & 0x7fffffff) =3D=3D 0;
>  }
>=20=20
> -static inline int float32_is_any_nan(float32 a)
> +static inline bool float32_is_any_nan(float32 a)
>  {
>      return ((float32_val(a) & ~(1 << 31)) > 0x7f800000UL);
>  }
>=20=20
> -static inline int float32_is_zero_or_denormal(float32 a)
> +static inline bool float32_is_zero_or_denormal(float32 a)
>  {
>      return (float32_val(a) & 0x7f800000) =3D=3D 0;
>  }
> @@ -540,8 +540,8 @@ float64 float64_minnum(float64, float64, float_status=
 *status);
>  float64 float64_maxnum(float64, float64, float_status *status);
>  float64 float64_minnummag(float64, float64, float_status *status);
>  float64 float64_maxnummag(float64, float64, float_status *status);
> -int float64_is_quiet_nan(float64 a, float_status *status);
> -int float64_is_signaling_nan(float64, float_status *status);
> +bool float64_is_quiet_nan(float64 a, float_status *status);
> +bool float64_is_signaling_nan(float64, float_status *status);
>  float64 float64_silence_nan(float64, float_status *status);
>  float64 float64_scalbn(float64, int, float_status *status);
>=20=20
> @@ -561,27 +561,27 @@ static inline float64 float64_chs(float64 a)
>      return make_float64(float64_val(a) ^ 0x8000000000000000LL);
>  }
>=20=20
> -static inline int float64_is_infinity(float64 a)
> +static inline bool float64_is_infinity(float64 a)
>  {
>      return (float64_val(a) & 0x7fffffffffffffffLL ) =3D=3D 0x7ff00000000=
00000LL;
>  }
>=20=20
> -static inline int float64_is_neg(float64 a)
> +static inline bool float64_is_neg(float64 a)
>  {
>      return float64_val(a) >> 63;
>  }
>=20=20
> -static inline int float64_is_zero(float64 a)
> +static inline bool float64_is_zero(float64 a)
>  {
>      return (float64_val(a) & 0x7fffffffffffffffLL) =3D=3D 0;
>  }
>=20=20
> -static inline int float64_is_any_nan(float64 a)
> +static inline bool float64_is_any_nan(float64 a)
>  {
>      return ((float64_val(a) & ~(1ULL << 63)) > 0x7ff0000000000000ULL);
>  }
>=20=20
> -static inline int float64_is_zero_or_denormal(float64 a)
> +static inline bool float64_is_zero_or_denormal(float64 a)
>  {
>      return (float64_val(a) & 0x7ff0000000000000LL) =3D=3D 0;
>  }
> @@ -708,7 +708,7 @@ static inline floatx80 floatx80_chs(floatx80 a)
>      return a;
>  }
>=20=20
> -static inline int floatx80_is_infinity(floatx80 a)
> +static inline bool floatx80_is_infinity(floatx80 a)
>  {
>  #if defined(TARGET_M68K)
>      return (a.high & 0x7fff) =3D=3D floatx80_infinity.high && !(a.low <<=
 1);
> @@ -718,22 +718,22 @@ static inline int floatx80_is_infinity(floatx80 a)
>  #endif
>  }
>=20=20
> -static inline int floatx80_is_neg(floatx80 a)
> +static inline bool floatx80_is_neg(floatx80 a)
>  {
>      return a.high >> 15;
>  }
>=20=20
> -static inline int floatx80_is_zero(floatx80 a)
> +static inline bool floatx80_is_zero(floatx80 a)
>  {
>      return (a.high & 0x7fff) =3D=3D 0 && a.low =3D=3D 0;
>  }
>=20=20
> -static inline int floatx80_is_zero_or_denormal(floatx80 a)
> +static inline bool floatx80_is_zero_or_denormal(floatx80 a)
>  {
>      return (a.high & 0x7fff) =3D=3D 0;
>  }
>=20=20
> -static inline int floatx80_is_any_nan(floatx80 a)
> +static inline bool floatx80_is_any_nan(floatx80 a)
>  {
>      return ((a.high & 0x7fff) =3D=3D 0x7fff) && (a.low<<1);
>  }
> @@ -936,8 +936,8 @@ float128 float128_rem(float128, float128, float_statu=
s *status);
>  float128 float128_sqrt(float128, float_status *status);
>  FloatRelation float128_compare(float128, float128, float_status *status);
>  FloatRelation float128_compare_quiet(float128, float128, float_status *s=
tatus);
> -int float128_is_quiet_nan(float128, float_status *status);
> -int float128_is_signaling_nan(float128, float_status *status);
> +bool float128_is_quiet_nan(float128, float_status *status);
> +bool float128_is_signaling_nan(float128, float_status *status);
>  float128 float128_silence_nan(float128, float_status *status);
>  float128 float128_scalbn(float128, int, float_status *status);
>=20=20
> @@ -953,22 +953,22 @@ static inline float128 float128_chs(float128 a)
>      return a;
>  }
>=20=20
> -static inline int float128_is_infinity(float128 a)
> +static inline bool float128_is_infinity(float128 a)
>  {
>      return (a.high & 0x7fffffffffffffffLL) =3D=3D 0x7fff000000000000LL &=
& a.low =3D=3D 0;
>  }
>=20=20
> -static inline int float128_is_neg(float128 a)
> +static inline bool float128_is_neg(float128 a)
>  {
>      return a.high >> 63;
>  }
>=20=20
> -static inline int float128_is_zero(float128 a)
> +static inline bool float128_is_zero(float128 a)
>  {
>      return (a.high & 0x7fffffffffffffffLL) =3D=3D 0 && a.low =3D=3D 0;
>  }
>=20=20
> -static inline int float128_is_zero_or_denormal(float128 a)
> +static inline bool float128_is_zero_or_denormal(float128 a)
>  {
>      return (a.high & 0x7fff000000000000LL) =3D=3D 0;
>  }
> @@ -983,7 +983,7 @@ static inline bool float128_is_denormal(float128 a)
>      return float128_is_zero_or_denormal(a) && !float128_is_zero(a);
>  }
>=20=20
> -static inline int float128_is_any_nan(float128 a)
> +static inline bool float128_is_any_nan(float128 a)
>  {
>      return ((a.high >> 48) & 0x7fff) =3D=3D 0x7fff &&
>          ((a.low !=3D 0) || ((a.high & 0xffffffffffffLL) !=3D 0));
> diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.in=
c.c
> index 025ee4f991..44f5b661f8 100644
> --- a/fpu/softfloat-specialize.inc.c
> +++ b/fpu/softfloat-specialize.inc.c
> @@ -245,7 +245,7 @@ typedef struct {
>  | NaN; otherwise returns 0.
>  *-----------------------------------------------------------------------=
-----*/
>=20=20
> -int float16_is_quiet_nan(float16 a_, float_status *status)
> +bool float16_is_quiet_nan(float16 a_, float_status *status)
>  {
>  #ifdef NO_SIGNALING_NANS
>      return float16_is_any_nan(a_);
> @@ -264,7 +264,7 @@ int float16_is_quiet_nan(float16 a_, float_status *st=
atus)
>  | NaN; otherwise returns 0.
>  *-----------------------------------------------------------------------=
-----*/
>=20=20
> -int float16_is_signaling_nan(float16 a_, float_status *status)
> +bool float16_is_signaling_nan(float16 a_, float_status *status)
>  {
>  #ifdef NO_SIGNALING_NANS
>      return 0;
> @@ -283,7 +283,7 @@ int float16_is_signaling_nan(float16 a_, float_status=
 *status)
>  | NaN; otherwise returns 0.
>  *-----------------------------------------------------------------------=
-----*/
>=20=20
> -int float32_is_quiet_nan(float32 a_, float_status *status)
> +bool float32_is_quiet_nan(float32 a_, float_status *status)
>  {
>  #ifdef NO_SIGNALING_NANS
>      return float32_is_any_nan(a_);
> @@ -302,7 +302,7 @@ int float32_is_quiet_nan(float32 a_, float_status *st=
atus)
>  | NaN; otherwise returns 0.
>  *-----------------------------------------------------------------------=
-----*/
>=20=20
> -int float32_is_signaling_nan(float32 a_, float_status *status)
> +bool float32_is_signaling_nan(float32 a_, float_status *status)
>  {
>  #ifdef NO_SIGNALING_NANS
>      return 0;
> @@ -637,7 +637,7 @@ static float32 propagateFloat32NaN(float32 a, float32=
 b, float_status *status)
>  | NaN; otherwise returns 0.
>  *-----------------------------------------------------------------------=
-----*/
>=20=20
> -int float64_is_quiet_nan(float64 a_, float_status *status)
> +bool float64_is_quiet_nan(float64 a_, float_status *status)
>  {
>  #ifdef NO_SIGNALING_NANS
>      return float64_is_any_nan(a_);
> @@ -657,7 +657,7 @@ int float64_is_quiet_nan(float64 a_, float_status *st=
atus)
>  | NaN; otherwise returns 0.
>  *-----------------------------------------------------------------------=
-----*/
>=20=20
> -int float64_is_signaling_nan(float64 a_, float_status *status)
> +bool float64_is_signaling_nan(float64 a_, float_status *status)
>  {
>  #ifdef NO_SIGNALING_NANS
>      return 0;
> @@ -939,7 +939,7 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b,=
 float_status *status)
>  | NaN; otherwise returns 0.
>  *-----------------------------------------------------------------------=
-----*/
>=20=20
> -int float128_is_quiet_nan(float128 a, float_status *status)
> +bool float128_is_quiet_nan(float128 a, float_status *status)
>  {
>  #ifdef NO_SIGNALING_NANS
>      return float128_is_any_nan(a);
> @@ -959,7 +959,7 @@ int float128_is_quiet_nan(float128 a, float_status *s=
tatus)
>  | signaling NaN; otherwise returns 0.
>  *-----------------------------------------------------------------------=
-----*/
>=20=20
> -int float128_is_signaling_nan(float128 a, float_status *status)
> +bool float128_is_signaling_nan(float128 a, float_status *status)
>  {
>  #ifdef NO_SIGNALING_NANS
>      return 0;


--=20
Alex Benn=C3=A9e

