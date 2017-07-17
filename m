Received: from eggs.gnu.org ([2001:4830:134:3::10]:34020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWvvh-0000OZ-8I
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 22:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWvvg-0001Wp-Dv
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 22:38:37 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 10:38:20 +0800
Message-Id: <20170717023824.18796-3-famz@redhat.com>
In-Reply-To: <20170717023824.18796-1-famz@redhat.com>
References: <20170717023824.18796-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 2/6] armv7m: Convert armv7m.memory to
 DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/arm/armv7m.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 8efc4e8..1c837da 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -132,12 +132,6 @@ static void armv7m_instance_init(Object *obj)
 
     /* Can't init the cpu here, we don't yet know which model to use */
 
-    object_property_add_link(obj, "memory",
-                             TYPE_MEMORY_REGION,
-                             (Object **)&s->board_memory,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
     memory_region_init(&s->container, obj, "armv7m-container", UINT64_MAX);
 
     object_initialize(&s->nvic, sizeof(s->nvic), "armv7m_nvic");
@@ -248,6 +242,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
 
 static Property armv7m_properties[] = {
     DEFINE_PROP_STRING("cpu-model", ARMv7MState, cpu_model),
+    DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.4
