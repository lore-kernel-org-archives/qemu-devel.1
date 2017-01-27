Received: from eggs.gnu.org ([2001:4830:134:3::10]:59551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vp-00011A-AA
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vo-000559-Af
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:29 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vo-000541-3F
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:28 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Ve-0003Kv-Js
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:18 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:31:55 +0000
Message-Id: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/22] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

ARM queue; the bulk of this is M profile bugfixes.

thanks
-- PMM

The following changes since commit 8a26d88507b51b7cc5dc40732e51ccc135fec0f6:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qio-2017-01-26-1' into staging (2017-01-27 14:08:57 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170127

for you to fetch changes up to 146871c33eb70ca7090a0a55e69e5a8f9b5eb102:

  dma: omap: check dma channel data_type (2017-01-27 15:29:08 +0000)

----------------------------------------------------------------
target-arm queue:
 * various minor M profile bugfixes
 * aspeed/smc: handle dummy bytes when doing fast reads in command mode
 * pflash_cfi01: fix per-device sector length in CFI table
 * arm: stellaris: make MII accesses complete immediately
 * hw/char/exynos4210_uart: Drop unused local variable frame_size
 * arm_gicv3: Fix broken logic in ELRSR calculation
 * dma: omap: check dma channel data_type

----------------------------------------------------------------
Cédric Le Goater (1):
      aspeed/smc: handle dummy bytes when doing fast reads in command mode

Michael Davidsaver (12):
      armv7m: MRS/MSR: handle unprivileged access
      armv7m: Replace armv7m.hack with unassigned_access handler
      armv7m: Explicit error for bad vector table
      armv7m: Fix reads of CONTROL register bit 1
      armv7m: Clear FAULTMASK on return from non-NMI exceptions
      armv7m_nvic: keep a pointer to the CPU
      armv7m: implement CCR, CFSR, HFSR, DFSR, BFAR, and MMFAR
      armv7m: honour CCR.STACKALIGN on exception entry
      armv7m: set CFSR.UNDEFINSTR on undefined instructions
      armv7m: Honour CCR.USERSETMPEND
      armv7m: FAULTMASK should be 0 on reset
      arm: stellaris: make MII accesses complete immediately

Peter Maydell (8):
      hw/registerfields.h: Pull FIELD etc macros out of hw/register.h
      pflash_cfi01: fix per-device sector length in CFI table
      target/arm: Drop IS_M() macro
      armv7m: add state for v7M CCR, CFSR, HFSR, DFSR, MMFAR, BFAR
      armv7m: Report no-coprocessor faults correctly
      armv7m: R14 should reset to 0xffffffff
      hw/char/exynos4210_uart: Drop unused local variable frame_size
      arm_gicv3: Fix broken logic in ELRSR calculation

Prasad J Pandit (1):
      dma: omap: check dma channel data_type

 include/hw/compat.h         |   4 ++
 include/hw/register.h       |  47 +------------
 include/hw/registerfields.h |  60 +++++++++++++++++
 target/arm/cpu.h            |  62 +++++++++++++++--
 target/arm/internals.h      |   7 ++
 hw/arm/armv7m.c             |   8 ---
 hw/block/pflash_cfi01.c     |  22 ++++--
 hw/char/exynos4210_uart.c   |   6 +-
 hw/dma/omap_dma.c           |  10 ++-
 hw/intc/arm_gicv3_cpuif.c   |   2 +-
 hw/intc/armv7m_nvic.c       |  58 +++++++++++-----
 hw/net/stellaris_enet.c     |   5 +-
 hw/ssi/aspeed_smc.c         |  21 ++++++
 linux-user/main.c           |   1 +
 target/arm/cpu.c            |  50 ++++++++++++--
 target/arm/helper.c         | 160 +++++++++++++++++++++++++++-----------------
 target/arm/machine.c        |  12 ++--
 target/arm/translate.c      |  20 ++++--
 18 files changed, 386 insertions(+), 169 deletions(-)
 create mode 100644 include/hw/registerfields.h
