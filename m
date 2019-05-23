Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0987C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B88121019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3Udg79c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B88121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41647 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTsTt-0006nV-Gs
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 14:30:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTsSz-0006W2-0l
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTsSy-0000Us-61
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:29:25 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e]:43514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTsSy-0000US-00
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:29:24 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id n145so2629566ybg.10
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=L1P7C7xAjbopvHcMFOt+2AdGEpBt5a7dLCwDpO90VKU=;
	b=o3Udg79cvELc1fyrn2OjTz7wcxX8hN4Ou8C7762LGqkB+jj7dtct1eqq1GhS7uroLO
	0kI3yT2x62cw0jcS8RqSvI1tI8PYKOAwfxIamVmEEU0TVj4TuRcK+KJFb1sg949d4pwW
	rC4Ij93MUe+rUyBDqQSMK+Bkygne3Ib7u37M8oRKIPXgChrvlry+UyPOCRSmnFDI5fhH
	yz/vU0p6YSXIuxjQrZifuDLH0X3lHA9NiPTjqTFLOhPw3Ofc7ShrGxSF+mPYKghyTUN6
	gw2Wz41iuBNXsutAiCnFPM/T0MK1h1sxMIcc++ps/zSvYUtzvVZqkBt69JHe2dMmrlYL
	aULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=L1P7C7xAjbopvHcMFOt+2AdGEpBt5a7dLCwDpO90VKU=;
	b=bVn/mBnkGQyRaerPBa7qb/Zn02h1OwXfh2IHBSZHqtI2+Ql36vA/aX1YxZW4qOw9+h
	Wm/5iNii/6o1kKWyFkSq+LTmjFFI0d2chtyAn6KfWSZIA4clp5EJnRmTgaZEyzXf/j0d
	zkJJKMj6L8PYryA/Y+UKUGySYtvED9k8mI3nVeInwbq/y4P/z2pAd6L/aask+w9xYnfw
	aJiBQ5uaKznUn2rJS/usHsmSH0+rIzOdyE1B4FrSjofEplRX/pRuHap43twlcdO/+8lK
	ct56zYvP8fVdr4hD9uSrHUiY2pGuClcrQ4r7sVDWuMJeKsrBaljTfDNJsGciDeecEKmC
	CbZw==
X-Gm-Message-State: APjAAAVDHdoPKJecjOlZmHikKIBScWyMMVoeuutjEX+0Pn8g+Ywhs2Hz
	TS7Xc1iViRrwOYqLEvdhLODRccShr/U=
X-Google-Smtp-Source: APXvYqzBvNW7lhvcOdQ9kAuTC3FPpCRaUCs7S73zpkKZJIMSPQNYpd9wT2UCu02yinNlQo/ledOK0Q==
X-Received: by 2002:a25:e04f:: with SMTP id x76mr23060152ybg.471.1558636162807;
	Thu, 23 May 2019 11:29:22 -0700 (PDT)
Received: from [10.241.6.101] ([71.46.56.12])
	by smtp.gmail.com with ESMTPSA id y18sm6932ywa.48.2019.05.23.11.29.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 11:29:21 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
	<alex.bennee@linaro.org>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<87v9y5gvfq.fsf@zen.linaroharston>
	<233da7c2-baed-face-16e8-af7a06d642c5@gmail.com>
	<0d863686-435b-e3f6-e358-926591bbd7d3@linaro.org>
	<3e9ec904-62f4-1886-7d33-1903e795adf0@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1959ed20-6460-c5d2-e487-f33c1df50167@linaro.org>
Date: Thu, 23 May 2019 14:29:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3e9ec904-62f4-1886-7d33-1903e795adf0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b2e
Subject: Re: [Qemu-devel] [RISU v2 00/11] Support for i386/x86_64 with
 vector extensions
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 2:03 PM, Jan Bobek wrote:
> I ran some experiments on my laptop's Intel(R) Core(TM) i5-4210U to
> find out what actually happens. This CPU supports AVX (but not
> AVX-512) and doesn't support XSAVEC, so I only looked at XSAVE and
> XSAVEOPT (XSAVES is kernel-mode only). I found out that:
> 
> 1. both XSAVE and XSAVEOPT do not include the AVX state if it is in
>    the initial configuration (not only XSAVEOPT),
> 2. return to initial configuration is not detected, i.e. the AVX state
>    is included even though it has been set to all zeros via vxorps,
> 3. the AVX state can be brought back to the initial configuration via
>    XRSTOR with the AVX component removed.

Thanks, for doing the tests.  I'm glad what I understood from my reading
matches experimental results.  :-)


r~

