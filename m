Received: from eggs.gnu.org ([209.51.188.92]:47000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1ESk-0001Ai-5u
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1ESh-00028Q-CQ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:45 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49551 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1ESg-00018y-Uy
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:06:43 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue,  5 Mar 2019 19:05:12 +0100
Message-Id: <1551809127-3658-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 00/15] MIPS queue for March 5th, 2019
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit 0984a157c1c053394adbf64ed7de97f1aebe6a2d:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2019-03-05 09:33:20 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-mar-05-2019

for you to fetch changes up to 0fdd986a6c8f921693d025c3f095a0eaf628b6b6:

  target/mips: Add tests for integer add MSA instruction group (2019-03-05 17:05:33 +0100)

----------------------------------------------------------------

MIPS queue for March 5th, 2019

  * cosmetic improvements of nanoMIPS disassembler code
  * MIPS TCG tests infrastructure improvements
  * new MIPS64R6 TCG tests
  * new MSA TCG tests

  Note:

  * several "MAINTAINERS" and two comment-related checkpatch.pl
  warnings are benign and can be ignored

----------------------------------------------------------------

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

Mateja Marjanovic (1):
  target/mips: Add tests for integer add MSA instruction group

 disas/nanomips.cpp                                 | 536 +++++++++++++--------
 tests/tcg/mips/include/test_inputs.h               |   4 +-
 tests/tcg/mips/include/test_inputs_32.h            | 122 +++++
 tests/tcg/mips/include/test_inputs_64.h            | 208 ++++++++
 tests/tcg/mips/include/test_utils.h                |  15 +-
 tests/tcg/mips/include/test_utils_32.h             |  78 +++
 tests/tcg/mips/include/test_utils_64.h             |  78 +++
 tests/tcg/mips/include/wrappers_mips64r6.h         |  83 ++++
 tests/tcg/mips/include/wrappers_msa.h              | 121 +++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_b.c   | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_d.c   | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_h.c   | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_w.c   | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_a_b.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_a_d.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_a_h.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_a_w.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_s_b.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_s_d.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_s_h.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_s_w.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_u_b.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_u_d.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_u_h.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_u_w.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_addv_b.c    | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_addv_d.c    | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_addv_h.c    | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_addv_w.c    | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c  | 151 ++++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c  | 151 ++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c  | 153 ++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c  | 153 ++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c  | 153 ++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c  | 153 ++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c  | 153 ++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c  | 153 ++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c  | 153 ++++++
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c  | 153 ++++++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c | 153 ++++++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c | 153 ++++++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c | 153 ++++++
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c | 153 ++++++
 .../isa/mips64r6/bit-count/test_mips64r6_clo.c     | 144 ++++++
 .../isa/mips64r6/bit-count/test_mips64r6_clz.c     | 144 ++++++
 .../isa/mips64r6/bit-count/test_mips64r6_dclo.c    | 144 ++++++
 .../isa/mips64r6/bit-count/test_mips64r6_dclz.c    | 144 ++++++
 .../isa/mips64r6/bit-swap/test_mips64r6_bitswap.c  | 144 ++++++
 .../isa/mips64r6/bit-swap/test_mips64r6_dbitswap.c | 144 ++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_dmuh.c | 151 ++++++
 .../mips64r6/int-multiply/test_mips64r6_dmuhu.c    | 151 ++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_dmul.c | 151 ++++++
 .../mips64r6/int-multiply/test_mips64r6_dmulu.c    | 151 ++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_muh.c  | 151 ++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_muhu.c | 151 ++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_mul.c  | 151 ++++++
 .../isa/mips64r6/int-multiply/test_mips64r6_mulu.c | 151 ++++++
 .../user/isa/mips64r6/logic/test_mips64r6_and.c    | 151 ++++++
 .../user/isa/mips64r6/logic/test_mips64r6_nor.c    | 151 ++++++
 .../user/isa/mips64r6/logic/test_mips64r6_or.c     | 151 ++++++
 .../user/isa/mips64r6/logic/test_mips64r6_xor.c    | 151 ++++++
 .../user/isa/mips64r6/shift/test_mips64r6_dsllv.c  | 151 ++++++
 .../user/isa/mips64r6/shift/test_mips64r6_dsrav.c  | 151 ++++++
 .../user/isa/mips64r6/shift/test_mips64r6_dsrlv.c  | 151 ++++++
 .../user/isa/mips64r6/shift/test_mips64r6_sllv.c   | 151 ++++++
 .../user/isa/mips64r6/shift/test_mips64r6_srav.c   | 151 ++++++
 .../user/isa/mips64r6/shift/test_mips64r6_srlv.c   | 151 ++++++
 71 files changed, 10376 insertions(+), 213 deletions(-)
 create mode 100644 tests/tcg/mips/include/test_inputs_32.h
 create mode 100644 tests/tcg/mips/include/test_inputs_64.h
 create mode 100644 tests/tcg/mips/include/test_utils_32.h
 create mode 100644 tests/tcg/mips/include/test_utils_64.h
 create mode 100644 tests/tcg/mips/include/wrappers_mips64r6.h
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c
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
