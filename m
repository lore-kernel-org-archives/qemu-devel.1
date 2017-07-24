Received: from eggs.gnu.org ([2001:4830:134:3::10]:55510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dZgoK-0007Bu-Bc
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dZgoJ-0001dJ-GZ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dZgoJ-0001cR-AA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 13:06:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dZgoG-00009b-NQ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 18:06:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 18:06:17 +0100
Message-Id: <1500915978-29213-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500915978-29213-1-git-send-email-peter.maydell@linaro.org>
References: <1500915978-29213-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 3/4] mps2: Correctly set parent bus for SCC
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A cut-and-paste error meant that instead of setting the
qdev parent bus for the SCC device we were setting it
twice for the ARMv7M container device. Fix this bug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1500634509-28011-1-git-send-email-peter.maydell@linaro.org
---
 hw/arm/mps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index f727b43..abb0ab6 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -303,7 +303,7 @@ static void mps2_common_init(MachineState *machine)
 
     object_initialize(&mms->scc, sizeof(mms->scc), TYPE_MPS2_SCC);
     sccdev = DEVICE(&mms->scc);
-    qdev_set_parent_bus(armv7m, sysbus_get_default());
+    qdev_set_parent_bus(sccdev, sysbus_get_default());
     qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
     qdev_prop_set_uint32(sccdev, "scc-aid", 0x02000008);
     qdev_prop_set_uint32(sccdev, "scc-id", mmc->scc_id);
-- 
2.7.4
