Received: from eggs.gnu.org ([2001:4830:134:3::10]:51883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWr-00053b-RU
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWq-0008Fj-TG
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:13 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWq-0008Dn-N3
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:13:12 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWp-0007r7-Hb
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:13:11 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 18:12:39 +0000
Message-Id: <1513188761-20784-42-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 41/43] xilinx_spips: Update the QSPI Mod ID
 reset value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

Update the reset value to match the latest ZynqMP register spec.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: c03e51d041db7f055596084891aeb1e856e32b9f.1513104804.git.alistair.francis@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index ad1b2ba..899db81 100644
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
2.7.4
