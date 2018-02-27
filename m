Received: from eggs.gnu.org ([2001:4830:134:3::10]:53710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eqkR4-0000uQ-V2
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eqkR2-0007i0-6g
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:57:11 -0500
Received: from mail-dm3nam03on0623.outbound.protection.outlook.com
	([2a01:111:f400:fe49::623]:50153
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eqkR1-0007hR-Vy
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:57:08 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Feb 2018 10:52:14 -0800
Message-ID: <cover.1519755964.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 0/3]  Add and connect the ZynqMP RTC
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

V7:
 - Move the current_tm to the init() function

V6:
 - Migrate tick_offset and add a pre_save call

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
 include/hw/timer/xlnx-zynqmp-rtc.h |  86 ++++++++++++
 hw/arm/xlnx-zynqmp.c               |  14 ++
 hw/timer/xlnx-zynqmp-rtc.c         | 272 +++++++++++++++++++++++++++++++++=
++++
 hw/timer/Makefile.objs             |   1 +
 hw/timer/trace-events              |   3 +
 6 files changed, 378 insertions(+)
 create mode 100644 include/hw/timer/xlnx-zynqmp-rtc.h
 create mode 100644 hw/timer/xlnx-zynqmp-rtc.c

--=20
2.14.1
