Received: from eggs.gnu.org ([2001:4830:134:3::10]:44885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi0l3-00034z-2U
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi0ky-0008Ii-Uo
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:05:57 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36748 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi0ky-0007rI-Mi
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:05:52 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:04:38 +0200
Message-Id: <1532451888-8958-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 00/10] Mips maintenance and misc fixes and
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

v6->v7:

   - added two syscall in syscall list patch that were omitted by
     mistake
   - added commit message to the patch on some syscalls preprocessor
     availability control
   - in the same patch, provided #ifdefs for one more function
   - patch on workaround for checkpatch hang given up (checkpatch
     was updated with a fix that fixes the hang)
   - rebased to the latest code

v5->v6:

  - patch on updating CP0 register bit definitions expanded to include
    Config2, Config3, and Config4 registers   
  - added 4 patches:
      - elf: Remove duplicate preprocessor constant definition
      - elf: Add ELF flags for MIPS machine variants
      - linux-user: Update MIPS syscall numbers up to kernel 4.18
      - linux-user: Add availability control to some syscalls

v4->v5:

  - patch 5 (Add CP0 BadInstrX) corrected to work for both 32-bit and
    64-bit targets, and using correct tcg function
  - patch 7 (Amend CP0 WatchHi) was removed from the series until it
    is reimplemented in a better way

v3->v4:

  - accepted suggestion on better format of bit definitions in patch 3
  - fixed build errors caused by a mistake in patch 4
  - removed spurious comments in patch 4
  - added setting lower 16 bits to 0 in patch 5
  - used proper email address for a reviewer in patch 7 commit message

v2->v3:

  - replaced invalid @imgtec.com and @mips.com in "From:",,
    "Signed-off-by:", "Reviewed-by:" lines with the most current
    email addresses for a particular person
  - fixed build errors that appeared because of a mistake during
    integration

v1->v2:

  - fixed recipient's email addresses

Maintenance issues, fixes, and improvements collected during recent
development. Some of them are related to the upcoming nanoMIPS changes.

Aleksandar Markovic (7):
  target/mips: Update maintainer's email addresses
  target/mips: Avoid case statements formulated by ranges
  target/mips: Update some CP0 registers bit definitions
  elf: Remove duplicate preprocessor constant definition
  elf: Add ELF flags for MIPS machine variants
  linux-user: Update MIPS syscall numbers up to kernel 4.18 headers
  linux-user: Add preprocessor availability control to some syscalls

Stefan Markovic (1):
  target/mips: Add CP0 BadInstrX register

Yongbok Kim (2):
  target/mips: Don't update BadVAddr register in Debug Mode
  target/mips: Check ELPA flag only in some cases of MFHC0 and MTHC0

 .mailmap                       |   7 +-
 MAINTAINERS                    |   9 +-
 include/elf.h                  |  24 +++-
 linux-user/mips/syscall_nr.h   |   9 ++
 linux-user/mips64/syscall_nr.h |  18 +++
 linux-user/strace.c            |  14 ++-
 linux-user/syscall.c           |  29 +++++
 target/mips/cpu.h              | 158 +++++++++++++----------
 target/mips/helper.c           |   4 +-
 target/mips/machine.c          |   5 +-
 target/mips/op_helper.c        |  12 +-
 target/mips/translate.c        | 279 +++++++++++++++++++++++++++++++++--------
 12 files changed, 431 insertions(+), 137 deletions(-)

-- 
2.7.4
