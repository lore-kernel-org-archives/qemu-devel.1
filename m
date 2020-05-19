Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B78C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB51207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="epeSXeZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB51207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaylj-0002p7-SR
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 05:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaykg-0001g2-Fi
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:41:34 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaykf-0000F3-1n
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:41:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id u188so2728923wmu.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vylq3kQb6EETwi9eygzeyw6Z65b5rUot/ttRtg+7tTU=;
 b=epeSXeZFVc0mCn3mAbbdPT0cerSWcDkjSZw0GU/6iBmTIRK6Noyvs57hDeZmgz4ZOr
 eg6oG2f5eT8qVc7uOMSlq0UMYHrq0XRr5Tz5t8r4O3yanHAiBwp8I6gd9MSo0U/JjkYI
 Fgi14qZm9fTJYRbGHLQREpEz0V6qDtCxnTPy/YNCsO3mWjcxBUTX1sCawcQ97Hzg9tCI
 Kdd37mPpcCn6srtuU6vL9WYSzBNCwIgtEVbhlJtVQuJBQnRYgT7iQ6mAOHeZBU4klE12
 Or9lVelFCx6oWdOqLQnt8i0bMS61Nn4B4k8P0wjqWVJrEgIGEdYIr2ZtZD7YzogI1t6U
 5iKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vylq3kQb6EETwi9eygzeyw6Z65b5rUot/ttRtg+7tTU=;
 b=Yw8id03ZOMim450ITeoWLXb4Udztz8S7z/MxXOpjnFDEeNW6T89vNgkMRtf4iGcwuE
 11ds/RS/6sRFKVq99dtKJFWo1mEEzB0u3I3V7xO76ehBQOBBr+7HE2msjQoRhKSy7LCJ
 V45Q8NlCHybRMf8rPeRa1WFVRmy7fP+hWXUIz050j/3SLbvW5I0fFsgaX0A+s750iqvn
 MAuDqKvYQ6lA8gUPuBpohkKA+U+ZkFshr1XY3TVx4ylh1c8GLxhMpFq5KQ32UzNmVma9
 dY7rBDofVJ8sihqOXvjp9BZmt+Sp+v23l2NYyBJsNpehINon/gxRhDnEboPX578+Ib62
 EHmw==
X-Gm-Message-State: AOAM533MWmrPXRGku0zqwEohhK9EEG9Mqh6oiuFBsUTedCg+zxtKROir
 0/Xzskdyljs7J+bg1lIiRsPOYv16YVI=
X-Google-Smtp-Source: ABdhPJx3Sos4X7i61pLbcqftJAioNWM/+pojqSXLGXjloUzCnhbKUqUwEdYv0+0EmYPKsISqYrmKdw==
X-Received: by 2002:a1c:7212:: with SMTP id n18mr4756368wmc.129.1589881291442; 
 Tue, 19 May 2020 02:41:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 88sm19517193wrq.77.2020.05.19.02.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 02:41:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B42981FF7E;
 Tue, 19 May 2020 10:41:29 +0100 (BST)
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-9-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 08/10] softfloat: Inline float128 compare specializations
In-reply-to: <20200515190153.6017-9-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 10:41:29 +0100
Message-ID: <87pnb0i7na.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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

> Replace the float128 compare specializations with inline functions
> that call the standard float128_compare{,_quiet} functions.
> Use bool as the return type.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/fpu/softfloat.h |  49 +++++++--
>  fpu/softfloat.c         | 238 ----------------------------------------
>  2 files changed, 41 insertions(+), 246 deletions(-)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 281f0fd971..cfb3cda46b 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -901,14 +901,6 @@ float128 float128_mul(float128, float128, float_stat=
us *status);
>  float128 float128_div(float128, float128, float_status *status);
>  float128 float128_rem(float128, float128, float_status *status);
>  float128 float128_sqrt(float128, float_status *status);
> -int float128_eq(float128, float128, float_status *status);
> -int float128_le(float128, float128, float_status *status);
> -int float128_lt(float128, float128, float_status *status);
> -int float128_unordered(float128, float128, float_status *status);
> -int float128_eq_quiet(float128, float128, float_status *status);
> -int float128_le_quiet(float128, float128, float_status *status);
> -int float128_lt_quiet(float128, float128, float_status *status);
> -int float128_unordered_quiet(float128, float128, float_status *status);
>  FloatRelation float128_compare(float128, float128, float_status *status);
>  FloatRelation float128_compare_quiet(float128, float128, float_status *s=
tatus);
>  int float128_is_quiet_nan(float128, float_status *status);
> @@ -964,6 +956,47 @@ static inline int float128_is_any_nan(float128 a)
>          ((a.low !=3D 0) || ((a.high & 0xffffffffffffLL) !=3D 0));
>  }
>=20=20
> +static inline bool float128_eq(float128 a, float128 b, float_status *s)
> +{
> +    return float128_compare(a, b, s) =3D=3D float_relation_equal;
> +}
> +
> +static inline bool float128_le(float128 a, float128 b, float_status *s)
> +{
> +    return float128_compare(a, b, s) <=3D float_relation_equal;
> +}
> +
> +static inline bool float128_lt(float128 a, float128 b, float_status *s)
> +{
> +    return float128_compare(a, b, s) < float_relation_equal;
> +}
> +
> +static inline bool float128_unordered(float128 a, float128 b, float_stat=
us *s)
> +{
> +    return float128_compare(a, b, s) =3D=3D float_relation_unordered;
> +}
> +
> +static inline bool float128_eq_quiet(float128 a, float128 b, float_statu=
s *s)
> +{
> +    return float128_compare_quiet(a, b, s) =3D=3D float_relation_equal;
> +}
> +
> +static inline bool float128_le_quiet(float128 a, float128 b, float_statu=
s *s)
> +{
> +    return float128_compare_quiet(a, b, s) <=3D float_relation_equal;
> +}
> +
> +static inline bool float128_lt_quiet(float128 a, float128 b, float_statu=
s *s)
> +{
> +    return float128_compare_quiet(a, b, s) < float_relation_equal;
> +}
> +
> +static inline bool float128_unordered_quiet(float128 a, float128 b,
> +                                           float_status *s)
> +{
> +    return float128_compare_quiet(a, b, s) =3D=3D float_relation_unorder=
ed;
> +}
> +
>  #define float128_zero make_float128(0, 0)
>=20=20
>  /*----------------------------------------------------------------------=
------
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 5d7fc2c17a..4567dda112 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -7218,244 +7218,6 @@ float128 float128_sqrt(float128 a, float_status *=
status)
>=20=20
>  }
>=20=20
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the quadruple-precision floating-point value `a' is equal=
 to
> -| the corresponding value `b', and 0 otherwise.  The invalid exception is
> -| raised if either operand is a NaN.  Otherwise, the comparison is perfo=
rmed
> -| according to the IEC/IEEE Standard for Binary Floating-Point Arithmeti=
c.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float128_eq(float128 a, float128 b, float_status *status)
> -{
> -
> -    if (    (    ( extractFloat128Exp( a ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a )=
 ) )
> -         || (    ( extractFloat128Exp( b ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b )=
 ) )
> -       ) {
> -        float_raise(float_flag_invalid, status);
> -        return 0;
> -    }
> -    return
> -           ( a.low =3D=3D b.low )
> -        && (    ( a.high =3D=3D b.high )
> -             || (    ( a.low =3D=3D 0 )
> -                  && ( (uint64_t) ( ( a.high | b.high )<<1 ) =3D=3D 0 ) )
> -           );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the quadruple-precision floating-point value `a' is less =
than
> -| or equal to the corresponding value `b', and 0 otherwise.  The invalid
> -| exception is raised if either operand is a NaN.  The comparison is per=
formed
> -| according to the IEC/IEEE Standard for Binary Floating-Point Arithmeti=
c.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float128_le(float128 a, float128 b, float_status *status)
> -{
> -    bool aSign, bSign;
> -
> -    if (    (    ( extractFloat128Exp( a ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a )=
 ) )
> -         || (    ( extractFloat128Exp( b ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b )=
 ) )
> -       ) {
> -        float_raise(float_flag_invalid, status);
> -        return 0;
> -    }
> -    aSign =3D extractFloat128Sign( a );
> -    bSign =3D extractFloat128Sign( b );
> -    if ( aSign !=3D bSign ) {
> -        return
> -               aSign
> -            || (    ( ( (uint64_t) ( ( a.high | b.high )<<1 ) ) | a.low =
| b.low )
> -                 =3D=3D 0 );
> -    }
> -    return
> -          aSign ? le128( b.high, b.low, a.high, a.low )
> -        : le128( a.high, a.low, b.high, b.low );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the quadruple-precision floating-point value `a' is less =
than
> -| the corresponding value `b', and 0 otherwise.  The invalid exception is
> -| raised if either operand is a NaN.  The comparison is performed accord=
ing
> -| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float128_lt(float128 a, float128 b, float_status *status)
> -{
> -    bool aSign, bSign;
> -
> -    if (    (    ( extractFloat128Exp( a ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a )=
 ) )
> -         || (    ( extractFloat128Exp( b ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b )=
 ) )
> -       ) {
> -        float_raise(float_flag_invalid, status);
> -        return 0;
> -    }
> -    aSign =3D extractFloat128Sign( a );
> -    bSign =3D extractFloat128Sign( b );
> -    if ( aSign !=3D bSign ) {
> -        return
> -               aSign
> -            && (    ( ( (uint64_t) ( ( a.high | b.high )<<1 ) ) | a.low =
| b.low )
> -                 !=3D 0 );
> -    }
> -    return
> -          aSign ? lt128( b.high, b.low, a.high, a.low )
> -        : lt128( a.high, a.low, b.high, b.low );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the quadruple-precision floating-point values `a' and `b'=
 cannot
> -| be compared, and 0 otherwise.  The invalid exception is raised if eith=
er
> -| operand is a NaN. The comparison is performed according to the IEC/IEEE
> -| Standard for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float128_unordered(float128 a, float128 b, float_status *status)
> -{
> -    if (    (    ( extractFloat128Exp( a ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a )=
 ) )
> -         || (    ( extractFloat128Exp( b ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b )=
 ) )
> -       ) {
> -        float_raise(float_flag_invalid, status);
> -        return 1;
> -    }
> -    return 0;
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the quadruple-precision floating-point value `a' is equal=
 to
> -| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause=
 an
> -| exception.  The comparison is performed according to the IEC/IEEE Stan=
dard
> -| for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float128_eq_quiet(float128 a, float128 b, float_status *status)
> -{
> -
> -    if (    (    ( extractFloat128Exp( a ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a )=
 ) )
> -         || (    ( extractFloat128Exp( b ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b )=
 ) )
> -       ) {
> -        if (float128_is_signaling_nan(a, status)
> -         || float128_is_signaling_nan(b, status)) {
> -            float_raise(float_flag_invalid, status);
> -        }
> -        return 0;
> -    }
> -    return
> -           ( a.low =3D=3D b.low )
> -        && (    ( a.high =3D=3D b.high )
> -             || (    ( a.low =3D=3D 0 )
> -                  && ( (uint64_t) ( ( a.high | b.high )<<1 ) =3D=3D 0 ) )
> -           );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the quadruple-precision floating-point value `a' is less =
than
> -| or equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs =
do not
> -| cause an exception.  Otherwise, the comparison is performed according =
to the
> -| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float128_le_quiet(float128 a, float128 b, float_status *status)
> -{
> -    bool aSign, bSign;
> -
> -    if (    (    ( extractFloat128Exp( a ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a )=
 ) )
> -         || (    ( extractFloat128Exp( b ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b )=
 ) )
> -       ) {
> -        if (float128_is_signaling_nan(a, status)
> -         || float128_is_signaling_nan(b, status)) {
> -            float_raise(float_flag_invalid, status);
> -        }
> -        return 0;
> -    }
> -    aSign =3D extractFloat128Sign( a );
> -    bSign =3D extractFloat128Sign( b );
> -    if ( aSign !=3D bSign ) {
> -        return
> -               aSign
> -            || (    ( ( (uint64_t) ( ( a.high | b.high )<<1 ) ) | a.low =
| b.low )
> -                 =3D=3D 0 );
> -    }
> -    return
> -          aSign ? le128( b.high, b.low, a.high, a.low )
> -        : le128( a.high, a.low, b.high, b.low );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the quadruple-precision floating-point value `a' is less =
than
> -| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause=
 an
> -| exception.  Otherwise, the comparison is performed according to the IE=
C/IEEE
> -| Standard for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float128_lt_quiet(float128 a, float128 b, float_status *status)
> -{
> -    bool aSign, bSign;
> -
> -    if (    (    ( extractFloat128Exp( a ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a )=
 ) )
> -         || (    ( extractFloat128Exp( b ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b )=
 ) )
> -       ) {
> -        if (float128_is_signaling_nan(a, status)
> -         || float128_is_signaling_nan(b, status)) {
> -            float_raise(float_flag_invalid, status);
> -        }
> -        return 0;
> -    }
> -    aSign =3D extractFloat128Sign( a );
> -    bSign =3D extractFloat128Sign( b );
> -    if ( aSign !=3D bSign ) {
> -        return
> -               aSign
> -            && (    ( ( (uint64_t) ( ( a.high | b.high )<<1 ) ) | a.low =
| b.low )
> -                 !=3D 0 );
> -    }
> -    return
> -          aSign ? lt128( b.high, b.low, a.high, a.low )
> -        : lt128( a.high, a.low, b.high, b.low );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the quadruple-precision floating-point values `a' and `b'=
 cannot
> -| be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.  =
The
> -| comparison is performed according to the IEC/IEEE Standard for Binary
> -| Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float128_unordered_quiet(float128 a, float128 b, float_status *statu=
s)
> -{
> -    if (    (    ( extractFloat128Exp( a ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a )=
 ) )
> -         || (    ( extractFloat128Exp( b ) =3D=3D 0x7FFF )
> -              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b )=
 ) )
> -       ) {
> -        if (float128_is_signaling_nan(a, status)
> -         || float128_is_signaling_nan(b, status)) {
> -            float_raise(float_flag_invalid, status);
> -        }
> -        return 1;
> -    }
> -    return 0;
> -}
> -
>  static inline FloatRelation
>  floatx80_compare_internal(floatx80 a, floatx80 b, bool is_quiet,
>                            float_status *status)


--=20
Alex Benn=C3=A9e

