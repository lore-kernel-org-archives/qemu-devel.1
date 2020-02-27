Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6681EC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3652E2469A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGLKRxU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3652E2469A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7IjY-00077S-7S
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47935)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7Iih-0006RE-EN
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7Iig-0001Hv-85
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:56:51 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7Iig-0001FJ-0m
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:56:50 -0500
Received: by mail-pl1-x641.google.com with SMTP id p7so1117239pli.5
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 04:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/B8hMISiRy/G+ie70axEz69LfXSiPbJHtnLMgBPq6eg=;
 b=VGLKRxU00rdRUdhqCIl80Vx2QfBQ5huxdqzXTs5oj91RnOMTaf9JLesXXsAS4Eq8gN
 Snq8pLC74g22kHA99/tQyNROnLssNbw9rDnLK/gwEvQYZORbfW9oumt2wrJ+sVduxtyj
 AH7pdlcVbhsC4dhQoQlY8P1sos1RJOuPwchtEo+QtP4wGrYSoQU7fFMM4d4YTucH83il
 57tyLn3W9bV/ZnwHdhdczhVCoaRRLtQemTYdRH5YCvHpVu3BWOtrSkC6HnKlUuVQjd4+
 iVDgBLFz4iEpPIwGPLadFvTWiPEY6E4rKhJ6iFdvTdwFn/vc3tFt71GdwnAQHq1SUvc5
 EfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/B8hMISiRy/G+ie70axEz69LfXSiPbJHtnLMgBPq6eg=;
 b=pSaHgjJsZ5aYDXzsZZz7wzBR1eSxT0xzJl4ey3s50waPTNC8mY3l/S0f4KOO/KlnsZ
 xZuucU6ojiTkeDuXHh+SHfspyEhu0tlxfy/ZEeepE+hLC9UjrydSV/+xPX8oLw6vf9m5
 3Q31jQV59Ngf77q9Mispmf5hr4GHQat4UxTu3iZycq1B71VHDT4pLErKdf/kxOaD+gpg
 vkzgGu5AooFSNnvei925j9zyW/tJYX+tD9rYEyKjJSTEhOnltFFOA6awT37K4SLVeMQN
 ebO8NQ93JGYM2cVnoTAILWQsH2CJ9Ig9NJ9/Mx36YFSJreugqjvMVH12/urrLV2dj5IA
 JfAw==
X-Gm-Message-State: APjAAAUIszB3HkMO0IwkT3tRuCcekfyQq1Qh5OxWIjuI6T/zAfcRhhbT
 iY90ZprvQArYFvhKdFFoaaxmBA==
X-Google-Smtp-Source: APXvYqxcYQknEEwEPA392GeXNqXsCW1KEzjX1Q8kZ1XHuJUH6vP4E6eyQ3cy8aJu2QR4hhAcNRTrEw==
X-Received: by 2002:a17:90a:bf81:: with SMTP id
 d1mr4716950pjs.21.1582808208712; 
 Thu, 27 Feb 2020 04:56:48 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 r145sm7431800pfr.5.2020.02.27.04.56.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2020 04:56:48 -0800 (PST)
Subject: Re: [PATCH v1 4/4] accel/tcg: increase default code gen buffer size
 for 64 bit
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-5-alex.bennee@linaro.org>
 <2ca7b55b-5674-370d-5c4d-dc8b7782ca64@linaro.org> <87pne0w6rt.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <56f5e355-9357-e212-e92b-9db1d8424dea@linaro.org>
Date: Thu, 27 Feb 2020 04:56:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87pne0w6rt.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/27/20 4:31 AM, Alex Bennée wrote:
>> It does not make sense for a linux-user chroot, running make -jN, on just about
>> any host.  For linux-user, I could be happy with a modest increase, but not all
>> the way out to 2GiB.
>>
>> Discuss.
> 
> Does it matter that much? Surely for small programs the kernel just
> never pages in the used portions of the mmap?

That's why I used the example of a build under the chroot, because the compiler
is not a small program.

Consider when the memory *is* used, and N * 2GB implies lots of paging, where
the previous N * 32MB did not.

I'm saying that we should consider a setting more like 128MB or so, since the
value cannot be changed from the command-line, or through the environment.


r~

