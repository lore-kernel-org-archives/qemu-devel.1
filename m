Received: from eggs.gnu.org ([2001:4830:134:3::10]:41483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecF8j-0007TQ-EO
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecF8e-0002mN-Ib
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:42:17 -0500
Sender: Alistair Francis <alistair23@gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 18 Jan 2018 10:37:44 -0800
Message-Id: <cover.1516300623.git.alistair.francis@xilinx.com>
Subject: [Qemu-devel] [PATCH v6 0/9]  Add the ZynqMP PMU and IPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, qemu-arm@nongnu.org


This series adds the ZynqMP Power Management Unit (PMU) machine with basic
functionality.

The machine only has the
 - CPU
 - Memory
 - Interrupt controller
 - IPI device

connected, but that is enough to run some of the ROM and firmware
code on the machine

The series also adds the IPI device and connects it to the ZynqMP ARM
side and the ZynqMP PMU. These IPI devices don't connect between the ARM
and MicroBlaze instances though.

V6:
 - Pass initrd instead of kernel to microblaze_load_kernel()
V5:
 - Fix clang makecheck error
 - Rebase on master
V4:
 - Rename the ZCU102 machine to just ZynqMP
 - Rename the PMC SoC to "xlnx,zynqmp-pmu-soc"
 - Move the IPI device to the machine instead of the SoC
V3:
 - Add the interrupt controller
 - Replace some of the error_fatals with errp
 - Fix the PMU CPU name



Alistair Francis (9):
  microblaze: boot.c: Don't try to find NULL pointer
  xlnx-zynqmp-pmu: Initial commit of the ZynqMP PMU
  xlnx-zynqmp-pmu: Add the CPU and memory
  aarch64-softmmu.mak: Use an ARM specific config
  xlnx-pmu-iomod-intc: Add the PMU Interrupt controller
  xlnx-zynqmp-pmu: Connect the PMU interrupt controller
  xlnx-zynqmp-ipi: Initial version of the Xilinx IPI device
  xlnx-zynqmp-pmu: Connect the IPI device to the PMU
  xlnx-zynqmp: Connect the IPI device to the ZynqMP SoC

 default-configs/aarch64-softmmu.mak    |   1 +
 default-configs/microblaze-softmmu.mak |   1 +
 include/hw/arm/xlnx-zynqmp.h           |   2 +
 include/hw/intc/xlnx-pmu-iomod-intc.h  |  58 ++++
 include/hw/intc/xlnx-zynqmp-ipi.h      |  57 ++++
 hw/arm/xlnx-zynqmp.c                   |  14 +
 hw/intc/xlnx-pmu-iomod-intc.c          | 554 +++++++++++++++++++++++++++++++++
 hw/intc/xlnx-zynqmp-ipi.c              | 377 ++++++++++++++++++++++
 hw/microblaze/boot.c                   |   2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c        | 204 ++++++++++++
 hw/arm/Makefile.objs                   |   2 +-
 hw/display/Makefile.objs               |   2 +-
 hw/dma/Makefile.objs                   |   1 +
 hw/intc/Makefile.objs                  |   2 +
 hw/microblaze/Makefile.objs            |   1 +
 15 files changed, 1275 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/intc/xlnx-pmu-iomod-intc.h
 create mode 100644 include/hw/intc/xlnx-zynqmp-ipi.h
 create mode 100644 hw/intc/xlnx-pmu-iomod-intc.c
 create mode 100644 hw/intc/xlnx-zynqmp-ipi.c
 create mode 100644 hw/microblaze/xlnx-zynqmp-pmu.c

-- 
2.14.1
