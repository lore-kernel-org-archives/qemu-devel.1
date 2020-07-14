Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5270FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2084C221F7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lx3Smhaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2084C221F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHi6-0005iC-ED
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcW-0003fr-8V
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:53:04 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:43052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcU-0003zh-ET
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:53:03 -0400
Received: by mail-wr1-x42c.google.com with SMTP id j4so20514258wrp.10
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qk3ABZq413c4i38F0xqHIViOGrZppkOMvKepCv8uPHk=;
 b=Lx3SmhaaqaTP2jWtLNDyloCEHO8D54gCtmrdZYTtd/Avt7x5mvkpFksjqy6Hx2oXHa
 RfE/O12//wuzgMRQmaVHnQRCURbHRApcWjb0uEz/VjGszCnre2unhWFVnzYLUoLwtdmg
 9axHL0oTAIdTRuw/Lhi/cX+x5O6Kp/0z4v3U9b//24CVZhYFDE6+jTRWdFhBgSZbhwpk
 zvAzoqWxWSYBP1BojvT80KoxUQ5XaBWrjzDY9hLxOEfKb5QF4hQw+WDRI3758f4JyyAt
 esllrcVKxTziAye5aVVI7cwMu8jMphMZCxs0vUK9Pc0HRwlY/Bne4CLPM0nl9RFycXb4
 owcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qk3ABZq413c4i38F0xqHIViOGrZppkOMvKepCv8uPHk=;
 b=kZs++6Ld8OhMtoE36lqoFQ0/nzxzqtEWah1JEDKlZNfXLd4VKD2xh5dDBQ1qiFNW4T
 xKqBxm2skPaXm6xnhyj5JVU++w2V53iFEcCMambpcvmYctubPbiKHGVlY2cv8Lbt3A3W
 gv3BdlpEi3nqDANIwQGpadul6drOn6SaWam9Cx0Qary2xSkChvoFqiogL/MucDcF/T60
 nBZxxaCM1ctxuaj07QSoCuDeZ/6O8ARvMD1KXeZF7/BUl6jdIi9AmG8ldlAwcLhzwy5N
 1/rHf2V8fi32oVf6s54vzmUx4HPqdWXHe97vdV+Hk+UHm8iHmNEvh3U5gKMmDaxGRpRE
 ejAQ==
X-Gm-Message-State: AOAM532CDxg86ReKKtTac1UQ/cBi63LtHlb9jdZc/MOYj/lVUCPoCCsf
 RZk3zRRJU2+2fmiCXHDqzQDEsQ==
X-Google-Smtp-Source: ABdhPJwSpTIlynN4SIs7kUE0jjohYof84f5Vd0am6OaJu1uyMkqrb8QSbSbEs486ibXF6eH5UsOt3w==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr4097874wrr.259.1594720381061; 
 Tue, 14 Jul 2020 02:53:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p14sm30359670wrj.14.2020.07.14.02.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 02:52:55 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 22A311FF98;
 Tue, 14 Jul 2020 10:52:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 9/9] plugins: expand the bb plugin to be thread safe and track
 per-cpu
Date: Tue, 14 Jul 2020 10:52:47 +0100
Message-Id: <20200714095247.19573-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200714095247.19573-1-alex.bennee@linaro.org>
References: <20200714095247.19573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Dave Bort <dbort@dbort.com>,
 Robert Foley <robert.foley@linaro.org>
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

Message-Id: <20200713200415.26214-8-alex.bennee@linaro.org>

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


