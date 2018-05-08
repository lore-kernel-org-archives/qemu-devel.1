Received: from eggs.gnu.org ([2001:4830:134:3::10]:57963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4GS-0002ic-JR
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG4GM-000524-Hu
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:10:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  8 May 2018 12:10:33 -0300
Message-Id: <20180508151035.16774-3-f4bug@amsat.org>
In-Reply-To: <20180508151035.16774-1-f4bug@amsat.org>
References: <20180508151035.16774-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/4] hw/pcmcia: Remove PCMCIACardState from
 qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>

There is only one file requiring this typedef (hw/arm/pxa.h),
let it include "hw/pcmcia.h" directly to simplify qemu/typedefs.h.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/pxa.h    | 1 +
 include/hw/pcmcia.h     | 4 ++--
 include/qemu/typedefs.h | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index 0df1199caa..f6dfb5c0cf 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -12,6 +12,7 @@
 
 #include "exec/memory.h"
 #include "target/arm/cpu-qom.h"
+#include "hw/pcmcia.h"
 
 /* Interrupt numbers */
 # define PXA2XX_PIC_SSP3	0
diff --git a/include/hw/pcmcia.h b/include/hw/pcmcia.h
index 79cac9c761..1b4080764f 100644
--- a/include/hw/pcmcia.h
+++ b/include/hw/pcmcia.h
@@ -18,13 +18,13 @@ typedef struct PCMCIASocket {
 #define PCMCIA_CARD_CLASS(cls) \
     OBJECT_CLASS_CHECK(PCMCIACardClass, cls, TYPE_PCMCIA_CARD)
 
-struct PCMCIACardState {
+typedef struct PCMCIACardState {
     /*< private >*/
     DeviceState parent_obj;
     /*< public >*/
 
     PCMCIASocket *slot;
-};
+} PCMCIACardState;
 
 typedef struct PCMCIACardClass {
     /*< private >*/
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 325c72de33..c7a0159bd2 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -76,7 +76,6 @@ typedef struct PCIHostDeviceAddress PCIHostDeviceAddress;
 typedef struct PCIHostState PCIHostState;
 typedef struct PCMachineClass PCMachineClass;
 typedef struct PCMachineState PCMachineState;
-typedef struct PCMCIACardState PCMCIACardState;
 typedef struct PixelFormat PixelFormat;
 typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
-- 
2.17.0
