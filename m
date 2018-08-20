Received: from eggs.gnu.org ([2001:4830:134:3::10]:46272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frl70-00070E-15
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frl6w-0000U1-8Q
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:24:52 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:11:13 +0100
Message-Id: <20180820141116.9118-20-peter.maydell@linaro.org>
In-Reply-To: <20180820141116.9118-1-peter.maydell@linaro.org>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 19/22] hw/ssi/pl022: Correct wrong value for
 PL022_INT_RT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The PL022 interrupt registers have bits allocated as:
 0: ROR (receive overrun)
 1: RT (receive timeout)
 2: RX (receive FIFO half full or less)
 3: TX (transmit FIFO half full or less)

A cut and paste error meant we had the wrong value for
the PL022_INT_RT constant. This bug doesn't affect device
behaviour, because we don't implmenet the receive timeout
feature and so never set that interrupt bit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/pl022.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/pl022.c b/hw/ssi/pl022.c
index 3ac57f4c96a..d310671d18e 100644
--- a/hw/ssi/pl022.c
+++ b/hw/ssi/pl022.c
@@ -38,7 +38,7 @@ do { fprintf(stderr, "pl022: error: " fmt , ## __VA_ARGS__);} while (0)
 #define PL022_SR_BSY  0x10
 
 #define PL022_INT_ROR 0x01
-#define PL022_INT_RT  0x04
+#define PL022_INT_RT  0x02
 #define PL022_INT_RX  0x04
 #define PL022_INT_TX  0x08
 
-- 
2.18.0
