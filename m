Received: from eggs.gnu.org ([209.51.188.92]:48240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxe3-0005j5-Ae
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghxVk-0002HT-03
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:10:18 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:08:46 +0100
Message-Id: <20190111140857.4211-5-philmd@redhat.com>
In-Reply-To: <20190111140857.4211-1-philmd@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/15] hw/ide/ahci: Remove AllwinnerAHCIState
 from "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Files requiring AllwinnerAHCIState already include "hw/ide/ahci.h".

To clean "qemu/typedefs.h", move the declaration to "hw/ide/ahci.h"
(removing the forward declaration).

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
index c026229573..3a5ca74bd3 100644
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
2.17.2
