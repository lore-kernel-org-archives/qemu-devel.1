Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A124DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA592075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qMuu8NUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA592075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4lX-0000ir-Lq
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gl-0008Lf-Gq
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:36918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gj-0006Ji-3P
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id a6so18135546wrm.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pdf6aU3FyC9r3Nn2r3fEZmyoTvKCMt4IaqLuhhG9jq4=;
 b=qMuu8NUF/b5XQzGj6rgCcShJ7YZW8kcH5Cws6JU6MI7d+6hvHv2O8wUnQxD18xN6Ib
 /GUBwiTEa4mi60XToVO4xC4Vv528IZZWbNckDvFA+EAeTtPf8lNWOU18vdJ9uR2ddDer
 9MtAnIARhKWhMJSXUSOlWGNCfqok2+OPyzZ0xwUH0d3l6mjambBEH34WyN/HOBZxjtCS
 TBY8Vk9tCA3A0DsJ5p3hsMOYAdA3zhejqb+xWlM1Kz5nr/yaFyAJndYCrov4ZNZL84b3
 4WVfMvz8Qbw9uBgPv08fMSe2/8/ZjihGHZJaVVw++tRYhUx5PKEzlAeWu4Z1535PuLXO
 zRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pdf6aU3FyC9r3Nn2r3fEZmyoTvKCMt4IaqLuhhG9jq4=;
 b=MbVnJqJd6DP0ycZbtdSEiarivYN+Zfu6flCygS76VaNET7bd187quK0+EJpMGOQNW3
 hYkOfKlY/XGmFcdV/JMgkxbXSzvhq65n95Ub2NSWphLYRDFLtEnJ23OLBdPu5tw8gTQA
 OE8ctp0kVxnwHmsKd9eXSKp6GM9wh6X51oU3/NJ8Qb8vYLlfycNVBxXnCN2HAo+YmFP8
 jbwN+syBNKdRI76nklr12K+DJLndf0p23L0X0rH/CinmFxRBLi5pDGHpDwFAYJ2fI/9x
 nivcAp7BGFIM/HkHHtb1ss7JtWrqUz2thSybKrOdOfGvXRVN8coB1PQfOC4Pu+5tTvmp
 i4gw==
X-Gm-Message-State: AOAM533ZZzLU/YVjMqp/ccpe9OxBVCyW5HMjGKTmHFqrK9Fs0CgzT1fZ
 kdwmpnnjHzE+KLnHtkWpLrYaGA==
X-Google-Smtp-Source: ABdhPJwVxlhQ9mVVhwT4VIn7GVK6w/nxlGINZcKsC992JVrFpK6Zxjo0UMSxUODSRdT1QtVrc4vJ5A==
X-Received: by 2002:adf:d0d0:: with SMTP id z16mr1230452wrh.95.1594670671470; 
 Mon, 13 Jul 2020 13:04:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d81sm1348870wmc.0.2020.07.13.13.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 13:04:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A391A1FF9A;
 Mon, 13 Jul 2020 21:04:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 11/11] plugins: new hwprofile plugin
Date: Mon, 13 Jul 2020 21:04:15 +0100
Message-Id: <20200713200415.26214-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713200415.26214-1-alex.bennee@linaro.org>
References: <20200713200415.26214-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a plugin intended to help with profiling access to various
bits of system hardware. It only really makes sense for system
emulation.

It takes advantage of the recently exposed helper API that allows us
to see the device name (memory region name) associated with a device.

You can specify arg=read or arg=write to limit the tracking to just
reads or writes (by default it does both).

The pattern option:

  -plugin ./tests/plugin/libhwprofile.so,arg=pattern

will allow you to see the access pattern to devices, eg:

  gic_cpu @ 0xffffffc010040000
    off:00000000, 8, 1, 8, 1
    off:00000000, 4, 1, 4, 1
    off:00000000, 2, 1, 2, 1
    off:00000000, 1, 1, 1, 1

The source option:

  -plugin ./tests/plugin/libhwprofile.so,arg=source

will track the virtual source address of the instruction making the
access:

  pl011 @ 0xffffffc010031000
    pc:ffffffc0104c785c, 1, 4, 0, 0
    pc:ffffffc0104c7898, 1, 4, 0, 0
    pc:ffffffc010512bcc, 2, 1867, 0, 0

You cannot mix source and pattern.

Finally the match option allow you to limit the tracking to just the
devices you care about.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Tested-by: Robert Foley <robert.foley@linaro.org>

---
v2
  - use 64 bit cpu masks
  - warn if we will exceed cpu mask capability
  - don't run in linux-user mode
  - skip in check-tcg for linux-user test
v3
  - update device name API
  - re-factor and clean-up
  - add source tracking
  - use direct hash for source/pattern
  - add match function
  - expand the commit message
  - checkpatch cleanups
---
 tests/plugin/hwprofile.c  | 305 ++++++++++++++++++++++++++++++++++++++
 tests/plugin/Makefile     |   1 +
 tests/tcg/Makefile.target |  12 +-
 3 files changed, 316 insertions(+), 2 deletions(-)
 create mode 100644 tests/plugin/hwprofile.c

diff --git a/tests/plugin/hwprofile.c b/tests/plugin/hwprofile.c
new file mode 100644
index 0000000000..6dac1d5f85
--- /dev/null
+++ b/tests/plugin/hwprofile.c
@@ -0,0 +1,305 @@
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
+    uint64_t cpu_read;
+    uint64_t cpu_write;
+    uint64_t reads;
+    uint64_t writes;
+} IOCounts;
+
+typedef struct {
+    uint64_t off_or_pc;
+    IOCounts counts;
+} IOLocationCounts;
+
+typedef struct {
+    const char *name;
+    uint64_t   base;
+    IOCounts   totals;
+    GHashTable *detail;
+} DeviceCounts;
+
+static GMutex lock;
+static GHashTable *devices;
+
+/* track the access pattern to a piece of HW */
+static bool pattern;
+/* track the source address of access to HW */
+static bool source;
+/* track only matched regions of HW */
+static bool check_match;
+static gchar **matches;
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
+    devices = g_hash_table_new(NULL, NULL);
+}
+
+static gint sort_cmp(gconstpointer a, gconstpointer b)
+{
+    DeviceCounts *ea = (DeviceCounts *) a;
+    DeviceCounts *eb = (DeviceCounts *) b;
+    return ea->totals.reads + ea->totals.writes >
+           eb->totals.reads + eb->totals.writes ? -1 : 1;
+}
+
+static gint sort_loc(gconstpointer a, gconstpointer b)
+{
+    IOLocationCounts *ea = (IOLocationCounts *) a;
+    IOLocationCounts *eb = (IOLocationCounts *) b;
+    return ea->off_or_pc > eb->off_or_pc;
+}
+
+static void fmt_iocount_record(GString *s, IOCounts *rec)
+{
+    if (track_reads()) {
+        g_string_append_printf(s, ", %"PRIx64", %"PRId64,
+                               rec->cpu_read, rec->reads);
+    }
+    if (track_writes()) {
+        g_string_append_printf(s, ", %"PRIx64", %"PRId64,
+                               rec->cpu_write, rec->writes);
+    }
+}
+
+static void fmt_dev_record(GString *s, DeviceCounts *rec)
+{
+    g_string_append_printf(s, "%s, 0x%"PRIx64,
+                           rec->name, rec->base);
+    fmt_iocount_record(s, &rec->totals);
+    g_string_append_c(s, '\n');
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autoptr(GString) report = g_string_new("");
+    GList *counts;
+
+    if (!(pattern || source)) {
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
+            if (rec->detail) {
+                GList *accesses = g_hash_table_get_values(rec->detail);
+                GList *io_it = g_list_sort(accesses, sort_loc);
+                const char *prefix = pattern ? "off" : "pc";
+                g_string_append_printf(report, "%s @ 0x%"PRIx64"\n",
+                                       rec->name, rec->base);
+                while (io_it) {
+                    IOLocationCounts *loc = (IOLocationCounts *) io_it->data;
+                    g_string_append_printf(report, "  %s:%08"PRIx64,
+                                           prefix, loc->off_or_pc);
+                    fmt_iocount_record(report, &loc->counts);
+                    g_string_append_c(report, '\n');
+                    io_it = io_it->next;
+                }
+            } else {
+                fmt_dev_record(report, rec);
+            }
+            it = it->next;
+        };
+        g_list_free(it);
+    }
+
+    qemu_plugin_outs(report->str);
+}
+
+static DeviceCounts *new_count(const char *name, uint64_t base)
+{
+    DeviceCounts *count = g_new0(DeviceCounts, 1);
+    count->name = name;
+    count->base = base;
+    if (pattern || source) {
+        count->detail = g_hash_table_new(NULL, NULL);
+    }
+    g_hash_table_insert(devices, (gpointer) name, count);
+    return count;
+}
+
+static IOLocationCounts *new_location(GHashTable *table, uint64_t off_or_pc)
+{
+    IOLocationCounts *loc = g_new0(IOLocationCounts, 1);
+    loc->off_or_pc = off_or_pc;
+    g_hash_table_insert(table, (gpointer) off_or_pc, loc);
+    return loc;
+}
+
+static void hwprofile_match_hit(DeviceCounts *rec, uint64_t off)
+{
+    g_autoptr(GString) report = g_string_new("hwprofile: match @ offset");
+    g_string_append_printf(report, "%"PRIx64", previous hits\n", off);
+    fmt_dev_record(report, rec);
+    qemu_plugin_outs(report->str);
+}
+
+static void inc_count(IOCounts *count, bool is_write, unsigned int cpu_index)
+{
+    if (is_write) {
+        count->writes++;
+        count->cpu_write |= (1 << cpu_index);
+    } else {
+        count->reads++;
+        count->cpu_read |= (1 << cpu_index);
+    }
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
+        const char *name = qemu_plugin_hwaddr_device_name(hwaddr);
+        uint64_t off = qemu_plugin_hwaddr_device_offset(hwaddr);
+        bool is_write = qemu_plugin_mem_is_store(meminfo);
+        DeviceCounts *counts;
+
+        g_mutex_lock(&lock);
+        counts = (DeviceCounts *) g_hash_table_lookup(devices, name);
+
+        if (!counts) {
+            uint64_t base = vaddr - off;
+            counts = new_count(name, base);
+        }
+
+        if (check_match) {
+            if (g_strv_contains((const char * const *)matches, counts->name)) {
+                hwprofile_match_hit(counts, off);
+                inc_count(&counts->totals, is_write, cpu_index);
+            }
+        } else {
+            inc_count(&counts->totals, is_write, cpu_index);
+        }
+
+        /* either track offsets or source of access */
+        if (source) {
+            off = (uint64_t) udata;
+        }
+
+        if (pattern || source) {
+            IOLocationCounts *io_count = g_hash_table_lookup(counts->detail,
+                                                             (gpointer) off);
+            if (!io_count) {
+                io_count = new_location(counts->detail, off);
+            }
+            inc_count(&io_count->counts, is_write, cpu_index);
+        }
+
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
+        gpointer udata = (gpointer) (source ? qemu_plugin_insn_vaddr(insn) : 0);
+        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_haddr,
+                                         QEMU_PLUGIN_CB_NO_REGS,
+                                         rw, udata);
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
+        } else if (g_strcmp0(opt, "pattern") == 0) {
+            pattern = true;
+        } else if (g_strcmp0(opt, "source") == 0) {
+            source = true;
+        } else if (g_str_has_prefix(opt, "match")) {
+            gchar **parts = g_strsplit(opt, "=", 2);
+            check_match = true;
+            matches = g_strsplit(parts[1], ",", -1);
+            g_strfreev(parts);
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
+    if (source && pattern) {
+        fprintf(stderr, "can only currently track either source or pattern.\n");
+        return -1;
+    }
+
+    if (!info->system_emulation) {
+        fprintf(stderr, "hwprofile: plugin only useful for system emulation\n");
+        return -1;
+    }
+
+    /* Just warn about overflow */
+    if (info->system.smp_vcpus > 64 ||
+        info->system.max_vcpus > 64) {
+        fprintf(stderr, "hwprofile: can only track up to 64 CPUs\n");
+    }
+
+    plugin_init();
+
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index e9348fde4a..e9d1947751 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -21,6 +21,7 @@ NAMES += hotblocks
 NAMES += howvec
 NAMES += hotpages
 NAMES += lockstep
+NAMES += hwprofile
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 4b2b696fce..bc595b0588 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -129,8 +129,16 @@ ifeq ($(CONFIG_PLUGIN),y)
 PLUGIN_SRC=$(SRC_PATH)/tests/plugin
 PLUGIN_LIB=../../plugin
 VPATH+=$(PLUGIN_LIB)
-PLUGINS=$(filter-out liblockstep.so,\
-		$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c))))
+
+# Some plugins aren't testable automatically
+SKIP_PLUGINS=liblockstep.so
+ifdef CONFIG_USER_ONLY
+SKIP_PLUGINS+=libhwprofile.so
+endif
+
+PLUGINS=$(filter-out $(SKIP_PLUGINS),\
+		$(patsubst %.c, lib%.so, \
+			$(notdir $(wildcard $(PLUGIN_SRC)/*.c))))
 
 # We need to ensure expand the run-plugin-TEST-with-PLUGIN
 # pre-requistes manually here as we can't use stems to handle it. We
-- 
2.20.1


