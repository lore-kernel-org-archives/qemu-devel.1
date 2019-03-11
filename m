Received: from eggs.gnu.org ([209.51.188.92]:57131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h3Lsj-0004zh-OR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h3LsY-0001NK-SX
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:26:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:53975 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h3LsO-0000eq-9D
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:26:10 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 11 Mar 2019 15:24:43 +0100
Message-Id: <1552314290-28709-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 0/7] MIPS queue for March 11th, 2019
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

The following changes since commit e2a18635a400b0e68679614132e9ef6316105590:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-03-08' into staging (2019-03-09 20:55:44 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-mar-11-2019

for you to fetch changes up to 53e116fed6dde572003aebf3bc32e25663eeb446:

  target/mips: Add tests for a variety of MSA integer subtract instructions (2019-03-11 12:45:36 +0100)

----------------------------------------------------------------

MIPS queue for March 11th, 2019

  - MIPS TCG tests updates and cleanups

  Note:

  - six checkpatch.pl warnings on "MAINTAINERS" can be ignored

----------------------------------------------------------------

Aleksandar Markovic (2):
  tests/tcg: target/mips: Correct preambles of test source files
  tests/tcg: target/mips: Rename two header files for consistency

Mateja Marjanovic (5):
  target/mips: Add tests for a variety of MSA integer average
    instructions
  target/mips: Add tests for a variety of MSA integer divide
    instructions
  target/mips: Add tests for a variety of MSA integer dot product
    instructions
  target/mips: Add tests for a variety of MSA integer multiply
    instructions
  target/mips: Add tests for a variety of MSA integer subtract
    instructions

 .../include/{test_inputs.h => test_inputs_128.h}   |   8 +-
 .../include/{test_utils.h => test_utils_128.h}     |   8 +-
 tests/tcg/mips/include/wrappers_msa.h              |   4 +-
 .../mips/user/ase/msa/bit-count/test_msa_nloc_b.c  |   8 +-
 .../mips/user/ase/msa/bit-count/test_msa_nloc_d.c  |   8 +-
 .../mips/user/ase/msa/bit-count/test_msa_nloc_h.c  |   8 +-
 .../mips/user/ase/msa/bit-count/test_msa_nloc_w.c  |   8 +-
 .../mips/user/ase/msa/bit-count/test_msa_nlzc_b.c  |   8 +-
 .../mips/user/ase/msa/bit-count/test_msa_nlzc_d.c  |   8 +-
 .../mips/user/ase/msa/bit-count/test_msa_nlzc_h.c  |   8 +-
 .../mips/user/ase/msa/bit-count/test_msa_nlzc_w.c  |   8 +-
 .../mips/user/ase/msa/bit-count/test_msa_pcnt_b.c  |   8 +-
 .../mips/user/ase/msa/bit-count/test_msa_pcnt_d.c  |   8 +-
 .../mips/user/ase/msa/bit-count/test_msa_pcnt_h.c  |   8 +-
 .../mips/user/ase/msa/bit-count/test_msa_pcnt_w.c  |   8 +-
 .../mips/user/ase/msa/int-add/test_msa_add_a_b.c   |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_add_a_d.c   |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_add_a_h.c   |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_add_a_w.c   |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_a_b.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_a_d.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_a_h.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_a_w.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_s_b.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_s_d.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_s_h.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_s_w.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_u_b.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_u_d.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_u_h.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_adds_u_w.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_addv_b.c    |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_addv_d.c    |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_addv_h.c    |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_addv_w.c    |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c  |   6 +-
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c  |   6 +-
 .../user/ase/msa/int-average/test_msa_ave_s_b.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_s_d.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_s_h.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_s_w.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_u_b.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_u_d.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_u_h.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_ave_u_w.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_s_b.c   | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_s_d.c   | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_s_h.c   | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_s_w.c   | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_u_b.c   | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_u_d.c   | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_u_h.c   | 151 ++++++++++++++++++++
 .../user/ase/msa/int-average/test_msa_aver_u_w.c   | 151 ++++++++++++++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_b.c |   8 +-
 .../mips/user/ase/msa/int-compare/test_msa_ceq_d.c |   8 +-
 .../mips/user/ase/msa/int-compare/test_msa_ceq_h.c |   8 +-
 .../mips/user/ase/msa/int-compare/test_msa_ceq_w.c |   8 +-
 .../user/ase/msa/int-compare/test_msa_cle_s_b.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_cle_s_d.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_cle_s_h.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_cle_s_w.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_cle_u_b.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_cle_u_d.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_cle_u_h.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_cle_u_w.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_clt_s_b.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_clt_s_d.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_clt_s_h.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_clt_s_w.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_clt_u_b.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_clt_u_d.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_clt_u_h.c    |   8 +-
 .../user/ase/msa/int-compare/test_msa_clt_u_w.c    |   8 +-
 .../user/ase/msa/int-divide/test_msa_div_s_b.c     | 151 ++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_s_d.c     | 151 ++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_s_h.c     | 151 ++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_s_w.c     | 151 ++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_u_b.c     | 151 ++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_u_d.c     | 151 ++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_u_h.c     | 151 ++++++++++++++++++++
 .../user/ase/msa/int-divide/test_msa_div_u_w.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dotp_s_d.c    | 151 ++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dotp_s_h.c    | 151 ++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dotp_s_w.c    | 151 ++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dotp_u_d.c    | 151 ++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dotp_u_h.c    | 151 ++++++++++++++++++++
 .../ase/msa/int-dot-product/test_msa_dotp_u_w.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_a_b.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_max_a_d.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_max_a_h.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_max_a_w.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_max_s_b.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_max_s_d.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_max_s_h.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_max_s_w.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_max_u_b.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_max_u_d.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_max_u_h.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_max_u_w.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_min_a_b.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_min_a_d.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_min_a_h.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_min_a_w.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_min_s_b.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_min_s_d.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_min_s_h.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_min_s_w.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_min_u_b.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_min_u_d.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_min_u_h.c    |   8 +-
 .../user/ase/msa/int-max-min/test_msa_min_u_w.c    |   8 +-
 .../user/ase/msa/int-multiply/test_msa_mul_q_h.c   | 151 ++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mul_q_w.c   | 151 ++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mulr_q_h.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mulr_q_w.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mulv_b.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mulv_d.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mulv_h.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-multiply/test_msa_mulv_w.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_s_b.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_s_d.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_s_h.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_s_w.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_u_b.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_u_d.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_u_h.c  | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subs_u_w.c  | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsus_u_b.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsus_u_d.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsus_u_h.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsus_u_w.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsuu_s_b.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsuu_s_d.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsuu_s_h.c     | 151 ++++++++++++++++++++
 .../ase/msa/int-subtract/test_msa_subsuu_s_w.c     | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subv_b.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subv_d.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subv_h.c    | 151 ++++++++++++++++++++
 .../user/ase/msa/int-subtract/test_msa_subv_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvev_b.c     |   8 +-
 .../user/ase/msa/interleave/test_msa_ilvev_d.c     |   8 +-
 .../user/ase/msa/interleave/test_msa_ilvev_h.c     |   8 +-
 .../user/ase/msa/interleave/test_msa_ilvev_w.c     |   8 +-
 .../mips/user/ase/msa/interleave/test_msa_ilvl_b.c |   8 +-
 .../mips/user/ase/msa/interleave/test_msa_ilvl_d.c |   8 +-
 .../mips/user/ase/msa/interleave/test_msa_ilvl_h.c |   8 +-
 .../mips/user/ase/msa/interleave/test_msa_ilvl_w.c |   8 +-
 .../user/ase/msa/interleave/test_msa_ilvod_b.c     |   8 +-
 .../user/ase/msa/interleave/test_msa_ilvod_d.c     |   8 +-
 .../user/ase/msa/interleave/test_msa_ilvod_h.c     |   8 +-
 .../user/ase/msa/interleave/test_msa_ilvod_w.c     |   8 +-
 .../mips/user/ase/msa/interleave/test_msa_ilvr_b.c |   8 +-
 .../mips/user/ase/msa/interleave/test_msa_ilvr_d.c |   8 +-
 .../mips/user/ase/msa/interleave/test_msa_ilvr_h.c |   8 +-
 .../mips/user/ase/msa/interleave/test_msa_ilvr_w.c |   8 +-
 tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c |   8 +-
 tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c |   8 +-
 tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c  |   8 +-
 tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c |   8 +-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c  |   8 +-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c  |   8 +-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c  |   8 +-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c  |   8 +-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c  |   8 +-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c  |   8 +-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c  |   8 +-
 .../tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c  |   8 +-
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c |   8 +-
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c |   8 +-
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c |   8 +-
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c |   8 +-
 175 files changed, 9200 insertions(+), 440 deletions(-)
 rename tests/tcg/mips/include/{test_inputs.h => test_inputs_128.h} (97%)
 rename tests/tcg/mips/include/{test_utils.h => test_utils_128.h} (93%)
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_ave_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-average/test_msa_aver_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-divide/test_msa_div_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-dot-product/test_msa_dotp_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mul_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulr_q_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-multiply/test_msa_mulv_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subs_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsus_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subsuu_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_subv_w.c

-- 
2.7.4
