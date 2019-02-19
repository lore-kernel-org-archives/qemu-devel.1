Received: from eggs.gnu.org ([209.51.188.92]:49390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydO-0005AH-Nb
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydM-000717-Pi
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:02 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:42524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvydK-0006zB-6G
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:11:58 -0500
Received: by mail-lf1-x144.google.com with SMTP id l10so13995929lfh.9
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:11:54 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:10:48 -0800
Message-Id: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 00/23] tests/tcg/xtensa: conditionalize xtensa
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series reorganizes xtensa tests so that they can be run on various
xtensa core configurations. It adds new tests for FPU2000 opcodes and
for FLIX. It also adds support for printing test execution trace when
preprocessor macro DEBUG is defined.

Max Filippov (23):
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

 target/xtensa/cpu.h                 |   1 +
 target/xtensa/translate.c           |  16 ++
 tests/tcg/xtensa/Makefile           |  13 +-
 tests/tcg/xtensa/linker.ld.S        |  67 +++++---
 tests/tcg/xtensa/macros.inc         |  41 ++++-
 tests/tcg/xtensa/test_b.S           |  40 ++++-
 tests/tcg/xtensa/test_boolean.S     |   4 +
 tests/tcg/xtensa/test_break.S       |  27 ++--
 tests/tcg/xtensa/test_cache.S       |  62 ++++++--
 tests/tcg/xtensa/test_clamps.S      |   4 +
 tests/tcg/xtensa/test_flix.S        |  60 +++++++
 tests/tcg/xtensa/test_fp0_arith.S   | 173 ++++++++++++++++++++
 tests/tcg/xtensa/test_fp0_conv.S    | 304 ++++++++++++++++++++++++++++++++++++
 tests/tcg/xtensa/test_fp1.S         | 141 +++++++++++++++++
 tests/tcg/xtensa/test_fp_cpenable.S |  27 ++++
 tests/tcg/xtensa/test_interrupt.S   |  88 ++++++++---
 tests/tcg/xtensa/test_loop.S        |   4 +
 tests/tcg/xtensa/test_lsc.S         | 122 +++++++++++++++
 tests/tcg/xtensa/test_mac16.S       |   4 +
 tests/tcg/xtensa/test_max.S         |   4 +
 tests/tcg/xtensa/test_min.S         |   4 +
 tests/tcg/xtensa/test_mmu.S         |   4 +
 tests/tcg/xtensa/test_mul16.S       |   4 +
 tests/tcg/xtensa/test_mul32.S       |   4 +
 tests/tcg/xtensa/test_nsa.S         |   4 +
 tests/tcg/xtensa/test_phys_mem.S    |   4 +
 tests/tcg/xtensa/test_quo.S         |   4 +
 tests/tcg/xtensa/test_rem.S         |   4 +
 tests/tcg/xtensa/test_rst0.S        |   8 +
 tests/tcg/xtensa/test_s32c1i.S      |  12 ++
 tests/tcg/xtensa/test_sext.S        |   4 +
 tests/tcg/xtensa/test_sr.S          | 153 +++++++++++++++++-
 tests/tcg/xtensa/test_timer.S       |  48 +++++-
 tests/tcg/xtensa/test_windowed.S    |  32 ++--
 tests/tcg/xtensa/vectors.S          |  14 +-
 35 files changed, 1413 insertions(+), 92 deletions(-)
 create mode 100644 tests/tcg/xtensa/test_flix.S
 create mode 100644 tests/tcg/xtensa/test_fp0_arith.S
 create mode 100644 tests/tcg/xtensa/test_fp0_conv.S
 create mode 100644 tests/tcg/xtensa/test_fp1.S
 create mode 100644 tests/tcg/xtensa/test_fp_cpenable.S
 create mode 100644 tests/tcg/xtensa/test_lsc.S

-- 
2.11.0
