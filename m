Received: from eggs.gnu.org ([2001:4830:134:3::10]:41929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fFKWd-0004q4-Gl
	for qemu-devel@nongnu.org; Sun, 06 May 2018 10:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fFKWY-0008MR-Cb
	for qemu-devel@nongnu.org; Sun, 06 May 2018 10:20:31 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun,  6 May 2018 15:20:02 +0100
Message-Id: <20180506142005.19580-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180506142005.19580-1-mark.cave-ayland@ilande.co.uk>
References: <20180506142005.19580-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/4] uninorth: add impl min_access_size and
 max_access_size to unin_ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

>From testing all my local images the uninorth registers are only ever
read or written with 32-bit accesses.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/uninorth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index ba76b84dbc..a658f9230a 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -548,6 +548,10 @@ static const MemoryRegionOps unin_ops = {
     .read = unin_read,
     .write = unin_write,
     .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
 };
 
 static void unin_init(Object *obj)
-- 
2.11.0
