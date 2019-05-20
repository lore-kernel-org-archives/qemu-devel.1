Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503C8C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264A4206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264A4206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58679 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSbiA-0000zp-Dx
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 02:23:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hSbfo-0008AJ-L3
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:21:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hSbfl-0003cR-Og
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:21:24 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hSbfl-0003bo-3Z
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:21:21 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MAfQk-1hM3AS2cyO-00B3B4; Mon, 20 May 2019 08:21:16 +0200
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190519203726.20729-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <93793c2d-9fe1-d246-a678-2511b66d0a3e@vivier.eu>
Date: Mon, 20 May 2019 08:21:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190519203726.20729-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZMXyUCHVlhKuKocdhv7dfdWdeuteW7n09siobfTJ2migoG4i8H4
	txWiWjiehJKguCs+trJOj09/LdrTIBFtmYPpKvuAbt43Li1b+s7wtJbhUE9/IEAvYYp3ppY
	EnssssLJNXifg5hiwu1mhcZZLRm7Y1Mse5V7j4S+ArI14HPIhRGLmdtqHDx4haEy0UsbmzL
	qZhZJfrLU948zpMcLpHHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XWhfqq3+6wo=:zR5+XrwQHhvkXNCRe91xMK
	D5rqEYEWg1Anm2HU6uF3+MgTMz7i1PpwSIzyhOHO6zoCjJycFahSZZLcwnjX7MZF73md3jdOk
	Txq5eZRXbwm5baFYGzcdIEXQHeLDu1OZebwF4wwgesX55dz53f90qXL1KTfqplSHxHvf/0Xg1
	R4k9FRw1m2RCO3ILBWnMoJIBeHcrx+bWe7yrvSWPrbUsmd8TABhsa4BKkC7HGkBeuVQqsxT8r
	TuVz3+4urnPSP0rSY1sFZr6xJZo1U74eI0xeHwnqnFzd2+LOpZoTh6AZ7g+E0wpEc82u7mIUm
	I2BRGBXXBMyMBSKizK3WIU8/mWP8T5MvXygcHSCqNm8rKzC88EeFnyLORG1etqX0D121B0nup
	Bi0UOI5oN5h9WFvkrsp6W5vjpWySKbgfeFQM/7x/SeeMIzwPzPfu3KX/R9KjWiPR0vJ1CvYDq
	+mHMxmvA0u/h/Y2Wzh6nQG0NpbwnWtI4MWOEAS1+iPKx+wtJdqWmBUyxNcrwWQRxnkD8y+6rR
	4uvm+FEUXvwTKB0u9zx3POH9/pLURgB0YYSbnS7stDSuMvZ40Stql5A+8X8fdafEUoCow91aH
	lhli6oUCunp74ODzAc//cw3RLwD1WohWmW7yOF/C7xhJs7a/+sUYVDoeFYZZULF1CrwD/k76K
	e1XCHoQjBzvtFKwCqtl/j2pOArcKNJwGaxf4ZmxE4DIIhRdNZUDoGSvP5u/7ZGGd2iZSG9Lwm
	L+Qwa5ZuWkddzSz8vpmpIi2QBzpwFE2Ppg+m2FYpKWEM2JHYBr4zWYI/HQQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: Re: [Qemu-devel] [PATCH v7 00/74] linux-user: Split do_syscall
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

On 19/05/2019 22:36, Richard Henderson wrote:
> Based-on: <20190519201953.20161-1-richard.henderson@linaro.org>
> Aka "linux-user: path, clone, sparc, shmat fixes"
> 
> Version 6 was
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg04794.html
> 
> Since v5, I've fixed the ioctl failure that Laurent found, and
> have done a few more syscalls.
> 
> I've tried to do more testing with LTP, but it's a really annoying
> testsuite.  There are at least 3 tests that hang forever (before
> and after this patch set), and the host kernel's OOM handler kills
> my login session, ending the test run.  This seems to be different
> behaviour than I was seeing in January, when I did have test runs
> that completed successfully.
> 
> OTOH, looking back at the v6 cover letter, I now see that I was
> testing armhf and i386 as guests, whereas this time I was trying
> aarch64 and ppc64 as guests.  32-bit guests unable to trigger the
> host OOM killer?
> 
> Laurent, is there anything special that you're doing to see these
> tests run to completion?

I'm running them in a container ('unshare chroot') and aarch64 needs a 
patch that hasn't been merged:

   "[PATCH] linux-user: check valid address in access_ok()"
   https://patchew.org/QEMU/20190208173520.15007-1-remi@remlab.net/

I have a skipfile that contains:

futex_wait03
mmap13
mmap16
msgctl10
msgctl11
ptrace01
ptrace02
ptrace03
ptrace05
remap_file_pages01
remap_file_pages02
sendmsg01
fork13
fork14
creat07
mremap03

but I didn't update it for a while.

I will test as soon as possible your series in my environment.

Thanks,
Laurent

