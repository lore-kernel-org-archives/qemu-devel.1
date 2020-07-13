Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236E6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B6920674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOKKinMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B6920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4lZ-0000mA-87
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gj-0008Gz-De
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gh-0006JN-GR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id b6so18142756wrs.11
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 13:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RFloOI9RdqsuY1jzWY/LdnGW0qTS1vaDIDIUNvMdMkw=;
 b=zOKKinMl8Lc4tl+khcrq25otS5ClYMFza+X8Eb8n8PJ7hQDMp7qLKWT7XBzuLwUnTi
 VjmNAJQVQ8lV8KViFJt6Ozwz01fq/4O5j/ugnJOlgWRuWS2rLAvFgb/A1HQBF55RbRcZ
 GQvBF03MeCYdYuHLlSkW1GWLRGzaW/2xHlEzOxRnbI10ygzyNKxJW+TeXWZ60yztPJnx
 PwSYc/3A956kxyXldFVqJWJqmrfib28ef2fVWm+uiDaIOkbqTL/AdGRXizdlqrJpddv4
 8IBew9zVF+kF5eibGXk6wzK6t67zqOdaQAphN8pyy3GT1vKQ8SeZRAq3HKPkeAvi7x7Q
 3fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RFloOI9RdqsuY1jzWY/LdnGW0qTS1vaDIDIUNvMdMkw=;
 b=HG6Ikq8ZHO+Vs/UYJ+j5HrrgIrKtr5bcVaHYHL5opYNB0HC+Vl3/y687JOH4QL8qlJ
 aV8kCd713EdH8aey2O1ugM5ZUZcBXiGkTwdZEP+tL6fcpT5+ZRg1FBkmbrujJ0p9Gv2c
 ay/dgyfdFldNDke89p23gXvB5Q+bbOGPSRqHy8ChzMiUuEg3y2LGSpTNYyxAd61ilBL9
 ji/X7rTz4W2m8QeviiRJDr7zx5czlIS4tPnmrH1FWgRLSaZduxcx0i5IvVIE0qbsXLyn
 S4IICrwi/W/uPCDnFYr2lvEbkLOIMIKUtznB1LRrCh9kHpnQc/7xLOCCLBSDElPFNsdx
 e0pg==
X-Gm-Message-State: AOAM530B8xazTi8iIvKMPlNruyh3RmR5jbCY1gx3KpP794VWJj5b3gOc
 SR4wTHNED6L0wMV77Rkm+CAuwg==
X-Google-Smtp-Source: ABdhPJz0U1RwaSiDkrjwHwQDpu95CLWAZdSD8f+3Y7G8PVkw0FQyxceowkoWTeeyIBCnsVHLzEK73A==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr1188315wrt.174.1594670670106; 
 Mon, 13 Jul 2020 13:04:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 190sm939618wmb.15.2020.07.13.13.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 13:04:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 43CCF1FF93;
 Mon, 13 Jul 2020 21:04:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/11] plugins: expand the bb plugin to be thread safe and
 track per-cpu
Date: Mon, 13 Jul 2020 21:04:11 +0100
Message-Id: <20200713200415.26214-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713200415.26214-1-alex.bennee@linaro.org>
References: <20200713200415.26214-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, Dave Bort <dbort@dbort.com>,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While there isn't any easy way to make the inline counts thread safe
we can ensure the callback based ones are. While we are at it we can
reduce introduce a new option ("idle") to dump a report of the current
bb and insn count each time a vCPU enters the idle state.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Cc: Dave Bort <dbort@dbort.com>

---
v2
  - fixup for non-inline linux-user case
  - minor cleanup and re-factor
v3
  - checkpatch
---
 tests/plugin/bb.c | 97 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 84 insertions(+), 13 deletions(-)

diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index df19fd359d..e4cc7fdd6e 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -16,24 +16,67 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-static uint64_t bb_count;
-static uint64_t insn_count;
+typedef struct {
+    GMutex lock;
+    int index;
+    uint64_t bb_count;
+    uint64_t insn_count;
+} CPUCount;
+
+/* Used by the inline & linux-user counts */
 static bool do_inline;
+static CPUCount inline_count;
+
+/* Dump running CPU total on idle? */
+static bool idle_report;
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
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
-    g_autofree gchar *out = g_strdup_printf(
-        "bb's: %" PRIu64", insns: %" PRIu64 "\n",
-        bb_count, insn_count);
-    qemu_plugin_outs(out);
+    g_autoptr(GString) report = g_string_new("");
+
+    if (do_inline || !max_cpus) {
+        g_string_printf(report, "bb's: %" PRIu64", insns: %" PRIu64 "\n",
+                        inline_count.bb_count, inline_count.insn_count);
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
-    unsigned long n_insns = (unsigned long)udata;
+    CPUCount *count = max_cpus ?
+        g_ptr_array_index(counts, cpu_index) : &inline_count;
 
-    insn_count += n_insns;
-    bb_count++;
+    unsigned long n_insns = (unsigned long)udata;
+    g_mutex_lock(&count->lock);
+    count->insn_count += n_insns;
+    count->bb_count++;
+    g_mutex_unlock(&count->lock);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -42,9 +85,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 
     if (do_inline) {
         qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &bb_count, 1);
+                                                 &inline_count.bb_count, 1);
         qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &insn_count, n_insns);
+                                                 &inline_count.insn_count,
+                                                 n_insns);
     } else {
         qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
                                              QEMU_PLUGIN_CB_NO_REGS,
@@ -56,8 +100,35 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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
+    if (info->system_emulation && !do_inline) {
+        max_cpus = info->system.max_vcpus;
+        counts = g_ptr_array_new();
+        for (i = 0; i < max_cpus; i++) {
+            CPUCount *count = g_new0(CPUCount, 1);
+            g_mutex_init(&count->lock);
+            count->index = i;
+            g_ptr_array_add(counts, count);
+        }
+    } else if (!do_inline) {
+        g_mutex_init(&inline_count.lock);
+    }
+
+    if (idle_report) {
+        qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
     }
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
-- 
2.20.1


