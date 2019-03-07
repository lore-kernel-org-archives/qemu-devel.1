Received: from eggs.gnu.org ([209.51.188.92]:57354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h1szb-0002u4-QR
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h1szY-0006EP-O0
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:23:23 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:33684 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1h1szY-0005eV-Bh
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:23:20 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Thu,  7 Mar 2019 14:22:04 +0100
Message-Id: <1551964929-17845-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/5] target/mips: Add tests for a variety of
 MSA int binary ops
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

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

These are regression tests for MSA integer binary operations.

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
 58 files changed, 8760 insertions(+)
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
