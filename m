Received: from eggs.gnu.org ([2001:4830:134:3::10]:54893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cJT8d-0004i6-La
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 17:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cJT8a-00040N-Fh
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 17:44:03 -0500
Received: from mail-by2nam03on0058.outbound.protection.outlook.com
	([104.47.42.58]:20386
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cJT8a-0003zX-4n
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 17:44:00 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 20 Dec 2016 14:41:59 -0800
Message-ID: <cover.1482265908.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/3]  Add the generic ARM timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, fred.konrad@greensocs.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

These three patches and and connect the Generic ARM Timer. This includes
support for dropping insecure writes and includes the ReadBase memory
map.

V3:
 - Add the ReadBase memory map
 - Update the names to match the ARM ARM
V2:
 - Fix couter/counter typo


Alistair Francis (3):
  arm_generic_timer: Add the ARM Generic Timer
  arm_generic_timer: Add support for the ReadBase memory map
  xlnx-zynqmp: Connect the ARM Generic Timer

 hw/arm/xlnx-zynqmp.c                 |  14 +++
 hw/timer/Makefile.objs               |   1 +
 hw/timer/arm_generic_timer.c         | 232 +++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h         |   2 +
 include/hw/timer/arm_generic_timer.h |  74 +++++++++++
 5 files changed, 323 insertions(+)
 create mode 100644 hw/timer/arm_generic_timer.c
 create mode 100644 include/hw/timer/arm_generic_timer.h

-- 
2.7.4
