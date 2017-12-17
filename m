Received: from eggs.gnu.org ([2001:4830:134:3::10]:41271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQgaK-00053A-7c
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQgaH-0007Bt-SI
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:35:00 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:28:00 +0300
Message-Id: <eb1595366daabb93af83ae4a3b038cae2f3ec3c4.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 55/61] hw/display/vga: "vga_int.h" requires
 "ui/console.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

since The VGACommonState struct has a GraphicHwOps *hw_ops member,
then remove the now unnecessary includes.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/cirrus_vga.c | 1 -
 hw/display/qxl.h        | 1 -
 hw/display/vga-isa-mm.c | 1 -
 hw/display/vga-isa.c    | 1 -
 hw/display/vga-pci.c    | 1 -
 hw/display/vga.c        | 1 -
 hw/display/vga_int.h    | 3 ++-
 hw/display/virtio-vga.c | 1 -
 hw/display/vmware_vga.c | 1 -
 9 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index bc32bf1e39..138ae961b9 100644
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
diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index f6556adb73..8668a8e05a 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -3,7 +3,6 @@
=20
 #include "qemu-common.h"
=20
-#include "ui/console.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "vga_int.h"
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
index ce95b40e5c..4163b532e0 100644
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
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index ad34a1f048..fe23b81442 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -25,8 +25,9 @@
 #ifndef HW_VGA_INT_H
 #define HW_VGA_INT_H
=20
-#include "hw/hw.h"
+#include "exec/ioport.h"
 #include "exec/memory.h"
+#include "ui/console.h"
=20
 #define ST01_V_RETRACE      0x08
 #define ST01_DISP_ENABLE    0x01
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
index 0e6673a911..bd3e8b3586 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -26,7 +26,6 @@
 #include "hw/hw.h"
 #include "hw/loader.h"
 #include "trace.h"
-#include "ui/console.h"
 #include "ui/vnc.h"
 #include "hw/pci/pci.h"
=20
--=20
2.11.0
