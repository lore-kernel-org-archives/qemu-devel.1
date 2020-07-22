Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A4AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F04120729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TnghUyLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F04120729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyD3a-0003ko-JF
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyD2f-0002nk-DB
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:36:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyD2Z-0001kk-UD
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:36:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id 17so1670299wmo.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=nqpzWMhWw0dhfht62G9L5GK/ukksDN1KydO+4r1lkpA=;
 b=TnghUyLF4GYmWwcAPstMegspXO+hDGs6C8EqAggFMyZdT2C26Bq2em7Fq94m8wfS0U
 hiTWS97bPD9jX41TMxUJvnRDNPxiKKMOOlcrMpIQnV1NCkDD5Zu7vMz5m4JDCKgsv3CH
 Lax8gyVa9Sw4Zw4CH0M9/F+qvSKhbQCwTCpBD4atkks6xldTIuLmlmoGtuATlltwWbFo
 OFFTzPpeYmdjyC1Hc0jYLoPs2c+kIAcJa/J2YDYsVWZOxC592ok+FaILT5hrC9JWzdRq
 miikaQ4ZBVLXWEHTLc0RmjxupOaHq0lhL6CxxpVqN8uh5LXArDEZS/Nuale4WHWguzAl
 zRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=nqpzWMhWw0dhfht62G9L5GK/ukksDN1KydO+4r1lkpA=;
 b=DZ4q1BEsoJ80FP9hSNdEbkZGN0q57nLEcXcMbwENRZJFAQekQHGv2WH6LPyOY+eBye
 n45LtVTfh+oq/uhakFX87PXURHAz56mv7UpccKOARou2+x2uNbzAoInxAlT+at0psY8a
 1XUQ10tDot7SvFnP+V5A/E5BjZ4wVlPCnLMgoiuuQCIk7g3rO0n7oAXR8Is0RvwhBOhP
 bVMHTNLEQjFXPyXzV6RT6GzsNz55qrH+anocIcWBY0M7035Nve15/wQy88YY6wsSuFVG
 dV5lXq5nO6Ko4DegHVNvEdThavu7OPxuCip1eooSdQnxx2LfWz4wsz6s0tMY7Q4jvPWg
 ZJEw==
X-Gm-Message-State: AOAM533S0IHuqxbCXqiYOTNgEvBtmhz13gZa/j9lJ3+qzFM/V/VOj2CY
 7dD2lr3O9SFJ/qeH8ftSfHLOnA==
X-Google-Smtp-Source: ABdhPJy2a9+CyWGsd4In5tL8svUAMt2uXfti0PjAWR7hhGVzdr0LX6VK9CVIal/se9wOZgsvFoTbIQ==
X-Received: by 2002:a1c:2ec4:: with SMTP id u187mr8088119wmu.188.1595417760663; 
 Wed, 22 Jul 2020 04:36:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y16sm42335896wro.71.2020.07.22.04.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 04:35:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4448D1FF7E;
 Wed, 22 Jul 2020 12:35:58 +0100 (BST)
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-53-frank.chang@sifive.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: frank.chang@sifive.com
Subject: Re: [RFC v2 52/76] fpu: implement full set compare for fp16
In-reply-to: <20200722091641.8834-53-frank.chang@sifive.com>
Date: Wed, 22 Jul 2020 12:35:58 +0100
Message-ID: <87tuxzu6ht.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Chih-Min Chao <chihmin.chao@sifive.com>,
 Kito Cheng <kito.cheng@sifive.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


frank.chang@sifive.com writes:

> From: Kito Cheng <kito.cheng@sifive.com>
>
> Signed-off-by: Kito Cheng <kito.cheng@sifive.com>
> Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  fpu/softfloat.c         | 28 ++++++++++++++++++++++++++++
>  include/fpu/softfloat.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 79be4f5840..9c6640862e 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -401,6 +401,34 @@ float64_gen2(float64 xa, float64 xb, float_status *s,
>      return soft(ua.s, ub.s, s);
>  }
>=20=20
> +/*----------------------------------------------------------------------=
------
> +| Returns the fraction bits of the half-precision floating-point value `=
a'.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +static inline uint32_t extractFloat16Frac(float16 a)
> +{
> +    return float16_val(a) & 0x3ff;
> +}
> +
> +/*----------------------------------------------------------------------=
------
> +| Returns the exponent bits of the half-precision floating-point value `=
a'.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +static inline int extractFloat16Exp(float16 a)
> +{
> +    return (float16_val(a) >> 10) & 0x1f;
> +}
> +
> +/*----------------------------------------------------------------------=
------
> +| Returns the sign bit of the half-precision floating-point value `a'.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +static inline bool extractFloat16Sign(float16 a)
> +{
> +    return float16_val(a) >> 15;
> +}
> +
> +

There functions are no longer needed as float16_compare uses the
decompose code to get what it wants.

>  /*----------------------------------------------------------------------=
------
>  | Returns the fraction bits of the single-precision floating-point value=
 `a'.
>  *-----------------------------------------------------------------------=
-----*/
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index ff4e2605b1..267519cd65 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -285,6 +285,47 @@ static inline float16 float16_set_sign(float16 a, in=
t sign)
>      return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
>  }
>=20=20
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

The rest looks fine. With the extra functions removed:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

