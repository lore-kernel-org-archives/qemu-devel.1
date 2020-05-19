Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8FFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA52207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I2jT4bNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA52207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaylM-00028R-2J
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 05:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaykJ-0001Ag-E9
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:41:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jaykI-0000DS-19
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:41:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id n5so2737470wmd.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=INNHwktukbmrXGEJFgkPVvP4u4ixH/+L3tgtOxYzwG8=;
 b=I2jT4bNHPdW7LQL4rRMz9A9RwWNTa3rwvb4ph/xHi+Hx1Gb/mnpDgGBcscH57VYk21
 Pa0eJYRp6zkUTpULS+q+s/sJkMrynUq4jopNpCJTLVNWFaOPLfl88FnJunHr22nP5ewu
 7tHkhVo/T9orzYSNMxZCUbNm36OvlpzsoAGrbicMq8qHPV9xstknnqd6JoVCpFu2hdzr
 751iIDXgk+gozqiBrg9IwOqaI0QRVOl+3MmEC247fULqHplZkuGe+dcAxOhZGy4uV9ry
 3s0lAzZpjeR5u8eZ2eK9fVTRolpWd7cSezR1g2duwQ6sqOMGGrV2d0MnU0AoTgzbRx4C
 iNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=INNHwktukbmrXGEJFgkPVvP4u4ixH/+L3tgtOxYzwG8=;
 b=Zm5ZTOMlN80MgwPKdBqAKhUHND0IZ1mO797PunVheDsNIS5Q0gY/5y5+zhKjTxZkpG
 gmdW//nH6eEhqhh7FAwb6h4pjmc97oJIvg35oK1HCuAW2K8QQHNPgYV2kujMQ7lNsBY6
 eIwiBzhcLQB9r2CqeLx5N3Ro8csyIouZvw9lvNQdgHWIN9bBpPUtFFEj16Dx5xuFeXwh
 LmRiqFCzoEclbv4PjQelf6bt45Id0u0DUBfVS1iO+ZFMJ+We6Bup40KsT1BLTpPtrXpX
 gKrPEmOwTS78DDIPwPkkYBwbQeUdXdWE99fpok/WOBnqr5iolMdI3Z+AcdEE41jbs9+Z
 AWBA==
X-Gm-Message-State: AOAM53278Qq9k08IiwJ93J8a5ZtCJWawEVemergEEtXAQttS7OlFonLk
 wB80sL5GtNRPVwE4TevPs7lezP2284M=
X-Google-Smtp-Source: ABdhPJy+EsWlawOsSV3T/+fc/RrVGCdPTWwerh52s8jqUSkv5B1dwWCmVYcUlkafAWR8BOPC33X/jg==
X-Received: by 2002:a7b:c1d2:: with SMTP id a18mr4401782wmj.176.1589881268302; 
 Tue, 19 May 2020 02:41:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a21sm3066012wmm.7.2020.05.19.02.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 02:41:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 324361FF7E;
 Tue, 19 May 2020 10:41:06 +0100 (BST)
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-8-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 07/10] softfloat: Inline float64 compare specializations
In-reply-to: <20200515190153.6017-8-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 10:41:06 +0100
Message-ID: <87sgfwi7nx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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

> Replace the float64 compare specializations with inline functions
> that call the standard float64_compare{,_quiet} functions.
> Use bool as the return type.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/fpu/softfloat.h       |  49 ++++++--
>  fpu/softfloat.c               | 220 ----------------------------------
>  target/s390x/vec_fpu_helper.c |   2 +-
>  3 files changed, 42 insertions(+), 229 deletions(-)

=F0=9F=91=8B=F0=9F=91=8F

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 4d1af6ab45..281f0fd971 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -532,14 +532,6 @@ float64 float64_rem(float64, float64, float_status *=
status);
>  float64 float64_muladd(float64, float64, float64, int, float_status *sta=
tus);
>  float64 float64_sqrt(float64, float_status *status);
>  float64 float64_log2(float64, float_status *status);
> -int float64_eq(float64, float64, float_status *status);
> -int float64_le(float64, float64, float_status *status);
> -int float64_lt(float64, float64, float_status *status);
> -int float64_unordered(float64, float64, float_status *status);
> -int float64_eq_quiet(float64, float64, float_status *status);
> -int float64_le_quiet(float64, float64, float_status *status);
> -int float64_lt_quiet(float64, float64, float_status *status);
> -int float64_unordered_quiet(float64, float64, float_status *status);
>  FloatRelation float64_compare(float64, float64, float_status *status);
>  FloatRelation float64_compare_quiet(float64, float64, float_status *stat=
us);
>  float64 float64_min(float64, float64, float_status *status);
> @@ -615,6 +607,47 @@ static inline float64 float64_set_sign(float64 a, in=
t sign)
>                          | ((int64_t)sign << 63));
>  }
>=20=20
> +static inline bool float64_eq(float64 a, float64 b, float_status *s)
> +{
> +    return float64_compare(a, b, s) =3D=3D float_relation_equal;
> +}
> +
> +static inline bool float64_le(float64 a, float64 b, float_status *s)
> +{
> +    return float64_compare(a, b, s) <=3D float_relation_equal;
> +}
> +
> +static inline bool float64_lt(float64 a, float64 b, float_status *s)
> +{
> +    return float64_compare(a, b, s) < float_relation_equal;
> +}
> +
> +static inline bool float64_unordered(float64 a, float64 b, float_status =
*s)
> +{
> +    return float64_compare(a, b, s) =3D=3D float_relation_unordered;
> +}
> +
> +static inline bool float64_eq_quiet(float64 a, float64 b, float_status *=
s)
> +{
> +    return float64_compare_quiet(a, b, s) =3D=3D float_relation_equal;
> +}
> +
> +static inline bool float64_le_quiet(float64 a, float64 b, float_status *=
s)
> +{
> +    return float64_compare_quiet(a, b, s) <=3D float_relation_equal;
> +}
> +
> +static inline bool float64_lt_quiet(float64 a, float64 b, float_status *=
s)
> +{
> +    return float64_compare_quiet(a, b, s) < float_relation_equal;
> +}
> +
> +static inline bool float64_unordered_quiet(float64 a, float64 b,
> +                                           float_status *s)
> +{
> +    return float64_compare_quiet(a, b, s) =3D=3D float_relation_unordere=
d;
> +}
> +
>  #define float64_zero make_float64(0)
>  #define float64_half make_float64(0x3fe0000000000000LL)
>  #define float64_one make_float64(0x3ff0000000000000LL)
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index f6bfc40c97..5d7fc2c17a 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -4941,226 +4941,6 @@ float64 float64_log2(float64 a, float_status *sta=
tus)
>      return normalizeRoundAndPackFloat64(zSign, 0x408, zSig, status);
>  }
>=20=20
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the double-precision floating-point value `a' is equal to=
 the
> -| corresponding value `b', and 0 otherwise.  The invalid exception is ra=
ised
> -| if either operand is a NaN.  Otherwise, the comparison is performed
> -| according to the IEC/IEEE Standard for Binary Floating-Point Arithmeti=
c.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float64_eq(float64 a, float64 b, float_status *status)
> -{
> -    uint64_t av, bv;
> -    a =3D float64_squash_input_denormal(a, status);
> -    b =3D float64_squash_input_denormal(b, status);
> -
> -    if (    ( ( extractFloat64Exp( a ) =3D=3D 0x7FF ) && extractFloat64F=
rac( a ) )
> -         || ( ( extractFloat64Exp( b ) =3D=3D 0x7FF ) && extractFloat64F=
rac( b ) )
> -       ) {
> -        float_raise(float_flag_invalid, status);
> -        return 0;
> -    }
> -    av =3D float64_val(a);
> -    bv =3D float64_val(b);
> -    return ( av =3D=3D bv ) || ( (uint64_t) ( ( av | bv )<<1 ) =3D=3D 0 =
);
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the double-precision floating-point value `a' is less tha=
n or
> -| equal to the corresponding value `b', and 0 otherwise.  The invalid
> -| exception is raised if either operand is a NaN.  The comparison is per=
formed
> -| according to the IEC/IEEE Standard for Binary Floating-Point Arithmeti=
c.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float64_le(float64 a, float64 b, float_status *status)
> -{
> -    bool aSign, bSign;
> -    uint64_t av, bv;
> -    a =3D float64_squash_input_denormal(a, status);
> -    b =3D float64_squash_input_denormal(b, status);
> -
> -    if (    ( ( extractFloat64Exp( a ) =3D=3D 0x7FF ) && extractFloat64F=
rac( a ) )
> -         || ( ( extractFloat64Exp( b ) =3D=3D 0x7FF ) && extractFloat64F=
rac( b ) )
> -       ) {
> -        float_raise(float_flag_invalid, status);
> -        return 0;
> -    }
> -    aSign =3D extractFloat64Sign( a );
> -    bSign =3D extractFloat64Sign( b );
> -    av =3D float64_val(a);
> -    bv =3D float64_val(b);
> -    if ( aSign !=3D bSign ) return aSign || ( (uint64_t) ( ( av | bv )<<=
1 ) =3D=3D 0 );
> -    return ( av =3D=3D bv ) || ( aSign ^ ( av < bv ) );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the double-precision floating-point value `a' is less than
> -| the corresponding value `b', and 0 otherwise.  The invalid exception is
> -| raised if either operand is a NaN.  The comparison is performed accord=
ing
> -| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float64_lt(float64 a, float64 b, float_status *status)
> -{
> -    bool aSign, bSign;
> -    uint64_t av, bv;
> -
> -    a =3D float64_squash_input_denormal(a, status);
> -    b =3D float64_squash_input_denormal(b, status);
> -    if (    ( ( extractFloat64Exp( a ) =3D=3D 0x7FF ) && extractFloat64F=
rac( a ) )
> -         || ( ( extractFloat64Exp( b ) =3D=3D 0x7FF ) && extractFloat64F=
rac( b ) )
> -       ) {
> -        float_raise(float_flag_invalid, status);
> -        return 0;
> -    }
> -    aSign =3D extractFloat64Sign( a );
> -    bSign =3D extractFloat64Sign( b );
> -    av =3D float64_val(a);
> -    bv =3D float64_val(b);
> -    if ( aSign !=3D bSign ) return aSign && ( (uint64_t) ( ( av | bv )<<=
1 ) !=3D 0 );
> -    return ( av !=3D bv ) && ( aSign ^ ( av < bv ) );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the double-precision floating-point values `a' and `b' ca=
nnot
> -| be compared, and 0 otherwise.  The invalid exception is raised if eith=
er
> -| operand is a NaN.  The comparison is performed according to the IEC/IE=
EE
> -| Standard for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float64_unordered(float64 a, float64 b, float_status *status)
> -{
> -    a =3D float64_squash_input_denormal(a, status);
> -    b =3D float64_squash_input_denormal(b, status);
> -
> -    if (    ( ( extractFloat64Exp( a ) =3D=3D 0x7FF ) && extractFloat64F=
rac( a ) )
> -         || ( ( extractFloat64Exp( b ) =3D=3D 0x7FF ) && extractFloat64F=
rac( b ) )
> -       ) {
> -        float_raise(float_flag_invalid, status);
> -        return 1;
> -    }
> -    return 0;
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the double-precision floating-point value `a' is equal to=
 the
> -| corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
> -| exception.The comparison is performed according to the IEC/IEEE Standa=
rd
> -| for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float64_eq_quiet(float64 a, float64 b, float_status *status)
> -{
> -    uint64_t av, bv;
> -    a =3D float64_squash_input_denormal(a, status);
> -    b =3D float64_squash_input_denormal(b, status);
> -
> -    if (    ( ( extractFloat64Exp( a ) =3D=3D 0x7FF ) && extractFloat64F=
rac( a ) )
> -         || ( ( extractFloat64Exp( b ) =3D=3D 0x7FF ) && extractFloat64F=
rac( b ) )
> -       ) {
> -        if (float64_is_signaling_nan(a, status)
> -         || float64_is_signaling_nan(b, status)) {
> -            float_raise(float_flag_invalid, status);
> -        }
> -        return 0;
> -    }
> -    av =3D float64_val(a);
> -    bv =3D float64_val(b);
> -    return ( av =3D=3D bv ) || ( (uint64_t) ( ( av | bv )<<1 ) =3D=3D 0 =
);
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the double-precision floating-point value `a' is less tha=
n or
> -| equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs do =
not
> -| cause an exception.  Otherwise, the comparison is performed according =
to the
> -| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float64_le_quiet(float64 a, float64 b, float_status *status)
> -{
> -    bool aSign, bSign;
> -    uint64_t av, bv;
> -    a =3D float64_squash_input_denormal(a, status);
> -    b =3D float64_squash_input_denormal(b, status);
> -
> -    if (    ( ( extractFloat64Exp( a ) =3D=3D 0x7FF ) && extractFloat64F=
rac( a ) )
> -         || ( ( extractFloat64Exp( b ) =3D=3D 0x7FF ) && extractFloat64F=
rac( b ) )
> -       ) {
> -        if (float64_is_signaling_nan(a, status)
> -         || float64_is_signaling_nan(b, status)) {
> -            float_raise(float_flag_invalid, status);
> -        }
> -        return 0;
> -    }
> -    aSign =3D extractFloat64Sign( a );
> -    bSign =3D extractFloat64Sign( b );
> -    av =3D float64_val(a);
> -    bv =3D float64_val(b);
> -    if ( aSign !=3D bSign ) return aSign || ( (uint64_t) ( ( av | bv )<<=
1 ) =3D=3D 0 );
> -    return ( av =3D=3D bv ) || ( aSign ^ ( av < bv ) );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the double-precision floating-point value `a' is less than
> -| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause=
 an
> -| exception.  Otherwise, the comparison is performed according to the IE=
C/IEEE
> -| Standard for Binary Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float64_lt_quiet(float64 a, float64 b, float_status *status)
> -{
> -    bool aSign, bSign;
> -    uint64_t av, bv;
> -    a =3D float64_squash_input_denormal(a, status);
> -    b =3D float64_squash_input_denormal(b, status);
> -
> -    if (    ( ( extractFloat64Exp( a ) =3D=3D 0x7FF ) && extractFloat64F=
rac( a ) )
> -         || ( ( extractFloat64Exp( b ) =3D=3D 0x7FF ) && extractFloat64F=
rac( b ) )
> -       ) {
> -        if (float64_is_signaling_nan(a, status)
> -         || float64_is_signaling_nan(b, status)) {
> -            float_raise(float_flag_invalid, status);
> -        }
> -        return 0;
> -    }
> -    aSign =3D extractFloat64Sign( a );
> -    bSign =3D extractFloat64Sign( b );
> -    av =3D float64_val(a);
> -    bv =3D float64_val(b);
> -    if ( aSign !=3D bSign ) return aSign && ( (uint64_t) ( ( av | bv )<<=
1 ) !=3D 0 );
> -    return ( av !=3D bv ) && ( aSign ^ ( av < bv ) );
> -
> -}
> -
> -/*----------------------------------------------------------------------=
------
> -| Returns 1 if the double-precision floating-point values `a' and `b' ca=
nnot
> -| be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.  =
The
> -| comparison is performed according to the IEC/IEEE Standard for Binary
> -| Floating-Point Arithmetic.
> -*-----------------------------------------------------------------------=
-----*/
> -
> -int float64_unordered_quiet(float64 a, float64 b, float_status *status)
> -{
> -    a =3D float64_squash_input_denormal(a, status);
> -    b =3D float64_squash_input_denormal(b, status);
> -
> -    if (    ( ( extractFloat64Exp( a ) =3D=3D 0x7FF ) && extractFloat64F=
rac( a ) )
> -         || ( ( extractFloat64Exp( b ) =3D=3D 0x7FF ) && extractFloat64F=
rac( b ) )
> -       ) {
> -        if (float64_is_signaling_nan(a, status)
> -         || float64_is_signaling_nan(b, status)) {
> -            float_raise(float_flag_invalid, status);
> -        }
> -        return 1;
> -    }
> -    return 0;
> -}
> -
>  /*----------------------------------------------------------------------=
------
>  | Returns the result of converting the extended double-precision floatin=
g-
>  | point value `a' to the 32-bit two's complement integer format.  The
> diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
> index a48bd704bc..c1564e819b 100644
> --- a/target/s390x/vec_fpu_helper.c
> +++ b/target/s390x/vec_fpu_helper.c
> @@ -174,7 +174,7 @@ void HELPER(gvec_wfk64)(const void *v1, const void *v=
2, CPUS390XState *env,
>      env->cc_op =3D wfc64(v1, v2, env, true, GETPC());
>  }
>=20=20
> -typedef int (*vfc64_fn)(float64 a, float64 b, float_status *status);
> +typedef bool (*vfc64_fn)(float64 a, float64 b, float_status *status);
>  static int vfc64(S390Vector *v1, const S390Vector *v2, const S390Vector =
*v3,
>                   CPUS390XState *env, bool s, vfc64_fn fn, uintptr_t reta=
ddr)
>  {


--=20
Alex Benn=C3=A9e

