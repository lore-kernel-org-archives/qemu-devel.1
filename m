Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C4C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F4139206F4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrALG24x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F4139206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZpQE-0003eS-8a
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 01:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZpPZ-00039r-Ax
 for qemu-devel@nongnu.org; Sat, 16 May 2020 01:31:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZpPX-0000rp-W6
 for qemu-devel@nongnu.org; Sat, 16 May 2020 01:31:01 -0400
Received: by mail-wm1-x342.google.com with SMTP id m12so4205429wmc.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 22:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J5EbXzwd2hfU39x+PRIB6Qpav55VbEdPRUJ0holWlJo=;
 b=lrALG24xmCZ8zSNpqizYBq+IPWYOf7swFkU8tVvZ+7vXnrMSK4MgUbUt4FlpK/244S
 5FZgs6X8L1m6vP6FE/OBtlXyv2d8XPDAXyBQ3Rh6EbkqF9sAtmN4y4PCMP/iJsVlNIgd
 kRrTvA2xVp/Pso1yHDEcuwM2VfOOACWD3P6otJyQph4LK1ElRjeEWWcBKWizcrEu243e
 g9WGu2D4GjRbXVygfwqwBYT7XRqSs5VJPlT37CY8RCCcycHpi/XrXlXCRrJ/yHdfADqr
 D2RM5oDk1UGGjxiZPVRXnvOBtVNf8uPOyqsmNaO5CNTCLhRTX6SExm+DXIQsU/V1pQw+
 P78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J5EbXzwd2hfU39x+PRIB6Qpav55VbEdPRUJ0holWlJo=;
 b=j5Yc9WzgXzYaGjO7zrNoZeiKDmfrHWBwLo2W7ZsLAGj+Ggc+E2WkBd+Q8yIt51KAli
 zrpQL8KUWVZzs2hiIi/rQmjVejZRMSwJ9bKjto3bFRAhS6G54tXdFgA0xpTmqOtTjpno
 wOzwILWf8kEjP+Up6G53oySD97Peru3MunICzw0ufy0UKQ8BEzrteNMwGR6Udcp9mPOP
 eXxjRH0vVPHwZGWv7AnF875wPaZYYrWZKWCxY/03yZHKLuhC+jZCdXngIoU1/Mp2TUEK
 XSvnwLLNARbgj1AAhpfF26F6QJyz5M+pumdwx5y7sKoXego/gE+cy0abQIUvGpaad6B2
 apyg==
X-Gm-Message-State: AOAM5305ubwmSypjA8Ql5X/oPmqSSxs5UTbkS0sX8uqJygH9xDvCBNql
 iZJW2ptNkLv6WME+JobII9E=
X-Google-Smtp-Source: ABdhPJx+XsApgWA2Z0aHUzdzMhY7hxEl2gt6z1iV8oTQ329ijarIt6boc4S+C62JS2ocxy/T0yIaWQ==
X-Received: by 2002:a1c:e4c1:: with SMTP id b184mr7785833wmh.4.1589607057900; 
 Fri, 15 May 2020 22:30:57 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id w15sm6386051wrl.73.2020.05.15.22.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 22:30:57 -0700 (PDT)
Subject: Re: [PATCH 04/10] softfloat: Name rounding mode enum
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <36cab9e3-906e-8579-3867-73768dff1e79@amsat.org>
Date: Sat, 16 May 2020 07:30:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200515190153.6017-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 9:01 PM, Richard Henderson wrote:
> Give the previously unnamed enum a typedef name.  Use the packed
> attribute so that we do not affect the layout of the float_status
> struct.  Use it in the prototypes of relevant functions.
> 
> Adjust switch statements as necessary to avoid compiler warnings.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h |  5 +--
>   include/fpu/softfloat-types.h   |  6 ++--
>   include/fpu/softfloat.h         | 39 +++++++++++-----------
>   fpu/softfloat.c                 | 57 ++++++++++++++++++++-------------
>   target/arm/vfp_helper.c         |  4 +--
>   target/m68k/fpu_helper.c        |  6 ++--
>   6 files changed, 66 insertions(+), 51 deletions(-)
> 
> diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
> index 40d32a6d5d..735ed6b653 100644
> --- a/include/fpu/softfloat-helpers.h
> +++ b/include/fpu/softfloat-helpers.h
> @@ -58,7 +58,8 @@ static inline void set_float_detect_tininess(bool val, float_status *status)
>       status->tininess_before_rounding = val;
>   }
>   
> -static inline void set_float_rounding_mode(int val, float_status *status)
> +static inline void set_float_rounding_mode(FloatRoundMode val,
> +                                           float_status *status)
>   {
>       status->float_rounding_mode = val;
>   }
> @@ -99,7 +100,7 @@ static inline bool get_float_detect_tininess(float_status *status)
>       return status->tininess_before_rounding;
>   }
>   
> -static inline int get_float_rounding_mode(float_status *status)
> +static inline FloatRoundMode get_float_rounding_mode(float_status *status)
>   {
>       return status->float_rounding_mode;
>   }
> diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
> index 874ddd9f93..7680193ebc 100644
> --- a/include/fpu/softfloat-types.h
> +++ b/include/fpu/softfloat-types.h
> @@ -123,7 +123,7 @@ typedef struct {
>    *Software IEC/IEEE floating-point rounding mode.
>    */
>   
> -enum {
> +typedef enum __attribute__((__packed__)) {
>       float_round_nearest_even = 0,
>       float_round_down         = 1,
>       float_round_up           = 2,
> @@ -131,7 +131,7 @@ enum {
>       float_round_ties_away    = 4,
>       /* Not an IEEE rounding mode: round to the closest odd mantissa value */
>       float_round_to_odd       = 5,
> -};
> +} FloatRoundMode;
[...]

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

