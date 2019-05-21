Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F8DC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510FE2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510FE2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55062 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT64x-0006Hb-MV
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:49:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hT63u-0005y8-Gi
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hT63s-0004Ej-EQ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:48:18 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hT63q-0004Bd-Od
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:48:15 -0400
Received: by mail-wr1-f47.google.com with SMTP id g12so18669638wro.8
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 07:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=oY3ydw4E29eSLqPmuzOulk06hJZ1kCgcs0s+vlC2jTo=;
	b=jrc9KcXQD8ISymlBBIoyA7DCg34+nGU0zbhBSlZsefTEnrU/PdukEE8IBLjlrB5Rd0
	PkUK7y7ALjhYLcBHlS74nEEpF8cByIF53lYnK6N9gc7GmNQJQH6Bpwki+3GYpOgGoRVW
	Tqz9yhuH9JCbZtKYxZ47lBVELtBw1VyBEgo7i8VEPJITG00fPrMCFOMo/4k8vkS34/fW
	VTAMUYbIq4ddCZLoqZzlp0VxHFS8A2iG2fUrQr3e6JzqmvI/oG7FrkmrjrwPwmS9FZ6n
	rkgO8b4d4L0i/R1xrZv8ujRQJcU+qZ2WXYDu9r7Y3aZFDOooxjnTRPwBsrPnkSG7SKDh
	0LRA==
X-Gm-Message-State: APjAAAWFgrzJGdt93Upup6iEe80X9fhlGkcqBtDghDgh6vdTPjkMFnLX
	SV6SZ4YvuxaBe2pIN80QRI9FzRuoxlwDaw==
X-Google-Smtp-Source: APXvYqxvq6WnLWPLY9kKM9/3En63uke55VnttHX0gls2/ugmZArdagJ4U9zxjYaI7D9hJzW8AiyoCA==
X-Received: by 2002:a05:6000:1201:: with SMTP id
	e1mr49045959wrx.136.1558450093322; 
	Tue, 21 May 2019 07:48:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844?
	([2001:b07:6468:f312:ac04:eef9:b257:b844])
	by smtp.gmail.com with ESMTPSA id
	f6sm23000355wro.12.2019.05.21.07.48.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 07:48:12 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-vSebWjhbFTdfOSGHJtr8-a+DKG22JU3tS-1OoGR=VXQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c07524e-3d2b-da06-2aac-b0eaf3e1c179@redhat.com>
Date: Tue, 21 May 2019 16:48:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-vSebWjhbFTdfOSGHJtr8-a+DKG22JU3tS-1OoGR=VXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.47
Subject: Re: [Qemu-devel] is anybody experimenting with the idea of rust
 code in QEMU?
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/19 16:39, Peter Maydell wrote:
> Hi; I have on my todo list the idea of some experimentation/prototyping
> of whether being able to write some components of QEMU in Rust would
> be (a) feasible (b) beneficial (c) fun to play around with even if
> it is likely that it doesn't go anywhere :-)
> 
> I know Paolo has had a look at how you might write some makefiles
> to integrate rust into a C program (https://github.com/bonzini/rust-and-c/).
> Has anybody else been doing anything in this general area ?

I have a version of QEMU's RCU that can be called from Rust code with a
nice API (https://github.com/bonzini/rust-rcu-qemu).  The idea was to
continue with a port of the memory API, and then to use rust-vmm's
virtio code.

Paolo

> (I went to two good talks locally recently about rust-vmm and Amazon's
> 'firecracker' VMM by Andreea Florescu and Diana Popa -- I
> definitely plan to look at rust-vmm as part of this.)
> 
> thanks
> -- PMM
> 


