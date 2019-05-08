Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BE5C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB67720C01
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JErBxilE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB67720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56889 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAdI-00049V-4b
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:40:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOAW2-0005Or-GB
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOAW0-0003KZ-Jp
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:32:57 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOAW0-0003Gh-DS
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:32:56 -0400
Received: by mail-pl1-x642.google.com with SMTP id d21so1504562plr.3
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=vJwbsEy7yodZbKRBHVf7RYs1dsMA/KhZsC2H2NXmmkc=;
	b=JErBxilEUVQBQUGOpxaD2qeIFXELvV8sD5+wrI9ainC7Qojo9I2UgzOg00lbOptphc
	Q0ILVEYaczLZo60IMRX5HfjJ/lcsjIKvTtm9Xy5S4lsFSUxqoRK7SB75CC1yKuVxf+Al
	kf6yv6bEksF2P3PSC4wKuX/zvPgABPwV828ZrQvjZ2CkvQhqrzOL3bAO1Zy08xz5pH1C
	dlDQht9qeaGXN58u7I/oAOH9tRfUgfzG0j+HhMWhOGjdBYuEWksqhY4slggzmvoCebLx
	o5plIAi5hTRp9rcFwn5pv76NAhsyuH1RintJfjdILdfF31qSOkrRFZdortY6HQ/a2n1B
	e7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vJwbsEy7yodZbKRBHVf7RYs1dsMA/KhZsC2H2NXmmkc=;
	b=BbANUq60e6vum4VKAMGIyktBP4YHxBMG7rC8RA6dWsIlDi9f5WTUnT2nzuFXV8FfuW
	q5JDTjrt8dakwTEJEwjZYFQsvqOosx4kU8eRUb0ZLH1yKASHmxmBWzyv1aKzCDhxXmgm
	HXscmcpoOnWlulQYFrnzqpauK+pNR/wgEu+QVS0Jx14ZI6BYf57b4pwk1QQWoAHPBc7/
	YOHg/tzTpXZpFBmEYCtvycxxB6NL95H6k5fzph6Ge5frwa/9FI76LsywWwGqYVyJplC7
	MQ5tTcf1yHVqQnXKQYIYtFXTi8wUtbM/Ut+d7UG6oapYDHPHZCC5sg+8wSLSoxvI3/a1
	cQOw==
X-Gm-Message-State: APjAAAX6N5Vtovldg5EI215SCqvjF01IZyj8yI8FhuvSxqx4p3n6uCPJ
	FScdTs/VObcfUhy1XCLSvefmRA0gtNU=
X-Google-Smtp-Source: APXvYqyZDdigA1bSbObc8OpuAEQgvm8YhI2H8nDDOa86jQlcTmBr5G5UqlOIgR1mueVYIoUTZ8Hb1A==
X-Received: by 2002:a17:902:5c5:: with SMTP id
	f63mr42435376plf.327.1557275574359; 
	Tue, 07 May 2019 17:32:54 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	z19sm17291697pgk.28.2019.05.07.17.32.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 17:32:53 -0700 (PDT)
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-10-richard.henderson@linaro.org>
	<b2a1544e-bf3d-5d90-c6e5-df7f49664059@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ea815545-4603-fe68-2b2d-ca03f790c7ed@linaro.org>
Date: Tue, 7 May 2019 17:32:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b2a1544e-bf3d-5d90-c6e5-df7f49664059@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v4 09/24] ui/vnc: Use gcrypto_random_bytes
 for start_auth_vnc
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

On 5/7/19 3:49 AM, Laurent Vivier wrote:
>>     void start_auth_vnc(VncState *vs)
>>   {
>> -    make_challenge(vs);
>> +    Error *err = NULL;
>> +
>> +    if (qcrypto_random_bytes(vs->challenge, sizeof(vs->challenge), &err)) {
>> +        trace_vnc_auth_fail(vs, vs->auth, "cannot get random bytes",
>> +                            error_get_pretty(err));
>> +        error_free(err);
>> +        authentication_failed(vs);
>> +        return;
>> +    }
>> +
> 
> This part is weird for me: if auth fails we send "vnc_write_u32(vs, 1)" but if
> it succeeds we send the challenge. There is no success value to send (like
> "vnc_write_u32(vs, 0)") ?

There is, but this code is a mess of callbacks.  In this case it happens toward
the end of protocol_client_auth_vnc:

   2604         trace_vnc_auth_pass(vs, vs->auth);
   2605         vnc_write_u32(vs, 0); /* Accept auth */
   2606         vnc_flush(vs);


r~

