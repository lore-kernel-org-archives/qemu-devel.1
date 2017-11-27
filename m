Received: from eggs.gnu.org ([2001:4830:134:3::10]:43881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eJB9l-0007pW-Ng
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 23:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eJB9j-0004x7-50
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 23:36:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:29419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eJB9i-0004w1-Sz
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 23:36:31 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 27 Nov 2017 12:35:16 +0800
Message-Id: <20171127043517.22441-3-haozhong.zhang@intel.com>
In-Reply-To: <20171127043517.22441-1-haozhong.zhang@intel.com>
References: <20171127043517.22441-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v3 2/3] nvdimm: add a macro for property
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
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/mem/nvdimm.c         | 2 +-
 include/hw/mem/nvdimm.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

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
-- 
2.14.1
