Received: from eggs.gnu.org ([209.51.188.92]:35623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL77-0004e2-16
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1guL73-0004KP-NS
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:56 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:52201 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1guL73-0003xP-8o
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:47:53 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 14 Feb 2019 18:47:09 +0100
Message-Id: <1550166444-22882-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 00/15] MIPS queue for February 14th, 2019
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

The following changes since commit 7e407466b1efbd65225cc72fe09c0c5ec79df75b:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-02-14 15:22:29 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-feb-14-2019

for you to fetch changes up to ba632924450faf6741d299f8feed8150a0c6f884:

  tests/tcg: target/mips: Add tests for MSA logic instructions (2019-02-14 17:47:37 +0100)

----------------------------------------------------------------
MIPS queue for February 14th, 2019

  - MTTCG support for MIPS
  - The first part of MSA ASE tests

There are several checkpatch warnings that should be all ignored.

----------------------------------------------------------------

Aleksandar Markovic (11):
  hw/mips_int: hold BQL for all interrupt requests
  target/mips: introduce MTTCG-enabled builds
  tests/tcg: target/mips: Remove an unnecessary file
  tests/tcg: target/mips: Add a header with test inputs
  tests/tcg: target/mips: Add a header with test utilities
  tests/tcg: target/mips: Add wrappers for MSA bit counting instructions
  tests/tcg: target/mips: Add tests for MSA bit counting instructions
  tests/tcg: target/mips: Add wrappers for MSA interleave instructions
  tests/tcg: target/mips: Add tests for MSA interleave instructions
  tests/tcg: target/mips: Add wrappers for MSA logic instructions
  tests/tcg: target/mips: Add tests for MSA logic instructions

Goran Ferenc (1):
  target/mips: hold BQL in mips_vpe_wake()

Leon Alrae (2):
  target/mips: compare virtual addresses in LL/SC sequence
  target/mips: reimplement SC instruction emulation and use cmpxchg

Miodrag Dinic (1):
  hw/mips_cpc: kick a VP when putting it into Run statewq

 configure                                          |   3 +
 hw/mips/mips_int.c                                 |  12 ++
 hw/misc/mips_cpc.c                                 |  17 ++-
 linux-user/mips/cpu_loop.c                         |  73 ----------
 target/mips/cpu.h                                  |   9 +-
 target/mips/helper.c                               |   6 +-
 target/mips/helper.h                               |   2 -
 target/mips/machine.c                              |   7 +-
 target/mips/op_helper.c                            |  76 +++-------
 target/mips/translate.c                            | 127 ++++++-----------
 tests/tcg/mips/include/test_inputs.h               | 122 ++++++++++++++++
 tests/tcg/mips/include/test_utils.h                |  78 +++++++++++
 tests/tcg/mips/include/wrappers_msa.h              | 101 ++++++++++++++
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
 tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c  | 153 +++++++++++++++++++++
 tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c | 153 +++++++++++++++++++++
 46 files changed, 5194 insertions(+), 229 deletions(-)
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
 create mode 100644 tests/tcg/mips/user/ase/msa/logic/test_msa_and_v.c
 create mode 100644 tests/tcg/mips/user/ase/msa/logic/test_msa_nor_v.c
 create mode 100644 tests/tcg/mips/user/ase/msa/logic/test_msa_or_v.c
 create mode 100644 tests/tcg/mips/user/ase/msa/logic/test_msa_xor_v.c

-- 
2.7.4
