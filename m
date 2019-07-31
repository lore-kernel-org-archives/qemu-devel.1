Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557D3C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B12206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gofb3qoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B12206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrRU-0000dT-D7
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42439)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG8-0005zJ-G9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG6-0004AB-4I
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:24 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrG5-00048p-Rq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id h19so1641598wme.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JAsL9lKxpSV7gJFxFeCPfJnq/9l3IF3WkKcMWFNHkFQ=;
 b=Gofb3qoizzTEFOrIm6gY/3mjfRv4Me7XXMW1YJZSHIoq1utaJv189tPrtL+XPVsmTR
 XLEiDlX9ibfSFJE+ujZ0Ch3FDJqLg+2CcL714dkzfrHcBv9SiwWkb9kBvD9tNc2lT12p
 Vdf9eklBWH7NMxoYY4EqbxzwoRRmntM4X5pJE+Vye8PTzPduhdNaPgyNwuJFMhy/kR2w
 i6fa+VwJnzioj6YzGhfZ1xpEpcgwxWO6ws1Q6FbgqAhftu5DXfMJ+P8bR2K3ozDEJvD3
 3M/JcqbeHm7NYiDZw/466sh9fZT/aIKSmPgAo+IawBPynCH4iHXT5979K8bXB0XgZ1oO
 2Bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JAsL9lKxpSV7gJFxFeCPfJnq/9l3IF3WkKcMWFNHkFQ=;
 b=YWiQNGugSU2KNJapd1T3GZ48jqCYUoroUpc7j/nD//Ila+Kpa95XwR8+LZcg+jl+w1
 605+EJ1D1MQHcd2+g9kuRvEZ6HN8BNbm6n33kPIIMYfJ+7Fmk+lcPmuY48uOZ3bQBvbc
 l3kA4XtbFcqTGj1ow2aQpgXvze/0PLt1v3fWXf0CeWXxABRB+fzE2IDMgiiB3nyhxfAV
 yeW1NVFjjIaxihEnzs3Ra2lPiNuxOrklF51L/98l4u3t9mhIyogno1JYntwBR018OaKd
 2SwbMYeXJWiMBftxFrG54TCtqGCyTqrKZxfk5RRnsTH8cLWIIpihirmOA20C+10LYier
 TRdA==
X-Gm-Message-State: APjAAAWpouphnFzV3i0/tZGW4RymCPGGmQtGSdR+fR0ZPGlUXyT1BueL
 lOtKW9LcURcRYki3jP95fFoGPQ==
X-Google-Smtp-Source: APXvYqweIncqGHtkBm9WAAowNUtnX7rzJ9XJod8v0iIgCDeMguinb185qEsp46reHChWw6zAMdg8YQ==
X-Received: by 2002:a1c:a686:: with SMTP id
 p128mr50348737wme.130.1564589720435; 
 Wed, 31 Jul 2019 09:15:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p18sm68312914wrm.16.2019.07.31.09.15.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:17 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 338C11FFC9;
 Wed, 31 Jul 2019 17:07:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:16 +0100
Message-Id: <20190731160719.11396-52-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v4 51/54] tests/plugin: add hotpages plugin to
 breakdown memory access patterns
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
Cc: bobby.prani@gmail.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This plugin gives a break down of access patterns grouped into pages.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
   - tweaks for new hwaddr api
   - add sorting and pagesize selection args
---
 tests/plugin/Makefile   |   1 +
 tests/plugin/hotpages.c | 179 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+)
 create mode 100644 tests/plugin/hotpages.c

diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index 3656429d46b..75467b6db85 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -12,6 +12,7 @@ NAMES += insn
 NAMES += mem
 NAMES += hotblocks
 NAMES += howvec
+NAMES += hotpages
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
diff --git a/tests/plugin/hotpages.c b/tests/plugin/hotpages.c
new file mode 100644
index 00000000000..13ce8ffeb8b
--- /dev/null
+++ b/tests/plugin/hotpages.c
@@ -0,0 +1,179 @@
+/*
+ * Copyright (C) 2019, Alex Bennée <alex.bennee@linaro.org>
+ *
+ * Hot Pages - show which pages saw the most memory accesses.
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
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
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static uint64_t page_size = 4096;
+static uint64_t page_mask;
+static int stdout_fd;
+static int limit = 50;
+static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
+
+enum sort_type {
+    SORT_RW = 0,
+    SORT_R,
+    SORT_W
+};
+
+static int sort_by = SORT_RW;
+
+typedef struct {
+    uint64_t page_address;
+    int cpu_read;
+    int cpu_write;
+    uint64_t reads;
+    uint64_t writes;
+} PageCounters;
+
+static GMutex lock;
+static GHashTable *pages;
+
+static gint cmp_access_count(gconstpointer a, gconstpointer b)
+{
+    PageCounters *ea = (PageCounters *) a;
+    PageCounters *eb = (PageCounters *) b;
+    int r;
+    switch (sort_by) {
+    case SORT_RW:
+        r = (ea->reads + ea->writes) > (eb->reads + eb->writes) ? -1 : 1;
+        break;
+    case SORT_R:
+        r = ea->reads > eb->reads ? -1 : 1;
+        break;
+    case SORT_W:
+        r = ea->writes > eb->writes ? -1 : 1;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return r;
+}
+
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    GString *report = g_string_new("Addr, RCPUs, Reads, WCPUs, Writes\n");
+    int i;
+    GList *counts;
+
+    counts = g_hash_table_get_values(pages);
+    if (counts && g_list_next(counts)) {
+        GList *it;
+
+        it = g_list_sort(counts, cmp_access_count);
+
+        for (i = 0; i < limit && it->next; i++, it = it->next) {
+            PageCounters *rec = (PageCounters *) it->data;
+            g_string_append_printf(report,
+                                   "%#016"PRIx64", 0x%04x, %"PRId64
+                                   ", 0x%04x, %"PRId64"\n",
+                                   rec->page_address,
+                                   rec->cpu_read, rec->reads,
+                                   rec->cpu_write, rec->writes);
+        }
+        g_list_free(it);
+    }
+
+    dprintf(stdout_fd, "%s", report->str);
+    g_string_free(report, true);
+}
+
+static void plugin_init(void)
+{
+    page_mask = (page_size - 1);
+    pages = g_hash_table_new(NULL, g_direct_equal);
+}
+
+static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
+                       uint64_t vaddr, void *udata)
+{
+    struct qemu_plugin_hwaddr *hwaddr = qemu_plugin_get_hwaddr(meminfo, vaddr);
+    uint64_t page;
+    PageCounters *count;
+
+    /* We only get a hwaddr for system emulation */
+    if (hwaddr) {
+        page = (uint64_t) qemu_plugin_hwaddr_to_raddr(hwaddr);
+    } else {
+        page = vaddr;
+    }
+    page &= ~page_mask;
+
+    g_mutex_lock(&lock);
+    count = (PageCounters *) g_hash_table_lookup(pages, GUINT_TO_POINTER(page));
+
+    if (!count) {
+        count = g_new0(PageCounters, 1);
+        count->page_address = page;
+        g_hash_table_insert(pages, GUINT_TO_POINTER(page), (gpointer) count);
+    }
+    if (qemu_plugin_mem_is_store(meminfo)) {
+        count->writes++;
+        count->cpu_write |= (1 << cpu_index);
+    } else {
+        count->reads++;
+        count->cpu_read |= (1 << cpu_index);
+    }
+
+    g_mutex_unlock(&lock);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t n = qemu_plugin_tb_n_insns(tb);
+    size_t i;
+
+    for (i = 0; i < n; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_haddr,
+                                         QEMU_PLUGIN_CB_NO_REGS,
+                                         rw, NULL);
+    }
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv)
+{
+    int i;
+
+    /* to be used when in the exit hook */
+    stdout_fd = dup(STDOUT_FILENO);
+    assert(stdout_fd);
+
+    for (i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        if (g_strcmp0(opt, "reads") == 0) {
+            sort_by = SORT_R;
+        } else if (g_strcmp0(opt, "writes") == 0) {
+            sort_by = SORT_W;
+        } else if (g_str_has_prefix(opt, "pagesize=")) {
+            page_size = g_ascii_strtoull(opt + 9, NULL, 10);
+        } else {
+            dprintf(stdout_fd, "option parsing failed: %s\n", opt);
+            return -1;
+        }
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


