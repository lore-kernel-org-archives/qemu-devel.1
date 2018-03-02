Received: from eggs.gnu.org ([2001:4830:134:3::10]:56327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eroD4-00046g-Us
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eroD0-0007Lq-V0
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:11:06 -0500
Received: from mail-cys01nam02on061c.outbound.protection.outlook.com
	([2a01:111:f400:fe45::61c]:45952
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eroD0-0007LV-ML
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:11:02 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 2 Mar 2018 09:06:09 -0800
Message-ID: <cover.1520010339.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/2] Add a property to set the ARM CPU core
 count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com


Add an ARM CPU property which allows us to set the ARM CPU core count.



Alistair Francis (2):
  target/arm: Add a cluster size property
  hw/arm: Set the core count for Xilinx's ZynqMP

 target/arm/cpu.h     |  5 +++++
 hw/arm/xlnx-zynqmp.c |  2 ++
 target/arm/cpu.c     |  1 +
 target/arm/cpu64.c   | 11 +++++++++--
 4 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.14.1
