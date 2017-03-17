Received: from eggs.gnu.org ([2001:4830:134:3::10]:57585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1colA8-0006BQ-PP
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 02:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1colA6-00073D-Od
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 02:14:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1colA6-000736-Hb
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 02:14:54 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 17 Mar 2017 14:14:46 +0800
Message-Id: <20170317061447.16243-2-famz@redhat.com>
In-Reply-To: <20170317061447.16243-1-famz@redhat.com>
References: <20170317061447.16243-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 v3 1/2] virtio-scsi: Make
 virtio_scsi_acquire/release public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>

They will be used in virtio-scsi-dataplane.c as well, so move them to
header.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/virtio-scsi.c           | 14 --------------
 include/hw/virtio/virtio-scsi.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 1dbc4bc..e7466d3 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -422,20 +422,6 @@ static void virtio_scsi_handle_ctrl_req(VirtIOSCSI *s, VirtIOSCSIReq *req)
     }
 }
 
-static inline void virtio_scsi_acquire(VirtIOSCSI *s)
-{
-    if (s->ctx) {
-        aio_context_acquire(s->ctx);
-    }
-}
-
-static inline void virtio_scsi_release(VirtIOSCSI *s)
-{
-    if (s->ctx) {
-        aio_context_release(s->ctx);
-    }
-}
-
 bool virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
     VirtIOSCSIReq *req;
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index f536f77..8ae0aca 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -121,6 +121,20 @@ typedef struct VirtIOSCSIReq {
     } req;
 } VirtIOSCSIReq;
 
+static inline void virtio_scsi_acquire(VirtIOSCSI *s)
+{
+    if (s->ctx) {
+        aio_context_acquire(s->ctx);
+    }
+}
+
+static inline void virtio_scsi_release(VirtIOSCSI *s)
+{
+    if (s->ctx) {
+        aio_context_release(s->ctx);
+    }
+}
+
 void virtio_scsi_common_realize(DeviceState *dev, Error **errp,
                                 VirtIOHandleOutput ctrl, VirtIOHandleOutput evt,
                                 VirtIOHandleOutput cmd);
-- 
2.9.3
