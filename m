Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A4AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3383206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3383206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Aaq-00066P-5o
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k6AXC-00004y-KZ; Thu, 13 Aug 2020 06:32:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4182 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k6AX8-0006p1-PZ; Thu, 13 Aug 2020 06:32:34 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 1F1F7F1691C568442C8D;
 Thu, 13 Aug 2020 18:32:27 +0800 (CST)
Received: from localhost.localdomain (10.175.104.175) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 13 Aug 2020 18:32:16 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC 2/9] target/arm: parse cpu feature related options
Date: Thu, 13 Aug 2020 18:26:50 +0800
Message-ID: <20200813102657.2588720-3-liangpeng10@huawei.com>
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

The implementation of CPUClass::parse_features only supports CPU
features in "feature=value" format.  However, libvirt maybe send us a
CPU feature string in "+feature/-feature" format.  Hence, we need to
override CPUClass::parse_features to support CPU feature string in both
"feature=value" and "+feature/-feature" format.

The logic of AArch64CPUClass::parse_features is similar to that of
X86CPUClass::parse_features.  The diference is that feature name is
transformed to upper before it's added as a property because the name
of CPU features is upper for convenience.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 target/arm/cpu64.c | 101 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4b52505b6e..981011b3da 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -28,6 +28,7 @@
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
 #include "qapi/visitor.h"
+#include "hw/qdev-properties.h"
 
 #ifndef CONFIG_USER_ONLY
 static uint64_t a57_a53_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -778,6 +779,105 @@ static gchar *aarch64_gdb_arch_name(CPUState *cs)
     return g_strdup("aarch64");
 }
 
+static void
+cpu_add_feat_as_prop(const char *typename, const char *name, const char *val)
+{
+    GlobalProperty *prop = g_new0(typeof(*prop), 1);
+    prop->driver = typename;
+    prop->property = g_strdup(name);
+    prop->value = g_strdup(val);
+    qdev_prop_register_global(prop);
+}
+
+static gint compare_string(gconstpointer a, gconstpointer b)
+{
+    return g_strcmp0(a, b);
+}
+
+static GList *plus_features, *minus_features;
+
+static char *strtoupr(char *str)
+{
+    char *orign = str;
+
+    for (; *str != '\0'; str++) {
+        *str = toupper(*str);
+    }
+
+    return orign;
+}
+
+static void aarch64_cpu_parse_features(const char *typename, char *features,
+                                     Error **errp)
+{
+    GList *l;
+    char *featurestr; /* Single 'key=value" string being parsed */
+    static bool cpu_globals_initialized;
+
+    if (cpu_globals_initialized) {
+        return;
+    }
+    cpu_globals_initialized = true;
+
+    if (!features) {
+        return;
+    }
+    for (featurestr = strtok(features, ",");
+        featurestr;
+        featurestr = strtok(NULL, ",")) {
+        const char *name;
+        char *tmp;
+        const char *val = NULL;
+        char *eq = NULL;
+
+        /* Compatibility syntax: */
+        if (featurestr[0] == '+') {
+            plus_features = g_list_append(plus_features,
+                                          g_strdup(featurestr + 1));
+            continue;
+        } else if (featurestr[0] == '-') {
+            minus_features = g_list_append(minus_features,
+                                           g_strdup(featurestr + 1));
+            continue;
+        }
+
+        eq = strchr(featurestr, '=');
+        name = featurestr;
+        if (eq) {
+            *eq++ = 0;
+            val = eq;
+        } else {
+            error_setg(errp, "Unsupported property format: %s", name);
+            return;
+        }
+
+        if (g_list_find_custom(plus_features, name, compare_string)) {
+            warn_report("Ambiguous CPU model string. "
+                        "Don't mix both \"+%s\" and \"%s=%s\"",
+                        name, name, val);
+        }
+        if (g_list_find_custom(minus_features, name, compare_string)) {
+            warn_report("Ambiguous CPU model string. "
+                        "Don't mix both \"-%s\" and \"%s=%s\"",
+                        name, name, val);
+        }
+        tmp = g_strdup(name);
+        tmp = strtoupr(tmp);
+        cpu_add_feat_as_prop(typename, tmp, val);
+        g_free(tmp);
+    }
+
+    for (l = plus_features; l; l = l->next) {
+        const char *name = strtoupr(l->data); /* convert to upper string */
+        cpu_add_feat_as_prop(typename, name, "on");
+    }
+
+    for (l = minus_features; l; l = l->next) {
+        const char *name = strtoupr(l->data);
+        cpu_add_feat_as_prop(typename, name, "off");
+    }
+}
+
 static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
 {
     CPUClass *cc = CPU_CLASS(oc);
@@ -788,6 +888,7 @@ static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_num_core_regs = 34;
     cc->gdb_core_xml_file = "aarch64-core.xml";
     cc->gdb_arch_name = aarch64_gdb_arch_name;
+    cc->parse_features = aarch64_cpu_parse_features;
 }
 
 static void aarch64_cpu_instance_init(Object *obj)
-- 
2.18.4


