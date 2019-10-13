Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38862C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 07:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB65620679
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 07:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzKSwq2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB65620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJYg5-0005tF-Q3
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 03:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iJYcC-0000fr-Vc
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 03:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iJYcB-0008JJ-IY
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 03:48:32 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:36576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iJYcB-0008IS-C7
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 03:48:31 -0400
Received: by mail-wr1-x432.google.com with SMTP id y19so16153428wrd.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 00:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MBE/sZ604WgtEEK2KK0XvQaJBBoGSHYTdBPmGrMUCB0=;
 b=XzKSwq2MIiUKjQ+NzhXqUUhyAy62iFyMuuNoCMkyWrfFBtRdu1na9qgb4kL2zuntmH
 t49Qg6+Z27a+4Ok/Tyq5+/3AWQspkAhclHMq4BJi6D7AlBAqdGdXPZphwVzfz3unu3pX
 8W0B92z8g7n219M+Zqo0zAS5pDmNbpSW86DWhrIF8oeysM9xKDdzQRoIR5NdtOF842Px
 Rk+ktbjBPccKjHnPkTqPMjpvDdoJT560MWjOf2NrWQNkDk1/FDWL2zCD8wpg3uiAbXM/
 sJnd9Wq/HasN2VDsHsNJ8kv7ycG5VM6fB5/tmci01rvMCM2c1yXfeVAo5sx2fpByf9kr
 r2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MBE/sZ604WgtEEK2KK0XvQaJBBoGSHYTdBPmGrMUCB0=;
 b=e3sxqFrTn87HHQZHyGfB1iXqVEdExs/HrDX2KbVV/u76p2MiDk0va2WhQFmIeTqWgH
 OD/hzS/dgxM9btEfGjl4sEaob/HlXFOmgFJsTMFEHg8BShJ5/+/dxooxvNJ9AM7lvV9O
 K6PI4vg7ksccFXCpmL24rf8lBXr1SIE/NyPg3JRIP9ZXrCSorIxmExk2u16emPx7oCrJ
 FW9DYa8C2h7rFJuyC+OMzI1A32mrgMZPB63WzK2NnNZmWMzBGd8G891ehB70REdAzl8f
 KHfGQPkbZ2NWgsFUQcleW4RdMHHn1mkysgaPMB7YjIPOjLsi0b3g/S+KDS5dDTogAtg9
 GDVQ==
X-Gm-Message-State: APjAAAUcstHV41NWKHRxKSV40aoSmvPwRF5+fcrNW/QaOkFCjToMEXr1
 mckV2XF2U9yK1jfjWVmE7WXn7AmD/6Y=
X-Google-Smtp-Source: APXvYqzArfhhdD6iOTW48Z+zrQQdwtygRUu3gUFwBJKYsRzrlbjpupwECKN5Xg4BnOjHBIkrkCY7Yw==
X-Received: by 2002:a5d:51d1:: with SMTP id n17mr20787368wrv.125.1570952909950; 
 Sun, 13 Oct 2019 00:48:29 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-179-64-109.red.bezeqint.net. [79.179.64.109])
 by smtp.gmail.com with ESMTPSA id u26sm9277532wrd.87.2019.10.13.00.48.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 13 Oct 2019 00:48:29 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v32 04/13] target/avr: Add instruction translation - begin
Date: Sun, 13 Oct 2019 10:47:57 +0300
Message-Id: <20191013074803.91390-6-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191013074803.91390-1-mrolnik@gmail.com>
References: <20191013074803.91390-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

This includes:
- TCG translations for each instruction

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 target/avr/translate.c | 132 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 target/avr/translate.c

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


