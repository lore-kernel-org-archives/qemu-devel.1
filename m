Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0BBC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE25206CD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzRSJzg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE25206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmRG-0002S9-12
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKN-0004Rp-Pk
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:39 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKL-000600-Tx
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:39 -0400
Received: by mail-pg1-x544.google.com with SMTP id p37so839657pgl.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AL0uzCSfOumwHkpirTGBR8ikbqPuw1vczWQqngjG3N0=;
 b=LzRSJzg+9xLDiAfHG2MiCqfHY3rfpM7pRsngkZIBkIxLXE1Z13CuRkrmV2R7gYZdaT
 twX5EQP9nCJVl/VnULtIbP1lwrCTDDY/bzt62WZIi0KyHoiEpdYXkM6Cjyo61CMUmnoX
 FqpeV6jeIdPOiQi7fuC+rk6sh9I5VCRkXQNrPjaz1jWurnj3b2ILvcuYizkp+45N0X5h
 ptxbtNNwJ80gZCppo1N5SNEMYjATF7ku3k5k3q1VIF+f3dWM8000CWEnDh58f/s9x7Wz
 o6hh9+CvW1NxoX5RSZpPp0gWnwSR/E2hkWQnt9El/8l7wAfHZ7TzqDspVWIFhoV3gBnQ
 P1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AL0uzCSfOumwHkpirTGBR8ikbqPuw1vczWQqngjG3N0=;
 b=jsGGUlYFIV0kfGMTEyXIH+IgoAulzaBI/yPdqhCdI7FsXev8sIwAiFamge5zHp5TID
 95zdcgxVS/Hu4T5i3VyCk2Sd06wdO2YCJD4/yQ0jkODGYYq8UFfbVgt79Cmgi34Og+cP
 wkHp4l4KGtTGT3GHeWFr1TFy6Tc0t7pYdXPo6j4cBdZLZCzbh1mQjGm+jNIonjglGCdJ
 XiLZ7QXMP41hoERS/2Lb9JQLNljscHHXSdVCA3mMAe+xNo3S597a9CXiv1ASIuP2R1JO
 ggcpAe4PP9Otl25nVetMSvx7/aP3jb+149ZmZwkjj0plD7hcsRDk8H6A+9PaS/2HkkPy
 9b/w==
X-Gm-Message-State: AOAM531s4BaGEPoEus3+R1m8LLXe3Ljp+FRUSTfmsU5XsG8FL/mS5E/y
 hvi/8OMVZsmE4THOeXD1xVwnxPlGnvAENQ==
X-Google-Smtp-Source: ABdhPJxlBNyy/iT38uKciavKj0A+8MAM04J936ebchAvpQqdBBPl00qF9O73Y7witvaY4NZI1cpyHg==
X-Received: by 2002:a63:1f42:: with SMTP id q2mr1692764pgm.265.1598889996131; 
 Mon, 31 Aug 2020 09:06:36 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/76] target/microblaze: Tidy mb_tcg_init
Date: Mon, 31 Aug 2020 09:05:09 -0700
Message-Id: <20200831160601.833692-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All of the tcg globals can be recorded in the same table.
Drop the "r" prefix from "rpc" and "rmsr".  Obviates the
need for regnames[], which was incorrectly not const.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


