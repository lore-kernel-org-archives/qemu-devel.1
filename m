Received: from eggs.gnu.org ([209.51.188.92]:51191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hHYQ5-0006Sj-TK
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hHYPt-0003wx-AY
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:39:19 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56042 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hHYPp-0003Lo-DO
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:39:15 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Apr 2019 20:37:56 +0200
Message-Id: <1555699081-24577-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/5] target/mips: Consolidate MIPS TCG tests
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

This series contains a number of fixes, improvements and amendments
related to MIPS TCG tests. It is focused on improving existing tests,
even though some small number of tests are added.

Aleksandar Markovic (3):
  target/mips: Amend and cleanup MSA TCG tests
  tests/tcg: target/mips: Add tests for MSA bit set instructions
  tests/tcg: target/mips: Add README for MSA tests

Mateja Marjanovic (2):
  target/mips: Make the results of DIV_<U|S>.<B|H|W|D> the same as on
    hardware
  target/mips: Make the results of MOD_<U|S>.<B|H|W|D> the same as on
    hardware

 target/mips/msa_helper.c                           |   9 +-
 tests/tcg/mips/include/test_utils_128.h            |   2 +-
 tests/tcg/mips/include/wrappers_msa.h              | 147 ++++-
 tests/tcg/mips/user/ase/msa/README                 | 639 +++++++++++++++++++++
 .../mips/user/ase/msa/bit-set/test_msa_bclr_b.c    | 153 +++++
 .../mips/user/ase/msa/bit-set/test_msa_bclr_d.c    | 153 +++++
 .../mips/user/ase/msa/bit-set/test_msa_bclr_h.c    | 153 +++++
 .../mips/user/ase/msa/bit-set/test_msa_bclr_w.c    | 153 +++++
 .../mips/user/ase/msa/bit-set/test_msa_bneg_b.c    | 153 +++++
 .../mips/user/ase/msa/bit-set/test_msa_bneg_d.c    | 153 +++++
 .../mips/user/ase/msa/bit-set/test_msa_bneg_h.c    | 153 +++++
 .../mips/user/ase/msa/bit-set/test_msa_bneg_w.c    | 153 +++++
 .../mips/user/ase/msa/bit-set/test_msa_bset_b.c    | 153 +++++
 .../mips/user/ase/msa/bit-set/test_msa_bset_d.c    | 153 +++++
 .../mips/user/ase/msa/bit-set/test_msa_bset_h.c    | 153 +++++
 .../mips/user/ase/msa/bit-set/test_msa_bset_w.c    | 153 +++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_b.c   |   4 +
 .../mips/user/ase/msa/int-add/test_msa_add_a_d.c   |   4 +
 .../mips/user/ase/msa/int-add/test_msa_add_a_h.c   |   4 +
 .../mips/user/ase/msa/int-add/test_msa_add_a_w.c   |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_a_b.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_a_d.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_a_h.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_a_w.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_s_b.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_s_d.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_s_h.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_s_w.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_u_b.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_u_d.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_u_h.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_adds_u_w.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_addv_b.c    |   4 +
 .../mips/user/ase/msa/int-add/test_msa_addv_d.c    |   4 +
 .../mips/user/ase/msa/int-add/test_msa_addv_h.c    |   4 +
 .../mips/user/ase/msa/int-add/test_msa_addv_w.c    |   4 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c  |   4 +
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c  |   4 +
 .../user/ase/msa/int-average/test_msa_ave_s_b.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_s_d.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_s_h.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_s_w.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_u_b.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_u_d.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_u_h.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_ave_u_w.c    |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_s_b.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_s_d.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_s_h.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_s_w.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_u_b.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_u_d.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_u_h.c   |  12 +-
 .../user/ase/msa/int-average/test_msa_aver_u_w.c   |  12 +-
 .../mips/user/ase/msa/int-compare/test_msa_ceq_b.c |   2 +
 .../mips/user/ase/msa/int-compare/test_msa_ceq_d.c |   2 +
 .../mips/user/ase/msa/int-compare/test_msa_ceq_h.c |   2 +
 .../mips/user/ase/msa/int-compare/test_msa_ceq_w.c |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_s_b.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_s_d.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_s_h.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_s_w.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_u_b.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_u_d.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_u_h.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_cle_u_w.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_s_b.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_s_d.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_s_h.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_s_w.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_u_b.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_u_d.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_u_h.c    |   2 +
 .../user/ase/msa/int-compare/test_msa_clt_u_w.c    |   2 +
 .../user/ase/msa/int-divide/test_msa_div_s_b.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_s_d.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_s_h.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_s_w.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_u_b.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_u_d.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_u_h.c     |  12 +-
 .../user/ase/msa/int-divide/test_msa_div_u_w.c     |  12 +-
 .../ase/msa/int-dot-product/test_msa_dotp_s_d.c    |  12 +-
 .../ase/msa/int-dot-product/test_msa_dotp_s_h.c    |  12 +-
 .../ase/msa/int-dot-product/test_msa_dotp_s_w.c    |  12 +-
 .../ase/msa/int-dot-product/test_msa_dotp_u_d.c    |  12 +-
 .../ase/msa/int-dot-product/test_msa_dotp_u_h.c    |  12 +-
 .../ase/msa/int-dot-product/test_msa_dotp_u_w.c    |  12 +-
 .../user/ase/msa/int-max-min/test_msa_max_a_b.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_a_d.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_a_h.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_a_w.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_s_b.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_s_d.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_s_h.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_s_w.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_u_b.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_u_d.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_u_h.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_max_u_w.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_a_b.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_a_d.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_a_h.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_a_w.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_s_b.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_s_d.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_s_h.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_s_w.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_u_b.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_u_d.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_u_h.c    |   2 +
 .../user/ase/msa/int-max-min/test_msa_min_u_w.c    |   2 +
 .../user/ase/msa/int-modulo/test_msa_mod_s_b.c     | 155 +++++
 .../user/ase/msa/int-modulo/test_msa_mod_s_d.c     | 155 +++++
 .../user/ase/msa/int-modulo/test_msa_mod_s_h.c     | 155 +++++
 .../user/ase/msa/int-modulo/test_msa_mod_s_w.c     | 155 +++++
 .../user/ase/msa/int-modulo/test_msa_mod_u_b.c     | 155 +++++
 .../user/ase/msa/int-modulo/test_msa_mod_u_d.c     | 155 +++++
 .../user/ase/msa/int-modulo/test_msa_mod_u_h.c     | 155 +++++
 .../user/ase/msa/int-modulo/test_msa_mod_u_w.c     | 155 +++++
 .../user/ase/msa/int-multiply/test_msa_mul_q_h.c   |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mul_q_w.c   |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mulr_q_h.c  |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mulr_q_w.c  |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mulv_b.c    |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mulv_d.c    |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mulv_h.c    |  12 +-
 .../user/ase/msa/int-multiply/test_msa_mulv_w.c    |  12 +-
 .../user/ase/msa/int-subtract/test_msa_asub_s_b.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_asub_s_d.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_asub_s_h.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_asub_s_w.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_asub_u_b.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_asub_u_d.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_asub_u_h.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_asub_u_w.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_hsub_s_d.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_hsub_s_h.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_hsub_s_w.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_hsub_u_d.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_hsub_u_h.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_hsub_u_w.c  | 155 +++++
 .../user/ase/msa/int-subtract/test_msa_subs_s_b.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_s_d.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_s_h.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_s_w.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_u_b.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_u_d.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_u_h.c  |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subs_u_w.c  |  12 +-
 .../ase/msa/int-subtract/test_msa_subsus_u_b.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsus_u_d.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsus_u_h.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsus_u_w.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsuu_s_b.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsuu_s_d.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsuu_s_h.c     |  12 +-
 .../ase/msa/int-subtract/test_msa_subsuu_s_w.c     |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subv_b.c    |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subv_d.c    |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subv_h.c    |  12 +-
 .../user/ase/msa/int-subtract/test_msa_subv_w.c    |  10 +-
 .../user/ase/msa/interleave/test_msa_ilvev_b.c     |   2 +-
 .../user/ase/msa/interleave/test_msa_ilvev_d.c     |   2 +-
 .../user/ase/msa/interleave/test_msa_ilvev_h.c     |   2 +-
 169 files changed, 6691 insertions(+), 244 deletions(-)
 create mode 100644 tests/tcg/mips/user/ase/msa/README
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bclr_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bneg_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-set/test_msa_bset_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-modulo/test_msa_mod_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_asub_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-subtract/test_msa_hsub_u_w.c

-- 
2.7.4
