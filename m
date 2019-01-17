Received: from eggs.gnu.org ([209.51.188.92]:53141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkCBZ-00086g-NZ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gkCBV-0004Rl-Uy
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:35 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50134 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gkCBJ-0002S8-F3
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 13:14:26 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 17 Jan 2019 19:12:53 +0100
Message-Id: <1547748785-14030-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 00/12] MIPS queue for January 17, 2019*
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

The following changes since commit 681d61362d3f766a00806b89d6581869041f73cb:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-01-17 12:48:42 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-january-17-2019

for you to fetch changes up to 60bfe335972213bada1ac954e84234aa7c4046f9:

  target/mips: Introduce 32 R5900 multimedia registers (2019-01-17 19:06:56 +0100)

----------------------------------------------------------------

MIPS queue for January 17, 2019

  - provide access to configuration registers SAARI, SAAR, and
    MemoryMapID
  - update Inter-Thread Communication Unit
  - CP0-related cleanups
  - introduce R5900 multimedia registers

----------------------------------------------------------------

Aleksandar Markovic (6):
  target/mips: Move comment containing summary of CP0 registers
  target/mips: Add preprocessor constants for 32 major CP0 registers
  target/mips: Use preprocessor constants for 32 major CP0 registers
  target/mips: Amend preprocessor constants for CP0 registers
  target/mips: Add CP0 register MemoryMapID
  target/mips: Rename 'rn' to 'register_name'

Fredrik Noring (1):
  target/mips: Introduce 32 R5900 multimedia registers

Yongbok Kim (5):
  target/mips: Add fields for SAARI and SAAR CP0 registers
  target/mips: Provide R/W access to SAARI and SAAR CP0 registers
  target/mips: Add field and R/W access to ITU control register ICR0
  target/mips: Update ITU to utilize SAARI and SAAR CP0 registers
  target/mips: Update ITU to handle bus errors

 hw/mips/cps.c              |    8 +
 hw/misc/mips_itu.c         |   72 ++-
 include/hw/misc/mips_itu.h |    8 +
 target/mips/cpu.h          |  331 +++++++++---
 target/mips/helper.h       |    6 +
 target/mips/internal.h     |    1 +
 target/mips/machine.c      |    7 +-
 target/mips/op_helper.c    |   64 +++
 target/mips/translate.c    | 1192 +++++++++++++++++++++++---------------------
 9 files changed, 1041 insertions(+), 648 deletions(-)

-- 
2.7.4
