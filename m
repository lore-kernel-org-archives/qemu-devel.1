Received: from eggs.gnu.org ([209.51.188.92]:35196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h0uuK-00034X-A5
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h0upy-0002df-M2
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:09:28 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:41268 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h0upy-0002cJ-7W
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 16:09:26 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  4 Mar 2019 22:08:56 +0100
Message-Id: <1551733750-4902-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 00/14] Misc target/mips fixes and
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

A collection of misc target/mips fixes and improvements for March 2019.

v6->v7:

  - added a patch on nanomips instruction pool organization in disas
  - added a patch on fixing 128-bit test infrastructure
  - added a patch on extending MSA wrappers macro functionality
  - added a patch on MIPS64R6 bit count instructions tests
  - minor improvements in other patches
  - order of patches slightly changed

v5->v6:

  - addressed Philippe's comments from v5
  - all patches on MSA wrappers squashed
  - added a patch on 32-bit test infrastructure
  - added a patch on MIPS64R6 bit count instructions tests
  - added a patch on MIPS64R6 shift instructions tests
  - added a patch on MIPS64R6 integer multiply instructions tests
  - added a patch on MSA pack instructions tests

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

Aleksandar Markovic (14):
  disas: nanoMIPS: Correct comments to handlers of some DSP instructions
  disas: nanoMIPS: Add graphical description of pool organization
  tests/tcg: target/mips: Add wrappers for various MSA instructions
  tests/tcg: target/mips: Add test utilities for 32-bit tests
  tests/tcg: target/mips: Add test utilities for 64-bit tests
  tests/tcg: target/mips: Fix test utilities for 128-bit tests
  tests/tcg: target/mips: Extend functionality of MSA wrapper macros
  tests/tcg: target/mips: Add wrappers for some MIPS64R6 instructions
  tests/tcg: target/mips: Add tests for MIPS64R6 logic instructions
  tests/tcg: target/mips: Add tests for MIPS64R6 bit swap instructions
  tests/tcg: target/mips: Add tests for MIPS64R6 bit count instructions
  tests/tcg: target/mips: Add tests for MIPS64R6 shift instructions
  tests/tcg: target/mips: Add tests for MIPS64R6 int multiply
    instructions
  tests/tcg: target/mips: Add tests for MSA pack instructions

 disas/nanomips.cpp                                 | 387 ++++++++++++++-------
 tests/tcg/mips/include/test_inputs.h               |   4 +-
 tests/tcg/mips/include/test_inputs_32.h            | 122 +++++++
 tests/tcg/mips/include/test_inputs_64.h            | 208 +++++++++++
 tests/tcg/mips/include/test_utils.h                |  15 +-
 tests/tcg/mips/include/test_utils_32.h             |  78 +++++
 tests/tcg/mips/include/test_utils_64.h             |  78 +++++
 tests/tcg/mips/include/wrappers_mips64r6.h         |  83 +++++
 tests/tcg/mips/include/wrappers_msa.h              | 121 +++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c  | 153 ++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c  | 153 ++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c  | 153 ++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c  | 153 ++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c  | 153 ++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c  | 153 ++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c  | 153 ++++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c  | 153 ++++++++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c | 153 ++++++++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c | 153 ++++++++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c | 153 ++++++++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c | 153 ++++++++
 .../isa/mips64r6/bit-count/test_mips64r6_clo.c     | 144 ++++++++
 .../isa/mips64r6/bit-count/test_mips64r6_clz.c     | 144 ++++++++
 .../isa/mips64r6/bit-count/test_mips64r6_dclo.c    | 144 ++++++++
 .../isa/mips64r6/bit-count/test_mips64r6_dclz.c    | 144 ++++++++
 .../isa/mips64r6/bit-swap/test_mips64r6_bitswap.c  | 144 ++++++++
 .../isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c | 144 ++++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_dmuh.c | 151 ++++++++
 .../mips64r6/int-multiply/test_mips64r6_dmuhu.c    | 151 ++++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_dmul.c | 151 ++++++++
 .../mips64r6/int-multiply/test_mips64r6_dmulu.c    | 151 ++++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_muh.c  | 151 ++++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_muhu.c | 151 ++++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_mul.c  | 151 ++++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_mulu.c | 151 ++++++++
 .../user/isa/mips64r6/logic/test_mips64r6_and.c    | 151 ++++++++
 .../user/isa/mips64r6/logic/test_mips64r6_nor.c    | 151 ++++++++
 .../user/isa/mips64r6/logic/test_mips64r6_or.c     | 151 ++++++++
 .../user/isa/mips64r6/logic/test_mips64r6_xor.c    | 151 ++++++++
 .../user/isa/mips64r6/shift/test_mips64r6_dsllv.c  | 151 ++++++++
 .../user/isa/mips64r6/shift/test_mips64r6_dsrav.c  | 151 ++++++++
 .../user/isa/mips64r6/shift/test_mips64r6_dsrlv.c  | 151 ++++++++
 .../user/isa/mips64r6/shift/test_mips64r6_sllv.c   | 151 ++++++++
 .../user/isa/mips64r6/shift/test_mips64r6_srav.c   | 151 ++++++++
 .../user/isa/mips64r6/shift/test_mips64r6_srlv.c   | 151 ++++++++
 45 files changed, 6370 insertions(+), 144 deletions(-)
 create mode 100644 tests/tcg/mips/include/test_inputs_32.h
 create mode 100644 tests/tcg/mips/include/test_inputs_64.h
 create mode 100644 tests/tcg/mips/include/test_utils_32.h
 create mode 100644 tests/tcg/mips/include/test_utils_64.h
 create mode 100644 tests/tcg/mips/include/wrappers_mips64r6.h
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clo.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_clz.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclo.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-count/test_mips64r6_dclz.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_bitswap.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuh.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmuhu.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmul.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_dmulu.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muh.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_muhu.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mul.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/int-multiply/test_mips64r6_mulu.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_and.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_nor.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_or.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/logic/test_mips64r6_xor.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsllv.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrav.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_dsrlv.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_sllv.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srav.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/shift/test_mips64r6_srlv.c

-- 
2.7.4
