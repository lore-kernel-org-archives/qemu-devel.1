Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59B5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D90A20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1kNfx53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D90A20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaj6o-000557-ES
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaj3f-0000Pt-UJ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:56:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaj3f-0001lD-9F
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:56:07 -0400
Received: by mail-wr1-x442.google.com with SMTP id y3so12747151wrt.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kP5CpLK7roVxCfLoRGfkxLQzXkbWexOk3kGLUrfq3R4=;
 b=N1kNfx53/aPNen6ixHzakXzwTUFr8HE7sEM3nv8Ss8bWSsIPMaxZbH8qGGLyVQY04U
 /q9YMgtwbnmtSVrikFZZMSjrNt+L8x5dzBuCcxBprhc8AkhiSUUSEIvf71cB6dPtwnXj
 TTIhRr5UJeqYdO6uE47iitCNSLXOM1Kj2MHdy+KAp6daQpdVg7S1c4uV3eQr1nO4Xzib
 dqprdXZZvZ2j/065cue5/FfIQ/w7/TS9QUZ13aE+BOIq5QipjGQ+6sIwtEkZ7K7Qyhu3
 MQIk591wFbuq3V28OmPiQrQY6xbOY5nfYHljWfGrY9/xNIsqdnh7u36ssnaRfCsc+emM
 05jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kP5CpLK7roVxCfLoRGfkxLQzXkbWexOk3kGLUrfq3R4=;
 b=AfZj/R1dUL7pKkEsykWytUpzQ9sz2Z7dkFup9LsoJBgnek/xhA2nXHIoqorFtkUCHl
 wotEG38X6ZOEvIWLEeMCpu7a8y5hKB5Cu8PCq2s9y78ZAZApg2VV57JhNVyHedOBGyoO
 d5LctPM3aHplHzFMAlr1kw6gBKsIb56XeTwh2NmhudAERoO0dQ686oltF9Frqnpm38Fr
 N7qcGKfXUeTH7FcaRMnYlPWN5MklI5nVPF1zhvMFLofWhCh3BdFbwPBoXs3ZpAVJJbUP
 01kNAGx/aBsENzgWgBSg0w7jBv8zNgdXVkBO6YgKKvNurNX/MsnX8EFEo1TeSAs/zrgL
 CX5Q==
X-Gm-Message-State: AOAM532Sjn1qEQvbA/ix8mKuFoveHblU2Vw6Hy5r2dOeZg9ieJJr6jds
 WnVVNB0ngdNXk3417oi9B0c=
X-Google-Smtp-Source: ABdhPJz8VUp1ORsBLMpZG3v+MzhcxmkpxdhI/+CrNzkp2+I18k9/w/X1jOdMexTpEqLPc2c/D9KSgQ==
X-Received: by 2002:adf:f4c4:: with SMTP id h4mr21217577wrp.142.1589820965797; 
 Mon, 18 May 2020 09:56:05 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id e7sm18056924wrp.0.2020.05.18.09.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 09:56:04 -0700 (PDT)
Subject: Re: [PATCH 8/8] target/arm: Use a non-overlapping group for misc
 control
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200518164052.18689-1-richard.henderson@linaro.org>
 <20200518164052.18689-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4a578b8c-bfcc-59ac-fc0a-af5947e0c114@amsat.org>
Date: Mon, 18 May 2020 18:56:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518164052.18689-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 6:40 PM, Richard Henderson wrote:
> This sub-group in the t32 deocode are mutually exclusive.

"The miscellaneous control instructions are mutually exclusive within 
the t32 decode sub-group."?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/t32.decode | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/t32.decode b/target/arm/t32.decode
> index c63082fc9c..c21a988f97 100644
> --- a/target/arm/t32.decode
> +++ b/target/arm/t32.decode
> @@ -312,13 +312,13 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
>                    &cps
>   
>       # Miscellaneous control
> -    {
> +    [
>         CLREX      1111 0011 1011 1111 1000 1111 0010 1111
>         DSB        1111 0011 1011 1111 1000 1111 0100 ----
>         DMB        1111 0011 1011 1111 1000 1111 0101 ----
>         ISB        1111 0011 1011 1111 1000 1111 0110 ----
>         SB         1111 0011 1011 1111 1000 1111 0111 0000
> -    }
> +    ]
>   
>       # Note that the v7m insn overlaps both the normal and banked insn.
>       {
> 

