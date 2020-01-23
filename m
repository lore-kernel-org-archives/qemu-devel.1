Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865E4C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 03:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520D924673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 03:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KivGQ0NJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520D924673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuTA7-00066i-Hj
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 22:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iuT9J-0005ff-HE
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 22:27:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iuT9I-00047a-Ea
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 22:27:17 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iuT9I-00043z-7A
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 22:27:16 -0500
Received: by mail-pl1-x642.google.com with SMTP id p23so716478plq.10
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 19:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UyMqzatQBPNk5iDJ02MIBTznMU7nvKsWo6DYPfnnGDw=;
 b=KivGQ0NJxQt+D5MJNKb4qrm+9+JyELp9uaxxUKbVyj/lT81N8w/N/CBCIDT1M2NK+M
 /GSy23WJ/k/WT0Si30WM8mRVmP/BUm7/NlsidhhbxdTHENjVPNiJv0HHGmy9IbTfNlzs
 N7i2Iio3eKzpc1Wqk0ZJ6GQhnhykU6gmXASc7PHsReJ12A8RpWxDmuE5v1NuSx6L3kkg
 X4TYuLPM2h+xWateGjn8OsORuXLDcISBSS5zKaiKAVIfbsMOWfInIUjX7SOog1b94N58
 A7yJN3ZfouHAY8aVKKRmutZwYkrdJ3a6wFPj9VZac1k4mFoyxdhvL6Gyit/L3QZk2luh
 0evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UyMqzatQBPNk5iDJ02MIBTznMU7nvKsWo6DYPfnnGDw=;
 b=XzcYt0s1RR890rdR+/iIMgEqMujkcgEB40UjcMKgpiGr/kk0ONZ9lC7rLl4jd7lwhY
 pTiMwgEKJSfStdT1zx+hJ9MEBeAfW9jS2ZsoKxyM+cm5Katgcf8V/hfF9tc3U0PHI0tm
 hL/BGlR5XJVbRWZfh9EcuyY+3jV/wyYe0E86GH5hQap/jVUCYf1OKq3Cpzh6KBu+8Cje
 8X6LHnDF8nWmn7i/hQLGqwoYsyO+swKOIX/6lruEHOY5oZ9S7SyU3dL5lwUnbUF9BIpJ
 0VkwztkJEhRIN0tmNPK1ol/UGOvMQgamjM3DrbnVo7Q5zENY+5m8yJqmJJwDHwcnkBqF
 jg2A==
X-Gm-Message-State: APjAAAXKWRKwxzv5qXxN18VAag85pI8FHKZrNhVdxXfIen4+5MtACwig
 qRxjYX4p5E5n3itqis2jRzwjiA==
X-Google-Smtp-Source: APXvYqxjlX1PcPwRpiR87aojQ7baDGbLvsV8dOspUyEmgBSB3tf2re4XgsSzqkci1zJAxWEUi+Fsjg==
X-Received: by 2002:a17:90b:8b:: with SMTP id
 bb11mr2132836pjb.27.1579750031217; 
 Wed, 22 Jan 2020 19:27:11 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id g67sm361204pfb.66.2020.01.22.19.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 19:27:10 -0800 (PST)
Subject: Re: [PATCH] tests/boot-serial-test: Allow the HPPA machine to shudown
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200123003603.11610-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <15bada61-7e0c-bb4d-a91e-2cdfd42161e1@linaro.org>
Date: Wed, 22 Jan 2020 17:27:05 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123003603.11610-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 2:36 PM, Philippe Mathieu-Daudé wrote:
> The boot-serial test uses SeaBIOS on HPPA, and expects to read the
> "SeaBIOS wants SYSTEM HALT" string, see [*]:
> 
>  122 void __VISIBLE __noreturn hlt(void)
>  123 {
>  124     if (pdc_debug)
>  125         printf("HALT initiated from %p\n",  __builtin_return_address(0));
>  126     printf("SeaBIOS wants SYSTEM HALT.\n\n");
>  127     asm volatile("\t.word 0xfffdead0": : :"memory");
>  128     while (1);
>  129 }
> 
> A 'SYSTEM HALT' would really halts the CPU, but SeaBIOS implements
> it as an infinite loop.

Well, SeaBIOS implements it as the magic QEMU halt instruction,

# These are artificial instructions used by QEMU firmware.
# They are allocated from the unassigned instruction space.
halt            1111 1111 1111 1101 1110 1010 1101 0000
reset           1111 1111 1111 1101 1110 1010 1101 0001

followed by an infinite loop, probably to avoid a compiler warning and Just In
Case.  We really should halt here, unless shutdown is disabled.

> -    qts = qtest_initf("%s %s -M %s -no-shutdown "
> +    qts = qtest_initf("%s %s -M %s %s "
>                        "-chardev file,id=serial0,path=%s "
>                        "-serial chardev:serial0 -accel tcg -accel kvm %s",
>                        codeparam, code ? codetmp : "", test->machine,
> +                      shutdown ? "" : "-no-shutdown",
>                        serialtmp, test->extra);

And thus avoiding the -no-shutdown should in fact shutdown.

Are you saying this doesn't happen, or what?  I think I got lost with the rest
of the message...


r~

