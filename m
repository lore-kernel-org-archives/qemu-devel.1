Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA12DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 20:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946C1206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 20:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqO09HqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946C1206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjpxp-0005bG-Pd
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 16:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjpx8-0004uU-5u
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 16:07:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38163)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjpx6-00011T-6B
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 16:07:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id e1so11148682wrt.5
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 13:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EGLD52uq6wgg6S3df+UnGSa41O+4jPyJdVKK+sE8Gas=;
 b=aqO09HqDxny+XgBeCSTGsi+OvKyoNtwYueXopI55VTvFIE08feQAryxqGoXAJ2scCu
 9hjgLtdpPhMDpgDAk233lCqnuDpzlmUmKgFAGYR2HllkBczN8nw7nQ1Ef7KK3Dolc/Cp
 ZFWoOQRf1poNNF6S5bPLJuGJeXpPge3izhDrY/Ab3lqNdojDgqtGVhFkqdddtgoCCx8e
 0fVejOEnQqQSW9GtP0sliDy6fkilS5XR7MryPeBzJrr55CZrKNIozIMe5xvClnzW4eYB
 mhd5r5xHK/Rx0B1k/G/ED+y4rrT9BPT4n4IiiFW3IKMIhsHqSwOYkqg8epRW/Zr1F+bv
 +M6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=EGLD52uq6wgg6S3df+UnGSa41O+4jPyJdVKK+sE8Gas=;
 b=OCAXPPFjNlQpNSBKmmEG/h4BXAlZBZW9vhLf4W1iJbgLSwPeDt1mz/ixMFRWttooMU
 KcgrUaxkQ+6ZOgNnxyzL3wQCq6T0pOS8F/xxkmbe82fcUOmwudn/Ya5oMgZ7W6Hi8nUC
 xkwenopMcamCosnU7QczgBOtfreu8f//hmizL6OZ7tpYYMxXpRe4NIsCp969MT2i9+5d
 2g8rhDN+vffdx6D9sEJNCWPGIhoGgWlagtXEniC3i409go9j9BNnVMTKH3ckKaSf2mOd
 sFFnt/BrzblmWtUuxqPUmm+W4Qsdydx4gzkZHIyDDu3nmHvmvnDY5PWX7otqyTqEXtmQ
 7PJQ==
X-Gm-Message-State: AOAM532ZlMGPwyY6Xy9gNBta6d0jBxXPnMzmqt28IbOQQCbJpbGQ3uJt
 v9sEvEXSuy+6weGkUCe0NYXoFg==
X-Google-Smtp-Source: ABdhPJzBOQS8iWejORXOYHuSblQ4xA5tps58tg5djXPuvHyfAoWYHfmxJOrREzkJI0qvrnTbkV/HBw==
X-Received: by 2002:adf:f6ce:: with SMTP id y14mr17242072wrp.90.1591992410387; 
 Fri, 12 Jun 2020 13:06:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 50sm12324578wra.1.2020.06.12.13.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 13:06:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 860E01FF7E;
 Fri, 12 Jun 2020 21:06:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] plugins: expand the bb plugin to be thread safe and track
 per-cpu
Date: Fri, 12 Jun 2020 21:06:42 +0100
Message-Id: <20200612200642.9714-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dave Bort <dbort@dbort.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While there isn't any easy way to make the inline counts thread safe
we can ensure the callback based ones are. While we are at it we can
reduce introduce a new option ("idle") to dump a report of the current
bb and insn count each time a vCPU enters the idle state.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Dave Bort <dbort@dbort.com>
---
 tests/plugin/bb.c | 85 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 8 deletions(-)

diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index df19fd359df..5c08367d3d7 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -16,24 +16,68 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
+/* Used by the inline counts */
 static uint64_t bb_count;
 static uint64_t insn_count;
 static bool do_inline;
 
+/* Dump running CPU total on idle? */
+static bool idle_report;
+
+typedef struct {
+    GMutex lock;
+    int index;
+    uint64_t bb_count;
+    uint64_t insn_count;
+} CPUCount;
+
+static GPtrArray *counts;
+static int max_cpus;
+
+static void gen_one_cpu_report(CPUCount *count, GString *report)
+{
+    if (count->bb_count) {
+        g_string_append_printf(report, "CPU%d: "
+                               "bb's: %" PRIu64", insns: %" PRIu64 "\n",
+                               count->index,
+                               count->bb_count, count->insn_count);
+    }
+}
+
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
-    g_autofree gchar *out = g_strdup_printf(
-        "bb's: %" PRIu64", insns: %" PRIu64 "\n",
-        bb_count, insn_count);
-    qemu_plugin_outs(out);
+    g_autoptr(GString) report = g_string_new("");
+
+    if (do_inline) {
+        g_string_printf(report, "bb's: %" PRIu64", insns: %" PRIu64 "\n",
+                        bb_count, insn_count);
+    } else {
+        g_ptr_array_foreach(counts, (GFunc) gen_one_cpu_report, report);
+    }
+    qemu_plugin_outs(report->str);
+}
+
+static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
+{
+    CPUCount *count = g_ptr_array_index(counts, cpu_index);
+    g_autoptr(GString) report = g_string_new("");
+    gen_one_cpu_report(count, report);
+
+    if (report->len > 0) {
+        g_string_prepend(report, "Idling ");
+        qemu_plugin_outs(report->str);
+    }
 }
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 {
+    CPUCount *count = g_ptr_array_index(counts, cpu_index);
     unsigned long n_insns = (unsigned long)udata;
 
-    insn_count += n_insns;
-    bb_count++;
+    g_mutex_lock(&count->lock);
+    count->insn_count += n_insns;
+    count->bb_count++;
+    g_mutex_unlock(&count->lock);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -56,8 +100,33 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
-    if (argc && strcmp(argv[0], "inline") == 0) {
-        do_inline = true;
+    int i;
+
+    for (i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        if (g_strcmp0(opt, "inline") == 0) {
+            do_inline = true;
+        } else if (g_strcmp0(opt, "idle") == 0) {
+            idle_report = true;
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    if (!do_inline) {
+        max_cpus = info->system.max_vcpus;
+        counts = g_ptr_array_new();
+        for (i = 0; i < max_cpus; i++) {
+            CPUCount *count = g_new0(CPUCount, 1);
+            g_mutex_init(&count->lock);
+            count->index = i;
+            g_ptr_array_add(counts, count);
+        }
+    }
+
+    if (idle_report) {
+        qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
     }
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
-- 
2.20.1


