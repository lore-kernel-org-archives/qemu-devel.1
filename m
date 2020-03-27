Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E12DC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 13:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D965D2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 13:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAJ7y3EK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D965D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHp9j-0007ev-4b
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 09:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHp96-0007GX-A3
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 09:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHp95-0007Ew-0E
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 09:35:36 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHp94-0007Am-Me
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 09:35:34 -0400
Received: by mail-pg1-x542.google.com with SMTP id 142so4570627pgf.11
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lery+U2Q++rR6Hk5UMKsDjGxpSfo7NwMfwYr58mvgIo=;
 b=OAJ7y3EKrqWXJjYetWQAOfkJ3tgazGamjAvUscW2avxoEaOwt6neVG47TrOo0hKQ9I
 B4vFt+pM0FfTUr73tZynLRtAJvzyBQydgFAaN9UpcJhCASBZXRgsqyt6smJV+0XIzoXR
 uz4vHDSeFxajb49W2Z6BJch1erMplv+b17Kc1dFPyqdBbmk2V/uZWsY6UxorBCbSQcM3
 MYZm8fkrTPWa9NOksIiUwJGEo61oNtpmhsP9oGSPOn1X7d8O1oj+b5cgaNpN73XY5LEw
 kALQJo2UVlkLmhNwdB0xbbrC1VsRp6GkvMj0SVkzsxBXykJNME854NPAqFbeocQC8YlI
 2LLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lery+U2Q++rR6Hk5UMKsDjGxpSfo7NwMfwYr58mvgIo=;
 b=LH21o9k9fB/+mrD520dWHJMqjmszhJi0ml5HfcBK8dYAiPLxpiZvcc1yH5taw5Q9gw
 c32isv+myh88RBXqmBDkXAWDF26EOkcoceIqDF8U1H7yyQGbRn77zOLyyNy4PdnNChvl
 KkOXj8wXgIGmq1B7p6L6jylI1FfwlJOvqlF+wABVi6tA410Am6jA5OWg6bkHrwFj2yUA
 UFHkAHRRSDZvAFMTHZI5pOUt+Me+JufgUipH7bzQ1S4Zj2NxNMO9CxOu/t3/oaP+eJz0
 EJQHffnFYSE/wu9+gBYQ05GO0iFT/7JAZ46EoHjDavwmnauw7ARPrXjZpjpXGQBwXoAq
 Xbjg==
X-Gm-Message-State: ANhLgQ3Gl7cBYb/SDqf8RKaW20wd9MoKMWkqByyzlbEthEgRzzNz5GWC
 CO9VWEqN2PHvOSpCR+Co+4ue0zMuhu8=
X-Google-Smtp-Source: ADFU+vuxFcxM42uoQu3G5v9QJyWpfoUnZ5Fc6bhydC2nKdLEGqPj+UU5MsT2bxBjRI3vC1UVzEYClA==
X-Received: by 2002:a63:1e4f:: with SMTP id p15mr14315431pgm.28.1585316132684; 
 Fri, 27 Mar 2020 06:35:32 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id v185sm4131944pfv.32.2020.03.27.06.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 06:35:31 -0700 (PDT)
Subject: Re: [PATCH] qemu/atomic.h: add #ifdef guards for stdatomic.h
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200326170121.13045-1-alex.bennee@linaro.org>
 <CAFEAcA8Lo84gNk2tFCKsgM_O50bXTCs6Z9jH6aCvfDA56TDCmA@mail.gmail.com>
 <ba33454a-6e57-960a-7114-fc71a9f09442@redhat.com>
 <CAFEAcA_KSVHkVznGD=cxzLaHSbPmWLN6MSqWHBqB8_ux05gD7A@mail.gmail.com>
 <87y2rmm8h6.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e10f27f8-a47f-2ebe-5cab-0c4eae43667c@linaro.org>
Date: Fri, 27 Mar 2020 06:35:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87y2rmm8h6.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 2:51 AM, Alex Bennée wrote:
> 
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Thu, 26 Mar 2020 at 18:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> On 26/03/20 18:14, Peter Maydell wrote:
>>>>> +#ifndef atomic_fetch_add
>>>>>  #define atomic_fetch_add(ptr, n) __atomic_fetch_add(ptr, n, __ATOMIC_SEQ_CST)
>>>>>  #define atomic_fetch_sub(ptr, n) __atomic_fetch_sub(ptr, n, __ATOMIC_SEQ_CST)
>>>>>  #define atomic_fetch_and(ptr, n) __atomic_fetch_and(ptr, n, __ATOMIC_SEQ_CST)
>>>>>  #define atomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_SEQ_CST)
>>>>>  #define atomic_fetch_xor(ptr, n) __atomic_fetch_xor(ptr, n, __ATOMIC_SEQ_CST)
>>>>> +#endif
>>>>
>>>> This will work around FreeBSD's current implementation in particular,
>>>> but I don't think there's anything in the C11 spec that mandates that
>>>> atomic_fetch_add() and friends have to be macros and not simply
>>>> functions...
>>>
>>> That's not a problem as long as they are all functions, the macros would
>>> simply override the function-based implementation.
>>
>> Oh yes, so it would. I think I was also vaguely thinking in terms
>> of FreeBSD being the leading edge of "one day most or all of our
>> hosts will have a full stdatomic.h", so maybe we should shift to
>> use-host-stdatomic-by-default, with the use of the gcc __atomic*
>> as the fallback at some point ?
> 
> At some point but I suspect not right now.
> 
> So what's the conclusion for this patch? Are people happy with it as a
> sticking plaster I can apply to the bounced testing PR?
> 

I guess I'm happy with it.  Have a
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

