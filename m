Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E51C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 21:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E53C21882
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 21:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.utexas.edu header.i=@cs.utexas.edu header.b="QHe0jOpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E53C21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.utexas.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTYNA-0001QL-Lo
	for qemu-devel@archiver.kernel.org; Sat, 09 Nov 2019 16:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rajaths@cs.utexas.edu>) id 1iTYMH-0000aa-R4
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 16:33:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rajaths@cs.utexas.edu>) id 1iTYMG-0006Tc-7S
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 16:33:25 -0500
Received: from newman.cs.utexas.edu ([128.83.139.110]:47161)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rajaths@cs.utexas.edu>)
 id 1iTYMF-0006Iv-Oo
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 16:33:24 -0500
Received: from localhost.localdomain (rrcs-72-128-130-131.sw.biz.rr.com
 [72.128.130.131]) (authenticated bits=0)
 by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 xA9LXF79032767
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
 Sat, 9 Nov 2019 15:33:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
 s=default; t=1573335197;
 bh=KKuhh8TOSl7FFzlRURehpHTVPqqL+GxcieYpfZvwRzo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=QHe0jOpVZuVNzdVPn866iXJYDCxnROxud4emjc5eYwQ4foj4bWP3/vgZiLyGKn2Km
 6BtTInXfq5t0cnFZmqYm/c3TT9EI+PMYsEsKOzDsC9slulOHRhtw9UpsKtZDdyJnPH
 YpwIdhFC2SNrrEmCsfipgQHftgF96gZZGb/0HRlo=
Subject: Re: Looking for issues/features for my first contribution
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
 <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
 <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
 <CAL1e-=hNH6HaKsczgkUdgbt18E2V2Cm6oPhSQewvMKvVTnarbA@mail.gmail.com>
From: Rajath Shashidhara <rajaths@cs.utexas.edu>
Message-ID: <1ec3ea6a-6a75-15eb-086c-d8f5e33bc0dc@cs.utexas.edu>
Date: Sat, 9 Nov 2019 15:33:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hNH6HaKsczgkUdgbt18E2V2Cm6oPhSQewvMKvVTnarbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.3.9
 (newman.cs.utexas.edu [128.83.139.110]); Sat, 09 Nov 2019 15:33:17 -0600 (CST)
X-Virus-Scanned: clamav-milter 0.100.3 at newman
X-Virus-Status: Clean
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.83.139.110
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/9/19 1:46 PM, Aleksandar Markovic wrote:

> 
> 
> Hi, Rajath.
> 
> No, it doesn't. Linux kernel has a driver for DS3231. Take a closer look.

Kernel driver found here:
https://elixir.bootlin.com/linux/v5.4-rc6/source/drivers/rtc/rtc-ds3232.c
did register NVMEM of 236 bytes with the kernel. As long as this NVMEM
is never accessed, the same driver should work for both DS3231 and DS3232.

Is there any other driver you are referring to ? Please let me know if I
missed something here.

> 
> But, in any case, you base your QEMU emulation on the *datasheet*.
> 
> The OS drivers may be helpful, but they are not a reference you base
> your solution on. The drivers may be obsolete, incorrect, incomplete, or
> just plain wrong. Additionally, as QEMU, of course, supports emulation
> of systems running variety of OSs, the existence of the Linux kernel
> driver is not a necessary condition for QEMU implementation. QEMU
> emulates many systems that Linux never ran on, and could not be run at all.
> 

I was only looking at the Kernel drivers to setup a test framework. I
plan to test my implementation using a Raspi emulation with qemu,
configure it with a DS3231 device. After this, I should be able to use
ioctl() on /dev/rtc to test the functionality:
https://linux.die.net/man/4/rtc

If you have a better approach to testing, do let me know.

Thanks,
Rajath Shashidhara

