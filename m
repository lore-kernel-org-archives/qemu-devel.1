Received: from eggs.gnu.org ([2001:4830:134:3::10]:48969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUz0-0001uz-H3
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyz-0000q1-7U
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38612 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyz-0000pv-3m
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:17 -0400
Date: Wed, 23 May 2018 17:43:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-20-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 19/28] nvdimm: fix typo in label-size definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

From: Ross Zwisler <ross.zwisler@linux.intel.com>

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Fixes: commit da6789c27c2e ("nvdimm: add a macro for property "label-size"")
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/mem/nvdimm.h | 2 +-
 hw/mem/nvdimm.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 7fd87c4..74c6033 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -48,7 +48,7 @@
 #define NVDIMM_GET_CLASS(obj) OBJECT_GET_CLASS(NVDIMMClass, (obj), \
                                                TYPE_NVDIMM)
 
-#define NVDIMM_LABLE_SIZE_PROP "label-size"
+#define NVDIMM_LABEL_SIZE_PROP "label-size"
 #define NVDIMM_UNARMED_PROP    "unarmed"
 
 struct NVDIMMDevice {
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index acb656b..4087aca 100644
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
-- 
MST
