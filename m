Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D653EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971702067B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="boJLOshU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971702067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9Ff-0006qD-T3
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97h-0003p9-Qa
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:54511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jg97g-0007dx-DQ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:46:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id g10so3402146wmh.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TTAp5rDD3D05lpMYKygwT+EZBLy9H09vRzxjadlC3og=;
 b=boJLOshUdKXGZfw665tFYM4A4pCjHkOuSLRwmpolEJ1R0ind9XcaALkQ4LcriVcjj4
 I1Q1cs5XA0/7S+2W9lYhrEQnTXzY6Gs8Dba9RgIkd2OVpvHebJG0pizNUVkf72fXl6bB
 POYPkewda46q8tBX5ZYhluUdIGsqcJe4TEkDo1fx5lOB3DDUnq+UIbZ/iMHdhlSe2IPt
 z/W4ZpeAYAE6xd8RwcfSEZAuQUEJZ/ocnY2ZKNqAK0Qde48+9VHckBM46Q0MwDSTC0SV
 0ubnhpToIFoI0xshuKpnHJJUpqrlQgJNuc00fQTUzkCLZ9kQCYI5PxZ2Nwg7oDDeyXo4
 ke0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TTAp5rDD3D05lpMYKygwT+EZBLy9H09vRzxjadlC3og=;
 b=C/5UCFOLEQNt3DRA2l3zHYuvlHRMWNXrbCYkKIDdEQ9+8qpTiKxAQbZwyOA/vdAYfU
 3gbTuDjJJ2y7IihQQfwxdTd70RrjX9m4p4k+SrPkST42W5Nwpq+GClDB6vKMz20T2tkk
 K9vXsc09Uk1CnMjWCYw00tAB9dNTJpok4Xn/lr+GSjB5R0tW/tJgdKsKC5QThQ7mDVF4
 uD+FvpwMaCFN2OQeb/4ubYxaX3SeqAjl3GITV6pI31MJ7BnfBXUGnbM8pSuTZNpriLRd
 nHfOMIij8SKxOZaf8b+ku3og4bvycJ9is3XQTBgQbsg8d6UgKuBRKeglKtSiMe/JIE21
 Lrlg==
X-Gm-Message-State: AOAM533yCZoXkhKrP2eYe+u8g7/DdH6BjxIw3ydNYX5wxngQZ9HPtHlM
 rpcwQHDaTpEi8J8QGoxqxX/j4Q==
X-Google-Smtp-Source: ABdhPJwdPDGoSWra5z8RM/5Zyyfwctln64NN1VHieXtwCE2X/+RQPsjFlUGgT9kd98a3DlZu/QTHWA==
X-Received: by 2002:a1c:bc84:: with SMTP id m126mr5004966wmf.159.1591112798854; 
 Tue, 02 Jun 2020 08:46:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b136sm283700wme.1.2020.06.02.08.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 08:46:32 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F09D61FF96;
 Tue,  2 Jun 2020 16:46:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 8/9] plugins: new hwprofile plugin
Date: Tue,  2 Jun 2020 16:46:23 +0100
Message-Id: <20200602154624.4460-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200602154624.4460-1-alex.bennee@linaro.org>
References: <20200602154624.4460-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a plugin intended to help with profiling access to various
bits of system hardware. It only really makes sense for system
emulation.

It takes advantage of the recently exposed helper API that allows us
to see the device name (memory region name) associated with a device.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/hwprofile.c | 248 +++++++++++++++++++++++++++++++++++++++
 tests/plugin/Makefile    |   1 +
 2 files changed, 249 insertions(+)
 create mode 100644 tests/plugin/hwprofile.c

diff --git a/tests/plugin/hwprofile.c b/tests/plugin/hwprofile.c
new file mode 100644
index 00000000000..f5e0639e762
--- /dev/null
+++ b/tests/plugin/hwprofile.c
@@ -0,0 +1,248 @@
+/*
+ * Copyright (C) 2020, Alex Bennée <alex.bennee@linaro.org>
+ *
+ * HW Profile - breakdown access patterns for IO to devices
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
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+typedef struct {
+    uint64_t offset;
+    int size;
+    int cpu_read;
+    int cpu_write;
+    uint64_t reads;
+    uint64_t writes;
+} IOLocationCounts;
+
+typedef struct {
+    const char *name;
+    uint64_t base;
+    int cpu_read;
+    int cpu_write;
+    uint64_t total_writes;
+    uint64_t total_reads;
+    GHashTable *access_pattern;
+} DeviceCounts;
+
+static GMutex lock;
+static GHashTable *devices;
+static bool detail;
+
+static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
+
+static inline bool track_reads(void)
+{
+    return rw == QEMU_PLUGIN_MEM_RW || rw == QEMU_PLUGIN_MEM_R;
+}
+
+static inline bool track_writes(void)
+{
+    return rw == QEMU_PLUGIN_MEM_RW || rw == QEMU_PLUGIN_MEM_W;
+}
+
+static void plugin_init(void)
+{
+    devices = g_hash_table_new(g_str_hash, g_str_equal);
+}
+
+static gint sort_cmp(gconstpointer a, gconstpointer b)
+{
+    DeviceCounts *ea = (DeviceCounts *) a;
+    DeviceCounts *eb = (DeviceCounts *) b;
+    return ea->total_reads + ea->total_writes >
+        eb->total_reads + eb->total_writes ? -1 : 1;
+}
+
+static gint sort_off(gconstpointer a, gconstpointer b)
+{
+    IOLocationCounts *ea = (IOLocationCounts *) a;
+    IOLocationCounts *eb = (IOLocationCounts *) b;
+    return ea->offset > eb->offset;
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autoptr(GString) report = g_string_new("");
+    GList *counts;
+
+    if (!detail) {
+        g_string_printf(report, "Device, Address");
+        if (track_reads()) {
+            g_string_append_printf(report, ", RCPUs, Reads");
+        }
+        if (track_writes()) {
+            g_string_append_printf(report, ",  WCPUs, Writes");
+        }
+        g_string_append_c(report, '\n');
+    }
+
+    counts = g_hash_table_get_values(devices);
+    if (counts && g_list_next(counts)) {
+        GList *it;
+
+        it = g_list_sort(counts, sort_cmp);
+
+        while (it) {
+            DeviceCounts *rec = (DeviceCounts *) it->data;
+            if (detail) {
+                GList *accesses = g_hash_table_get_values(rec->access_pattern);
+                GList *io_it = g_list_sort(accesses, sort_off);
+                g_string_append_printf(report, "%s @ 0x%"PRIx64"\n", rec->name, rec->base);
+                while (io_it) {
+                    IOLocationCounts *loc = (IOLocationCounts *) io_it->data;
+                    g_string_append_printf(report, "  off:%08"PRIx64, loc->offset);
+                    if (track_reads()) {
+                        g_string_append_printf(report, ", 0x%04x, %"PRId64,
+                                               loc->cpu_read, loc->reads);
+                    }
+                    if (track_writes()) {
+                       g_string_append_printf(report, ", 0x%04x, %"PRId64,
+                                               loc->cpu_write, loc->writes);
+                    }
+                    g_string_append_c(report,'\n');
+                    io_it = io_it->next;
+                }
+            } else {
+                g_string_append_printf(report, "%s, 0x%"PRIx64,
+                                       rec->name, rec->base);
+                if (track_reads()) {
+                    g_string_append_printf(report, ", 0x%04x, %"PRId64,
+                                           rec->cpu_read, rec->total_reads);
+                }
+                if (track_writes()) {
+                    g_string_append_printf(report, ", 0x%04x, %"PRId64,
+                                           rec->cpu_write, rec->total_writes);
+                }
+                g_string_append_c(report, '\n');
+            }
+            it = it->next;
+        };
+        g_list_free(it);
+    }
+
+    qemu_plugin_outs(report->str);
+}
+
+static DeviceCounts * new_count(char *name, uint64_t base)
+{
+    DeviceCounts *count = g_new0(DeviceCounts, 1);
+    count->name = name;
+    count->base = base;
+    if (detail) {
+        count->access_pattern = g_hash_table_new(g_int64_hash, g_int64_equal);
+    }
+    g_hash_table_insert(devices, name, count);
+    return count;
+}
+
+static IOLocationCounts * new_location(uint64_t offset)
+{
+    IOLocationCounts *loc = g_new0(IOLocationCounts, 1);
+    loc->offset = offset;
+    return loc;
+}
+
+static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
+                       uint64_t vaddr, void *udata)
+{
+    struct qemu_plugin_hwaddr *hwaddr = qemu_plugin_get_hwaddr(meminfo, vaddr);
+
+    if (!hwaddr || !qemu_plugin_hwaddr_is_io(hwaddr)) {
+        return;
+    } else {
+        char *name = qemu_plugin_hwaddr_device_name(hwaddr);
+        DeviceCounts *counts;
+
+        g_mutex_lock(&lock);
+        counts = (DeviceCounts *) g_hash_table_lookup(devices, name);
+        if (!counts) {
+            uint64_t off = qemu_plugin_hwaddr_device_offset(hwaddr);
+            uint64_t base = vaddr - off;
+            counts = new_count(name, base);
+        } else {
+            g_free(name);
+        }
+
+        if (detail) {
+            uint64_t off = qemu_plugin_hwaddr_device_offset(hwaddr);
+            IOLocationCounts *io_count = g_hash_table_lookup(counts->access_pattern, &off);
+            if (!io_count) {
+                io_count = new_location(off);
+                g_hash_table_insert(counts->access_pattern, &off, io_count);
+            }
+            if (qemu_plugin_mem_is_store(meminfo)) {
+                io_count->writes++;
+                io_count->cpu_write |= (1 << cpu_index);
+            } else {
+                io_count->reads++;
+                io_count->cpu_read |= (1 << cpu_index);
+            }
+        } else {
+            if (qemu_plugin_mem_is_store(meminfo)) {
+                counts->total_writes++;
+                counts->cpu_write |= (1 << cpu_index);
+            } else {
+                counts->total_reads++;
+                counts->cpu_read |= (1 << cpu_index);
+            }
+        }
+        g_mutex_unlock(&lock);
+    }
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
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    int i;
+
+    for (i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        if (g_strcmp0(opt, "read") == 0) {
+            rw = QEMU_PLUGIN_MEM_R;
+        } else if (g_strcmp0(opt, "write") == 0) {
+            rw = QEMU_PLUGIN_MEM_W;
+        } else if (g_strcmp0(opt, "detail") == 0) {
+            detail = true;
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
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
diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index b3250e2504c..d87b8d40699 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -14,6 +14,7 @@ NAMES += hotblocks
 NAMES += howvec
 NAMES += hotpages
 NAMES += lockstep
+NAMES += hwprofile
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
-- 
2.20.1


