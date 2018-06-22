Received: from eggs.gnu.org ([2001:4830:134:3::10]:49787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcx-0003PM-4b
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcv-00053M-SC
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLcv-00051P-Jq
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:21 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcn-0003p3-S8
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:13 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:56:45 +0100
Message-Id: <20180622125713.15303-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/28] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Arm queue. I still have a lot of stuff in my to-review queue, so
won't be long til the next one.

I've thrown in a couple of minor non-arm patches (a xen code
cleanup and a vl.c codestyle issue).

thanks
-- PMM

The following changes since commit de44c044420d1139480fa50c2d5be19223391218:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-tcg-testing-revivial-210618-2' into staging (2018-06-22 10:57:47 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180622

for you to fetch changes up to 6dad8260e82b69bd278685ee25209f5824360455:

  xen: Don't use memory_region_init_ram_nomigrate() in pci_assign_dev_load_option_rom() (2018-06-22 13:28:42 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/intc/arm_gicv3: fix wrong values when reading IPRIORITYR
 * target/arm: fix read of freed memory in kvm_arm_machine_init_done()
 * virt: support up to 512 CPUs
 * virt: support 256MB ECAM PCI region (for more PCI devices)
 * xlnx-zynqmp: Use Cortex-R5F, not Cortex-R5
 * mps2-tz: Implement and use the TrustZone Memory Protection Controller
 * target/arm: enforce alignment checking for v6M cores
 * xen: Don't use memory_region_init_ram_nomigrate() in pci_assign_dev_load_option_rom()
 * vl.c: Don't zero-initialize statics for serial_hds

----------------------------------------------------------------
Amol Surati (1):
      hw/intc/arm_gicv3: fix an extra left-shift when reading IPRIORITYR

Edgar E. Iglesias (2):
      target-arm: Add the Cortex-R5F
      xlnx-zynqmp: Swap Cortex-R5 for Cortex-R5F

Eric Auger (11):
      linux-headers: Update to kernel mainline commit b357bf602
      target/arm: Allow KVM device address overwriting
      hw/intc/arm_gicv3: Introduce redist-region-count array property
      hw/intc/arm_gicv3_kvm: Get prepared to handle multiple redist regions
      hw/arm/virt: GICv3 DT node with one or two redistributor regions
      hw/arm/virt-acpi-build: Advertise one or two GICR structures
      hw/arm/virt: Register two redistributor regions when necessary
      hw/arm/virt: Add a new 256MB ECAM region
      hw/arm/virt: Add virt-3.0 machine type
      hw/arm/virt: Use 256MB ECAM region by default
      hw/arm/virt: Increase max_cpus to 512

Julia Suvorova (3):
      target/arm: Minor cleanup for ARMv6-M 32-bit instructions
      target/arm: Introduce ARM_FEATURE_M_MAIN
      target/arm: Strict alignment for ARMv6-M and ARMv8-M Baseline

Peter Maydell (10):
      hw/misc/tz-mpc.c: Implement the Arm TrustZone Memory Protection Controller
      hw/misc/tz-mpc.c: Implement registers
      hw/misc/tz-mpc.c: Implement correct blocked-access behaviour
      hw/misc/tz_mpc.c: Honour the BLK_LUT settings in translate
      hw/misc/iotkit-secctl.c: Implement SECMPCINTSTATUS
      hw/arm/iotkit: Instantiate MPC
      hw/arm/iotkit: Wire up MPC interrupt lines
      hw/arm/mps2-tz.c: Instantiate MPCs
      vl.c: Don't zero-initialize statics for serial_hds
      xen: Don't use memory_region_init_ram_nomigrate() in pci_assign_dev_load_option_rom()

Zheng Xiang (1):
      target-arm: fix a segmentation fault due to illegal memory access

 hw/misc/Makefile.objs                              |   1 +
 hw/xen/xen_pt.h                                    |   2 +-
 include/hw/arm/iotkit.h                            |   8 +
 include/hw/arm/virt.h                              |  19 +
 include/hw/intc/arm_gicv3_common.h                 |   8 +-
 include/hw/misc/iotkit-secctl.h                    |   8 +
 include/hw/misc/tz-mpc.h                           |  80 +++
 include/standard-headers/linux/pci_regs.h          |   8 +
 include/standard-headers/linux/virtio_gpu.h        |   1 +
 include/standard-headers/linux/virtio_net.h        |   3 +
 linux-headers/asm-arm/kvm.h                        |   1 +
 linux-headers/asm-arm/unistd-common.h              |   1 +
 linux-headers/asm-arm64/kvm.h                      |   1 +
 linux-headers/asm-generic/unistd.h                 |   4 +-
 linux-headers/asm-powerpc/unistd.h                 |   1 +
 linux-headers/asm-x86/unistd_32.h                  |   2 +
 linux-headers/asm-x86/unistd_64.h                  |   2 +
 linux-headers/asm-x86/unistd_x32.h                 |   2 +
 linux-headers/linux/kvm.h                          |   5 +-
 linux-headers/linux/psp-sev.h                      |  12 +
 target/arm/cpu.h                                   |   1 +
 target/arm/kvm_arm.h                               |   3 +-
 hw/arm/iotkit.c                                    | 112 +++-
 hw/arm/mps2-tz.c                                   |  71 ++-
 hw/arm/virt-acpi-build.c                           |  30 +-
 hw/arm/virt.c                                      | 100 +++-
 hw/arm/xlnx-zcu102.c                               |   2 +-
 hw/arm/xlnx-zynqmp.c                               |   2 +-
 hw/intc/arm_gic_kvm.c                              |   4 +-
 hw/intc/arm_gicv3.c                                |  12 +-
 hw/intc/arm_gicv3_common.c                         |  38 +-
 hw/intc/arm_gicv3_dist.c                           |   3 +-
 hw/intc/arm_gicv3_its_kvm.c                        |   2 +-
 hw/intc/arm_gicv3_kvm.c                            |  44 +-
 hw/intc/arm_gicv3_redist.c                         |   3 +-
 hw/misc/iotkit-secctl.c                            |  38 +-
 hw/misc/tz-mpc.c                                   | 628 +++++++++++++++++++++
 hw/xen/xen_pt_graphics.c                           |   2 +-
 hw/xen/xen_pt_load_rom.c                           |   6 +-
 target/arm/cpu.c                                   |  12 +
 target/arm/kvm.c                                   |  11 +-
 target/arm/translate.c                             |  45 +-
 vl.c                                               |   4 +-
 MAINTAINERS                                        |   2 +
 default-configs/arm-softmmu.mak                    |   1 +
 hw/misc/trace-events                               |   8 +
 .../LICENSES/exceptions/Linux-syscall-note         |   2 +-
 linux-headers/LICENSES/preferred/GPL-2.0           |   6 +
 48 files changed, 1250 insertions(+), 111 deletions(-)
 create mode 100644 include/hw/misc/tz-mpc.h
 create mode 100644 hw/misc/tz-mpc.c
