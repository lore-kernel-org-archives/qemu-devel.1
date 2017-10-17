Received: from eggs.gnu.org ([2001:4830:134:3::10]:50278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOP-0008GK-Mq
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOO-0006rc-JS
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:13 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:19 +1100
Message-Id: <20171017042152.29443-2-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 01/34] macio: add missing registers to
 VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Commit 4f7265f "ppc/ide/macio: Add missing registers" added two extra macio
registers but forgot to add them to the corresponding VMStateDescription.

The version number is bumped accordingly, although this will have little
effect given that the Mac machines are practically unmigratable.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ide/macio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index ce194c6cec..2e043ef1ea 100644
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
2.13.6
