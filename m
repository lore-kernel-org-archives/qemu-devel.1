Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8043BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B4521848
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRZi0wQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B4521848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAy6Y-0000xY-BX
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAy4i-0008KV-3h
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAy4g-0005OZ-BL
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:10:27 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAy4g-0005OF-10
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:10:26 -0400
Received: by mail-pf1-x442.google.com with SMTP id b128so2545626pfa.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 08:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vuPTaZxWH7rLoyZh9kbg1WeA01izBsu9Mli9R+eJC6g=;
 b=aRZi0wQjOboGNB8jifBOiGDoHE94QpqvlFbV5BMAymoY3oLf9IlEzmMXNted1JnmQe
 dRDjWlUwUe0u1iIBYMnH9MUKyfuh2ie20HzVu9xg2VTUI9ESGTMsGtc3EFfQgkrmFdyl
 nDDALA/e8++coxnPGzrly0NR3dokH7r+8K72weZyycRd/1phrqHY7CUs4XCwQ/2QPa4g
 PX0hOgxTvWp9ec1AWJ0HMcn9Lmkr1juXJM1STmOemE6sBlGvsApOZt7s30gXJKaiHpyC
 Fptvyz5J9v0Okg42JzFUoe/ub2hKJJqXndwkRex4/Hd964JhRFietiPr8ZO2t3fLj4sI
 DIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vuPTaZxWH7rLoyZh9kbg1WeA01izBsu9Mli9R+eJC6g=;
 b=ckjFnF+MAzxp+8AGkLeoMeDQm9ME3tgZvE4xHiFOpiio6Winc/pLghN8vvfZF+i9Ja
 +MeT7R+6GybWMucmGIynSAVg6YTxYpQEc2MxXjQw2xlNsKsBiMCJ/XQO/8rqAdezS2NW
 9100CzsEkz3+o3oaiE//FfT/rs5JFeZRf2pSt6Aa2EWbzjq15vAKQq8wNM5tnJluRd8h
 76bqLSlzZ6mix7S+f6l1arwmz11YDpUaR+27BeCv/fhOtMclYwyUtIU8OrM0UlrdW399
 A7NdoB9C+Gf2PCE+kO4B/e1VIpBalRK6uiywHgYLErWtXfe1s6axufxnP+6rIs7ALE7m
 yLuQ==
X-Gm-Message-State: APjAAAXXuTyEUJEUQnm0oIfaRdqaDy0Rfy2Nb9MlTneLJvKZJ88pyqUD
 Ld52A+0TdzWr4HYOMQmJh/hwJA==
X-Google-Smtp-Source: APXvYqyCCBnen1m7dWPYVmUrd0t+eyJnNeRh3/MlKZmPEhsk+lU2r6VEaROoVM8lsAuwihb7FXoXbA==
X-Received: by 2002:a63:2b0c:: with SMTP id r12mr9601254pgr.206.1568905824563; 
 Thu, 19 Sep 2019 08:10:24 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b16sm19811269pfb.54.2019.09.19.08.10.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Sep 2019 08:10:23 -0700 (PDT)
Subject: Re: [RFC v2 2/5] cputlb: Replace switches in load/store_helper with
 callback
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190918180251.32003-1-richard.henderson@linaro.org>
 <20190918180251.32003-3-richard.henderson@linaro.org>
 <b11701c0-63cd-f313-fc0b-f66cb6d2f10a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <662b0ca3-9ce4-53d9-723c-76aa242616ea@linaro.org>
Date: Thu, 19 Sep 2019 08:10:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b11701c0-63cd-f313-fc0b-f66cb6d2f10a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 7:53 AM, David Hildenbrand wrote:
> On 18.09.19 20:02, Richard Henderson wrote:
>> Add a function parameter to perform the actual load/store to ram.
>> With optimization, this results in identical code.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  accel/tcg/cputlb.c | 159 +++++++++++++++++++++++----------------------
>>  1 file changed, 83 insertions(+), 76 deletions(-)
> 
> I would have guessed the compiler propagates the constant and eliminates
> the switch completely for the variants. After all, we now have more LOC ...
> 
> I would have moved the actual read/write to a separate function
> containing the switch statement instead.

I tried that.

The compiler does fold away the constant and eliminate the switch for the code
as-is.  But it somehow fails to do so for op ^ MO_BSWAP, where op is constant.
 I don't know why.

These little inline functions were the third try and the only one for which all
of the indirection folded away.  Not so much here, but in the next patch which
passes in the reverse-endian function as well.


>> +/* Wrap the unaligned load helpers to that they have a common signature.  */
>> +static inline uint64_t wrap_ldub(const void *haddr)
>> +{
>> +    return ldub_p(haddr);
> 
> I wonder if you should just add proper type cast to all of the <
> uint64_t accessors (e.g., here (uint8_t) ). Shouldn't hurt and makes
> people wonder less how the conversion from the int these accessors
> return to uint64_t will turn out.
> 
> But yeah, you're simply moving code here.

Perhaps.  I'm not really a fan of redundant casts.


r~

