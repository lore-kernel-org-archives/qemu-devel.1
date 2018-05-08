Received: from eggs.gnu.org ([2001:4830:134:3::10]:57994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4GW-0002lY-0d
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4GS-00056y-1P
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:10:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  8 May 2018 12:10:35 -0300
Message-Id: <20180508151035.16774-5-f4bug@amsat.org>
In-Reply-To: <20180508151035.16774-1-f4bug@amsat.org>
References: <20180508151035.16774-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 4/4] hw/ide/ahci: Remove AllwinnerAHCIState
 from qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Files requiring AllwinnerAHCIState already include "hw/ide/ahci.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/ide/ahci.h   | 4 ++--
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index b7bb2b02d6..b44e3000cf 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -73,13 +73,13 @@ typedef struct SysbusAHCIState {
 #define ALLWINNER_AHCI_MMIO_OFF  0x80
 #define ALLWINNER_AHCI_MMIO_SIZE 0x80
 
-struct AllwinnerAHCIState {
+typedef struct AllwinnerAHCIState {
     /*< private >*/
     SysbusAHCIState parent_obj;
     /*< public >*/
 
     MemoryRegion mmio;
     uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
-};
+} AllwinnerAHCIState;
 
 #endif /* HW_IDE_AHCI_H */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index b4dc63a466..6baadfbd49 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -8,7 +8,6 @@
 typedef struct AdapterInfo AdapterInfo;
 typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
-typedef struct AllwinnerAHCIState AllwinnerAHCIState;
 typedef struct AudioState AudioState;
 typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
 typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
-- 
2.17.0
