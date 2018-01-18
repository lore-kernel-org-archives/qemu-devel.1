Received: from eggs.gnu.org ([2001:4830:134:3::10]:46331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzg2-0001OV-1l
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzfx-00054c-8E
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebzfx-00054B-2R
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:33 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:09:57 -0200
Message-Id: <20180118021000.27203-17-ehabkost@redhat.com>
In-Reply-To: <20180118021000.27203-1-ehabkost@redhat.com>
References: <20180118021000.27203-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 16/19] nvdimm: add a macro for property
 "label-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>

From: Haozhong Zhang <haozhong.zhang@intel.com>

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20171211072806.2812-3-haozhong.zhang@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/mem/nvdimm.h | 3 +++
 hw/mem/nvdimm.c         | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 03e1ff9558..28e68ddf59 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -47,6 +47,9 @@
 #define NVDIMM_CLASS(oc) OBJECT_CLASS_CHECK(NVDIMMClass, (oc), TYPE_NVDIMM)
 #define NVDIMM_GET_CLASS(obj) OBJECT_GET_CLASS(NVDIMMClass, (obj), \
                                                TYPE_NVDIMM)
+
+#define NVDIMM_LABLE_SIZE_PROP "label-size"
+
 struct NVDIMMDevice {
     /* private */
     PCDIMMDevice parent_obj;
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 952fce5ec8..618c3d677b 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -66,7 +66,7 @@ out:
 
 static void nvdimm_init(Object *obj)
 {
-    object_property_add(obj, "label-size", "int",
+    object_property_add(obj, NVDIMM_LABLE_SIZE_PROP, "int",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                         NULL, NULL);
 }
-- 
2.14.3
