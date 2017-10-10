Received: from eggs.gnu.org ([2001:4830:134:3::10]:60379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iq7-00029u-VB
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iq4-0004F9-R7
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:08 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:57219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1iq4-0004Ee-KS
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:04 -0400
Received: by mail-pf0-x22d.google.com with SMTP id b85so4312184pfj.13
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:56:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Oct 2017 17:55:37 -0700
Message-Id: <20171010005600.28735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/23] Queued TCG patches
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

One trivial cleanup from Jiang.  Cherry-picking half of Emilio's
patch set that has been reviewed.


r~


The following changes since commit 530049bc1dcc24c1178a29d99ca08b6dd08413e0:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-10-06 17:43:02 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20171009

for you to fetch changes up to 5de8a6a471ba6b86c6b4fb681e5a3c594ed5a684:

  tcg/mips: delete commented out extern keyword. (2017-10-09 17:07:32 -0700)

----------------------------------------------------------------
Queued tcg patches

----------------------------------------------------------------
Emilio G. Cota (22):
      cputlb: bring back tlb_flush_count under !TLB_DEBUG
      tcg: fix corruption of code_time profiling counter upon tb_flush
      exec-all: fix typos in TranslationBlock's documentation
      translate-all: make have_tb_lock static
      cpu-exec: rename have_tb_lock to acquired_tb_lock in tb_find
      tcg/i386: constify tcg_target_callee_save_regs
      tcg/mips: constify tcg_target_callee_save_regs
      tcg: remove addr argument from lookup_tb_ptr
      tcg: consolidate TB lookups in tb_lookup__cpu_state
      exec-all: bring tb->invalid into tb->cflags
      translate-all: define and use DEBUG_TB_FLUSH_GATE
      exec-all: introduce TB_PAGE_ADDR_FMT
      translate-all: define and use DEBUG_TB_INVALIDATE_GATE
      translate-all: define and use DEBUG_TB_CHECK_GATE
      exec-all: extract tb->tc_* into a separate struct tc_tb
      tci: move tci_regs to tcg_qemu_tb_exec's stack
      tcg: take .helpers out of TCGContext
      tcg: allocate optimizer temps with tcg_malloc
      util: move qemu_real_host_page_size/mask to osdep.h
      osdep: introduce qemu_mprotect_rwx/none
      translate-all: use qemu_protect_rwx/none helpers
      tcg: define TCG_HIGHWATER

Jiang Biao (1):
      tcg/mips: delete commented out extern keyword.

 accel/tcg/tcg-runtime.h    |   2 +-
 include/exec/cpu-all.h     |   2 -
 include/exec/cpu-defs.h    |   1 +
 include/exec/cputlb.h      |   3 +-
 include/exec/exec-all.h    |  19 +-
 include/exec/tb-lookup.h   |  49 ++++
 include/qemu/osdep.h       |   8 +
 tcg/tcg-op.h               |   4 +-
 tcg/tcg.h                  |   2 -
 accel/tcg/cpu-exec.c       |  73 +++---
 accel/tcg/cputlb.c         |  17 +-
 accel/tcg/tcg-runtime.c    |  34 +--
 accel/tcg/translate-all.c  | 157 ++++++-------
 exec.c                     |   4 -
 target/alpha/translate.c   |   2 +-
 target/arm/translate-a64.c |   4 +-
 target/arm/translate.c     |   5 +-
 target/hppa/translate.c    |   6 +-
 target/i386/translate.c    |  17 +-
 target/mips/translate.c    |   4 +-
 target/s390x/translate.c   |   2 +-
 target/sh4/translate.c     |   4 +-
 tcg/i386/tcg-target.inc.c  |   2 +-
 tcg/mips/tcg-target.inc.c  |   4 +-
 tcg/optimize.c             | 306 +++++++++++++------------
 tcg/tcg-op.c               |   4 +-
 tcg/tcg.c                  |  18 +-
 tcg/tci.c                  | 552 +++++++++++++++++++++++----------------------
 util/osdep.c               |  41 ++++
 util/pagesize.c            |  18 ++
 util/Makefile.objs         |   1 +
 31 files changed, 738 insertions(+), 627 deletions(-)
 create mode 100644 include/exec/tb-lookup.h
 create mode 100644 util/pagesize.c
