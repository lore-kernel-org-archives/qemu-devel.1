Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE58AC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990DB21569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 15:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYhUs8N8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990DB21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itvpP-0001kS-QD
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 10:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1itvop-0001Lx-Ac
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:51:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1itvom-0001LY-7Q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:51:55 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1itvol-0001LA-V7
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 10:51:52 -0500
Received: by mail-pl1-x642.google.com with SMTP id p9so1494448plk.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 07:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V7vmM2K+05tl2NmFDA3FYC6BYv0lFYgWok3xvqqXizI=;
 b=lYhUs8N88W8enKgMWY2Zklqvzoy9PFJTgPKX7Qu1ronw4mPbyISr0KZBqdukqsOBZa
 PwxTtnwps6BtnWw1qqTkfkN8kWKs5AvivgW4Je/j73uMUKPKC1RCLcevKxqNQW04awq5
 adN95rZGI6FJlZwvbyrsPHdr7rRZ0kTES8ABljQIV+gDfF8IjC8elDIfA+mfx9k70O/Z
 pcc4kkWqpSgzYbgY71mJGrnNKgz5U7xJLsEZAvHT1DZLEfEWUIRR9L9mDncKwVdbDwZN
 KMIIRDpmFh9Utz5N8sajdRWfBB46Wt0TmRwvBtzYTissufytMiimF8ek/38EJSuTkmds
 ZBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V7vmM2K+05tl2NmFDA3FYC6BYv0lFYgWok3xvqqXizI=;
 b=BusfOUwolOI4L5TY9fOD35qwtEbQhyzfyxfeQGBF1aEy+DrKJkR66ZKAVi514+e2eu
 xJoS1qNYgxVXaydzQGUN/TRsIHMF5OXB2IxvSgpMUIe2V3mgmFJfVdK7qmdmRo8W5Jau
 xYH5HByKo0AzCKgHOWWJCBWLEenp72c4mXwruCwPuO2w+WJakyCw1X6dDw6M8t+bmDXx
 9s1MAImfZsool3BfUyKUyI89HZSYsjZmkSeBt9tfA+CaMOuSJw0ZrPlpq8UdsObcv49v
 wW44Q2CluciCQ0AiEEASdSKITljYoQ6toyQhyqXS04zpo0kA2BiqW6Z2wBybpj4s1auP
 sAFg==
X-Gm-Message-State: APjAAAXW2VdohwOQLtdZPl2j/8rNJ+DDUxFSdIpbDVBCDRknuxeydq+Z
 7NjqQJu230tw1uItEmaY23m0jA==
X-Google-Smtp-Source: APXvYqww6vt4lQ85Y1lYVoRxywhwOIfqCYJ2woXSXrzyBQLV77MiLcZf0VHQIkpaH50xdtSJm376dg==
X-Received: by 2002:a17:902:7009:: with SMTP id
 y9mr6136190plk.254.1579621910751; 
 Tue, 21 Jan 2020 07:51:50 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id x18sm44832674pfr.26.2020.01.21.07.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 07:51:50 -0800 (PST)
Subject: Re: [PATCH v2 3/5] linux-user/i386: Emulate x86_64 vsyscalls
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200116194341.402-1-richard.henderson@linaro.org>
 <20200116194341.402-4-richard.henderson@linaro.org>
 <87v9p62vt5.fsf@linaro.org> <e384935c-7fc2-77eb-352d-90aa95ba89a9@linaro.org>
 <87r1zt15jg.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e383d1d6-7c08-ba3c-6e8b-971d62a9d2cb@linaro.org>
Date: Tue, 21 Jan 2020 05:51:46 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87r1zt15jg.fsf@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 12:13 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 1/20/20 1:48 AM, Alex Bennée wrote:
>>>> +    default:
>>>> +    sigsegv:
>>>
>>> this label looks a little extraneous.
>>>
>>> Otherwise:
>>>
>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>>
>>
>> Look a little further down:
>>
>>> +    default:
>>> +    sigsegv:
>>> +        /* Like force_sig(SIGSEGV).  */
>>> +        gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
>>> +        return;
>>> +    }
>>> +
>>> +    /*
>>> +     * Validate the return address.
>>> +     * Note that the kernel treats this the same as an invalid entry point.
>>> +     */
>>> +    if (get_user_u64(caller, env->regs[R_ESP])) {
>>> +        goto sigsegv;
>>> +    }
> 
> Wouldn't this read better:
> 
>     /*
>      * Validate the entry point.  We have already validated the page
>      * during translation, now verify the offset.
>      */
>     switch (env->eip & ~TARGET_PAGE_MASK) {
>     case 0x000:
>         syscall = TARGET_NR_gettimeofday;
>         break;
>     case 0x400:
>         syscall = TARGET_NR_time;
>         break;
>     case 0x800:
>         syscall = TARGET_NR_getcpu;
>         break;
>     default:
>         syscall = -1;
>         break;
>     }
> 
>     /*
>      * If we have an invalid entry point or an invalid return address we
>      * generate a SIGSEG.
>      */
>     if (syscall < 0 || get_user_u64(caller, env->regs[R_ESP])) {
>         gen_signal(env, TARGET_SIGSEGV, TARGET_SI_KERNEL, 0);
>         return;
>     }
> 

Only if you have a violent goto allergy.


r~

