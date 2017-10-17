Received: from eggs.gnu.org ([2001:4830:134:3::10]:47491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4V17-0002pE-QU
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4V16-0003mX-P5
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:46:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 17 Oct 2017 13:44:20 -0300
Message-Id: <20171017164426.25277-37-f4bug@amsat.org>
In-Reply-To: <20171017164426.25277-1-f4bug@amsat.org>
References: <20171017164426.25277-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 36/42] hw/display/vga: "vga_int.h" requires
 "ui/console.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

since The VGACommonState struct has a GraphicHwOps *hw_ops member,
then remove the now unnecessary includes.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/qxl.h        | 1 -
 hw/display/vga_int.h    | 3 ++-
 hw/display/cirrus_vga.c | 1 -
 hw/display/vga-isa-mm.c | 1 -
 hw/display/vga-isa.c    | 1 -
 hw/display/vga-pci.c    | 1 -
 hw/display/vga.c        | 1 -
 hw/display/virtio-vga.c | 1 -
 hw/display/vmware_vga.c | 1 -
 9 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index f6556adb73..8668a8e05a 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -3,7 +3,6 @@
 
 #include "qemu-common.h"
 
-#include "ui/console.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "vga_int.h"
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index ad34a1f048..fe23b81442 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -25,8 +25,9 @@
 #ifndef HW_VGA_INT_H
 #define HW_VGA_INT_H
 
-#include "hw/hw.h"
+#include "exec/ioport.h"
 #include "exec/memory.h"
+#include "ui/console.h"
 
 #define ST01_V_RETRACE      0x08
 #define ST01_DISP_ENABLE    0x01
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index b4d579857a..cde3f17ebd 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -31,7 +31,6 @@
 #include "trace.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "vga_int.h"
 #include "hw/loader.h"
diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index 51ccbccc41..68c4d6e23e 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -23,7 +23,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "ui/console.h"
 #include "hw/i386/pc.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 1af95562f2..26f69fd40a 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -25,7 +25,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "ui/console.h"
 #include "hw/i386/pc.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 7adb89fcb4..1674bd3581 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -25,7 +25,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "ui/console.h"
 #include "hw/pci/pci.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 35696b6fdd..22fd069ad2 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "ui/console.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "vga_int.h"
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index f9b017d86b..baa74ba82c 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "ui/console.h"
 #include "vga_int.h"
 #include "hw/virtio/virtio-pci.h"
 #include "qapi/error.h"
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index cdc3fed6ca..06d0adc590 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -26,7 +26,6 @@
 #include "hw/hw.h"
 #include "hw/loader.h"
 #include "trace.h"
-#include "ui/console.h"
 #include "ui/vnc.h"
 #include "hw/pci/pci.h"
 
-- 
2.15.0.rc0
