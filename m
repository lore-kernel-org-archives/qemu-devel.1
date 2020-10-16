Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3EAC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457D820829
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1XyXOOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457D820829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSg0-0005jo-9J
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kTSe6-0004iI-96
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:31:58 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:45914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kTSe2-000289-VS
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:31:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id e17so3574461wru.12
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=MXG3UgkaRgPQLfUSpk5FlydAYIo+GI+uwGtYZbmizeQ=;
 b=Z1XyXOOz3JGdn+o8lhDD4xr2n3MiiOFUriZ5LJDHWSidTnnm9c/423BL8fcDU/ppTq
 85OpDCUgD+pfsOZshWKen19lNzafInS7/byDYiVHwN9fULLuEy8CyHcF1Y0arjaHiCCJ
 tSKsxGrw5QP27rA+3W8XGpk82ZbWk6zJp7OBp8cGNFfgFhwBbSlS1C9cgayMrduJxbeT
 WA6OXShZmCjFgTy/A0QplEeZpz47BCkuurzZxtCotgGQCPsUl1uoL/HY/ZmjS9hGhU+U
 MAE+N1sz7K1lfs/58JJohhtWIaW/vCJZPUiIZd4N2rsZFOlsMT3q9L6pDF+Dc/SR/2H9
 jCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=MXG3UgkaRgPQLfUSpk5FlydAYIo+GI+uwGtYZbmizeQ=;
 b=Cmv9ar8m6tNxI9Em/xZ8W7hp0gE5IJ2ZduvP2IRMjpq9oxS6p6ha2v0tWRgpcdOpNW
 g9wJjnWKJoHFDJuBK5qMxIZEBHMlomxQzQG06UVUHc6rAdGscg78gtYQqNsAB7D8Ccdy
 e1rHcgtO/lQYZrxHsMIL0Bkj++Ty5GpB91BzRsEomVIIya5FJIltLWl+m53IpoE7eoV9
 LRdf2OG7H3JlR8Qvo5E+yxnHHC37n5Hnx0G+IBZa4zhpWRDUCksBFUMHuWK5GJ4NMCIZ
 wF6zVxhjsxeByQ6NRcXhy+al7DudLLjtchXo5fqA81dhkiEpcKS74+fhY6EsjbRuAhHh
 2k9w==
X-Gm-Message-State: AOAM531jYyOd2cIBmBIfuloylCI9gY4J6gWTAR8OtuwWuERnkqKDZ+H6
 tPXIIPvR2MCqIgNFHth5wmbHnw==
X-Google-Smtp-Source: ABdhPJztnhuAV5kQMtmJOd7jXfzuUP6iNsjFVpkdx1x8vGmiAIF5yuY8G1GUIu9OXDVd3K6ogW1k4w==
X-Received: by 2002:a05:6000:10cd:: with SMTP id
 b13mr4700765wrx.4.1602865912263; 
 Fri, 16 Oct 2020 09:31:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u6sm3237858wmj.40.2020.10.16.09.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 09:31:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 253221FF7E;
 Fri, 16 Oct 2020 17:31:50 +0100 (BST)
References: <20200925152047.709901-1-richard.henderson@linaro.org>
 <20200925152047.709901-7-richard.henderson@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 06/10] softfloat: Implement float128_muladd
In-reply-to: <20200925152047.709901-7-richard.henderson@linaro.org>
Date: Fri, 16 Oct 2020 17:31:50 +0100
Message-ID: <87tuuuuo7d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: bharata@linux.ibm.com, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/fpu/softfloat.h |   2 +
>  fpu/softfloat.c         | 416 +++++++++++++++++++++++++++++++++++++++-
>  tests/fp/fp-test.c      |   2 +-
>  tests/fp/wrap.c.inc     |  12 ++
>  4 files changed, 430 insertions(+), 2 deletions(-)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 78ad5ca738..a38433deb4 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -1196,6 +1196,8 @@ float128 float128_sub(float128, float128, float_sta=
tus *status);
>  float128 float128_mul(float128, float128, float_status *status);
>  float128 float128_div(float128, float128, float_status *status);
>  float128 float128_rem(float128, float128, float_status *status);
> +float128 float128_muladd(float128, float128, float128, int,
> +                         float_status *status);
>  float128 float128_sqrt(float128, float_status *status);
>  FloatRelation float128_compare(float128, float128, float_status *status);
>  FloatRelation float128_compare_quiet(float128, float128, float_status *s=
tatus);
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index e038434a07..49de31fec2 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -512,11 +512,19 @@ static inline __attribute__((unused)) bool is_qnan(=
FloatClass c)
>=20=20
>  typedef struct {
>      uint64_t frac;
> -    int32_t  exp;
> +    int32_t exp;
>      FloatClass cls;
>      bool sign;
>  } FloatParts;
>=20=20
> +/* Similar for float128.  */
> +typedef struct {
> +    uint64_t frac0, frac1;
> +    int32_t exp;
> +    FloatClass cls;
> +    bool sign;
> +} FloatParts128;
> +
>  #define DECOMPOSED_BINARY_POINT    (64 - 2)
>  #define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
>  #define DECOMPOSED_OVERFLOW_BIT    (DECOMPOSED_IMPLICIT_BIT << 1)
> @@ -4574,6 +4582,46 @@ static void
>=20=20
>  }
>=20=20
> +/*----------------------------------------------------------------------=
------
> +| Returns the parts of floating-point value `a'.
> +*-----------------------------------------------------------------------=
-----*/
> +
> +static void float128_unpack(FloatParts128 *p, float128 a, float_status *=
status)
> +{
> +    p->sign =3D extractFloat128Sign(a);
> +    p->exp =3D extractFloat128Exp(a);
> +    p->frac0 =3D extractFloat128Frac0(a);
> +    p->frac1 =3D extractFloat128Frac1(a);

Here we are deviating from the exiting style, it would be nice if we
could separate the raw unpack and have something like:

static const FloatFmt float128_params =3D {
    FLOAT_PARAMS(15, 112)
}

static inline FloatParts128 unpack128_raw(FloatFmt fmt, uint128_t raw)
{
    const int sign_pos =3D fmt.frac_size + fmt.exp_size;

    return (FloatParts128) {
        .cls =3D float_class_unclassified,
        .sign =3D extract128(raw, sign_pos, 1),
        .exp =3D extract128(raw, fmt.frac_size, fmt.exp_size),
        .frac1 =3D extract128_lo(raw, 0, fmt.frac_size),
        .frac2 =3D extract128_hi(raw, 0, fmt.frac_size),
    };
}

So even if we end up duplicating a chunk of the code the form will be
similar so when we side-by-side the logic we can see it works the same
way.

> +
> +    if (p->exp =3D=3D 0) {
> +        if ((p->frac0 | p->frac1) =3D=3D 0) {
> +            p->cls =3D float_class_zero;
> +        } else if (status->flush_inputs_to_zero) {
> +            float_raise(float_flag_input_denormal, status);
> +            p->cls =3D float_class_zero;
> +            p->frac0 =3D p->frac1 =3D 0;
> +        } else {
> +            normalizeFloat128Subnormal(p->frac0, p->frac1, &p->exp,
> +                                       &p->frac0, &p->frac1);
> +            p->exp -=3D 0x3fff;
> +            p->cls =3D float_class_normal;
> +        }

and also we can get avoid introducing the magic numbers into the code.

> +    } else if (p->exp =3D=3D 0x7fff) {
> +        if ((p->frac0 | p->frac1) =3D=3D 0) {
> +            p->cls =3D float_class_inf;
> +        } else if (float128_is_signaling_nan(a, status)) {
> +            p->cls =3D float_class_snan;
> +        } else {
> +            p->cls =3D float_class_qnan;
> +        }
> +    } else {
> +        /* Add the implicit bit. */
> +        p->frac0 |=3D UINT64_C(0x0001000000000000);
> +        p->exp -=3D 0x3fff;
> +        p->cls =3D float_class_normal;
> +    }
> +}
> +

and eventually hold out for compilers smart enough to handle unification
at a later date.

>  /*----------------------------------------------------------------------=
------
>  | Packs the sign `zSign', the exponent `zExp', and the significand formed
>  | by the concatenation of `zSig0' and `zSig1' into a quadruple-precision
> @@ -7205,6 +7253,372 @@ float128 float128_mul(float128 a, float128 b, flo=
at_status *status)
>=20=20
>  }
>=20=20
> +typedef struct UInt256 {
> +    /* Indexed big-endian, to match the rest of softfloat numbering. */
> +    uint64_t w[4];
> +} UInt256;
> +
> +static inline uint64_t shl_double(uint64_t h, uint64_t l, unsigned lsh)
> +{
> +    return lsh ? (h << lsh) | (l >> (64 - lsh)) : h;
> +}
> +
> +static inline uint64_t shr_double(uint64_t h, uint64_t l, unsigned rsh)
> +{
> +    return rsh ? (h << (64 - rsh)) | (l >> rsh) : l;
> +}
> +
> +static void shortShift256Left(UInt256 *p, unsigned lsh)
> +{
> +    if (lsh !=3D 0) {
> +        p->w[0] =3D shl_double(p->w[0], p->w[1], lsh);
> +        p->w[1] =3D shl_double(p->w[1], p->w[2], lsh);
> +        p->w[2] =3D shl_double(p->w[2], p->w[3], lsh);
> +        p->w[3] <<=3D lsh;
> +    }
> +}
> +
> +static inline void shift256RightJamming(UInt256 *p, unsigned count)
> +{
> +    uint64_t out, p0, p1, p2, p3;
> +
> +    p0 =3D p->w[0];
> +    p1 =3D p->w[1];
> +    p2 =3D p->w[2];
> +    p3 =3D p->w[3];
> +
> +    if (unlikely(count =3D=3D 0)) {
> +        return;
> +    } else if (likely(count < 64)) {
> +        out =3D 0;
> +    } else if (likely(count < 256)) {
> +        if (count < 128) {
> +            out =3D p3;
> +            p3 =3D p2;
> +            p2 =3D p1;
> +            p1 =3D p0;
> +            p0 =3D 0;
> +        } else if (count < 192) {
> +            out =3D p2 | p3;
> +            p3 =3D p1;
> +            p2 =3D p0;
> +            p1 =3D 0;
> +            p0 =3D 0;
> +        } else {
> +            out =3D p1 | p2 | p3;
> +            p3 =3D p0;
> +            p2 =3D 0;
> +            p1 =3D 0;
> +            p0 =3D 0;
> +        }
> +        count &=3D 63;
> +        if (count =3D=3D 0) {
> +            goto done;
> +        }
> +    } else {
> +        out =3D p0 | p1 | p2 | p3;
> +        p3 =3D 0;
> +        p2 =3D 0;
> +        p1 =3D 0;
> +        p0 =3D 0;
> +        goto done;
> +    }
> +
> +    out |=3D shr_double(p3, 0, count);
> +    p3 =3D shr_double(p2, p3, count);
> +    p2 =3D shr_double(p1, p2, count);
> +    p1 =3D shr_double(p0, p1, count);
> +    p0 =3D p0 >> count;
> +
> + done:
> +    p->w[3] =3D p3 | (out !=3D 0);
> +    p->w[2] =3D p2;
> +    p->w[1] =3D p1;
> +    p->w[0] =3D p0;
> +}
> +
> +/* R =3D A - B */
> +static void sub256(UInt256 *r, UInt256 *a, UInt256 *b)
> +{
> +    bool borrow =3D false;
> +
> +    for (int i =3D 3; i >=3D 0; --i) {
> +        uint64_t at =3D a->w[i];
> +        uint64_t bt =3D b->w[i];
> +        uint64_t rt =3D at - bt;
> +
> +        if (borrow) {
> +            borrow =3D at <=3D bt;
> +            rt -=3D 1;
> +        } else {
> +            borrow =3D at < bt;
> +        }
> +        r->w[i] =3D rt;
> +    }
> +}
> +
> +/* A =3D -A */
> +static void neg256(UInt256 *a)
> +{
> +    /*
> +     * Recall that -X - 1 =3D ~X, and that since this is negation,
> +     * once we find a non-zero number, all subsequent words will
> +     * have borrow-in, and thus use NOT.
> +     */
> +    uint64_t t =3D a->w[3];
> +    if (likely(t)) {
> +        a->w[3] =3D -t;
> +        goto not2;
> +    }
> +    t =3D a->w[2];
> +    if (likely(t)) {
> +        a->w[2] =3D -t;
> +        goto not1;
> +    }
> +    t =3D a->w[1];
> +    if (likely(t)) {
> +        a->w[1] =3D -t;
> +        goto not0;
> +    }
> +    a->w[0] =3D -a->w[0];
> +    return;
> + not2:
> +    a->w[2] =3D ~a->w[2];
> + not1:
> +    a->w[1] =3D ~a->w[1];
> + not0:
> +    a->w[0] =3D ~a->w[0];
> +}
> +
> +/* A +=3D B */
> +static void add256(UInt256 *a, UInt256 *b)
> +{
> +    bool carry =3D false;
> +
> +    for (int i =3D 3; i >=3D 0; --i) {
> +        uint64_t bt =3D b->w[i];
> +        uint64_t at =3D a->w[i] + bt;
> +
> +        if (carry) {
> +            at +=3D 1;
> +            carry =3D at <=3D bt;
> +        } else {
> +            carry =3D at < bt;
> +        }
> +        a->w[i] =3D at;
> +    }
> +}
> +
> +float128 float128_muladd(float128 a_f, float128 b_f, float128 c_f,
> +                         int flags, float_status *status)
> +{
> +    bool inf_zero, p_sign, sign_flip;
> +    int p_exp, exp_diff, shift, ab_mask, abc_mask;
> +    FloatParts128 a, b, c;
> +    FloatClass p_cls;
> +    UInt256 p_frac, c_frac;
> +
> +    float128_unpack(&a, a_f, status);
> +    float128_unpack(&b, b_f, status);
> +    float128_unpack(&c, c_f, status);
> +
> +    ab_mask =3D float_cmask(a.cls) | float_cmask(b.cls);
> +    abc_mask =3D float_cmask(c.cls) | ab_mask;
> +    inf_zero =3D ab_mask =3D=3D float_cmask_infzero;
> +
> +    /* If any input is a NaN, select the required result. */
> +    if (unlikely(abc_mask & float_cmask_anynan)) {
> +        if (unlikely(abc_mask & float_cmask_snan)) {
> +            float_raise(float_flag_invalid, status);
> +        }
> +
> +        int which =3D pickNaNMulAdd(a.cls, b.cls, c.cls, inf_zero, statu=
s);
> +        if (status->default_nan_mode) {
> +            which =3D 3;
> +        }
> +        switch (which) {
> +        case 0:
> +            break;
> +        case 1:
> +            a_f =3D b_f;
> +            a.cls =3D b.cls;
> +            break;
> +        case 2:
> +            a_f =3D c_f;
> +            a.cls =3D c.cls;
> +            break;
> +        case 3:
> +            return float128_default_nan(status);
> +        }
> +        if (is_snan(a.cls)) {
> +            return float128_silence_nan(a_f, status);
> +        }
> +        return a_f;
> +    }
> +
> +    /* After dealing with input NaNs, look for Inf * Zero. */
> +    if (unlikely(inf_zero)) {
> +        float_raise(float_flag_invalid, status);
> +        return float128_default_nan(status);
> +    }
> +
> +    p_sign =3D a.sign ^ b.sign;
> +
> +    if (flags & float_muladd_negate_c) {
> +        c.sign ^=3D 1;
> +    }
> +    if (flags & float_muladd_negate_product) {
> +        p_sign ^=3D 1;
> +    }
> +    sign_flip =3D (flags & float_muladd_negate_result);
> +
> +    if (ab_mask & float_cmask_inf) {
> +        p_cls =3D float_class_inf;
> +    } else if (ab_mask & float_cmask_zero) {
> +        p_cls =3D float_class_zero;
> +    } else {
> +        p_cls =3D float_class_normal;
> +    }
> +
> +    if (c.cls =3D=3D float_class_inf) {
> +        if (p_cls =3D=3D float_class_inf && p_sign !=3D c.sign) {
> +            /* +Inf + -Inf =3D NaN */
> +            float_raise(float_flag_invalid, status);
> +            return float128_default_nan(status);
> +        }
> +        /* Inf + Inf =3D Inf of the proper sign; reuse the return below.=
 */
> +        p_cls =3D float_class_inf;
> +        p_sign =3D c.sign;
> +    }
> +
> +    if (p_cls =3D=3D float_class_inf) {
> +        return packFloat128(p_sign ^ sign_flip, 0x7fff, 0, 0);
> +    }
> +
> +    if (p_cls =3D=3D float_class_zero) {
> +        if (c.cls =3D=3D float_class_zero) {
> +            if (p_sign !=3D c.sign) {
> +                p_sign =3D status->float_rounding_mode =3D=3D float_roun=
d_down;
> +            }
> +            return packFloat128(p_sign ^ sign_flip, 0, 0, 0);
> +        }
> +
> +        if (flags & float_muladd_halve_result) {
> +            c.exp -=3D 1;
> +        }
> +        return roundAndPackFloat128(c.sign ^ sign_flip,
> +                                    c.exp + 0x3fff - 1,
> +                                    c.frac0, c.frac1, 0, status);
> +    }
> +
> +    /* a & b should be normals now... */
> +    assert(a.cls =3D=3D float_class_normal && b.cls =3D=3D float_class_n=
ormal);
> +
> +    /* Multiply of 2 113-bit numbers produces a 226-bit result.  */
> +    mul128To256(a.frac0, a.frac1, b.frac0, b.frac1,
> +                &p_frac.w[0], &p_frac.w[1], &p_frac.w[2], &p_frac.w[3]);
> +
> +    /* Realign the binary point at bit 48 of p_frac[0].  */
> +    shift =3D clz64(p_frac.w[0]) - 15;
> +    shortShift256Left(&p_frac, shift);
> +    p_exp =3D a.exp + b.exp - (shift - 16);
> +    exp_diff =3D p_exp - c.exp;
> +
> +    /* Extend the fraction part of the addend to 256 bits.  */
> +    c_frac.w[0] =3D c.frac0;
> +    c_frac.w[1] =3D c.frac1;
> +    c_frac.w[2] =3D 0;
> +    c_frac.w[3] =3D 0;
> +
> +    /* Add or subtract C from the intermediate product. */
> +    if (c.cls =3D=3D float_class_zero) {
> +        /* Fall through to rounding after addition (with zero). */
> +    } else if (p_sign !=3D c.sign) {
> +        /* Subtraction */
> +        if (exp_diff < 0) {
> +            shift256RightJamming(&p_frac, -exp_diff);
> +            sub256(&p_frac, &c_frac, &p_frac);
> +            p_exp =3D c.exp;
> +            p_sign ^=3D 1;
> +        } else if (exp_diff > 0) {
> +            shift256RightJamming(&c_frac, exp_diff);
> +            sub256(&p_frac, &p_frac, &c_frac);
> +        } else {
> +            /* Low 128 bits of C are known to be zero. */
> +            sub128(p_frac.w[0], p_frac.w[1], c_frac.w[0], c_frac.w[1],
> +                   &p_frac.w[0], &p_frac.w[1]);
> +            /*
> +             * Since we have normalized to bit 48 of p_frac[0],
> +             * a negative result means C > P and we need to invert.
> +             */
> +            if ((int64_t)p_frac.w[0] < 0) {
> +                neg256(&p_frac);
> +                p_sign ^=3D 1;
> +            }
> +        }
> +
> +        /*
> +         * Gross normalization of the 256-bit subtraction result.
> +         * Fine tuning below shared with addition.
> +         */
> +        if (p_frac.w[0] !=3D 0) {
> +            /* nothing to do */
> +        } else if (p_frac.w[1] !=3D 0) {
> +            p_exp -=3D 64;
> +            p_frac.w[0] =3D p_frac.w[1];
> +            p_frac.w[1] =3D p_frac.w[2];
> +            p_frac.w[2] =3D p_frac.w[3];
> +            p_frac.w[3] =3D 0;
> +        } else if (p_frac.w[2] !=3D 0) {
> +            p_exp -=3D 128;
> +            p_frac.w[0] =3D p_frac.w[2];
> +            p_frac.w[1] =3D p_frac.w[3];
> +            p_frac.w[2] =3D 0;
> +            p_frac.w[3] =3D 0;
> +        } else if (p_frac.w[3] !=3D 0) {
> +            p_exp -=3D 192;
> +            p_frac.w[0] =3D p_frac.w[3];
> +            p_frac.w[1] =3D 0;
> +            p_frac.w[2] =3D 0;
> +            p_frac.w[3] =3D 0;
> +        } else {
> +            /* Subtraction was exact: result is zero. */
> +            p_sign =3D status->float_rounding_mode =3D=3D float_round_do=
wn;
> +            return packFloat128(p_sign ^ sign_flip, 0, 0, 0);
> +        }
> +    } else {
> +        /* Addition */
> +        if (exp_diff <=3D 0) {
> +            shift256RightJamming(&p_frac, -exp_diff);
> +            /* Low 128 bits of C are known to be zero. */
> +            add128(p_frac.w[0], p_frac.w[1], c_frac.w[0], c_frac.w[1],
> +                   &p_frac.w[0], &p_frac.w[1]);
> +            p_exp =3D c.exp;
> +        } else {
> +            shift256RightJamming(&c_frac, exp_diff);
> +            add256(&p_frac, &c_frac);
> +        }
> +    }
> +
> +    /* Fine normalization of the 256-bit result: p_frac[0] !=3D 0. */
> +    shift =3D clz64(p_frac.w[0]) - 15;
> +    if (shift < 0) {
> +        shift256RightJamming(&p_frac, -shift);
> +    } else if (shift > 0) {
> +        shortShift256Left(&p_frac, shift);
> +    }
> +    p_exp -=3D shift;
> +
> +    if (flags & float_muladd_halve_result) {
> +        p_exp -=3D 1;
> +    }
> +    return roundAndPackFloat128(p_sign ^ sign_flip,
> +                                p_exp + 0x3fff - 1,
> +                                p_frac.w[0], p_frac.w[1],
> +                                p_frac.w[2] | (p_frac.w[3] !=3D 0),
> +                                status);
> +}
> +
>  /*----------------------------------------------------------------------=
------
>  | Returns the result of dividing the quadruple-precision floating-point =
value
>  | `a' by the corresponding value `b'.  The operation is performed accord=
ing to
> diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
> index 06ffebd6db..9bbb0dba67 100644
> --- a/tests/fp/fp-test.c
> +++ b/tests/fp/fp-test.c
> @@ -717,7 +717,7 @@ static void do_testfloat(int op, int rmode, bool exac=
t)
>          test_abz_f128(true_abz_f128M, subj_abz_f128M);
>          break;
>      case F128_MULADD:
> -        not_implemented();
> +        test_abcz_f128(slow_f128M_mulAdd, qemu_f128_mulAdd);
>          break;
>      case F128_SQRT:
>          test_az_f128(slow_f128M_sqrt, qemu_f128M_sqrt);
> diff --git a/tests/fp/wrap.c.inc b/tests/fp/wrap.c.inc
> index 0cbd20013e..65a713deae 100644
> --- a/tests/fp/wrap.c.inc
> +++ b/tests/fp/wrap.c.inc
> @@ -574,6 +574,18 @@ WRAP_MULADD(qemu_f32_mulAdd, float32_muladd, float32)
>  WRAP_MULADD(qemu_f64_mulAdd, float64_muladd, float64)
>  #undef WRAP_MULADD
>=20=20
> +static void qemu_f128_mulAdd(const float128_t *ap, const float128_t *bp,
> +                             const float128_t *cp, float128_t *res)
> +{
> +    float128 a, b, c, ret;
> +
> +    a =3D soft_to_qemu128(*ap);
> +    b =3D soft_to_qemu128(*bp);
> +    c =3D soft_to_qemu128(*cp);
> +    ret =3D float128_muladd(a, b, c, 0, &qsf);
> +    *res =3D qemu_to_soft128(ret);
> +}
> +
>  #define WRAP_CMP16(name, func, retcond)         \
>      static bool name(float16_t a, float16_t b)  \
>      {                                           \


--=20
Alex Benn=C3=A9e

