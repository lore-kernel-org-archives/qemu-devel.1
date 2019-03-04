Received: from eggs.gnu.org ([209.51.188.92]:52887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0qoR-0005fj-Vv
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0qoQ-0007jP-RB
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:51:35 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:44290 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1h0qoQ-0007hC-F5
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:51:34 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon,  4 Mar 2019 17:51:21 +0100
Message-Id: <1551718283-4487-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/2] target/mips: Improve performance for MSA
 binary operations
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

Eliminate loops for better performance.
Regression tests are also included.

Mateja Marjanovic (2):
  target/mips: Improve performance for MSA binary operations
  target/mips: Tests for binary integer MSA instruction (add, adds,
    hadd...)

 target/mips/msa_helper.c                           |  43 ++++--
 .../mips/user/ase/msa/int-add/test_msa_add_a_b.c   | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_d.c   | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_h.c   | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_add_a_w.c   | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_a_b.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_a_d.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_a_h.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_a_w.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_s_b.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_s_d.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_s_h.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_s_w.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_u_b.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_u_d.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_u_h.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_adds_u_w.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_addv_b.c    | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_addv_d.c    | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_addv_h.c    | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_addv_w.c    | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_d.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_h.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_s_w.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_d.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_h.c  | 151 +++++++++++++++++++++
 .../mips/user/ase/msa/int-add/test_msa_hadd_u_w.c  | 151 +++++++++++++++++++++
 27 files changed, 3956 insertions(+), 13 deletions(-)
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

-- 
2.7.4
