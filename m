Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60808C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A1320757
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0AIHXOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A1320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHxZ5-0007H2-0N
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 19:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxUO-00012j-3L
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:02:24 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxUM-0006b3-72
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:02:23 -0400
Received: by mail-pj1-x1041.google.com with SMTP id a9so731746pjg.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AcobOMV5CV8pSJwR9n+sDy8pDWv6IjgjNuunOfxWOco=;
 b=E0AIHXOfc+KszyOAXsqWe4Yqsnce762fYysQsa0NINDAM2ugUuwiD2BoS3BWpOQGiJ
 xh85DanQ2RpccU2mh9R8AOkyhT3Ii3B175EIhguDvRpUVKazN8yRhdRvd22glOzGh03T
 L58Urw5EMA1Ae/Mme6xzArsNO4SLdWD8seqpVXHFi05VThB3VL6yk8wt61b5/VcAW48A
 0dusX2M77iU4MqZ6RH7ZSnwraFWRoQ+Ciz2pGqKJXdNx5CXTRJKYI8yCBZo39RaLarpe
 QlUu6ose14s/Z23TWsAPvwEW5CtsbukruKOLix/DOX2s8pNMz4E5YFoIgbTT9EOStZ5C
 iwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AcobOMV5CV8pSJwR9n+sDy8pDWv6IjgjNuunOfxWOco=;
 b=GMBfuXYKDzu2mgwFBTaIk9iBRH6RpJyL4BPW4Sl2HdHZykqZK0prh0ruHJvqxWk3Vb
 UVJED5cAZrl4MVVbmsyz1OJXCTkVYOjShQLerBrg4OnCsgck/lFjUx2UGiCfuV4BFyMK
 TlGtEixBpG4RyoNxXWu3sJ7jEUslm3OWInI+H7vfiugkkJI5JEbN0x4lxA90I20SvRMB
 Y6+etf0FvSDAyoBGsuexqHWMWWmUOfSYcMImMuIoD1KE4z1WZjt0BEyKKoHPAnqJX6ur
 bwHwjo67cKF1c3uM73TO50eo5n02o/dinQtVNdFx5KiZYDEWegkeFGSk7rXHkvG0pow7
 rl+A==
X-Gm-Message-State: AOAM530KoMB3eIn0k/JHi/k2P07oBFCzFbwwm44uTOOFGBKi25KWqQwV
 zB1xR7CHVWwqku0yYxfrK2Nd0++1cTyJsQ==
X-Google-Smtp-Source: ABdhPJxFM0sBC086ye8+LV68B1Vc+bwrAIp98x0AHeOw7Ik5nyerC9ICImu21ViGSKPNZW3D/aSd0g==
X-Received: by 2002:a17:902:d711:b029:d1:c6b5:ae5f with SMTP id
 w17-20020a170902d711b02900d1c6b5ae5fmr7567556ply.38.1600124540498; 
 Mon, 14 Sep 2020 16:02:20 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm9106076pgt.16.2020.09.14.16.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 16:02:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/10] disas: Cleanup plugin_disas
Date: Mon, 14 Sep 2020 16:02:06 -0700
Message-Id: <20200914230210.2185860-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914230210.2185860-1-richard.henderson@linaro.org>
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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


