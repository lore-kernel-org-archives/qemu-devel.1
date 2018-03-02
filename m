Received: from eggs.gnu.org ([2001:4830:134:3::10]:59964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1erqEm-0007iT-6G
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1erqEh-0002ey-Ve
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:21:00 -0500
Received: from mail-by2nam01on0068.outbound.protection.outlook.com
	([104.47.34.68]:10861
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1erqEh-0002eR-JY
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 14:20:55 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 2 Mar 2018 11:15:58 -0800
Message-ID: <cover.1520018138.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/2] Add a property to set the ARM CPU core
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
V3:
 - Fix Linux user mode compile failure

V2:
 - Fix commit message and title.
 - Move the core_count default setting logic to the arm_cpu_realize()
   function.


Alistair Francis (2):
  target/arm: Add a core count property
  hw/arm: Set the core count for Xilinx's ZynqMP

 target/arm/cpu.h     | 5 +++++
 hw/arm/xlnx-zynqmp.c | 2 ++
 target/arm/cpu.c     | 6 ++++++
 target/arm/cpu64.c   | 6 ++++--
 4 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.14.1
