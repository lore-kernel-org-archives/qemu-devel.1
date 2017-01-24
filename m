Received: from eggs.gnu.org ([2001:4830:134:3::10]:35384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6a0-0000fC-5H
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cW6Zz-0000dd-Bz
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:16:32 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 19:16:10 +0000
Message-Id: <1485285380-10565-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 00/10] More M profile bugfixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Liviu Ionescu <ilg@livius.net>

More easy bugfixes pulled out from (or inspired by,
or noticed during the course of working on) Michael's
NVIC patchset.

These patches expect to sit on top of my previous set.
You can find a git tree with the whole stack here:
 https://git.linaro.org/people/peter.maydell/qemu-arm.git m-profile-fixes

(I think the next part of this is going to be actually
digging into the NVIC rewrite proper.)

thanks
-- PMM

Michael Davidsaver (6):
  armv7m_nvic: keep a pointer to the CPU
  armv7m: implement CCR, CFSR, HFSR, DFSR, BFAR, and MMFAR
  armv7m: honour CCR.STACKALIGN on exception entry
  armv7m: set CFSR.UNDEFINSTR on undefined instructions
  armv7m: Honour CCR.USERSETMPEND
  armv7m: FAULTMASK should be 0 on reset

Peter Maydell (4):
  target/arm: Drop IS_M() macro
  armv7m: add state for v7M CCR, CFSR, HFSR, DFSR, MMFAR, BFAR
  armv7m: Report no-coprocessor faults correctly
  armv7m: R14 should reset to 0xffffffff

 target/arm/cpu.h       | 61 +++++++++++++++++++++++++++++++++++++++++++++-----
 hw/intc/armv7m_nvic.c  | 58 +++++++++++++++++++++++++++++++++--------------
 linux-user/main.c      |  1 +
 target/arm/cpu.c       | 22 +++++++++++++-----
 target/arm/helper.c    | 13 ++++++-----
 target/arm/machine.c   | 10 +++++++--
 target/arm/translate.c |  8 +++++++
 7 files changed, 138 insertions(+), 35 deletions(-)

-- 
2.7.4
