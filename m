Received: from eggs.gnu.org ([2001:4830:134:3::10]:50565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1diPxB-00054c-Ib
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1diPx8-0003gZ-H2
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:55:37 -0400
Received: from mail-by2nam03on0071.outbound.protection.outlook.com
	([104.47.42.71]:19792
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1diPx8-0003fk-3F
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:55:34 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 17 Aug 2017 11:51:59 -0700
Message-ID: <cover.1502993370.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/5] Expose the secure property to the
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com

The EL2 and EL3 work is working well now and interanlly we now have
tests that expect to start in EL3 and transition through EL2 to EL1. To
make this easy to run let's expose the secure property to the machine
and then use that to enable EL2.

This series also does some machine/name tidying up and makes the first
move to deprecating the EP108 machine, which was just an early access
development board.

Alistair Francis (5):
  xlnx-ep108: Rename to ZCU102
  xlnx-zcu102: Manually create the machines
  xlnx-zcu102: Add a machine level secure property
  xlnx-zynqmp: Allow the secure prop to enable EL2
  xlnx-zcu102: Mark the EP108 machine as deprecated

 hw/arm/Makefile.objs                   |   2 +-
 hw/arm/{xlnx-ep108.c => xlnx-zcu102.c} | 131 ++++++++++++++++++++++++++++-----
 hw/arm/xlnx-zynqmp.c                   |   2 +-
 3 files changed, 114 insertions(+), 21 deletions(-)
 rename hw/arm/{xlnx-ep108.c => xlnx-zcu102.c} (51%)

-- 
2.11.0
