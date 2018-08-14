Received: from eggs.gnu.org ([2001:4830:134:3::10]:51525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpdtL-0003NU-PF
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpdsq-0005tO-31
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:03 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:49989 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpdsp-0005aU-NW
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:17:31 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 14 Aug 2018 20:16:42 +0200
Message-Id: <1534270621-27332-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 00/19] MIPS queue for QEMU upstream, August 14,
 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit 38441756b70eec5807b5f60dad11a93a91199866:

  Update version for v3.0.0 release (2018-08-14 16:38:43 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-aug-14-2018

for you to fetch changes up to 20d4e01b6486b15d1f3d9ff2d51bba2bf00ebf94:

  qemu-doc: Amend MIPS-related items (2018-08-14 19:59:03 +0200)

----------------------------------------------------------------
MIPS queue for QEMU upstream, August 14, 2018

This is the first part of nanoMIPS support for QEMU. It contains
various fixes and improvements that are related to nanoMIPS support,
or are discovered while working on nanoMIPS support. Most of them are
fairly simple changes, but each of them has its own significance and
importance for nanoMIPS support.

The second part that contains QEMU support for core nanoMIPS
functionality will remain under review for some time.

The third part that mainly contains Linux user support will likely
remain under review for some longer period.

----------------------------------------------------------------

Aleksandar Markovic (9):
  MAINTAINERS: Update target/mips maintainer's email addresses
  target/mips: Avoid case statements formulated by ranges - part 1
  target/mips: Mark switch fallthroughs with interpretable comments
  target/mips: Fix two instances of shadow variables
  target/mips: Update some CP0 registers bit definitions
  elf: Remove duplicate preprocessor constant definition
  elf: Add ELF flags for MIPS machine variants
  linux-user: Update MIPS syscall numbers up to kernel 4.18 headers
  qemu-doc: Amend MIPS-related items

Aleksandar Rikalo (5):
  target/mips: Avoid case statements formulated by ranges - part 2
  target/mips: Add support for availability control via bit XNP
  target/mips: Add support for availability control via bit MT
  target/mips: Fix MT ASE instructions' availability control
  linux-user: Add preprocessor availability control to some syscalls

Stefan Markovic (3):
  target/mips: Add CP0 BadInstrX register
  target/mips: Implement CP0 Config1.WR bit functionality
  target/mips: Add gen_op_addr_addi()

Yongbok Kim (2):
  target/mips: Don't update BadVAddr register in Debug Mode
  target/mips: Check ELPA flag only in some cases of MFHC0 and MTHC0

 .mailmap                       |   7 +-
 MAINTAINERS                    |   9 +-
 include/elf.h                  |  24 ++-
 linux-user/mips/syscall_nr.h   |   9 +
 linux-user/mips64/syscall_nr.h |  18 ++
 linux-user/strace.c            |  14 +-
 linux-user/syscall.c           |  29 +++
 qemu-doc.texi                  |  13 +-
 target/mips/cpu.h              | 162 ++++++++-------
 target/mips/helper.c           |   4 +-
 target/mips/internal.h         |   9 +-
 target/mips/machine.c          |   5 +-
 target/mips/op_helper.c        |  12 +-
 target/mips/translate.c        | 443 ++++++++++++++++++++++++++++++++++-------
 14 files changed, 598 insertions(+), 160 deletions(-)

-- 
2.7.4
