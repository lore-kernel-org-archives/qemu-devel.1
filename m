Received: from eggs.gnu.org ([2001:4830:134:3::10]:48981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLlA-00028F-71
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fSLl8-00005a-K7
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 08:17:20 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 11 Jun 2018 14:16:53 +0200
Message-Id: <20180611121655.19616-10-david@redhat.com>
In-Reply-To: <20180611121655.19616-1-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 09/11] pc-dimm: remove
 pc_dimm_get_vmstate_memory_region()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

We can reuse pc_dimm_get_memory_region() now, as both functions are
(besides the assert which is also correct), equal.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/pc-dimm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9a0da5d441..bc79dd04d8 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -219,11 +219,6 @@ static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm)
     return host_memory_backend_get_memory(dimm->hostmem);
 }
 
-static MemoryRegion *pc_dimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
-{
-    return host_memory_backend_get_memory(dimm->hostmem);
-}
-
 static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
 {
     const PCDIMMDevice *dimm = PC_DIMM(md);
@@ -282,7 +277,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
     dc->desc = "DIMM memory module";
 
     ddc->get_memory_region = pc_dimm_get_memory_region;
-    ddc->get_vmstate_memory_region = pc_dimm_get_vmstate_memory_region;
+    ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
 
     mdc->get_addr = pc_dimm_md_get_addr;
     /* for a dimm plugged_size == region_size */
-- 
2.17.1
