Received: from eggs.gnu.org ([209.51.188.92]:44825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4z-0005dY-Km
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4x-0007Xv-Tg
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4v-0007Vw-MO
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:47 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:08 +0100
Message-Id: <1547460140-1473-14-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/25] hw/ide/ahci: Remove AllwinnerAHCIState
 from "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Files requiring AllwinnerAHCIState already include "hw/ide/ahci.h".

To clean "qemu/typedefs.h", move the declaration to "hw/ide/ahci.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/ide/ahci.h   | 4 ++--
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index b7bb2b0..b44e300 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -73,13 +73,13 @@ typedef struct SysbusAHCIState {
 #define ALLWINNER_AHCI_MMIO_OFF  0x80
 #define ALLWINNER_AHCI_MMIO_SIZE 0x80
=20
-struct AllwinnerAHCIState {
+typedef struct AllwinnerAHCIState {
     /*< private >*/
     SysbusAHCIState parent_obj;
     /*< public >*/
=20
     MemoryRegion mmio;
     uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
-};
+} AllwinnerAHCIState;
=20
 #endif /* HW_IDE_AHCI_H */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index c026229..3a5ca74 100644
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
--=20
1.8.3.1
