Received: from eggs.gnu.org ([2001:4830:134:3::10]:56290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqw-0000zJ-H5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqr-0007a0-T6
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqr-0007Xf-Lq
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:13 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqi-0001V6-HK
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:04 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:27:54 +0100
Message-Id: <1504790904-17018-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/31] armv7m: Convert bitband.source-memory to
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

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20170905131149.10669-2-famz@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/armv7m.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index d2477e8..4c560dd 100644
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
2.7.4
