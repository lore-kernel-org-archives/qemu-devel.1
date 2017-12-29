Received: from eggs.gnu.org ([2001:4830:134:3::10]:42655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV0NE-0000jB-PG
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV0NB-000061-JF
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:20 -0500
Received: from mail-pl0-x22c.google.com ([2607:f8b0:400e:c01::22c]:35625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eV0NB-00005W-C7
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:31:17 -0500
Received: by mail-pl0-x22c.google.com with SMTP id b96so23439688pli.2
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 11:31:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 29 Dec 2017 11:31:05 -0800
Message-Id: <20171229193113.11753-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/8] tcg queued patches
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

Two reviewed patches from the 2.11 soft-freeze era, and five
preparatory patches extract from my host vector patch set.


r~


The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651b8:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2017-12-22 00:11:36 +0000)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20171229

for you to fetch changes up to d034b92af6687e1ba436ee9541c91f78af20b47f:

  tcg: add cs_base and flags to -d exec output (2017-12-28 20:38:54 -0800)

----------------------------------------------------------------
Queued TCG patches

----------------------------------------------------------------
Alex Bennée (1):
      target/*helper: don't check retaddr before calling cpu_restore_state

Paolo Bonzini (1):
      tcg: add cs_base and flags to -d exec output

Richard Henderson (6):
      target/moxie: Fix tlb_fill
      tcg: Remove TCGV_UNUSED* and TCGV_IS_UNUSED*
      tcg: Dynamically allocate TCGOps
      tcg: Generalize TCGOp parameters
      tcg: Add tcg_signed_cond
      tcg: Allow 6 arguments to TCG helpers

 include/exec/gen-icount.h                  |   9 +-
 include/exec/helper-gen.h                  |  11 +++
 include/exec/helper-head.h                 |   2 +
 include/exec/helper-proto.h                |   5 +
 include/exec/helper-tcg.h                  |   7 ++
 include/qemu/queue.h                       |   5 +
 target/arm/translate.h                     |  10 +-
 tcg/tcg-op.h                               |   4 -
 tcg/tcg.h                                  |  60 +++++-------
 accel/tcg/cpu-exec.c                       |   6 +-
 accel/tcg/tcg-runtime.c                    |   5 +-
 target/alpha/mem_helper.c                  |  13 +--
 target/alpha/translate.c                   |  22 ++---
 target/arm/op_helper.c                     |  18 ++--
 target/arm/translate-a64.c                 |  37 ++++---
 target/arm/translate.c                     |  31 +++---
 target/cris/translate.c                    |   4 +-
 target/hppa/translate.c                    |  63 ++++++------
 target/i386/svm_helper.c                   |   4 +-
 target/i386/translate.c                    |  13 ++-
 target/lm32/op_helper.c                    |   7 +-
 target/lm32/translate.c                    |   2 -
 target/m68k/op_helper.c                    |   7 +-
 target/m68k/translate.c                    |  14 +--
 target/microblaze/op_helper.c              |   7 +-
 target/microblaze/translate.c              |   4 -
 target/mips/translate.c                    |   2 +-
 target/moxie/helper.c                      |   5 +-
 target/nios2/mmu.c                         |   7 +-
 target/nios2/translate.c                   |   6 +-
 target/openrisc/mmu_helper.c               |   6 +-
 target/ppc/translate.c                     |   2 +-
 target/s390x/translate.c                   |  42 ++++----
 target/sh4/translate.c                     |   2 +-
 target/sparc/translate.c                   |   2 +-
 target/tilegx/translate.c                  |  10 +-
 target/tricore/op_helper.c                 |  13 +--
 target/unicore32/op_helper.c               |   7 +-
 target/unicore32/translate.c               |   4 +-
 tcg/optimize.c                             |  20 +---
 tcg/tcg-op.c                               |  24 -----
 tcg/tcg.c                                  | 149 +++++++++++------------------
 tcg/tci.c                                  |  12 ++-
 tcg/tci/tcg-target.inc.c                   |   6 +-
 scripts/coccinelle/cpu_restore_state.cocci |  19 ++++
 45 files changed, 312 insertions(+), 396 deletions(-)
 create mode 100644 scripts/coccinelle/cpu_restore_state.cocci
