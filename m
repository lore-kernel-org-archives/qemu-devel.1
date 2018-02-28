Received: from eggs.gnu.org ([2001:4830:134:3::10]:36321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1erALC-0000lf-9n
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1erAL8-0008A1-5l
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:36:50 -0500
Received: from mail-by2nam01on0047.outbound.protection.outlook.com
	([104.47.34.47]:45366
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1erAL7-00087s-I1
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:36:45 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 28 Feb 2018 14:31:56 -0800
Message-ID: <cover.1519856998.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/5] Add and connect the PMU IOModule devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

V2:
 - Add the GPO and GPI devices as well


Alistair Francis (5):
  timer: Initial commit of xlnx-pmu-iomod-pit device
  xlnx-zynqmp-pmu: Connect the PMU IOMOD PIT devices
  hw/gpio: Add the xlnx-pmu-iomod-gpo device
  hw/gpio: Add support for the xlnx-pmu-iomod-gpi device
  xlnx-zynqmp-pmu: Connect the IOMOD GPI/GPO devices

 include/hw/gpio/xlnx-pmu-iomod-gp.h   |  57 ++++++++
 include/hw/timer/xlnx-pmu-iomod-pit.h |  58 ++++++++
 hw/gpio/xlnx-pmu-iomod-gp.c           | 203 ++++++++++++++++++++++++++++
 hw/microblaze/xlnx-zynqmp-pmu.c       | 108 +++++++++++++++
 hw/timer/xlnx-pmu-iomod-pit.c         | 241 ++++++++++++++++++++++++++++++++++
 hw/gpio/Makefile.objs                 |   2 +
 hw/timer/Makefile.objs                |   2 +
 7 files changed, 671 insertions(+)
 create mode 100644 include/hw/gpio/xlnx-pmu-iomod-gp.h
 create mode 100644 include/hw/timer/xlnx-pmu-iomod-pit.h
 create mode 100644 hw/gpio/xlnx-pmu-iomod-gp.c
 create mode 100644 hw/timer/xlnx-pmu-iomod-pit.c

-- 
2.14.1
