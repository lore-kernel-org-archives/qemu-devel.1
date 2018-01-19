Received: from eggs.gnu.org ([2001:4830:134:3::10]:40027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecbZj-000871-Nc
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecbZg-00013T-MP
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:39:39 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ecbZg-00013F-GQ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:39:36 -0500
Received: by mail-pf0-x242.google.com with SMTP id t12so1989270pfg.2
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 10:39:36 -0800 (PST)
Sender: Alistair Francis <alistair23@gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 19 Jan 2018 10:35:07 -0800
Message-Id: <cover.1516386853.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/3]  Add and connect the ZynqMP RTC
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
 include/hw/timer/xlnx-zynqmp-rtc.h |  88 ++++++++++++
 hw/arm/xlnx-zynqmp.c               |  14 ++
 hw/timer/xlnx-zynqmp-rtc.c         | 276 +++++++++++++++++++++++++++++++++++++
 hw/timer/Makefile.objs             |   1 +
 hw/timer/trace-events              |   3 +
 6 files changed, 384 insertions(+)
 create mode 100644 include/hw/timer/xlnx-zynqmp-rtc.h
 create mode 100644 hw/timer/xlnx-zynqmp-rtc.c

-- 
2.14.1
