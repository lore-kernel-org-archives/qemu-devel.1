Received: from eggs.gnu.org ([2001:4830:134:3::10]:53624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOs-0003zQ-04
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2YOq-0006xS-4N
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2YOp-0006x7-Uu
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:27:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8D923D966
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 07:27:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 24 Apr 2017 09:27:00 +0200
Message-Id: <1493018820-23445-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1493018820-23445-1-git-send-email-armbru@redhat.com>
References: <1493018820-23445-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 15/15] error: Apply error_propagate_null.cocci
 again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170421122710.15373-15-famz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/pc.c          | 4 +---
 hw/s390x/virtio-ccw.c | 4 +---
 hw/usb/bus.c          | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d24388e..f3b372a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1104,9 +1104,7 @@ static void pc_new_cpu(const char *typename, int64_t apic_id, Error **errp)
     object_property_set_bool(cpu, true, "realized", &local_err);
 
     object_unref(cpu);
-    if (local_err) {
-        error_propagate(errp, local_err);
-    }
+    error_propagate(errp, local_err);
 }
 
 void pc_hot_add_cpu(const int64_t id, Error **errp)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index f376381..e7167e3 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1761,9 +1761,7 @@ static void vhost_vsock_ccw_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 
     qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
     object_property_set_bool(OBJECT(vdev), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-    }
+    error_propagate(errp, err);
 }
 
 static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 24f1608..5939b27 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -762,9 +762,7 @@ static void usb_set_attached(Object *obj, bool value, Error **errp)
 
     if (value) {
         usb_device_attach(dev, &err);
-        if (err) {
-            error_propagate(errp, err);
-        }
+        error_propagate(errp, err);
     } else {
         usb_device_detach(dev);
     }
-- 
2.7.4
