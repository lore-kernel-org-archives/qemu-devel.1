Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6EAC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562D5206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ylHxTUwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562D5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40971 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGT9s-0003jM-La
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 14:50:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGT80-0002ei-Ph
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGT7y-0002vP-Pa
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:48:19 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGT7y-0002gy-9m
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:48:18 -0400
Received: by mail-pg1-x544.google.com with SMTP id j26so10761612pgl.5
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=2nfoaC/P6XmzF1KYd3uOuYw8NbtLnt80czToE8UJpg0=;
	b=ylHxTUwJQyED3WL5soSscRK+3r32mR1V21go3mP9a1XMPE0d5VsnVT2B6izaXbla9M
	ET/KrYr62YNt5ZdidYwMhu8kIcSMO1/4i926r7gzMUkGrIju4xggHQg27GqnP1LkfXDu
	ZfGACILJcUgRdzxWd6FUAEwzPM/DjReccGGBWUW92ti+10PDtnNRrIu+gaLd/i3lmTHt
	F/W6HZ8abo0++X1JDOdQhBRWbjJjVkBF7s2GUk1hMpkJkYvXz6nDd2HwATxZVBU604Or
	uxztz4kmi5KAxEYfmGbJ7QaqIuFmyahNOLo4cNDZgZhLliXGf3g47CuKrid83mKAug0x
	xCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=2nfoaC/P6XmzF1KYd3uOuYw8NbtLnt80czToE8UJpg0=;
	b=BR4uoDHJmuqDryCA8NSmML2yk4gOtoYkyNJ+9Day5iqjGFxBH+I8YRPRGNKPH+5tj3
	sy4791AWKemMQmfc6yT0hiKTYcI7K/btQXcaFL4bhxtJZBiwHXf5bm0Q+v1bBqRU2NFn
	3rWaL7QqetOVwGR+jSIY+bEklAZBYqo6dGVaJhl6EBw+n0qIGr4pCtUrFw2Xbe/dzulN
	toCOH+2KW0Erd0yNBfdgPfdMBmYxPM0gUi2oZZj+/2S6C7JHb4OIrfwVO7ScBsFrgKFQ
	rgP78BleG6Ab/801++S336uDSrtujOFHj6bna2V8SxZqUds/hKdEHayq6c6iUlf1HKBu
	5+0g==
X-Gm-Message-State: APjAAAW8Wvp5zfMlra03CVbtCQHDzwpeA58VKTBn8cviABLtfMRk9Bgt
	KmQ8sIhwnJkrU7tVjjv0VsoWf9XPWNU=
X-Google-Smtp-Source: APXvYqz8WbaOD/zTXgGmkMfq1Gootqo1AKh0ZM/eVoCNT35VzTQCYBeEaE1FKc1R93gfiJEPcQ1GHA==
X-Received: by 2002:a62:6444:: with SMTP id y65mr83972587pfb.56.1555440495401; 
	Tue, 16 Apr 2019 11:48:15 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	o89sm91797193pfi.178.2019.04.16.11.48.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 11:48:14 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190416083150.19649-1-richard.henderson@linaro.org>
	<20190416083150.19649-3-richard.henderson@linaro.org>
	<6860567d-8678-783e-e001-1dd53785c84a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4d5aea2d-15fd-ad52-a6b4-fb6b74b231e4@linaro.org>
Date: Tue, 16 Apr 2019 08:48:11 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6860567d-8678-783e-e001-1dd53785c84a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 2/2] tcg: Restart after TB code generation
 overflow
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416184811.ngaNXuejHqlnjASoPXyxXrGjfXnxz2QEJZspmIqBUq0@z>

On 4/16/19 7:47 AM, Eric Blake wrote:
> On 4/16/19 3:31 AM, Richard Henderson wrote:
>> If a TB generates too much code, try again with fewer insns.
>>
>> Fixes: https://bugs.launchpad.net/bugs/1824853
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  accel/tcg/translate-all.c | 39 +++++++++++++++++++++++++++++++++------
>>  tcg/tcg.c                 |  4 ++++
>>  2 files changed, 37 insertions(+), 6 deletions(-)
>>
> 
>> +             * Try again with half as many insns as we attempted this time.
>> +             * If a single insn overflows, there's a bug somewhere...
>> +             */
>> +            max_insns = tb->icount;
>> +qemu_log("TB overflow: pc=%lx insns=%d\n", (unsigned long)pc, max_insns);
> 
> Leftover debugging? Or should it be kept but properly indented?

Debugging that I thought I had not committed at all.
That's annoying...


r~

