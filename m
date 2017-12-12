Received: from eggs.gnu.org ([2001:4830:134:3::10]:48272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eOplB-0002OL-IX
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:58:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eOpl7-0008Bt-Iz
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:58:33 -0500
Received: from mail-co1nam03on0078.outbound.protection.outlook.com
	([104.47.40.78]:51456
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eOpl7-00088W-4Q
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 13:58:29 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 12 Dec 2017 10:54:13 -0800
Message-ID: <c03e51d041db7f055596084891aeb1e856e32b9f.1513104804.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1513104804.git.alistair.francis@xilinx.com>
References: <cover.1513104804.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH-2.12 v3 1/3] xilinx_spips: Update the QSPI Mod
 ID reset value
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

Update the reset value to match the latest ZynqMP register spec.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---

 hw/ssi/xilinx_spips.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index ad1b2ba79f..899db814ee 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -355,6 +355,7 @@ static void xlnx_zynqmp_qspips_reset(DeviceState *d)
     s->regs[R_GQSPI_RX_THRESH] = 1;
     s->regs[R_GQSPI_GFIFO_THRESH] = 1;
     s->regs[R_GQSPI_IMR] = GQSPI_IXR_MASK;
+    s->regs[R_MOD_ID] = 0x01090101;
     s->man_start_com_g = false;
     s->gqspi_irqline = 0;
     xlnx_zynqmp_qspips_update_ixr(s);
-- 
2.14.1
