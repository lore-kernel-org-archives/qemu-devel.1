Received: from eggs.gnu.org ([2001:4830:134:3::10]:38873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dI8pL-0000mi-Q1
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dI8pH-0005KX-2K
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:58638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dI8pG-0005K6-Qh
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:22:51 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Tue,  6 Jun 2017 15:22:26 +0800
Message-Id: <20170606072229.9302-2-haozhong.zhang@intel.com>
In-Reply-To: <20170606072229.9302-1-haozhong.zhang@intel.com>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2 1/4] nvdimm: add a macro for property
 "label-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
 hw/mem/nvdimm.c         | 2 +-
 include/hw/mem/nvdimm.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index db896b0bb6..a9b0863f20 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -66,7 +66,7 @@ out:
 
 static void nvdimm_init(Object *obj)
 {
-    object_property_add(obj, "label-size", "int",
+    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                         NULL, NULL);
 }
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 03e1ff9558..f1f3987055 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -47,6 +47,9 @@
 #define NVDIMM_CLASS(oc) OBJECT_CLASS_CHECK(NVDIMMClass, (oc), TYPE_NVDIMM)
 #define NVDIMM_GET_CLASS(obj) OBJECT_GET_CLASS(NVDIMMClass, (obj), \
                                                TYPE_NVDIMM)
+
+#define NVDIMM_LABEL_SIZE_PROP "label-size"
+
 struct NVDIMMDevice {
     /* private */
     PCDIMMDevice parent_obj;
-- 
2.11.0
