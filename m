Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E0CC2D0C3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 04:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE27C20718
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 04:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE27C20718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijby0-000201-Ts
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 23:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ijbuG-00067B-R5
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 23:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ijbuF-0008BV-Fv
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 23:34:52 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:58319 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1ijbuF-00085t-8B
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 23:34:51 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 478EE1A1D37;
 Tue, 24 Dec 2019 05:34:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 204C51A0EE6;
 Tue, 24 Dec 2019 05:34:47 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] linux-user: Misc patches for 5.0
Date: Tue, 24 Dec 2019 05:34:32 +0100
Message-Id: <1577162078-29048-1-git-send-email-aleksandar.markovic@rt-rk.com>
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

This series is a collection of patches I recently accumulated.

v1->v2:

  - fixed a constant in xtensa's termbits.h that was missed in v1
  - redid syscall numbers for mips o32
  - minor formatting and wording changes

Aleksandar Markovic (6):
  linux-user: Fix some constants in termbits.h
  linux-user: mips: Update syscall numbers to kernel 5.5 rc3 level
  linux-user: Add support for FS_IOC_<GET|SET>VERSION ioctls
  linux-user: Add support for FS_IOC32_<GET|SET>FLAGS ioctls
  linux-user: Add support for FS_IOC32_<GET|SET>VERSION ioctls
  linux-user: Add support for FS_IOC_FS<GET|SET>XATTR ioctls

 linux-user/aarch64/termbits.h    |   4 +-
 linux-user/alpha/termbits.h      |  10 +--
 linux-user/arm/termbits.h        |   4 +-
 linux-user/cris/termbits.h       |   4 +-
 linux-user/hppa/termbits.h       |   4 +-
 linux-user/i386/termbits.h       |   4 +-
 linux-user/ioctls.h              |  13 ++++
 linux-user/m68k/termbits.h       |   4 +-
 linux-user/microblaze/termbits.h |   4 +-
 linux-user/mips/cpu_loop.c       |  69 +++++++++++++++++
 linux-user/mips/syscall_nr.h     |  45 +++++++++++
 linux-user/mips/termbits.h       |   4 +-
 linux-user/mips64/syscall_nr.h   |  13 ++++
 linux-user/nios2/termbits.h      |   4 +-
 linux-user/openrisc/termbits.h   |   6 +-
 linux-user/ppc/termbits.h        |   4 +-
 linux-user/riscv/termbits.h      |   4 +-
 linux-user/s390x/termbits.h      |  26 ++++---
 linux-user/sh4/termbits.h        |   4 +-
 linux-user/sparc/termbits.h      |   4 +-
 linux-user/sparc64/termbits.h    |   4 +-
 linux-user/syscall_defs.h        |  14 +++-
 linux-user/x86_64/termbits.h     |   6 +-
 linux-user/xtensa/termbits.h     | 156 ++++++++++++++++++++++-----------------
 24 files changed, 292 insertions(+), 122 deletions(-)

-- 
2.7.4


