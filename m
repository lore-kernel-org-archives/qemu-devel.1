Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1376C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531CB21D1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 00:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PA8dBs8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531CB21D1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHc2l-0002X1-DX
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 20:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHbwc-0002fC-UR
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:02:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHbwa-0004CB-FQ
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 20:02:06 -0400
Received: by mail-pg1-x541.google.com with SMTP id 34so10058826pgo.13
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 17:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=inMfli2pDbU3kA4lojjL53bmShI2QMyc74Hc7w0ZLmA=;
 b=PA8dBs8AR+0g73MQhP0H29Dw0WnCWu1lFOGv5y8V9rbotwTNmZPNczXYCg1fCgvYvL
 4V9XU7BJw4J1THaMWJr15wMis8Hg2LkQ2oSoD1sBdIE33TkmE0YI1J/9BBjaxdkaLhGJ
 acZ5VnGot+swtU76I431Fc/zP6MYx8MAKTsUwiZLHjZoT3YKCi9MHO0Wkk7pPp/u4oTQ
 amzR7OtNLwREWll2BYB/5ztch7BTvEv+tlmlhYcT6FMhd2PC6U0qyPtd/iU7m8PeqtsM
 +w23+9b7g8rDN8gOdmGRIu1kgsfaWp/Nh55HumyNEMGRdNNyzlGfsq/m89gE3ckkfHIW
 Z+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=inMfli2pDbU3kA4lojjL53bmShI2QMyc74Hc7w0ZLmA=;
 b=qJXdQX06rSdEg84TCHnkf5mrMQFL4PlqmV36Tihnru43wZ1wnYkZTDwTlVwRlQdT73
 zLUF4UNHosTPRqNzqOlj6oN5DEVYV5Aby24qfm/a48whvjd8C4OkZp/LACV8gTDMa5Nb
 D04S4w9zject3C51bT3MzeEk6nAFDL/u418GLQ1bYPHBhE7Na2k12VVMB5AsO4427OSL
 5Dx5K2HqRMTh5Ee2V+jQLokpc8cgIJX04QMCNReb3dMFRsrLsf0BKvUQPloUbSO52+8I
 YcVVjnSdhj7pnfHVc4246i3vbrbEPdx+jmTqyOu+JYqP1ebW0oR99oni4f8E3s2wRV4n
 CADg==
X-Gm-Message-State: AOAM5314hRX54EE6pdI93nBceDD/MVx7ZmhhdFzJIcURyvwdCWpOrgYQ
 apnsDmM/BC22J48voISBiwcAObg+LwRKhA==
X-Google-Smtp-Source: ABdhPJwmJ8Vo1qiME16/LKOV1qSRjDo1b9/nYsc/IBeK3fgsXqrYcOsZZHX9Km7g51wtKIdDkPzK5w==
X-Received: by 2002:a63:1925:: with SMTP id z37mr1984764pgl.23.1600041722760; 
 Sun, 13 Sep 2020 17:02:02 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 31sm6538252pgs.59.2020.09.13.17.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 17:02:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/11] disas: Cleanup plugin_disas
Date: Sun, 13 Sep 2020 17:01:48 -0700
Message-Id: <20200914000153.1725632-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914000153.1725632-1-richard.henderson@linaro.org>
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com
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
index 20fad6aabb..ed9965c32f 100644
--- a/disas.c
+++ b/disas.c
@@ -498,13 +498,12 @@ void target_disas(FILE *out, CPUState *cpu, target_ulong code,
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
@@ -524,28 +523,20 @@ static void plugin_print_address(bfd_vma addr, struct disassemble_info *info)
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
@@ -560,34 +551,26 @@ bool cap_disas_plugin(disassemble_info *info, uint64_t pc, size_t size)
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


