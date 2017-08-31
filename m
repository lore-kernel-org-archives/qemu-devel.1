Received: from eggs.gnu.org ([2001:4830:134:3::10]:45977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnZ2C-0003Gk-2Z
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 19:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dnZ2B-0003eg-6V
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 19:38:04 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 31 Aug 2017 16:34:14 -0700
Message-ID: <cover.1504222314.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/5] Expose the secure and virt properties
 to the
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com


The EL2 and EL3 work is working well now and interanlly we now have
tests that expect to start in EL3 and transition through EL2 to EL1. To
make this easy to run let's expose the secure property to the machine
and also add a virt property that can enable EL2.

This series also does some machine/name tidying up and makes the first
move to deprecating the EP108 machine, which was just an early access
development board.

V2:
 - Add a virt option for setting EL2



Alistair Francis (5):
  xlnx-ep108: Rename to ZCU102
  xlnx-zcu102: Manually create the machines
  xlnx-zcu102: Add a machine level secure property
  xlnx-zcu102: Add a machine level virtualization property
  xlnx-zcu102: Mark the EP108 machine as deprecated

 hw/arm/Makefile.objs         |   2 +-
 hw/arm/xlnx-ep108.c          | 137 -----------------------
 hw/arm/xlnx-zcu102.c         | 257 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/xlnx-zynqmp.c         |   3 +-
 include/hw/arm/xlnx-zynqmp.h |   2 +
 5 files changed, 262 insertions(+), 139 deletions(-)
 delete mode 100644 hw/arm/xlnx-ep108.c
 create mode 100644 hw/arm/xlnx-zcu102.c

-- 
2.11.0
