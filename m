Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E77FC388F7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E783922247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E783922247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrcP-00035S-Qq
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kUrU9-0000OH-QY; Tue, 20 Oct 2020 09:15:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42650 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kUrU0-000779-NB; Tue, 20 Oct 2020 09:15:29 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 536F2BE80799AE2F9550;
 Tue, 20 Oct 2020 21:15:12 +0800 (CST)
Received: from localhost (10.174.186.67) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 21:15:03 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC PATCH v2 08/13] hw/acpi/aml-build: add processor hierarchy node
 structure
Date: Tue, 20 Oct 2020 21:14:35 +0800
Message-ID: <20201020131440.1090-9-fangying1@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201020131440.1090-1-fangying1@huawei.com>
References: <20201020131440.1090-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:15:06
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

Add the processor hierarchy node structures to build ACPI information
for CPU topology. Three helpers are introduced:

(1) build_socket_hierarchy for socket description structure
(2) build_processor_hierarchy for processor description structure
(3) build_smt_hierarchy for thread (logic processor) description structure

Signed-off-by: Ying Fang <fangying1@huawei.com>
Signed-off-by: Henglong Fan <fanhenglong@huawei.com>
---
 hw/acpi/aml-build.c         | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/acpi/aml-build.h |  7 +++++++
 2 files changed, 44 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 3792ba96ce..da3b41b514 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1770,6 +1770,43 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms)
                  table_data->len - slit_start, 1, NULL, NULL);
 }
 
+/*
+ * ACPI 6.3: 5.2.29.1 Processor hierarchy node structure (Type 0)
+ */
+void build_socket_hierarchy(GArray *tbl, uint32_t parent, uint32_t id)
+{
+    build_append_byte(tbl, 0);          /* Type 0 - processor */
+    build_append_byte(tbl, 20);         /* Length, no private resources */
+    build_append_int_noprefix(tbl, 0, 2);  /* Reserved */
+    build_append_int_noprefix(tbl, 1, 4);  /* Flags: Physical package */
+    build_append_int_noprefix(tbl, parent, 4);  /* Parent */
+    build_append_int_noprefix(tbl, id, 4);     /* ACPI processor ID */
+    build_append_int_noprefix(tbl, 0, 4);  /* Number of private resources */
+}
+
+void build_processor_hierarchy(GArray *tbl, uint32_t flags,
+                               uint32_t parent, uint32_t id)
+{
+    build_append_byte(tbl, 0);          /* Type 0 - processor */
+    build_append_byte(tbl, 20);         /* Length, no private resources */
+    build_append_int_noprefix(tbl, 0, 2);      /* Reserved */
+    build_append_int_noprefix(tbl, flags, 4);  /* Flags */
+    build_append_int_noprefix(tbl, parent, 4); /* Parent */
+    build_append_int_noprefix(tbl, id, 4);     /* ACPI processor ID */
+    build_append_int_noprefix(tbl, 0, 4);  /* Number of private resources */
+}
+
+void build_smt_hierarchy(GArray *tbl, uint32_t parent, uint32_t id)
+{
+    build_append_byte(tbl, 0);            /* Type 0 - processor */
+    build_append_byte(tbl, 20);           /* Length, add private resources */
+    build_append_int_noprefix(tbl, 0, 2); /* Reserved */
+    build_append_int_noprefix(tbl, 0x0e, 4);    /* Processor is a thread */
+    build_append_int_noprefix(tbl, parent , 4); /* parent */
+    build_append_int_noprefix(tbl, id, 4);      /* ACPI processor ID */
+    build_append_int_noprefix(tbl, 0, 4);       /* Num of private resources */
+}
+
 /* build rev1/rev3/rev5.1 FADT */
 void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
                 const char *oem_id, const char *oem_table_id)
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index fe0055fffb..56474835a7 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -437,6 +437,13 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
 
 void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms);
 
+void build_socket_hierarchy(GArray *tbl, uint32_t parent, uint32_t id);
+
+void build_processor_hierarchy(GArray *tbl, uint32_t flags,
+                               uint32_t parent, uint32_t id);
+
+void build_smt_hierarchy(GArray *tbl, uint32_t parent, uint32_t id);
+
 void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
                 const char *oem_id, const char *oem_table_id);
 
-- 
2.23.0


