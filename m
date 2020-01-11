Return-Path: <SRS0=vKWr=3A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F94C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 15:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26C04206ED
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 15:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C04206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqIvQ-0004Tq-PF
	for qemu-devel@archiver.kernel.org; Sat, 11 Jan 2020 10:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iqItr-0002Fj-SN
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 10:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iqItq-0002Dg-CH
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 10:42:07 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:45070 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iqItq-000873-1K
 for qemu-devel@nongnu.org; Sat, 11 Jan 2020 10:42:06 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 8BDE91A1EAC;
 Sat, 11 Jan 2020 16:41:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 6D8E21A1187;
 Sat, 11 Jan 2020 16:41:00 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/19] linux-user: Misc patches for 5.0 
Date: Sat, 11 Jan 2020 16:40:22 +0100
Message-Id: <1578757241-29583-1-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: laurent@vivier.eu, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series is a collection of linux-user patches I recently
accumulated. The summary of patches is as follows:

Patch 1: Fix for some issues in termbits.h files.
Patches 2-6: Updating syscall numbers
Patch 7: A minor xtensa cleanup
Patches 8-13: Adding support for some filesystem-related ioctls
Patches 14-16: Adding support for some floppy-drive-related ioctls
Patches 17-19: Adding support for kcov-related ioctls

History of the series:

v3->v4:

  - added support for three filesystem-related ioctls
  - added syscall number update for m68k, microblaze, x86_64 and xtensa
  - fixed some issues related to unused ranges of syscall numbers for
    mips o32
  - several minor corrections

v2->v3:

  - added support for seven floppy-drive-related ioctls
  - added support for three kcov-related ioctls

v1->v2:

  - fixed a constant in xtensa's termbits.h that was missed in v1
  - redid syscall numbers for mips o32
  - minor formatting and wording changes

Aleksandar Markovic (19):
  linux-user: Fix some constants in termbits.h
  linux-user: m68k: Update syscall numbers to kernel 5.5 rc3 level
  linux-user: microblaze: Update syscall numbers to kernel 5.5 rc3 level
  linux-user: mips: Update syscall numbers to kernel 5.5 rc3 level
  linux-user: x86_64: Update syscall numbers to kernel 5.5 rc3 level
  linux-user: xtensa: Update syscall numbers to kernel 5.5 rc3 level
  linux-user: xtensa: Remove unused constant TARGET_NR_syscall_count
  linux-user: Add support for FS_IOC_<GET|SET>VERSION ioctls
  linux-user: Add support for FS_IOC32_<GET|SET>FLAGS ioctls
  linux-user: Add support for FS_IOC32_<GET|SET>VERSION ioctls
  linux-user: Add support for FS_IOC_FS<GET|SET>XATTR ioctls
  linux-user: Add support for FITRIM ioctl
  linux-user: Add support for FIFREEZE and FITHAW ioctls
  linux-user: Add support for FD<SETEMSGTRESH|SETMAXERRS|GETMAXERRS>
    ioctls
  linux-user: Add support for FDFMT<BEG|TRK|END> ioctls
  linux-user: Add support for FDGETFDCSTAT ioctl
  configure: Detect kcov support and introduce CONFIG_KCOV
  linux-user: Add support for KCOV_<ENABLE|DISABLE> ioctls
  linux-user: Add support for KCOV_INIT_TRACE ioctl

 configure                          |  21 +++++
 linux-user/aarch64/termbits.h      |   4 +-
 linux-user/alpha/termbits.h        |  10 +--
 linux-user/arm/termbits.h          |   4 +-
 linux-user/cris/termbits.h         |   4 +-
 linux-user/hppa/termbits.h         |   4 +-
 linux-user/i386/termbits.h         |   4 +-
 linux-user/ioctls.h                |  36 +++++++++
 linux-user/m68k/syscall_nr.h       |  50 +++++++++++-
 linux-user/m68k/termbits.h         |   4 +-
 linux-user/microblaze/syscall_nr.h |  45 +++++++++++
 linux-user/microblaze/termbits.h   |   4 +-
 linux-user/mips/cpu_loop.c         |  78 ++++++++++++++++++-
 linux-user/mips/syscall_nr.h       |  45 +++++++++++
 linux-user/mips/termbits.h         |   4 +-
 linux-user/mips64/syscall_nr.h     |  13 ++++
 linux-user/nios2/termbits.h        |   4 +-
 linux-user/openrisc/termbits.h     |   6 +-
 linux-user/ppc/termbits.h          |   4 +-
 linux-user/riscv/termbits.h        |   4 +-
 linux-user/s390x/termbits.h        |  26 ++++---
 linux-user/sh4/termbits.h          |   4 +-
 linux-user/sparc/termbits.h        |   4 +-
 linux-user/sparc64/termbits.h      |   4 +-
 linux-user/syscall.c               |   3 +
 linux-user/syscall_defs.h          |  46 ++++++++++-
 linux-user/syscall_types.h         |  24 ++++++
 linux-user/x86_64/syscall_nr.h     |  24 ++++++
 linux-user/x86_64/termbits.h       |   6 +-
 linux-user/xtensa/syscall_nr.h     |  36 ++++++++-
 linux-user/xtensa/termbits.h       | 156 +++++++++++++++++++++----------------
 31 files changed, 555 insertions(+), 126 deletions(-)

-- 
2.7.4


