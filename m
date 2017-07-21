Received: from eggs.gnu.org ([2001:4830:134:3::10]:36341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dYVaV-00076J-Gx
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dYVaU-0007us-Ox
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:55:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 11:55:09 +0100
Message-Id: <1500634509-28011-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.10] mps2: Correctly set parent bus for
 SCC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

A cut-and-paste error meant that instead of setting the
qdev parent bus for the SCC device we were setting it
twice for the ARMv7M container device. Fix this bug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
