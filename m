Received: from eggs.gnu.org ([2001:4830:134:3::10]:56077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dyKxl-0004QO-V4
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 12:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dyKxh-00041c-WD
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 12:50:02 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 30 Sep 2017 17:49:35 +0100
Message-Id: <1506790175-581-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] macio: add missing registers to
 VMStateDescription
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
List-ID: <qemu-devel.nongnu.org>

Commit 4f7265f "ppc/ide/macio: Add missing registers" added two extra macio
registers but forgot to add them to the corresponding VMStateDescription.

The version number is bumped accordingly, although this will have little
effect given that the Mac machines are practically unmigratable.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/macio.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index ce194c6..2e043ef 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -353,12 +353,14 @@ static const MemoryRegionOps pmac_ide_ops = {
 
 static const VMStateDescription vmstate_pmac = {
     .name = "ide",
-    .version_id = 4,
+    .version_id = 5,
     .minimum_version_id = 0,
     .fields = (VMStateField[]) {
         VMSTATE_IDE_BUS(bus, MACIOIDEState),
         VMSTATE_IDE_DRIVES(bus.ifs, MACIOIDEState),
         VMSTATE_BOOL(dma_active, MACIOIDEState),
+        VMSTATE_UINT32(timing_reg, MACIOIDEState),
+        VMSTATE_UINT32(irq_reg, MACIOIDEState),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
1.7.10.4
