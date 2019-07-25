Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED662C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE6522BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdiG16Gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE6522BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqefV-0005zh-Rd
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33662)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hqefK-0005Zw-IL
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hqefJ-0004ZJ-IV
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:24:18 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hqefJ-0004Yf-BB
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:24:17 -0400
Received: by mail-pf1-x442.google.com with SMTP id y15so22850788pfn.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I1vrAVacngQsTErWMGlOtAHGVrLVOAcU9r0B41wXqhk=;
 b=DdiG16GkPcWkWSR3QBjL0L8YKQp41W8hyAfYZ04O4d6gHretFczYQ/TBwWec6JHMD8
 sj3Y1IiU0LNGlzIHDutXpAWVuiLEWUULZy3acleMjyh9s/HToKccKiSst6y94xAicROL
 0AK3vPgrClw5QnnTq/vk1tf2UzpveqRa8qLzoIseZAOramN6DjhJlMnzxcY0T+8ezhAF
 +h77Zd521ITMO5p8iOnj87s2yabzE5YXpyFtK/vMQ2HI8gmWI2yoHYfwfqoAB7BzQkb+
 196Uw3yKtb6Kc7mrmN8CrfGhAvr5MFv5j9HZncKprl+oT3PSo0TeUz56qbH+q1LZdvwS
 KUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I1vrAVacngQsTErWMGlOtAHGVrLVOAcU9r0B41wXqhk=;
 b=D1QxEmnyfz89CeXjKiLSVmLgl4TMtvJUMCrOYo4NynhkHVo5AGoEB1IkGi+NyuxBOI
 uLxgWUSZgRumiLXNJIrGZ/Y5WlVfEmD1Dz7kGjO6yhdSiimTObjVTIg9YWDPyb0F5vmO
 vXja+x0f2cx3uPBw3GMXAYAPxhFqoOxXiwEMW+qfxMQC1EjYk/LjCUHJ855re2DQRNQC
 LQbBUwnsjFyR8WUQfRGlHcJYMWaYrRCM016NhRP5rZptNHNkA1YzJE7AbYWxLKHTLLNm
 vK76LRHKQmF1Yhop6c2dCMPe/x8/gBqt+yZmzQJtn6dOrRWCvtsara7rGC4BXUBbuLmW
 OlsQ==
X-Gm-Message-State: APjAAAXfnCSNL6B9rDOGVJE/doYJuW3Z4an/vdsdCTDo9Nglg0opN96D
 jL7RFgp022QFKra8jY1KgnUuTA==
X-Google-Smtp-Source: APXvYqzJ4tj047V+dgc+TKDZcflNbKJ5qTg0EAVu+npAXtjoZQ7guf2rLTzpaAdN41expHYGtOQXRQ==
X-Received: by 2002:a17:90a:372a:: with SMTP id
 u39mr93122937pjb.2.1564064655613; 
 Thu, 25 Jul 2019 07:24:15 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id l31sm87357468pgm.63.2019.07.25.07.24.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 07:24:14 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-13-richard.henderson@linaro.org>
 <871rye1ad5.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6f561cff-b612-ae50-020f-7c66bac0f742@linaro.org>
Date: Thu, 25 Jul 2019 07:24:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <871rye1ad5.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH for-4.2 12/24] target/arm: Add VHE system
 register redirection and aliasing
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 7:01 AM, Alex Bennée wrote:
>> +    union {
>> +        /*
>> +         * Offsets of the secure and non-secure fields in CPUARMState for
>> +         * the register if it is banked.  These fields are only used during
>> +         * the static registration of a register.  During hashing the bank
>> +         * associated with a given security state is copied to fieldoffset
>> +         * which is used from there on out.
>> +         *
>> +         * It is expected that register definitions use either fieldoffset
>> +         * or bank_fieldoffsets in the definition but not both.  It is also
>> +         * expected that both bank offsets are set when defining a banked
>> +         * register.  This use indicates that a register is banked.
>> +         */
>> +        ptrdiff_t bank_fieldoffsets[2];
> 
> It seems a bit off that we are compressing this structure into a union
> when we didn't bother with the above fieldoffset despite the statement
> that only one or the other is used.
...
> Is 2 pointers enough saving? Will we never see a re-directed register
> that was using the banked fieldoffsets? Can we protect against that?

It's because bank_fieldoffsets[] is only used before instantiation.

Before the structure is given to add_cpreg_to_hashtable, we have copied the
structure, copied bank_fieldoffsets into fieldoffset, and adjusted the secure
state flag.

After instantiation, those two pointers are unused, and I thought I could
reclaim it.  However, you may have a point re total memory savings not making
the complication worthwhile.


r~

