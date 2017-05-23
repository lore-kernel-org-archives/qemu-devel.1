Received: from eggs.gnu.org ([2001:4830:134:3::10]:37655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dD14n-0005Ai-7Q
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dD14k-0004gl-1F
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:05:41 -0400
Received: from [59.151.112.132] (port=56572 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dD14i-0004eW-Uk
	for qemu-devel@nongnu.org; Tue, 23 May 2017 00:05:37 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Tue, 23 May 2017 12:04:40 +0800
Message-ID: <ec029a5251aeafccf051f27cdbf953b1ec563d4b.1495508197.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1495508197.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 4/4] net/rocker: Fix the unusual macro name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, jasowang@redhat.com, f4bug@amsat.org, jiri@resnulli.us

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/net/rocker/rocker.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 2764529..f8a32f7 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -69,10 +69,10 @@ struct rocker {
     QLIST_ENTRY(rocker) next;
 };
 
-#define ROCKER "rocker"
+#define TYPE_ROCKER "rocker"
 
-#define to_rocker(obj) \
-    OBJECT_CHECK(Rocker, (obj), ROCKER)
+#define ROCKER(obj) \
+    OBJECT_CHECK(Rocker, (obj), TYPE_ROCKER)
 
 static QLIST_HEAD(, rocker) rockers;
 
@@ -1287,7 +1287,7 @@ static World *rocker_world_type_by_name(Rocker *r, const char *name)
 
 static void pci_rocker_realize(PCIDevice *dev, Error **errp)
 {
-    Rocker *r = to_rocker(dev);
+    Rocker *r = ROCKER(dev);
     const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
     const MACAddr dflt = { .a = { 0x52, 0x54, 0x00, 0x12, 0x35, 0x01 } };
     static int sw_index;
@@ -1333,7 +1333,7 @@ static void pci_rocker_realize(PCIDevice *dev, Error **errp)
     /* validate switch properties */
 
     if (!r->name) {
-        r->name = g_strdup(ROCKER);
+        r->name = g_strdup(TYPE_ROCKER);
     }
 
     if (rocker_find(r->name)) {
@@ -1429,7 +1429,7 @@ err_world_type_by_name:
 
 static void pci_rocker_uninit(PCIDevice *dev)
 {
-    Rocker *r = to_rocker(dev);
+    Rocker *r = ROCKER(dev);
     int i;
 
     QLIST_REMOVE(r, next);
@@ -1462,7 +1462,7 @@ static void pci_rocker_uninit(PCIDevice *dev)
 
 static void rocker_reset(DeviceState *dev)
 {
-    Rocker *r = to_rocker(dev);
+    Rocker *r = ROCKER(dev);
     int i;
 
     for (i = 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
@@ -1500,7 +1500,7 @@ static Property rocker_properties[] = {
 };
 
 static const VMStateDescription rocker_vmsd = {
-    .name = ROCKER,
+    .name = TYPE_ROCKER,
     .unmigratable = 1,
 };
 
@@ -1523,7 +1523,7 @@ static void rocker_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo rocker_info = {
-    .name          = ROCKER,
+    .name          = TYPE_ROCKER,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(Rocker),
     .class_init    = rocker_class_init,
-- 
2.9.3
