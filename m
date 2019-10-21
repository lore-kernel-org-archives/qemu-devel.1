Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045E4CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 22:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00B720882
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 22:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtpcWXGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00B720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMgNB-0006vL-CY
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 18:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iMgJ7-0001Zs-Dm
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iMgJ5-0000yx-UO
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:37:45 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iMgJ5-0000yc-ON
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 18:37:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id t16so10605043wrr.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 15:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xQcT6lJDAnxnyOR9LE4FI1x69eqswuMffbSPTPns70U=;
 b=YtpcWXGi2eC8peqOK1KmZ9o9T11dQBmTtuRveH9mN5M5EZ2W+iQ1BPSlLPe8wWdXHd
 SevS2cyPlLtzH4MPZ/fAhmpFQjrKyK8g4r9KrkaWZwzLAJfZgB3I6/fyYF4ZF8uStoyc
 CoLbdaGzZjZOQDhBT08eQ8Hzr8KAHmaxzXWyNV1txH2XXTV0w++nuDfIyNKlM+2PhTRZ
 R/OMPNPXtZaUeMpds+HsPPjQWG/aQ5FKel5rkXDiq5LEUJIzDfSjV1n4WYdjrpfRN9PQ
 mCZqQca2i0AgfiLC3F4tuLG0ZusWkzN2J5oU+YALVdS4j9I39iPF/UpF7/CK8R6IhCCF
 8zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xQcT6lJDAnxnyOR9LE4FI1x69eqswuMffbSPTPns70U=;
 b=cGjKXf2YYfrGs6LbSsWoUUaOyWEofdyMzVgz2rhrQaLdTVMgKKrxdj9HjX96FucH7U
 bsQw0iVSsPsZaqRPEeqzjMgQ7dtIcCOUMCGuoSjTqhkqPGy7HYJoB7YUNvn7ON3JqZRA
 3iOHgTGhzX0ExBFgEXHfBfi/k9xSwR35/i0JRCGfJ7NWwE5wx53xpV3R1z2itNDmxj2A
 4lu4jAMndeuD+DNWfUFEJ0O3iyHK/WfsAQBB92XlnJSOBUoocTaGwr+zoZfRyFnR4tzs
 jA3SNl4NMwdQkH5+o66iyda7yLDU/Z1uKfN/+u/+1ZVf+zETlaKiQvawAXZcahyBSH4t
 HwKg==
X-Gm-Message-State: APjAAAWpTHs3KjU24C/XkTus76bDS3a950yhOfT1E8DOMKqTrF3wN/6h
 jKO8a/bwkZuYZHDgfSt9tsquwqmd1tzs+Q==
X-Google-Smtp-Source: APXvYqy7YHbw4xRSNrfFFUNQzxBgQ5YevM0jBmDfzWfSxqLUSp5FDFVvA9oAZQ0MwlJsTFQSyN/aig==
X-Received: by 2002:a5d:4d85:: with SMTP id b5mr479217wru.248.1571697462312;
 Mon, 21 Oct 2019 15:37:42 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-50-254.red.bezeqint.net. [109.65.50.254])
 by smtp.gmail.com with ESMTPSA id q66sm16951271wme.39.2019.10.21.15.37.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 21 Oct 2019 15:37:41 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v33 04/13] target/avr: Add instruction translation - Registers
 definition
Date: Tue, 22 Oct 2019 01:37:02 +0300
Message-Id: <20191021223711.66955-5-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191021223711.66955-1-mrolnik@gmail.com>
References: <20191021223711.66955-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 target/avr/cpu.h       |   2 +-
 target/avr/translate.c | 132 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 1 deletion(-)
 create mode 100644 target/avr/translate.c

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 45d644f4f4..6cac7bdb2f 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -219,7 +219,7 @@ static inline int cpu_interrupts_enabled(CPUAVRState *env)
 static inline uint8_t cpu_get_sreg(CPUAVRState *env)
 {
     uint8_t sreg;
-    sreg = (env->sregC & 0x01) << 0
+    sreg = (env->sregC) << 0
          | (env->sregZ == 0 ? 1 : 0) << 1
          | (env->sregN) << 2
          | (env->sregV) << 3
diff --git a/target/avr/translate.c b/target/avr/translate.c
new file mode 100644
index 0000000000..53c9892a60
--- /dev/null
+++ b/target/avr/translate.c
@@ -0,0 +1,132 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2019 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/qemu-print.h"
+#include "tcg/tcg.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "disas/disas.h"
+#include "tcg-op.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "exec/log.h"
+#include "exec/gdbstub.h"
+#include "exec/translator.h"
+#include "exec/gen-icount.h"
+
+/*
+ *  Define if you want a BREAK instruction translated to a breakpoint
+ *  Active debugging connection is assumed
+ *  This is for
+ *  https://github.com/seharris/qemu-avr-tests/tree/master/instruction-tests
+ *  tests
+ */
+#undef BREAKPOINT_ON_BREAK
+
+static TCGv cpu_pc;
+
+static TCGv cpu_Cf;
+static TCGv cpu_Zf;
+static TCGv cpu_Nf;
+static TCGv cpu_Vf;
+static TCGv cpu_Sf;
+static TCGv cpu_Hf;
+static TCGv cpu_Tf;
+static TCGv cpu_If;
+
+static TCGv cpu_rampD;
+static TCGv cpu_rampX;
+static TCGv cpu_rampY;
+static TCGv cpu_rampZ;
+
+static TCGv cpu_r[NO_CPU_REGISTERS];
+static TCGv cpu_eind;
+static TCGv cpu_sp;
+
+static TCGv cpu_skip;
+
+static const char reg_names[NO_CPU_REGISTERS][8] = {
+    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
+    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
+    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
+};
+#define REG(x) (cpu_r[x])
+
+enum {
+    DISAS_EXIT   = DISAS_TARGET_0,  /* We want return to the cpu main loop.  */
+    DISAS_LOOKUP = DISAS_TARGET_1,  /* We have a variable condition exit.  */
+    DISAS_CHAIN  = DISAS_TARGET_2,  /* We have a single condition exit.  */
+};
+
+typedef struct DisasContext DisasContext;
+
+/* This is the state at translation time. */
+struct DisasContext {
+    TranslationBlock *tb;
+
+    CPUAVRState *env;
+    CPUState *cs;
+
+    target_long npc;
+    uint32_t opcode;
+
+    /* Routine used to access memory */
+    int memidx;
+    int bstate;
+    int singlestep;
+
+    TCGv skip_var0;
+    TCGv skip_var1;
+    TCGCond skip_cond;
+    bool free_skip_var0;
+};
+
+static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); }
+static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
+static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) * 2; }
+static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2; }
+
+static uint16_t next_word(DisasContext *ctx)
+{
+    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
+}
+
+static int append_16(DisasContext *ctx, int x)
+{
+    return x << 16 | next_word(ctx);
+}
+
+
+static bool avr_have_feature(DisasContext *ctx, int feature)
+{
+    if (!avr_feature(ctx->env, feature)) {
+        gen_helper_unsupported(cpu_env);
+        ctx->bstate = DISAS_NORETURN;
+        return false;
+    }
+    return true;
+}
+
+static bool decode_insn(DisasContext *ctx, uint16_t insn);
+#include "decode_insn.inc.c"
+
-- 
2.17.2 (Apple Git-113)


