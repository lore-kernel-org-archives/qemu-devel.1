Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B870EC4742C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2588C20729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTH1vMnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2588C20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasTA-0006Gx-AP
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRP-0004Nr-Ro
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:31 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRO-0006uE-7N
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:31 -0500
Received: by mail-pg1-x544.google.com with SMTP id i7so2880472pgh.6
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kjsZwqo16wWQgyXnGfAD2sB/J/+jiHAWTHwjAIw7NfU=;
 b=ZTH1vMnki1p5vmUOBjZzTzJM7NUOdveFifsjKnIo5PB2GuTdYJTA1vCSgtNv3SUw4R
 M3LjWPLD52N/0mPrvglxPepdDyOZ0s1ykWw3MSLdM6wwdbtfCdsJE8wX8qJkTVXU4iaG
 5yVOHwkO+XED8+9YkLh4bYM/4zcnmAs9a9NWGm2lbvEb6xGyT4AHIRe5Fro4B0l8h5z5
 SZM9QdM04FOTivgIU/zqRyfWyDSAupDgKurqRjRN1vjYdVxRuMMoMZRpsba+G97e0i3L
 zIolhk118ZNbB48awBa1LyFW30S2RVdlOeJDgBYNWk7I7OfC/RlmRvQKRiWDhCIR6xfI
 ob9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kjsZwqo16wWQgyXnGfAD2sB/J/+jiHAWTHwjAIw7NfU=;
 b=KGk8Z30ieUKbNAhoNuxCFUy8mHic76q0rKlGuKEDfXoomR3t4dbeYaHcIUvglCdxEv
 aiHsBGHNFt+y7f9y6NhmLPfzQw4tLO6iM/+PL1G/n61MtA7kOnx8eaf/QfQfvW2HL3Sr
 KJEYja0XKUtQitWLrBfOBBLdTG8fONtIBNFoBLOfzy+BUEFVVyTA9V79fZb7Q0zPdeZ+
 W7R3VDGYwpStzHZY0+JqfMOEE8SgazCDCWS5ZESxAKJgyk+vBx7kRmAz5AUGjfs6gI7+
 edJqfOGlm5l0wGs58I4k3mWz0iWs+V5oUCKjc7Vn8GOYbaknub7uY6IYTuanHtcaRIZ6
 IC0w==
X-Gm-Message-State: AOAM533sy5cd50zTwGkljn1/MXdf7wybtU0YCIwCzXwr53Jz8zK0evEp
 Nx7y22I9BTqoKM/MC86Vdf6q83sevqa7ZQ==
X-Google-Smtp-Source: ABdhPJxFHQGOc3dY4qjXzdw/JdPbL2A0630inlRe2f6Pmob4YKhhhNempPn21/LWdw4actCCUZNA/A==
X-Received: by 2002:a17:90a:d082:: with SMTP id
 k2mr128978pju.195.1604633368541; 
 Thu, 05 Nov 2020 19:29:28 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/41] tcg: Add in_code_gen_buffer
Date: Thu,  5 Nov 2020 19:28:44 -0800
Message-Id: <20201106032921.600200-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a function to determine if a pointer is within the buffer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h         |  6 ++++++
 accel/tcg/translate-all.c | 26 ++++++++------------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index bb1e97b13b..e4d0ace44b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -680,6 +680,12 @@ extern __thread TCGContext *tcg_ctx;
 extern void *tcg_code_gen_epilogue;
 extern TCGv_env cpu_env;
 
+static inline bool in_code_gen_buffer(const void *p)
+{
+    const TCGContext *s = &tcg_init_ctx;
+    return (size_t)(p - s->code_gen_buffer) <= s->code_gen_buffer_size;
+}
+
 static inline size_t temp_idx(TCGTemp *ts)
 {
     ptrdiff_t n = ts - tcg_ctx->temps;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 4572b4901f..744f97a717 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -392,27 +392,18 @@ void tb_destroy(TranslationBlock *tb)
 
 bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc, bool will_exit)
 {
-    TranslationBlock *tb;
-    bool r = false;
-    uintptr_t check_offset;
-
-    /* The host_pc has to be in the region of current code buffer. If
-     * it is not we will not be able to resolve it here. The two cases
-     * where host_pc will not be correct are:
+    /*
+     * The host_pc has to be in the region of the code buffer.
+     * If it is not we will not be able to resolve it here.
+     * The two cases where host_pc will not be correct are:
      *
      *  - fault during translation (instruction fetch)
      *  - fault from helper (not using GETPC() macro)
      *
      * Either way we need return early as we can't resolve it here.
-     *
-     * We are using unsigned arithmetic so if host_pc <
-     * tcg_init_ctx.code_gen_buffer check_offset will wrap to way
-     * above the code_gen_buffer_size
      */
-    check_offset = host_pc - (uintptr_t) tcg_init_ctx.code_gen_buffer;
-
-    if (check_offset < tcg_init_ctx.code_gen_buffer_size) {
-        tb = tcg_tb_lookup(host_pc);
+    if (in_code_gen_buffer((const void *)host_pc)) {
+        TranslationBlock *tb = tcg_tb_lookup(host_pc);
         if (tb) {
             cpu_restore_state_from_tb(cpu, tb, host_pc, will_exit);
             if (tb_cflags(tb) & CF_NOCACHE) {
@@ -421,11 +412,10 @@ bool cpu_restore_state(CPUState *cpu, uintptr_t host_pc, bool will_exit)
                 tcg_tb_remove(tb);
                 tb_destroy(tb);
             }
-            r = true;
+            return true;
         }
     }
-
-    return r;
+    return false;
 }
 
 static void page_init(void)
-- 
2.25.1


