Received: from eggs.gnu.org ([2001:4830:134:3::10]:51297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWR-0004YH-7b
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWP-0007VZ-Vr
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:47 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWP-0007Ts-MT
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:45 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWM-0007Yb-B9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:12:42 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:11:58 +0000
Message-Id: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/43] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

First arm pullreq for the 2.12 cycle, with all the
things that queued up during the release phase.
2.11 isn't quite released yet, but might as well put
the pullreq on the mailing list :-)

thanks
-- PMM

The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:

  Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)

are available in the git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171213

for you to fetch changes up to d3c348b6e3af3598bfcb755d59f8f4de80a2228a:

  xilinx_spips: Use memset instead of a for loop to zero registers (2017-12-13 17:59:26 +0000)

----------------------------------------------------------------
target-arm queue:
 * xilinx_spips: set reset values correctly
 * MAINTAINERS: fix an email address
 * hw/display/tc6393xb: limit irq handler index to TC6393XB_GPIOS
 * nvic: Make systick banked for v8M
 * refactor get_phys_addr() so we can return the right format PAR
   for ATS operations
 * implement v8M TT instruction
 * fix some minor v8M bugs
 * Implement reset for GICv3 ITS
 * xlnx-zcu102: Add support for the ZynqMP QSPI

----------------------------------------------------------------
Alistair Francis (3):
      xilinx_spips: Update the QSPI Mod ID reset value
      xilinx_spips: Set all of the reset values
      xilinx_spips: Use memset instead of a for loop to zero registers

Edgar E. Iglesias (1):
      target/arm: Extend PAR format determination

Eric Auger (4):
      hw/intc/arm_gicv3_its: Don't call post_load on reset
      hw/intc/arm_gicv3_its: Implement a minimalist reset
      linux-headers: update to 4.15-rc1
      hw/intc/arm_gicv3_its: Implement full reset

Francisco Iglesias (13):
      m25p80: Add support for continuous read out of RDSR and READ_FSR
      m25p80: Add support for SST READ ID 0x90/0xAB commands
      m25p80: Add support for BRRD/BRWR and BULK_ERASE (0x60)
      m25p80: Add support for n25q512a11 and n25q512a13
      xilinx_spips: Move FlashCMD, XilinxQSPIPS and XilinxSPIPSClass
      xilinx_spips: Update striping to be big-endian bit order
      xilinx_spips: Add support for RX discard and RX drain
      xilinx_spips: Make tx/rx_data_bytes more generic and reusable
      xilinx_spips: Add support for zero pumping
      xilinx_spips: Add support for 4 byte addresses in the LQSPI
      xilinx_spips: Don't set TX FIFO UNDERFLOW at cmd done
      xilinx_spips: Add support for the ZynqMP Generic QSPI
      xlnx-zcu102: Add support for the ZynqMP QSPI

Peter Maydell (20):
      target/arm: Handle SPSEL and current stack being out of sync in MSP/PSP reads
      target/arm: Allow explicit writes to CONTROL.SPSEL in Handler mode
      target/arm: Add missing M profile case to regime_is_user()
      target/arm: Split M profile MNegPri mmu index into user and priv
      target/arm: Create new arm_v7m_mmu_idx_for_secstate_and_priv()
      target/arm: Factor MPU lookup code out of get_phys_addr_pmsav8()
      target/arm: Implement TT instruction
      target/arm: Provide fault type enum and FSR conversion functions
      target/arm: Remove fsr argument from arm_ld*_ptw()
      target/arm: Convert get_phys_addr_v5() to not return FSC values
      target/arm: Convert get_phys_addr_v6() to not return FSC values
      target/arm: Convert get_phys_addr_lpae() to not return FSC values
      target/arm: Convert get_phys_addr_pmsav5() to not return FSC values
      target/arm: Convert get_phys_addr_pmsav7() to not return FSC values
      target/arm: Convert get_phys_addr_pmsav8() to not return FSC values
      target/arm: Use ARMMMUFaultInfo in deliver_fault()
      target/arm: Ignore fsr from get_phys_addr() in do_ats_write()
      target/arm: Remove fsr argument from get_phys_addr() and arm_tlb_fill()
      nvic: Make nvic_sysreg_ns_ops work with any MemoryRegion
      nvic: Make systick banked

Prasad J Pandit (1):
      hw/display/tc6393xb: limit irq handler index to TC6393XB_GPIOS

Zhaoshenglong (1):
      MAINTAINERS: replace the unavailable email address

 include/hw/arm/xlnx-zynqmp.h                       |   5 +
 include/hw/intc/armv7m_nvic.h                      |   4 +-
 include/hw/ssi/xilinx_spips.h                      |  74 +-
 include/standard-headers/asm-s390/virtio-ccw.h     |   1 +
 include/standard-headers/asm-x86/hyperv.h          | 394 +--------
 include/standard-headers/linux/input-event-codes.h |   2 +
 include/standard-headers/linux/input.h             |   1 +
 include/standard-headers/linux/pci_regs.h          |  45 +-
 linux-headers/asm-arm/kvm.h                        |   8 +
 linux-headers/asm-arm/kvm_para.h                   |   1 +
 linux-headers/asm-arm/unistd.h                     |   2 +
 linux-headers/asm-arm64/kvm.h                      |   8 +
 linux-headers/asm-arm64/unistd.h                   |   1 +
 linux-headers/asm-powerpc/epapr_hcalls.h           |   1 +
 linux-headers/asm-powerpc/kvm.h                    |   1 +
 linux-headers/asm-powerpc/kvm_para.h               |   1 +
 linux-headers/asm-powerpc/unistd.h                 |   1 +
 linux-headers/asm-s390/kvm.h                       |   1 +
 linux-headers/asm-s390/kvm_para.h                  |   1 +
 linux-headers/asm-s390/unistd.h                    |   4 +-
 linux-headers/asm-x86/kvm.h                        |   1 +
 linux-headers/asm-x86/kvm_para.h                   |   2 +-
 linux-headers/asm-x86/unistd.h                     |   1 +
 linux-headers/linux/kvm.h                          |   2 +
 linux-headers/linux/kvm_para.h                     |   1 +
 linux-headers/linux/psci.h                         |   1 +
 linux-headers/linux/userfaultfd.h                  |   1 +
 linux-headers/linux/vfio.h                         |   1 +
 linux-headers/linux/vfio_ccw.h                     |   1 +
 linux-headers/linux/vhost.h                        |   1 +
 target/arm/cpu.h                                   |  73 +-
 target/arm/helper.h                                |   2 +
 target/arm/internals.h                             | 193 ++++-
 hw/arm/xlnx-zcu102.c                               |  23 +
 hw/arm/xlnx-zynqmp.c                               |  26 +
 hw/block/m25p80.c                                  |  80 +-
 hw/display/tc6393xb.c                              |   1 +
 hw/intc/arm_gicv3_its_common.c                     |   2 -
 hw/intc/arm_gicv3_its_kvm.c                        |  53 +-
 hw/intc/armv7m_nvic.c                              | 100 ++-
 hw/ssi/xilinx_spips.c                              | 928 +++++++++++++++++----
 target/arm/helper.c                                | 489 +++++++----
 target/arm/op_helper.c                             |  82 +-
 target/arm/translate.c                             |  37 +-
 MAINTAINERS                                        |   2 +-
 default-configs/arm-softmmu.mak                    |   2 +-
 46 files changed, 1833 insertions(+), 828 deletions(-)
