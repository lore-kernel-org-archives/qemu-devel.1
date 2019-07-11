Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA15C74A4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C386208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 09:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJF2xOJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C386208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlVTc-00077B-NI
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 05:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hlVSv-0006gz-AM
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hlVSu-0006PE-Au
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:34:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hlVSu-0006Nn-4C
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 05:34:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id v19so4983378wmj.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NbCv3xeLcLIU7KIztu3hH9p6DXa8jBZ+bQ7id5ZKNUY=;
 b=FJF2xOJEt7sIv1Jr7pEfwo5/xdt5EoHL4APE/5KtIB9X4Op7a79qL3Z5othwHaJOrt
 SOGNgyWcHR2m4yg4H076AkaLykS5zYyzUe9h4eztldRa7BGT1Rmrp9zBsm+v8+kddm7j
 IkmT2vb7c/CymxpQz1cbd8tvoCUp0Y2NcRxF/MdeJoJEDPaIEBZ5DFqICCIY+x51Khxd
 O4YEPJ9btaeJmqQLWalUc1z8rpBsCsxYxl1GDzUAcHU1HaYD1F330Dzkdbg/Z8zM38Kv
 A9mD3qsL903iDIqDAPfMkcLfm/5Ygp4/kpwrCGxLOoLlFIBdP9nJ1eBMGxqL/apZ+rZf
 YLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NbCv3xeLcLIU7KIztu3hH9p6DXa8jBZ+bQ7id5ZKNUY=;
 b=ZImK+Z+l0AOps2GAqdrHRlY8CARSv0hfsAiWQMG02LTeL9HT7Jg7NuuPq4DIF2weTY
 P4tTVW+IjVLKD7R/mDY2eJEs4/3h5IhHpcme1mvSfDX//fl7Ak7qfj7Wj+mOpfcjAIcZ
 dQYxsQeOY9yBPgenIMkQWQnfAdNCcUg2i4r7L7wzC9kOpxEHruyYy3RVR9F6GZI8XhoY
 jmev2jO00bzem5p8pJhlN7095hoR/S2DH1DQR2KMcRZSaizIBHipXzb+/y1CcYUnntSr
 gYXKpWSdIsd6kpxOfWXAas0q5sMqDg/v1U7/cZMghNC48m6LSeCOHIUfRxNSgukl4tuo
 sjtQ==
X-Gm-Message-State: APjAAAVM/Nwdevc0iyXFDz6PTAfXDSRZ1GxICxd47q/l25QzuU3Gvyao
 E3wvb6+B6/QDbpwaGT3pLBMvaA==
X-Google-Smtp-Source: APXvYqwIQY+WwlYEXtbfiYdRUqKgAJu7/tiixhXjCA6M/rxSVoRoABi7bZEmUxL1aI2X3IoHYmhrPA==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr3327629wma.164.1562837650703; 
 Thu, 11 Jul 2019 02:34:10 -0700 (PDT)
Received: from [172.16.96.70] (mob-31-157-172-216.net.vodafone.it.
 [31.157.172.216])
 by smtp.gmail.com with ESMTPSA id y18sm4843114wmi.23.2019.07.11.02.34.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 02:34:10 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190701043536.26019-1-jan.bobek@gmail.com>
 <20190701043536.26019-7-jan.bobek@gmail.com>
 <f1b0ff64-0c62-f1b0-8362-539d9d37156c@linaro.org>
 <53d71ce2-54da-b118-c5b9-c49216d13d51@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e2947ad4-3668-0d23-1374-4101ebad6c9d@linaro.org>
Date: Thu, 11 Jul 2019 11:34:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <53d71ce2-54da-b118-c5b9-c49216d13d51@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RISU RFC PATCH v2 06/14] x86.risu: add MMX
 instructions
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/19 8:32 PM, Jan Bobek wrote:
> On 7/3/19 5:49 PM, Richard Henderson wrote:
>> On 7/1/19 6:35 AM, Jan Bobek wrote:
>>> +MOVQ            MMX     00001111 011 d 1110 !emit { rex(w => 1); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
>>> +MOVQ_mem        MMX     00001111 011 d 1110 !emit { rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
>>
>> Oh, note that there are only 8 mmx registers, so the respective rex.{r,b} bit
>> can't be set.
> 
> Actually, my CPU chewed it without choking even when the bits were
> set, but it will taken care of in v3.

That's interesting data.

I wonder if it's worth retaining this as a feature in order to check qemu's
implementation?


r~

