Received: from eggs.gnu.org ([2001:4830:134:3::10]:42851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC5-0000dR-M3
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC4-0007mH-QE
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRC4-0007PR-JA
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC3-0003nO-87
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:35 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:12 +0100
Message-Id: <20181016152325.31367-7-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/19] net: cadence_gem: Disable TSU feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Disable the Timestamping Unit feature bit since QEMU does not
yet support it. This allows guest SW to correctly probe for
its existance.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20181011021931.4249-2-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 0fa4b0dc440..e560b7a142e 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1228,7 +1228,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_MODID] = s->revision;
     s->regs[GEM_DESCONF] = 0x02500111;
     s->regs[GEM_DESCONF2] = 0x2ab13fff;
-    s->regs[GEM_DESCONF5] = 0x002f2145;
+    s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = 0x00000200;
 
     /* Set MAC address */
-- 
2.19.0
