Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B7AC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50252217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAek12Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50252217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53740 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpvg-0001xK-Jt
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56074)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkL-0000gx-Rp
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkJ-00033k-Q2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:13 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:33357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpkJ-00032M-GX
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id h19so9331015wme.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=92e5w8g18IqDzpvO8b8wKWyc5Ftp9KNxzA8ygeTKv0o=;
 b=bAek12XdtEyb83bF64UDydH2kbmmGFeBBH+zVxvuJrlv4yrHOgrAPc2P4Z58zG5jR6
 iWLP8VGklU8Vr8+QvGSiWhgYnk0iBA4zGOb27OQq/9xduviUotWW2upNHxkPQo3gOBWz
 zDganJlAHgHZfFFtGXmoWSIyDAKoKvBO2EmX4pZuMDP3UL1MNpnXF2qVnOFDkUO2VB92
 P8iUl1OvvTfG/lCNHKpftha3DlcVljHwsLfhiv04EzL9feSdFh7j6DmfMwuywyuutNo4
 S0ZD93zOvuh5pL62nTiqVDGIUvJxGeatedM27drNTY6RJHTJlZ1iHlBQSJrCUjR8MLmu
 PSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=92e5w8g18IqDzpvO8b8wKWyc5Ftp9KNxzA8ygeTKv0o=;
 b=ebfCXni/hS6fdFzjWDp0W7e04Hpf3GDJ108UgMnU2C6bnizi+CF83WXnTpxHHsA0Fk
 dWttbPVyzLGJg086QJSfGtUSGXA2+E09TPC2LMhgQRlCeiQKMIZC90WnjVH9OoRqOtyk
 /I0FzBAOzlc5SpG79R3czfyj0KBlEci4asvPh9s41CxV/aC8kXPpPiC6KlqUfIHpO8Qw
 PRfSLsm5NCoZ4Gnq+wijauFrKHxB1N0g8YIzrETrYxeoMV47ZSfE2cHrVpP4QeOkpFjp
 ctn0h34sahO1eOARjZiKoMlLTqfswDBLJNJu6iGp4vlWr8JPtWI/Lost9NYugCB1zOqE
 WB+A==
X-Gm-Message-State: APjAAAUU2UdPOiA7nANTjPz+JYF3HC1I1wo3GrDk7HcrOoQlXMIv3aZD
 VeN0lvIkbeeBPKIogAm/BB3hEQ==
X-Google-Smtp-Source: APXvYqxofbzmMwRvc+NMsVEK0Wbo9ivrjRPa6VBV2taIeozmtOJEFQ+Cog83uzuoztqK82ZgFFd9EQ==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr8794084wmc.53.1560532330031; 
 Fri, 14 Jun 2019 10:12:10 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id w185sm4025708wma.39.2019.06.14.10.12.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:12:05 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 43A8F1FF99;
 Fri, 14 Jun 2019 18:12:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:19 +0100
Message-Id: <20190614171200.21078-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PATCH v3 09/50] plugin: add implementation of the api
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[AJB: split from the core code commit]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/Makefile.objs |   1 +
 plugins/api.c         | 267 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 268 insertions(+)
 create mode 100644 plugins/api.c

diff --git a/plugins/Makefile.objs b/plugins/Makefile.objs
index 58940335bc..95baabf3d2 100644
--- a/plugins/Makefile.objs
+++ b/plugins/Makefile.objs
@@ -4,3 +4,4 @@
 
 obj-y += loader.o
 obj-y += core.o
+obj-y += api.o
diff --git a/plugins/api.c b/plugins/api.c
new file mode 100644
index 0000000000..1c3aa64702
--- /dev/null
+++ b/plugins/api.c
@@ -0,0 +1,267 @@
+/*
+ * QEMU Plugin API
+ *
+ * This provides the API that is available to the plugins to interact
+ * with QEMU. We have to be careful not to expose internal details of
+ * how QEMU works so we abstract out things like translation and
+ * instructions to anonymous data types:
+ *
+ *  qemu_plugin_tb
+ *  qemu_plugin_insn
+ *
+ * Which can then be passed back into the API to do additional things.
+ * As such all the public functions in here are exported in
+ * qemu-plugin.h.
+ *
+ * The general life-cycle of a plugin is:
+ *
+ *  - plugin is loaded, public qemu_plugin_install called
+ *    - the install func registers callbacks for events
+ *    - usually an atexit_cb is registered to dump info at the end
+ *  - when a registered event occurs the plugin is called
+ *     - some events pass additional info
+ *     - during translation the plugin can decide to instrument any
+ *       instruction
+ *  - when QEMU exits all the registered atexit callbacks are called
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019, Linaro
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/plugin.h"
+#include "cpu.h"
+#include "sysemu/sysemu.h"
+#include "tcg/tcg.h"
+#include "trace/mem-internal.h" /* mem_info macros */
+#include "plugin.h"
+
+/* Uninstall and Reset handlers */
+
+void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
+{
+    plugin_reset_uninstall(id, cb, false);
+}
+
+void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
+{
+    plugin_reset_uninstall(id, cb, true);
+}
+
+/*
+ * Plugin Register Functions
+ *
+ * This allows the plugin to register callbacks for various events
+ * during the translation.
+ */
+
+void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INIT, cb);
+}
+
+void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXIT, cb);
+}
+
+void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
+                                          qemu_plugin_vcpu_udata_cb_t cb,
+                                          enum qemu_plugin_cb_flags flags,
+                                          void *udata)
+{
+    plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
+                                  cb, flags, udata);
+}
+
+void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
+                                              enum qemu_plugin_op op,
+                                              void *ptr, uint64_t imm)
+{
+    plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE], 0, op, ptr, imm);
+}
+
+void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
+                                            qemu_plugin_vcpu_udata_cb_t cb,
+                                            enum qemu_plugin_cb_flags flags,
+                                            void *udata)
+{
+    plugin_register_dyn_cb__udata(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR],
+        cb, flags, udata);
+}
+
+void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
+                                                enum qemu_plugin_op op,
+                                                void *ptr, uint64_t imm)
+{
+    plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
+                              0, op, ptr, imm);
+}
+
+
+
+void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
+                                      qemu_plugin_vcpu_mem_cb_t cb,
+                                      enum qemu_plugin_cb_flags flags,
+                                      enum qemu_plugin_mem_rw rw,
+                                      void *udata)
+{
+    plugin_register_vcpu_mem_cb(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR],
+        cb, flags, rw, udata, false);
+}
+
+void qemu_plugin_register_vcpu_mem_haddr_cb(struct qemu_plugin_insn *insn,
+                                            qemu_plugin_vcpu_mem_haddr_cb_t cb,
+                                            enum qemu_plugin_cb_flags flags,
+                                            enum qemu_plugin_mem_rw rw,
+                                            void *udata)
+{
+    plugin_register_vcpu_mem_cb(&insn->cbs[PLUGIN_CB_HADDR][PLUGIN_CB_REGULAR],
+        cb, flags, rw, udata, true);
+}
+
+void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
+                                          enum qemu_plugin_mem_rw rw,
+                                          enum qemu_plugin_op op, void *ptr,
+                                          uint64_t imm)
+{
+    plugin_register_inline_op(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE],
+        rw, op, ptr, imm);
+}
+
+void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
+                                           qemu_plugin_vcpu_tb_trans_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_TB_TRANS, cb);
+}
+
+void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
+                                          qemu_plugin_vcpu_syscall_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL, cb);
+}
+
+void
+qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
+                                         qemu_plugin_vcpu_syscall_ret_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_RET, cb);
+}
+
+/*
+ * Plugin Queries
+ *
+ * These are queries that the plugin can make to gauge information
+ * from our opaque data types. We do not want to leak internal details
+ * here just information useful to the plugin.
+ */
+
+/*
+ * Translation block information:
+ *
+ * A plugin can query the virtual address of the start of the block
+ * and the number of instructions in it. It can also get access to
+ * each translated instruction.
+ */
+
+size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb)
+{
+    return tb->n;
+}
+
+uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
+{
+    return tb->vaddr;
+}
+
+struct qemu_plugin_insn *
+qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
+{
+    if (unlikely(idx >= tb->n)) {
+        return NULL;
+    }
+    return g_ptr_array_index(tb->insns, idx);
+}
+
+/*
+ * Instruction information
+ *
+ * These queries allow the plugin to retrieve information about each
+ * instruction being translated.
+ */
+
+const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn)
+{
+    return insn->data->data;
+}
+
+size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn)
+{
+    return insn->data->len;
+}
+
+uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
+{
+    return insn->vaddr;
+}
+
+void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
+{
+    return insn->haddr;
+}
+
+/*
+ * The memory queries allow the plugin to query information about a
+ * memory access.
+ */
+
+unsigned qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info)
+{
+    return info & TRACE_MEM_SZ_SHIFT_MASK;
+}
+
+bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info)
+{
+    return !!(info & TRACE_MEM_SE);
+}
+
+bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info)
+{
+    return !!(info & TRACE_MEM_BE);
+}
+
+bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
+{
+    return !!(info & TRACE_MEM_ST);
+}
+
+/*
+ * Queries to the number and potential maximum number of vCPUs there
+ * will be. This helps the plugin dimension per-vcpu arrays.
+ */
+
+int qemu_plugin_n_vcpus(void)
+{
+#ifdef CONFIG_USER_ONLY
+    return -1;
+#else
+    return smp_cpus;
+#endif
+}
+
+int qemu_plugin_n_max_vcpus(void)
+{
+#ifdef CONFIG_USER_ONLY
+    return -1;
+#else
+    return max_cpus;
+#endif
+}
-- 
2.20.1


