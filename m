Received: from eggs.gnu.org ([2001:4830:134:3::10]:41500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fD3Ic-0002wQ-0P
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fD3IY-0005U1-U5
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 03:32:38 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 30 Apr 2018 09:32:19 +0200
Message-Id: <1525073539-27991-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] trivial: Do not include pci.h if it is not
 necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>

There is no need to include pci.h in these files.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/ppc/ppc4xx.h            | 2 --
 include/hw/virtio/virtio-balloon.h | 1 -
 include/hw/virtio/virtio-gpu.h     | 1 -
 3 files changed, 4 deletions(-)

diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index cb0bb55..3a2a04c 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -25,8 +25,6 @@
 #ifndef PPC4XX_H
 #define PPC4XX_H
 
-#include "hw/pci/pci.h"
-
 /* PowerPC 4xx core initialization */
 PowerPCCPU *ppc4xx_init(const char *cpu_model,
                         clk_setup_t *cpu_clk, clk_setup_t *tb_clk,
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 1ea13bd..e0df352 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -17,7 +17,6 @@
 
 #include "standard-headers/linux/virtio_balloon.h"
 #include "hw/virtio/virtio.h"
-#include "hw/pci/pci.h"
 
 #define TYPE_VIRTIO_BALLOON "virtio-balloon-device"
 #define VIRTIO_BALLOON(obj) \
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 22ac3c2..79bb3fb 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -18,7 +18,6 @@
 #include "ui/qemu-pixman.h"
 #include "ui/console.h"
 #include "hw/virtio/virtio.h"
-#include "hw/pci/pci.h"
 #include "qemu/log.h"
 
 #include "standard-headers/linux/virtio_gpu.h"
-- 
1.8.3.1
