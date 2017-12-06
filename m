Received: from eggs.gnu.org ([2001:4830:134:3::10]:53059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eMi9j-00087O-Ur
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eMi9g-0002Kc-Qv
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:27:07 -0500
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com
	([104.47.33.67]:53584
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eMi9g-0002KC-GO
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 17:27:04 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 6 Dec 2017 14:22:43 -0800
Message-ID: <cover.1512598866.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH-2.12 v2 0/3] Update the reset values of the
 Xilinx ZynqMP QSPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, frasse.iglesias@gmail.com, frederic.konrad@adacore.com

Update the reset values of the Xilinx ZynqMP QSPI device to match the
resister spec here:
https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrascale-registers.html

V2:
 - Don't double set registers

Based-on: 20171126231634.9531-14-frasse.iglesias@gmail.com

Alistair Francis (3):
  xilinx_spips: Update the QSPI Mod ID reset value
  xilinx_spips: Set all of the reset values
  xilinx_spips: Use memset instead of a for loop to zero registers

 hw/ssi/xilinx_spips.c         | 45 +++++++++++++++++++++++++++++++------------
 include/hw/ssi/xilinx_spips.h |  2 +-
 2 files changed, 34 insertions(+), 13 deletions(-)

-- 
2.14.1
