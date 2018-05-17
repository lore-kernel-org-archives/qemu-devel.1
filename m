Received: from eggs.gnu.org ([2001:4830:134:3::10]:45438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fJB2I-0001mU-9J
	for qemu-devel@nongnu.org; Thu, 17 May 2018 01:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fJB2A-0001Gt-FP
	for qemu-devel@nongnu.org; Thu, 17 May 2018 01:01:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:63835)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fJB2A-0000pA-3F
	for qemu-devel@nongnu.org; Thu, 17 May 2018 01:00:58 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Date: Wed, 16 May 2018 23:00:21 -0600
Message-Id: <20180517050024.20101-2-ross.zwisler@linux.intel.com>
In-Reply-To: <20180517050024.20101-1-ross.zwisler@linux.intel.com>
References: <20180517050024.20101-1-ross.zwisler@linux.intel.com>
Subject: [Qemu-devel] [qemu PATCH v2 1/4] nvdimm: fix typo in label-size
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Fixes: commit da6789c27c2e ("nvdimm: add a macro for property "label-size"")
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/mem/nvdimm.c         | 2 +-
 include/hw/mem/nvdimm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index acb656b672..4087aca25e 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -89,7 +89,7 @@ static void nvdimm_set_unarmed(Object *obj, bool value, Error **errp)
 
 static void nvdimm_init(Object *obj)
 {
-    object_property_add(obj, NVDIMM_LABLE_SIZE_PROP, "int",
+    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                         NULL, NULL);
     object_property_add_bool(obj, NVDIMM_UNARMED_PROP,
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 7fd87c4e1c..74c60332e1 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -48,7 +48,7 @@
 #define NVDIMM_GET_CLASS(obj) OBJECT_GET_CLASS(NVDIMMClass, (obj), \
                                                TYPE_NVDIMM)
 
-#define NVDIMM_LABLE_SIZE_PROP "label-size"
+#define NVDIMM_LABEL_SIZE_PROP "label-size"
 #define NVDIMM_UNARMED_PROP    "unarmed"
 
 struct NVDIMMDevice {
-- 
2.14.3
