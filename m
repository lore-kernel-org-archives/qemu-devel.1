Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E06C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FC620738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t60jFHPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FC620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgL2-0002Qu-Ct
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3R-0007ew-2w
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:30 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3N-0001kc-4c
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:28 -0400
Received: by mail-pf1-x442.google.com with SMTP id u20so8301699pfn.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7NCItsGikAjoxCQbtrtcdgvM3OCnFXhPqNO+3OzZ5UY=;
 b=t60jFHPHxGZvsQ/+O0kKL5kPf6mKMjwIKpMaD9YLU4m71eNm9GShaSxNzYl08IHOK9
 sU0fZAB+dxf2ky7fRQ2ES1Ag0QZvAZxINk08Z6UZZl2Gth63UhPPgHrJezunWb50v1hL
 Kt747xTQThHC+dNhqHi/FmdH7+niGG1FaPEfOB0gscQAduRVs74WoZ+KRozG2L/Ux7s1
 fJNL+HLZRDzjP9/nfv0+yMz+QxPr/d18zqPqJloXA2+Za6aqczEuutgMjlv/UkdR0d15
 tlXOieSsAcK92bj1q4rvgS1QnEDpaClZjufdLJzV4YJ/I3tWrHsP3Lzh2kEaBG9qz6j1
 XUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7NCItsGikAjoxCQbtrtcdgvM3OCnFXhPqNO+3OzZ5UY=;
 b=aAghQclWJ63R6KyWv4uZwVG+EQDWDIWBB0cyhijoJx1UxACoTier+dDMw+w8N+wYwz
 mbvBP/UwX8v2/XGOhT8eedjMbM6Wj0twNBg8aISHkjrXq3xjz8J6Tt12714+1bmRZbkb
 3vsaV/afLvtFjW2DRm+Rn1gqoz2YmSfqJCtxKNGHJ1rU/9xWL9tOp6wxpsX+Izrc+8iP
 0v8SCYBLkzcHvkRJSkH0qBjeBdomI05/5c4LeiDQ1kxoOfxr1LEsBynghV+9XSlXvwjx
 S22Ho5EgMkGV7TKPq0pXtm9eY7TP7l+f5ymISp8YJ9U1m/SLSRCCFxOHOFatvRQUM1ng
 IX1A==
X-Gm-Message-State: AOAM533SHj3QT335A3AVSInNplBtgY9j8SZ752KLQ3z2Lj7ELAqHKZwA
 64h+D80x+wWHhgSDnUR7PuEUEb8Vylkwhg==
X-Google-Smtp-Source: ABdhPJxmnjXjeudfsgB8FpE4zxSJCzU4FHi68usjUrAB927UOV3C0uFqKGztLBcLC8AMObQAsMddhA==
X-Received: by 2002:a65:64cb:: with SMTP id t11mr7764581pgv.359.1598389223283; 
 Tue, 25 Aug 2020 14:00:23 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/77] target/microblaze: Tidy mb_tcg_init
Date: Tue, 25 Aug 2020 13:58:57 -0700
Message-Id: <20200825205950.730499-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All of the tcg globals can be recorded in the same table.
Drop the "r" prefix from "rpc" and "rmsr".  Obviates the
need for regnames[], which was incorrectly not const.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 62 +++++++++++++++--------------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9aa63ddcc5..e709884f2d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -95,14 +95,6 @@ typedef struct DisasContext {
     int singlestep_enabled;
 } DisasContext;
 
-static const char *regnames[] =
-{
-    "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
-    "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
-    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
-    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
-};
-
 static inline void t_sync_flags(DisasContext *dc)
 {
     /* Synch the tb dependent flags between translator and runtime.  */
@@ -1846,36 +1838,36 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
 void mb_tcg_init(void)
 {
-    int i;
+#define R(X)  { &cpu_R[X], offsetof(CPUMBState, regs[X]), "r" #X }
+#define SP(X) { &cpu_##X, offsetof(CPUMBState, X), #X }
 
-    cpu_iflags = tcg_global_mem_new_i32(cpu_env,
-                    offsetof(CPUMBState, iflags),
-                    "iflags");
-    cpu_imm = tcg_global_mem_new_i32(cpu_env,
-                    offsetof(CPUMBState, imm),
-                    "imm");
-    cpu_btarget = tcg_global_mem_new_i32(cpu_env,
-                     offsetof(CPUMBState, btarget),
-                     "btarget");
-    cpu_btaken = tcg_global_mem_new_i32(cpu_env,
-                     offsetof(CPUMBState, btaken),
-                     "btaken");
-    cpu_res_addr = tcg_global_mem_new(cpu_env,
-                     offsetof(CPUMBState, res_addr),
-                     "res_addr");
-    cpu_res_val = tcg_global_mem_new_i32(cpu_env,
-                     offsetof(CPUMBState, res_val),
-                     "res_val");
-    for (i = 0; i < ARRAY_SIZE(cpu_R); i++) {
-        cpu_R[i] = tcg_global_mem_new_i32(cpu_env,
-                          offsetof(CPUMBState, regs[i]),
-                          regnames[i]);
+    static const struct {
+        TCGv_i32 *var; int ofs; char name[8];
+    } i32s[] = {
+        R(0),  R(1),  R(2),  R(3),  R(4),  R(5),  R(6),  R(7),
+        R(8),  R(9),  R(10), R(11), R(12), R(13), R(14), R(15),
+        R(16), R(17), R(18), R(19), R(20), R(21), R(22), R(23),
+        R(24), R(25), R(26), R(27), R(28), R(29), R(30), R(31),
+
+        SP(pc),
+        SP(msr),
+        SP(imm),
+        SP(iflags),
+        SP(btaken),
+        SP(btarget),
+        SP(res_val),
+    };
+
+#undef R
+#undef SP
+
+    for (int i = 0; i < ARRAY_SIZE(i32s); ++i) {
+        *i32s[i].var =
+          tcg_global_mem_new_i32(cpu_env, i32s[i].ofs, i32s[i].name);
     }
 
-    cpu_pc =
-        tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, pc), "rpc");
-    cpu_msr =
-        tcg_global_mem_new_i32(cpu_env, offsetof(CPUMBState, msr), "rmsr");
+    cpu_res_addr =
+        tcg_global_mem_new(cpu_env, offsetof(CPUMBState, res_addr), "res_addr");
 }
 
 void restore_state_to_opc(CPUMBState *env, TranslationBlock *tb,
-- 
2.25.1


