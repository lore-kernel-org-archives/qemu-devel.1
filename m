Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE954CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF4E20867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEchem4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF4E20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtVu-00083L-As
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE5-0003Od-CW
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE2-0008Ru-2k
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtE1-0008RB-SD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id r1so901940wrs.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yAGQHjJX6sN9vqBD9CUSIS92quPpG3GGj8bU/lL0Ji4=;
 b=nEchem4M3/M08Rd9orRMB8+/QD76x8Yhe9aigLpWlxq0bbIj3FYlSHgEFq9fL9MRIJ
 ZlfwjGZHFl6Vi8nsIqxaDTS/A1M8AitUzMmFgjNCHqEAG8tUayB1I3EyQEsH8OiSZbcY
 1pcCuv0CkYcX7b9d3wgrhsTs1PGFeRhslLurY3mAPhFXeKnN4CbKqQtEgS39j5vHhE65
 oVLZ29DQrgD6oLPbFXVsvBGu0dVLtDIt0RRKkhezRIfyncF9pZFN2unv+zPriSnn3tK8
 FFRUea9mGz1KCfXFxjMLa2r/HDDwBrisHWuJOU6mVWoOYbTj2/dSYr6hYfxEQBnKoilV
 L9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yAGQHjJX6sN9vqBD9CUSIS92quPpG3GGj8bU/lL0Ji4=;
 b=BsYOyeiEQxwPmyEyW2l4cpucaW+NoxYyGjvAI08G+tQj3CJJVrSL6nJGeYvpFcnkOS
 WAw9CVxPVzG8qfHIGS62xLmRAB4nnYnrIR0mBAd0Xuiet2nuMcycJaiG9ffpkkHYE28U
 OEYkUwPJBmakQ5yy20bxx9gRPdiEuOowUOSDiNuPDf0Ml7pocJRyOmVC0ZHAPOGD1FVb
 n7S7jio0FVVjS4iAQ9u6Ds4xUcR4aRT5weNVeAOoL7xSNPyLbSpFQ1dN1zYiG1+BtJaw
 U6+QgnCIuLotci/m1nbrN6ZDUIuFyV6yqnFHlKXVMVR00YAg7dmra7ci8quUGRTk+Ht9
 KYYw==
X-Gm-Message-State: APjAAAWhnY1z8dW4fAyTOh8/B06zMEbPiwey42UUl+7f3Sp2l/iF1DQw
 8mzYUm1vHrft3wlmi7w8jflViw==
X-Google-Smtp-Source: APXvYqy+b7ipQyH12IlBv6SMk8CmUoXXnVOW6pLO8IIkMPUuvMM3AamshUSqJsqxwNvY3HgxJimGjA==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr1189002wru.87.1571985448546; 
 Thu, 24 Oct 2019 23:37:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g10sm1189335wrr.28.2019.10.24.23.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D6BB71FFD7;
 Fri, 25 Oct 2019 07:37:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 65/73] tests/plugin: add a hotblocks plugin
Date: Fri, 25 Oct 2019 07:37:05 +0100
Message-Id: <20191025063713.23374-66-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a simple plugin to track which translation blocks are call
most often. As we don't have a view of the internals of TCG we can
only work by the address of the start of the block so we also need to
tracks how often the address is translated.

As there will be multiple blocks starting at the same address. We can
try and work around this by futzing the value to feed to the hash with
the insn count.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index f9a3546ea32..e74940eaac5 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -10,6 +10,7 @@ NAMES += bb
 NAMES += empty
 NAMES += insn
 NAMES += mem
+NAMES += hotblocks
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
diff --git a/tests/plugin/hotblocks.c b/tests/plugin/hotblocks.c
new file mode 100644
index 00000000000..1bd183849a1
--- /dev/null
+++ b/tests/plugin/hotblocks.c
@@ -0,0 +1,143 @@
+/*
+ * Copyright (C) 2019, Alex Bennée <alex.bennee@linaro.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <inttypes.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <glib.h>
+
+#include <qemu-plugin.h>
+
+static bool do_inline;
+
+/* Plugins need to take care of their own locking */
+static GMutex lock;
+static GHashTable *hotblocks;
+static guint64 limit = 20;
+
+/*
+ * Counting Structure
+ *
+ * The internals of the TCG are not exposed to plugins so we can only
+ * get the starting PC for each block. We cheat this slightly by
+ * xor'ing the number of instructions to the hash to help
+ * differentiate.
+ */
+typedef struct {
+    uint64_t start_addr;
+    uint64_t exec_count;
+    int      trans_count;
+    unsigned long insns;
+} ExecCount;
+
+static gint cmp_exec_count(gconstpointer a, gconstpointer b)
+{
+    ExecCount *ea = (ExecCount *) a;
+    ExecCount *eb = (ExecCount *) b;
+    return ea->exec_count > eb->exec_count ? -1 : 1;
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autoptr(GString) report = g_string_new("collected ");
+    GList *counts, *it;
+    int i;
+
+    g_mutex_lock(&lock);
+    g_string_append_printf(report, "%d entries in the hash table\n",
+                           g_hash_table_size(hotblocks));
+    counts = g_hash_table_get_values(hotblocks);
+    it = g_list_sort(counts, cmp_exec_count);
+
+    if (it) {
+        g_string_append_printf(report, "pc, tcount, icount, ecount\n");
+
+        for (i = 0; i < limit && it->next; i++, it = it->next) {
+            ExecCount *rec = (ExecCount *) it->data;
+            g_string_append_printf(report, "%#016"PRIx64", %d, %ld, %"PRId64"\n",
+                                   rec->start_addr, rec->trans_count,
+                                   rec->insns, rec->exec_count);
+        }
+
+        g_list_free(it);
+        g_mutex_unlock(&lock);
+    }
+
+    qemu_plugin_outs(report->str);
+}
+
+static void plugin_init(void)
+{
+    hotblocks = g_hash_table_new(NULL, g_direct_equal);
+}
+
+static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
+{
+    ExecCount *cnt;
+    uint64_t hash = (uint64_t) udata;
+
+    g_mutex_lock(&lock);
+    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
+    /* should always succeed */
+    g_assert(cnt);
+    cnt->exec_count++;
+    g_mutex_unlock(&lock);
+}
+
+/*
+ * When do_inline we ask the plugin to increment the counter for us.
+ * Otherwise a helper is inserted which calls the vcpu_tb_exec
+ * callback.
+ */
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    ExecCount *cnt;
+    uint64_t pc = qemu_plugin_tb_vaddr(tb);
+    unsigned long insns = qemu_plugin_tb_n_insns(tb);
+    uint64_t hash = pc ^ insns;
+
+    g_mutex_lock(&lock);
+    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
+    if (cnt) {
+        cnt->trans_count++;
+    } else {
+        cnt = g_new0(ExecCount, 1);
+        cnt->start_addr = pc;
+        cnt->trans_count = 1;
+        cnt->insns = insns;
+        g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
+    }
+
+    g_mutex_unlock(&lock);
+
+    if (do_inline) {
+        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
+                                                 &cnt->exec_count, 1);
+    } else {
+        qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
+                                             QEMU_PLUGIN_CB_NO_REGS,
+                                             (void *)hash);
+    }
+}
+
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    if (argc && strcmp(argv[0], "inline") == 0) {
+        do_inline = true;
+    }
+
+    plugin_init();
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
-- 
2.20.1


