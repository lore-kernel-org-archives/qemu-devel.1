Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3E9C3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517F520851
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517F520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzgVV-0003ke-5d
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTb-0001rl-3v
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTZ-0002Yj-HM
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:30 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56367 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hzgTZ-0001cg-5r
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:29 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id C9ED51A206C;
 Mon, 19 Aug 2019 14:08:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 9E2B61A203D;
 Mon, 19 Aug 2019 14:08:23 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:07:39 +0200
Message-Id: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v8 00/37] target/mips: Misc patches for 4.2
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
Cc: arikalo@wavecomp.com, philmd@redhat.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series includes misc MIPS patches intended to be integrated after
4.1 release.

v7->v8:

  - added several more patches on CP0 cleanup
  - added a patch on translate.c cleanup
  - other minor improvements

v6->v7:

  - added four more patches on CP0 cleanup
  - other minor improvements

v5->v6:

  - added five more patches on style improvements
  - added five patches on CP0 cleanup
  - other minor improvements

v4->v5:

  - fixed more build errors
  - added five patches on style improvements
  - added a patch on updating vmstate
  - other minor improvements

v3->v4:

  - fixed build error

v2->v3:

  - corrected the patch on WatchHi to include "mi" field
  - corrected the patch on WatchHi to bump VMStateDescription version

v1->v2:

  - fixed checkpatch warnings
  - added four new patches on various topics


Aleksandar Markovic (32):
  target/mips: Style improvements in cp0_timer.c
  target/mips: Style improvements in cpu.c
  target/mips: Style improvements in internal.h
  target/mips: Style improvements in machine.c
  target/mips: Style improvements in helper.c
  target/mips: Style improvements in translate.c
  target/mips: Style improvements in cps.c
  target/mips: Style improvements in mips_fulong2e.c
  target/mips: Style improvements in mips_int.c
  target/mips: Style improvements in mips_malta.c
  target/mips: Style improvements in mips_mipssim.c
  target/mips: Clean up handling of CP0 register 0
  target/mips: Clean up handling of CP0 register 1
  target/mips: Clean up handling of CP0 register 2
  target/mips: Clean up handling of CP0 register 5
  target/mips: Clean up handling of CP0 register 6
  target/mips: Clean up handling of CP0 register 7
  target/mips: Clean up handling of CP0 register 8
  target/mips: Clean up handling of CP0 register 10
  target/mips: Clean up handling of CP0 register 11
  target/mips: Clean up handling of CP0 register 12
  target/mips: Clean up handling of CP0 register 15
  target/mips: Clean up handling of CP0 register 16
  target/mips: Clean up handling of CP0 register 17
  target/mips: Clean up handling of CP0 register 20
  target/mips: Clean up handling of CP0 register 23
  target/mips: Clean up handling of CP0 register 24
  target/mips: Clean up handling of CP0 register 26
  target/mips: Clean up handling of CP0 register 30
  target/mips: Clean up handling of CP0 register 31
  target/mips: tests/tcg: Add optional printing of more detailed failure
    info
  target/mips: tests/tcg: Fix target configurations for MSA tests

Yongbok Kim (5):
  target/mips: Add support for DSPRAM
  target/mips: Amend CP0 WatchHi register implementation
  target/mips: Amend CP0 MemoryMapID register implementation
  target/mips: Add support for emulation of GINVT instruction
  target/mips: Add support for emulation of CRC32 group of instructions

 disas/mips.c                                       |   10 +
 hw/mips/cps.c                                      |   35 +-
 hw/mips/mips_fulong2e.c                            |   96 +-
 hw/mips/mips_int.c                                 |    3 +-
 hw/mips/mips_malta.c                               |  216 +--
 hw/mips/mips_mipssim.c                             |   19 +-
 hw/misc/Makefile.objs                              |    1 +
 hw/misc/mips_dspram.c                              |  153 +++
 include/hw/mips/cps.h                              |    2 +
 include/hw/misc/mips_dspram.h                      |   46 +
 target/mips/cp0_timer.c                            |   42 +-
 target/mips/cpu.c                                  |   17 +-
 target/mips/cpu.h                                  |   62 +-
 target/mips/helper.c                               |  122 +-
 target/mips/helper.h                               |    7 +
 target/mips/internal.h                             |   61 +-
 target/mips/machine.c                              |   17 +-
 target/mips/op_helper.c                            |  185 ++-
 target/mips/translate.c                            | 1449 +++++++++++---------
 target/mips/translate_init.inc.c                   |    2 +
 tests/tcg/mips/include/test_utils_128.h            |   23 +-
 .../mips/user/ase/msa/test_msa_compile_32r5eb.sh   |  917 +++++++++++++
 .../mips/user/ase/msa/test_msa_compile_32r5el.sh   |  917 +++++++++++++
 .../mips/user/ase/msa/test_msa_compile_32r6eb.sh   |  643 ---------
 .../mips/user/ase/msa/test_msa_compile_32r6el.sh   |  643 ---------
 tests/tcg/mips/user/ase/msa/test_msa_run_32r5eb.sh |  371 +++++
 tests/tcg/mips/user/ase/msa/test_msa_run_32r5el.sh |  371 +++++
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh |  371 -----
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh |  371 -----
 29 files changed, 4250 insertions(+), 2922 deletions(-)
 create mode 100644 hw/misc/mips_dspram.c
 create mode 100644 include/hw/misc/mips_dspram.h
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r5eb.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r5el.sh
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6eb.sh
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_compile_32r6el.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r5eb.sh
 create mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r5el.sh
 delete mode 100644 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh
 delete mode 100755 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh

-- 
2.7.4


