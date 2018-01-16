Received: from eggs.gnu.org ([2001:4830:134:3::10]:35289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ebPlr-0005aC-QS
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ebPln-00008k-ST
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:51:15 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1ebPln-00008A-KO
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:51:11 -0500
Received: by mail-lf0-x244.google.com with SMTP id h140so17076167lfg.1
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 03:51:11 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 16 Jan 2018 12:50:59 +0100
Message-Id: <1516103467-7983-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 0/8] Xilinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The following changes since commit f521eeee3bd060b460c99e605472b7e03967db43:

  Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180115' into staging (2018-01-15 13:17:47 +0000)

are available in the git repository at:

  git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2018-01.for-upstream

for you to fetch changes up to e451272ac191cd3ac408bc89ea63a401e84d4224:

  xlnx-zynqmp: Connect the IPI device to the ZynqMP SoC (2018-01-16 11:44:49 +0100)

----------------------------------------------------------------
Xilinx queue

----------------------------------------------------------------
Alistair Francis (8):
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
 hw/arm/Makefile.objs                   |   2 +-
 hw/arm/xlnx-zynqmp.c                   |  14 +
 hw/display/Makefile.objs               |   2 +-
 hw/dma/Makefile.objs                   |   2 +-
 hw/intc/Makefile.objs                  |   2 +
 hw/intc/xlnx-pmu-iomod-intc.c          | 554 +++++++++++++++++++++++++++++++++
 hw/intc/xlnx-zynqmp-ipi.c              | 377 ++++++++++++++++++++++
 hw/microblaze/Makefile.objs            |   1 +
 hw/microblaze/xlnx-zynqmp-pmu.c        | 204 ++++++++++++
 include/hw/arm/xlnx-zynqmp.h           |   2 +
 include/hw/intc/xlnx-pmu-iomod-intc.h  |  58 ++++
 include/hw/intc/xlnx-zynqmp-ipi.h      |  57 ++++
 14 files changed, 1274 insertions(+), 3 deletions(-)
 create mode 100644 hw/intc/xlnx-pmu-iomod-intc.c
 create mode 100644 hw/intc/xlnx-zynqmp-ipi.c
 create mode 100644 hw/microblaze/xlnx-zynqmp-pmu.c
 create mode 100644 include/hw/intc/xlnx-pmu-iomod-intc.h
 create mode 100644 include/hw/intc/xlnx-zynqmp-ipi.h

Alistair Francis (8):
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
 hw/arm/Makefile.objs                   |   2 +-
 hw/arm/xlnx-zynqmp.c                   |  14 +
 hw/display/Makefile.objs               |   2 +-
 hw/dma/Makefile.objs                   |   2 +-
 hw/intc/Makefile.objs                  |   2 +
 hw/intc/xlnx-pmu-iomod-intc.c          | 554 +++++++++++++++++++++++++++++++++
 hw/intc/xlnx-zynqmp-ipi.c              | 377 ++++++++++++++++++++++
 hw/microblaze/Makefile.objs            |   1 +
 hw/microblaze/xlnx-zynqmp-pmu.c        | 204 ++++++++++++
 include/hw/arm/xlnx-zynqmp.h           |   2 +
 include/hw/intc/xlnx-pmu-iomod-intc.h  |  58 ++++
 include/hw/intc/xlnx-zynqmp-ipi.h      |  57 ++++
 14 files changed, 1274 insertions(+), 3 deletions(-)
 create mode 100644 hw/intc/xlnx-pmu-iomod-intc.c
 create mode 100644 hw/intc/xlnx-zynqmp-ipi.c
 create mode 100644 hw/microblaze/xlnx-zynqmp-pmu.c
 create mode 100644 include/hw/intc/xlnx-pmu-iomod-intc.h
 create mode 100644 include/hw/intc/xlnx-zynqmp-ipi.h

-- 
2.7.4
