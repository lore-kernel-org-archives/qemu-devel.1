Received: from eggs.gnu.org ([208.118.235.92]:55924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf5y1-0001Jh-El
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf5xw-0007o1-EA
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:35:33 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:40262 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf5xw-0006ex-4X
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:35:28 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 17:34:04 +0100
Message-Id: <1546533252-26601-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/8] target/mips: Update Inter-Thread
 Communication Unit support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Inter-Thread Communication Unit (or ITU) represents and important
part of contemporary MIPS cores. This series extends support for
ITU in QEMU. The changes will not be visible for end users
immediatelly, but there are plans to enable corresponding features
for certain CPUs soon.

Break down by patches:

  - patches 1-3 are cosmetic improvements of CP0-related definitions
  - patches 4-5 introduce SAARI and SAAR CP0 registers
  - patch 6 introduce ITU control register ICR0
  - patch 7 add usage of SAARI and SAAR registers within ITU
  - patch 8 adds handling of bus errors within ITU

Aleksandar Markovic (3):
  target/mips: Move comment containing summary of CP0 registers
  target/mips: Add preprocessor constants for 32 major CP0 registers
  target/mips: Use preprocessor constants for 32 major CP0 registers

Yongbok Kim (5):
  target/mips: Add fields for SAARI and SAAR CP0 registers
  target/mips: Provide R/W access to SAARI and SAAR CP0 registers
  target/mips: Add field and R/W access to ITU control register ICR0
  target/mips: Update ITU to utilize SAARI and SAAR CP0 registers
  target/mips: Update ITU to handle bus errors

 hw/mips/cps.c              |   8 ++
 hw/misc/mips_itu.c         |  72 +++++++++-
 include/hw/misc/mips_itu.h |   8 ++
 target/mips/cpu.h          | 213 +++++++++++++++++-----------
 target/mips/helper.h       |   6 +
 target/mips/internal.h     |   1 +
 target/mips/machine.c      |   6 +-
 target/mips/op_helper.c    |  64 +++++++++
 target/mips/translate.c    | 338 ++++++++++++++++++++++++++-------------------
 9 files changed, 484 insertions(+), 232 deletions(-)

-- 
2.7.4
