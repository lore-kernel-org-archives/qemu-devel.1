Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B6C32771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F6124679
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 19:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEP3tboU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F6124679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1istl6-0005hM-GI
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 14:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1istcR-0002yn-Ei
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1istcP-0003jT-SJ
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:18:51 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:35360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1istcP-0003iO-LW
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 14:18:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id p17so10846730wmb.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 11:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GX/AGeaj9ABxhp4/AZJflicRhmKLYIGNABhlODWYu6w=;
 b=MEP3tboUil220q2pElFrPCZqTZ6SksqZXeqkStt21a5XgWj+vUgYqs67qEQbzH7POb
 KzQnTQH1MwmQGI2qfTee3DfIjd8lD+JKYJ5F/Q0spkkA/drGArKiQmEbnr6IWGERBvDn
 BYEUUGKwAm5CO72hOQD3nrrKshKMWyJsNahrvEY/fULFZurx5g/oHLVPzwQgtAWUxmrp
 c9V2PN2SR+aUHa5/9lMaF2wmKO7mkvuGAsxu0qgzQ0Cn/QKivPz7palKjOMYvp4sWfoR
 419G2BvfwIvfzD77N0bsU7mT1QtClieVX1khaIlnFl5EN5a0Ni4X12ZsU9vDUMsb3ria
 H31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GX/AGeaj9ABxhp4/AZJflicRhmKLYIGNABhlODWYu6w=;
 b=YglGkVjtN5ddMg3liYLKqIcpo4zgoQJ0mlsqc/hfMR1QTMGti9s10I2cg4dKSFmoRc
 mMvPkaX9KGkC2D9El9SgI6F1HnWqgD/+6whID9VSs1WgPGJ7Q9FVadbvxzEtzXk02Ko/
 iiiXn8qeN0pBWiNoK2fLVBGZ/sY9DmnGlZg3Lw/H2eCgqRMu11dXJn5jCM5kbIBKXg7Q
 /waFfVYAUTHXjrQdo1epfFXPfb8V5QESiLdyngXxm843CNKHPfmZuUGUOBCGQkybDhrQ
 Am1PLbtzTScPmufAjVXP4N+xGl5OyfefA1US81Z8wc834DlfJo39AjbKc8MOaJxZ4Y/X
 eY0w==
X-Gm-Message-State: APjAAAXZMtNMYEoxa1xX1iNdr5OnWFoN4x43ivvmg1jqSDeDREgC2xWt
 mFgOc4rmn9hqq91yu56GkTDGUL4Dav3I7cA3
X-Google-Smtp-Source: APXvYqwvw84WPk7OkZkF6rIToFN5xMR0s/S6F3rKwgUlEDIRCPKoXng0dgHcd+MIk34TgyHMx5yfGw==
X-Received: by 2002:a05:600c:2050:: with SMTP id
 p16mr10800801wmg.176.1579375128441; 
 Sat, 18 Jan 2020 11:18:48 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-108-13.red.bezeqint.net. [109.65.108.13])
 by smtp.gmail.com with ESMTPSA id o16sm2875468wmc.18.2020.01.18.11.18.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 18 Jan 2020 11:18:48 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v41 03/21] target/avr: Add instruction translation - Registers
 definition
Date: Sat, 18 Jan 2020 21:13:58 +0200
Message-Id: <20200118191416.19934-4-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20200118191416.19934-1-mrolnik@gmail.com>
References: <20200118191416.19934-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/avr/translate.c | 172 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 target/avr/translate.c

diff --git a/target/avr/translate.c b/target/avr/translate.c
new file mode 100644
index 0000000000..241083dc2d
--- /dev/null
+++ b/target/avr/translate.c
@@ -0,0 +1,172 @@
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
+#include "tcg/tcg-op.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "exec/log.h"
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
+static TCGv cpu_r[NUMBER_OF_CPU_REGISTERS];
+static TCGv cpu_eind;
+static TCGv cpu_sp;
+
+static TCGv cpu_skip;
+
+static const char reg_names[NUMBER_OF_CPU_REGISTERS][8] = {
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
+    /*
+     * some AVR instructions can make the following instruction to be skipped
+     * Let's name those instructions
+     *     A   - instruction that can skip the next one
+     *     B   - instruction that can be skipped. this depends on execution of A
+     * there are two scenarios
+     * 1. A and B belong to the same translation block
+     * 2. A is the last instruction in the translation block and B is the last
+     *
+     * following variables are used to simplify the skipping logic, they are
+     * used in the following manner (sketch)
+     *
+     * TCGLabel *skip_label = NULL;
+     * if (ctx.skip_cond != TCG_COND_NEVER) {
+     *     skip_label = gen_new_label();
+     *     tcg_gen_brcond_tl(skip_cond, skip_var0, skip_var1, skip_label);
+     * }
+     *
+     * if (free_skip_var0) {
+     *     tcg_temp_free(skip_var0);
+     *     free_skip_var0 = false;
+     * }
+     *
+     * translate(&ctx);
+     *
+     * if (skip_label) {
+     *     gen_set_label(skip_label);
+     * }
+     */
+    TCGv skip_var0;
+    TCGv skip_var1;
+    TCGCond skip_cond;
+    bool free_skip_var0;
+};
+
+static int to_regs_16_31_by_one(DisasContext *ctx, int indx)
+{
+    return 16 + (indx % 16);
+}
+
+static int to_regs_16_23_by_one(DisasContext *ctx, int indx)
+{
+    return 16 + (indx % 8);
+}
+static int to_regs_24_30_by_two(DisasContext *ctx, int indx)
+{
+    return 24 + (indx % 4) * 2;
+}
+static int to_regs_00_30_by_two(DisasContext *ctx, int indx)
+{
+    return (indx % 16) * 2;
+}
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


