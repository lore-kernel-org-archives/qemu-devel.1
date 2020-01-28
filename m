Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F48C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2186F21739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2186F21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwXLg-0006u3-8A
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 15:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iwXKe-0005Mi-S3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iwXKd-0001AO-47
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:19:32 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:41529 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iwXKc-0006gK-PZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:19:31 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 2CECD1A1EA4;
 Tue, 28 Jan 2020 21:09:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 153B31A1E9A;
 Tue, 28 Jan 2020 21:09:38 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] MIPS queue for January 28th, 2020
Date: Tue, 28 Jan 2020 21:09:15 +0100
Message-Id: <1580242161-20333-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit 4c60e3289875ae6c516a37523bcecb87f68ce6=
7c:

  Merge remote-tracking branch 'remotes/rth/tags/pull-pa-20200127' into s=
taging (2020-01-28 15:11:04 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-jan-28-2020

for you to fetch changes up to 370bf3a4196ebef247752a68b89d497522168ebb:

  target/mips: Add implementation of GINVT instruction (2020-01-28 20:52:=
20 +0100)

----------------------------------------------------------------

MIPS queue for January 28th, 2020

  A diverse set of fixes and improvements:

    - finalize documentation on deprecating r4k machine
    - enable disassembler to receive target-specific data
    - enable kernel loader to get e_flags from ELF header
    - improve code flow in helper_do_semihosting()
    - amend CP0 WatchHi register implementation
    - add GINVT instruction emulation

----------------------------------------------------------------

Aleksandar Markovic (2):
  target/mips: Rectify documentation on deprecating r4k machine
  disas: Add a field for target-dependant data

Daniel Henrique Barboza (1):
  mips-semi.c: remove 'uhi_done' label in helper_do_semihosting()

Philippe Mathieu-Daud=C3=A9 (1):
  hw/core/loader: Let load_elf() populate the processor-specific flags

Yongbok Kim (2):
  target/mips: Amend CP0 WatchHi register implementation
  target/mips: Add implementation of GINVT instruction

 disas/mips.c                   |  10 +++
 hw/alpha/dp264.c               |   4 +-
 hw/arm/armv7m.c                |   2 +-
 hw/arm/boot.c                  |   2 +-
 hw/core/generic-loader.c       |   2 +-
 hw/core/loader.c               |  37 +++++-----
 hw/cris/boot.c                 |   2 +-
 hw/hppa/machine.c              |   4 +-
 hw/i386/multiboot.c            |   2 +-
 hw/i386/x86.c                  |   2 +-
 hw/lm32/lm32_boards.c          |   4 +-
 hw/lm32/milkymist.c            |   2 +-
 hw/m68k/an5206.c               |   2 +-
 hw/m68k/mcf5208.c              |   2 +-
 hw/m68k/q800.c                 |   2 +-
 hw/microblaze/boot.c           |   4 +-
 hw/mips/mips_fulong2e.c        |   2 +-
 hw/mips/mips_malta.c           |   3 +-
 hw/mips/mips_mipssim.c         |   2 +-
 hw/mips/mips_r4k.c             |   2 +-
 hw/moxie/moxiesim.c            |   2 +-
 hw/nios2/boot.c                |   4 +-
 hw/openrisc/openrisc_sim.c     |   2 +-
 hw/pci-host/prep.c             |   3 +-
 hw/ppc/e500.c                  |   2 +-
 hw/ppc/mac_newworld.c          |   4 +-
 hw/ppc/mac_oldworld.c          |   4 +-
 hw/ppc/ppc440_bamboo.c         |   2 +-
 hw/ppc/sam460ex.c              |   3 +-
 hw/ppc/spapr.c                 |   6 +-
 hw/ppc/virtex_ml507.c          |   2 +-
 hw/riscv/boot.c                |   4 +-
 hw/s390x/ipl.c                 |   7 +-
 hw/sparc/leon3.c               |   2 +-
 hw/sparc/sun4m.c               |   4 +-
 hw/sparc64/sun4u.c             |   5 +-
 hw/tricore/tricore_testboard.c |   2 +-
 hw/xtensa/sim.c                |   2 +-
 hw/xtensa/xtfpga.c             |   2 +-
 include/disas/dis-asm.h        |   3 +
 include/hw/elf_ops.h           |   6 +-
 include/hw/loader.h            |  21 +++---
 qemu-deprecated.texi           |   2 +-
 target/mips/cpu.h              |   4 +-
 target/mips/helper.c           |  20 ++++--
 target/mips/helper.h           |   5 ++
 target/mips/internal.h         |   1 +
 target/mips/machine.c          |   6 +-
 target/mips/mips-semi.c        |  15 ++--
 target/mips/op_helper.c        | 152 +++++++++++++++++++++++++++++++++++=
------
 target/mips/translate.c        |  88 +++++++++++++++++++++++-
 51 files changed, 356 insertions(+), 121 deletions(-)

--=20
2.7.4


