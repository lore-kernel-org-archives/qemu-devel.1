Received: from eggs.gnu.org ([2001:4830:134:3::10]:38388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ee74C-00030U-3z
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ee747-0008Tg-2r
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:29:20 -0500
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com
	([104.47.37.85]:47408
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1ee746-0008RM-LU
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:29:15 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 23 Jan 2018 14:24:42 -0800
Message-ID: <cover.1516746211.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/3]  Add and connect the ZynqMP RTC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, f4bug@amsat.org

V5:
 - Recalculate tick_offset after migration

V4:
 - Use the RegisterAccessInfo .unimp functionality

V3:
 - Store an offset value
 - Use mktimegm()
 - Log unimplemented writes

V2:
 - Delete unused realise function
 - Add cover letter
 - Convert DB_PRINT() macro to trace


Alistair Francis (3):
  xlnx-zynqmp-rtc: Initial commit
  xlnx-zynqmp-rtc: Add basic time support
  xlnx-zynqmp: Connect the RTC device

 include/hw/arm/xlnx-zynqmp.h       |   2 +
 include/hw/timer/xlnx-zynqmp-rtc.h |  87 ++++++++++++
 hw/arm/xlnx-zynqmp.c               |  14 ++
 hw/timer/xlnx-zynqmp-rtc.c         | 266 +++++++++++++++++++++++++++++++++=
++++
 hw/timer/Makefile.objs             |   1 +
 hw/timer/trace-events              |   3 +
 6 files changed, 373 insertions(+)
 create mode 100644 include/hw/timer/xlnx-zynqmp-rtc.h
 create mode 100644 hw/timer/xlnx-zynqmp-rtc.c

--=20
2.14.1
