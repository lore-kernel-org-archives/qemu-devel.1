Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE27FC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48212166E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48212166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyx0t-0008W6-Tl
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 07:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iywzl-0006k0-9x
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iywzj-0007wW-7m
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:07:56 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36622 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iywzi-0007qc-Sc
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:07:55 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 143F81A1E70;
 Tue,  4 Feb 2020 13:07:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id CF1241A2085;
 Tue,  4 Feb 2020 13:07:49 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/9] linux-user: Update syscall numbers to kernel 5.5 level
Date: Tue,  4 Feb 2020 13:07:29 +0100
Message-Id: <1580818058-16159-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 Palmer Dabbelt <palmer@dabbelt.com>, amarkovic@wavecomp.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Hello, folks!

This series is a spin-off of another larger linux-user series
that become too large to handle, hence these patches related to
syscall numbers are now in this, separate, series.

Now that kernel 5.5 is released few days ago, it is time to
reflect what can be updated in linux-user for upcomming QEMU 5.0.

An obvoius kernel change we should take into account are new
system calls, and the foirst step is updating syscall numbers
mainteined within QEMU linux-user.

Regarding kernel syscal numbers there is good news and bad news.

The good news is that kernel developers decided to make future
syscall numbers much more synchonized accross architectures than
before. They already reached that state.

The bad news is that we in QEMU did not reach that state yet, since
we lag after kernel significantly.

The good news again is that we will reach that state if we update
syscall numbers accross the board now. This is the main intention
and motivation of this series.

The bad news again is that in order to update syscall numebrs we
need to be very careful at this moment. There are a number of new
syscalls added to the kernel recently that QEMU doesn't know about
at all. Significant number of new syscalls deal with 32/64-bit
compatibility, traditionally a problematic area in kernel, and in
QEMU as well. Moreover, some of the new syscalls are applicable to
32-bit architectures only.

This series covers updating syscall numbers defined in the following
files:

  - linux-user/alpha/syscall_nr.h
  - linux-user/arm/syscall_nr.h
  - linux-user/m68k/syscall_nr.h
  - linux-user/microblaze/syscall_nr.h
  - linux-user/mips/cpu_loop.c
  - linux-user/mips/syscall_nr.h
  - linux-user/mips64/syscall_nr.h
  - linux-user/sh4/syscall_nr.h
  - linux-user/x86_64/syscall_nr.h
  - linux-user/xtensa/syscall_nr.h

This series doesn't cover following files (since they use certain
proprietary rules for mapping between kernel source and qemu source,
I don't feel quite comfortable changing them - therefore I am asking
corresponding target maintainers or Lauren to update them, if
possible, before our 5.0 release):

  - linux-user/aarch64/syscall_nr.h
  - linux-user/i386/syscall_nr.h
  - linux-user/nios2/syscall_nr.h
  - linux-user/ppc/syscall_nr.h
  - linux-user/riscv/syscall_nr.h
  - linux-user/s390x/syscall_nr.h
  - linux-user/sparc/syscall_nr.h
  - linux-user/sparc64/syscall_nr.h

CC: Peter Maydell <peter.maydell@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Chris Wulff <crwulff@gmail.com>
CC: Marek Vasut <marex@denx.de>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Alistair Francis <Alistair.Francis@wdc.com>
CC: Sagar Karandikar <sagark@eecs.berkeley.edu>
CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
CC: David Hildenbrand <david@redhat.com>
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Artyom Tarasenko <atar4qemu@gmail.com>

This series also doesn't cover following files (since I can't find
corresponding kernel code - and I am also asking corresponding
target maintainers or Lauren to update them, if possible, before
our 5.0 release):

  - linux-user/cris/cpu_loop.c
  - linux-user/hppa/syscall_nr.h
  - linux-user/openrisc/syscall_nr.h
  - linux-user/tilegx/syscall_nr.h

CC: Edgar E. Iglesias <edgar.iglesias@gmail.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Stafford Horne <shorne@gmail.com>

Again, I don't plan (I am really running out of time resources) to
work in a significant way on this issue any more, and I am asking
you guys other maintainers to help finish updating syscall numbers
before QEMU 5.0 release.

Once we do that, updating syscall numbers in QEMU should and will
be significantly easier.

Thanks in advance!

Truly yours,
Aleksandar

-----------------------------------------------------------------------

Aleksandar Markovic (9):
  linux-user: alpha: Update syscall numbers to kernel 5.5 level
  linux-user: arm: Update syscall numbers to kernel 5.5 level
  linux-user: m68k: Update syscall numbers to kernel 5.5 level
  linux-user: microblaze: Update syscall numbers to kernel 5.5 level
  linux-user: mips: Update syscall numbers to kernel 5.5 level
  linux-user: sh4: Update syscall numbers to kernel 5.5 level
  linux-user: x86_64: Update syscall numbers to kernel 5.5 level
  linux-user: xtensa: Update syscall numbers to kernel 5.5 level
  linux-user: xtensa: Remove unused constant TARGET_NR_syscall_count

 linux-user/alpha/syscall_nr.h      | 35 +++++++++++++++++
 linux-user/arm/syscall_nr.h        | 44 +++++++++++++++++++++
 linux-user/m68k/syscall_nr.h       | 50 +++++++++++++++++++++++-
 linux-user/microblaze/syscall_nr.h | 45 ++++++++++++++++++++++
 linux-user/mips/cpu_loop.c         | 78 +++++++++++++++++++++++++++++++++++++-
 linux-user/mips/syscall_nr.h       | 45 ++++++++++++++++++++++
 linux-user/mips64/syscall_nr.h     | 13 +++++++
 linux-user/sh4/syscall_nr.h        | 48 +++++++++++++++++++++++
 linux-user/x86_64/syscall_nr.h     | 24 ++++++++++++
 linux-user/xtensa/syscall_nr.h     | 36 +++++++++++++++++-
 10 files changed, 414 insertions(+), 4 deletions(-)

-- 
2.7.4


