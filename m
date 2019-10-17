Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5CAFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B7E2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqIwv0ZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B7E2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5x1-0005jM-Ee
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dl-00088C-L1
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dh-0005Sv-HQ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5dh-0005Rc-54
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id v17so2488920wml.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yuKYDVURJsoh7ltrhZ/rRppynX6rAlAjmrHW/gLUgw0=;
 b=rqIwv0ZJe7hxzbAYcjlIIle1SwMdlPVtOM+l383xFe7bUkxF3NqOJPGiE0KQg9guwi
 SbHKjiRtbMRk6M4bW+QLa+Eql/XoD/tQRwJ8zI2nN0G9Bdkv/NIZ8kqEUZcWCUVU5nVl
 m5KGGQJ4ZEPtpBj5ASlO0LpsE8hCMjuCPuVqxOmmGKbUISuv+AVAwECy5d8CjnPMXhY9
 H5jxxG+jI4VynHYb/a1Hajw4mWnwcN5mLWwi92JvWdUXNqfcWlP/949L/bwqBYkbuUpK
 71cXawBxd/jjBUDT0G+lXhh1TtNdnbERktJCJ12YrRvM6LqW0wTU2T73Qezq46lvxA6e
 14MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yuKYDVURJsoh7ltrhZ/rRppynX6rAlAjmrHW/gLUgw0=;
 b=MJBTNv4bory8AteK00Pspmb6iK3+sujLscyvWyLRVraXML4SAWwvsQ6GE+br0K/kNQ
 WeUsJjYK7RK+SD5IRtHx8lNeIqGKUWybexJJX3zMKl2MqeCMnVlKt4mvIkWZjefl2mH8
 TTVObgJybBtUuapHF2Mv1tqC2l/vMLEq6zP7fDDgWJ7PUasyNipH9E4DG0lILUyp4DiI
 t1/KfTZGSLDaPXPgweTndG/3n+eC3m/nWUmsUuzReVm6Z4N2URHAnaRly86Uu1UAcV4Q
 cxD0Yy8M6ZvsYsoX5PZBd46ZNXhzU2k7SliaZ0hv9fT23ixn93akks9tYbvT1PmmOSMY
 H1JA==
X-Gm-Message-State: APjAAAVaJRfS3mMGN4t9JhVkixVnQlK0HfHdMs0eJKUeshZNzVXhBJkJ
 4RRE0cVW5PR2FSW+3+azd9zUxQ==
X-Google-Smtp-Source: APXvYqzOhlqe80qStBB+ypMduRih1qrohmt156fMy7gl9fCrkFNOOxC50ELq+Xpbsgwz/sfiIM8nUg==
X-Received: by 2002:a1c:f709:: with SMTP id v9mr3037833wmh.62.1571318183174;
 Thu, 17 Oct 2019 06:16:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o22sm2469933wra.96.2019.10.17.06.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:20 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 80EA21FF96;
 Thu, 17 Oct 2019 14:16:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 07/54] plugin: add core code
Date: Thu, 17 Oct 2019 14:15:28 +0100
Message-Id: <20191017131615.19660-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: moved directory and merged various fixes]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v3
  - moved to plugins/
  - merged
    plugin: remove uninstall_cb_t and just use simple_cb_t
    plugin: handle uninstall when !current_cpu
    plugin: introduce qemu_plugin_reset
  - split into core/loader
  - use GArray/GByteArray/GPtrArray instead of homegrown funcs
v4
  - document QEMU_PLUGIN_EV_MAX
  - move qemu_plugin_ram_addr_from_host to api
  - drop vcpu_index from trans cb
  - s/plugin_dyn_cb_type/plugin_dyn_cb_subtype/ in qemu_plugin_dyn_cb
  - remove haddr from memory hooks
  - checkpatch fixes
v5
  - fix up includes of hw/cpu.h
  - added proper license and copyright headers
  - restore commented out uninstall
v6
  - call plugin_reset_uninstall directly instead of API function
  - fix up some checkpatch warnings
  - remove unused QLIST_HEAD that checkpatch warned about
  - use gmodule for .so load and link operations
---
 Makefile              |   9 +-
 Makefile.target       |   2 +
 configure             |   3 +
 include/hw/core/cpu.h |   6 +
 include/qemu/plugin.h | 255 +++++++++++++++++++++
 plugins/Makefile.objs |   6 +
 plugins/core.c        | 502 ++++++++++++++++++++++++++++++++++++++++++
 plugins/loader.c      | 362 ++++++++++++++++++++++++++++++
 plugins/plugin.h      |  97 ++++++++
 9 files changed, 1241 insertions(+), 1 deletion(-)
 create mode 100644 include/qemu/plugin.h
 create mode 100644 plugins/Makefile.objs
 create mode 100644 plugins/core.c
 create mode 100644 plugins/loader.c
 create mode 100644 plugins/plugin.h

diff --git a/Makefile b/Makefile
index 30f0abfb42..15f4745cf3 100644
--- a/Makefile
+++ b/Makefile
@@ -846,7 +846,11 @@ endif
 
 ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 
-install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir \
+install-includedir:
+	$(INSTALL_DIR) "$(DESTDIR)$(includedir)"
+
+install: all $(if $(BUILD_DOCS),install-doc) \
+	install-datadir install-localstatedir install-includedir \
 	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
 	recurse-install
 ifneq ($(TOOLS),)
@@ -908,6 +912,9 @@ endif
 		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
 ifdef CONFIG_GTK
 	$(MAKE) -C po $@
+endif
+ifeq ($(CONFIG_PLUGIN),y)
+	$(INSTALL_DATA) $(SRC_PATH)/include/qemu/qemu-plugin.h "$(DESTDIR)$(includedir)/qemu-plugin.h"
 endif
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
 	set -e; for x in $(KEYMAPS); do \
diff --git a/Makefile.target b/Makefile.target
index 5e916230c4..5de6c95efb 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -119,6 +119,8 @@ obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 LIBS := $(libs_cpu) $(LIBS)
 
+obj-$(CONFIG_PLUGIN) += plugins/
+
 #########################################################
 # Linux user emulator target
 
diff --git a/configure b/configure
index 08ca4bcb46..412b1e13af 100755
--- a/configure
+++ b/configure
@@ -3607,6 +3607,9 @@ glib_modules=gthread-2.0
 if test "$modules" = yes; then
     glib_modules="$glib_modules gmodule-export-2.0"
 fi
+if test "$plugins" = yes; then
+    glib_modules="$glib_modules gmodule-2.0"
+fi
 
 # This workaround is required due to a bug in pkg-config file for glib as it
 # doesn't define GLIB_STATIC_COMPILATION for pkg-config --static
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 07f2ab0590..e1c383ba84 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -29,6 +29,7 @@
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
+#include "qemu/plugin.h"
 
 typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
                                      void *opaque);
@@ -344,6 +345,7 @@ struct qemu_work_item;
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
+ * @plugin_mask: Plugin event bitmap. Modified only via async work.
  * @ignore_memory_transaction_failures: Cached copy of the MachineState
  *    flag of the same name: allows the board to suppress calling of the
  *    CPU do_transaction_failed hook function.
@@ -428,6 +430,10 @@ struct CPUState {
     DECLARE_BITMAP(trace_dstate_delayed, CPU_TRACE_DSTATE_MAX_EVENTS);
     DECLARE_BITMAP(trace_dstate, CPU_TRACE_DSTATE_MAX_EVENTS);
 
+    DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
+
+    GArray *plugin_mem_cbs;
+
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
new file mode 100644
index 0000000000..11687e8cdc
--- /dev/null
+++ b/include/qemu/plugin.h
@@ -0,0 +1,255 @@
+/*
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#ifndef QEMU_PLUGIN_H
+#define QEMU_PLUGIN_H
+
+#include "qemu/config-file.h"
+#include "qemu/qemu-plugin.h"
+#include "qemu/error-report.h"
+#include "qemu/queue.h"
+#include "qemu/option.h"
+
+/*
+ * Option parsing/processing.
+ * Note that we can load an arbitrary number of plugins.
+ */
+struct qemu_plugin_desc;
+typedef QTAILQ_HEAD(, qemu_plugin_desc) QemuPluginList;
+
+#ifdef CONFIG_PLUGIN
+extern QemuOptsList qemu_plugin_opts;
+
+static inline void qemu_plugin_add_opts(void)
+{
+    qemu_add_opts(&qemu_plugin_opts);
+}
+
+void qemu_plugin_opt_parse(const char *optarg, QemuPluginList *head);
+int qemu_plugin_load_list(QemuPluginList *head);
+#else /* !CONFIG_PLUGIN */
+static inline void qemu_plugin_add_opts(void)
+{ }
+
+static inline void qemu_plugin_opt_parse(const char *optarg,
+                                         QemuPluginList *head)
+{
+    error_report("plugin interface not enabled in this build");
+    exit(1);
+}
+
+static inline int qemu_plugin_load_list(QemuPluginList *head)
+{
+    return 0;
+}
+#endif /* !CONFIG_PLUGIN */
+
+/*
+ * Events that plugins can subscribe to.
+ */
+enum qemu_plugin_event {
+    QEMU_PLUGIN_EV_VCPU_INIT,
+    QEMU_PLUGIN_EV_VCPU_EXIT,
+    QEMU_PLUGIN_EV_VCPU_TB_TRANS,
+    QEMU_PLUGIN_EV_VCPU_IDLE,
+    QEMU_PLUGIN_EV_VCPU_RESUME,
+    QEMU_PLUGIN_EV_VCPU_SYSCALL,
+    QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
+    QEMU_PLUGIN_EV_FLUSH,
+    QEMU_PLUGIN_EV_ATEXIT,
+    QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
+};
+
+union qemu_plugin_cb_sig {
+    qemu_plugin_simple_cb_t          simple;
+    qemu_plugin_udata_cb_t           udata;
+    qemu_plugin_vcpu_simple_cb_t     vcpu_simple;
+    qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
+    qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
+    qemu_plugin_vcpu_mem_cb_t        vcpu_mem;
+    qemu_plugin_vcpu_syscall_cb_t    vcpu_syscall;
+    qemu_plugin_vcpu_syscall_ret_cb_t vcpu_syscall_ret;
+    void *generic;
+};
+
+enum plugin_dyn_cb_type {
+    PLUGIN_CB_INSN,
+    PLUGIN_CB_MEM,
+    PLUGIN_N_CB_TYPES,
+};
+
+enum plugin_dyn_cb_subtype {
+    PLUGIN_CB_REGULAR,
+    PLUGIN_CB_INLINE,
+    PLUGIN_N_CB_SUBTYPES,
+};
+
+/*
+ * A dynamic callback has an insertion point that is determined at run-time.
+ * Usually the insertion point is somewhere in the code cache; think for
+ * instance of a callback to be called upon the execution of a particular TB.
+ */
+struct qemu_plugin_dyn_cb {
+    union qemu_plugin_cb_sig f;
+    void *userp;
+    unsigned tcg_flags;
+    enum plugin_dyn_cb_subtype type;
+    /* @rw applies to mem callbacks only (both regular and inline) */
+    enum qemu_plugin_mem_rw rw;
+    /* fields specific to each dyn_cb type go here */
+    union {
+        struct {
+            enum qemu_plugin_op op;
+            uint64_t imm;
+        } inline_insn;
+    };
+};
+
+struct qemu_plugin_insn {
+    GByteArray *data;
+    uint64_t vaddr;
+    void *haddr;
+    GArray *cbs[PLUGIN_N_CB_TYPES][PLUGIN_N_CB_SUBTYPES];
+    bool calls_helpers;
+    bool mem_helper;
+};
+
+/*
+ * qemu_plugin_insn allocate and cleanup functions. We don't expect to
+ * cleanup many of these structures. They are reused for each fresh
+ * translation.
+ */
+
+static inline void qemu_plugin_insn_cleanup_fn(gpointer data)
+{
+    struct qemu_plugin_insn *insn = (struct qemu_plugin_insn *) data;
+    g_byte_array_free(insn->data, true);
+}
+
+static inline struct qemu_plugin_insn *qemu_plugin_insn_alloc(void)
+{
+    int i, j;
+    struct qemu_plugin_insn *insn = g_new0(struct qemu_plugin_insn, 1);
+    insn->data = g_byte_array_sized_new(4);
+
+    for (i = 0; i < PLUGIN_N_CB_TYPES; i++) {
+        for (j = 0; j < PLUGIN_N_CB_SUBTYPES; j++) {
+            insn->cbs[i][j] = g_array_new(false, false,
+                                          sizeof(struct qemu_plugin_dyn_cb));
+        }
+    }
+    return insn;
+}
+
+struct qemu_plugin_tb {
+    GPtrArray *insns;
+    size_t n;
+    uint64_t vaddr;
+    uint64_t vaddr2;
+    void *haddr1;
+    void *haddr2;
+    GArray *cbs[PLUGIN_N_CB_SUBTYPES];
+};
+
+/**
+ * qemu_plugin_tb_insn_get(): get next plugin record for translation.
+ *
+ */
+static inline
+struct qemu_plugin_insn *qemu_plugin_tb_insn_get(struct qemu_plugin_tb *tb)
+{
+    struct qemu_plugin_insn *insn;
+    int i, j;
+
+    if (unlikely(tb->n == tb->insns->len)) {
+        struct qemu_plugin_insn *new_insn = qemu_plugin_insn_alloc();
+        g_ptr_array_add(tb->insns, new_insn);
+    }
+    insn = g_ptr_array_index(tb->insns, tb->n++);
+    g_byte_array_set_size(insn->data, 0);
+    insn->calls_helpers = false;
+    insn->mem_helper = false;
+
+    for (i = 0; i < PLUGIN_N_CB_TYPES; i++) {
+        for (j = 0; j < PLUGIN_N_CB_SUBTYPES; j++) {
+            g_array_set_size(insn->cbs[i][j], 0);
+        }
+    }
+
+    return insn;
+}
+
+#ifdef CONFIG_PLUGIN
+
+void qemu_plugin_vcpu_init_hook(CPUState *cpu);
+void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
+void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
+void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
+void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
+void
+qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
+                         uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
+                         uint64_t a6, uint64_t a7, uint64_t a8);
+void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret);
+
+void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr, uint32_t meminfo);
+
+void qemu_plugin_flush_cb(void);
+
+void qemu_plugin_atexit_cb(void);
+
+void qemu_plugin_add_dyn_cb_arr(GArray *arr);
+
+void qemu_plugin_disable_mem_helpers(CPUState *cpu);
+
+#else /* !CONFIG_PLUGIN */
+
+static inline void qemu_plugin_vcpu_init_hook(CPUState *cpu)
+{ }
+
+static inline void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
+{ }
+
+static inline void qemu_plugin_tb_trans_cb(CPUState *cpu,
+                                           struct qemu_plugin_tb *tb)
+{ }
+
+static inline void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
+{ }
+
+static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
+{ }
+
+static inline void
+qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
+                         uint64_t a3, uint64_t a4, uint64_t a5, uint64_t a6,
+                         uint64_t a7, uint64_t a8)
+{ }
+
+static inline
+void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
+{ }
+
+static inline void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
+                                           uint32_t meminfo)
+{ }
+
+static inline void qemu_plugin_flush_cb(void)
+{ }
+
+static inline void qemu_plugin_atexit_cb(void)
+{ }
+
+static inline
+void qemu_plugin_add_dyn_cb_arr(GArray *arr)
+{ }
+
+static inline void qemu_plugin_disable_mem_helpers(CPUState *cpu)
+{ }
+
+#endif /* !CONFIG_PLUGIN */
+
+#endif /* QEMU_PLUGIN_H */
diff --git a/plugins/Makefile.objs b/plugins/Makefile.objs
new file mode 100644
index 0000000000..58940335bc
--- /dev/null
+++ b/plugins/Makefile.objs
@@ -0,0 +1,6 @@
+#
+# Plugin Support
+#
+
+obj-y += loader.o
+obj-y += core.o
diff --git a/plugins/core.c b/plugins/core.c
new file mode 100644
index 0000000000..9e1b9e7a91
--- /dev/null
+++ b/plugins/core.c
@@ -0,0 +1,502 @@
+/*
+ * QEMU Plugin Core code
+ *
+ * This is the core code that deals with injecting instrumentation into the code
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019, Linaro
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/config-file.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
+#include "qemu/rcu_queue.h"
+#include "qemu/xxhash.h"
+#include "qemu/rcu.h"
+#include "hw/core/cpu.h"
+#include "exec/cpu-common.h"
+
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+#include "sysemu/sysemu.h"
+#include "tcg/tcg.h"
+#include "tcg/tcg-op.h"
+#include "trace/mem-internal.h" /* mem_info macros */
+#include "plugin.h"
+
+struct qemu_plugin_cb {
+    struct qemu_plugin_ctx *ctx;
+    union qemu_plugin_cb_sig f;
+    void *udata;
+    QLIST_ENTRY(qemu_plugin_cb) entry;
+};
+
+struct qemu_plugin_state plugin;
+
+struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id)
+{
+    struct qemu_plugin_ctx *ctx;
+    qemu_plugin_id_t *id_p;
+
+    id_p = g_hash_table_lookup(plugin.id_ht, &id);
+    ctx = container_of(id_p, struct qemu_plugin_ctx, id);
+    if (ctx == NULL) {
+        error_report("plugin: invalid plugin id %" PRIu64, id);
+        abort();
+    }
+    return ctx;
+}
+
+static void plugin_cpu_update__async(CPUState *cpu, run_on_cpu_data data)
+{
+    bitmap_copy(cpu->plugin_mask, &data.host_ulong, QEMU_PLUGIN_EV_MAX);
+    cpu_tb_jmp_cache_clear(cpu);
+}
+
+static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer udata)
+{
+    CPUState *cpu = container_of(k, CPUState, cpu_index);
+    run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
+
+    if (cpu->created) {
+        async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
+    } else {
+        plugin_cpu_update__async(cpu, mask);
+    }
+}
+
+void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
+                                  enum qemu_plugin_event ev)
+{
+    struct qemu_plugin_cb *cb = ctx->callbacks[ev];
+
+    if (cb == NULL) {
+        return;
+    }
+    QLIST_REMOVE_RCU(cb, entry);
+    g_free(cb);
+    ctx->callbacks[ev] = NULL;
+    if (QLIST_EMPTY_RCU(&plugin.cb_lists[ev])) {
+        clear_bit(ev, plugin.mask);
+        g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked, NULL);
+    }
+}
+
+static void plugin_vcpu_cb__simple(CPUState *cpu, enum qemu_plugin_event ev)
+{
+    struct qemu_plugin_cb *cb, *next;
+
+    switch (ev) {
+    case QEMU_PLUGIN_EV_VCPU_INIT:
+    case QEMU_PLUGIN_EV_VCPU_EXIT:
+    case QEMU_PLUGIN_EV_VCPU_IDLE:
+    case QEMU_PLUGIN_EV_VCPU_RESUME:
+        /* iterate safely; plugins might uninstall themselves at any time */
+        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+            qemu_plugin_vcpu_simple_cb_t func = cb->f.vcpu_simple;
+
+            func(cb->ctx->id, cpu->cpu_index);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void plugin_cb__simple(enum qemu_plugin_event ev)
+{
+    struct qemu_plugin_cb *cb, *next;
+
+    switch (ev) {
+    case QEMU_PLUGIN_EV_FLUSH:
+        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+            qemu_plugin_simple_cb_t func = cb->f.simple;
+
+            func(cb->ctx->id);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void plugin_cb__udata(enum qemu_plugin_event ev)
+{
+    struct qemu_plugin_cb *cb, *next;
+
+    switch (ev) {
+    case QEMU_PLUGIN_EV_ATEXIT:
+        QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+            qemu_plugin_udata_cb_t func = cb->f.udata;
+
+            func(cb->ctx->id, cb->udata);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void
+do_plugin_register_cb(qemu_plugin_id_t id, enum qemu_plugin_event ev,
+                      void *func, void *udata)
+{
+    struct qemu_plugin_ctx *ctx;
+
+    qemu_rec_mutex_lock(&plugin.lock);
+    ctx = plugin_id_to_ctx_locked(id);
+    /* if the plugin is on its way out, ignore this request */
+    if (unlikely(ctx->uninstalling)) {
+        goto out_unlock;
+    }
+    if (func) {
+        struct qemu_plugin_cb *cb = ctx->callbacks[ev];
+
+        if (cb) {
+            cb->f.generic = func;
+            cb->udata = udata;
+        } else {
+            cb = g_new(struct qemu_plugin_cb, 1);
+            cb->ctx = ctx;
+            cb->f.generic = func;
+            cb->udata = udata;
+            ctx->callbacks[ev] = cb;
+            QLIST_INSERT_HEAD_RCU(&plugin.cb_lists[ev], cb, entry);
+            if (!test_bit(ev, plugin.mask)) {
+                set_bit(ev, plugin.mask);
+                g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked,
+                                     NULL);
+            }
+        }
+    } else {
+        plugin_unregister_cb__locked(ctx, ev);
+    }
+ out_unlock:
+    qemu_rec_mutex_unlock(&plugin.lock);
+}
+
+void plugin_register_cb(qemu_plugin_id_t id, enum qemu_plugin_event ev,
+                        void *func)
+{
+    do_plugin_register_cb(id, ev, func, NULL);
+}
+
+void
+plugin_register_cb_udata(qemu_plugin_id_t id, enum qemu_plugin_event ev,
+                         void *func, void *udata)
+{
+    do_plugin_register_cb(id, ev, func, udata);
+}
+
+void qemu_plugin_vcpu_init_hook(CPUState *cpu)
+{
+    bool success;
+
+    qemu_rec_mutex_lock(&plugin.lock);
+    plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);
+    success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
+                                  &cpu->cpu_index);
+    g_assert(success);
+    qemu_rec_mutex_unlock(&plugin.lock);
+
+    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
+}
+
+void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
+{
+    bool success;
+
+    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_EXIT);
+
+    qemu_rec_mutex_lock(&plugin.lock);
+    success = g_hash_table_remove(plugin.cpu_ht, &cpu->cpu_index);
+    g_assert(success);
+    qemu_rec_mutex_unlock(&plugin.lock);
+}
+
+struct plugin_for_each_args {
+    struct qemu_plugin_ctx *ctx;
+    qemu_plugin_vcpu_simple_cb_t cb;
+};
+
+static void plugin_vcpu_for_each(gpointer k, gpointer v, gpointer udata)
+{
+    struct plugin_for_each_args *args = udata;
+    int cpu_index = *(int *)k;
+
+    args->cb(args->ctx->id, cpu_index);
+}
+
+void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
+                               qemu_plugin_vcpu_simple_cb_t cb)
+{
+    struct plugin_for_each_args args;
+
+    if (cb == NULL) {
+        return;
+    }
+    qemu_rec_mutex_lock(&plugin.lock);
+    args.ctx = plugin_id_to_ctx_locked(id);
+    args.cb = cb;
+    g_hash_table_foreach(plugin.cpu_ht, plugin_vcpu_for_each, &args);
+    qemu_rec_mutex_unlock(&plugin.lock);
+}
+
+/* Allocate and return a callback record */
+static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
+{
+    GArray *cbs = *arr;
+
+    if (!cbs) {
+        cbs = g_array_sized_new(false, false,
+                                sizeof(struct qemu_plugin_dyn_cb), 1);
+        *arr = cbs;
+    }
+
+    g_array_set_size(cbs, cbs->len + 1);
+    return &g_array_index(cbs, struct qemu_plugin_dyn_cb, cbs->len - 1);
+}
+
+void plugin_register_inline_op(GArray **arr,
+                               enum qemu_plugin_mem_rw rw,
+                               enum qemu_plugin_op op, void *ptr,
+                               uint64_t imm)
+{
+    struct qemu_plugin_dyn_cb *dyn_cb;
+
+    dyn_cb = plugin_get_dyn_cb(arr);
+    dyn_cb->userp = ptr;
+    dyn_cb->type = PLUGIN_CB_INLINE;
+    dyn_cb->rw = rw;
+    dyn_cb->inline_insn.op = op;
+    dyn_cb->inline_insn.imm = imm;
+}
+
+static inline uint32_t cb_to_tcg_flags(enum qemu_plugin_cb_flags flags)
+{
+    uint32_t ret;
+
+    switch (flags) {
+    case QEMU_PLUGIN_CB_RW_REGS:
+        ret = 0;
+    case QEMU_PLUGIN_CB_R_REGS:
+        ret = TCG_CALL_NO_WG;
+        break;
+    case QEMU_PLUGIN_CB_NO_REGS:
+    default:
+        ret = TCG_CALL_NO_RWG;
+    }
+    return ret;
+}
+
+inline void
+plugin_register_dyn_cb__udata(GArray **arr,
+                              qemu_plugin_vcpu_udata_cb_t cb,
+                              enum qemu_plugin_cb_flags flags, void *udata)
+{
+    struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
+
+    dyn_cb->userp = udata;
+    dyn_cb->tcg_flags = cb_to_tcg_flags(flags);
+    dyn_cb->f.vcpu_udata = cb;
+    dyn_cb->type = PLUGIN_CB_REGULAR;
+}
+
+void plugin_register_vcpu_mem_cb(GArray **arr,
+                                 void *cb,
+                                 enum qemu_plugin_cb_flags flags,
+                                 enum qemu_plugin_mem_rw rw,
+                                 void *udata)
+{
+    struct qemu_plugin_dyn_cb *dyn_cb;
+
+    dyn_cb = plugin_get_dyn_cb(arr);
+    dyn_cb->userp = udata;
+    dyn_cb->tcg_flags = cb_to_tcg_flags(flags);
+    dyn_cb->type = PLUGIN_CB_REGULAR;
+    dyn_cb->rw = rw;
+    dyn_cb->f.generic = cb;
+}
+
+void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
+{
+    struct qemu_plugin_cb *cb, *next;
+    enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_TB_TRANS;
+
+    /* no plugin_mask check here; caller should have checked */
+
+    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+        qemu_plugin_vcpu_tb_trans_cb_t func = cb->f.vcpu_tb_trans;
+
+        func(cb->ctx->id, tb);
+    }
+}
+
+void
+qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
+                         uint64_t a3, uint64_t a4, uint64_t a5,
+                         uint64_t a6, uint64_t a7, uint64_t a8)
+{
+    struct qemu_plugin_cb *cb, *next;
+    enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL;
+
+    if (!test_bit(ev, cpu->plugin_mask)) {
+        return;
+    }
+
+    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+        qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
+
+        func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
+    }
+}
+
+void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
+{
+    struct qemu_plugin_cb *cb, *next;
+    enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_RET;
+
+    if (!test_bit(ev, cpu->plugin_mask)) {
+        return;
+    }
+
+    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+        qemu_plugin_vcpu_syscall_ret_cb_t func = cb->f.vcpu_syscall_ret;
+
+        func(cb->ctx->id, cpu->cpu_index, num, ret);
+    }
+}
+
+void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
+{
+    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
+}
+
+void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
+{
+    plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
+}
+
+void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_IDLE, cb);
+}
+
+void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
+                                         qemu_plugin_vcpu_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
+}
+
+void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
+                                   qemu_plugin_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_FLUSH, cb);
+}
+
+static bool free_dyn_cb_arr(void *p, uint32_t h, void *userp)
+{
+    g_array_free((GArray *) p, true);
+    return true;
+}
+
+void qemu_plugin_flush_cb(void)
+{
+    qht_iter_remove(&plugin.dyn_cb_arr_ht, free_dyn_cb_arr, NULL);
+    qht_reset(&plugin.dyn_cb_arr_ht);
+
+    plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
+}
+
+void exec_inline_op(struct qemu_plugin_dyn_cb *cb)
+{
+    uint64_t *val = cb->userp;
+
+    switch (cb->inline_insn.op) {
+    case QEMU_PLUGIN_INLINE_ADD_U64:
+        *val += cb->inline_insn.imm;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr, uint32_t info)
+{
+    GArray *arr = cpu->plugin_mem_cbs;
+    size_t i;
+
+    if (arr == NULL) {
+        return;
+    }
+    for (i = 0; i < arr->len; i++) {
+        struct qemu_plugin_dyn_cb *cb =
+            &g_array_index(arr, struct qemu_plugin_dyn_cb, i);
+        int w = !!(info & TRACE_MEM_ST) + 1;
+
+        if (!(w & cb->rw)) {
+                break;
+        }
+        switch (cb->type) {
+        case PLUGIN_CB_REGULAR:
+            cb->f.vcpu_mem(cpu->cpu_index, info, vaddr, cb->userp);
+            break;
+        case PLUGIN_CB_INLINE:
+            exec_inline_op(cb);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
+
+void qemu_plugin_atexit_cb(void)
+{
+    plugin_cb__udata(QEMU_PLUGIN_EV_ATEXIT);
+}
+
+void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
+                                    qemu_plugin_udata_cb_t cb,
+                                    void *udata)
+{
+    plugin_register_cb_udata(id, QEMU_PLUGIN_EV_ATEXIT, cb, udata);
+}
+
+/*
+ * Call this function after longjmp'ing to the main loop. It's possible that the
+ * last instruction of a TB might have used helpers, and therefore the
+ * "disable" instruction will never execute because it ended up as dead code.
+ */
+void qemu_plugin_disable_mem_helpers(CPUState *cpu)
+{
+    cpu->plugin_mem_cbs = NULL;
+}
+
+static bool plugin_dyn_cb_arr_cmp(const void *ap, const void *bp)
+{
+    return ap == bp;
+}
+
+static void __attribute__((__constructor__)) plugin_init(void)
+{
+    int i;
+
+    for (i = 0; i < QEMU_PLUGIN_EV_MAX; i++) {
+        QLIST_INIT(&plugin.cb_lists[i]);
+    }
+    qemu_rec_mutex_init(&plugin.lock);
+    plugin.id_ht = g_hash_table_new(g_int64_hash, g_int64_equal);
+    plugin.cpu_ht = g_hash_table_new(g_int_hash, g_int_equal);
+    QTAILQ_INIT(&plugin.ctxs);
+    qht_init(&plugin.dyn_cb_arr_ht, plugin_dyn_cb_arr_cmp, 16,
+             QHT_MODE_AUTO_RESIZE);
+    atexit(qemu_plugin_atexit_cb);
+}
diff --git a/plugins/loader.c b/plugins/loader.c
new file mode 100644
index 0000000000..eaedff577c
--- /dev/null
+++ b/plugins/loader.c
@@ -0,0 +1,362 @@
+/*
+ * QEMU Plugin Core Loader Code
+ *
+ * This is the code responsible for loading and unloading the plugins.
+ * Aside from the basic housekeeping tasks we also need to ensure any
+ * generated code is flushed when we remove a plugin so we cannot end
+ * up calling and unloaded helper function.
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019, Linaro
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/config-file.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
+#include "qemu/rcu_queue.h"
+#include "qemu/qht.h"
+#include "qemu/bitmap.h"
+#include "qemu/xxhash.h"
+#include "qemu/plugin.h"
+#include "hw/core/cpu.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "plugin.h"
+
+/*
+ * For convenience we use a bitmap for plugin.mask, but really all we need is a
+ * u32, which is what we store in TranslationBlock.
+ */
+QEMU_BUILD_BUG_ON(QEMU_PLUGIN_EV_MAX > 32);
+
+struct qemu_plugin_desc {
+    char *path;
+    char **argv;
+    QTAILQ_ENTRY(qemu_plugin_desc) entry;
+    int argc;
+};
+
+struct qemu_plugin_parse_arg {
+    QemuPluginList *head;
+    struct qemu_plugin_desc *curr;
+};
+
+QemuOptsList qemu_plugin_opts = {
+    .name = "plugin",
+    .implied_opt_name = "file",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_plugin_opts.head),
+    .desc = {
+        /* do our own parsing to support multiple plugins */
+        { /* end of list */ }
+    },
+};
+
+typedef int (*qemu_plugin_install_func_t)(qemu_plugin_id_t, int, char **);
+
+extern struct qemu_plugin_state plugin;
+
+void qemu_plugin_add_dyn_cb_arr(GArray *arr)
+{
+    uint32_t hash = qemu_xxhash2((uint64_t)(uintptr_t)arr);
+    bool inserted;
+
+    inserted = qht_insert(&plugin.dyn_cb_arr_ht, arr, hash, NULL);
+    g_assert(inserted);
+}
+
+static struct qemu_plugin_desc *plugin_find_desc(QemuPluginList *head,
+                                                 const char *path)
+{
+    struct qemu_plugin_desc *desc;
+
+    QTAILQ_FOREACH(desc, head, entry) {
+        if (strcmp(desc->path, path) == 0) {
+            return desc;
+        }
+    }
+    return NULL;
+}
+
+static int plugin_add(void *opaque, const char *name, const char *value,
+                      Error **errp)
+{
+    struct qemu_plugin_parse_arg *arg = opaque;
+    struct qemu_plugin_desc *p;
+
+    if (strcmp(name, "file") == 0) {
+        if (strcmp(value, "") == 0) {
+            error_setg(errp, "requires a non-empty argument");
+            return 1;
+        }
+        p = plugin_find_desc(arg->head, value);
+        if (p == NULL) {
+            p = g_new0(struct qemu_plugin_desc, 1);
+            p->path = g_strdup(value);
+            QTAILQ_INSERT_TAIL(arg->head, p, entry);
+        }
+        arg->curr = p;
+    } else if (strcmp(name, "arg") == 0) {
+        if (arg->curr == NULL) {
+            error_setg(errp, "missing earlier '-plugin file=' option");
+            return 1;
+        }
+        p = arg->curr;
+        p->argc++;
+        p->argv = g_realloc_n(p->argv, p->argc, sizeof(char *));
+        p->argv[p->argc - 1] = g_strdup(value);
+    } else {
+        error_setg(errp, "-plugin: unexpected parameter '%s'; ignored", name);
+    }
+    return 0;
+}
+
+void qemu_plugin_opt_parse(const char *optarg, QemuPluginList *head)
+{
+    struct qemu_plugin_parse_arg arg;
+    QemuOpts *opts;
+
+    opts = qemu_opts_parse_noisily(qemu_find_opts("plugin"), optarg, true);
+    if (opts == NULL) {
+        exit(1);
+    }
+    arg.head = head;
+    arg.curr = NULL;
+    qemu_opt_foreach(opts, plugin_add, &arg, &error_fatal);
+    qemu_opts_del(opts);
+}
+
+/*
+ * From: https://en.wikipedia.org/wiki/Xorshift
+ * This is faster than rand_r(), and gives us a wider range (RAND_MAX is only
+ * guaranteed to be >= INT_MAX).
+ */
+static uint64_t xorshift64star(uint64_t x)
+{
+    x ^= x >> 12; /* a */
+    x ^= x << 25; /* b */
+    x ^= x >> 27; /* c */
+    return x * UINT64_C(2685821657736338717);
+}
+
+static int plugin_load(struct qemu_plugin_desc *desc)
+{
+    qemu_plugin_install_func_t install;
+    struct qemu_plugin_ctx *ctx;
+    gpointer sym;
+    int rc;
+
+    ctx = qemu_memalign(qemu_dcache_linesize, sizeof(*ctx));
+    memset(ctx, 0, sizeof(*ctx));
+    ctx->desc = desc;
+
+    ctx->handle = g_module_open(desc->path, G_MODULE_BIND_LOCAL);
+    if (ctx->handle == NULL) {
+        error_report("%s: %s", __func__, g_module_error());
+        goto err_dlopen;
+    }
+
+    if (!g_module_symbol(ctx->handle, "qemu_plugin_install", &sym)) {
+        error_report("%s: %s", __func__, g_module_error());
+        goto err_symbol;
+    }
+    install = (qemu_plugin_install_func_t) sym;
+    /* symbol was found; it could be NULL though */
+    if (install == NULL) {
+        error_report("%s: %s: qemu_plugin_install is NULL",
+                     __func__, desc->path);
+        goto err_symbol;
+    }
+
+    qemu_rec_mutex_lock(&plugin.lock);
+
+    /* find an unused random id with &ctx as the seed */
+    ctx->id = (uint64_t)(uintptr_t)ctx;
+    for (;;) {
+        void *existing;
+
+        ctx->id = xorshift64star(ctx->id);
+        existing = g_hash_table_lookup(plugin.id_ht, &ctx->id);
+        if (likely(existing == NULL)) {
+            bool success;
+
+            success = g_hash_table_insert(plugin.id_ht, &ctx->id, &ctx->id);
+            g_assert(success);
+            break;
+        }
+    }
+    QTAILQ_INSERT_TAIL(&plugin.ctxs, ctx, entry);
+    ctx->installing = true;
+    rc = install(ctx->id, desc->argc, desc->argv);
+    ctx->installing = false;
+    if (rc) {
+        error_report("%s: qemu_plugin_install returned error code %d",
+                     __func__, rc);
+        /*
+         * we cannot rely on the plugin doing its own cleanup, so
+         * call a full uninstall if the plugin did not yet call it.
+         */
+        if (!ctx->uninstalling) {
+            plugin_reset_uninstall(ctx->id, NULL, false);
+        }
+    }
+
+    qemu_rec_mutex_unlock(&plugin.lock);
+    return rc;
+
+ err_symbol:
+ err_dlopen:
+    qemu_vfree(ctx);
+    return 1;
+}
+
+/* call after having removed @desc from the list */
+static void plugin_desc_free(struct qemu_plugin_desc *desc)
+{
+    int i;
+
+    for (i = 0; i < desc->argc; i++) {
+        g_free(desc->argv[i]);
+    }
+    g_free(desc->argv);
+    g_free(desc->path);
+    g_free(desc);
+}
+
+/**
+ * qemu_plugin_load_list - load a list of plugins
+ * @head: head of the list of descriptors of the plugins to be loaded
+ *
+ * Returns 0 if all plugins in the list are installed, !0 otherwise.
+ *
+ * Note: the descriptor of each successfully installed plugin is removed
+ * from the list given by @head.
+ */
+int qemu_plugin_load_list(QemuPluginList *head)
+{
+    struct qemu_plugin_desc *desc, *next;
+
+    QTAILQ_FOREACH_SAFE(desc, head, entry, next) {
+        int err;
+
+        err = plugin_load(desc);
+        if (err) {
+            return err;
+        }
+        QTAILQ_REMOVE(head, desc, entry);
+    }
+    return 0;
+}
+
+struct qemu_plugin_reset_data {
+    struct qemu_plugin_ctx *ctx;
+    qemu_plugin_simple_cb_t cb;
+    bool reset;
+};
+
+static void plugin_reset_destroy__locked(struct qemu_plugin_reset_data *data)
+{
+    struct qemu_plugin_ctx *ctx = data->ctx;
+    enum qemu_plugin_event ev;
+    bool success;
+
+    /*
+     * After updating the subscription lists there is no need to wait for an RCU
+     * grace period to elapse, because right now we either are in a "safe async"
+     * work environment (i.e. all vCPUs are asleep), or no vCPUs have yet been
+     * created.
+     */
+    for (ev = 0; ev < QEMU_PLUGIN_EV_MAX; ev++) {
+        plugin_unregister_cb__locked(ctx, ev);
+    }
+
+    if (data->reset) {
+        g_assert(ctx->resetting);
+        if (data->cb) {
+            data->cb(ctx->id);
+        }
+        ctx->resetting = false;
+        g_free(data);
+        return;
+    }
+
+    g_assert(ctx->uninstalling);
+    /* we cannot dlclose if we are going to return to plugin code */
+    if (ctx->installing) {
+        error_report("Calling qemu_plugin_uninstall from the install function "
+                     "is a bug. Instead, return !0 from the install function.");
+        abort();
+    }
+
+    success = g_hash_table_remove(plugin.id_ht, &ctx->id);
+    g_assert(success);
+    QTAILQ_REMOVE(&plugin.ctxs, ctx, entry);
+    if (data->cb) {
+        data->cb(ctx->id);
+    }
+    if (!g_module_close(ctx->handle)) {
+        warn_report("%s: %s", __func__, g_module_error());
+    }
+    plugin_desc_free(ctx->desc);
+    qemu_vfree(ctx);
+    g_free(data);
+}
+
+static void plugin_reset_destroy(struct qemu_plugin_reset_data *data)
+{
+    qemu_rec_mutex_lock(&plugin.lock);
+    plugin_reset_destroy__locked(data);
+    qemu_rec_mutex_lock(&plugin.lock);
+}
+
+static void plugin_flush_destroy(CPUState *cpu, run_on_cpu_data arg)
+{
+    struct qemu_plugin_reset_data *data = arg.host_ptr;
+
+    g_assert(cpu_in_exclusive_context(cpu));
+    tb_flush(cpu);
+    plugin_reset_destroy(data);
+}
+
+void plugin_reset_uninstall(qemu_plugin_id_t id,
+                            qemu_plugin_simple_cb_t cb,
+                            bool reset)
+{
+    struct qemu_plugin_reset_data *data;
+    struct qemu_plugin_ctx *ctx;
+
+    qemu_rec_mutex_lock(&plugin.lock);
+    ctx = plugin_id_to_ctx_locked(id);
+    if (ctx->uninstalling || (reset && ctx->resetting)) {
+        qemu_rec_mutex_unlock(&plugin.lock);
+        return;
+    }
+    ctx->resetting = reset;
+    ctx->uninstalling = !reset;
+    qemu_rec_mutex_unlock(&plugin.lock);
+
+    data = g_new(struct qemu_plugin_reset_data, 1);
+    data->ctx = ctx;
+    data->cb = cb;
+    data->reset = reset;
+    /*
+     * Only flush the code cache if the vCPUs have been created. If so,
+     * current_cpu must be non-NULL.
+     */
+    if (current_cpu) {
+        async_safe_run_on_cpu(current_cpu, plugin_flush_destroy,
+                              RUN_ON_CPU_HOST_PTR(data));
+    } else {
+        /*
+         * If current_cpu isn't set, then we don't have yet any vCPU threads
+         * and we therefore can remove the callbacks synchronously.
+         */
+        plugin_reset_destroy(data);
+    }
+}
diff --git a/plugins/plugin.h b/plugins/plugin.h
new file mode 100644
index 0000000000..5482168d79
--- /dev/null
+++ b/plugins/plugin.h
@@ -0,0 +1,97 @@
+/*
+ * Plugin Shared Internal Functions
+ *
+ * Copyright (C) 2019, Linaro
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _PLUGIN_INTERNAL_H_
+#define _PLUGIN_INTERNAL_H_
+
+#include <gmodule.h>
+
+/* global state */
+struct qemu_plugin_state {
+    QTAILQ_HEAD(, qemu_plugin_ctx) ctxs;
+    QLIST_HEAD(, qemu_plugin_cb) cb_lists[QEMU_PLUGIN_EV_MAX];
+    /*
+     * Use the HT as a hash map by inserting k == v, which saves memory as
+     * documented by GLib. The parent struct is obtained with container_of().
+     */
+    GHashTable *id_ht;
+    /*
+     * Use the HT as a hash map. Note that we could use a list here,
+     * but with the HT we avoid adding a field to CPUState.
+     */
+    GHashTable *cpu_ht;
+    DECLARE_BITMAP(mask, QEMU_PLUGIN_EV_MAX);
+    /*
+     * @lock protects the struct as well as ctx->uninstalling.
+     * The lock must be acquired by all API ops.
+     * The lock is recursive, which greatly simplifies things, e.g.
+     * callback registration from qemu_plugin_vcpu_for_each().
+     */
+    QemuRecMutex lock;
+    /*
+     * HT of callbacks invoked from helpers. All entries are freed when
+     * the code cache is flushed.
+     */
+    struct qht dyn_cb_arr_ht;
+};
+
+
+struct qemu_plugin_ctx {
+    GModule *handle;
+    qemu_plugin_id_t id;
+    struct qemu_plugin_cb *callbacks[QEMU_PLUGIN_EV_MAX];
+    QTAILQ_ENTRY(qemu_plugin_ctx) entry;
+    /*
+     * keep a reference to @desc until uninstall, so that plugins do not have
+     * to strdup plugin args.
+     */
+    struct qemu_plugin_desc *desc;
+    bool installing;
+    bool uninstalling;
+    bool resetting;
+};
+
+struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id);
+
+void plugin_register_inline_op(GArray **arr,
+                               enum qemu_plugin_mem_rw rw,
+                               enum qemu_plugin_op op, void *ptr,
+                               uint64_t imm);
+
+void plugin_reset_uninstall(qemu_plugin_id_t id,
+                            qemu_plugin_simple_cb_t cb,
+                            bool reset);
+
+void plugin_register_cb(qemu_plugin_id_t id, enum qemu_plugin_event ev,
+                        void *func);
+
+void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
+                                  enum qemu_plugin_event ev);
+
+void
+plugin_register_cb_udata(qemu_plugin_id_t id, enum qemu_plugin_event ev,
+                         void *func, void *udata);
+
+void
+plugin_register_dyn_cb__udata(GArray **arr,
+                              qemu_plugin_vcpu_udata_cb_t cb,
+                              enum qemu_plugin_cb_flags flags, void *udata);
+
+
+void plugin_register_vcpu_mem_cb(GArray **arr,
+                                 void *cb,
+                                 enum qemu_plugin_cb_flags flags,
+                                 enum qemu_plugin_mem_rw rw,
+                                 void *udata);
+
+void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
+
+#endif /* _PLUGIN_INTERNAL_H_ */
-- 
2.20.1


