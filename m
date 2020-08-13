Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED67C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431E8206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431E8206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Aaz-0006Mu-EY
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k6AXH-0000Ee-29; Thu, 13 Aug 2020 06:32:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4186 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k6AXE-0006qF-PT; Thu, 13 Aug 2020 06:32:38 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2C3A3952A789AAB8465B;
 Thu, 13 Aug 2020 18:32:32 +0800 (CST)
Received: from localhost.localdomain (10.175.104.175) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 13 Aug 2020 18:32:22 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC 7/9] target/arm: Add CPU features to query-cpu-model-expansion
Date: Thu, 13 Aug 2020 18:26:55 +0800
Message-ID: <20200813102657.2588720-8-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200813102657.2588720-1-liangpeng10@huawei.com>
References: <20200813102657.2588720-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=liangpeng10@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 06:32:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
 zhang.zhanghailiang@huawei.com, mst@redhat.com, cohuck@redhat.com,
 xiexiangyou@huawei.com, Peng Liang <liangpeng10@huawei.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add CPU features to the result of query-cpu-model-expansion so that
other applications (such as libvirt) can know the supported CPU
features.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 target/arm/cpu.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h     |  2 ++
 target/arm/monitor.c |  2 ++
 3 files changed, 45 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3fc54cb3a4..0f620e8afe 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -25,6 +25,8 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "qapi/qmp/qdict.h"
+#include "qom/qom-qobject.h"
 #include "cpu.h"
 #include "internals.h"
 #include "exec/exec-all.h"
@@ -1515,6 +1517,45 @@ static const CPUFeatureDep feature_dependencies[] = {
     },
 };
 
+static char *strtolower(char *src)
+{
+    char *start = src;
+
+    for (; *src; ++src) {
+        *src = tolower(*src);
+    }
+
+    return start;
+}
+
+void arm_cpu_features_to_dict(ARMCPU *cpu, QDict *features)
+{
+    Object *obj = OBJECT(cpu);
+    const char *name;
+    ObjectProperty *prop;
+    bool is_32bit = !arm_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(cpu_features); ++i) {
+        if (is_32bit != cpu_features[i].is_32bit) {
+            continue;
+        }
+
+        name = cpu_features[i].name;
+        prop = object_property_find(obj, name, NULL);
+        if (prop) {
+            QObject *value;
+            g_autofree char *tmp;
+
+            assert(prop->get);
+            value = object_property_get_qobject(obj, name, &error_abort);
+            tmp = strtolower(g_strdup(name));
+
+            qdict_put_obj(features, tmp, value);
+        }
+    }
+}
+
 static void arm_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5d8074d03b..da68b7f8f4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3933,4 +3933,6 @@ static inline bool isar_feature_any_tts2uxn(const ARMISARegisters *id)
 #define cpu_isar_feature(name, cpu) \
     ({ ARMCPU *cpu_ = (cpu); isar_feature_##name(&cpu_->isar); })
 
+void arm_cpu_features_to_dict(ARMCPU *cpu, QDict *features);
+
 #endif
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index ba6e01abd0..f8eb29efec 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -225,6 +225,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         }
     }
 
+    arm_cpu_features_to_dict(ARM_CPU(obj), qdict_out);
+
     if (!qdict_size(qdict_out)) {
         qobject_unref(qdict_out);
     } else {
-- 
2.18.4


