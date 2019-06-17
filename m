Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E262C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1C920652
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFMorwB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1C920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcv1t-0008DW-5I
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33184)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcuyD-00066O-1T
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcuyB-0001yi-0Z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:59:00 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcuy8-0001s0-Tn
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:58:58 -0400
Received: by mail-pg1-x541.google.com with SMTP id 196so6153956pgc.6
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9hHmXjsmIgSXX6IxdG6kiYxinftCn7rjEAcGgSGhsgI=;
 b=xFMorwB/o2lItiYuW8gUWPfkL8KNoryWfEYSOuAjXuKq2qTqsgyioMs+opYfyVng7f
 HzELHqYLW7kdoaKLmZxT+iVSvdOW1/BuOBNdlO0oYP/x8sIlj3hgdEcaMKsv0du7jnfW
 gg+RdDj3FHmI5fShtl3M+pOhVKnZ9EfjYN/omQG9FqCF7nujU/oCxsUjDacnIkvjY5Hv
 LX8oHPOvlFpx510z+IMr7AqXgjCzpwfqUR4szWkUFb08M8wg8lgsvafNSB0BdRHprUUc
 lObs4Cwl8+4ugOsyDcneunIEy5nMG+oJ6A8bQNtvKw76bDc0Vx6vcXToyTcL5RsdPIMM
 lkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9hHmXjsmIgSXX6IxdG6kiYxinftCn7rjEAcGgSGhsgI=;
 b=DUBmDSaGTVMOPkVni+TvBdX+XqDSM7MbrZwZvDPHpYLRO3nbMKhIyLJ/dwrEXOUQGT
 TQf2HwmjfC4Tp9lMwz1Ksnxbj10MiTGzEnqVrf2AQak1J6Wr8vso30cr4FW9F59KjaXp
 sckaVuvJ/fMErloye9ABkQgeHjH9vaCY1g9P0YNVYkWTRkWktrLTY2wcBywwk7mtuSZR
 UhhIrz1YXUgNuF80DZB25YLpGi7VjvgsgbYyNY6VSx1svk+nvSZqEd6iQdfyqWOuvkrZ
 acxNzwKCa218YK5bp+n3/ekcRZf6blx73qPg4e+C1xkYS+X/PRj+PpE7I/xpBXGd63YT
 Xc6w==
X-Gm-Message-State: APjAAAU0A3Cnq7r3RDIrhxUx3ah1+37k+j+ago0XRap6zMcORwYbCPSt
 FiInNCYgItx0gp7JHpsjfrZtZA==
X-Google-Smtp-Source: APXvYqxLe0KtH9V1VNtds3QOto2JN6THbo8IjrdGu+Ds5bfwm0msuFtvKo1G9wpHuTumD8l5q/YziQ==
X-Received: by 2002:a63:4d05:: with SMTP id a5mr46645366pgb.19.1560790735115; 
 Mon, 17 Jun 2019 09:58:55 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id y23sm15162676pfm.117.2019.06.17.09.58.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:58:54 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190616210546.17221-1-richard.henderson@linaro.org>
 <875zp49ocs.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f8e98c93-394f-835a-4ec0-d21746bd9c2f@linaro.org>
Date: Mon, 17 Jun 2019 09:58:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <875zp49ocs.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix mmap lock assert on translation
 failure
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
Cc: christophe.lyon@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/19 9:18 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Check page flags before letting an invalid pc cause a SIGSEGV.
>>
>> Prepare for eventially validating PROT_EXEC.  The current wrinkle being
>> that we have a problem with our implementation of signals.  We should
>> be using a vdso like the kernel, but we instead put the trampoline on
>> the stack.  In the meantime, let PROT_READ match PROT_EXEC.
> 
> We can come up with a test case for this right? Would it be triggered by
> having:
> 
> __attribute__((aligned(PAGE_SIZE)))
> void some_func(void) {
>      /* does something */
> }
> 
> __attribute__((aligned(PAGE_SIZE)))
> ... rest of code ...
> 
> main () {
>      mmap(&some_func, PAGE_SIZE, PROT_READ, MAP_ANONYMOUS, 0, 0);
>      some_func()
>      /* causes SEGV */
>      mmap(&some_func, PAGE_SIZE, PROT_READ|PROT_EXEC, MAP_ANONYMOUS, 0, 0);
>      some_func()
>      /* works */
> }
> 
> Or is it trickier to mess with your own mapped memory?

It's trickier than that, but I do have a simple test case.

  https://bugs.launchpad.net/qemu/+bug/1832916

But fixing that, as I mention above, makes signal trampolines fail.

Or did you mean for Christophe's failure?  That's easier -- just make a NULL
function call.


r~

