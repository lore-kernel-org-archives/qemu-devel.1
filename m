Received: from eggs.gnu.org ([2001:4830:134:3::10]:39878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeE-0005Nk-NP
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpbeC-00005W-3q
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:46 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:35653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpbeB-00005I-SB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:49:44 -0400
Received: by mail-pf0-x235.google.com with SMTP id g13so13160548pfm.2
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:49:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 07:49:26 -0700
Message-Id: <20170906144940.30880-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/14] TCG misc queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This includes the tcg/ia64 removal, the tcg/s390 patch set that
was recently acked, a couple of Pranith's memory ordering patches,
and some fixes and additions to disas/i386.


r~


The following changes since commit b07d1c2f5607489d4d4a6a65ce36a3e896ac065e:

  Revert "kvm: use DIV_ROUND_UP" (2017-09-05 18:55:40 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20170906

for you to fetch changes up to 4609190b5f7f68a5e2a8738029594f45a062d4c9:

  tcg/s390: Use slbgr for setcond le and leu (2017-09-06 07:24:46 -0700)

----------------------------------------------------------------
Queued tcg patches

----------------------------------------------------------------
Pranith Kumar (2):
      tcg: Add tcg target default memory ordering
      tcg: Implement implicit ordering semantics

Richard Henderson (12):
      tcg: Remove support for ia64 as host
      disas/i386: Fix disassembly of two-byte vex prefixes
      disas/i386: Add disassembly of vex.0f38.f5
      disas/i386: Add disassembly of rorx
      tcg/s390: Fully convert tcg_target_op_def
      tcg/s390: Merge cmpi facilities check to tcg_target_op_def
      tcg/s390: Merge muli facilities check to tcg_target_op_def
      tcg/s390: Merge add2i facilities check to tcg_target_op_def
      tcg/s390: Merge ori+xori facilities check to tcg_target_op_def
      tcg/s390: Use distinct-operands facility
      tcg/s390: Use load-on-condition-2 facility
      tcg/s390: Use slbgr for setcond le and leu

 tcg/aarch64/tcg-target.h  |     2 +
 tcg/arm/tcg-target.h      |     2 +
 tcg/ia64/tcg-target.h     |   198 -
 tcg/mips/tcg-target.h     |     2 +
 tcg/ppc/tcg-target.h      |     2 +
 tcg/s390/tcg-target.h     |     4 +
 tcg/sparc/tcg-target.h    |     2 +
 disas.c                   |     2 -
 disas/i386.c              |    29 +-
 disas/ia64.c              | 10600 --------------------------------------------
 tcg/ia64/tcg-target.inc.c |  2482 -----------
 tcg/s390/tcg-target.inc.c |   700 +--
 tcg/tcg-op.c              |    16 +
 MAINTAINERS               |     6 -
 configure                 |     6 -
 disas/Makefile.objs       |     1 -
 16 files changed, 432 insertions(+), 13622 deletions(-)
 delete mode 100644 tcg/ia64/tcg-target.h
 delete mode 100644 disas/ia64.c
 delete mode 100644 tcg/ia64/tcg-target.inc.c
