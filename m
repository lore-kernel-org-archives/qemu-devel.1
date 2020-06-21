Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68943C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 18:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3482821527
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 18:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7FxZiyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3482821527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn4MA-0005sm-CR
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 14:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jn4LS-0005Rm-Fd
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 14:05:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jn4LQ-0005DD-Q2
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 14:05:30 -0400
Received: by mail-wm1-x341.google.com with SMTP id r9so12859637wmh.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AEhS/33CVU76DPPSGbij661UQ2SItHwu2LuQ6JFwLrg=;
 b=P7FxZiyTX5HWr6+TdjSC3c5juxj9dkTiWhC2YLH8d12VMQq6XRMvVC1jrVI64LbrrA
 4alElMsjn/YF1lwd5f79pmp3PpuVyfZPyACTpuJ9K8/lIiWmFidufjpbimkMRaQdQctA
 F6m8dw8M6BMqCEPpDuQ9u4sCO8uTc6Kt7189pPPcuQfk861bjmdPujWm9MLHhFy0h+hm
 Pb02ftCULnCGUCvo+uwmtoLPhZU6hOjxN/iFdXWhKNStBYoXLaBam3/3hAyoUUh3PQZ9
 h0rZyvwYwGHq1YvzUlclvt7MF97FDnITAnApEG00H04wl+XgcgQkeji9O4HDiir3qRgD
 KJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AEhS/33CVU76DPPSGbij661UQ2SItHwu2LuQ6JFwLrg=;
 b=o7Um2PeBRgGTEKIEFcE4a8E4M23hXjoBwR0QqAvsEaVxP5tAl8j3I4FhrRcZtN6nzV
 mBUyPSxx4nj0/8VIXaf2kFBuf+FoJS9+ZEFVwr+CsqTJrnsM0fgjrlG6Z1mzKEUkxsOG
 JzHROFSjhL+HatNbXHJvVNxUvcLyLM6g0/5124vuWhCAEjA6csyRnxqHy/Ya4/xLUfHe
 LRZA8+nZoaqZ8INSqPe8eRI9m9+OVkgLSgXcfN71jkmkWXDMaJHKdu7LK2q6wxdLSysq
 L1/XfSlY2YyzMDXlLqQESQLn0Ir6KSGa0EhsbhmZOMKFnEavGbRK45aLvrTty/ko9X/Y
 mzGw==
X-Gm-Message-State: AOAM533wZdEOwJt6cFFd40nlXs08SnDc/CF+y9d52tLyAczJE9BH9BuK
 lXz8gbEOjm35kT6voqv9pkqNuQ+B
X-Google-Smtp-Source: ABdhPJx3vO3OVxyoXhebMTS5gp7csqDE///48+nr1cM0gl1AudWURzdoPAmRrLYxsbPJluwRevLkyA==
X-Received: by 2002:a1c:a385:: with SMTP id
 m127mr13665761wme.112.1592762727022; 
 Sun, 21 Jun 2020 11:05:27 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u74sm13895132wmu.31.2020.06.21.11.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 11:05:26 -0700 (PDT)
Subject: Re: [PATCH] .travis.yml: Build acceptance tests with -O2 compiler
 optimization
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200620232947.17895-1-f4bug@amsat.org>
 <6ec17c5e-a7a2-ec47-cc30-807405cd39c0@amsat.org> <874kr4bn71.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <be1726dd-c84e-b874-e2b2-7fe2cee92b8a@amsat.org>
Date: Sun, 21 Jun 2020 20:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <874kr4bn71.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/20 2:47 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 6/21/20 1:29 AM, Philippe Mathieu-Daudé wrote:
>>> As we just want the tests to succeed, build them with compiler
>>> optimizations enabled to run the tests faster.
>>
>> Maybe it is a good opportunity to test -O3 instead...
>> Since this configuration is not covered.
> 
> Don't know if -O3 is worth it - even Gentoo developers warn against
> cranking it up too much.
> 
> In fact I'm surprised we don't build -O2 by default.

Do you mean in Travis or directly in ./configure?

> 
>>
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  .travis.yml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 74158f741b..61b247db9f 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -293,7 +293,7 @@ jobs:
>>>      - name: "GCC check-acceptance"
>>>        dist: bionic
>>>        env:
>>> -        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>>> +        - CONFIG="--extra-cflags=-O2 --enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>>>          - TEST_CMD="make check-acceptance"
>>>          - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-acceptance"
>>>        after_script:
>>>
> 
> 

