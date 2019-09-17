Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18313C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF085214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CR1TLuNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF085214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAL2g-0002t2-Nc
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 17:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAL1Z-0002J1-PV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAL1Y-0000vP-Ld
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:28:37 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAL1Y-0000vA-F9
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:28:36 -0400
Received: by mail-pg1-x541.google.com with SMTP id n9so2694474pgc.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 14:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WzMGZXaEOlRXK4dqLeaJHkKEfUJG+DDEAm+9ueoRpZU=;
 b=CR1TLuNwwGVBp3QhMk8KFn4851X5vQ4tgkd3scgTOR7U4eZQGjJKZDf0DGgWGx6nPW
 VSpyifIN/QKkCTE95DMLaaMgDXn5oOHArkClBG0OEl+ZphNOKSZ9vpsV7LTdd/JQ4qnZ
 N4FdeUeYBAbXWngXqzpE67aRLKgBuuOWK6vvPdCxye/rzZ6gX3+ztLJuG4vL3V/cDXHf
 CJpIYvmqACqEe/awykRUnYLr0gfVd9FCZ8QIlTRXDRtYTQkWdVjOcJNBm3Ie++TlfY+9
 TkhhpK0XIPWHH6bmlPjVEk12D/F+q+iy1RKsvAOtolC10GtylBtBwscyMS3tOyBf20Fv
 josA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WzMGZXaEOlRXK4dqLeaJHkKEfUJG+DDEAm+9ueoRpZU=;
 b=gGQyN37gxD3tyoTdIxjMDJeUzmrEu8z0UNgS/foAmnR9I9OcaaqkJm+hGJV1upwkei
 k0OcE6DbbinRHL3GvzlC1g3rGiaco3PRwyid8wEhSoT06J9ewufRiooH4Xe853gLzWyR
 hBy3n4XWxoPbWTxtzoX/XbtGkvMkHyEmrbIx+mgdC3h8pOejKATEvdS2eLVYtFfi7c/j
 dqA9ccJLNEaVsTscKre6EmMgTNSuFTI5vZ/GWp227I1nNJnjWBYRV79jR9bbzf1OB7Ao
 dXu6FtwJ/jWu+N9tTQsK0jpLN9qRmB/0twWzwm4p7y4C7ZndcQphEl6PFLmuUZ5gl8he
 y5LQ==
X-Gm-Message-State: APjAAAUcLyoz1Vmikp8DHsscBq6JcF1rukZNc7zLCsXEJHNEcuID5KBL
 ky8ArI3RnAiIWgPB09WvGX/me12o0IbykQ==
X-Google-Smtp-Source: APXvYqwpIjkBcxeQGuAYkeTZ3kmQQKG49hF7tADyBRvwgPbb522P8dyZJmt9OEgrtcDqWs0tsbM6DQ==
X-Received: by 2002:a17:90a:b001:: with SMTP id
 x1mr174603pjq.114.1568755714959; 
 Tue, 17 Sep 2019 14:28:34 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n15sm1679909pgl.80.2019.09.17.14.28.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 14:28:34 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190917184109.12564-1-alex.bennee@linaro.org>
 <20190917184109.12564-8-alex.bennee@linaro.org>
 <afd9bc85-9c79-a456-73c1-fc19e97d1acd@linaro.org> <877e661vur.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <93ff7174-77c0-d2eb-eac2-d3eef7e88a14@linaro.org>
Date: Tue, 17 Sep 2019 14:28:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <877e661vur.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v1 7/9] tests/tcg: add float_madds test to
 multiarch
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 5:00 PM, Alex Bennée wrote:
>>> +    add_f32_const(0x8p-152);
>>> +    add_f32_const(0x8p-152);
>>> +    add_f32_const(0x8p-152);
>>
>> Why are you adding 3 of the same?
> 
> To replicate the 1841491 test case where the same number is used for
> a/b/c

Then we really ought to be more explicit about that.

You're not doing full permutations on the sets of numbers, so does incrementing
a random index really test what you intended?

>>> +#if defined(__arm__)
>>> +                r = __builtin_fmaf(a, b, c);
>>> +#else
>>> +                r = __builtin_fmaf(a, b, c);
>>> +#endif
>>
>> Eh?
> 
> Ahh I was going to hardcode the arm madd instruction in as the builtin
> wasn't expanding. I tried setting -march in the CFLAGS but that didn't
> trigger it either on my buster arm-hf compiler. Any ideas how to get the
> compiler to do the right thing?

I think you want -mfpu=neon-vfpv4.


r~

