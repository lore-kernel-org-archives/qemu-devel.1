Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBE7C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5410206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5410206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv20G-0001BL-KX
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iv1z9-0007zF-PG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:39:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iv1z8-0006mu-K4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:39:07 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60733 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iv1z8-0006jX-CH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:39:06 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 775B71A211E;
 Fri, 24 Jan 2020 17:39:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 5D8BF1A2006;
 Fri, 24 Jan 2020 17:39:02 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/7] target/mips: Misc MIPS fixes and improvements for 5.0
Date: Fri, 24 Jan 2020 17:38:42 +0100
Message-Id: <1579883929-1517-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
Cc: aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series contains a variety of fixes and improvements for
target MIPS.

v3->v4:

  - split micromips R6 disassembler patch to more manageable parts
  - added new field to disassemble_info structure
  - CRC32 refactoring is as is in this version, but refactoring is
    planned for near future

v2->v3:

  - added micromips R6 disassembler

Aleksandar Markovic (5):
  target/mips: Rectify documentation on deprecating r4k machine
  target/mips: Add support for MIPS<32|64>R6 CRC32 ISA
  disas: Add a field for target-dependant data
  disas: mips: Add micromips R6 disassembler - infrastructure and 16-bit
    instructions
  disas: mips: Add micromips R6 disassembler - 32-bit instructions

Yongbok Kim (2):
  target/mips: Amend CP0 WatchHi register implementation
  target/mips: Add implementation of GINVT instruction

 disas/Makefile.objs     |    1 +
 disas/micromips_r6.c    | 5670 +++++++++++++++++++++++++++++++++++++++++++++++
 disas/mips.c            |   10 +
 include/disas/dis-asm.h |    4 +
 qemu-deprecated.texi    |    2 +-
 target/mips/cpu.c       |    4 +
 target/mips/cpu.h       |    4 +-
 target/mips/helper.c    |   20 +-
 target/mips/helper.h    |    7 +
 target/mips/internal.h  |    1 +
 target/mips/machine.c   |    6 +-
 target/mips/op_helper.c |  171 +-
 target/mips/translate.c |  215 +-
 13 files changed, 6081 insertions(+), 34 deletions(-)
 create mode 100644 disas/micromips_r6.c

-- 
2.7.4


