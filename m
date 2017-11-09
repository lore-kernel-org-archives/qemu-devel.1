Received: from eggs.gnu.org ([2001:4830:134:3::10]:33097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCuli-0008QG-36
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCuld-0002FF-7n
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:53:50 -0500
Received: from mail-dm3nam03on0066.outbound.protection.outlook.com
	([104.47.41.66]:17024
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCulc-0002Ek-UN
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 16:53:45 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 9 Nov 2017 13:49:30 -0800
Message-ID: <cover.1510263731.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for 2.11 v2 0/2] Xilinx ZCU102 fixes for 2.11
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

V2:
 - Update qemu-doc.texi

Alistair Francis (2):
  xlnx-zynqmp: Properly support the smp command line option
  xlnx-zcu102: Add an info message deprecating the EP108

 hw/arm/xlnx-zcu102.c |  6 +++++-
 hw/arm/xlnx-zynqmp.c | 26 ++++++++++++++++----------
 qemu-doc.texi        |  7 +++++++
 3 files changed, 28 insertions(+), 11 deletions(-)

-- 
2.14.1
