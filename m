Received: from eggs.gnu.org ([2001:4830:134:3::10]:34018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWvvh-0000OE-5s
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 22:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWvvg-0001Wj-Bv
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 22:38:37 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 10:38:19 +0800
Message-Id: <20170717023824.18796-2-famz@redhat.com>
In-Reply-To: <20170717023824.18796-1-famz@redhat.com>
References: <20170717023824.18796-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 1/6] armv7m: Convert bitband.source-mamory
 to DEFINE_PROP_LINK
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
index c8a11f2..8efc4e8 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -97,12 +97,6 @@ static void bitband_init(Object *obj)
     BitBandState *s = BITBAND(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    object_property_add_link(obj, "source-memory",
-                             TYPE_MEMORY_REGION,
-                             (Object **)&s->source_memory,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
     memory_region_init_io(&s->iomem, obj, &bitband_ops, s,
                           "bitband", 0x02000000);
     sysbus_init_mmio(dev, &s->iomem);
@@ -349,6 +343,8 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
 
 static Property bitband_properties[] = {
     DEFINE_PROP_UINT32("base", BitBandState, base, 0),
+    DEFINE_PROP_LINK("source-memory", BitBandState, source_memory,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.4
