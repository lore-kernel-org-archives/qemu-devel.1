Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16A0C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 03:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546B42065D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 03:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546B42065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIkcw-0000p4-Ei
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 23:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIkUS-000579-78; Wed, 16 Sep 2020 23:21:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45244 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIkUM-0004Rp-L0; Wed, 16 Sep 2020 23:21:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 05F8EEB1067D628429A8;
 Thu, 17 Sep 2020 11:21:18 +0800 (CST)
Received: from localhost (10.174.185.104) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 11:21:07 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC PATCH 12/12] hw/arm/virt-acpi-build: Enable CPU cache topology
Date: Thu, 17 Sep 2020 11:20:33 +0800
Message-ID: <20200917032033.2020-13-fangying1@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200917032033.2020-1-fangying1@huawei.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 23:20:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, drjones@redhat.com,
 zhang.zhanghailiang@huawei.com, Henglong Fan <fanhenglong@huawei.com>,
 alex.chen@huawei.com, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 alistair.francis@wdc.com, Ying Fang <fangying1@huawei.com>,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A helper struct AcpiCacheOffset is introduced to describe the offset
of three level caches. The cache hierarchy is built according to
ACPI spec v6.3 5.2.29.2. Let's enable CPU cache topology now.

Signed-off-by: Ying Fang <fangying1@huawei.com>
Signed-off-by: Henglong Fan <fanhenglong@huawei.com>
---
 hw/acpi/aml-build.c         | 19 +++++++++-----
 hw/arm/virt-acpi-build.c    | 52 ++++++++++++++++++++++++++++++++-----
 include/hw/acpi/acpi-defs.h |  6 +++++
 include/hw/acpi/aml-build.h |  7 ++---
 4 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 123eb032cd..f8d74f3f10 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1783,27 +1783,32 @@ void build_cache_hierarchy(GArray *tbl,
 /*
  * ACPI 6.3: 5.2.29.1 Processor hierarchy node structure (Type 0)
  */
-void build_socket_hierarchy(GArray *tbl, uint32_t parent, uint32_t id)
+void build_socket_hierarchy(GArray *tbl, uint32_t parent,
+                            uint32_t offset, uint32_t id)
 {
     build_append_byte(tbl, 0);          /* Type 0 - processor */
-    build_append_byte(tbl, 20);         /* Length, no private resources */
+    build_append_byte(tbl, 24);         /* Length, no private resources */
     build_append_int_noprefix(tbl, 0, 2);  /* Reserved */
     build_append_int_noprefix(tbl, 1, 4);  /* Flags: Physical package */
     build_append_int_noprefix(tbl, parent, 4);  /* Parent */
     build_append_int_noprefix(tbl, id, 4);     /* ACPI processor ID */
-    build_append_int_noprefix(tbl, 0, 4);  /* Number of private resources */
+    build_append_int_noprefix(tbl, 1, 4);  /*  Number of private resources */
+    build_append_int_noprefix(tbl, offset, 4);  /* Private resources */
 }
 
-void build_processor_hierarchy(GArray *tbl, uint32_t flags,
-                               uint32_t parent, uint32_t id)
+void build_processor_hierarchy(GArray *tbl, uint32_t flags, uint32_t parent,
+                               AcpiCacheOffset offset, uint32_t id)
 {
     build_append_byte(tbl, 0);          /* Type 0 - processor */
-    build_append_byte(tbl, 20);         /* Length, no private resources */
+    build_append_byte(tbl, 32);         /* Length, no private resources */
     build_append_int_noprefix(tbl, 0, 2);      /* Reserved */
     build_append_int_noprefix(tbl, flags, 4);  /* Flags */
     build_append_int_noprefix(tbl, parent, 4); /* Parent */
     build_append_int_noprefix(tbl, id, 4);     /* ACPI processor ID */
-    build_append_int_noprefix(tbl, 0, 4);  /* Number of private resources */
+    build_append_int_noprefix(tbl, 3, 4);  /* Number of private resources */
+    build_append_int_noprefix(tbl, offset.l1d_offset, 4);/* Private resources */
+    build_append_int_noprefix(tbl, offset.l1i_offset, 4);/* Private resources */
+    build_append_int_noprefix(tbl, offset.l2_offset, 4); /* Private resources */
 }
 
 void build_smt_hierarchy(GArray *tbl, uint32_t parent, uint32_t id)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b5aa3d3c83..375fb9e24f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -594,29 +594,69 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                  "SRAT", table_data->len - srat_start, 3, NULL, NULL);
 }
 
-static void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms)
+static inline void arm_acpi_cache_info(CPUCacheInfo *cpu_cache,
+                                       AcpiCacheInfo *acpi_cache)
 {
+    acpi_cache->size = cpu_cache->size;
+    acpi_cache->sets = cpu_cache->sets;
+    acpi_cache->associativity = cpu_cache->associativity;
+    acpi_cache->attributes = cpu_cache->attributes;
+    acpi_cache->line_size = cpu_cache->line_size;
+}
+
+static void build_pptt(GArray *table_data, BIOSLinker *linker,
+                       VirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
     int pptt_start = table_data->len;
     int uid = 0, cpus = 0, socket;
     unsigned int smp_cores = ms->smp.cores;
     unsigned int smp_threads = ms->smp.threads;
+    AcpiCacheOffset offset;
+    ARMCPU *cpu = ARM_CPU(qemu_get_cpu(cpus));
+    AcpiCacheInfo cache_info;
 
     acpi_data_push(table_data, sizeof(AcpiTableHeader));
 
     for (socket = 0; cpus < ms->possible_cpus->len; socket++) {
-        uint32_t socket_offset = table_data->len - pptt_start;
+        uint32_t l3_offset = table_data->len - pptt_start;
+        uint32_t socket_offset;
         int core;
 
-        build_socket_hierarchy(table_data, 0, socket);
+        /* L3 cache type structure */
+        arm_acpi_cache_info(cpu->caches.l3_cache, &cache_info);
+        build_cache_hierarchy(table_data, 0, &cache_info);
+
+        socket_offset = table_data->len - pptt_start;
+        build_socket_hierarchy(table_data, 0, l3_offset, socket);
 
         for (core = 0; core < smp_cores; core++) {
             uint32_t core_offset = table_data->len - pptt_start;
             int thread;
 
+            /* L2 cache tpe structure */
+            offset.l2_offset = table_data->len - pptt_start;
+            arm_acpi_cache_info(cpu->caches.l2_cache, &cache_info);
+            build_cache_hierarchy(table_data, 0, &cache_info);
+
+            /* L1d cache type structure */
+            offset.l1d_offset = table_data->len - pptt_start;
+            arm_acpi_cache_info(cpu->caches.l1d_cache, &cache_info);
+            build_cache_hierarchy(table_data, offset.l2_offset, &cache_info);
+
+            /* L1i cache type structure */
+            offset.l1i_offset = table_data->len - pptt_start;
+            arm_acpi_cache_info(cpu->caches.l1i_cache, &cache_info);
+            build_cache_hierarchy(table_data, offset.l2_offset, &cache_info);
+
+            core_offset = table_data->len - pptt_start;
             if (smp_threads <= 1) {
-                build_processor_hierarchy(table_data, 2, socket_offset, uid++);
+                build_processor_hierarchy(table_data, 2, socket_offset,
+                                          offset, uid++);
              } else {
-                build_processor_hierarchy(table_data, 0, socket_offset, core);
+
+                build_processor_hierarchy(table_data, 0, socket_offset,
+                                          offset, core);
                 for (thread = 0; thread < smp_threads; thread++) {
                     build_smt_hierarchy(table_data, core_offset, uid++);
                 }
@@ -892,7 +932,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     if (cpu_topology_enabled) {
         acpi_add_table(table_offsets, tables_blob);
-        build_pptt(tables_blob, tables->linker, ms);
+        build_pptt(tables_blob, tables->linker, vms);
     }
 
     acpi_add_table(table_offsets, tables_blob);
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 3df38ab449..e48b7fa506 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -626,4 +626,10 @@ typedef struct AcpiCacheInfo {
     uint16_t line_size;
 } AcpiCacheInfo;
 
+typedef struct AcpiCacheOffset {
+    uint32_t l1d_offset;
+    uint32_t l1i_offset;
+    uint32_t l2_offset;
+} AcpiCacheOffset;
+
 #endif
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index ced1ae6a83..984c5dec3b 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -438,10 +438,11 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms);
 void build_cache_hierarchy(GArray *tbl,
               uint32_t next_level, AcpiCacheInfo *cache_info);
 
-void build_socket_hierarchy(GArray *tbl, uint32_t parent, uint32_t id);
+void build_socket_hierarchy(GArray *tbl, uint32_t parent,
+                            uint32_t offset, uint32_t id);
 
-void build_processor_hierarchy(GArray *tbl, uint32_t flags,
-                               uint32_t parent, uint32_t id);
+void build_processor_hierarchy(GArray *tbl, uint32_t flags, uint32_t parent,
+                               AcpiCacheOffset offset, uint32_t id);
 
 void build_smt_hierarchy(GArray *tbl, uint32_t parent, uint32_t id);
 
-- 
2.23.0


