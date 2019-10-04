Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D888DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 16:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A09120873
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 16:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A09120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGQE5-0003Gy-5W
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 12:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iGPuc-0006MH-CB
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iGPuZ-0000cl-Bv
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:54:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2245 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iGPuP-0000Uo-Pn; Fri, 04 Oct 2019 11:54:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C8CD5155CB26E3B1BFA7;
 Fri,  4 Oct 2019 23:54:17 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 4 Oct 2019 23:54:11 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH 4/5] hw/arm/boot: Expose the pmem nodes in the DT
Date: Fri, 4 Oct 2019 16:53:01 +0100
Message-ID: <20191004155302.4632-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, lersek@redhat.com, linuxarm@huawei.com,
 xuwei5@hisilicon.com, shannon.zhaosl@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

In case of NV-DIMM slots, let's add /pmem DT nodes.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/boot.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c264864c11..bd6d72b33e 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -20,6 +20,7 @@
 #include "hw/boards.h"
 #include "sysemu/reset.h"
 #include "hw/loader.h"
+#include "hw/mem/memory-device.h"
 #include "elf.h"
 #include "sysemu/device_tree.h"
 #include "qemu/config-file.h"
@@ -523,6 +524,44 @@ static void fdt_add_psci_node(void *fdt)
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
 }
 
+static int fdt_add_pmem_node(void *fdt, uint32_t acells, uint32_t scells)
+{
+    MemoryDeviceInfoList *info, *info_list = qmp_memory_device_list();
+    MemoryDeviceInfo *mi;
+    int ret;
+
+    for (info = info_list; info != NULL; info = info->next) {
+        mi = info->value;
+
+        if (mi->type == MEMORY_DEVICE_INFO_KIND_NVDIMM) {
+            PCDIMMDeviceInfo *di = mi->u.nvdimm.data;
+            char *nodename;
+
+            nodename = g_strdup_printf("/pmem@%" PRIx64, di->addr);
+            qemu_fdt_add_subnode(fdt, nodename);
+            qemu_fdt_setprop_string(fdt, nodename, "compatible", "pmem-region");
+            ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells,
+                                               di->addr, scells, di->size);
+            /* only set the NUMA ID if it is specified */
+            if (!ret && di->node >= 0) {
+                ret = qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id",
+                                            di->node);
+            }
+
+            g_free(nodename);
+
+            if (ret < 0) {
+                fprintf(stderr, "couldn't add NVDIMM /memory@%"PRIx64" node\n",
+                        di->addr);
+                goto out;
+            }
+        }
+    }
+out:
+    qapi_free_MemoryDeviceInfoList(info_list);
+    return ret;
+}
+
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  hwaddr addr_limit, AddressSpace *as, MachineState *ms)
 {
@@ -622,6 +661,12 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     }
 
+    rc = fdt_add_pmem_node(fdt, acells, scells);
+    if (rc < 0) {
+        fprintf(stderr, "couldn't add pmem memory nodes\n");
+        goto fail;
+    }
+
     rc = fdt_path_offset(fdt, "/chosen");
     if (rc < 0) {
         qemu_fdt_add_subnode(fdt, "/chosen");
-- 
2.17.1



