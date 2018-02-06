Received: from eggs.gnu.org ([2001:4830:134:3::10]:57833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ejBiG-0006MB-T9
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ejBiD-00037y-8u
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:27:40 -0500
Received: from mail-sn1nam02on0082.outbound.protection.outlook.com
	([104.47.36.82]:43568
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1ejBiC-000350-UV
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:27:37 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 6 Feb 2018 14:23:00 -0800
Message-ID: <cover.1517955702.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/2] Add and connet the PMU IOModule PIT
 device
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

Alistair Francis (2):
  timer: Initial commit of xlnx-pmu-iomod-pit device
  xlnx-zynqmp-pmu: Connect the PMU IOMOD PIT devices

 include/hw/timer/xlnx-pmu-iomod-pit.h |  58 ++++++++
 hw/microblaze/xlnx-zynqmp-pmu.c       |  35 +++++
 hw/timer/xlnx-pmu-iomod-pit.c         | 241 ++++++++++++++++++++++++++++++++++
 hw/timer/Makefile.objs                |   2 +
 4 files changed, 336 insertions(+)
 create mode 100644 include/hw/timer/xlnx-pmu-iomod-pit.h
 create mode 100644 hw/timer/xlnx-pmu-iomod-pit.c

-- 
2.14.1
