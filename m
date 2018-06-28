Received: from eggs.gnu.org ([2001:4830:134:3::10]:38054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAg-0007HF-2k
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAf-0000Zo-7L
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:38 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:37257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAf-0000Yd-0R
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:37 -0400
Received: by mail-wr0-x235.google.com with SMTP id k6-v6so6687746wrp.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:36 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:32 +0200
Message-Id: <1530216310-52873-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/60] nvdimm: no need to overwrite
 get_vmstate_memory_region()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Our parent class (PC_DIMM) provides exactly the same function.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180619134141.29478-7-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mem/nvdimm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 4087aca..f974acc 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -166,11 +166,6 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
     memory_region_set_dirty(mr, backend_offset, size);
 }
 
-static MemoryRegion *nvdimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
-{
-    return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
-}
-
 static void nvdimm_class_init(ObjectClass *oc, void *data)
 {
     PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
@@ -178,7 +173,6 @@ static void nvdimm_class_init(ObjectClass *oc, void *data)
 
     ddc->realize = nvdimm_realize;
     ddc->get_memory_region = nvdimm_get_memory_region;
-    ddc->get_vmstate_memory_region = nvdimm_get_vmstate_memory_region;
 
     nvc->read_label_data = nvdimm_read_label_data;
     nvc->write_label_data = nvdimm_write_label_data;
-- 
1.8.3.1
