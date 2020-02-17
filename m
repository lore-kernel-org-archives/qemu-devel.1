Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AE2C3402C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 22:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09B920718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 22:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09B920718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3p1I-0007zG-Vg
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 17:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3p0N-0006aC-7j
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3p0L-0000R4-Il
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:36:43 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:57087)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j3p0H-0000Pa-W3; Mon, 17 Feb 2020 17:36:38 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MNtjq-1ioTxy3LL6-00OIw1; Mon, 17 Feb 2020 23:36:03 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/22] linux-user: generate syscall_nr.sh
Date: Mon, 17 Feb 2020 23:35:36 +0100
Message-Id: <20200217223558.863199-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sbeterh1R8JaGe7WCtHcR89D1s9Wfjeh3KZq0U5xP0ONjBSrzXC
 Fr5nooIZ2ZyNKPN8kETIswCwltq4upqH1I1rxv4PrFOHTRiqmrno2dnvOGlRZlEeDvGiQrC
 TWDA8r1G2BDUnJCNjxTlCrpqjgrVDqB5nVHlTrmiE7hwwcstgr0Q68sLZ3MCjoBFR+x8+TH
 ysIrgIZMq328tZW0K4U5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g5MFwxWLULo=:ajpOBsnKewG5a4cf3LCW/y
 6tzsXNq7QE1nEit9P56XnjsxVHEv4fl4ST4VrPobyBM+VlHIx/x4h5Y16yuTNKecOM4WLE/t0
 McYiPDWUUQZUH9E0UHDYXMNABW4Kp8ikVHMOuWIEhB4R5QsBTUw5KV0zoTyHw0nI8XJwS/NWI
 ArHaZt0w5l4N9aJDdvJTVTdhlTKpSZJC/Bk1AQQ5Qw1Fh2tGDGkQVXLfTUonLRR2827bp2715
 NM3qZ06O2QJQv50cS5w63iM8Ka3r0lFd0sDELFGsd2AoSNnaeM6CZgKuCBsL8okBzzZhHIC6p
 5f9O6br1F45S+JNQVgOOXD35mNhmbNGC+zhbcjhrgXtftIq3qdfZtFgtxnAHGmL4v0b3nGalX
 55x5wvwIVWqC2FxFnN6V2JVPE3vqQjTRp1eAhcXVsQzZj+n3f22ctdKDp84jeCU3NyUiI6tnn
 JQjRLjwqHMNoj5rdAP31n9MKt4hCDQdthKEgT6f3K2qXhlHtiJY9trjfijXVSfAbeHNBx0r3n
 1K1iQegOvYJ7ah2j2JYTwcITQfcF4RRenGUC2p5ugy81lWQhPJx/i68hXNgKU6k//elepRJli
 FNtsG8rkcfEE4AOnRVTk8kdx3HDBmv6yy7io78H7wzm/41iiK+NP9h8I3qLl1/QO/WN0K4cJ0
 V8bACisikVI2hELEtvss9tV6vwB+UM0flNZVk0nrDcK+Y9zR7sAlxQESJ8AFyPNBs1eePIdp7
 zA3azIu02JSnRgxWsEmW7kcdg6KYwkrA9cYUMNF2EKf1/B/Mi3V8+g2DqVq1xowU7ozag3iCU
 09/9ZzByRlrk/+zkvxR49yvuzpyaJc91D65azRwL5tQjhEJdtvyUVTzHhB8XUbF2Hamcy2u
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series copies the files syscall.tbl from linux v5.5 and generates
the file syscall_nr.h from them.

This is done for all the QEMU targets that have a syscall.tbl
in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.

tilegx and cris are depecrated in linux (tilegx has no maintainer in QEMU)

aarch64, nios2, openrisc and riscv have no syscall.tbl in linux.

It seems there is a bug in QEMU that forces to disable manually arch_prctl
with i386 target: do_arch_prctl() is only defined with TARGET_ABI32 but
TARGET_ABI32 is never defined with TARGET_I386 (nor TARGET_X86_64).

I have also removed all syscalls in s390x/syscall_nr.h defined for
!defined(TARGET_S390X).

I have added a script to copy all these files from linux and updated
them at the end of the series with their latest version for today.

The two last patches manage the special case for mips O32 that needs
to know the number of arguments. We find them in strace sources.

Laurent Vivier (22):
  linux-user: introduce parameters to generate syscall_nr.h
  linux-user,alpha: add syscall table generation support
  linux-user,hppa: add syscall table generation support
  linux-user,m68k: add syscall table generation support
  linux-user,xtensa: add syscall table generation support
  linux-user,sh4: add syscall table generation support
  linux-user,microblaze: add syscall table generation support
  linux-user,arm: add syscall table generation support
  linux-user,ppc: split syscall_nr.h
  linux-user,ppc: add syscall table generation support
  linux-user,s390x: remove syscall definitions for !TARGET_S390X
  linux-user,s390x: add syscall table generation support
  linux-user,sparc,sparc64: add syscall table generation support
  linux-user,i386: add syscall table generation support
  linux-user,x86_64: add syscall table generation support
  linux-user,mips: add syscall table generation support
  linux-user,mips64: split syscall_nr.h
  linux-user,mips64: add syscall table generation support
  linux-user,scripts: add a script to update syscall.tbl
  linux-user: update syscall.tbl from linux 0bf999f9c5e7
  linux-user,mips: move content of mips_syscall_args
  linux-user,mips: update syscall-args-o32.c.inc

 MAINTAINERS                            |   1 +
 Makefile.target                        |   3 +-
 configure                              |  23 +
 linux-user/Makefile.objs               |  19 +-
 linux-user/alpha/Makefile.objs         |   5 +
 linux-user/alpha/syscall.tbl           | 479 ++++++++++++++++
 linux-user/alpha/syscall_nr.h          | 492 -----------------
 linux-user/alpha/syscallhdr.sh         |  32 ++
 linux-user/arm/Makefile.objs           |   8 +
 linux-user/arm/syscall.tbl             | 453 ++++++++++++++++
 linux-user/arm/syscall_nr.h            | 447 ---------------
 linux-user/arm/syscallhdr.sh           |  31 ++
 linux-user/hppa/Makefile.objs          |   5 +
 linux-user/hppa/syscall.tbl            | 437 +++++++++++++++
 linux-user/hppa/syscall_nr.h           | 358 ------------
 linux-user/hppa/syscallhdr.sh          |  32 ++
 linux-user/i386/Makefile.objs          |   5 +
 linux-user/i386/syscall_32.tbl         | 444 +++++++++++++++
 linux-user/i386/syscall_nr.h           | 387 -------------
 linux-user/i386/syscallhdr.sh          |  28 +
 linux-user/m68k/Makefile.objs          |   5 +
 linux-user/m68k/syscall.tbl            | 439 +++++++++++++++
 linux-user/m68k/syscall_nr.h           | 434 ---------------
 linux-user/m68k/syscallhdr.sh          |  32 ++
 linux-user/microblaze/Makefile.objs    |   5 +
 linux-user/microblaze/syscall.tbl      | 445 +++++++++++++++
 linux-user/microblaze/syscall_nr.h     | 442 ---------------
 linux-user/microblaze/syscallhdr.sh    |  32 ++
 linux-user/mips/Makefile.objs          |   5 +
 linux-user/mips/cpu_loop.c             | 440 +--------------
 linux-user/mips/syscall-args-o32.c.inc | 436 +++++++++++++++
 linux-user/mips/syscall_nr.h           | 425 ---------------
 linux-user/mips/syscall_o32.tbl        | 427 +++++++++++++++
 linux-user/mips/syscallhdr.sh          |  36 ++
 linux-user/mips64/Makefile.objs        |   9 +
 linux-user/mips64/syscall_n32.tbl      | 378 +++++++++++++
 linux-user/mips64/syscall_n64.tbl      | 354 ++++++++++++
 linux-user/mips64/syscall_nr.h         | 719 +------------------------
 linux-user/mips64/syscallhdr.sh        |  33 ++
 linux-user/ppc/Makefile.objs           |   9 +
 linux-user/ppc/signal.c                |   2 +-
 linux-user/ppc/syscall.tbl             | 521 ++++++++++++++++++
 linux-user/ppc/syscall_nr.h            | 394 +-------------
 linux-user/ppc/syscallhdr.sh           |  34 ++
 linux-user/s390x/Makefile.objs         |   5 +
 linux-user/s390x/syscall.tbl           | 442 +++++++++++++++
 linux-user/s390x/syscall_nr.h          | 398 --------------
 linux-user/s390x/syscallhdr.sh         |  32 ++
 linux-user/sh4/Makefile.objs           |   5 +
 linux-user/sh4/syscall.tbl             | 442 +++++++++++++++
 linux-user/sh4/syscall_nr.h            | 441 ---------------
 linux-user/sh4/syscallhdr.sh           |  32 ++
 linux-user/sparc/Makefile.objs         |   5 +
 linux-user/sparc/syscall.tbl           | 485 +++++++++++++++++
 linux-user/sparc/syscall_nr.h          | 363 -------------
 linux-user/sparc/syscallhdr.sh         |  32 ++
 linux-user/sparc64/Makefile.objs       |   5 +
 linux-user/sparc64/syscall.tbl         | 485 +++++++++++++++++
 linux-user/sparc64/syscall_nr.h        | 366 -------------
 linux-user/sparc64/syscallhdr.sh       |  32 ++
 linux-user/x86_64/Makefile.objs        |   5 +
 linux-user/x86_64/syscall_64.tbl       | 404 ++++++++++++++
 linux-user/x86_64/syscall_nr.h         | 356 ------------
 linux-user/x86_64/syscallhdr.sh        |  28 +
 linux-user/xtensa/Makefile.objs        |   5 +
 linux-user/xtensa/syscall.tbl          | 410 ++++++++++++++
 linux-user/xtensa/syscall_nr.h         | 469 ----------------
 linux-user/xtensa/syscallhdr.sh        |  32 ++
 scripts/update-mips-syscall-args.sh    |  57 ++
 scripts/update-syscalltbl.sh           |  49 ++
 70 files changed, 8201 insertions(+), 6929 deletions(-)
 create mode 100644 linux-user/alpha/Makefile.objs
 create mode 100644 linux-user/alpha/syscall.tbl
 delete mode 100644 linux-user/alpha/syscall_nr.h
 create mode 100644 linux-user/alpha/syscallhdr.sh
 create mode 100644 linux-user/arm/Makefile.objs
 create mode 100644 linux-user/arm/syscall.tbl
 delete mode 100644 linux-user/arm/syscall_nr.h
 create mode 100644 linux-user/arm/syscallhdr.sh
 create mode 100644 linux-user/hppa/Makefile.objs
 create mode 100644 linux-user/hppa/syscall.tbl
 delete mode 100644 linux-user/hppa/syscall_nr.h
 create mode 100644 linux-user/hppa/syscallhdr.sh
 create mode 100644 linux-user/i386/Makefile.objs
 create mode 100644 linux-user/i386/syscall_32.tbl
 delete mode 100644 linux-user/i386/syscall_nr.h
 create mode 100644 linux-user/i386/syscallhdr.sh
 create mode 100644 linux-user/m68k/Makefile.objs
 create mode 100644 linux-user/m68k/syscall.tbl
 delete mode 100644 linux-user/m68k/syscall_nr.h
 create mode 100644 linux-user/m68k/syscallhdr.sh
 create mode 100644 linux-user/microblaze/Makefile.objs
 create mode 100644 linux-user/microblaze/syscall.tbl
 delete mode 100644 linux-user/microblaze/syscall_nr.h
 create mode 100644 linux-user/microblaze/syscallhdr.sh
 create mode 100644 linux-user/mips/Makefile.objs
 create mode 100644 linux-user/mips/syscall-args-o32.c.inc
 delete mode 100644 linux-user/mips/syscall_nr.h
 create mode 100644 linux-user/mips/syscall_o32.tbl
 create mode 100644 linux-user/mips/syscallhdr.sh
 create mode 100644 linux-user/mips64/Makefile.objs
 create mode 100644 linux-user/mips64/syscall_n32.tbl
 create mode 100644 linux-user/mips64/syscall_n64.tbl
 create mode 100644 linux-user/mips64/syscallhdr.sh
 create mode 100644 linux-user/ppc/Makefile.objs
 create mode 100644 linux-user/ppc/syscall.tbl
 create mode 100644 linux-user/ppc/syscallhdr.sh
 create mode 100644 linux-user/s390x/Makefile.objs
 create mode 100644 linux-user/s390x/syscall.tbl
 delete mode 100644 linux-user/s390x/syscall_nr.h
 create mode 100755 linux-user/s390x/syscallhdr.sh
 create mode 100644 linux-user/sh4/Makefile.objs
 create mode 100644 linux-user/sh4/syscall.tbl
 delete mode 100644 linux-user/sh4/syscall_nr.h
 create mode 100644 linux-user/sh4/syscallhdr.sh
 create mode 100644 linux-user/sparc/Makefile.objs
 create mode 100644 linux-user/sparc/syscall.tbl
 delete mode 100644 linux-user/sparc/syscall_nr.h
 create mode 100644 linux-user/sparc/syscallhdr.sh
 create mode 100644 linux-user/sparc64/Makefile.objs
 create mode 100644 linux-user/sparc64/syscall.tbl
 delete mode 100644 linux-user/sparc64/syscall_nr.h
 create mode 100644 linux-user/sparc64/syscallhdr.sh
 create mode 100644 linux-user/x86_64/Makefile.objs
 create mode 100644 linux-user/x86_64/syscall_64.tbl
 delete mode 100644 linux-user/x86_64/syscall_nr.h
 create mode 100644 linux-user/x86_64/syscallhdr.sh
 create mode 100644 linux-user/xtensa/Makefile.objs
 create mode 100644 linux-user/xtensa/syscall.tbl
 delete mode 100644 linux-user/xtensa/syscall_nr.h
 create mode 100644 linux-user/xtensa/syscallhdr.sh
 create mode 100755 scripts/update-mips-syscall-args.sh
 create mode 100755 scripts/update-syscalltbl.sh

-- 
2.24.1


