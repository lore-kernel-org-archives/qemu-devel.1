Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1C5C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 03:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0BE206B7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 03:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0BE206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbxbK-0003An-Gy
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 22:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kbxUw-0001kq-02; Sun, 08 Nov 2020 22:05:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kbxUp-0006io-M2; Sun, 08 Nov 2020 22:05:37 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CTwpg60gZzLvWb;
 Mon,  9 Nov 2020 11:05:15 +0800 (CST)
Received: from localhost (10.174.186.67) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 11:05:15 +0800
From: Ying Fang <fangying1@huawei.com>
To: <peter.maydell@linaro.org>
Subject: [RFC PATCH v3 10/13] target/arm/cpu: Add cpu cache description for arm
Date: Mon, 9 Nov 2020 11:04:49 +0800
Message-ID: <20201109030452.2197-11-fangying1@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201109030452.2197-1-fangying1@huawei.com>
References: <20201109030452.2197-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=fangying1@huawei.com;
 helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 22:05:18
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: drjones@redhat.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, alistair.francis@wdc.com,
 Ying Fang <fangying1@huawei.com>, imammedo@redhat.com, salil.mehta@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the CPUCacheInfo structure to hold cpu cache information for ARM cpus.
A classic three level cache topology is used here. The default cache
capacity is given and userspace can overwrite these values.

Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 target/arm/cpu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h | 27 +++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 056319859f..f1bac7452c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -27,6 +27,7 @@
 #include "qapi/visitor.h"
 #include "cpu.h"
 #include "internals.h"
+#include "qemu/units.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
@@ -997,6 +998,45 @@ uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz)
     return (Aff1 << ARM_AFF1_SHIFT) | Aff0;
 }
 
+static CPUCaches default_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+    .type = DATA_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .line_size = 64,
+        .associativity = 4,
+        .sets = 256,
+        .attributes = 0x02,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .line_size = 64,
+        .associativity = 4,
+        .sets = 256,
+        .attributes = 0x04,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .sets = 1024,
+        .attributes = 0x0a,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 65536 * KiB,
+        .line_size = 64,
+        .associativity = 15,
+        .sets = 2048,
+        .attributes = 0x0a,
+    },
+};
+
 static void cpreg_hashtable_data_destroy(gpointer data)
 {
     /*
@@ -1841,6 +1881,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    cpu->caches = default_cache_info;
+
     qemu_init_vcpu(cs);
     cpu_reset(cs);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cfff1b5c8f..dbc33a9802 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -746,6 +746,30 @@ typedef enum ARMPSCIState {
 
 typedef struct ARMISARegisters ARMISARegisters;
 
+/* Cache information type */
+enum CacheType {
+    DATA_CACHE,
+    INSTRUCTION_CACHE,
+    UNIFIED_CACHE
+};
+
+typedef struct CPUCacheInfo {
+    enum CacheType type;      /* Cache Type*/
+    uint8_t level;
+    uint32_t size;            /* Size in bytes */
+    uint16_t line_size;       /* Line size in bytes */
+    uint8_t associativity;    /* Cache associativity */
+    uint32_t sets;            /* Number of sets */
+    uint8_t attributes;       /* Cache attributest  */
+} CPUCacheInfo;
+
+typedef struct CPUCaches {
+        CPUCacheInfo *l1d_cache;
+        CPUCacheInfo *l1i_cache;
+        CPUCacheInfo *l2_cache;
+        CPUCacheInfo *l3_cache;
+} CPUCaches;
+
 /**
  * ARMCPU:
  * @env: #CPUARMState
@@ -987,6 +1011,9 @@ struct ARMCPU {
 
     /* Generic timer counter frequency, in Hz */
     uint64_t gt_cntfrq_hz;
+
+    /* CPU cache information */
+    CPUCaches caches;
 };
 
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
-- 
2.23.0


