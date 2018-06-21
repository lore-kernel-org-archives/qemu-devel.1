Received: from eggs.gnu.org ([2001:4830:134:3::10]:33288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fW0iE-0000UM-01
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fW0iA-0003i8-Pm
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:37:26 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:33553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fW0iA-0003gs-9R
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:37:22 -0400
Received: by mail-pg0-x233.google.com with SMTP id e11-v6so1533618pgq.0
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 07:37:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 21 Jun 2018 04:37:15 -1000
Message-Id: <20180621143715.27176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2.5 00/19] tcg queued patches
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

Re-issuing the v2 pull request with the proper form.


r~


The following changes since commit 42747d6abb5035473e5585fa17620c1e8983a70b:

  Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-06-15.for-upstream' into staging (2018-06-15 17:28:37 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20180615

for you to fetch changes up to 9f754620651d3432114f4bb89c7f12cbea814b3e:

  tcg: Reduce max TB opcode count (2018-06-15 09:39:53 -1000)

----------------------------------------------------------------
TCG patch queue:

Workaround macos assembler lossage.
Eliminate tb_lock.
Fix TB code generation overflow.

----------------------------------------------------------------
Emilio G. Cota (17):
      qht: require a default comparison function
      qht: return existing entry when qht_insert fails
      tcg: track TBs with per-region BST's
      tcg: move tb_ctx.tb_phys_invalidate_count to tcg_ctx
      translate-all: iterate over TBs in a page with PAGE_FOR_EACH_TB
      translate-all: make l1_map lockless
      translate-all: remove hole in PageDesc
      translate-all: work page-by-page in tb_invalidate_phys_range_1
      translate-all: move tb_invalidate_phys_page_range up in the file
      translate-all: use per-page locking in !user-mode
      translate-all: add page_locked assertions
      translate-all: introduce assert_no_pages_locked
      translate-all: discard TB when tb_link_page returns an existing matching TB
      translate-all: protect TB jumps with a per-destination-TB lock
      cputlb: remove tb_lock from tlb_flush functions
      translate-all: remove tb_lock mention from cpu_restore_state_from_tb
      tcg: remove tb_lock

John Arbuckle (1):
      tcg/i386: Use byte form of xgetbv instruction

Richard Henderson (1):
      tcg: Reduce max TB opcode count

 accel/tcg/translate-all.h       |    6 +-
 include/exec/cpu-common.h       |    2 +-
 include/exec/exec-all.h         |   51 +-
 include/exec/memory-internal.h  |    6 +-
 include/exec/tb-context.h       |    4 -
 include/qemu/qht.h              |   32 +-
 tcg/tcg.h                       |   19 +-
 accel/tcg/cpu-exec.c            |   96 ++--
 accel/tcg/cputlb.c              |    8 -
 accel/tcg/translate-all.c       | 1045 +++++++++++++++++++++++++++------------
 exec.c                          |   26 +-
 linux-user/main.c               |    3 -
 tcg/aarch64/tcg-target.inc.c    |    2 +-
 tcg/arm/tcg-target.inc.c        |    2 +-
 tcg/i386/tcg-target.inc.c       |    7 +-
 tcg/mips/tcg-target.inc.c       |    2 +-
 tcg/ppc/tcg-target.inc.c        |    4 +-
 tcg/s390/tcg-target.inc.c       |    2 +-
 tcg/sparc/tcg-target.inc.c      |    4 +-
 tcg/tcg.c                       |  218 +++++++-
 tcg/tci/tcg-target.inc.c        |    2 +-
 tests/qht-bench.c               |   18 +-
 tests/test-qht.c                |   23 +-
 util/qht.c                      |   41 +-
 docs/devel/multi-thread-tcg.txt |   24 +-
 25 files changed, 1157 insertions(+), 490 deletions(-)
