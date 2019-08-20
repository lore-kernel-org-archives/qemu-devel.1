Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379BAC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF972082F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF972082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzxoN-0006me-Ro
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 02:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzxmf-0004o0-1U
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzxmd-0006UU-Cg
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:38:20 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39273 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hzxmd-0006Me-1A
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:38:19 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 655571A1FC6;
 Tue, 20 Aug 2019 08:38:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 45B9B1A0F1A;
 Tue, 20 Aug 2019 08:38:15 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:37:52 +0200
Message-Id: <1566283083-21838-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 00/11] MIPS queue for August 20th, 2019
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit 50d69ee0d82378c7c21f482492dacfe0916b4863:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-softfloat-headers-190819-1' into staging (2019-08-19 15:58:01 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-aug-20-2019

for you to fetch changes up to 6eed53f71b33c3716e5d94eba506e4706d8dace8:

  target/mips: tests/tcg: Fix target configurations for MSA tests (2019-08-19 19:53:37 +0200)

----------------------------------------------------------------

MIPS queue for August 20th, 2019

Highlights:

  - this pull request consists of selected patches from "target/mips:
    Misc patches for 4.2" series; most of them are checkpatch cleanups,
    and the rest are improvements of MSA TCG tests

Note:

  - an instance of checkpatch warning on updating MAINTAINERS for a patch
    can be ignored

----------------------------------------------------------------

Aleksandar Markovic (11):
  target/mips: Style improvements in cp0_timer.c
  target/mips: Style improvements in cpu.c
  target/mips: Style improvements in machine.c
  target/mips: Style improvements in translate.c
  target/mips: Style improvements in cps.c
  target/mips: Style improvements in mips_fulong2e.c
  target/mips: Style improvements in mips_int.c
  target/mips: Style improvements in mips_malta.c
  target/mips: Style improvements in mips_mipssim.c
  target/mips: tests/tcg: Add optional printing of more detailed failure
    info
  target/mips: tests/tcg: Fix target configurations for MSA tests

 hw/mips/cps.c                                      |   6 +-
 hw/mips/mips_fulong2e.c                            |  96 ++-
 hw/mips/mips_int.c                                 |   3 +-
 hw/mips/mips_malta.c                               | 216 +++--
 hw/mips/mips_mipssim.c                             |  19 +-
 target/mips/cp0_timer.c                            |  42 +-
 target/mips/cpu.c                                  |  17 +-
 target/mips/machine.c                              |   4 +-
 target/mips/translate.c                            | 773 ++++++++---------
 tests/tcg/mips/include/test_utils_128.h            |  23 +-
 .../mips/user/ase/msa/test_msa_compile_32r5eb.sh   | 917 +++++++++++++++++++++
 .../mips/user/ase/msa/test_msa_compile_32r5el.sh   | 917 +++++++++++++++++++++
 .../mips/user/ase/msa/test_msa_compile_32r6eb.sh   | 643 ---------------
 .../mips/user/ase/msa/test_msa_compile_32r6el.sh   | 643 ---------------
 tests/tcg/mips/user/ase/msa/test_msa_run_32r5eb.sh | 371 +++++++++
 tests/tcg/mips/user/ase/msa/test_msa_run_32r5el.sh | 371 +++++++++
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6eb.sh | 371 ---------
 tests/tcg/mips/user/ase/msa/test_msa_run_32r6el.sh | 371 ---------
 18 files changed, 3231 insertions(+), 2572 deletions(-)
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


