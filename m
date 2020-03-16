Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2105CC18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC0C205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC0C205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtm6-0005KT-2p
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsPT-0007qA-AD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsPR-0006Wf-94
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:11 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56325)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsPQ-0006JS-Uf
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:09 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFb38-1j5bzV2d2s-00H5OL; Mon, 16 Mar 2020 17:16:00 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 00/38] Linux user for 5.0 patches
Date: Mon, 16 Mar 2020 17:15:12 +0100
Message-Id: <20200316161550.336150-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8MwWF+gdKaU8FduivmQrr8pxCdzf8rVZ9IH+6y9gDX5Za7jnfBp
 UH6ITk6tYzRLWuYLh1URP2nhQlk2ghMEPBVvpXtROZkVfTIzjxhpAYVD9Pflj0549u/TaZW
 hQSbaT0r5H6f4oq29WX4Yu4J4TgAusrGlMPmphjqAmI0xAExBBkhEySrrcDyk+2sPR/FZXQ
 OQIy8Iy9j2ZH1XF+sADeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PEGVsEuvAJA=:A7ZAr2IksPQiG0Fjh30QiP
 NMZGRmiapNnXdhmKPOUc5Bm3v577xubwr6Ls9eK7xd1a7oSFSGdOl+IrmRLNNtU7yi3nQhJO5
 rxm9faRIhRMcR8Qu+irXU8QM14nAW7KTMnwCP+/bk9lGxfz4fLqnyLT6GMLfnRbuwuKiqNMY2
 YIjUcdr2MJVCiqwmhA7PZiOe+XmnyPrF3C2k7ddANO2KzQu05PmyV9aeXWlQRDBRSNY+f/SVf
 BRKWzLpSU2N0y4cnCbQR4iZw+3kaI4c7d8ruS53u8NnEGE9LmxM6RFGyFN9/R+T8EO0CyMd0+
 3YN4GBG3TDSA2HUTLdvnkNupNlCJjyg3W/ew4v6jh7r7VKrcJnj2mGXcSaxaDnVr4hCnmaiZj
 hVyRUCl34VZPCi4LY5PwCuRl5xSwAiPSAlo1jsVRoclfKjz/zSthy92wc3yrT2NsyxGPPuBIb
 flJHj7Xsnui+Ooi5wpGeOCD14K4h+hlJCVNpqR45t/vnSLkfs4liBz7WwZWKtblCIW35SUpN3
 FpdcxeLkNfx8jKtGew3pf0cyGTQWxs26U/bQLmHaGE7a2Fa0E2ccY+Qqv9jTjekeN0V0MOwGv
 o4jLL9cDEjk7+yQoDxWcM0fODA0ILlJnUKvrpOGoMcCnYs4FW69N9zFNDSeORzS4fJnzN+BXl
 tWif2Wfgjmdv8b/8cKhzxM4LwBnYq9ZARXjvV7FEiEZrAeCxYTT+InucuSzBuN1sqVISDPrPX
 5SNttKkREBBFrVyrhG23Fut5bEaKCx4dkw4zF8WWtL0HC0Z0Efgyi2b0SDkJzSRi0KuaVpKzT
 dB2cpGPgr4qW+eeZoWbc4A1bzBM0SgRKX1QjZ3DkfrIhQzhTQENav83jQdK7G1Z4e3Szt+q
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 373c7068dd610e97f0b551b5a6d0a27cd6da4506:

  qemu.nsi: Install Sphinx documentation (2020-03-09 16:45:00 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request

for you to fetch changes up to 63e05b3db1e5f0560ae579050c53d1ee36ed5aca:

  linux-user, openrisc: sync syscall numbers with kernel v5.5 (2020-03-16 14:20:07 +0100)

----------------------------------------------------------------
update syscall numbers to linux 5.5 (with scripts)
add futex_time64/clock_gettime64/clock_settime64
add AT_EXECFN
Emulate x86_64 vsyscalls

----------------------------------------------------------------

Alistair Francis (4):
  linux-user: Protect more syscalls
  linux-user/syscall: Add support for clock_gettime64/clock_settime64
  linux-user: Support futex_time64
  linux-user/riscv: Update the syscall_nr's to the 5.5 kernel

Laurent Vivier (26):
  linux-user: fix socket() strace
  linux-user: introduce parameters to generate syscall_nr.h
  linux-user, alpha: add syscall table generation support
  linux-user, hppa: add syscall table generation support
  linux-user, m68k: add syscall table generation support
  linux-user, xtensa: add syscall table generation support
  linux-user, sh4: add syscall table generation support
  linux-user, microblaze: add syscall table generation support
  linux-user, arm: add syscall table generation support
  linux-user, ppc: add syscall table generation support
  linux-user, s390x: remove syscall definitions for !TARGET_S390X
  linux-user, s390x: add syscall table generation support
  linux-user, sparc, sparc64: add syscall table generation support
  linux-user, x86_64, i386: cleanup TARGET_NR_arch_prctl
  linux-user, i386: add syscall table generation support
  linux-user, x86_64: add syscall table generation support
  linux-user, mips: add syscall table generation support
  linux-user, mips64: add syscall table generation support
  linux-user, scripts: add a script to update syscall.tbl
  linux-user: update syscall.tbl from linux 0bf999f9c5e7
  linux-user,mips: move content of mips_syscall_args
  linux-user,mips: update syscall-args-o32.c.inc
  scripts: add a script to generate syscall_nr.h
  linux-user, aarch64: sync syscall numbers with kernel v5.5
  linux-user, nios2: sync syscall numbers with kernel v5.5
  linux-user, openrisc: sync syscall numbers with kernel v5.5

Lirong Yuan (2):
  linux-user: Add AT_EXECFN auxval
  linux-user: Update TASK_UNMAPPED_BASE for aarch64

Richard Henderson (5):
  target/i386: Renumber EXCP_SYSCALL
  linux-user/i386: Split out gen_signal
  linux-user/i386: Emulate x86_64 vsyscalls
  linux-user: Add x86_64 vsyscall page to /proc/self/maps
  linux-user: Flush out implementation of gettimeofday

Tobias Koch (1):
  linux-user: do prlimit selectively

 MAINTAINERS                            |   3 +
 Makefile.target                        |   3 +-
 configure                              |  35 ++
 linux-user/Makefile.objs               |  19 +-
 linux-user/aarch64/syscall_nr.h        |  34 +-
 linux-user/alpha/Makefile.objs         |   5 +
 linux-user/alpha/syscall.tbl           | 479 ++++++++++++++++
 linux-user/alpha/syscall_nr.h          | 492 -----------------
 linux-user/alpha/syscallhdr.sh         |  32 ++
 linux-user/arm/Makefile.objs           |   8 +
 linux-user/arm/syscall.tbl             | 453 +++++++++++++++
 linux-user/arm/syscall_nr.h            | 447 ---------------
 linux-user/arm/syscallhdr.sh           |  31 ++
 linux-user/elfload.c                   |   3 +-
 linux-user/hppa/Makefile.objs          |   5 +
 linux-user/hppa/syscall.tbl            | 437 +++++++++++++++
 linux-user/hppa/syscall_nr.h           | 358 ------------
 linux-user/hppa/syscallhdr.sh          |  32 ++
 linux-user/i386/Makefile.objs          |   5 +
 linux-user/i386/cpu_loop.c             | 201 +++++--
 linux-user/i386/syscall_32.tbl         | 444 +++++++++++++++
 linux-user/i386/syscall_nr.h           | 387 -------------
 linux-user/i386/syscallhdr.sh          |  28 +
 linux-user/i386/target_cpu.h           |   4 +-
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
 linux-user/mips64/Makefile.objs        |  12 +
 linux-user/mips64/syscall_n32.tbl      | 378 +++++++++++++
 linux-user/mips64/syscall_n64.tbl      | 354 ++++++++++++
 linux-user/mips64/syscall_nr.h         | 725 -------------------------
 linux-user/mips64/syscallhdr.sh        |  33 ++
 linux-user/mmap.c                      |   4 +
 linux-user/nios2/syscall_nr.h          | 650 +++++++++++-----------
 linux-user/openrisc/syscall_nr.h       | 309 +++--------
 linux-user/ppc/Makefile.objs           |   6 +
 linux-user/ppc/signal.c                |   2 +-
 linux-user/ppc/syscall.tbl             | 521 ++++++++++++++++++
 linux-user/ppc/syscall_nr.h            | 402 --------------
 linux-user/ppc/syscallhdr.sh           |  34 ++
 linux-user/riscv/syscall32_nr.h        | 295 ++++++++++
 linux-user/riscv/syscall64_nr.h        | 301 ++++++++++
 linux-user/riscv/syscall_nr.h          | 294 +---------
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
 linux-user/strace.c                    |  10 +-
 linux-user/syscall.c                   | 314 ++++++++++-
 linux-user/x86_64/Makefile.objs        |   5 +
 linux-user/x86_64/syscall_64.tbl       | 404 ++++++++++++++
 linux-user/x86_64/syscall_nr.h         | 356 ------------
 linux-user/x86_64/syscallhdr.sh        |  28 +
 linux-user/xtensa/Makefile.objs        |   5 +
 linux-user/xtensa/syscall.tbl          | 410 ++++++++++++++
 linux-user/xtensa/syscall_nr.h         | 469 ----------------
 linux-user/xtensa/syscallhdr.sh        |  32 ++
 scripts/gensyscalls.sh                 | 102 ++++
 scripts/update-mips-syscall-args.sh    |  57 ++
 scripts/update-syscalltbl.sh           |  49 ++
 target/i386/cpu.h                      |  12 +-
 target/i386/translate.c                |  14 +-
 85 files changed, 9791 insertions(+), 7914 deletions(-)
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
 delete mode 100644 linux-user/mips64/syscall_nr.h
 create mode 100644 linux-user/mips64/syscallhdr.sh
 create mode 100644 linux-user/ppc/Makefile.objs
 create mode 100644 linux-user/ppc/syscall.tbl
 delete mode 100644 linux-user/ppc/syscall_nr.h
 create mode 100644 linux-user/ppc/syscallhdr.sh
 create mode 100644 linux-user/riscv/syscall32_nr.h
 create mode 100644 linux-user/riscv/syscall64_nr.h
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
 create mode 100755 scripts/gensyscalls.sh
 create mode 100755 scripts/update-mips-syscall-args.sh
 create mode 100755 scripts/update-syscalltbl.sh

-- 
2.24.1


