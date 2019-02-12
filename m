Received: from eggs.gnu.org ([209.51.188.92]:39299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gte8h-0006wV-09
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gte8f-000805-B0
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:54:42 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:44818 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gte8d-0006dB-3F
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:54:39 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 12 Feb 2019 20:53:20 +0100
Message-Id: <1550001205-7883-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/5] target/mips: Add MSA ASE tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, alex.bennee@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series begins to add unit tests (aka tcg tests) for MIPS'
MSA ASE. More tests and related test infrastructure will be added
in subsequent version of this series.

There are several checkpatch warnings that are all false positives
for given circumstances.

Aleksandar Markovic (5):
  tests/tcg: target/mips: Remove an unnecessary file
  tests/tcg: target/mips: Add a header with test inputs
  tests/tcg: target/mips: Add a header with MSA wrappers
  tests/tcg: target/mips: Add a header with test utilities
  tests/tcg: target/mips: Add tests for MSA bit counting instructions

 tests/tcg/mips/include/test_inputs.h               | 120 +++++++++++++++++
 tests/tcg/mips/include/test_utils.h                |  84 ++++++++++++
 tests/tcg/mips/include/wrappers_msa.h              |  57 ++++++++
 tests/tcg/mips/mips64-dspr2/.directory             |   2 -
 .../user/ase/msa/bit_counting/test_msa_nloc_b.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit_counting/test_msa_nloc_d.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit_counting/test_msa_nloc_h.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit_counting/test_msa_nloc_w.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit_counting/test_msa_nlzc_b.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit_counting/test_msa_nlzc_d.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit_counting/test_msa_nlzc_h.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit_counting/test_msa_nlzc_w.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit_counting/test_msa_pcnt_b.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit_counting/test_msa_pcnt_d.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit_counting/test_msa_pcnt_h.c    | 144 +++++++++++++++++++++
 .../user/ase/msa/bit_counting/test_msa_pcnt_w.c    | 144 +++++++++++++++++++++
 16 files changed, 1989 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/mips/include/test_inputs.h
 create mode 100644 tests/tcg/mips/include/test_utils.h
 create mode 100644 tests/tcg/mips/include/wrappers_msa.h
 delete mode 100644 tests/tcg/mips/mips64-dspr2/.directory
 create mode 100644 tests/tcg/mips/user/ase/msa/bit_counting/test_msa_nloc_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit_counting/test_msa_nloc_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit_counting/test_msa_nloc_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit_counting/test_msa_nloc_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit_counting/test_msa_nlzc_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit_counting/test_msa_nlzc_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit_counting/test_msa_nlzc_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit_counting/test_msa_nlzc_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit_counting/test_msa_pcnt_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit_counting/test_msa_pcnt_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit_counting/test_msa_pcnt_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit_counting/test_msa_pcnt_w.c

-- 
2.7.4
