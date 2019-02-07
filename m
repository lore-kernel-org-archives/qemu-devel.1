Received: from eggs.gnu.org ([209.51.188.92]:57966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwq-0002pb-Pj
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwp-0002iC-Ms
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:52 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwp-0002Zt-EB
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:51 -0500
Received: by mail-wm1-x343.google.com with SMTP id v26so814483wmh.3
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:28 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:34 +0100
Message-Id: <1549562254-41157-52-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 51/51] FIXME vhost: add more stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com

Due to the dependency of net/ against hw/net/, it is not possible
to compile out hw/net/vhost_net.c for now.  Add more stubs to
allow it to compile when hw/net/vhost.c is missing.

(To be re-evaluated after rebase on top of the revamped vhost_net configury).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/vhost-stub.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
index 049089b..ef8e54d 100644
--- a/hw/virtio/vhost-stub.c
+++ b/hw/virtio/vhost-stub.c
@@ -15,3 +15,61 @@ VhostUserState *vhost_user_init(void)
 void vhost_user_cleanup(VhostUserState *user)
 {
 }
+
+int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
+                   VhostBackendType backend_type, uint32_t busyloop_timeout)
+{
+    return -ENODEV;
+}
+
+void vhost_dev_cleanup(struct vhost_dev *hdev)
+{
+}
+
+int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
+{
+    abort();
+}
+
+void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
+{
+}
+
+int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
+{
+    abort();
+}
+
+void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
+{
+    abort();
+}
+
+int vhost_net_set_backend(struct vhost_dev *hdev,
+                          struct vhost_vring_file *file)
+{
+    abort();
+}
+
+uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
+                            uint64_t features)
+{
+    abort();
+}
+
+void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
+                        uint64_t features)
+{
+    abort();
+}
+
+bool vhost_virtqueue_pending(struct vhost_dev *hdev, int n)
+{
+    abort();
+}
+
+void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
+                         bool mask)
+{
+    abort();
+}
-- 
1.8.3.1
