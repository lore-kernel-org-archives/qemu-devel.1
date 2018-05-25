Received: from eggs.gnu.org ([2001:4830:134:3::10]:58505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFss-0003wQ-Fc
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFsr-0002q3-By
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMFsr-0002pr-6v
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:48:05 -0400
Date: Fri, 25 May 2018 19:48:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527266793-301361-15-git-send-email-mst@redhat.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527266793-301361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/20] usb: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

When pulling in headers that are in the same directory as C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/usb/desc-msos.c            | 2 +-
 hw/usb/desc.c                 | 2 +-
 hw/usb/dev-audio.c            | 2 +-
 hw/usb/dev-bluetooth.c        | 2 +-
 hw/usb/dev-hid.c              | 2 +-
 hw/usb/dev-hub.c              | 2 +-
 hw/usb/dev-mtp.c              | 2 +-
 hw/usb/dev-network.c          | 2 +-
 hw/usb/dev-serial.c           | 2 +-
 hw/usb/dev-smartcard-reader.c | 2 +-
 hw/usb/dev-storage.c          | 2 +-
 hw/usb/dev-uas.c              | 2 +-
 hw/usb/dev-wacom.c            | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/usb/desc-msos.c b/hw/usb/desc-msos.c
index 3652919..3a5ad7c 100644
--- a/hw/usb/desc-msos.c
+++ b/hw/usb/desc-msos.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 
 /*
  * Microsoft OS Descriptors
diff --git a/hw/usb/desc.c b/hw/usb/desc.c
index 85c15ad..8b6eaea 100644
--- a/hw/usb/desc.c
+++ b/hw/usb/desc.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 #include "trace.h"
 
 /* ------------------------------------------------------------------ */
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 3433452..ee43e49 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -32,7 +32,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 #include "hw/hw.h"
 #include "audio/audio.h"
 
diff --git a/hw/usb/dev-bluetooth.c b/hw/usb/dev-bluetooth.c
index 0bbceae..eac7365 100644
--- a/hw/usb/dev-bluetooth.c
+++ b/hw/usb/dev-bluetooth.c
@@ -22,7 +22,7 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 #include "sysemu/bt.h"
 #include "hw/bt.h"
 
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index c40019d..62d1829 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -26,7 +26,7 @@
 #include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "hw/input/hid.h"
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 752e30c..5d9743ef 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -26,7 +26,7 @@
 #include "qemu-common.h"
 #include "trace.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 #include "qemu/error-report.h"
 
 #define NUM_PORTS 8
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 3d59fe4..560c61c 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -24,7 +24,7 @@
 #include "qemu/iov.h"
 #include "trace.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 
 /* ----------------------------------------------------------------------- */
 
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index aea7edc..385e090 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 #include "net/net.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 2829dda..98d1ca3 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -14,7 +14,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 #include "chardev/char-serial.h"
 #include "chardev/char-fe.h"
 
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index f745192..2131e33 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -39,7 +39,7 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 
 #include "ccid.h"
 
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index b56c75a..f2f632a 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -14,7 +14,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 #include "hw/scsi/scsi.h"
 #include "ui/console.h"
 #include "monitor/monitor.h"
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index c218b53..aaf5a88 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -17,7 +17,7 @@
 #include "qemu/error-report.h"
 
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
 
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index bf70013..ac0bc83 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -29,7 +29,7 @@
 #include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 
 /* Interface requests */
 #define WACOM_GET_REPORT	0x2101
-- 
MST
