Received: from eggs.gnu.org ([2001:4830:134:3::10]:60269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ea812-0000NX-AW
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 17:41:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1ea80x-0003Cb-5D
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 17:41:36 -0500
Received: from mail-sn1nam01on0048.outbound.protection.outlook.com
	([104.47.32.48]:40608
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1ea80w-00039a-Pi
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 17:41:31 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 12 Jan 2018 14:36:57 -0800
Message-ID: <cover.1515796549.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3]  Add and connect the ZynqMP RTC
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

V2:
 - Delete unused realise function
 - Add cover letter
 - Convert DB_PRINT() macro to trace

Alistair Francis (3):
  xlnx-zynqmp-rtc: Initial commit
  xlnx-zynqmp-rtc: Add basic time support
  xlnx-zynqmp: Connect the RTC device

 hw/arm/xlnx-zynqmp.c               |  14 +++
 hw/timer/Makefile.objs             |   1 +
 hw/timer/trace-events              |   3 +
 hw/timer/xlnx-zynqmp-rtc.c         | 241 +++++++++++++++++++++++++++++++++=
++++
 include/hw/arm/xlnx-zynqmp.h       |   2 +
 include/hw/timer/xlnx-zynqmp-rtc.h |  87 +++++++++++++
 6 files changed, 348 insertions(+)
 create mode 100644 hw/timer/xlnx-zynqmp-rtc.c
 create mode 100644 include/hw/timer/xlnx-zynqmp-rtc.h

--
2.14.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
