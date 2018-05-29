Received: from eggs.gnu.org ([2001:4830:134:3::10]:41553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNe1x-0005GL-Tz
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNe1u-0007Nr-TX
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:47:13 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 14:47:05 +0200
Message-Id: <20180529124707.3025-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/2] xlnx-zynqmp: Change the Cortex-R5 for
 Cortex-R5F
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, frederic.konrad@adacore.com, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, luc.michel@greensocs.com, sstabellini@kernel.org, f4bug@amsat.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The ZynqMP actually has Cortex-R5Fs with the optional FPU enabled.

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Update ZCU102 description to mention R5Fs

Edgar E. Iglesias (2):
  target-arm: Add the Cortex-R5F
  xlnx-zynqmp: Swap Cortex-R5 for Cortex-R5F

 hw/arm/xlnx-zcu102.c | 2 +-
 hw/arm/xlnx-zynqmp.c | 2 +-
 target/arm/cpu.c     | 9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.14.1
