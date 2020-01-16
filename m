Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CDAC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C096F2051A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 18:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQazUcxW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C096F2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is9l5-0007co-SQ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 13:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1is9kM-00076V-Dn
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1is9kL-0007rY-6m
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:19:58 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1is9kK-0007qg-V0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 13:19:57 -0500
Received: by mail-pj1-x1041.google.com with SMTP id d5so1911440pjz.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 10:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Uk1M32o3N7gXBPZcXOLO/40xLC60g6xi0u9mr5yNsu8=;
 b=rQazUcxWRjI+BMERLrvdzFcWHAvhXKqLUS/MdTXOk9wg5JxrTUKWsLYp+Nb+Wou66R
 5wYsIXiyQ+kVwsp+a3YA6l8iH6aznCjATzo5p8Wy+VCyjBWJyaclnXi5lifeaIXevckW
 tMUDQsu+ucHXmgSEJhxjsPHD/GPgo7vbY5QECTI66J6F8u96Tl2epXoVqrINy/0/buWz
 MyDKXUQstNSqjlEu85Igicb4FrtVNOEP3PGgkHmYWrCIFwN8Uf5+gtRPLmkgPolHJMYo
 xZbQUTLcFyuFOY29OBMqOqxIfPXmGtUIJ7xsyPDmSlj6iIZe0RvZfG4A6ICDXyz1Qb/n
 5QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Uk1M32o3N7gXBPZcXOLO/40xLC60g6xi0u9mr5yNsu8=;
 b=JDcgEuc1FdjYTR0LF9WTXCIwBS6y0uxF1RI/cdZEyZGKO1JAG6dv3UfOYmP/NmDRvw
 //4Y1zCmtmdaXrvX3Sq4eH2COKASdFoJ6cl+0SzsB33PSnIPHgoLq4rBYa5pv0aki/Ke
 ZbDhtwWD9VW6IoA9ozDv3qahw6J9yrQmcOiVi2VpAZRVBz5luXuYccgByYwGL2fG6wCB
 7n09potFDKTVVO1eeprJQ3VC8vILvBxjC0nq5N2iq2XGpNvwqt1Qc8TfG8pFiZkcZm0L
 ihXOAc7MnssYksnaZOIKB58bzUliDRm71iLC9rX3Uo+TNJ6EQk7hRyv4C8o9Ukr9rIqc
 LHSA==
X-Gm-Message-State: APjAAAVQUFzH+/mjjGkUdfVRcIguJFttQSy7fWUPvn1TpvE4CcfZ04Uw
 98trkEBI2DwSbAEobYbncVvnucMT6d4=
X-Google-Smtp-Source: APXvYqzaMVgpOse8E6gUcw1zhY18qNYAhI1as6RvLXyfn9YevVKRf2tvvZ+uqV5Zw8VzmgmdSvAnpQ==
X-Received: by 2002:a17:902:b103:: with SMTP id
 q3mr33166696plr.37.1579198795130; 
 Thu, 16 Jan 2020 10:19:55 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id j28sm26042867pgb.36.2020.01.16.10.19.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 10:19:54 -0800 (PST)
Subject: Re: [PATCH 3/3] linux-user/i386: Emulate x86_64 vsyscalls
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200114210921.11216-1-richard.henderson@linaro.org>
 <20200114210921.11216-4-richard.henderson@linaro.org>
 <87ftgfl64x.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3733f2cd-9262-d7f9-ab9c-c8a3032732df@linaro.org>
Date: Thu, 16 Jan 2020 08:19:49 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87ftgfl64x.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, riku.voipio@iki.fi,
 laurent@vivier.eu, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 6:26 AM, Alex Bennée wrote:
>> +    /*
>> +     * Perform the syscall.  None of the vsyscalls should need restarting,
>> +     * and all faults should have been caught above.
>> +     */
>> +    ret = do_syscall(env, syscall, env->regs[R_EDI], env->regs[R_ESI],
>> +                     env->regs[R_EDX], env->regs[10], env->regs[8],
>> +                     env->regs[9], 0, 0);
> 
> How come the register ABI to the syscall is different to the others. I
> can see why syscall doesn't come from EAX but the others are a different
> set to normal syscalls which might be why:

Cut and paste error, I assume.

That said, the three syscalls have a maximum of 2 arguments,
so I could really just pass EDI and ESI and 0 for the rest...

> I'm seeing a EFAULT on the gettimeofday failure:

What getttimeofday failure?  Is this related to the mention of /sbin/ldconfig
in your previous message?

>    #0  do_syscall (cpu_env=cpu_env@entry=0x5555577d2b10, num=num@entry=96, arg1=0, arg2=0, arg3=4211016, arg4=8, arg5=274888677184, arg6=274886295415, arg7=0, arg8=0) at /home/alex/lsrc/qemu.git/linux-user/syscall.c:12076                                               
>    #1  0x0000555555609b6e in emulate_vsyscall (env=0x5555577d2b10) at /home/alex/lsrc/qemu.git/linux-user/x86_64/../i386/cpu_loop.c:180
>    #2  cpu_loop (env=0x5555577d2b10) at /home/alex/lsrc/qemu.git/linux-user/x86_64/../i386/cpu_loop.c:246                              
>    #3  0x000055555559640e in main (argc=<optimized out>, argv=<optimized
>    #out>, envp=<optimized out>) at
>    #/home/alex/lsrc/qemu.git/linux-user/main.c:865
> 
> arg1/arg2 don't seem right here.

Why?  NULL value for arg1 is legal, though semi-useless.

Ah, I see that our implementation of gettimeofday doesn't honor NULL.


r~

