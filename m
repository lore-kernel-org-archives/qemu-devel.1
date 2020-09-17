Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9DBC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AA520795
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEDHUqBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AA520795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ3qU-0000TD-5M
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 20:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mO-0003nx-V2
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:32 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mN-0006er-3E
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:32 -0400
Received: by mail-pl1-x644.google.com with SMTP id j7so1982123plk.11
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AcobOMV5CV8pSJwR9n+sDy8pDWv6IjgjNuunOfxWOco=;
 b=pEDHUqBrU6q5a/sS3cYJpf2ubqxocJK1ib0B7QJW0v5XVdX8SVJhJx9I1A8hqe9t7Z
 +UTbeB8hWLudH3/HNhsQ23UD8IW7wvEd9rx3JGEsll2OJ/eZ6Z/j4Dlu51yU1mC+QdMS
 jJoDCdVEZCQvx57qXIgi6tBVumGKh/IQqkFnSKLjyXgM0R6Fj1OmjwYJ3TSFTsMBgqNf
 Lklg4ovZ4e+Z/TC510u3BJ9RHE/3DJgQiUSuSLAJU3UzgK2O3UAn2jE+V9ZWpgeoorh3
 jrPaUqGZAHo2OTu8vwvt3MpvelxcS+Bd1x06K9bcuWKdrPpdEl3acTppnES1PsCNTk7x
 b+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AcobOMV5CV8pSJwR9n+sDy8pDWv6IjgjNuunOfxWOco=;
 b=DsMEiuPXUuxEoudXuKYoWgAk+BUgv7ni9ZfyYafE/bizEZ3bXH40MpyB8hYgfq8p4S
 piFT9E0ELSIzq49N1RGD4MQTZ1fJ2xFj0vmXF6AzCy1hHc7amHiTXAPqtyEoyCpAmKGm
 1iJp1aNHdym3fZ5xUAFjJ4z9X3j6QP6YFtDfqCY+NcsDPeSJOwWRbfpIzWVKUIAdi2W0
 9MgARYme2wfUPlYQd4e5WtLzCkqizLz4+UBGuICm569di6YQtMHhkvwperoAif6kwLbA
 HYwtnkB+QjAIDJDLGrsGPHg8/m6udzhjfZk3R0zc9JZnf+Etie3QDJSOdCZqsOH8ghKU
 3pGQ==
X-Gm-Message-State: AOAM532oj0ftGomSsXpJ6Mtw7PA2d0w7ZCaT7n3oXCnvIwbpEX6Cj0mu
 jhWzF5mlqcDMDylK1iJM5bqm1lSnvCnNFQ==
X-Google-Smtp-Source: ABdhPJyP1P9V+zDgJ05lzW5VVvjMJkDWu7IDAxDP2blf/fYLYwpYQYUbFDI6nMmJerwRDqiDWSZizg==
X-Received: by 2002:a17:902:8bc2:b029:d0:cbe1:e7a6 with SMTP id
 r2-20020a1709028bc2b02900d0cbe1e7a6mr30779035plo.23.1600387049432; 
 Thu, 17 Sep 2020 16:57:29 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m13sm772699pfk.103.2020.09.17.16.57.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 16:57:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/10] disas: Cleanup plugin_disas
Date: Thu, 17 Sep 2020 16:57:16 -0700
Message-Id: <20200917235720.2685978-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917235720.2685978-1-richard.henderson@linaro.org>
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not retain a GString in thread-local storage.  Allocate a
new one and free it on every invocation.  Do not g_strdup the
result; return the buffer from the GString.  Do not use
warn_report.

Using cs_disasm allocated memory via the &insn parameter, but
that was never freed.  Use cs_disasm_iter so that we use the
memory that we've already allocated, and so that we only try
to disassemble one insn, as desired.  Do not allocate 1k to
hold the bytes for a single instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 55 +++++++++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 36 deletions(-)

diff --git a/disas.c b/disas.c
index bf19b1b0bf..d0ccd4b727 100644
--- a/disas.c
+++ b/disas.c
@@ -491,13 +491,12 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
     }
 }
 
-static __thread GString plugin_disas_output;
-
 static int plugin_printf(FILE *stream, const char *fmt, ...)
 {
-    va_list va;
-    GString *s = &plugin_disas_output;
+    /* We abuse the FILE parameter to pass a GString. */
+    GString *s = (GString *)stream;
     int initial_len = s->len;
+    va_list va;
 
     va_start(va, fmt);
     g_string_append_vprintf(s, fmt, va);
@@ -517,28 +516,20 @@ static void plugin_print_address(bfd_vma addr, struct disassemble_info *info)
 static
 bool cap_disas_plugin(disassemble_info *info, uint64_t pc, size_t size)
 {
-    uint8_t cap_buf[1024];
+    uint8_t cap_buf[64];
+    const uint8_t *cbuf = cap_buf;
     csh handle;
-    cs_insn *insn;
-    size_t csize = 0;
-    int count;
-    GString *s = &plugin_disas_output;
 
     if (cap_disas_start(info, &handle) != CS_ERR_OK) {
         return false;
     }
-    insn = cap_insn;
 
-    size_t tsize = MIN(sizeof(cap_buf) - csize, size);
-    const uint8_t *cbuf = cap_buf;
-    target_read_memory(pc, cap_buf, tsize, info);
+    assert(size < sizeof(cap_buf));
+    target_read_memory(pc, cap_buf, size, info);
 
-    count = cs_disasm(handle, cbuf, size, 0, 1, &insn);
-
-    if (count) {
-        g_string_printf(s, "%s %s", insn->mnemonic, insn->op_str);
-    } else {
-        g_string_printf(s, "cs_disasm failed");
+    if (cs_disasm_iter(handle, &cbuf, &size, &pc, cap_insn)) {
+        GString *s = (GString *)info->stream;
+        g_string_printf(s, "%s %s", cap_insn->mnemonic, cap_insn->op_str);
     }
 
     cs_close(&handle);
@@ -553,34 +544,26 @@ bool cap_disas_plugin(disassemble_info *info, uint64_t pc, size_t size)
  */
 char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size)
 {
-    int count;
     CPUDebug s;
-    GString *ds = g_string_set_size(&plugin_disas_output, 0);
-
-    g_assert(ds == &plugin_disas_output);
+    GString *ds = g_string_new(NULL);
 
     initialize_debug_target(&s, cpu);
     s.info.fprintf_func = plugin_printf;
+    s.info.stream = (FILE *)ds;  /* abuse this slot */
     s.info.buffer_vma = addr;
     s.info.buffer_length = size;
     s.info.print_address_func = plugin_print_address;
 
     if (s.info.cap_arch >= 0 && cap_disas_plugin(&s.info, addr, size)) {
-        return g_strdup(ds->str);
+        ; /* done */
+    } else if (s.info.print_insn) {
+        s.info.print_insn(addr, &s.info);
+    } else {
+        ; /* cannot disassemble -- return empty string */
     }
 
-    if (s.info.print_insn == NULL) {
-        s.info.print_insn = print_insn_od_target;
-    }
-
-    count = s.info.print_insn(addr, &s.info);
-
-    /* The decoder probably read more than it needed it's not critical */
-    if (count < size) {
-        warn_report("%s: %zu bytes left over", __func__, size - count);
-    }
-
-    return g_strdup(ds->str);
+    /* Return the buffer, freeing the GString container.  */
+    return g_string_free(ds, false);
 }
 
 /* Disassemble this for me please... (debugging). */
-- 
2.25.1


