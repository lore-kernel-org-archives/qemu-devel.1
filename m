Received: from eggs.gnu.org ([2001:4830:134:3::10]:42552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYi-0000PK-CT
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYh-00055D-7x
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:52 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYg-00054U-RV
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:51 -0400
Received: by mail-wr0-x241.google.com with SMTP id g46so1016641wrd.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:50 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:26 +0200
Message-Id: <1500027028-4127-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 53/55] mips_cmgcr: Convert to DEFINE_PROP_LINK
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
Message-Id: <20170714021509.23681-19-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/mips_cmgcr.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index a1edb53..211f609 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -181,18 +181,6 @@ static void mips_gcr_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     MIPSGCRState *s = MIPS_GCR(obj);
 
-    object_property_add_link(obj, "gic", TYPE_MEMORY_REGION,
-                             (Object **)&s->gic_mr,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-
-    object_property_add_link(obj, "cpc", TYPE_MEMORY_REGION,
-                             (Object **)&s->cpc_mr,
-                             qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-
     memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
                           "mips-gcr", GCR_ADDRSPACE_SZ);
     sysbus_init_mmio(sbd, &s->iomem);
@@ -227,6 +215,10 @@ static Property mips_gcr_properties[] = {
     DEFINE_PROP_INT32("num-vp", MIPSGCRState, num_vps, 1),
     DEFINE_PROP_INT32("gcr-rev", MIPSGCRState, gcr_rev, 0x800),
     DEFINE_PROP_UINT64("gcr-base", MIPSGCRState, gcr_base, GCR_BASE_ADDR),
+    DEFINE_PROP_LINK("gic", MIPSGCRState, gic_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_LINK("cpc", MIPSGCRState, cpc_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
1.8.3.1
