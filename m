Received: from eggs.gnu.org ([2001:4830:134:3::10]:33940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8u-0003Vw-5m
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVq8s-0001F8-TR
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVq8s-0001Ek-9R
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 22:15:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 520709E618
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:15:41 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 14 Jul 2017 10:15:01 +0800
Message-Id: <20170714021509.23681-13-famz@redhat.com>
In-Reply-To: <20170714021509.23681-1-famz@redhat.com>
References: <20170714021509.23681-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 12/20] armv7m: Convert bitband.source-mamory
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

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
