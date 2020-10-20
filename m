Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BB2C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1EA22244
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9X8lJCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1EA22244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUwis-0000g1-JV
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUwhw-00008I-D6
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:50:04 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUwhu-0003Gj-85
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:50:03 -0400
Received: by mail-pf1-x441.google.com with SMTP id a200so1678122pfa.10
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2YSCBrV8N0F6AHWJ2u/uz6K3rNWDmD73VBl5nqd/Y1I=;
 b=f9X8lJCOVE114elJaD8aNMD2ogeipUrwoi/pZQ8TNe+9zxa77LNEzV7pq9TVN8OFt8
 6mD0Cs7CAiWmAGGYPNXNmSP6aIBmBMfvgkVXChqB3HEMY0SLzKm6qcvs+l0IK9w/Yn4X
 +wd1B7zKq8TWdpdKEOcB6vat/Qg+qB/ewi6daW8VxyRfuK0n0OfPxs/L0u3D5t1ottC+
 TP54e42PFYyImiizq+yVlNGTHvr4gfdp3ebm8mdrwPjuIce0HJgwtQfMjRFYijgQRKMQ
 NVTxan5GufBtATppEjH0YyEoYMLF3+8ARJa+sFgLoQxcsdLHY3fK0hyOCbVLCususJjv
 KDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2YSCBrV8N0F6AHWJ2u/uz6K3rNWDmD73VBl5nqd/Y1I=;
 b=napse8F68RYK7hc6PhSOI4WLed6COYOJozqYABqZ/CftM//f5ILARMvw715AgbgErs
 xYBAtYktxi7PJKFmYZg3Q2gYYA0UWFiIvmc+HrGJi8lR11hSXpRFLugfImQvlB0XwLCd
 jQGbG0V9qqSb4i5+AgvewWIhknCnzbzqwvrRuA7x8/WuBbF2vto+t9elbo+jqsRQRbb7
 qgsaRSs+gx3SWbx+cvw/Z+30i5Af2swWU7gedz5V/o2OnqEI7qqe70tvI9/fWtGn9arN
 70Ua0N3iz2lyn343f3mylRQos/Sq/jqdU33DhkYIKOc19+fPGIQvv+zrsTZsP30YThly
 IBYw==
X-Gm-Message-State: AOAM530Q3CsiAIGRgiYrxUYjxWmPdLju/rr6qSSS6djF7iJgOyh5dt9l
 +D+TS9Cy+RcYxapLKF7uDyCPQg==
X-Google-Smtp-Source: ABdhPJxKYnk2toG7EtnuV58t55tEGF1Wlv3L8g3kGSRgdFiSMBTg7vnaWXMHUKXhvamj64ANDIXFVw==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr3957982pgk.421.1603219800175; 
 Tue, 20 Oct 2020 11:50:00 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 9sm2970619pfx.138.2020.10.20.11.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 11:49:59 -0700 (PDT)
Subject: Re: [RFC PATCH 8/8] softfloat: implement addsub_floats128 using
 Uint128 and new style code
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201020163738.27700-1-alex.bennee@linaro.org>
 <20201020163738.27700-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c836b8eb-ea62-e88e-5f40-44ba6dace9b9@linaro.org>
Date: Tue, 20 Oct 2020 11:49:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020163738.27700-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, cota@braap.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 9:37 AM, Alex Bennée wrote:
> +static inline FloatParts128 unpack128_raw(FloatFmt fmt, Uint128 raw)
> +{
> +    const int sign_pos = fmt.frac_size + fmt.exp_size;
> +
> +    return (FloatParts128) {
> +        .cls = float_class_unclassified,
> +        .sign = extract128(raw, sign_pos, 1),
> +        .exp = extract128(raw, fmt.frac_size, fmt.exp_size),
> +        .frac = extract128(raw, 0, fmt.frac_size),
> +    };
> +}

This use of extract128 for sign and exp will not work for 32-bit.  You can't
just automatically truncate from __uint128_t to int in that case.

I don't think we should necessarily create this function, but rather leave it at

> +static inline FloatParts128 float128_unpack_raw(float128 f)
> +{
> +    return unpack128_raw(float128_params, uint128_make128(f.low, f.high));
> +}

... this one, and construct the FloatParts128 directly from the float128
components.  E.g.

    int f_size = float128_params.frac_size;
    int e_size = float128_params.exp_size;
    return (FloatParts128) {
       .sign = extract64(f.high, f_size + e_size - 64, 1);
       .exp = extract64(f.high, f_size - 64, e_size);
       .frac = extract128(int128_make128(f.low, f.high),
                          0, f_size);
    };

I don't want to over-generalize this just yet.


> +static inline Uint128 pack128_raw(FloatFmt fmt, FloatParts128 p)
> +{
> +    const int sign_pos = fmt.frac_size + fmt.exp_size;
> +    Uint128 ret = deposit128(p.frac, fmt.frac_size, fmt.exp_size, p.exp);
> +    return deposit128(ret, sign_pos, 1, p.sign);
> +}

Likewise, omit this and only have

> +static inline float128 float128_pack_raw(FloatParts128 p)
> +{
> +    Uint128 out = pack128_raw(float128_params, p);
> +    return make_float128(uint128_gethi(out), uint128_getlo(out));
> +}

this.


> +/* Almost exactly the same as sf_canonicalize except 128 bit */
> +static FloatParts128 sf128_canonicalize(FloatParts128 part, const FloatFmt *parm,
> +                                        float_status *status)

I think we may have reached the point of diminishing returns on structure
returns.  This is a 196-bit struct, and will not be passed in registers
anymore.  It might be better to do

static void sf128_canonicalize(FloatParts128 *part,
                               const FloatFmt *parm,
                               float_status *status)

and modify the FloatParts128 in place.

> +    bool frac_is_zero = uint128_eq(part.frac, uint128_zero());

With Int128, we'd use !int128_nz().

> +/* As above but wider */
> +static FloatParts128 round128_canonical(FloatParts128 p, float_status *s,
> +                                        const FloatFmt *parm)
> +{
> +    /* Do these by hand rather than widening the FloatFmt structure */
> +    const Uint128 frac_lsb = uint128_lshift(1, DECOMPOSED128_BINARY_POINT - parm->frac_size);

You can't pass constant 1 on 32-bit.
Maybe add a int128_makepow2(exp) function to make this easier?

> +        case float_round_nearest_even:
> +            overflow_norm = false;
> +            inc = ((frac & roundeven_mask) != frac_lsbm1 ? frac_lsbm1 : 0);

Can't use & or != on 32-bit.

> +            inc = frac & frac_lsb ? 0 : round_mask;
...
> +            if (frac & round_mask) {
...
> +                frac += inc;
> +                if (frac & DECOMPOSED128_OVERFLOW_BIT) {
> +                    frac >>= 1;
...
> +            frac >>= frac_shift;
...
> +                    frac = -1;
...
> +            if (frac & round_mask) {
> +                    inc = ((uint128_and(frac, roundeven_mask)) != frac_lsbm1
...
> +            if (exp == 0 && frac == 0) {
...
> +        frac = 0;
...
> +        frac = 0;

and more.  There are lots more later.

This is going to get ugly fast.  We need another solution.

> +static bool parts128_is_snan_frac(Uint128 frac, float_status *status)
> +{
> +    if (no_signaling_nans(status)) {
> +        return false;
> +    } else {
> +        bool msb = extract128(frac, DECOMPOSED128_BINARY_POINT - 1, 1);

Doesn't work for 32-bit.  Again, extract128 by itself is not the right
interface.  Do we in fact want to share code with the normal parts_is_snan_frac
by just passing in the high-part?


r~

