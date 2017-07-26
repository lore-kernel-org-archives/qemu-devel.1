Received: from eggs.gnu.org ([2001:4830:134:3::10]:40897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHSl-0001Qb-TU
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHSk-0007Ic-Uc
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:14:35 -0400
Received: from [59.151.112.132] (port=27895 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHSk-0007Ht-Hy
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:14:34 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 16:13:35 +0800
Message-ID: <6d339059d168f3a9d89f89e2125db1131b4f3023.1501052660.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <cover.1501052660.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1501052660.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 4/4] net/rocker: Fix the unusual macro name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, jiri@resnulli.us, armbru@redhat.com, f4bug@amsat.org

Cc: jasowang@redhat.com
Cc: jiri@resnulli.us
Cc: armbru@redhat.com
Cc: f4bug@amsat.org
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/rocker/rocker.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index bb38cba..9273473 100644
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
 
@@ -1285,7 +1285,7 @@ static World *rocker_world_type_by_name(Rocker *r, const char *name)
 
 static void pci_rocker_realize(PCIDevice *dev, Error **errp)
 {
-    Rocker *r = to_rocker(dev);
+    Rocker *r = ROCKER(dev);
     const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
     const MACAddr dflt = { .a = { 0x52, 0x54, 0x00, 0x12, 0x35, 0x01 } };
     static int sw_index;
@@ -1331,7 +1331,7 @@ static void pci_rocker_realize(PCIDevice *dev, Error **errp)
     /* validate switch properties */
 
     if (!r->name) {
-        r->name = g_strdup(ROCKER);
+        r->name = g_strdup(TYPE_ROCKER);
     }
 
     if (rocker_find(r->name)) {
@@ -1427,7 +1427,7 @@ err_world_type_by_name:
 
 static void pci_rocker_uninit(PCIDevice *dev)
 {
-    Rocker *r = to_rocker(dev);
+    Rocker *r = ROCKER(dev);
     int i;
 
     QLIST_REMOVE(r, next);
@@ -1460,7 +1460,7 @@ static void pci_rocker_uninit(PCIDevice *dev)
 
 static void rocker_reset(DeviceState *dev)
 {
-    Rocker *r = to_rocker(dev);
+    Rocker *r = ROCKER(dev);
     int i;
 
     for (i = 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
@@ -1498,7 +1498,7 @@ static Property rocker_properties[] = {
 };
 
 static const VMStateDescription rocker_vmsd = {
-    .name = ROCKER,
+    .name = TYPE_ROCKER,
     .unmigratable = 1,
 };
 
@@ -1521,7 +1521,7 @@ static void rocker_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo rocker_info = {
-    .name          = ROCKER,
+    .name          = TYPE_ROCKER,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(Rocker),
     .class_init    = rocker_class_init,
-- 
2.9.4
