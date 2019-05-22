Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CB4C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4DB2089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4DB2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43305 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRKR-0004D6-78
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:30:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hTRIp-0003FC-AZ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hTRIo-0007mR-Cz
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:29:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hTRIo-0007Wt-6h
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:29:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so4746338wme.0
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 06:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=+dLJ0LePWde9C91jtMK5co33oto1XGS+1XRVuhoNJEo=;
	b=p06BKD/qt3fp1eP7F/wOQEc4GCIarvq1/QeSWwj2uXTlBAy9wti18mkqPYLZvuUiGP
	pr2u8cCl7gBC/xkWYl5cy3Wj9ayC6ZrZtglJRVrjQL7nyIEPv0/Jstm9vYr+hklfYhWT
	5UfuCzwRUFD6rAksiJZRZtPVxmCh76ETTLl30jbYP0Nn7tZQkQ+YmYp809FXDOrX1K9h
	eoDLh9UZCBkMs2M/+J0P+OaUlWrjh3bQ1QzQZlNpjxtNF7b2WTf0nm299lfXIB/kkqR1
	x09JuXkn+X/z39mJ485KDu6kWoo6vWIU+oG/XaVVWFoJU05P0+VCGBPcizFHg86QpVIc
	XItg==
X-Gm-Message-State: APjAAAVm8brYn92A4BErr2NpAtHJgjzFZJbuvi/g4IHIMFlihMs4QZ0M
	98lJdUU6qmImQeUd17QUBT40mQ==
X-Google-Smtp-Source: APXvYqztadVxjGeSB0sA/0dlmBHTxLPiL79xWWn01lRd9+Rw83Y1OQbiUxsb1NyM/goKURFVHdQrXQ==
X-Received: by 2002:a1c:2dd2:: with SMTP id t201mr7493736wmt.136.1558531722145;
	Wed, 22 May 2019 06:28:42 -0700 (PDT)
Received: from [10.32.181.147] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
	by smtp.gmail.com with ESMTPSA id n5sm2867933wrj.27.2019.05.22.06.28.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 06:28:41 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA-vSebWjhbFTdfOSGHJtr8-a+DKG22JU3tS-1OoGR=VXQ@mail.gmail.com>
	<20190522125348.GH27900@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95f2e1c8-5307-9aa0-601a-e4ee53c199fb@redhat.com>
Date: Wed, 22 May 2019 15:28:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522125348.GH27900@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/05/19 14:53, Stefan Hajnoczi wrote:
> On Tue, May 21, 2019 at 03:39:40PM +0100, Peter Maydell wrote:
>> Hi; I have on my todo list the idea of some experimentation/prototyping
>> of whether being able to write some components of QEMU in Rust would
>> be (a) feasible (b) beneficial (c) fun to play around with even if
>> it is likely that it doesn't go anywhere :-)
>>
>> I know Paolo has had a look at how you might write some makefiles
>> to integrate rust into a C program (https://github.com/bonzini/rust-and-c/).
>> Has anybody else been doing anything in this general area ?
>>
>> (I went to two good talks locally recently about rust-vmm and Amazon's
>> 'firecracker' VMM by Andreea Florescu and Diana Popa -- I
>> definitely plan to look at rust-vmm as part of this.)
> 
> There are some in-development vhost-user device backends in Rust.
> Sergio Lopez is working on a vhost-user-blk implementation.  David
> Gilbert is working on a vhost-user-fs implementation.
> 
> I think mixing Rust and C code in the main QEMU binary itself is
> probably more trouble than it's worth.  Think boilerplate, duplication,
> coming up with safe Rust APIs for QEMU's unsafe APIs.

This is true.  The case I was playing with is where the QEMU APIs have a
more or less direct mapping to rust-vmm APIs and only have a limited
number of dependencies on other C APIs.  This way, you can either write
a Rust binding to the C code, or rewrite the C code in Rust with tiny C
wrapper APIs on top.

For example, the memory API (more or less) depends only on RCU and maps
to rust-vmm/vm-memory, and virtqueue processing in rust-vmm/vm-virtio
depends only on the memory API.

Thanks,

Paolo

> I'm more interested in using Rust for separate processes that can be
> written from scratch.
> 
> Stefan
> 


