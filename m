Received: from eggs.gnu.org ([209.51.188.92]:51142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gwtTt-0004IJ-Cd
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gwtTq-0005Mr-Ow
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:54:00 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:34697 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gwtTn-0005IG-QL
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:53:57 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 21 Feb 2019 19:53:32 +0100
Message-Id: <1550775220-26797-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 0/8] MIPS queue for February 21st, 2019, v2
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

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-feb-21-2019-v2

for you to fetch changes up to fb1b0fcc03b0c15bc3580309738280ad9565b6d9:

  target/mips: fulong2e: Dynamically generate SPD EEPROM data (2019-02-21 19:36:47 +0100)

----------------------------------------------------------------

MIPS queue for February 21st, 2019, v2

  - fix 32/64 bit issue with a shift operator in MIPS ITU code
  - fix three misc issues in tcg tests code for MIPS
  - add QMP query-cpu-definitions command for MIPS
  - improve MIPS Fulong 2E machine

NOTE: There is a checkpatch warning (about updating MAINTAINERS)
that should be ignored for given circumstances.

----------------------------------------------------------------


Aleksandar Markovic (4):
  hw/misc: mips_itu: Fix 32/64 bit issue in a line involving shift
    operator
  tests/tcg: target/mips: Correct path to headers in some test source
    files
  tests/tcg: target/mips: Change directory name 'bit-counting' to
    'bit-count'
  tests/tcg: target/mips: Add wrappers for MSA integer compare
    instructions

BALATON Zoltan (3):
  hw/pci-host/bonito.c: Add PCI mem region mapped at the correct address
  target/mips: fulong2e: Fix bios flash size
  target/mips: fulong2e: Dynamically generate SPD EEPROM data

Pavel Dovgalyuk (1):
  target/mips: implement QMP query-cpu-definitions command

 hw/mips/mips_fulong2e.c                            | 40 +++++++++-------------
 hw/misc/mips_itu.c                                 |  2 +-
 hw/pci-host/bonito.c                               |  7 +++-
 qapi/target.json                                   |  4 +--
 target/mips/helper.c                               | 33 ++++++++++++++++++
 tests/tcg/mips/include/wrappers_msa.h              | 25 ++++++++++++++
 .../{bit-counting => bit-count}/test_msa_nloc_b.c  |  6 ++--
 .../{bit-counting => bit-count}/test_msa_nloc_d.c  |  6 ++--
 .../{bit-counting => bit-count}/test_msa_nloc_h.c  |  6 ++--
 .../{bit-counting => bit-count}/test_msa_nloc_w.c  |  6 ++--
 .../{bit-counting => bit-count}/test_msa_nlzc_b.c  |  6 ++--
 .../{bit-counting => bit-count}/test_msa_nlzc_d.c  |  6 ++--
 .../{bit-counting => bit-count}/test_msa_nlzc_h.c  |  6 ++--
 .../{bit-counting => bit-count}/test_msa_nlzc_w.c  |  6 ++--
 .../{bit-counting => bit-count}/test_msa_pcnt_b.c  |  6 ++--
 .../{bit-counting => bit-count}/test_msa_pcnt_d.c  |  6 ++--
 .../{bit-counting => bit-count}/test_msa_pcnt_h.c  |  6 ++--
 .../{bit-counting => bit-count}/test_msa_pcnt_w.c  |  6 ++--
 18 files changed, 120 insertions(+), 63 deletions(-)
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

-- 
2.7.4
