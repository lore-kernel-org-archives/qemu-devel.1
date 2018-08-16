Received: from eggs.gnu.org ([2001:4830:134:3::10]:54104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqMQW-0002U7-VZ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqMQT-0007zE-Qm
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:51:16 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56401 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqMQT-0007z1-JN
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:51:13 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 19:48:52 +0200
Message-Id: <1534441747-4197-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 00/15] MIPS queue for QEMU upstream, August 16,
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

The following changes since commit c542a9f9794ec8e0bc3fcf5956d3cc8bce667789:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-tests-2018-08-16' into staging (2018-08-16 09:50:54 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-aug-2018

for you to fetch changes up to 8639c5c95472ee79391a7e7826d1af23948b71f6:

  qemu-doc: Amend MIPS-related items (2018-08-16 19:18:45 +0200)

----------------------------------------------------------------
MIPS queue for QEMU upstream, August 16, 2018

This is v2 of the pull request sent on August 14, 2018 - in
this pull request clang build errors are fixed. The pull request
is based on the first part (patches 1-15) of v9 of the nanoMIPS
support series.

  - gcc/clang bisect were tested to work (build ok after each
    patch).
  - Two occurences of "O64" are replaced with "N64" in the last
    patch, as minor corrections.
  - "Reviewed-by" lines were also updated compared to v9.

-----------------------------------------------------------------
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

Aleksandar Rikalo (2):
  target/mips: Avoid case statements formulated by ranges - part 2
  linux-user: Add preprocessor availability control to some syscalls

Stefan Markovic (2):
  target/mips: Add CP0 BadInstrX register
  target/mips: Implement CP0 Config1.WR bit functionality

Yongbok Kim (2):
  target/mips: Don't update BadVAddr register in Debug Mode
  target/mips: Check ELPA flag only in some cases of MFHC0 and MTHC0

 .mailmap                       |   7 +-
 MAINTAINERS                    |   9 +-
 include/elf.h                  |  24 ++-
 linux-user/mips/syscall_nr.h   |   9 +
 linux-user/mips64/syscall_nr.h |  18 ++
 linux-user/strace.c            |  14 +-
 linux-user/syscall.c           |  29 ++++
 qemu-doc.texi                  |  13 +-
 target/mips/cpu.h              | 158 +++++++++--------
 target/mips/helper.c           |   4 +-
 target/mips/machine.c          |   5 +-
 target/mips/op_helper.c        |  12 +-
 target/mips/translate.c        | 374 ++++++++++++++++++++++++++++++++++-------
 13 files changed, 526 insertions(+), 150 deletions(-)

-- 
2.7.4
