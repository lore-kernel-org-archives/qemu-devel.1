Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEC2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FDB6206F4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 05:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RELAjeq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDB6206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZpNE-000239-D7
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 01:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZpMh-0001Y9-Cy
 for qemu-devel@nongnu.org; Sat, 16 May 2020 01:28:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jZpMg-0000UT-Ku
 for qemu-devel@nongnu.org; Sat, 16 May 2020 01:28:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so5823707wru.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 22:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TeKbUgDg/e1ToNP4FPnBIdX4bzto6nC8SGmfLuO+VqI=;
 b=RELAjeq3vczdYJxCEe7WvZ57R9EHzJgfrkKLRzbJRgSiGKc2wg9m67jKwWn+Zp8Y+V
 aiU0ZlxhClotcC16WAM6g1p2dsBoRhuXapd1F1PgGupIo0qWtdrf46qvxikBowuNUa4Q
 Jy5e4migMaxv28n31Lfib3QRou/FR14qgUwVuwofYsfd8XgegdLdl7NfkhBhsZZmrSl7
 xkArzxc68aGZpgiqcSCWZgMD9XSwn2b2k5nL5+vVqPtIns5pUhvUip2MO7uPRnR7nTIR
 fKD3cqXXXbs8bJxtp41ReBvlFm/MxYpzjieGMSi9KSgAo8Xh2LaWY4IVDhSEs2K3x3Uh
 Xw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TeKbUgDg/e1ToNP4FPnBIdX4bzto6nC8SGmfLuO+VqI=;
 b=Pqnef7R8Uw0S7SVThO064nVF9Iad3szpcltDwdADEXdSgGxbylgh+4Qbdat/08qSC8
 Cm0VaiL7XDDlVIjnjtIbsEXzeuE2iRGWDu5YAv6fwmin4jlCyWE8meR83knZTewqzXre
 zTSVGbG+VvW1MwY/v5P/lm2RR/pBuJ2PB2SE++OmyToJnkVs1PVs9WUb6GrXD0G/fx+R
 736moEhTD7p8V7jy3OFIwaiAmuwzN7dlLhnWoBJErqPzw1Af9OPPPSEvgqG5ZSlQoBqq
 k05p5nvgIycnjvVuj4zxVc5V5EeTyrPlxivwKC3tRM4+TNZuKmJLGUoV4hCDwDuHF4Xq
 YNWA==
X-Gm-Message-State: AOAM531Aciox+NvKXmxEHIZURtM6SFKI0eEm/tG6/Iq0qvWs0uG7V/w2
 dcmXVurytdW5OGBuz5ILHCU=
X-Google-Smtp-Source: ABdhPJy9iM/gff0Xcf1KBH9Auxc76ef9vkVDzzZT9C9UVSz7J6BAXqepyK7XVpbiOCeA4cueYqTpaw==
X-Received: by 2002:adf:fa4d:: with SMTP id y13mr8159175wrr.263.1589606881114; 
 Fri, 15 May 2020 22:28:01 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id g10sm6257834wrx.4.2020.05.15.22.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 22:27:59 -0700 (PDT)
Subject: Re: [PATCH 02/10] softfloat: Replace flag with bool
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e29e3512-efc9-bedc-f68c-1f2978581f37@amsat.org>
Date: Sat, 16 May 2020 07:27:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200515190153.6017-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
> We have had this on the to-do list for quite some time.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-helpers.h |  14 +--
>   include/fpu/softfloat-macros.h  |  24 ++--
>   include/fpu/softfloat-types.h   |  14 +--
>   include/fpu/softfloat.h         |  10 +-
>   fpu/softfloat-specialize.inc.c  |  16 +--
>   fpu/softfloat.c                 | 190 ++++++++++++++++----------------
>   target/arm/sve_helper.c         |   8 +-
>   target/arm/vfp_helper.c         |   8 +-
>   target/m68k/softfloat.c         |  70 ++++++------
>   target/mips/msa_helper.c        |  10 +-
>   10 files changed, 174 insertions(+), 190 deletions(-)
> 
[...]
> diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
> index 2aae6a89b1..619b875df6 100644
> --- a/include/fpu/softfloat-types.h
> +++ b/include/fpu/softfloat-types.h
> @@ -80,12 +80,6 @@ this code that are retained.
>   #ifndef SOFTFLOAT_TYPES_H
>   #define SOFTFLOAT_TYPES_H
>   
> -/* This 'flag' type must be able to hold at least 0 and 1. It should
> - * probably be replaced with 'bool' but the uses would need to be audited
> - * to check that they weren't accidentally relying on it being a larger type.
> - */
> -typedef uint8_t flag;

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> -
>   /*
>    * Software IEC/IEEE floating-point types.
>    */
> @@ -169,12 +163,12 @@ typedef struct float_status {
>       uint8_t     float_exception_flags;
>       signed char floatx80_rounding_precision;
>       /* should denormalised results go to zero and set the inexact flag? */
> -    flag flush_to_zero;
> +    bool flush_to_zero;
>       /* should denormalised inputs go to zero and set the input_denormal flag? */
> -    flag flush_inputs_to_zero;
> -    flag default_nan_mode;
> +    bool flush_inputs_to_zero;
> +    bool default_nan_mode;
>       /* not always used -- see snan_bit_is_one() in softfloat-specialize.h */
> -    flag snan_bit_is_one;
> +    bool snan_bit_is_one;
>   } float_status;
>   
>   #endif /* SOFTFLOAT_TYPES_H */
[...]

