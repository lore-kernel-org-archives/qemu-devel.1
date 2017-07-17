Received: from eggs.gnu.org ([2001:4830:134:3::10]:34070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWvvk-0000Wh-A5
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 22:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWvvj-0001YH-LF
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 22:38:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 10:38:22 +0800
Message-Id: <20170717023824.18796-5-famz@redhat.com>
In-Reply-To: <20170717023824.18796-1-famz@redhat.com>
References: <20170717023824.18796-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 4/6] xlnx_zynqmp: Convert to DEFINE_PROP_LINK
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
 hw/arm/xlnx-zynqmp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 64f52f8..cd8a4aa 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -140,11 +140,6 @@ static void xlnx_zynqmp_init(Object *obj)
                                   &error_abort);
     }
 
-    object_property_add_link(obj, "ddr-ram", TYPE_MEMORY_REGION,
-                             (Object **)&s->ddr_ram,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE, &error_abort);
-
     object_initialize(&s->gic, sizeof(s->gic), gic_class_name());
     qdev_set_parent_bus(DEVICE(&s->gic), sysbus_get_default());
 
@@ -434,6 +429,8 @@ static Property xlnx_zynqmp_props[] = {
     DEFINE_PROP_STRING("boot-cpu", XlnxZynqMPState, boot_cpu),
     DEFINE_PROP_BOOL("secure", XlnxZynqMPState, secure, false),
     DEFINE_PROP_BOOL("has_rpu", XlnxZynqMPState, has_rpu, false),
+    DEFINE_PROP_LINK("ddr-ram", XlnxZynqMPState, ddr_ram, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.9.4
