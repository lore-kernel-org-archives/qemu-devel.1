Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDB5C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3D7205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3D7205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38866 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDoAm-00050N-A8
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 06:40:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo2H-0006Nl-W8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo2G-0007S6-Ub
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60594 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo2C-0007Ob-Vd; Tue, 09 Apr 2019 06:31:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id C68807842779D2009383;
	Tue,  9 Apr 2019 18:31:17 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
	DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server
	id 14.3.408.0; Tue, 9 Apr 2019 18:31:08 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
	<imammedo@redhat.com>
Date: Tue, 9 Apr 2019 11:29:35 +0100
Message-ID: <20190409102935.28292-9-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: [Qemu-devel] [PATCH v4 8/8] hw/arm/boot: Expose the PC-DIMM nodes
 in the DT
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ard.biesheuvel@linaro.org,
	linuxarm@huawei.com, xuwei5@hisilicon.com,
	shannon.zhaosl@gmail.com, sebastien.boeuf@intel.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409102935.j7bST3ENACek5NzGO9qr90eGpMMDW1dYtHWsa07JM6Y@z>

This patch adds memory nodes corresponding to PC-DIMM regions.
This will enable support for cold plugged device memory for Guests
with DT boot.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/boot.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 8c840ba..150e1ed 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -19,6 +19,7 @@
 #include "sysemu/numa.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
+#include "hw/mem/memory-device.h"
 #include "elf.h"
 #include "sysemu/device_tree.h"
 #include "qemu/config-file.h"
@@ -538,6 +539,41 @@ static void fdt_add_psci_node(void *fdt)
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
 }
 
+static int fdt_add_hotpluggable_memory_nodes(void *fdt,
+                                             uint32_t acells, uint32_t scells) {
+    MemoryDeviceInfoList *info, *info_list = qmp_memory_device_list();
+    MemoryDeviceInfo *mi;
+    int ret = 0;
+
+    for (info = info_list; info != NULL; info = info->next) {
+        mi = info->value;
+        switch (mi->type) {
+        case MEMORY_DEVICE_INFO_KIND_DIMM:
+        {
+            PCDIMMDeviceInfo *di = mi->u.dimm.data;
+
+            ret = fdt_add_memory_node(fdt, acells, di->addr, scells,
+                                      di->size, di->node, true);
+            if (ret) {
+                fprintf(stderr,
+                        "couldn't add PCDIMM /memory@%"PRIx64" node\n",
+                        di->addr);
+                goto out;
+            }
+            break;
+        }
+        default:
+            fprintf(stderr, "%s memory nodes are not yet supported\n",
+                    MemoryDeviceInfoKind_str(mi->type));
+            ret = -ENOENT;
+            goto out;
+        }
+    }
+out:
+    qapi_free_MemoryDeviceInfoList(info_list);
+    return ret;
+}
+
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  hwaddr addr_limit, AddressSpace *as)
 {
@@ -637,6 +673,12 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     }
 
+    rc = fdt_add_hotpluggable_memory_nodes(fdt, acells, scells);
+    if (rc < 0) {
+        fprintf(stderr, "couldn't add hotpluggable memory nodes\n");
+        goto fail;
+    }
+
     rc = fdt_path_offset(fdt, "/chosen");
     if (rc < 0) {
         qemu_fdt_add_subnode(fdt, "/chosen");
-- 
2.7.4



