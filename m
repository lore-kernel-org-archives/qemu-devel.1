Received: from eggs.gnu.org ([209.51.188.92]:35677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gycIE-000491-BR
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gycIB-0000CG-Ui
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:57:05 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37465 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gycIB-00086L-Hs
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:57:03 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 26 Feb 2019 13:55:26 +0100
Message-Id: <1551185735-17154-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 0/9] Misc target/mips fixes and improvements
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
February 2019.

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

Aleksandar Markovic (8):
  tests/tcg: target/mips: Add tests for MSA integer compare instructions
  disas: nanoMIPS: Fix a function misnomer
  qemu-doc: Move section on MIPS' mipssim pseudo board
  qemu-doc: Add section on MIPS' Fulong 2E board
  qemu-doc: Add section on MIPS' Boston board
  tests/tcg: target/mips: Add wrappers for MSA integer max/min
    instructions
  tests/tcg: target/mips: Add tests for MSA integer max/min instructions
  disas: nanoMIPS: Correct comments to handlers of some DSP instructions

Yongbok Kim (1):
  target/mips: Add support for DSPRAM

 default-configs/mips-softmmu-common.mak            |   1 +
 disas/nanomips.cpp                                 | 381 +++++++++++----------
 disas/nanomips.h                                   |   2 +-
 hw/mips/cps.c                                      |   3 +-
 hw/mips/mips_malta.c                               |  31 ++
 hw/misc/Makefile.objs                              |   1 +
 include/hw/mips/cps.h                              |   2 +
 qemu-doc.texi                                      |  46 ++-
 target/mips/cpu.h                                  |   5 +
 target/mips/internal.h                             |   1 +
 target/mips/op_helper.c                            |  10 +
 target/mips/translate.c                            |   8 +
 target/mips/translate_init.inc.c                   |   2 +
 tests/tcg/mips/include/wrappers_msa.h              |  30 ++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_b.c | 153 +++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_d.c | 153 +++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_h.c | 153 +++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_w.c | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_b.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_d.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_h.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_w.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_b.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_d.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_h.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_w.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_b.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_d.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_h.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_w.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_b.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_d.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_h.c    | 153 +++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_w.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_max_a_b.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_max_a_d.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_max_a_h.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_max_a_w.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_max_s_b.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_max_s_d.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_max_s_h.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_max_s_w.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_max_u_b.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_max_u_d.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_max_u_h.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_max_u_w.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_min_a_b.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_min_a_d.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_min_a_h.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_min_a_w.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_min_s_b.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_min_s_d.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_min_s_h.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_min_s_w.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_min_u_b.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_min_u_d.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_min_u_h.c    | 153 +++++++++
 .../user/ase/msa/int-max-min/test_msa_min_u_w.c    | 153 +++++++++
 58 files changed, 7058 insertions(+), 197 deletions(-)
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_ceq_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_cle_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-compare/test_msa_clt_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_a_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_max_u_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_a_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_s_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/int-max-min/test_msa_min_u_w.c

-- 
2.7.4
