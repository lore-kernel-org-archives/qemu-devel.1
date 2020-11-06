Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083FDC388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617422072E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bd1BKXve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617422072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasVX-0001HF-Aa
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRP-0004N8-5S
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:31 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRM-0006tw-2m
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:30 -0500
Received: by mail-pf1-x443.google.com with SMTP id 13so51933pfy.4
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pAispzyuoe9bb7pX+t0JNwtc7CrjVyVvkGgTqmJ29zY=;
 b=bd1BKXveBuU//fHZTnIZDLyjtxcrIVGn5jr5DMLBZa95UkDPoPvw9ZG/0zqU8+ozKp
 Bmhu/keZnbhmWvKVtnNAum2iFCjIj99TpIVfCNubgZffGNABsaL7Pvp5pgaOUIXLnpU7
 KS1dEpaJ1aeFhB7PThe+jWnKH0hWR/9Ay7DV7fHF18wEQ5XLGv4vpiSEunmv8/6yzwqg
 k64QnE65/5g7SgKd6Uyv0tG1X4L/Dj6n1T8llcCeu5qNmZnXyfzVL+jyxBCd05tPutGp
 QmUaKXxm5oxSjSaPOinyU/ra/iK6kedtmFECB/JO0bxGddCIamVZFQ9B1PyhUH5C+hOf
 4Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pAispzyuoe9bb7pX+t0JNwtc7CrjVyVvkGgTqmJ29zY=;
 b=cjJMl90gCXhQFa8zXce8Dgtb5ESf9lZVmkMtqAXartM6BkCAO/La71dJI60Onc7UZz
 hnK/ckshWeEamog1DHIpIgl73a3QuTL5qLLrjkzm2vIjYZSBYoiN1PWalBHd5W2g7IPQ
 3vxuPjcLZzjTPmEnX782N+ucwelwR+u0P0aqyVJHi3QzZp2wqugeTI58tO9Crh1JiJ75
 CPMYJHJUrm1MT1gJfBGWz8cjdI0WkP2helXkIOTpyjC7FNQcrl8CllVhGnnAKnw9wnqb
 JlD75SWIo8RODjd+pRmP6X7o2aYjB6rsvRoV0iEvUxfaIummSDmtWOOLnIlM4V4rbsd0
 HWcQ==
X-Gm-Message-State: AOAM532wdFeAtOtcyaf7LO9CExyeBwT7K/JpTxV65ISBSViL3bOPYFRA
 5BDNtP9scQ+yMcJLslmAg3G0qrZRrkOebQ==
X-Google-Smtp-Source: ABdhPJw69TmpVG9uvQtdmOAs1bhScRAW5tQ3GFGciX6X/W3paBl1u7o7Bkv9/M3d5X+VE18Nmt6M2Q==
X-Received: by 2002:aa7:9e90:0:b029:18b:a94:3498 with SMTP id
 p16-20020aa79e900000b029018b0a943498mr5160617pfq.54.1604633365753; 
 Thu, 05 Nov 2020 19:29:25 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/41] tcg: Move tcg prologue pointer out of TCGContext
Date: Thu,  5 Nov 2020 19:28:42 -0800
Message-Id: <20201106032921.600200-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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

This value is constant across all thread-local copies of TCGContext,
so we might as well move it out of thread-local storage.

Use the correct function pointer type, and name the variable
tcg_qemu_tb_exec, which means that we are able to remove the
macro that does the casting.

Replace HAVE_TCG_QEMU_TB_EXEC with CONFIG_TCG_INTERPRETER,
as this is somewhat clearer in intent.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h    | 9 ++++-----
 tcg/tci/tcg-target.h | 2 --
 tcg/tcg.c            | 9 ++++++++-
 tcg/tci.c            | 3 ++-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 8ff9dad4ef..9cc412f90c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -621,7 +621,6 @@ struct TCGContext {
        here, because there's too much arithmetic throughout that relies
        on addition and subtraction working on bytes.  Rely on the GCC
        extension that allows arithmetic on void*.  */
-    void *code_gen_prologue;
     void *code_gen_epilogue;
     void *code_gen_buffer;
     size_t code_gen_buffer_size;
@@ -1222,11 +1221,11 @@ static inline unsigned get_mmuidx(TCGMemOpIdx oi)
 #define TB_EXIT_IDXMAX    1
 #define TB_EXIT_REQUESTED 3
 
-#ifdef HAVE_TCG_QEMU_TB_EXEC
-uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr);
+#ifdef CONFIG_TCG_INTERPRETER
+uintptr_t tcg_qemu_tb_exec(CPUArchState *env, void *tb_ptr);
 #else
-# define tcg_qemu_tb_exec(env, tb_ptr) \
-    ((uintptr_t (*)(void *, void *))tcg_ctx->code_gen_prologue)(env, tb_ptr)
+typedef uintptr_t tcg_prologue_fn(CPUArchState *env, void *tb_ptr);
+extern tcg_prologue_fn *tcg_qemu_tb_exec;
 #endif
 
 void tcg_register_jit(void *buf, size_t buf_size);
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 6460449719..49f3291f8a 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -189,8 +189,6 @@ typedef enum {
 
 void tci_disas(uint8_t opc);
 
-#define HAVE_TCG_QEMU_TB_EXEC
-
 /* Flush the dcache at RW, and the icache at RX, as necessary. */
 static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d5a72c226f..a6f47b033c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -161,6 +161,10 @@ static TCGContext **tcg_ctxs;
 static unsigned int n_tcg_ctxs;
 TCGv_env cpu_env = 0;
 
+#ifndef CONFIG_TCG_INTERPRETER
+tcg_prologue_fn *tcg_qemu_tb_exec;
+#endif
+
 struct tcg_region_tree {
     QemuMutex lock;
     GTree *tree;
@@ -1054,7 +1058,10 @@ void tcg_prologue_init(TCGContext *s)
     s->code_ptr = buf0;
     s->code_buf = buf0;
     s->data_gen_ptr = NULL;
-    s->code_gen_prologue = buf0;
+
+#ifndef CONFIG_TCG_INTERPRETER
+    tcg_qemu_tb_exec = (tcg_prologue_fn *)buf0;
+#endif
 
     /* Compute a high-water mark, at which we voluntarily flush the buffer
        and start over.  The size here is arbitrary, significantly larger
diff --git a/tcg/tci.c b/tcg/tci.c
index 82039fd163..d996eb7cf8 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -475,8 +475,9 @@ static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
 #endif
 
 /* Interpret pseudo code in tb. */
-uintptr_t tcg_qemu_tb_exec(CPUArchState *env, uint8_t *tb_ptr)
+uintptr_t tcg_qemu_tb_exec(CPUArchState *env, void *v_tb_ptr)
 {
+    uint8_t *tb_ptr = v_tb_ptr;
     tcg_target_ulong regs[TCG_TARGET_NB_REGS];
     long tcg_temps[CPU_TEMP_BUF_NLONGS];
     uintptr_t sp_value = (uintptr_t)(tcg_temps + CPU_TEMP_BUF_NLONGS);
-- 
2.25.1


