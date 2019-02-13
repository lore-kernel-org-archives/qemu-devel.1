Received: from eggs.gnu.org ([209.51.188.92]:48491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtwFi-0004mN-Dh
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtwFh-0000AN-5R
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:15:10 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52843 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gtwFg-00007j-RT
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:15:09 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 13 Feb 2019 16:14:50 +0100
Message-Id: <1550070897-5013-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 0/7] target/mips: Add MSA ASE tests
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

v1->v2:

  - added refference to the original commit in patch #1
  - corrected copy-and-paste error in comments in 12 new source files
  - renamed "bit_counting" subdirectory to "bit-counting"
  - added wrappers and tests for MSA interleave instructions

This series begins to add unit tests (aka tcg tests) for MIPS'
MSA ASE. More tests and related test infrastructure will be added
in subsequent version of this series.

There are several checkpatch warnings that are all false positives
for given circumstances.

Aleksandar Markovic (7):
  tests/tcg: target/mips: Remove an unnecessary file
  tests/tcg: target/mips: Add a header with test inputs
  tests/tcg: target/mips: Add a header with test utilities
  tests/tcg: target/mips: Add wrappers for MSA bit counting instructions
  tests/tcg: target/mips: Add tests for MSA bit counting instructions
  tests/tcg: target/mips: Add wrappers for MSA interleave instructions
  tests/tcg: target/mips: Add tests for MSA interleave instructions

 tests/tcg/mips/include/test_inputs.h               | 122 ++++++++++++++++
 tests/tcg/mips/include/test_utils.h                |  84 +++++++++++
 tests/tcg/mips/include/wrappers_msa.h              |  96 +++++++++++++
 tests/tcg/mips/mips64-dspr2/.directory             |   2 -
 .../user/ase/msa/bit-counting/test_msa_nloc_b.c    | 144 +++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nloc_d.c    | 144 +++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nloc_h.c    | 144 +++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nloc_w.c    | 144 +++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nlzc_b.c    | 144 +++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nlzc_d.c    | 144 +++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nlzc_h.c    | 144 +++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_nlzc_w.c    | 144 +++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_pcnt_b.c    | 144 +++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_pcnt_d.c    | 144 +++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_pcnt_h.c    | 144 +++++++++++++++++++
 .../user/ase/msa/bit-counting/test_msa_pcnt_w.c    | 144 +++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvev_b.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvev_d.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvev_h.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvev_w.c     | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvl_b.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvl_d.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvl_h.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvl_w.c | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvod_b.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvod_d.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvod_h.c     | 153 +++++++++++++++++++++
 .../user/ase/msa/interleave/test_msa_ilvod_w.c     | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvr_b.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvr_d.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvr_h.c | 153 +++++++++++++++++++++
 .../mips/user/ase/msa/interleave/test_msa_ilvr_w.c | 153 +++++++++++++++++++++
 32 files changed, 4478 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/mips/include/test_inputs.h
 create mode 100644 tests/tcg/mips/include/test_utils.h
 create mode 100644 tests/tcg/mips/include/wrappers_msa.h
 delete mode 100644 tests/tcg/mips/mips64-dspr2/.directory
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvev_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvl_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvod_w.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_b.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_d.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_h.c
 create mode 100644 tests/tcg/mips/user/ase/msa/interleave/test_msa_ilvr_w.c

-- 
2.7.4
