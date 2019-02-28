Received: from eggs.gnu.org ([209.51.188.92]:49230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gzTtD-0000RK-E6
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gzTtC-0007GO-AI
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:10:51 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f]:37784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gzTtB-0007FR-Tl
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:10:50 -0500
Received: by mail-lj1-x22f.google.com with SMTP id a17so18569041ljd.4
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 14:10:49 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 28 Feb 2019 14:10:33 -0800
Message-Id: <20190228221033.14484-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL v2 00/40] target/xtensa queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hi Peter,

please pull the following batch of target/xtensa updates.
Changes v1->v2:
- fix build with clang.

The following changes since commit 1c3d45df5e94042d5fb2bb31416072563ab30e49:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-02-04' into staging (2019-02-05 12:46:18 +0000)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20190228-xtensa

for you to fetch changes up to de0cebd93089ff2ebf2ebf9d287381eb73cbb9aa:

  tests/tcg/xtensa: add FPU2000 coprocessor tests (2019-02-28 04:43:24 -0800)

----------------------------------------------------------------
target/xtensa: FLIX support, various fixes and test improvements

- add FLIX (flexible length instructions extension) support;
- make testsuite runnable on wider range of xtensa cores;
- add floating point opcode tests;
- don't add duplicate 'static' in import_core.sh script;
- fix undefined opcodes detection in test_mmuhifi_c3 overlay.

----------------------------------------------------------------
Max Filippov (40):
      target/xtensa/import_core.sh: don't add duplicate 'static'
      target/xtensa: don't specify windowed registers manually
      target/xtensa: get rid of gen_callw[i]
      target/xtensa: fixup test_mmuhifi_c3 overlay
      target/xtensa: move xtensa_finalize_config to xtensa_core_class_init
      target/xtensa: don't require opcode table sorting
      target/xtensa: allow multiple names for single opcode
      target/xtensa: implement wide branches and loops
      target/xtensa: sort FLIX instruction opcodes
      target/xtensa: add generic instruction post-processing
      target/xtensa: move WINDOW_BASE SR update to postprocessing
      target/xtensa: only rotate window in the retw helper
      target/xtensa: reorganize register handling in translators
      target/xtensa: reorganize access to MAC16 registers
      target/xtensa: reorganize access to boolean registers
      target/xtensa: break circular register dependencies
      target/xtensa: prioritize load/store in FLIX bundles
      target/xtensa: implement PREFCTL SR
      tests/tcg/xtensa: indicate failed tests
      tests/tcg/xtensa: support configurations w/o vecbase
      tests/tcg/xtensa: support configs with LITBASE
      tests/tcg/xtensa: don't use optional opcodes in generic code
      tests/tcg/xtensa: fix endianness issues in test_b
      tests/tcg/xtensa: enable boolean tests
      tests/tcg/xtensa: conditionalize debug option tests
      tests/tcg/xtensa: conditionalize cache option tests
      tests/tcg/xtensa: add straightforward conditionals
      tests/tcg/xtensa: conditionalize interrupt tests
      tests/tcg/xtensa: conditionalize timer/CCOUNT tests
      tests/tcg/xtensa: conditionalize and expand SR tests
      tests/tcg/xtensa: fix SR tests for big endian configs
      tests/tcg/xtensa: conditionalize and fix s32c1i tests
      tests/tcg/xtensa: conditionalize windowed register tests
      tests/tcg/xtensa: conditionalize MMU-related tests
      tests/tcg/xtensa: add test for FLIX
      tests/tcg/xtensa: add LSCI/LSCX group tests
      tests/tcg/xtensa: add FP0 group arithmetic tests
      tests/tcg/xtensa: add FP0 group conversion tests
      tests/tcg/xtensa: add FP1 group tests
      tests/tcg/xtensa: add FPU2000 coprocessor tests

 .../core-test_mmuhifi_c3/xtensa-modules.inc.c      | 1322 ++++++------
 target/xtensa/cpu.h                                |   40 +-
 target/xtensa/helper.c                             |   94 +-
 target/xtensa/helper.h                             |    5 +-
 target/xtensa/import_core.sh                       |    2 +-
 target/xtensa/overlay_tool.h                       |    1 -
 target/xtensa/translate.c                          | 2114 ++++++++++----------
 target/xtensa/win_helper.c                         |   22 +-
 tests/tcg/xtensa/Makefile                          |   13 +-
 tests/tcg/xtensa/linker.ld.S                       |   67 +-
 tests/tcg/xtensa/macros.inc                        |   41 +-
 tests/tcg/xtensa/test_b.S                          |   40 +-
 tests/tcg/xtensa/test_boolean.S                    |    4 +
 tests/tcg/xtensa/test_break.S                      |   27 +-
 tests/tcg/xtensa/test_cache.S                      |   62 +-
 tests/tcg/xtensa/test_clamps.S                     |    4 +
 tests/tcg/xtensa/test_flix.S                       |   60 +
 tests/tcg/xtensa/test_fp0_arith.S                  |  173 ++
 tests/tcg/xtensa/test_fp0_conv.S                   |  304 +++
 tests/tcg/xtensa/test_fp1.S                        |  141 ++
 tests/tcg/xtensa/test_fp_cpenable.S                |   27 +
 tests/tcg/xtensa/test_interrupt.S                  |   88 +-
 tests/tcg/xtensa/test_loop.S                       |    4 +
 tests/tcg/xtensa/test_lsc.S                        |  122 ++
 tests/tcg/xtensa/test_mac16.S                      |    4 +
 tests/tcg/xtensa/test_max.S                        |    4 +
 tests/tcg/xtensa/test_min.S                        |    4 +
 tests/tcg/xtensa/test_mmu.S                        |    4 +
 tests/tcg/xtensa/test_mul16.S                      |    4 +
 tests/tcg/xtensa/test_mul32.S                      |    4 +
 tests/tcg/xtensa/test_nsa.S                        |    4 +
 tests/tcg/xtensa/test_phys_mem.S                   |    4 +
 tests/tcg/xtensa/test_quo.S                        |    4 +
 tests/tcg/xtensa/test_rem.S                        |    4 +
 tests/tcg/xtensa/test_rst0.S                       |    8 +
 tests/tcg/xtensa/test_s32c1i.S                     |   12 +
 tests/tcg/xtensa/test_sext.S                       |    4 +
 tests/tcg/xtensa/test_sr.S                         |  153 +-
 tests/tcg/xtensa/test_timer.S                      |   48 +-
 tests/tcg/xtensa/test_windowed.S                   |   32 +-
 tests/tcg/xtensa/vectors.S                         |   14 +-
 41 files changed, 3251 insertions(+), 1837 deletions(-)
 create mode 100644 tests/tcg/xtensa/test_flix.S
 create mode 100644 tests/tcg/xtensa/test_fp0_arith.S
 create mode 100644 tests/tcg/xtensa/test_fp0_conv.S
 create mode 100644 tests/tcg/xtensa/test_fp1.S
 create mode 100644 tests/tcg/xtensa/test_fp_cpenable.S
 create mode 100644 tests/tcg/xtensa/test_lsc.S

Thanks.
-- Max
