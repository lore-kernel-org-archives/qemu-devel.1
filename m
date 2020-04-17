Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BDEC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 23:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51DB2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 23:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyXtWAMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51DB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPatO-0001ho-W1
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 19:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPasZ-0001Ay-87
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 19:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPasY-0008An-0I
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 19:58:38 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPasX-000893-O8
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 19:58:37 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ng8so1762361pjb.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 16:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1+biJZoyR++xcwwn8CiTnOCnMfA6edDBOOVD4wdp7Zk=;
 b=KyXtWAMzfb6S3M+N0BCt8ZcTa+yrzzHcuUzUMnQH8Xe2k45RsE2CZCr9vL5U3pRWL7
 5qyByvY0V524bR+PXdYXEPR3ICzeT/aXGR3p0WtJK86dj3Kvfm4ub+NrgwYauRDrSPXI
 WReqjMJJJ3JT/wiwk7/XHGTn5JUC2z3oYLNiXBsDcrdEIUu7bBt6+Z62h4AWLxm9FP8F
 INI/a7dcs94Zi3L7r4YLfeuiXI908vB7btBlt42p97GZxV1nUnLqlf64L9rnNQZ4WZI2
 BRE6sPeDAruy10GRna+kb6rCbJ8QWDVryT8A1Pwx9GONICAWsYtWQmH70erLos6XlGBk
 TS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1+biJZoyR++xcwwn8CiTnOCnMfA6edDBOOVD4wdp7Zk=;
 b=S7HLOPRkf6we2ehmor6ohvDvL8S88IfdQcjgCruRsv+mctjoTp0Pp0s+QLfYBxJ7FZ
 z/4r0DkivPFifowPYfc2XxN+lLbI3Xxr4n+LSuGDYUYpPxQsYd+dE30FFV9aWvyzJoh1
 wZ5UHyotmHJAeF8LBw+budZwqWkhsItgohMI7x4njuT7gJ84Og96XAsmhb3emH8aEFxe
 mREUU3u0H+xMg1UlPItfERJOjn7goIIEWINmi8QAS3+KomLFiu2xZA942PkqYmvBfQ0F
 eGLd4mdsI/hn9DOUMeSV/Vpmrig29CeYtCOBTsG0BYU5pAb/4KO0x5eOYrnNIZLpAyZO
 8Awg==
X-Gm-Message-State: AGi0PuaS/0UJ8STaGbOcZXHA04ahb6LvGHDvlNep8sTgfQkkjt6LANmX
 4eRHZLA8bAwdTcFSf6Dhz0ETSw==
X-Google-Smtp-Source: APiQypJfdHyWbpLhso4k0TzYcGTyZuzmxfsSqmcRHp/9NrqzNTbzz9nqoLyj0Ljw2nCa58GXKC0EiA==
X-Received: by 2002:a17:90a:3781:: with SMTP id
 v1mr4838285pjb.83.1587167916310; 
 Fri, 17 Apr 2020 16:58:36 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id p8sm6797085pjd.10.2020.04.17.16.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 16:58:35 -0700 (PDT)
Subject: Re: [PATCH 2/4] target/arm: Implement SVE2 RADDHNB, RADDHNT
From: Richard Henderson <richard.henderson@linaro.org>
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200417162231.10374-1-steplong@quicinc.com>
 <20200417162231.10374-3-steplong@quicinc.com>
 <7593864c-828f-5c03-c3d5-8ba8eab8cd6a@linaro.org>
Message-ID: <d2c568ef-c87a-3300-17dc-cccf83c8f12f@linaro.org>
Date: Fri, 17 Apr 2020 16:58:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7593864c-828f-5c03-c3d5-8ba8eab8cd6a@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/17/20 2:24 PM, Richard Henderson wrote:
> On 4/17/20 9:22 AM, Stephen Long wrote:
>> +#define DO_RADDHN(N, M, SH) ((N + M + (1 << (SH - 1))) >> SH)
> 
> This formula will overflow.  See DO_RSHR -- with some added parenthesis, we
> could actually reuse that macro.

My bad.  While it does overflow, all of these operations are truncating not
saturating, and moreover truncate to halfesize bits.  Therefore overflow
doesn't matter.


r~

