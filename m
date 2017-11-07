Received: from eggs.gnu.org ([2001:4830:134:3::10]:33334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eC9A3-0008H8-8K
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eC9A0-0006bk-2c
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:03:47 -0500
Received: from mail-by2nam01on0047.outbound.protection.outlook.com
	([104.47.34.47]:17667
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eC99z-0006av-Ja
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 14:03:43 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 7 Nov 2017 10:59:36 -0800
Message-ID: <cover.1510080103.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/2]  Xilinx ZCU102 fixes for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, ehabkost@redhat.com, cota@braap.org, f4bug@amsat.org

These are two small fixes for 2.11.

Alistair Francis (2):
  xlnx-zynqmp: Properly support the smp command line option
  xlnx-zcu102: Add an info message deprecating the EP108

 hw/arm/xlnx-zcu102.c |  6 +++++-
 hw/arm/xlnx-zynqmp.c | 26 ++++++++++++++++----------
 2 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.11.0
