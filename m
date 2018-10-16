Received: from eggs.gnu.org ([2001:4830:134:3::10]:42825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC4-0000dO-Qv
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC3-0007ia-RB
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRC2-0007PR-KK
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRBx-0003m2-F6
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:29 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:06 +0100
Message-Id: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/19] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Latest set of arm patches. I may end up doing another pullreq at the
end of the week, but this is big enough to send out, plus it has
several instances of "let me take the first N patches in your series"
in it, so getting those into master makes patch respins for those
submitters easier.

thanks
-- PMM

The following changes since commit dddb37495b844270088e68e3bf30b764d48d863f:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20181015.0' into staging (2018-10-15 18:44:04 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181016

for you to fetch changes up to bdaffef4bb0729a74c7a325dba5c61d8cd8f464f:

  coccinelle: new inplace-byteswaps.cocci to remove inplace-byteswapping calls (2018-10-16 16:16:42 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/virt: add DT property /secure-chosen/stdout-path indicating secure UART
 * target/arm: Fix aarch64_sve_change_el wrt EL0
 * target/arm: Define fields of ISAR registers
 * target/arm: Align cortex-r5 id_isar0
 * target/arm: Fix cortex-a7 id_isar0
 * net/cadence_gem: Fix various bugs, add support for new
   features that will be used by the Xilinx Versal board
 * target-arm: powerctl: Enable HVC when starting CPUs to EL2
 * target/arm: Add the Cortex-A72
 * target/arm: Mark PMINTENCLR and PMINTENCLR_EL1 accesses as possibly doing IO
 * target/arm: Mask PMOVSR writes based on supported counters
 * target/arm: Initialize ARMMMUFaultInfo in v7m_stack_read/write
 * coccinelle: new inplace-byteswaps.cocci to remove inplace-byteswapping calls

----------------------------------------------------------------
Aaron Lindsay (2):
      target/arm: Mark PMINTENCLR and PMINTENCLR_EL1 accesses as possibly doing IO
      target/arm: Mask PMOVSR writes based on supported counters

Edgar E. Iglesias (10):
      net: cadence_gem: Disable TSU feature bit
      net: cadence_gem: Announce availability of priority queues
      net: cadence_gem: Use uint32_t for 32bit descriptor words
      net: cadence_gem: Add macro with max number of descriptor words
      net: cadence_gem: Add support for extended descriptors
      net: cadence_gem: Add support for selecting the DMA MemoryRegion
      net: cadence_gem: Implement support for 64bit descriptor addresses
      net: cadence_gem: Announce 64bit addressing support
      target-arm: powerctl: Enable HVC when starting CPUs to EL2
      target/arm: Add the Cortex-A72

Jerome Forissier (1):
      hw/arm/virt: add DT property /secure-chosen/stdout-path indicating secure UART

Peter Maydell (2):
      target/arm: Initialize ARMMMUFaultInfo in v7m_stack_read/write
      coccinelle: new inplace-byteswaps.cocci to remove inplace-byteswapping calls

Richard Henderson (4):
      target/arm: Fix aarch64_sve_change_el wrt EL0
      target/arm: Define fields of ISAR registers
      target/arm: Align cortex-r5 id_isar0
      target/arm: Fix cortex-a7 id_isar0

 include/hw/net/cadence_gem.h               |   7 +-
 target/arm/cpu.h                           |  95 +++++++++++++-
 hw/arm/virt.c                              |   4 +
 hw/net/cadence_gem.c                       | 192 +++++++++++++++++++++--------
 target/arm/arm-powerctl.c                  |  10 ++
 target/arm/cpu.c                           |   7 +-
 target/arm/cpu64.c                         |  66 +++++++++-
 target/arm/helper.c                        |  27 ++--
 target/arm/op_helper.c                     |   6 +-
 scripts/coccinelle/inplace-byteswaps.cocci |  65 ++++++++++
 10 files changed, 408 insertions(+), 71 deletions(-)
 create mode 100644 scripts/coccinelle/inplace-byteswaps.cocci
