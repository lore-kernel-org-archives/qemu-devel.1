Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2402C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3742173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="If9fYsHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3742173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idILM-0003gD-R2
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1idIDN-0002Q2-HC
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1idIDM-0006MQ-GK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:20:29 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1idIDK-0006K3-Az
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:20:26 -0500
Received: by mail-pl1-x642.google.com with SMTP id x13so3040071plr.9
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 10:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oOzYyprudmU67qFl8SvHvrIwSli35oGOiUxchYjoPpQ=;
 b=If9fYsHv948uhmP9qb6KQSusBrsi+xsuwyJ09LpzFimh61AkmlRzGONqWUsyM6x7i9
 ssvvH/FpEXntdaVDP1H69Sf3M9jJq96evNBh0EIdsI7FzFiB6X9XO4pS5FYv0XfaYTTm
 Q4x41XbKQCHcfF1cxVC6VCOKXidoAgBYk8QPOJdoZWDq/6gxNnL/F2V+SEJCkbo+2JwL
 F/q68dHhkG1+R2uq0ty6TS8+SipD0/7fI5HLt2Vbl5P+8HWvPgDeWvTrCv16TW7ebZZ9
 cRaXMmrXKCVnfDetP8vjUJljRNxzHq11NNuYoLXnga/Ujk6e8F4scxHhnNZVHUfLdeSn
 7MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oOzYyprudmU67qFl8SvHvrIwSli35oGOiUxchYjoPpQ=;
 b=EnsvPcAqSjtl36oYFLq7bzspPaKhT0+V5y/90TtzRaE/zLyz3uC4mxC9jR8wHC6GZp
 /8UJaKqzkg1gPmgfEIoo4AYM9C08GjbZssw2pywzxlnfIkYTQyMEXqZ/uAaYGSLbWbfX
 PlJGs2nCutE1LHtB6yX/92Ne3wEYMkpFM5aGYeIqclB+mMbs3N5lM+fhJV+QMU73GYy0
 c5tmYURRt6CsNfGbWjnGnFL662LvTbfLKFUNznFGPN7IKO7PPhO+dOR1jYFKDP9vsc3N
 jAmvpC7ufOY0KHv0NNXtURfvxVvJDqnVXDP5lmzGdysFYdooEm9pyLraGRsdVdgOwveA
 240Q==
X-Gm-Message-State: APjAAAX0QyHmDSeW6dFqOTuaGgUud4ewnVbUwrUGs1mCOm9iUXmqAh7L
 kcvPpgHDJvMmiDBU6srN4lulwA==
X-Google-Smtp-Source: APXvYqynv8QzhTBEqBQu8SALhwtbfE0fz7rO7A/MSZbCGw6GUI3pAp5UgZFPrZcoZ3ysKpf6GNQi2w==
X-Received: by 2002:a17:90a:f0d6:: with SMTP id
 fa22mr16961918pjb.136.1575656425169; 
 Fri, 06 Dec 2019 10:20:25 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i9sm17571643pfk.24.2019.12.06.10.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 10:20:24 -0800 (PST)
Subject: Re: [PATCH v4 10/40] target/arm: Rename ARMMMUIdx_S1NSE* to
 ARMMMUIdx_Stage1_E*
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-11-richard.henderson@linaro.org>
 <CAFEAcA_Q8foDFHbqLBCewnYPbSz8-VT2OU49tQsX2No+Yn0avw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e4e75e1c-7659-37fa-541e-962115526c4f@linaro.org>
Date: Fri, 6 Dec 2019 10:20:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Q8foDFHbqLBCewnYPbSz8-VT2OU49tQsX2No+Yn0avw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/6/19 7:47 AM, Peter Maydell wrote:
> On Tue, 3 Dec 2019 at 02:29, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This is part of a reorganization to the set of mmu_idx.
>> The EL1&0 regime is the only one that uses 2-stage translation.
>> Spelling out Stage avoids confusion with Secure.
> 
> If you didn't delete the 'NS' from the name then it
> wouldn't be confusing...

It is not obvious to my eye how to break up S1NSE0 -- 'NS' is buried in the
middle.  It might be different if these names were architectural, as if the AT
names, but they're not.

I think it is clearer to reserve 'S' for 'Secure', and use it consistently.
E.g. not the current "S1E3" (stage 1 e3), but "SE3" (secure e3).

I think it is clearer to simply document that, unless "Stage" is present in the
name, the tlb contains the complete translation.  This makes "S12" redundant
off of "NSE0", and "S1" off of "E3".

We'll still need a renaming of with SecEL2, since "SE0" is no longer complete;
we will need to specify "Secure EL1&0" vs "Secure EL2&0".  Thus perhaps
"SEL10_0" to match the "EL10_0" name that I'm using in this series.


r~

