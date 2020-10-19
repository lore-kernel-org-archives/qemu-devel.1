Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D851C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCC72224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXG18mgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCC72224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQRf-0001sg-II
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUQFk-0008FZ-TA
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:10:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUQFi-0005vF-UG
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:10:48 -0400
Received: by mail-wr1-x443.google.com with SMTP id n6so10234096wrm.13
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PoWXh9v1OvrU3j9tJjkwr8P5Ro5FITLrLLIx/goB+Dg=;
 b=TXG18mgmSD2xEqtXmySn6P0UTdYN9WVLiXJNNCDCXmkJYqGzOO+Po74im0UjV3EJ2T
 v+qmNYKDmu2Qw9bEP8rwLtvemwfNWAgcrSZ4XeQY9V1/1a+gPDj+G4cVL9G0UyhHJOSc
 KDJBsdyIfedksYFU67LXuhe8xDjfS/rXaDeIdCqwtQ9BNo0F7E93uaJQmjE/jKR/Dave
 buC/h2tpvYScCmr2lrITMdhdXMUhCy3rgpMPcrby8yKCdfPAw0tYwoI30FMFFuzZWopy
 KUGkergeuq7PTr/WGOlgR/Fh748kF5KfpJjiDzZ9jE7XADJW8/rlTB5sIFXyxUFu1FEG
 kIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PoWXh9v1OvrU3j9tJjkwr8P5Ro5FITLrLLIx/goB+Dg=;
 b=DEmGBt9RZ3w0eSB9eCSasTMe6jLL7dDLzwdt94dR2w2hl50jVJjXWfWqr6T77cp+nk
 rlWXKHYADPnFy1XtJHNk1LSXdFGUT8Hzv5iOo7DK5HVM/dJ9VO/VJPgwMY3KQfGzmRBt
 jnBEZFkNOORM19soLcll7KgaSy989fkqN2czQcLKEa7y9YvOPqq0jDG0qZUSegyCTQi8
 sBZk6gwpaYPPaIex8uaT0AENbZa1mXERm87SV8eryfa4+JyZQSMHk+7FGot5PELPOawJ
 9Cz/f0OVxs+lLt/Nf7/RBnYSDb7mKrYsiJbASAfQkMQy3cHdbxPesIIF4JOE05VgvJnR
 SucA==
X-Gm-Message-State: AOAM531M2xH3PBEJipwWOI7HMumP6xaOfSVugWlhb7IzUi2W9sNoyAwV
 a8y+PVagRbIyGTGrG+FJR4M=
X-Google-Smtp-Source: ABdhPJznC6vDPusWBlQqB2MUhP8sizKkHTVU8nyGHphTyS3wxUCs3YX5bOEjCXhINWzVFXP+CHU2tw==
X-Received: by 2002:adf:e8c7:: with SMTP id k7mr18308456wrn.102.1603095044799; 
 Mon, 19 Oct 2020 01:10:44 -0700 (PDT)
Received: from [192.168.1.36] (36.red-83-57-175.dynamicip.rima-tde.net.
 [83.57.175.36])
 by smtp.gmail.com with ESMTPSA id p4sm17714604wrf.67.2020.10.19.01.10.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 01:10:44 -0700 (PDT)
Subject: Re: [PATCH] softfloat: Mark base int-to-float routines QEMU_FLATTEN
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201018203334.1229243-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <af6db3d8-ab71-23de-9e0e-180e790aa5f2@amsat.org>
Date: Mon, 19 Oct 2020 10:10:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201018203334.1229243-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Ahmed Karaman <ahmedkrmn@outlook.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/20 10:33 PM, Richard Henderson wrote:
> This merges the int_to_float routine and the round_pack_canonical
> routine into the same function, allowing the FloatParts structure
> to be decomposed by the compiler.
> 
> This results in a 60-75% speedup of the flattened function.
> 
> Leave the narrower integer inputs to tail-call the int64_t version.
> 

Reported-by: Ahmed Karaman <ahmedkrmn@outlook.com>

> Buglink: https://bugs.launchpad.net/qemu/+bug/1892081
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   fpu/softfloat.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 7b6aee9323..2cbcf5bf10 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -2794,7 +2794,8 @@ static FloatParts int_to_float(int64_t a, int scale, float_status *status)
>       return r;
>   }
>   
> -float16 int64_to_float16_scalbn(int64_t a, int scale, float_status *status)
> +float16 QEMU_FLATTEN
> +int64_to_float16_scalbn(int64_t a, int scale, float_status *status)
>   {
>       FloatParts pa = int_to_float(a, scale, status);
>       return float16_round_pack_canonical(pa, status);
> @@ -2830,7 +2831,8 @@ float16 int8_to_float16(int8_t a, float_status *status)
>       return int64_to_float16_scalbn(a, 0, status);
>   }
>   
> -float32 int64_to_float32_scalbn(int64_t a, int scale, float_status *status)
> +float32 QEMU_FLATTEN
> +int64_to_float32_scalbn(int64_t a, int scale, float_status *status)
>   {
>       FloatParts pa = int_to_float(a, scale, status);
>       return float32_round_pack_canonical(pa, status);
> @@ -2861,7 +2863,8 @@ float32 int16_to_float32(int16_t a, float_status *status)
>       return int64_to_float32_scalbn(a, 0, status);
>   }
>   
> -float64 int64_to_float64_scalbn(int64_t a, int scale, float_status *status)
> +float64 QEMU_FLATTEN
> +int64_to_float64_scalbn(int64_t a, int scale, float_status *status)
>   {
>       FloatParts pa = int_to_float(a, scale, status);
>       return float64_round_pack_canonical(pa, status);
> @@ -2897,7 +2900,8 @@ float64 int16_to_float64(int16_t a, float_status *status)
>    * to the bfloat16 format.
>    */
>   
> -bfloat16 int64_to_bfloat16_scalbn(int64_t a, int scale, float_status *status)
> +bfloat16 QEMU_FLATTEN
> +int64_to_bfloat16_scalbn(int64_t a, int scale, float_status *status)
>   {
>       FloatParts pa = int_to_float(a, scale, status);
>       return bfloat16_round_pack_canonical(pa, status);
> @@ -2959,7 +2963,8 @@ static FloatParts uint_to_float(uint64_t a, int scale, float_status *status)
>       return r;
>   }
>   
> -float16 uint64_to_float16_scalbn(uint64_t a, int scale, float_status *status)
> +float16 QEMU_FLATTEN
> +uint64_to_float16_scalbn(uint64_t a, int scale, float_status *status)
>   {
>       FloatParts pa = uint_to_float(a, scale, status);
>       return float16_round_pack_canonical(pa, status);
> @@ -2995,7 +3000,8 @@ float16 uint8_to_float16(uint8_t a, float_status *status)
>       return uint64_to_float16_scalbn(a, 0, status);
>   }
>   
> -float32 uint64_to_float32_scalbn(uint64_t a, int scale, float_status *status)
> +float32 QEMU_FLATTEN
> +uint64_to_float32_scalbn(uint64_t a, int scale, float_status *status)
>   {
>       FloatParts pa = uint_to_float(a, scale, status);
>       return float32_round_pack_canonical(pa, status);
> @@ -3026,7 +3032,8 @@ float32 uint16_to_float32(uint16_t a, float_status *status)
>       return uint64_to_float32_scalbn(a, 0, status);
>   }
>   
> -float64 uint64_to_float64_scalbn(uint64_t a, int scale, float_status *status)
> +float64 QEMU_FLATTEN
> +uint64_to_float64_scalbn(uint64_t a, int scale, float_status *status)
>   {
>       FloatParts pa = uint_to_float(a, scale, status);
>       return float64_round_pack_canonical(pa, status);
> @@ -3062,7 +3069,8 @@ float64 uint16_to_float64(uint16_t a, float_status *status)
>    * bfloat16 format.
>    */
>   
> -bfloat16 uint64_to_bfloat16_scalbn(uint64_t a, int scale, float_status *status)
> +bfloat16 QEMU_FLATTEN
> +uint64_to_bfloat16_scalbn(uint64_t a, int scale, float_status *status)
>   {
>       FloatParts pa = uint_to_float(a, scale, status);
>       return bfloat16_round_pack_canonical(pa, status);
> 


