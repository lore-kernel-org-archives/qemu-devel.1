Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C10C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BE120692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RtVp6JXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BE120692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipINu-0006w7-Se
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipING-0006PO-D9
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipINF-0003Dv-6h
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:56:18 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53365)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipINE-0003Cd-Sy
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:56:17 -0500
Received: by mail-pj1-x1042.google.com with SMTP id n96so140209pjc.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 12:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6hfQ6QjSecE60n39hqzELtrIPfsof/FMBjfNf6LJx/Y=;
 b=RtVp6JXCKgXUnSH48Y6CStQFWfjL5CTsvKce4nUyHXMlHbw2WybNvnHnZbxAE/KrA8
 eUcCWR8ur+weyLNLpDetbQgJBmtc0Gk6aBOqzC3bsLc1INYdve5WcAHTYLws1FRbJ9Af
 FwNdjNcqhjOoHsR3gdTpdTDKb7oAkFNLTdJzWyQH4V+HD0IHi/UyP86wN1y3H2zDqkaW
 vm8SMjslaS+y7DJKiwKoSEJzsP3+F9UDovuQeRNYlpeDTkj1Y7HO+sSbU/PMyLxz0Ktt
 clQHDKeRQOsAaf0vlkbeuVe88JWSPmmm2Eswy0KPd7V5GDbZ7FhtpNllIPTi82W+Zanx
 a0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6hfQ6QjSecE60n39hqzELtrIPfsof/FMBjfNf6LJx/Y=;
 b=KRGgvO5lUr4N5dNdJlIj6IcaB52g5XQ9+CgAKvhOtcsopSMMx6gVQqgEkQi30vWm3g
 zvoR8EaRZ0xgpl/0uqLPg1akOcZH/W0gEIb5MzAeCuzY+Hem7eISolOHENoDaLB+WXQX
 /ece459zTI3dZ0DtIjiCGnSRNRCJUcsqEcOia2GJxi4e7TbavfJ1aIhAIeyzcdSWxgZq
 pBZ29uxE6s2I4sPxuOGTMLsvYmowS6XYPyfHkUKg7pLtf5CZGvCOUAd4by6JSqjRA22H
 BovuctCWJ2Qcnt7ilkyKGdXH9PAzZ9tOvGP2wcHgJBbh9w44SfmVVgUHr3s+UatzkagA
 hg+w==
X-Gm-Message-State: APjAAAWaiE4E02J/dU4JJrWdNJjlty5wL7mUvR7wXsT2hEsTXKjV3RiH
 xsnTv/yXUjH1BELt4typs0nbwQ==
X-Google-Smtp-Source: APXvYqzmhb1PH6IuKw7NwlzbcOPM3EXIWfJ1044jxyUv2fRt+8hfDWkpmEpLHcaeGvACQMAhI0hoyQ==
X-Received: by 2002:a17:90a:fb87:: with SMTP id
 cp7mr668601pjb.56.1578516975796; 
 Wed, 08 Jan 2020 12:56:15 -0800 (PST)
Received: from [192.168.15.12] (alanje.lnk.telstra.net. [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id d14sm180028pjz.12.2020.01.08.12.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 12:56:15 -0800 (PST)
Subject: Re: [PATCH v3 6/6] tests/tcg: add user version of dumb-as-bricks
 semiconsole test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200108150252.6216-1-alex.bennee@linaro.org>
 <20200108150252.6216-7-alex.bennee@linaro.org> <87a76xk9ip.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6c53d17c-d8a6-b356-e481-b34e4fbbcae8@linaro.org>
Date: Thu, 9 Jan 2020 07:56:10 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87a76xk9ip.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 6:55 AM, Alex Bennée wrote:
> 
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> There are linux-user users of semihosting so we'd better check things
>> work for them as well.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> ---
>> v3
>>   - include aarch64 version
>> v4
>>   - use common semicall.h, test thumb & arm
>> ---
>>  tests/tcg/arm/semiconsole.c       | 27 +++++++++++++++++++++++++++
>>  tests/tcg/aarch64/Makefile.target |  7 +++++++
>>  tests/tcg/arm/Makefile.target     | 19 +++++++++++++++++++
>>  3 files changed, 53 insertions(+)
>>  create mode 100644 tests/tcg/arm/semiconsole.c
>>
>> diff --git a/tests/tcg/arm/semiconsole.c b/tests/tcg/arm/semiconsole.c
>> new file mode 100644
>> index 00000000000..6ef0bd24500
>> --- /dev/null
>> +++ b/tests/tcg/arm/semiconsole.c
>> @@ -0,0 +1,27 @@
>> +/*
>> + * linux-user semihosting console
>> + *
>> + * Copyright (c) 2019
>> + * Written by Alex Bennée <alex.bennee@linaro.org>
>> + *
>> + * SPDX-License-Identifier: GPL-3.0-or-later
>> + */
>> +
>> +#include <stdio.h>
>> +#include <stdint.h>
>> +#include "semicall.h"
>> +
>> +int main(void)
>> +{
>> +    char c;
>> +
>> +    printf("Semihosting Console Test\n");
>> +    printf("hit X to exit:");
>> +
>> +    do {
>> +        c = __semi_call(SYS_READC, 0);
>> +        printf("got '%c'\n", c);
>> +    } while (c != 'X');
>> +
>> +    return 0;
>> +}
>> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
>> index 96d2321045a..4281c766419 100644
>> --- a/tests/tcg/aarch64/Makefile.target
>> +++ b/tests/tcg/aarch64/Makefile.target
>> @@ -32,4 +32,11 @@ run-plugin-semihosting-with-%:
>>  		 $(call strip-plugin,$<) 2> $<.err, \
>>  		"$< on $(TARGET_NAME) with $*")
>>  
>> +AARCH64_TESTS += semiconsole
>> +run-semiconsole: semiconsole
>> +	$(call skip-test, $<, "MANUAL ONLY")
>> +
>> +run-semiconsole-with-%:
> 
> this should be run-plugin-semiconsole-with-%
> 
> <snip>
>> +run-semiconsole-with-%:
> <snip>
>> +run-semiconsole-arm-with-%:
> 
> ditto for these

With these,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


