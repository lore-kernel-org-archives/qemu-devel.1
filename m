Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B847BC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8638D206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnEFkAm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8638D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrTE-0005nL-RJ
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45060)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPh-0004l4-OM
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPg-0000Gq-9I
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrPg-0000G4-2v
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id p17so70350835wrf.11
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BnGODuR3Ycz5wS1Vq+gAFUjpRMhPGEguKfmXZgD+ipE=;
 b=xnEFkAm/zWatmrROcSkSEvr63uPFYqEEk3yDbnOK6SwJW68+amL9e+gaCXhGJ7nKh4
 NLHzib3BT7uCP1EEqeLXgmyFER8zK2oJNK+YdF61icDx3hOjxwhkWu+xTFWmwKv8P+fR
 eYswyn+ru1s9xOowYI1p+DqcETTZ+PSJSGyuXp43oWoWsmKO2HeSUKuDf7sAivKQtzFj
 ucjrZN1ZNE/kc97sNfCY37euJ7fGHJD52Hy/SjpZZERS8i9+V4PJ9hvhu0e7Fuyxctgb
 KcNO3hO3Kv86zgvkSthjh/p6tmhJLggn15WI3vlmxyMiAjXxmOmpvu7mlLrHEYe0zx26
 VFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BnGODuR3Ycz5wS1Vq+gAFUjpRMhPGEguKfmXZgD+ipE=;
 b=WwrdBN3hz/EG5Y7CXitkonUsxKlaQmKWCX3fLgUMI004qG7q7v8ckv0mTjcq0FSyPf
 AHk5mrFvAftlHGawOD+1CfPsPI61V09wbOBfl9ZC7DF6CIwX0ayUu+V9B4umtbMJxiJl
 pEGodtlKyqgHC9EMJPbQrgYwX47KsCY4Yuhn6pU9gkrtcBWPqsibzH+CQcJ3BeM9B04D
 lvJO92yc0vhbFXz0Al0zI15eVhS7ogtOj2cSGGyk+QwVJc0ccbXJaoiEGNC7r41w6i5m
 OdG7Hob/VpaomHWjbxzKJ+wBN9j4NY+fo5CwqAT2ms8bl/2taUBF7d41QdOoU8+OPHox
 FOTg==
X-Gm-Message-State: APjAAAUD5nJrOiox82UCAnyjMdmojIuK8ML8IVcEb3iw2b5I3S6aBGeC
 YHzRDglqST9IK08JeJef0A9r9w==
X-Google-Smtp-Source: APXvYqzG0hFrgZLJ/WmOs174TOIh5X5FgoaT1X8dTrw70jFjKYp78d1dosIHTVoIUfRxXliwTtzhbw==
X-Received: by 2002:adf:d08e:: with SMTP id
 y14mr106235925wrh.309.1564590315002; 
 Wed, 31 Jul 2019 09:25:15 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x20sm157165737wrg.10.2019.07.31.09.25.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:25:13 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 09B251FFC7;
 Wed, 31 Jul 2019 17:07:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:14 +0100
Message-Id: <20190731160719.11396-50-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v4 49/54] plugin: add qemu_plugin_insn_disas
 helper
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
Cc: Richard Henderson <richard.henderson@linaro.org>, bobby.prani@gmail.com,
 cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Give the plugins access to the QEMU dissasembler so they don't have to
re-invent the wheel.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c                      | 103 +++++++++++++++++++++++++++++++++++
 include/disas/disas.h        |   2 +
 include/qemu/qemu-plugin.h   |   9 +++
 plugins/api.c                |   7 +++
 plugins/qemu-plugins.symbols |   1 +
 5 files changed, 122 insertions(+)

diff --git a/disas.c b/disas.c
index 3e2bfa572b1..4b127369c36 100644
--- a/disas.c
+++ b/disas.c
@@ -475,6 +475,109 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     }
 }
 
+static GString plugin_disas_output;
+
+static int plugin_printf(FILE *stream, const char *fmt, ...)
+{
+    va_list va;
+    GString *s = &plugin_disas_output;
+    int initial_len = s->len;
+
+    va_start(va, fmt);
+    g_string_append_printf(s, fmt, va);
+    va_end(va);
+
+    return s->len - initial_len;
+}
+
+static void plugin_print_address(bfd_vma addr, struct disassemble_info *info)
+{
+    /* does nothing */
+}
+
+/* Disassemble a single instruction directly into plugin output */
+static
+bool plugin_cap_disas_insn(disassemble_info *info, uint64_t pc, size_t size)
+{
+    uint8_t cap_buf[1024];
+    csh handle;
+    cs_insn *insn;
+    size_t csize = 0;
+    int count;
+    GString *s = &plugin_disas_output;
+
+    if (cap_disas_start(info, &handle) != CS_ERR_OK) {
+        return false;
+    }
+    insn = cap_insn;
+
+    size_t tsize = MIN(sizeof(cap_buf) - csize, size);
+    const uint8_t *cbuf = cap_buf;
+    target_read_memory(pc, cap_buf, tsize, info);
+
+    count = cs_disasm(handle, cbuf, size, 0, 1, &insn);
+
+    if (count) {
+        g_string_printf(s, "%s %s", insn->mnemonic, insn->op_str);
+    } else {
+        g_string_printf(s, "cs_disasm failed");
+    }
+
+    cs_close(&handle);
+    return true;
+}
+
+char * plugin_disas(CPUState *cpu, uint64_t addr, size_t size)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    target_ulong pc;
+    int count;
+    CPUDebug s;
+    GString *ds = g_string_set_size(&plugin_disas_output, 0);
+
+    g_assert(ds == &plugin_disas_output);
+
+    INIT_DISASSEMBLE_INFO(s.info, NULL, plugin_printf);
+
+    s.cpu = cpu;
+    s.info.read_memory_func = target_read_memory;
+    s.info.buffer_vma = addr;
+    s.info.buffer_length = size;
+    s.info.print_address_func = plugin_print_address;
+    s.info.cap_arch = -1;
+    s.info.cap_mode = 0;
+    s.info.cap_insn_unit = 4;
+    s.info.cap_insn_split = 4;
+
+#ifdef TARGET_WORDS_BIGENDIAN
+    s.info.endian = BFD_ENDIAN_BIG;
+#else
+    s.info.endian = BFD_ENDIAN_LITTLE;
+#endif
+
+    if (cc->disas_set_info) {
+        cc->disas_set_info(cpu, &s.info);
+    }
+
+    if (s.info.cap_arch >= 0 && plugin_cap_disas_insn(&s.info, addr, size)) {
+        return g_strdup(ds->str);
+    }
+
+    if (s.info.print_insn == NULL) {
+        s.info.print_insn = print_insn_od_target;
+    }
+
+    for (pc = addr; size > 0; pc += count, size -= count) {
+        count = s.info.print_insn(pc, &s.info);
+        if (count < 0) {
+            break;
+        }
+        g_assert(size >= count);
+    }
+
+    return g_strdup(ds->str);
+}
+
 /* Disassemble this for me please... (debugging). */
 void disas(FILE *out, void *code, unsigned long size)
 {
diff --git a/include/disas/disas.h b/include/disas/disas.h
index 15da511f49c..119df9e9bdf 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -13,6 +13,8 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
 void monitor_disas(Monitor *mon, CPUState *cpu,
                    target_ulong pc, int nb_insn, int is_physical);
 
+char * plugin_disas(CPUState *cpu, uint64_t addr, size_t size);
+
 /* Look up symbol for debugging purpose.  Returns "" if unknown. */
 const char *lookup_symbol(target_ulong orig_addr);
 #endif
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index d9c1ca3b4cf..8b403dd6157 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -324,6 +324,15 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_syscall_ret_cb_t cb);
 
 
+/**
+ * qemu_plugin_insn_disas() - return disassembly string for instruction
+ * @insn: instruction reference
+ *
+ * Returns an allocated string containing the disassembly
+ */
+
+char * qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
+
 /**
  * qemu_plugin_vcpu_for_each() - iterate over the existing vCPU
  * @id: plugin ID
diff --git a/plugins/api.c b/plugins/api.c
index 4b3ac9e31fb..5a0bed1b1e0 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -40,6 +40,7 @@
 #include "sysemu/sysemu.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
+#include "disas/disas.h"
 #include "plugin.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
@@ -211,6 +212,12 @@ void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
     return insn->haddr;
 }
 
+char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn)
+{
+    CPUState *cpu = current_cpu;
+    return plugin_disas(cpu, insn->vaddr, insn->data->len);
+}
+
 /*
  * The memory queries allow the plugin to query information about a
  * memory access.
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 40c0d1abd2f..267ec381b4a 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -25,6 +25,7 @@
   qemu_plugin_insn_size;
   qemu_plugin_insn_vaddr;
   qemu_plugin_insn_haddr;
+  qemu_plugin_insn_disas;
   qemu_plugin_mem_size_shift;
   qemu_plugin_mem_is_sign_extended;
   qemu_plugin_mem_is_big_endian;
-- 
2.20.1


