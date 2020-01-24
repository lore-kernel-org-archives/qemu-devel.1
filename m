Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39900C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F096C2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdFamHtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F096C2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunDS-0002yE-3E
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 19:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCL-0001A0-4l
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCJ-00051S-Dd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:51:45 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:42120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCJ-000517-75; Thu, 23 Jan 2020 19:51:43 -0500
Received: by mail-wr1-x430.google.com with SMTP id q6so55982wro.9;
 Thu, 23 Jan 2020 16:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OEFv6DQAolvxs62DZ13y7FtiFJmnj2RuvV8CY11AB9U=;
 b=fdFamHtCdyRT0BWZvkpILmY51xiqG3qcLC9S8kkzmkmVbvhyifg2GBef4x/Qg0ZkZF
 a6GLarNbGQXmEWLGsnKxYKEQ9TjmfDbtjYJM2XUcHVmMUqGO5TVzDBDBs24TmrIzhmcB
 VdT3Z2Jnyaai//g4iuFbnIAqFdYUHrbB8Ytco8Mab4x5h55QeIBjg0d2TMTn4/8LMT7q
 hCcG8TrhgQIPDZ4d1IiFxc8GWUoxhSyEP6QMumD82yunQfW2e6LTR9OZ1vFx2S0Yv09X
 bqnKqFdNgZ8PJ2unIxP/87ga09xrVV2dO6lozF17oQA1LDlp7JdJL0CvplrCAhAeOcMt
 ddOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=OEFv6DQAolvxs62DZ13y7FtiFJmnj2RuvV8CY11AB9U=;
 b=o+hdkbsRwHyZZh+kxcUqip4/3+qEVAuoQ7a+IZ8obn9tZthKje6oS7it5p1oyOFZgS
 d/H8IoELGzOzDBUVa29Yak2ZFdxmDLZs2NiqoXBLilZTqlSMMbLNexd4vpa+7/szmStP
 UXzzEQiQW9x23bL/Iz73eEW7oRi1y4ou6fl33H5OnDWDTwqXTj10/DCjTOU2sqh/RUuQ
 snOpO/1DlDk1BPNaentwcJs8wUcSEVHumy4tT8Wan5rzEUDl5MPj0xO/MrJgN4I0V+WH
 0rds94wvS4cYEHxPLJQwkLT9NtQIkLFAU/onlFU9cpSUgIIFNk6zkOcVDvm5gwMIHiEF
 2CZg==
X-Gm-Message-State: APjAAAVe7wOpntP8TVvRjYY11EnXG06IlcYeND6zLOCYPi6RNGBCoAvt
 H8PSBkEbWWnD8XpUkOIcGycJKcnt
X-Google-Smtp-Source: APXvYqzB4r5h6HlxAv89EVwX7MbfVfTx1iMIC4Yo7I0ABzOdSRftRiOOTG/PA7SPiUmBXeFYhTP9Fw==
X-Received: by 2002:a5d:6b47:: with SMTP id x7mr850295wrw.277.1579827102003;
 Thu, 23 Jan 2020 16:51:42 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:51:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 03/25] target/avr: Add instruction translation - Registers
 definition
Date: Fri, 24 Jan 2020 01:51:09 +0100
Message-Id: <20200124005131.16276-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200118191416.19934-4-mrolnik@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/translate.c | 171 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 target/avr/translate.c

diff --git a/target/avr/translate.c b/target/avr/translate.c
new file mode 100644
index 0000000000..535f666d18
--- /dev/null
+++ b/target/avr/translate.c
@@ -0,0 +1,171 @@
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
-- 
2.21.1


