Received: from eggs.gnu.org ([209.51.188.92]:39163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1vDj-0004Ks-DV
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1vDi-0005RD-2t
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:46:07 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:59498 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1vDh-0004kd-Kv
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:46:06 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  7 Mar 2019 16:44:45 +0100
Message-Id: <1551973487-7114-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/2] target/mips: Minor cleanups in test
 infrastructure
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

This series contains some minor cleanups in MIPS-specific test
infrastructure, done mostly for consistency and clarity.

Aleksandar Markovic (2):
  tests/tcg: target/mips: Correct preambles of test source files
  tests/tcg: target/mips: Rename two header files for consistency

 tests/tcg/mips/include/{test_inputs.h => test_inputs_128.h} | 0
 tests/tcg/mips/include/{test_utils.h => test_utils_128.h}   | 0
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c     | 8 ++++----
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c     | 8 ++++----
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c     | 8 ++++----
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c     | 8 ++++----
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c     | 8 ++++----
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c     | 8 ++++----
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c     | 8 ++++----
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c     | 8 ++++----
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c     | 8 ++++----
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c     | 8 ++++----
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c     | 8 ++++----
 tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c     | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c      | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c      | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c      | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c      | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c       | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c       | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c       | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c       | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c     | 6 +++---
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c    | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c    | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c    | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c    | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c  | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c   | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c   | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c   | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c   | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c    | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c    | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c    | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c    | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c   | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c   | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c   | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c   | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c    | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c    | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c    | 8 ++++----
 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c    | 8 ++++----
 tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c          | 8 ++++----
 tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c          | 8 ++++----
 tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c           | 8 ++++----
 tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c          | 8 ++++----
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_b.c         | 8 ++++----
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_d.c         | 8 ++++----
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_h.c         | 8 ++++----
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckev_w.c         | 8 ++++----
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_b.c         | 8 ++++----
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_d.c         | 8 ++++----
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_h.c         | 8 ++++----
 tests/tcg/mips/user/ase/msa/pack/test_msa_pckod_w.c         | 8 ++++----
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_b.c          | 8 ++++----
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_d.c          | 8 ++++----
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_h.c          | 8 ++++----
 tests/tcg/mips/user/ase/msa/pack/test_msa_vshf_w.c          | 8 ++++----
 116 files changed, 430 insertions(+), 430 deletions(-)
 rename tests/tcg/mips/include/{test_inputs.h => test_inputs_128.h} (100%)
 rename tests/tcg/mips/include/{test_utils.h => test_utils_128.h} (100%)

-- 
2.7.4
