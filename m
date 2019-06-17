Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4BAC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB373208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nNLNjg8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB373208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcw8K-00042z-1q
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56541)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcw5R-0001dh-7r
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcw5P-0005kD-TO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:10:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcw5P-0005iA-Ko
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:10:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id x17so11004438wrl.9
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=JvM326mIVcgy6Wf6H0hEA4+N/Cvz8bEr/6pvz61pg8Q=;
 b=nNLNjg8lN9krnv/Odq+8x+qVVvq9WUq+y81na5yxcEDrvX0m3l4Q8Bndo+nPQsVnuZ
 cHATEqZkyUfRcqXwQGOimJwOIHF/3t+aVWCX1Yw4EH3Jkikr+ll4mI/FQ/JL7Hgh2Bii
 kO4KSvEo1bmtQu9spd1LPlXdFANdFj4+Bnll9b4TJpErUhp7FbhozT2xWk3SLfx7MRe8
 PFY/VvsLRRNJuOvV/qD6llrwYNN57wU843MrgcSn8YLH01y0RcEbJTySY5HTsQ5CLUhi
 taFaiybG04ygWsne/28PozaXRqBt7djqVSjIBVud1kOGpNHBi215+oguzdQAKX/+CPHM
 KUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=JvM326mIVcgy6Wf6H0hEA4+N/Cvz8bEr/6pvz61pg8Q=;
 b=CDxgOZCRn/khyfcxRiKbhTuBs0RCU5y5SFfQHPSsSxA8rexDkJE2mFjW8vcQeO0GPq
 4D+sFmGdO3AjaIHB9U4R6sWTrtZg5TzUi8pxCIvqdEnO+iUu7MuzqVA90Vv94RpyDQeX
 fwN3Y59XHscRt22bhUa1VS7++Z/QRjeSMpuNKfIpG3wxyAkjld0uJUK4Bb4xV5vgZFD3
 fj27C9oXFxBXnfTjkMv79yE4XsztOer7d4y+idaqutuZCdKX3dRRzbsPLfRr5+5WzE9V
 Vy3WcwzvyBZm+yKMlXyVrO2M9G1HxyuHVZyXsdeY2bUJYeX3Rhgz0DyUqr/8nlvbxjTN
 Ccjg==
X-Gm-Message-State: APjAAAUR9QPa5H4Rcfs93aCh+w/RYEhpEom9rlkwvG1/mMAiAYhxOQd3
 3pkTa1pKIIHxdY/nCRaKNkkI4Q==
X-Google-Smtp-Source: APXvYqypbOhIBsyHJGgMmqstKHI6kQVC/52ycIZx0Z1uFyhT8ArgBl9lmJid7OcksgZwv8e7WYXFvA==
X-Received: by 2002:a05:6000:9:: with SMTP id
 h9mr12186096wrx.212.1560795029495; 
 Mon, 17 Jun 2019 11:10:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x8sm9571231wre.73.2019.06.17.11.10.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 11:10:28 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 845741FF87;
 Mon, 17 Jun 2019 19:10:28 +0100 (BST)
References: <20190616210546.17221-1-richard.henderson@linaro.org>
 <875zp49ocs.fsf@zen.linaroharston>
 <f8e98c93-394f-835a-4ec0-d21746bd9c2f@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <f8e98c93-394f-835a-4ec0-d21746bd9c2f@linaro.org>
Date: Mon, 17 Jun 2019 19:10:28 +0100
Message-ID: <874l4o9j6z.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/17/19 9:18 AM, Alex Benn=C3=A9e wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> Check page flags before letting an invalid pc cause a SIGSEGV.
>>>
>>> Prepare for eventially validating PROT_EXEC.  The current wrinkle being
>>> that we have a problem with our implementation of signals.  We should
>>> be using a vdso like the kernel, but we instead put the trampoline on
>>> the stack.  In the meantime, let PROT_READ match PROT_EXEC.
>>
>> We can come up with a test case for this right? Would it be triggered by
>> having:
>>
>> __attribute__((aligned(PAGE_SIZE)))
>> void some_func(void) {
>>      /* does something */
>> }
>>
>> __attribute__((aligned(PAGE_SIZE)))
>> ... rest of code ...
>>
>> main () {
>>      mmap(&some_func, PAGE_SIZE, PROT_READ, MAP_ANONYMOUS, 0, 0);
>>      some_func()
>>      /* causes SEGV */
>>      mmap(&some_func, PAGE_SIZE, PROT_READ|PROT_EXEC, MAP_ANONYMOUS, 0, =
0);
>>      some_func()
>>      /* works */
>> }
>>
>> Or is it trickier to mess with your own mapped memory?
>
> It's trickier than that, but I do have a simple test case.
>
>   https://bugs.launchpad.net/qemu/+bug/1832916
>
> But fixing that, as I mention above, makes signal trampolines fail.

Ahh I missed that. I guess we add it once we have the full solution.

>
> Or did you mean for Christophe's failure?  That's easier -- just make a N=
ULL
> function call.
>
>
> r~


--
Alex Benn=C3=A9e

