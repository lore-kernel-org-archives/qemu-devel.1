Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44095C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE0F2147A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWArM8Tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE0F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWSg-0000q6-9Y
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:22:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW7R-0000UY-B1
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW7P-0004q3-DM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:00:37 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLW7P-0004l5-7G
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:00:35 -0400
Received: by mail-pl1-x642.google.com with SMTP id d9so7015986pls.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=mPu49WOst7VeZvGvwGRvNDzY1W89nzmXBMCYmW4ZD1Y=;
	b=VWArM8TxhMbunf4ALbN4fYQ2+MwEeD5jCfKGtBNwxc9X4JpZD3oH480631fE1ig1hk
	gkUx+gRE5mCvfOvuMrC3H1c0cSkP8U1KFEKGZfALSp4LySfgzMWNsBlgGLTklDkNp1H6
	EYYKA9skW+ND505bWdk8gIiCTj8k5RLmixrck5CSNsKXDu67UXlhnkW17Y+a7h5EBy6x
	oZPrETECTxRnBZn5G3Y19cfCQ33UQSYQR2lIKO8HdMvYyw/qNTC04jskiVuFaf3NEOjV
	gynXJICwPHrdd/3+2NbmLeR1HLtG+DJEczcsTw+MwIupl643NqWbUcNBiADtyoSosLCQ
	7HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mPu49WOst7VeZvGvwGRvNDzY1W89nzmXBMCYmW4ZD1Y=;
	b=KGDhbU3P9BJcfBZh38ZuC2n0foS0fLCTiHvVuUcm7awYtOtv5tvxu9y5he0bnkd78f
	cXXBCARTCja3mR8HcrgHbJpmzMDOax26XZddtxLKdI8UWzXFYa/ERKQdzouMarXegAsG
	QQwEgdIg5KdaRmOnaROR8kZYv6val4D1JaXE4dwXt5lX0hqPcZim6FBgiGkSX64FM4wH
	pMZLZQDXxzzHkUPf8jzAHyfiEmnerOaQel4XeAJ6VlQKRRG7jrC5h+g2mGAOgO6h9HAU
	Zfe1kgsw1h9k1mfMQAVcO6UB8atZpiRXsWtuZ1DB8aRQvU7jxQ/+sVT/H1ymGrme6gOi
	fwHw==
X-Gm-Message-State: APjAAAVWaMzyBuuG3uImVILTD568TF6kb++qh9AtScppli6fktednna0
	DHIi091/qTGfycXL3ec2sGilmw==
X-Google-Smtp-Source: APXvYqxTHAOQdqvOVgfxDr62p35q0bD9mgYeWZryev9cKh4ngxOdE2XH+d1+Gjq6VaUa+eWM9Cb6iQ==
X-Received: by 2002:a17:902:2b88:: with SMTP id
	l8mr70369149plb.262.1556643622027; 
	Tue, 30 Apr 2019 10:00:22 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	x128sm62245272pfx.103.2019.04.30.10.00.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 10:00:21 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-15-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3c05b552-a692-e439-fc28-90ad69767cf2@linaro.org>
Date: Tue, 30 Apr 2019 10:00:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-15-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH 14/14] target/ppc: improve VSX_FMADD with
 new GEN_VSX_HELPER_VSX_MADD macro
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430170012.qFvrDAiKLEUqPjLlenmsmIeIJeHeJ1GW1M69PNzPstQ@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>  #define VSX_MADD(op, nels, tp, fld, maddflgs, afrm, sfprf, r2sp)              \
>  void helper_##op(CPUPPCState *env, uint32_t opcode,                           \
> -                 ppc_vsr_t *xt, ppc_vsr_t *xa, ppc_vsr_t *xb)                 \
> +                 ppc_vsr_t *xt, ppc_vsr_t *xa,                                \
> +                 ppc_vsr_t *b, ppc_vsr_t *c)                                  \
>  {                                                                             \
> -    ppc_vsr_t *b, *c;                                                         \
>      int i;                                                                    \
>                                                                                \
> -    if (afrm) { /* AxB + T */                                                 \
> -        b = xb;                                                               \
> -        c = xt;                                                               \
> -    } else { /* AxT + B */                                                    \
> -        b = xt;                                                               \
> -        c = xb;                                                               \
> -    }                                                                         \

The afrm argument is no longer used.
This also means that e.g.

VSX_MADD(xsmaddadp, 1, float64, VsrD(0), MADD_FLGS, 1, 1, 0)
VSX_MADD(xsmaddmdp, 1, float64, VsrD(0), MADD_FLGS, 0, 1, 0)

are redundant.  Similarly with all of the other pairs.


r~

