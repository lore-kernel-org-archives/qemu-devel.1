Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A144FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6818421929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2Jxpa0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6818421929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtkf-00012K-1X
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE6-0003R0-Rv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE5-0008TB-CD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:46556)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtE2-0008Rl-El
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:31 -0400
Received: by mail-wr1-x434.google.com with SMTP id n15so884325wrw.13
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q5qV5/OwW4JapCpipq8SEvEBPISUkxgOpnZmkOYtTHM=;
 b=q2Jxpa0ibGd5EvukN0YQg3eLwITE+qOUEgrhxsNxUKANJ4fMKlEdIL9HVRpGkUG4zL
 TCeOCgbS1XywyZUdHlHuiXQM/8kO5MKZPMHAXWP8gqs+a+pXGCcKXlGYn65QJxqWKUAZ
 flNGqfu262TyQ2MiZxUdVptMtbN8pz4rXGmqwBgebPoXxcbD8b4YX3i/PA4FB6DQwaQq
 wYL6spgmC/wR3WvpHTzrAtP0K02QQ9vU0Opltf2JbZd3CjJj1+/eTdpD329b4vATpYtK
 TehLK6F+84NR7UCVVj3wmYbwE9erP9GwoLvJ3uB7V28yItQWG/tMTsgIINNQi2PCKSOS
 xiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q5qV5/OwW4JapCpipq8SEvEBPISUkxgOpnZmkOYtTHM=;
 b=FzTxAfJGWWfDPSGxNPTh8P2/ghqdnxDUC+S0/a5TuMBeq7OiBt/U09wmeGP0gUT7yo
 gMISZvECsRf8SBP4LjcNrkuhvOcYbUKLXPnmrGpfm65Is44TY0q6IbyZVz/DvTwVhpAT
 YleECsanHIYYYWaSnse2QnAvuxI1N0MO9ycOS4fhEUqTcK5cGc/BvO0u3XDYQRXfXhiL
 EgwI3Oz1DWCQKjUa1LbXKwzW4KvjbMtGREedXu5p7gOr4YU5bPYrs39B794TksUPdhiz
 018bA2OjEPPRzwHQ+k66QnR6U2Lqpm8C9qWzFyM6z+NerJ5m2ykXsLLOxUP+suw5S//t
 58lg==
X-Gm-Message-State: APjAAAXvARBjlZSPSzHS1y1I0vh+o4B/toS2MuO8/IYMeFnMRs+jRd+H
 LYNbKVOh0QBnnoQbn0iFNb1oww==
X-Google-Smtp-Source: APXvYqx2cQ4oYzRTiyutv1cskh2f8RYLmcI1uSj4vQom6hBK2VSniyzRixV0Sr0lS290Ha26A5baFA==
X-Received: by 2002:a5d:444b:: with SMTP id x11mr1268199wrr.207.1571985449121; 
 Thu, 24 Oct 2019 23:37:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u21sm1731116wmu.27.2019.10.24.23.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DDB621FFCE;
 Fri, 25 Oct 2019 07:37:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 55/73] plugin: add qemu_plugin_insn_disas helper
Date: Fri, 25 Oct 2019 07:36:55 +0100
Message-Id: <20191025063713.23374-56-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

Give the plugins access to the QEMU dissasembler so they don't have to
re-invent the wheel. We generate a warning when there are spare bytes
in the decode buffer. This is usually due to the front end loading in
more bytes than decoded.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/disas.c b/disas.c
index 3e2bfa572b1..3937da61571 100644
--- a/disas.c
+++ b/disas.c
@@ -418,6 +418,7 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
 # define cap_disas_target(i, p, s)  false
 # define cap_disas_host(i, p, s)  false
 # define cap_disas_monitor(i, p, c)  false
+# define cap_disas_plugin(i, p, c) false
 #endif /* CONFIG_CAPSTONE */
 
 /* Disassemble this for me please... (debugging).  */
@@ -475,6 +476,115 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     }
 }
 
+static __thread GString plugin_disas_output;
+
+static int plugin_printf(FILE *stream, const char *fmt, ...)
+{
+    va_list va;
+    GString *s = &plugin_disas_output;
+    int initial_len = s->len;
+
+    va_start(va, fmt);
+    g_string_append_vprintf(s, fmt, va);
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
+
+#ifdef CONFIG_CAPSTONE
+/* Disassemble a single instruction directly into plugin output */
+static
+bool cap_disas_plugin(disassemble_info *info, uint64_t pc, size_t size)
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
+#endif
+
+/*
+ * We should only be dissembling one instruction at a time here. If
+ * there is left over it usually indicates the front end has read more
+ * bytes than it needed.
+ */
+char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
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
+    if (s.info.cap_arch >= 0 && cap_disas_plugin(&s.info, addr, size)) {
+        return g_strdup(ds->str);
+    }
+
+    if (s.info.print_insn == NULL) {
+        s.info.print_insn = print_insn_od_target;
+    }
+
+    count = s.info.print_insn(addr, &s.info);
+
+    /* The decoder probably read more than it needed it's not critical */
+    if (count < size) {
+        warn_report("%s: %zu bytes left over", __func__, size - count);
+    }
+
+    return g_strdup(ds->str);
+}
+
 /* Disassemble this for me please... (debugging). */
 void disas(FILE *out, void *code, unsigned long size)
 {
diff --git a/include/disas/disas.h b/include/disas/disas.h
index ba47e9197cd..36c33f6f194 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -14,6 +14,8 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
 void monitor_disas(Monitor *mon, CPUState *cpu,
                    target_ulong pc, int nb_insn, int is_physical);
 
+char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size);
+
 /* Look up symbol for debugging purpose.  Returns "" if unknown. */
 const char *lookup_symbol(target_ulong orig_addr);
 #endif
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 784f1dfc3da..ddf267fbfe0 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -351,6 +351,15 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_syscall_ret_cb_t cb);
 
 
+/**
+ * qemu_plugin_insn_disas() - return disassembly string for instruction
+ * @insn: instruction reference
+ *
+ * Returns an allocated string containing the disassembly
+ */
+
+char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
+
 /**
  * qemu_plugin_vcpu_for_each() - iterate over the existing vCPU
  * @id: plugin ID
diff --git a/plugins/api.c b/plugins/api.c
index 33dac8e790d..5adc4d25a1e 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -39,7 +39,8 @@
 #include "cpu.h"
 #include "sysemu/sysemu.h"
 #include "tcg/tcg.h"
-#include "trace/mem-internal.h" /* mem_info macros */
+#include "exec/exec-all.h"
+#include "disas/disas.h"
 #include "plugin.h"
 #ifndef CONFIG_USER_ONLY
 #include "qemu/plugin-memory.h"
@@ -212,6 +213,12 @@ void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
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


