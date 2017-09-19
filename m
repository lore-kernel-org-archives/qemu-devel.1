Received: from eggs.gnu.org ([2001:4830:134:3::10]:59809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfD-0003vB-3R
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf8-0005IX-L1
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:07 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHf8-0005Hw-C9
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:02 -0400
Received: by mail-wm0-x241.google.com with SMTP id m127so3756503wmm.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:02 -0700 (PDT)
Received: from 640k.lan (dynamic-adsl-78-12-246-117.clienti.tiscali.it.
	[78.12.246.117]) by smtp.gmail.com with ESMTPSA id
	k18sm1292878wmd.22.2017.09.19.05.29.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 19 Sep 2017 05:30:00 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:05 +0200
Message-Id: <1505824179-21541-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/50] scsi: move block/scsi.h to
 include/scsi/constants.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Complete the transition by renaming this header, which was
shared by block/iscsi.c and the SCSI emulation code.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c                              | 2 +-
 hw/block/virtio-blk.c                      | 2 +-
 hw/scsi/megasas.c                          | 2 +-
 hw/scsi/mptendian.c                        | 2 +-
 hw/scsi/mptsas.c                           | 2 +-
 hw/scsi/scsi-bus.c                         | 2 +-
 hw/scsi/scsi-disk.c                        | 2 +-
 hw/scsi/scsi-generic.c                     | 2 +-
 hw/scsi/spapr_vscsi.c                      | 2 +-
 hw/scsi/virtio-scsi-dataplane.c            | 2 +-
 hw/scsi/virtio-scsi.c                      | 2 +-
 hw/scsi/vmw_pvscsi.c                       | 2 +-
 hw/usb/dev-uas.c                           | 2 +-
 include/hw/ide/internal.h                  | 2 +-
 include/{block/scsi.h => scsi/constants.h} | 0
 scsi/utils.c                               | 2 +-
 tests/virtio-scsi-test.c                   | 2 +-
 17 files changed, 16 insertions(+), 16 deletions(-)
 rename include/{block/scsi.h => scsi/constants.h} (100%)

diff --git a/block/iscsi.c b/block/iscsi.c
index f1d3aaa..4683f3b 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -34,7 +34,7 @@
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
 #include "block/block_int.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "qemu/iov.h"
 #include "qemu/uuid.h"
 #include "qmp-commands.h"
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index a16ac75..05d1440 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -22,7 +22,7 @@
 #include "sysemu/blockdev.h"
 #include "hw/virtio/virtio-blk.h"
 #include "dataplane/virtio-blk.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #ifdef __linux__
 # include <scsi/sg.h>
 #endif
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 734fdae..0db68aa 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -27,7 +27,7 @@
 #include "hw/pci/msix.h"
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "mfi.h"
diff --git a/hw/scsi/mptendian.c b/hw/scsi/mptendian.c
index b7fe2a2..3415229 100644
--- a/hw/scsi/mptendian.c
+++ b/hw/scsi/mptendian.c
@@ -28,7 +28,7 @@
 #include "hw/pci/msi.h"
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "trace.h"
 
 #include "mptsas.h"
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 765ab53..8bae8f5 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -30,7 +30,7 @@
 #include "hw/pci/msi.h"
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "mptsas.h"
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 652ab04..977f7bc 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -3,7 +3,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/scsi/scsi.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "hw/qdev.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index ac8be40..6e841fb 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -32,7 +32,7 @@ do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/scsi/scsi.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 04c687e..bd0d9ff 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -34,7 +34,7 @@ do { printf("scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
 do { fprintf(stderr, "scsi-generic: " fmt , ## __VA_ARGS__); } while (0)
 
 #include <scsi/sg.h>
-#include "block/scsi.h"
+#include "scsi/constants.h"
 
 #ifndef MAX_UINT
 #define MAX_UINT ((unsigned int)-1)
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 55ee48c..360db53 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -36,7 +36,7 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/scsi/scsi.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "srp.h"
 #include "hw/qdev.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 944ea4e..add4b3f 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -17,7 +17,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/block-backend.h"
 #include "hw/scsi/scsi.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index aca1909..3aa9971 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -21,7 +21,7 @@
 #include "qemu/iov.h"
 #include "sysemu/block-backend.h"
 #include "hw/scsi/scsi.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 77d8b6f..6d3f0bf 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/scsi/scsi.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "hw/pci/msi.h"
 #include "vmw_pvscsi.h"
 #include "trace.h"
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index fffc424..c218b53 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -19,7 +19,7 @@
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 #include "hw/scsi/scsi.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 
 /* --------------------------------------------------------------------- */
 
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 7dd0db4..180e00e 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -11,7 +11,7 @@
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
 #include "hw/block/block.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "qapi/error.h"
 
 /* debug IDE devices */
diff --git a/include/block/scsi.h b/include/scsi/constants.h
similarity index 100%
rename from include/block/scsi.h
rename to include/scsi/constants.h
diff --git a/scsi/utils.c b/scsi/utils.c
index 6ee9f40..fab60bd 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -14,7 +14,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "scsi/utils.h"
 #include "qemu/bswap.h"
 
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index d148512..2934305 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "block/scsi.h"
+#include "scsi/constants.h"
 #include "libqos/libqos-pc.h"
 #include "libqos/libqos-spapr.h"
 #include "libqos/virtio.h"
-- 
1.8.3.1
