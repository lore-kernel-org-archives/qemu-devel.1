Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35C9C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 20:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACAA72067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 20:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMso3o1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAA72067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34759 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLCkb-0001oA-Rv
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 16:19:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLCjS-0001ON-7O
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLCjR-0002Xu-Bu
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:18:34 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLCjR-0002XN-5L
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 16:18:33 -0400
Received: by mail-pf1-x442.google.com with SMTP id y13so5868215pfm.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ft/KOVnG6O94OG6rxuFLn26qfqBK/eTTYlPhfxU1/wE=;
	b=OMso3o1PsoMehPq2kbmqIxAJJqrBbNbbHCiVpRZAtiHH42OvqbtFAHBtdbwx/oOubw
	i6JgM8WVRgF1Fma9Qj3fgO0fVu9ZZv2Kcne+pSlD0GM2NZkJDvufG1mBterYOcgq5A5n
	wR/1G6S5ss1ht/+m5vhDEI0WGbaFQTH4Zdg7oaNzsPb3AnbFZokZdsD9l9HnFKltbD67
	7xRqvl3jEPgvDSOXCog48VDCuAH9Nwk6VseSSj1aULtM9UVB3MdvkNlNBEk+II4c+4Jp
	G0Esa5cNYZIapnfG33F3OhkV3qFLT5vvfK7sQ4olupc0EJI25/YiAUzf8Yyv7WVyHB6a
	fayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ft/KOVnG6O94OG6rxuFLn26qfqBK/eTTYlPhfxU1/wE=;
	b=KUiU6UsosRhmxAm2LXvDfEU01TwXyikB3E9JPVCHq1jcoEyrqWpwQXCVm8v31eJkqG
	YTxiJ2KUWEqCyJwq+WF45E42tdx8dIgJ6LpMB8mgW3nRT6SZhdtNVMIjyD9wF0WDyvE8
	Ub5briRpMgtyrA/Ino/HO/6hgBJPfCgv8qTGwvJmUDq/7rpt8P90wHidmZuaQqHFaD2Q
	/1nBZdqTUDavYL5m8YTnB4U9qM7t+GrPkmIoEMzgKd2LSGN2ULk3nyDD13v91K+v7SDz
	4j5GWqgdymjX/2Gd8m1oY61IHCvUXLBx1eVhJDATZA3ENzPLoWkjgF3iZE8WgsDl9qkn
	nMug==
X-Gm-Message-State: APjAAAVnvTtBnEd34Esk2/S7tHAGEfDWTnuV6e8uRCI6RM4cfW/PnYXN
	UNuLP7uKtA+l4zh8PxllKpot9w==
X-Google-Smtp-Source: APXvYqwYBlLmXNBCceFPacMxPCWGQieEvsBrnYdT7mO7PTp2rIe8OCk5hUgbYaW//dM4mzMUrnNNkw==
X-Received: by 2002:a62:ed10:: with SMTP id u16mr64765832pfh.187.1556569109574;
	Mon, 29 Apr 2019 13:18:29 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	t3sm31894022pgu.78.2019.04.29.13.18.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 13:18:28 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-4-richard.henderson@linaro.org>
	<CAFEAcA-3qrQXk9iMY_9VZSLzdnn=EzzYOqhe61UQKYn-w__3Zw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a3da11b9-b2e2-2222-1194-437c7ccad61d@linaro.org>
Date: Mon, 29 Apr 2019 13:18:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-3qrQXk9iMY_9VZSLzdnn=EzzYOqhe61UQKYn-w__3Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v4 3/4] linux-user: Parse
 NT_GNU_PROPERTY_TYPE_0 notes
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429201823.egcss9DIKtd6RtUlO0ufrhAlxW1s_YwJ1Jr14Exz40U@z>

On 4/29/19 9:17 AM, Peter Maydell wrote:
>> +        struct elf_phdr *eppnt = phdr + i;
>> +
>> +        switch (eppnt->p_type) {
>> +        case PT_LOAD:
>> +            {
> 
> I think you have an extra layer of indent here that we usually
> don't do for switch statement cases.

No, that indent is exactly right for a compound statement
not associated with an if/while/whatnot.

> #define GNU0_MAGIC const_le32('G' | 'N' << 8 | 'U' << 16)
> 
> and then you can avoid the #ifdef HOST_WORDS_BIGENDIAN?

Sure.


r~

