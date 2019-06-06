Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336D8C28EB4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 14:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CD420665
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 14:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGNNnhnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CD420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33156 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYtKG-0005xb-Ns
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 10:25:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYtJP-0005a2-5V
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYtJO-0008He-A6
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:24:15 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:33305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYtJO-0008EX-3B
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 10:24:14 -0400
Received: by mail-ot1-x32e.google.com with SMTP id p4so2149837oti.0
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=9HWynlXTySzrdPJ8cjfhtf4d8AhaQcIVfaAvSs/ASKk=;
	b=SGNNnhnk/tE1OXfhrCGiFZu8BpJeUt4XvmXPIZHZ/caJYCwBVGm1WcsB+MQNYOmwtW
	280dBOzfawJEunNHyJgZOGAh9b0v7lro3JG81cWk1omdAO+VQ7ARkX+HfL/jP5E9UNnD
	ZWQhqXUtl7uHC+8ADwBqWISuUGr+v7g0bVQKENFI/v3EQ5xS04Md7HqUV/lOwxmhKMuo
	Sfs/WBAISmPqwwvkyXSv/rk2r3NYuXA9lMuaz2c1bDh4EqOSHEO3r0vNDJovvqGAZZpf
	5QdCXxo1N0sxcsPvvpHUXIo5R0mOmtAPSfhYhKD+mSdHalGa0gjZkKeuQBLv+fyukafN
	AvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=9HWynlXTySzrdPJ8cjfhtf4d8AhaQcIVfaAvSs/ASKk=;
	b=MI31UpT1Fm7PN5y0cWHiJAajReiWdzpbQsbIzFMMcAqrPzdbpOwo+3wt9oIJBr/rM4
	y4yz6FDTCZQmfhALQIA/brm4erMc5rAA8zRvojGj9TGb71L3qSDeJM+KXBypdsz0CsQ/
	CMJfH8KKdBYDJJotrOg9cADrz41e7ewopxClD907Uaopueww2PnL0cpQWcu/3LKq44lH
	2fC+KCyboH3zZfAfM6ZU3lgdIF6eZS/9R4xy9G8llWWsJNG5wzfn9zml/g+VRrLOMPwp
	FYxl+gPCGv/uSuJnpbf3rkq4/7uTHQsLlDWCgx8eCi60yyCUWFtbq8LbPwdIHLQPaFZC
	K5ZA==
X-Gm-Message-State: APjAAAXvvIxNQFL5CQaP7lhOM/3z+IrdJBRaE5oZK77Dl6DwvHqNkh9M
	I3cbubG4ZfsJdLud4r6bAZLkmQ==
X-Google-Smtp-Source: APXvYqwSYcNi+rnIM6RR8bBONRPXv93r06JG3/InlxuGdpI0Sr8eSq/hJQW+wOwlV+DWyJNTho2jIg==
X-Received: by 2002:a9d:7c8f:: with SMTP id q15mr2357000otn.24.1559831052958; 
	Thu, 06 Jun 2019 07:24:12 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id b9sm645437oti.43.2019.06.06.07.24.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 07:24:12 -0700 (PDT)
To: Dave Martin <Dave.Martin@arm.com>
References: <20190605205706.569-1-richard.henderson@linaro.org>
	<20190605205706.569-7-richard.henderson@linaro.org>
	<20190606102141.GB28398@e103592.cambridge.arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <234bbba7-550a-9183-4bd4-6d0f75c8dbf1@linaro.org>
Date: Thu, 6 Jun 2019 09:24:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606102141.GB28398@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PATCH v6 6/6] tests/tcg/aarch64: Add bti smoke
 test
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 5:21 AM, Dave Martin wrote:
>> +/*
>> + * Create the PT_NOTE that will enable BTI in the page tables.
>> + * This will be created by the compiler with -mbranch-protection=standard,
>> + * but as of 2019-03-29, this is has not been committed to gcc mainline.
>> + * This will probably be in GCC10.
> 
> FYI, GCC9 has it.

Thanks.

>> + */
>> +asm(".section .note.gnu.property,\"a\"\n\
>> +	.align	3\n\
>> +	.long	4\n\
>> +        .long	16\n\
>> +        .long	5\n\
>> +        .string	\"GNU\"\n\
>> +	.long	0xc0000000\n\
>> +	.long	4\n\
>> +	.long	1\n\
>> +        .align  3\n\
>> +	.previous");
> 
> Note, this won't be enough to generate the PT_GNU_PROPERTY entry in the
> program header table using older tools.
> 
> This may be work-round-able with a linker script, but I haven't looked
> into it.

Yes, a linker script can create such an entry.

>> +AARCH64_TESTS += bti-1
>> +bti-1: LDFLAGS += -nostartfiles -nodefaultlibs -nostdlib
>> +
> 
> Doesn't -nostdlib imply -nodefaultlibs and -nostartfiles?

I don't believe so, but I'll double-check.


r~

