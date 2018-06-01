Received: from eggs.gnu.org ([2001:4830:134:3::10]:38895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtf-0002WZ-8J
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtc-0007SO-41
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtb-0007S7-UE
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:27:20 -0400
Date: Fri, 1 Jun 2018 19:27:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-23-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/31] usb: use local path for local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

When pulling in headers that are in the same directory as the C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
index 3652919815..3a5ad7c8d0 100644
--- a/hw/usb/desc-msos.c
+++ b/hw/usb/desc-msos.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
=20
 /*
  * Microsoft OS Descriptors
diff --git a/hw/usb/desc.c b/hw/usb/desc.c
index 85c15addc5..8b6eaea407 100644
--- a/hw/usb/desc.c
+++ b/hw/usb/desc.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
=20
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 #include "trace.h"
=20
 /* ------------------------------------------------------------------ */
diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 343345235c..ee43e4914d 100644
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
=20
diff --git a/hw/usb/dev-bluetooth.c b/hw/usb/dev-bluetooth.c
index 0bbceaea0b..eac7365b0a 100644
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
=20
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index c40019df96..62d18290dc 100644
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
index 752e30c305..5d9743ef93 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -26,7 +26,7 @@
 #include "qemu-common.h"
 #include "trace.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 #include "qemu/error-report.h"
=20
 #define NUM_PORTS 8
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 3d59fe4944..560c61c7c1 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -24,7 +24,7 @@
 #include "qemu/iov.h"
 #include "trace.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
=20
 /* ---------------------------------------------------------------------=
-- */
=20
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index aea7edcf31..385e090336 100644
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
index 2829dda391..98d1ca3c91 100644
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
=20
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.=
c
index f7451923f4..2131e33d27 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -39,7 +39,7 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
=20
 #include "ccid.h"
=20
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index b56c75a73a..f2f632aeb0 100644
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
index c218b53f09..aaf5a88095 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -17,7 +17,7 @@
 #include "qemu/error-report.h"
=20
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
 #include "hw/scsi/scsi.h"
 #include "scsi/constants.h"
=20
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index bf70013059..ac0bc83b52 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -29,7 +29,7 @@
 #include "hw/hw.h"
 #include "ui/console.h"
 #include "hw/usb.h"
-#include "hw/usb/desc.h"
+#include "desc.h"
=20
 /* Interface requests */
 #define WACOM_GET_REPORT	0x2101
--=20
MST
