Received: from eggs.gnu.org ([2001:4830:134:3::10]:38428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fECqa-0005BV-Hd
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fECqV-0006yH-Vh
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:56:28 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 13:56:18 +0200
Message-Id: <20180503115620.10596-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/2] xlnx-zynqmp: Change the Cortex-R5 for
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
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, frederic.konrad@adacore.com, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

The ZynqMP actually has Cortex-R5Fs with the optional FPU enabled.

Cheers,
Edgar


Edgar E. Iglesias (2):
  target-arm: Add the Cortex-R5F
  xlnx-zynqmp: Swap Cortex-R5 for Cortex-R5F

 hw/arm/xlnx-zynqmp.c | 2 +-
 target/arm/cpu.c     | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.14.1
