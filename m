Received: from eggs.gnu.org ([2001:4830:134:3::10]:52821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnt7D-0000SW-MP
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 17:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnt79-0006oq-Bl
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 17:04:35 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 1 Sep 2017 14:00:32 -0700
Message-ID: <cover.1504293917.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/6]  Add the ZynqMP PMU and IPI
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

The machine only has the CPU and memory connected, but that is enough
to run some of the ROM code on the machine.

The series also adds the IPI device and connects it to the ZynqMP ARM
side and the ZynqMP PMU. These IPI devices don't connect between the ARM
and MicroBlaze instances though.

The PMU machine is missing an interrupt controller, which needs to be
added later on.


Alistair Francis (6):
  xlnx-zynqmp-pmu: Initial commit of the ZynqMP PMU
  xlnx-zynqmp-pmu: Add the CPU and memory
  aarch64-softmmu.mak: Use an ARM specific config
  xlnx-zynqmp-ipi: Initial version of the Xilinx IPI device
  xlnx-zynqmp-pmu: Connect the IPI device to the PMU
  xlnx-zynqmp: Connect the IPI device to the ZynqMP SoC

 default-configs/aarch64-softmmu.mak    |   1 +
 default-configs/microblaze-softmmu.mak |   1 +
 hw/arm/Makefile.objs                   |   2 +-
 hw/arm/xlnx-zynqmp.c                   |  14 ++
 hw/display/Makefile.objs               |   2 +-
 hw/dma/Makefile.objs                   |   2 +-
 hw/intc/Makefile.objs                  |   1 +
 hw/intc/xlnx-zynqmp-ipi.c              | 377 +++++++++++++++++++++++++++++++++
 hw/microblaze/Makefile.objs            |   1 +
 hw/microblaze/xlnx-zynqmp-pmu.c        | 172 +++++++++++++++
 include/hw/arm/xlnx-zynqmp.h           |   2 +
 include/hw/intc/xlnx-zynqmp-ipi.h      |  57 +++++
 12 files changed, 629 insertions(+), 3 deletions(-)
 create mode 100644 hw/intc/xlnx-zynqmp-ipi.c
 create mode 100644 hw/microblaze/xlnx-zynqmp-pmu.c
 create mode 100644 include/hw/intc/xlnx-zynqmp-ipi.h

-- 
2.11.0
