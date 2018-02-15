Received: from eggs.gnu.org ([2001:4830:134:3::10]:52593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2C-00081I-Ro
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2B-0004xH-R4
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:12 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emK2B-0004ta-Is
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:11 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emK23-0001kG-Rf
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:57:03 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 13:56:41 +0000
Message-Id: <20180215135702.1340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/21] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

target-arm queue: mostly just cleanup/minor stuff, but this does
include the raspi3 board model.

-- PMM

The following changes since commit 9f9c53368b219a9115eddb39f0ff5ad19c977134:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2018-02-15 10:14:11 +0000)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180215

for you to fetch changes up to e545f0f9be1f9e60951017c1e6558216732cc14e:

  target/arm: Implement v8M MSPLIM and PSPLIM registers (2018-02-15 13:48:11 +0000)

----------------------------------------------------------------
target-arm queue:
 * aspeed: code cleanup to use unimplemented_device
 * add 'raspi3' RaspberryPi 3 machine model
 * more SVE prep work
 * v8M: add minor missing registers
 * v7M: fix bug where we weren't migrating v7m.other_sp
 * v7M: fix bugs in handling of interrupt registers for
   external interrupts beyond 32

----------------------------------------------------------------
Pekka Enberg (3):
      bcm2836: Make CPU type configurable
      raspi: Raspberry Pi 3 support
      raspi: Add "raspi3" machine type

Peter Maydell (11):
      hw/intc/armv7m_nvic: Don't hardcode M profile ID registers in NVIC
      hw/intc/armv7m_nvic: Fix ICSR PENDNMISET/CLR handling
      hw/intc/armv7m_nvic: Implement M profile cache maintenance ops
      hw/intc/armv7m_nvic: Implement v8M CPPWR register
      hw/intc/armv7m_nvic: Implement cache ID registers
      hw/intc/armv7m_nvic: Implement SCR
      target/arm: Implement writing to CONTROL_NS for v8M
      hw/intc/armv7m_nvic: Fix byte-to-interrupt number conversions
      target/arm: Add AIRCR to vmstate struct
      target/arm: Migrate v7m.other_sp
      target/arm: Implement v8M MSPLIM and PSPLIM registers

Philippe Mathieu-Daudé (2):
      hw/arm/aspeed: directly map the serial device to the system address space
      hw/arm/aspeed: simplify using the 'unimplemented device' for aspeed_soc.io

Richard Henderson (5):
      target/arm: Remove ARM_CP_64BIT from ZCR_EL registers
      target/arm: Enforce FP access to FPCR/FPSR
      target/arm: Suppress TB end for FPCR/FPSR
      target/arm: Enforce access to ZCR_EL at translation
      target/arm: Handle SVE registers when using clear_vec_high

 include/hw/arm/aspeed_soc.h |   1 -
 include/hw/arm/bcm2836.h    |   1 +
 target/arm/cpu.h            |  71 ++++++++++++-----
 target/arm/internals.h      |   6 ++
 hw/arm/aspeed_soc.c         |  35 ++-------
 hw/arm/bcm2836.c            |  17 +++--
 hw/arm/raspi.c              |  57 +++++++++++---
 hw/intc/armv7m_nvic.c       |  98 ++++++++++++++++++------
 target/arm/cpu.c            |  28 +++++++
 target/arm/helper.c         |  84 +++++++++++++++-----
 target/arm/machine.c        |  84 ++++++++++++++++++++
 target/arm/translate-a64.c  | 181 ++++++++++++++++++++------------------------
 12 files changed, 452 insertions(+), 211 deletions(-)
