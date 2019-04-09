Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0472C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B302320818
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 10:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B302320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDo6Y-00015G-R5
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 06:35:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo2C-0006Il-09
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo2A-0007Oh-Sj
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:31:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2262 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1hDo26-0007Lz-Vz; Tue, 09 Apr 2019 06:31:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id B321B80BFBB013806270;
	Tue,  9 Apr 2019 18:31:12 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
	DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server
	id 14.3.408.0; Tue, 9 Apr 2019 18:31:04 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
	<imammedo@redhat.com>
Date: Tue, 9 Apr 2019 11:29:34 +0100
Message-ID: <20190409102935.28292-8-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: [Qemu-devel] [PATCH v4 7/8] hw/arm/boot: Add "hotpluggable"
 property to DT memory node
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
Message-ID: <20190409102934.ooAHIz3tNLDcLqjkdG96qXzS2X-3ony40RAsienL6ww@z>

Currently firmware has no way of differentiating the memory
nodes and as a result device memory nodes might get exposed
to Guest Kernel via UEFI GetMemoryMap() as early boot memory
even if Guest boots with ACPI. This will prevent hot-unplug
of the device memory. To address this, an additional
"hotpluggable" property is introduced here similar to
the MEM_AFFINITY_HOTPLUGGABLE flag used in ACPI SRAT table.

Firmware can now check for "hotpluggable" property in the
memory node and treat them differently.

This is in preparation of exposing device memory nodes in DT.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/arm/boot.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index a830655..8c840ba 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -425,7 +425,7 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
 
 static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
                                uint32_t scells, hwaddr mem_len,
-                               int numa_node_id)
+                               int numa_node_id, bool hotplug)
 {
     char *nodename;
     int ret;
@@ -444,6 +444,22 @@ static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
         ret = qemu_fdt_setprop_cell(fdt, nodename,
                                     "numa-node-id", numa_node_id);
     }
+
+    /*
+     * Firmware has no way of differentiating the memory nodes currently
+     * and in the case of device memory nodes this is a problem if Guest
+     * boots with ACPI as these nodes might get exposed to Guest Kernel
+     * via UEFI GetMemoryMap() as early boot memory. This will prevent
+     * the memory being hot-unpluggable. To address this, an additional
+     * "hotpluggable" property is introduced here, similar to the
+     * MEM_AFFINITY_HOTPLUGGABLE flag used in ACPI SRAT table.
+     * Firmware can now check for "hotpluggable" property in the memory
+     * node and treat them differently.
+     */
+
+    if (hotplug) {
+        ret = qemu_fdt_setprop(fdt, nodename, "hotpluggable", NULL, 0);
+    }
 out:
     g_free(nodename);
     return ret;
@@ -602,7 +618,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         for (i = 0; i < nb_numa_nodes; i++) {
             mem_len = numa_info[i].node_mem;
             rc = fdt_add_memory_node(fdt, acells, mem_base,
-                                     scells, mem_len, i);
+                                     scells, mem_len, i, false);
             if (rc < 0) {
                 fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
                         mem_base);
@@ -613,7 +629,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     } else {
         rc = fdt_add_memory_node(fdt, acells, binfo->loader_start,
-                                 scells, binfo->ram_size, -1);
+                                 scells, binfo->ram_size, -1, false);
         if (rc < 0) {
             fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
                     binfo->loader_start);
-- 
2.7.4



