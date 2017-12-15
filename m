Received: from eggs.gnu.org ([2001:4830:134:3::10]:34796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgj9-0002n4-2T
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePgj5-0005P3-Tw
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 22:31:59 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 00:29:56 -0300
Message-Id: <20171215033015.738-25-f4bug@amsat.org>
In-Reply-To: <20171215033015.738-1-f4bug@amsat.org>
References: <20171215033015.738-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 24/43] misc: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/audio/pcspk.c                    | 1 -
 hw/i386/xen/xen_platform.c          | 1 -
 hw/isa/vt82c686.c                   | 1 -
 hw/misc/ivshmem.c                   | 1 -
 hw/misc/sga.c                       | 1 -
 hw/pci-bridge/pci_expander_bridge.c | 1 -
 monitor.c                           | 1 -
 7 files changed, 7 deletions(-)

diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 0206f7399b..908696d483 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "hw/audio/soundhw.h"
 #include "audio/audio.h"
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 056b87de0b..fc8623c90b 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -26,7 +26,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/ide.h"
 #include "hw/pci/pci.h"
 #include "hw/irq.h"
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index c129985e2a..4084b32be9 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -12,7 +12,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus.h"
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index a5a46827fe..4919011f38 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -20,7 +20,6 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
diff --git a/hw/misc/sga.c b/hw/misc/sga.c
index 03b006d6f0..97fd63f176 100644
--- a/hw/misc/sga.c
+++ b/hw/misc/sga.c
@@ -26,7 +26,6 @@
  */
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
-#include "hw/i386/pc.h"
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 8c8ac737ad..9e799dc10f 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -16,7 +16,6 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bridge.h"
-#include "hw/i386/pc.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
diff --git a/monitor.c b/monitor.c
index e36fb5308d..d682eee2d8 100644
--- a/monitor.c
+++ b/monitor.c
@@ -28,7 +28,6 @@
 #include "hw/hw.h"
 #include "monitor/qdev.h"
 #include "hw/usb.h"
-#include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "sysemu/watchdog.h"
 #include "hw/loader.h"
-- 
2.15.1
