Received: from eggs.gnu.org ([209.51.188.92]:38055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gznhc-0005ct-9m
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gznhV-00044W-1J
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:07 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:38424 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gznhH-0002P9-8F
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:20:00 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  1 Mar 2019 20:18:24 +0100
Message-Id: <1551467914-11209-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 00/10] Misc target/mips fixes and
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

A collection of misc target/mips fixes and improvements for
March 2019.

v4->v5:

  - accepted patches removed
  - DSPRAM patch will be sent separately, so it is also removed
  - added several new patches on test infrastructue

v3->v4:

  - added a patch on DSPRAM support
  - order of patches slightly changed
  - minor changes in commit messages
  - rebased to the latest code

v2->v3:

  - added a patches on documenting Boston board
  - added two patches on testing integer max/min MSA instructions
  - removed four patches that had been accepted
  - amended patch on DSP-related comments

v1->v2:

  - added two patches on updating end user documentation
  - minor updates to commit messages

Aleksandar Markovic (10):
  disas: nanoMIPS: Correct comments to handlers of some DSP instructions
  tests/tcg: target/mips: Add wrappers for MSA bit set instructions
  tests/tcg: target/mips: Add wrappers for MSA pack nstructions
  tests/tcg: target/mips: Add wrappers for MSA shift instructions
  tests/tcg: target/mips: Add wrappers for MSA bit copy instructions
  tests/tcg: target/mips: Add wrappers for MSA FP max/min instructions
  tests/tcg: target/mips: Add test utilities for 64-bit tests
  tests/tcg: target/mips: Add wrappers for some MIPS64R6 instructions
  tests/tcg: target/mips: Add tests for MIPS64R6 logic instructions
  tests/tcg: target/mips: Add tests for MIPS64R6 bit swap instructions

 disas/nanomips.cpp                                 | 285 +++++++++++----------
 tests/tcg/mips/include/test_inputs_64.h            | 208 +++++++++++++++
 tests/tcg/mips/include/test_utils_64.h             |  78 ++++++
 tests/tcg/mips/include/wrappers_mips64r6.h         |  64 +++++
 tests/tcg/mips/include/wrappers_msa.h              |  70 +++++
 .../isa/mips64r6/bit-swap/test_mips64r6_bitswap.c  | 144 +++++++++++
 .../isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c | 144 +++++++++++
 .../user/isa/mips64r6/logic/test_mips64r6_and.c    | 151 +++++++++++
 .../user/isa/mips64r6/logic/test_mips64r6_nor.c    | 151 +++++++++++
 .../user/isa/mips64r6/logic/test_mips64r6_or.c     | 151 +++++++++++
 .../user/isa/mips64r6/logic/test_mips64r6_xor.c    | 151 +++++++++++
 11 files changed, 1462 insertions(+), 135 deletions(-)
 create mode 100644 tests/tcg/mips/include/test_inputs_64.h
 create mode 100644 tests/tcg/mips/include/test_utils_64.h
 create mode 100644 tests/tcg/mips/include/wrappers_mips64r6.h
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c

-- 
2.7.4
