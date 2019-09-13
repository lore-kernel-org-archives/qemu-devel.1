Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1DEC4CEC8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18F9206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wSvzMGwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18F9206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8q65-00083Y-L9
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 14:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8q54-0007Fo-7k
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8q53-0006po-3u
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:14:01 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:38353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8q52-0006oK-SE
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:14:01 -0400
Received: by mail-ed1-x542.google.com with SMTP id a23so25601061edv.5
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8uBuaXYFL4Cvm9iMwUlQx8ETWJTml2hU7suR2oueijY=;
 b=wSvzMGwNr1P4AgVyh+YwRukw3vwrAqnvAa+Fw5C8dT6DyvAxMadq/KaTl8nZDXaSeK
 I+xHZep8Gq2mc+BwKxI1IZJpQd64X5897OYR/Tv6cp4Gitjb4RBNQMIviMWmhmJuUCBX
 a4MwnClGDYqvP5OH47ZmqcbIWDi/RpPKJ650zyc3ETsge/vibM1ohrKIa7cDFcm/y07h
 QAOO2mh2Wqz0Xce0dPRrpqeFBwvaF/Mvm/7glHxy7FkbHvULxpq3HtcUv+ITwV2MCL8J
 t689LZN8ZgJ0MxrvpayO97OSi9uGaS1jmT/1WPVRnFm0hNmE5p1I7w0zTDUqc/mfzlKu
 MbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8uBuaXYFL4Cvm9iMwUlQx8ETWJTml2hU7suR2oueijY=;
 b=MEcumuqSVus1nCI6izMm1Z9OdqG1ZRKjiGn0zJYGs6xsNZt9bn+ADH6YKpUDNl8bf5
 QMrwfPgeUe7OUS6ZstfW5qbXwcvy3wPKYeX7xrE/VZbSfdI8s4CiGrUnocYGNXta0DTK
 QFF6AUpu4GkZ8APPxmjC6BBKIxTslWi604/YnohXtCBfN5z98mymQHcNHxleC2Ogjz3d
 +bnfPEL/HREovW65JEteTBEVeHNMV4c9lQbMdHicU/B97adlWdjC4l1uIQ5dRfIuuiYf
 yagRttgI3hjVzWy0AI56RzJmzf3t5MeWmBXJCQSzGWouzNRgaUYk/MCoho4dDcXT40fy
 W07A==
X-Gm-Message-State: APjAAAV/wYWvczWWNJRfQoVbvHrmN46lqg/W6pxvgu1Ai7DDv0J+bAzX
 HeQvriDDAobSV2kwzALHbQPJSw==
X-Google-Smtp-Source: APXvYqym1tEk1V3SEnCtmMVKD+VFbCc6n+9gA/YwAN6Ev7OlocmIDADLaVTClmx7erQ7B47uQSYkHg==
X-Received: by 2002:aa7:c1c7:: with SMTP id d7mr48924432edp.34.1568398438801; 
 Fri, 13 Sep 2019 11:13:58 -0700 (PDT)
Received: from [192.168.44.107] ([185.81.138.17])
 by smtp.gmail.com with ESMTPSA id s19sm3227811ejs.78.2019.09.13.11.13.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Sep 2019 11:13:58 -0700 (PDT)
To: Sven Schnelle <svens@stackframe.org>
References: <20190913101714.29019-1-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0b78ccdf-4c03-a60e-5884-a6833f6dde2b@linaro.org>
Date: Fri, 13 Sep 2019 14:13:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913101714.29019-1-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH 0/2] HPPA tcg fixes
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/19 6:17 AM, Sven Schnelle wrote:
> Sven Schnelle (2):
>   target/hppa: prevent trashing of temporary in trans_mtctl()
>   target/hppa: prevent trashing of temporary in do_depw_sar()
> 
>  target/hppa/translate.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Thanks, queued.


r~

