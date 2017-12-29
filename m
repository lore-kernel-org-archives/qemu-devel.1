Received: from eggs.gnu.org ([2001:4830:134:3::10]:54094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV1hN-0006Rx-PE
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 15:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eV1hK-0002V5-C5
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 15:56:13 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:46085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eV1hK-0002TF-5O
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 15:56:10 -0500
Received: by mail-pg0-x241.google.com with SMTP id r2so5940818pgq.13
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 12:56:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 29 Dec 2017 12:56:05 -0800
Message-Id: <20171229205605.21108-1-richard.henderson@linaro.org>
In-Reply-To: <20171229193113.11753-1-richard.henderson@linaro.org>
References: <20171229193113.11753-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 0/8] tcg queued patches
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

Ho hum.  While rebasing I accidentally used a constrained build
tree that didn't build sh4-linux-user, and an extra reference to
the removed TCGV_IS_UNUSED had crept in in the meantime.

I have pushed a revised tag with the same name.


r~


The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651b8:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2017-12-22 00:11:36 +0000)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20171229

for you to fetch changes up to 4fad446bc955fcaa08a21388cf82268824bea10e:

  tcg: add cs_base and flags to -d exec output (2017-12-29 12:43:40 -0800)

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
 target/sh4/translate.c                     |   4 +-
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
 45 files changed, 313 insertions(+), 397 deletions(-)
 create mode 100644 scripts/coccinelle/cpu_restore_state.cocci
