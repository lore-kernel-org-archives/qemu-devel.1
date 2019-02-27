Received: from eggs.gnu.org ([209.51.188.92]:58036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gyzn2-0004Yi-Tu
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gyzmx-0000ki-Ss
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:02:26 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:40068 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gyzmr-000089-ET
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:02:21 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 27 Feb 2019 15:00:37 +0100
Message-Id: <1551276045-19143-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 0/8] MIPS queue for February 27th, 2019
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

  Merge remote-tracking branch 'remotes/berrange/tags/authz-core-pull-request' into staging (2019-02-26 17:59:41 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-feb-27-2019

for you to fetch changes up to 37b9aae2e6e005e6df206a0b4804972460806166:

  target/mips: Preparing for adding MMI instructions (2019-02-27 14:26:14 +0100)

----------------------------------------------------------------

MIPS queue for February 27th, 2019

  - addition of two sets of new MSA ASE TCG tests
  - preparation for adding MMI instructions in translate.c
  - fixing a function misnomer in nanoMIPS disassembler
  - MIPS end user documentation updates

NOTES:

  - there are two checkpatch.pl's warnings on "updating MAINTAINERS"
    that can be ignored
  - all patches contain "message-id" now

----------------------------------------------------------------

Aleksandar Markovic (7):
  tests/tcg: target/mips: Add tests for MSA integer compare instructions
  disas: nanoMIPS: Fix a function misnomer
  qemu-doc: Move section on MIPS' mipssim pseudo board
  qemu-doc: Add section on MIPS' Fulong 2E board
  qemu-doc: Add section on MIPS' Boston board
  tests/tcg: target/mips: Add wrappers for MSA integer max/min
    instructions
  tests/tcg: target/mips: Add tests for MSA integer max/min instructions

Mateja Marjanovic (1):
  target/mips: Preparing for adding MMI instructions

 disas/nanomips.cpp                                 |  96 ++++++-------
 disas/nanomips.h                                   |   2 +-
 qemu-doc.texi                                      |  46 +++++--
 target/mips/translate.c                            |  43 +++++-
 tests/tcg/mips/include/wrappers_msa.h              |  30 ++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_b.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_d.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_h.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_w.c | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_a_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_a_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_a_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_a_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_s_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_s_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_s_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_s_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_u_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_u_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_u_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_max_u_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_a_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_a_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_a_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_a_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_s_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_s_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_s_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_s_w.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_u_b.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_u_d.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_u_h.c    | 153 +++++++++++++++++++++
 .../user/ase/msa/int-max-min/test_msa_min_u_w.c    | 153 +++++++++++++++++++++
 49 files changed, 6886 insertions(+), 63 deletions(-)
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
