Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7373AC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A2F20757
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A2F20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErUM-000216-FH
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jErRs-0005HD-V7
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jErRr-0004C1-Qc
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:44 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43937)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jErRr-0004Bf-Hs
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:43 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MzTCy-1jSFT54AS0-00vPiz; Thu, 19 Mar 2020 10:26:32 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/16] Linux user for 5.0 patches
Date: Thu, 19 Mar 2020 10:26:11 +0100
Message-Id: <20200319092627.51487-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:c1M9r1eB1prs0FrJzZNHQwP4jA0U2EIuxOFTZp7JkIvFI6asImf
 u3ZbBC6j5jRGUBUgev5UHW/p616J72dsxrBwnxHx8C+3mlwX+4juQNqjXYSwAUCp8hoeVyl
 QkLiuNaxz1a7PpPk1Sp+oA39cyf5XZx/PnD7qsJix8INEvDYQBFjae1xDjq0zPBuJ7qGqHE
 weaU0VglvCH4LxoMu4pDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qie6hs6ShXw=:5kMEaujtzTaqE8d/SvogDV
 kB0VCKS2LC6fdJComIb/xDRO5zHcAs0K/OW+V3MF8cwK+O0fGY/nwHkbpg7cNCop0GXR7NptC
 Z6RFPwR775ZuDduyZLw5cKHYa6/vtHFGKMdqjs5tWi2Vy5EXDZzdgnaM01JJIdSb6GIwNO7oD
 L6YsZXgh1i0UbFU2mhzOAnUx+3VIPT3Qk9tXf28AeZFK5CPxhV4d27fre1td/7i8SLqxdyToa
 gtzmeaTv9wCdVNOe6IxCfl0tdql6k5QRdWuMkO6od41Zf/a2pnc0Fp1KkbgRmpIjQ/5wWOcgj
 QC96EubkebMsmAx9PfvFbuj4C+VS2N0jpaFBiRfMq5mUJNmBkVlycg3In3DjMTdhtwjKYslPZ
 8JS7K8hzbSY+snBzW3GNFzndQROcL4wKuHIseAFJ8bXdEsWuayBFFVwoRZmESpL8BWC8avFsh
 xZ0R+QVaBFitN8FrPvDzAQr3wemuPwWVJeRAnV14a+jKRKdsB/aTuKRhtzYcpVUmtxXXG0Y6L
 0JFES3+EvsaysE3w8+3qUGUtWuDo3zzij+XSzusmsgM1iGsnAMSnY/lkScuzTN1HWSJ3ZO2Vu
 cEZjmf0PQyAftygOqRKNXRo2LPOIpjNnEJQA/JX+HMBaIgHfGbWkCND/zlQD1NEiG+suKsliG
 eVo0TwmWzZdrT/tqsdK2Unn9o3pX9/Fo4EhlUb+UsUDqCdmnDR6iBkXwzGQ6yQLT3qL0mG7eR
 a50dWhAPXRrkbNC7HlcGF1ArHwrRpaJDSEoNr2LjTeL6hr18iSa9yzKfxon9R/mgcCIE6cEmz
 esgoG8FRbf3DLdPJ+pe82smIXsNXdBVKtUp7AGmg7wmx54eDRDb0Futhu6gUM063fR7fYqM
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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

for you to fetch changes up to c91518bb0649f09e2c636790603907ef93ea95d4:

  linux-user, openrisc: sync syscall numbers with kernel v5.5 (2020-03-19 09:22:21 +0100)

----------------------------------------------------------------
update syscall numbers to linux 5.5 (with scripts)
add futex_time64/clock_gettime64/clock_settime64
add AT_EXECFN
Emulate x86_64 vsyscalls

v3: remove syscall.tbl series
v2: guard copy_to_user_timezone() with TARGET_NR_gettimeofday
    remove "Support futex_time64" patch
    guard sys_futex with TARGET_NR_exit

----------------------------------------------------------------

Alistair Francis (3):
  linux-user: Protect more syscalls
  linux-user/syscall: Add support for clock_gettime64/clock_settime64
  linux-user/riscv: Update the syscall_nr's to the 5.5 kernel

Laurent Vivier (5):
  linux-user: fix socket() strace
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

 MAINTAINERS                      |   1 +
 linux-user/aarch64/syscall_nr.h  |  34 +-
 linux-user/elfload.c             |   3 +-
 linux-user/i386/cpu_loop.c       | 201 +++++++---
 linux-user/mmap.c                |   4 +
 linux-user/nios2/syscall_nr.h    | 650 +++++++++++++++----------------
 linux-user/openrisc/syscall_nr.h | 309 +++------------
 linux-user/riscv/syscall32_nr.h  | 295 ++++++++++++++
 linux-user/riscv/syscall64_nr.h  | 301 ++++++++++++++
 linux-user/riscv/syscall_nr.h    | 294 +-------------
 linux-user/strace.c              |  10 +-
 linux-user/syscall.c             | 153 +++++++-
 scripts/gensyscalls.sh           | 102 +++++
 target/i386/cpu.h                |  12 +-
 target/i386/translate.c          |  14 +-
 15 files changed, 1437 insertions(+), 946 deletions(-)
 create mode 100644 linux-user/riscv/syscall32_nr.h
 create mode 100644 linux-user/riscv/syscall64_nr.h
 create mode 100755 scripts/gensyscalls.sh

-- 
2.25.1


