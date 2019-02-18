Received: from eggs.gnu.org ([209.51.188.92]:54107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gvkuj-0004zJ-76
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gvkuh-0001wq-Ta
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:33:01 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36983 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gvkuf-0001Ed-Tp
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:32:58 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 18 Feb 2019 16:31:30 +0100
Message-Id: <1550503897-31141-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/7] Misc target/mips fixes and improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, peter.maydell@linaro.org, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

A collection of misc target/mips fixes and improvements for
February 2019.

Aleksandar Markovic (7):
  hw/misc: mips_itu: Fix 32/64 bit issue in a line involving shift
    operator
  tests/tcg: target/mips: Correct path to headers in some test source
    files
  tests/tcg: target/mips: Change directory name 'bit-counting' to
    'bit-count'
  tests/tcg: target/mips: Add wrappers for MSA integer compare
    instructions
  tests/tcg: target/mips: Add tests for MSA integer compare instructions
  disas: nanoMIPS: Correct comments to handlers of some DSP instructions
  disas: nanoMIPS: Fix a function misnomer

 disas/nanomips.cpp                                 | 224 +++++++++++----------
 disas/nanomips.h                                   |   2 +-
 hw/misc/mips_itu.c                                 |   2 +-
 tests/tcg/mips/include/wrappers_msa.h              |  25 +++
 .../{bit-counting => bit-count}/test_msa_nloc_b.c  |   6 +-
 .../{bit-counting => bit-count}/test_msa_nloc_d.c  |   6 +-
 .../{bit-counting => bit-count}/test_msa_nloc_h.c  |   6 +-
 .../{bit-counting => bit-count}/test_msa_nloc_w.c  |   6 +-
 .../{bit-counting => bit-count}/test_msa_nlzc_b.c  |   6 +-
 .../{bit-counting => bit-count}/test_msa_nlzc_d.c  |   6 +-
 .../{bit-counting => bit-count}/test_msa_nlzc_h.c  |   6 +-
 .../{bit-counting => bit-count}/test_msa_nlzc_w.c  |   6 +-
 .../{bit-counting => bit-count}/test_msa_pcnt_b.c  |   6 +-
 .../{bit-counting => bit-count}/test_msa_pcnt_d.c  |   6 +-
 .../{bit-counting => bit-count}/test_msa_pcnt_h.c  |   6 +-
 .../{bit-counting => bit-count}/test_msa_pcnt_w.c  |   6 +-
 .../mips/user/ase/msa/int-compare/test_msa_ceq_b.c | 153 ++++++++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_d.c | 153 ++++++++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_h.c | 153 ++++++++++++++
 .../mips/user/ase/msa/int-compare/test_msa_ceq_w.c | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_b.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_d.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_h.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_s_w.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_b.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_d.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_h.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_cle_u_w.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_b.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_d.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_h.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_s_w.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_b.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_d.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_h.c    | 153 ++++++++++++++
 .../user/ase/msa/int-compare/test_msa_clt_u_w.c    | 153 ++++++++++++++
 36 files changed, 3238 insertions(+), 147 deletions(-)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_b.c (98%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_d.c (98%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_h.c (98%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_w.c (98%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_b.c (98%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_d.c (98%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_h.c (98%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_w.c (98%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_b.c (98%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_d.c (98%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_h.c (98%)
 rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_w.c (98%)
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

-- 
2.7.4
