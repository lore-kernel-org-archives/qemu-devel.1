Received: from eggs.gnu.org ([2001:4830:134:3::10]:46553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZev-0007ht-Lx
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecZeu-0007v9-VT
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:36:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecZeu-0007uz-QB
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 11:36:52 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Jan 2018 14:33:42 -0200
Message-Id: <20180119163345.10649-17-ehabkost@redhat.com>
In-Reply-To: <20180119163345.10649-1-ehabkost@redhat.com>
References: <20180119163345.10649-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 16/19] nvdimm: add a macro for property
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
