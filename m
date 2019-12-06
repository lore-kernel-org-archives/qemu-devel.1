Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB18C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7EF206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yViul8pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7EF206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIlW-0003i2-Ia
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1idIjt-00022F-Ar
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1idIjs-0005Td-4W
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:54:05 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1idIjr-0005PO-Je
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 13:54:03 -0500
Received: by mail-pf1-x443.google.com with SMTP id 4so3768315pfz.9
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 10:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+KT4pH+cyOA6/nlSNn19+QpI7K+f0JeoLlhLVLoFlGk=;
 b=yViul8pdu/+BGN5iZxnbMTwfmnTsQEeS92+Lw/RZ+F2DycTyIazKx+oETuGN4rLurL
 Xc/3hU9FRfS7fQwtedzF5Io1ol9NDBJLCclcjNLxOxdfM5x+kFIpb8jDnK2H2UV43kDq
 cQbKTBwMWzvtSmCvQ4dFwu/OhlimiKc80ck6GPL2GTbnR6PTNwVmNXiijPI4RkGbBXDI
 nhTUFc0xdiwtLaC1hZEuIbvG5g2bJ7H1Mwk4mWRpJqPrrPUakVBDgSJIJl0S9B8FEQ8C
 y5JJ9m+rnS1e3QDroI5cknLncxYJlo+5fDLhu0OEu3WDj6MwQt7KPqvjb63lH/0cJbhP
 R75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+KT4pH+cyOA6/nlSNn19+QpI7K+f0JeoLlhLVLoFlGk=;
 b=Y0tnR07/RhUMJTJCdewsZKlOmnupzybm2MV57x4J0lC8NCmkMipgp23dVv4ON8Sl+w
 2oCW62kD1rQMyKm+xpwbR4aYkGTV+GxS6CTRd1S4wbX0qVHwkM3XncvR661nmWZgJC4Q
 v4mQDF6Coo3FhaOAzYco06X5KKl4a2PUgfQ7vfpgyri0dtj4hXxGGTps8ziyaTaJ7MTZ
 c94NZeOrkkktfrHy9NFXGXjrcvRU12UzXuF4GvxMlJTc+EYPhwu1rECziYWEiVVjJB/u
 gbA564JSmVy8YRk/gqs99suMkVW+n7JDqREuZezzbggx+GzrFHNLNisk9BWaMfo+LxmI
 mYEw==
X-Gm-Message-State: APjAAAVJ4lwRJBxS0Zj+9suTceu3lrx7sjLMtaNHypiBuBtvkVM1RTHP
 oBe/GrqJXXCQadQtV0sS6Sq4kw==
X-Google-Smtp-Source: APXvYqwa3GN+xoYCk03zVMord2onW9kdaUM57otgGb0EWLUQ7qa7m9Rw3JGZuGW6zy3V19k9Oy9Yig==
X-Received: by 2002:a62:c541:: with SMTP id j62mr16179957pfg.237.1575658442347; 
 Fri, 06 Dec 2019 10:54:02 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g19sm17463675pfh.134.2019.12.06.10.54.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 10:54:01 -0800 (PST)
Subject: Re: [PATCH v4 27/40] target/arm: Add VHE system register redirection
 and aliasing
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-28-richard.henderson@linaro.org>
 <CAFEAcA8taFKOtz0pM-N3KRiQrguh43SNLSM__ZJH5xzVK5YkZg@mail.gmail.com>
 <ef270139-bca6-e7d9-57b8-b5a7416bbb56@linaro.org>
 <CAFEAcA-k9Ay3fEYOK=BKraFMhtm=9SxMqJNHGXZmDjpCeWGLWA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b136b9be-16c3-49d1-4766-7cb23dc99a9f@linaro.org>
Date: Fri, 6 Dec 2019 10:53:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-k9Ay3fEYOK=BKraFMhtm=9SxMqJNHGXZmDjpCeWGLWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

On 12/6/19 10:41 AM, Peter Maydell wrote:
> On Fri, 6 Dec 2019 at 18:36, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> 
>>>> +static void el2_e2h_write(CPUARMState *env, const ARMCPRegInfo *ri,
>>>> +                          uint64_t value)
>>>> +{
>>>> +    CPWriteFn *writefn;
>>>> +
>>>> +    if (redirect_for_e2h(env)) {
>>>> +        /* Switch to the saved EL2 version of the register.  */
>>>> +        ri = ri->opaque;
>>>> +        writefn = ri->writefn;
>>>> +    } else {
>>>> +        writefn = ri->orig_writefn;
>>>> +    }
>>>> +    if (writefn == NULL) {
>>>> +        writefn = raw_write;
>>>> +    }
>>>> +    writefn(env, ri, value);
>>>> +}
>>>
>>> I see how this works when we have a readfn or writefn,
>>> but how does the redirection work where the access
>>> goes directly via .fieldoffset ?
>>
>> When there is no .writefn, we use raw_write, which uses fieldoffset.
> 
> Yes, that's what I mean. There's no 'if redirect then this
> fieldoffset else that fieldoffset' codepath, so how does
> it update the right field?

Oh, for the redirected system registers, there will *always* be a .writefn --
el2_e2h_write.  What there will not necessarily be is a .orig_writefn -- in
which case we'll use raw_write.


r~


