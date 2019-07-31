Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C425C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361AA206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gp/fli3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361AA206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrCr-0008E3-C9
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40342)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8f-00026n-6A
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8d-0000jn-08
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:41 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8Y-0000go-UM
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id x1so20404420wrr.9
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o8GF3SlglsMFL92PLwLiZiSe0FHvXJ564WFkE3oIhzU=;
 b=Gp/fli3tbsp8d6epoMPjZal+0HiTArcZS8ns7t9hhwLGn+h0at87p9612hT1G9OmzS
 l95zppiBpYe6i0K70QrhInMURG62LgsBAX6JwirHScyk0Rg0lpiyw+A7V+CE0qk4wM3X
 Xh2HdHgWBvhBn/OOwxGbt7sT0ADpKmTO+gO7lvXBe5fQEDw0nQ1YMxadFGGzHMqXH89l
 RXDUmRFT21+JOhnZtoQhB11rwUPu+IBnbNeOXMseuzAYUW+DuKFhTjFQKTglU6fBUog/
 rfUPEcOE+yPqSuIamHwoZFAcvYfvfmPn9QtbZUOkSOwtSqPf84C7dyYQwcJ2EXg+oBe4
 /frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o8GF3SlglsMFL92PLwLiZiSe0FHvXJ564WFkE3oIhzU=;
 b=AfpohDuROkmPTjn2O7SEn6NFLv/UW5/AxUIg+8HBbf9whDPkibH6vVSZfQuJote/ce
 mCTmd1G0mda+J5FLOdpkLNa978jxQPovseXW6hXEGWMCzImnq83UhNgXDQ9PuWwASUPF
 2uDn6elFjkJmkHXe8CuyY8Et0wBI1NKAXrStNlBpHw/DeUMUu56nlsfYAfg288rt2Iuj
 QJ4ZegcwLkMdLmfRB25LS+EfMr4RaXFs1pda2ZrxnAdm6WMZJVtRqy+M1T1w9gmAHJRr
 rlKdr0uVOA3o8+LC0Wq2xwpDepFklZYlTK+2kowI+EMTnd4PwoTP50W9dt7f2ba+9eiF
 W8Ww==
X-Gm-Message-State: APjAAAVV1qZgD+7eZrqC5as8ptjqcnFwL9Y/O1Bb+cDC0kbp/xfbNCe1
 2qIFfjB5E4fDsvivo0e0f3SriQ==
X-Google-Smtp-Source: APXvYqwN22P8fqiqOE9ooT6DKNDgkIsp+UABxnHAq3RRJAWtAEi5mX3XmvWv/jHO7fbNzJbK5/BBAA==
X-Received: by 2002:adf:b64e:: with SMTP id
 i14mr124219409wre.248.1564589250472; 
 Wed, 31 Jul 2019 09:07:30 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f12sm74090173wrg.5.2019.07.31.09.07.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:25 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9829D1FF9C;
 Wed, 31 Jul 2019 17:07:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:38 +0100
Message-Id: <20190731160719.11396-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH  v4 13/54] plugin: add user-facing API
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

From: "Emilio G. Cota" <cota@braap.org>

Add the API first to ease review.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - merge in changes to plugin install/reset/uninstall
  - split api file
v4
  - s/is/it/
  - more docstrings
  - remove qemu_plugin_register_vcpu_mem_haddr_cb and related bits
  - add qemu_plugin_get_hwaddr and related bits
  - drop vcpu_index from tb_trans_cb_t
---
 include/qemu/qemu-plugin.h | 351 +++++++++++++++++++++++++++++++++++++
 1 file changed, 351 insertions(+)
 create mode 100644 include/qemu/qemu-plugin.h

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
new file mode 100644
index 00000000000..d9c1ca3b4cf
--- /dev/null
+++ b/include/qemu/qemu-plugin.h
@@ -0,0 +1,351 @@
+/*
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * Copyright (C) 2019, Linaro
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_PLUGIN_API_H
+#define QEMU_PLUGIN_API_H
+
+#include <inttypes.h>
+#include <stdbool.h>
+
+/*
+ * For best performance, build the plugin with -fvisibility=hidden so that
+ * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
+ * QEMU_PLUGIN_EXPORT. For more info, see
+ *   https://gcc.gnu.org/wiki/Visibility
+ */
+#if defined _WIN32 || defined __CYGWIN__
+  #ifdef BUILDING_DLL
+    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
+  #else
+    #define QEMU_PLUGIN_EXPORT __declspec(dllimport)
+  #endif
+  #define QEMU_PLUGIN_LOCAL
+#else
+  #if __GNUC__ >= 4
+    #define QEMU_PLUGIN_EXPORT __attribute__((visibility("default")))
+    #define QEMU_PLUGIN_LOCAL  __attribute__((visibility("hidden")))
+  #else
+    #define QEMU_PLUGIN_EXPORT
+    #define QEMU_PLUGIN_LOCAL
+  #endif
+#endif
+
+typedef uint64_t qemu_plugin_id_t;
+
+/**
+ * qemu_plugin_install() - Install a plugin
+ * @id: this plugin's opaque ID
+ * @argc: number of arguments
+ * @argv: array of arguments (@argc elements)
+ *
+ * All plugins must export this symbol.
+ *
+ * Note: Calling qemu_plugin_uninstall() from this function is a bug. To raise
+ * an error during install, return !0.
+ *
+ * Note: @argv remains valid throughout the lifetime of the loaded plugin.
+ */
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
+                                           char **argv);
+
+/*
+ * Prototypes for the various callback styles we will be registering
+ * in the following functions.
+ */
+typedef void (*qemu_plugin_simple_cb_t)(qemu_plugin_id_t id);
+
+typedef void (*qemu_plugin_udata_cb_t)(qemu_plugin_id_t id, void *userdata);
+
+typedef void (*qemu_plugin_vcpu_simple_cb_t)(qemu_plugin_id_t id,
+                                             unsigned int vcpu_index);
+
+typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
+                                            void *userdata);
+
+/**
+ * qemu_plugin_uninstall() - Uninstall a plugin
+ * @id: this plugin's opaque ID
+ * @cb: callback to be called once the plugin has been removed
+ *
+ * Do NOT assume that the plugin has been uninstalled once this function
+ * returns. Plugins are uninstalled asynchronously, and therefore the given
+ * plugin receives callbacks until @cb is called.
+ *
+ * Note: Calling this function from qemu_plugin_install() is a bug.
+ */
+void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
+
+/**
+ * qemu_plugin_reset() - Reset a plugin
+ * @id: this plugin's opaque ID
+ * @cb: callback to be called once the plugin has been reset
+ *
+ * Unregisters all callbacks for the plugin given by @id.
+ *
+ * Do NOT assume that the plugin has been reset once this function returns.
+ * Plugins are reset asynchronously, and therefore the given plugin receives
+ * callbacks until @cb is called.
+ */
+void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU is initialized.
+ *
+ * See also: qemu_plugin_register_vcpu_exit_cb()
+ */
+void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_exit_cb() - register a vCPU exit callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU exits.
+ *
+ * See also: qemu_plugin_register_vcpu_init_cb()
+ */
+void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_idle_cb() - register a vCPU idle callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU idles.
+ */
+void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
+                                       qemu_plugin_vcpu_simple_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_resume_cb() - register a vCPU resume callback
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a vCPU resumes execution.
+ */
+void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
+                                         qemu_plugin_vcpu_simple_cb_t cb);
+
+/*
+ * Opaque types that the plugin is given during the translation and
+ * instrumentation phase.
+ */
+struct qemu_plugin_tb;
+struct qemu_plugin_insn;
+
+enum qemu_plugin_cb_flags {
+    QEMU_PLUGIN_CB_NO_REGS, /* callback does not access the CPU's regs */
+    QEMU_PLUGIN_CB_R_REGS,  /* callback reads the CPU's regs */
+    QEMU_PLUGIN_CB_RW_REGS, /* callback reads and writes the CPU's regs */
+};
+
+enum qemu_plugin_mem_rw {
+    QEMU_PLUGIN_MEM_R = 1,
+    QEMU_PLUGIN_MEM_W,
+    QEMU_PLUGIN_MEM_RW,
+};
+
+/**
+ * qemu_plugin_register_vcpu_tb_trans_cb() - register a translate cb
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called every time a translation occurs. The @cb
+ * function is passed an opaque qemu_plugin_type which it can query
+ * for additional information including the list of translated
+ * instructions. At this point the plugin can register further
+ * callbacks to be triggered when the block or individual instruction
+ * executes.
+ */
+typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
+                                               struct qemu_plugin_tb *tb);
+
+void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
+                                           qemu_plugin_vcpu_tb_trans_cb_t cb);
+
+/**
+ * qemu_plugin_register_vcpu_tb_trans_exec_cb() - register execution callback
+ * @tb: the opaque qemu_plugin_tb handle for the translation
+ * @cb: callback function
+ * @flags: does the plugin read or write the CPU's registers?
+ * @userdata: any plugin data to pass to the @cb?
+ *
+ * The @cb function is called every time a translated unit executes.
+ */
+void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
+                                          qemu_plugin_vcpu_udata_cb_t cb,
+                                          enum qemu_plugin_cb_flags flags,
+                                          void *userdata);
+
+enum qemu_plugin_op {
+    QEMU_PLUGIN_INLINE_ADD_U64,
+};
+
+/**
+ * qemu_plugin_register_vcpu_tb_trans_exec_inline() - execution inline op
+ * @tb: the opaque qemu_plugin_tb handle for the translation
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @ptr: the target memory location for the op
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op to every time a translated unit executes.
+ * Useful if you just want to increment a single counter somewhere in
+ * memory.
+ */
+void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
+                                              enum qemu_plugin_op op,
+                                              void *ptr, uint64_t imm);
+
+/**
+ * qemu_plugin_register_vcpu_insn_exec_cb() - register insn execution cb
+ * @insn: the opaque qemu_plugin_insn handle for an instruction
+ * @cb: callback function
+ * @flags: does the plugin read or write the CPU's registers?
+ * @userdata: any plugin data to pass to the @cb?
+ *
+ * The @cb function is called every time an instruction is executed
+ */
+void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
+                                            qemu_plugin_vcpu_udata_cb_t cb,
+                                            enum qemu_plugin_cb_flags flags,
+                                            void *userdata);
+
+/**
+ * qemu_plugin_register_vcpu_insn_exec_inline() - insn execution inline op
+ * @insn: the opaque qemu_plugin_insn handle for an instruction
+ * @cb: callback function
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @ptr: the target memory location for the op
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op to every time an instruction executes. Useful
+ * if you just want to increment a single counter somewhere in memory.
+ */
+void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
+                                                enum qemu_plugin_op op,
+                                                void *ptr, uint64_t imm);
+
+/*
+ * Helpers to query information about the instructions in a block
+ */
+size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
+
+uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb);
+
+struct qemu_plugin_insn *
+qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
+
+const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);
+
+size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn);
+
+uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn);
+void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);
+
+/*
+ * Memory Instrumentation
+ *
+ * The anonymous qemu_plugin_meminfo_t and qemu_plugin_hwaddr types
+ * can be used in queries to QEMU to get more information about a
+ * given memory access.
+ */
+typedef uint32_t qemu_plugin_meminfo_t;
+struct qemu_plugin_hwaddr;
+
+/* meminfo queries */
+unsigned int qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info);
+bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info);
+bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
+bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
+
+/*
+ * qemu_plugin_get_hwaddr():
+ * @vaddr: the virtual address of the memory operation
+ *
+ * For system emulation returns a qemu_plugin_hwaddr handle to query
+ * details about the actual physical address backing the virtual
+ * address. For linux-user guests it just returns NULL.
+ *
+ * This handle is *only* valid for the duration of the callback. Any
+ * information about the handle should be recovered before the
+ * callback returns.
+ */
+struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+                                                  uint64_t vaddr);
+
+bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr);
+uint64_t qemu_plugin_hwaddr_to_raddr(const struct qemu_plugin_hwaddr *haddr);
+
+typedef void
+(*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
+                             qemu_plugin_meminfo_t info, uint64_t vaddr,
+                             void *userdata);
+
+void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
+                                      qemu_plugin_vcpu_mem_cb_t cb,
+                                      enum qemu_plugin_cb_flags flags,
+                                      enum qemu_plugin_mem_rw rw,
+                                      void *userdata);
+
+void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
+                                          enum qemu_plugin_mem_rw rw,
+                                          enum qemu_plugin_op op, void *ptr,
+                                          uint64_t imm);
+
+
+
+typedef void
+(*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
+                                 int64_t num, uint64_t a1, uint64_t a2,
+                                 uint64_t a3, uint64_t a4, uint64_t a5,
+                                 uint64_t a6, uint64_t a7, uint64_t a8);
+
+void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
+                                          qemu_plugin_vcpu_syscall_cb_t cb);
+
+typedef void
+(*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_idx,
+                                     int64_t num, int64_t ret);
+
+void
+qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
+                                         qemu_plugin_vcpu_syscall_ret_cb_t cb);
+
+
+/**
+ * qemu_plugin_vcpu_for_each() - iterate over the existing vCPU
+ * @id: plugin ID
+ * @cb: callback function
+ *
+ * The @cb function is called once for each existing vCPU.
+ *
+ * See also: qemu_plugin_register_vcpu_init_cb()
+ */
+void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
+                               qemu_plugin_vcpu_simple_cb_t cb);
+
+void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
+                                   qemu_plugin_simple_cb_t cb);
+
+void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
+                                    qemu_plugin_udata_cb_t cb, void *userdata);
+
+/* returns -1 in user-mode */
+int qemu_plugin_n_vcpus(void);
+
+/* returns -1 in user-mode */
+int qemu_plugin_n_max_vcpus(void);
+
+#endif /* QEMU_PLUGIN_API_H */
-- 
2.20.1


