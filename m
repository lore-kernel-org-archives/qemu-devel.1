Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FCEC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB8220E65
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNqzmBNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB8220E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTT1s-0004zU-Oj
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTT12-0004OM-Ix
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:55:40 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTT10-0005DB-AT
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:55:40 -0400
Received: by mail-pl1-x641.google.com with SMTP id w21so1603625plq.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fY0Kp6p80zDYDtbJNpys020qphxRq0E75+RNkPAIz8E=;
 b=kNqzmBNUM0+rWldksStOdquY4D4Fl54ZYkq/ZzW70Rs9wcYUWtHQTkTmYbmsHOqZic
 ztJgcfnWMI3BcFErJBBXHkJomqKkgzTWamogeoD979766+UJr78IqCVZ/dsQg/3k7321
 Y6rWjmh9Xrn6+7OoH0EIQTRu7sQd9ADue42mPh1niKESAQK1jhtGYMmaCij1hvT59xOH
 UToIAYBgtM9/z7w9lD5Nzkhf4cifjBJqxr/XOFmcEIbbJUoj3JS3mg6Kfi3qfFwai098
 hvou157DX8Ic2e8CkzNjlJV/d0Nxlx2+yMbBx4bW08wHIN/mfKH1wycd3rqCfZfRmijX
 GKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fY0Kp6p80zDYDtbJNpys020qphxRq0E75+RNkPAIz8E=;
 b=I1CHfxcS+k84ukJkuk3g/noJOryoxTe0MdzQtmhoBgLoQuJw78zKtdP7wqoQBC1U4E
 Us7xQ1WrItTJ/EkVs9x2evCcXJvXQ6Nz7Tvlk1QqenFAdkljOGBzB4bhtUjO8nqKN+e6
 wKqaX58gMy9WQvWf/Ggwap1tH8SH9F5tCGzWuccjBUQu24O9Ik3ybHhlAJY0LNUlDdPH
 JgZcHvmbCUVkE3Vh/NSjQwfTO1FlGlQc7OiKCd4zkirijKw3D5hhK6qUhsWGhgfnCEUn
 1a7bZiypzRV47USIxQ7ptTjizbk75QyUGCH0dCbaORj9e2k6k10T0Hva/O0RX38uQwE7
 NUZg==
X-Gm-Message-State: AOAM53195qrgEeGhYRuU4i3f6D4AtBqx2z7peuUKpmFP8JmMXcc3SzwZ
 FeJVr3Vk+kZGgUBb2ky6HeYTcw==
X-Google-Smtp-Source: ABdhPJyCkDVI9lS6oSCbTjA5UypEo2XT6rIEx8gxD1JmeDZ1JhwIOhOCZYE8TROajTTRWcWdN1i5Bg==
X-Received: by 2002:a17:90a:bb0e:: with SMTP id
 u14mr4910678pjr.112.1602867335671; 
 Fri, 16 Oct 2020 09:55:35 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z25sm3402238pgl.6.2020.10.16.09.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 09:55:34 -0700 (PDT)
Subject: Re: [PATCH v2 06/10] softfloat: Implement float128_muladd
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200925152047.709901-1-richard.henderson@linaro.org>
 <20200925152047.709901-7-richard.henderson@linaro.org>
 <87tuuuuo7d.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b0625633-f8aa-a3b3-706e-74757bb215e8@linaro.org>
Date: Fri, 16 Oct 2020 09:55:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87tuuuuo7d.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
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

On 10/16/20 9:31 AM, Alex Bennée wrote:
>> +static void float128_unpack(FloatParts128 *p, float128 a, float_status *status)
>> +{
>> +    p->sign = extractFloat128Sign(a);
>> +    p->exp = extractFloat128Exp(a);
>> +    p->frac0 = extractFloat128Frac0(a);
>> +    p->frac1 = extractFloat128Frac1(a);
> 
> Here we are deviating from the exiting style, it would be nice if we
> could separate the raw unpack and have something like:
> 
> static const FloatFmt float128_params = {
>     FLOAT_PARAMS(15, 112)
> }
> 
> static inline FloatParts128 unpack128_raw(FloatFmt fmt, uint128_t raw)
> {
>     const int sign_pos = fmt.frac_size + fmt.exp_size;
> 
>     return (FloatParts128) {
>         .cls = float_class_unclassified,
>         .sign = extract128(raw, sign_pos, 1),
>         .exp = extract128(raw, fmt.frac_size, fmt.exp_size),
>         .frac1 = extract128_lo(raw, 0, fmt.frac_size),
>         .frac2 = extract128_hi(raw, 0, fmt.frac_size),
>     };
> }
> 
> So even if we end up duplicating a chunk of the code the form will be
> similar so when we side-by-side the logic we can see it works the same
> way.

I suppose, but unlike the smaller fp formats, we won't be able to reuse this.
Even if we pull in the x86 80-bit format and the m68k 96-bit format, there are
a number of fundamental differences.  E.g. the implicit bit

>> +        /* Add the implicit bit. */
>> +        p->frac0 |= UINT64_C(0x0001000000000000);

is not present in the x86 and m68k formats.

Finally, I'm continuing to use the existing Berkeley packing logic.  Which a
bit persnickety with where that implicit bit goes.  Our smaller formats put the
implicit bit at bit 62.


r~

