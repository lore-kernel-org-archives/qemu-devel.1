Received: from eggs.gnu.org ([2001:4830:134:3::10]:33151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRZF-0007hx-1j
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNRZD-0001ci-Uz
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:28:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 28 May 2018 20:27:12 -0300
Message-Id: <20180528232719.4721-15-f4bug@amsat.org>
In-Reply-To: <20180528232719.4721-1-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 14/21] hw: Do not include
 "sysemu/blockdev.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>

Remove those unneeded includes to speed up the compilation
process a little bit.

Code change produced with:

    $ git grep '#include "sysemu/blockdev.h"' | \
      cut -d: -f-1 | \
      xargs egrep -L "(BlockInterfaceType|DriveInfo|drive_get|blk_legacy_dinfo|blockdev_mark_auto_del)" | \
      xargs sed -i.bak '/#include "sysemu\/blockdev.h"/d'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/m25p80.c          | 1 -
 hw/block/onenand.c         | 1 -
 hw/i386/xen/xen-mapcache.c | 1 -
 hw/s390x/virtio-ccw.c      | 1 -
 hw/scsi/scsi-generic.c     | 1 -
 hw/sd/sdhci.c              | 1 -
 hw/usb/dev-storage.c       | 1 -
 monitor.c                  | 1 -
 8 files changed, 8 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index b49c8e9caa..a5ccffb4aa 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/block/onenand.c b/hw/block/onenand.c
index ab0c7ea1b3..0cb8d7fa13 100644
--- a/hw/block/onenand.c
+++ b/hw/block/onenand.c
@@ -25,7 +25,6 @@
 #include "hw/block/flash.h"
 #include "hw/irq.h"
 #include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
 #include "exec/memory.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index efa35dc6e0..541b7693b3 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -14,7 +14,6 @@
 #include <sys/resource.h>
 
 #include "hw/xen/xen_backend.h"
-#include "sysemu/blockdev.h"
 #include "qemu/bitmap.h"
 
 #include <xen/hvm/params.h>
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index b68798ac52..0a9bec484b 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -13,7 +13,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "net/net.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 381f04e339..03bce8ff39 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -17,7 +17,6 @@
 #include "qemu/error-report.h"
 #include "hw/scsi/scsi.h"
 #include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
 
 #ifdef __linux__
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index b65403947b..3017e5a95a 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -26,7 +26,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
-#include "sysemu/blockdev.h"
 #include "sysemu/dma.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index b56c75a73a..d02acda945 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -20,7 +20,6 @@
 #include "monitor/monitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
-#include "sysemu/blockdev.h"
 #include "qapi/visitor.h"
 #include "qemu/cutils.h"
 
diff --git a/monitor.c b/monitor.c
index 46814af533..d75cb20815 100644
--- a/monitor.c
+++ b/monitor.c
@@ -44,7 +44,6 @@
 #include "qemu/readline.h"
 #include "ui/console.h"
 #include "ui/input.h"
-#include "sysemu/blockdev.h"
 #include "sysemu/block-backend.h"
 #include "audio/audio.h"
 #include "disas/disas.h"
-- 
2.17.0
