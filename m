Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528FAC18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A73420863
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A73420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTOAz-00033P-DY
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 06:08:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hTO6b-0008E8-4B
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hTO4p-000880-Oo
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:02:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hTO4n-00086E-RY
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:02:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so1537574wmh.3
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 03:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ow8UtW0xJabuzZys/UhrouAR2kIXy20cmyMzBCUpPCs=;
	b=U6N+OqLg4//zdRUMC9uoWswZGiBqEC1fprVEPPJd4SayQe45IZJ20iY6/sz3CkcBt1
	3Nx8yXv3fb+NImkt+MYojvHC9HK1jK3K086j019zaJJXLeQLdLsAkoB95JRJPhdS3w23
	P9TdTYsX/ad6QK5JRIAQkK5BAiBzfDcdnNzBNE7NJObFs7E611HM3IfNd8hftZNqj0Wq
	HezhcIyRD4GGbFerL0/xhY68ULrc0+/YGC3b8ix2yULFFFcTwAk7eVx34gKChKcyGpkI
	3otvJNJ2hrA4oSYH2ZLW8f9WyEUu6tvwqTnTBi3G9ThoR686N08GGSeVK52TmytX86tv
	Mf9g==
X-Gm-Message-State: APjAAAWf0sWVGxk9IMc0gadTFaS5IZJIzmwYVt3aZK8RtriNVssidDfN
	Xkghpd/WpTVMLAvITi7xRs0Aig==
X-Google-Smtp-Source: APXvYqzFrlGYylgN+iViXvkV/inzPVMH8r5JZoQ64g+Sq+fIt5JPlW0NDRHylTNhfs4JFh3nMppViQ==
X-Received: by 2002:a1c:a002:: with SMTP id j2mr6694976wme.131.1558519343623; 
	Wed, 22 May 2019 03:02:23 -0700 (PDT)
Received: from [10.32.181.147] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
	by smtp.gmail.com with ESMTPSA id
	s17sm4508801wmj.15.2019.05.22.03.02.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 03:02:22 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	Stefan Hajnoczi <stefanha@gmail.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<877eb4c3jm.fsf@zen.linaroharston>
	<CAFEAcA_+baJCxf1vQMJJP2cwzZ3snyHNJTWWgUqo26vUPKfszQ@mail.gmail.com>
	<20190515094830.GB29507@stefanha-x1.localdomain>
	<CAFEAcA-XC3UjNxRZ5OU5i16Nc515rYoaxEhMVc+8nD1M+VZVVg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <feef288f-e6c5-277b-7129-6facdb35c987@redhat.com>
Date: Wed, 22 May 2019 12:02:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-XC3UjNxRZ5OU5i16Nc515rYoaxEhMVc+8nD1M+VZVVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/9] Assembly coroutine
 backend and x86 CET support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/05/19 14:50, Peter Maydell wrote:
> On Wed, 15 May 2019 at 10:48, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> 1. It's required for Intel Control-flow Enforcement Technology (CET).
>>    The existing ucontext backend doesn't work with CET.
>> 2. It's faster than the existing ucontext implementation.
> 
> Mmm, I think we've talked about 1 before, but I think it would
> be useful to clearly state why we need to do things here.

The reason is that, with CET enabled, setjmp and longjmp assume that
they are used only to unwind the stack and not to switch to a completely
different one.  You are supposed to use swapcontext for that, but it
doesn't work for QEMU coroutines because it saves/restores the signal
mask; that is not only slower, it's incorrect we want the signal mask to
be a property of the thread, not the coroutine.

> It's also useful for identifying whether we need an asm
> backend for every host, or only some hosts (and if so which).

It's not needed for _any_ host (except x86 if you want CET support).  I
wrote these three backends to ensure that it could be ported without
much effort on any host.  If you prefer not having an aarch64 backend,
for example, I can leave it out.

Paolo

