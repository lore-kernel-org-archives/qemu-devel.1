Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CA3C48BE4
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5A2208C3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5A2208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45804 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hf5yQ-0003Po-Fe
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 13:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hf5wR-0001hL-8s
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hf5wO-0004P5-NM
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:11 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39418 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hf5wN-00039X-RR
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:08 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id DD1CE1A1D00;
 Sun, 23 Jun 2019 19:05:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id BE7381A0EDA;
 Sun, 23 Jun 2019 19:05:04 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Sun, 23 Jun 2019 19:04:34 +0200
Message-Id: <1561309489-16146-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561309489-16146-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561309489-16146-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v5 01/16] tcg/ppc: Introduce Altivec registers
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
Cc: richard.henderson@linaro.org,
 "David Gibson --cc=amarkovic @ wavecomp . com"
 <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Altivec (in all its versions) supports 32 128-bit vector registers,
whase names are by convention v0, v1,..., and v32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     | 11 +++++-
 tcg/ppc/tcg-target.inc.c | 88 ++++++++++++++++++++++++++++++------------------
 2 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 7627fb6..690fa74 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -31,7 +31,7 @@
 # define TCG_TARGET_REG_BITS  32
 #endif
 
-#define TCG_TARGET_NB_REGS 32
+#define TCG_TARGET_NB_REGS 64
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 
@@ -45,6 +45,15 @@ typedef enum {
     TCG_REG_R24, TCG_REG_R25, TCG_REG_R26, TCG_REG_R27,
     TCG_REG_R28, TCG_REG_R29, TCG_REG_R30, TCG_REG_R31,
 
+    TCG_REG_V0,  TCG_REG_V1,  TCG_REG_V2,  TCG_REG_V3,
+    TCG_REG_V4,  TCG_REG_V5,  TCG_REG_V6,  TCG_REG_V7,
+    TCG_REG_V8,  TCG_REG_V9,  TCG_REG_V10, TCG_REG_V11,
+    TCG_REG_V12, TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
+    TCG_REG_V16, TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20, TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    TCG_REG_V24, TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
+    TCG_REG_V28, TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
+
     TCG_REG_CALL_STACK = TCG_REG_R1,
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 852b894..8e1bba7 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -42,6 +42,9 @@
 # define TCG_REG_TMP1   TCG_REG_R12
 #endif
 
+#define TCG_VEC_TMP1    TCG_REG_V0
+#define TCG_VEC_TMP2    TCG_REG_V1
+
 #define TCG_REG_TB     TCG_REG_R31
 #define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
 
@@ -72,39 +75,15 @@ bool have_isa_3_00;
 #endif
 
 #ifdef CONFIG_DEBUG_TCG
-static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
-    "r0",
-    "r1",
-    "r2",
-    "r3",
-    "r4",
-    "r5",
-    "r6",
-    "r7",
-    "r8",
-    "r9",
-    "r10",
-    "r11",
-    "r12",
-    "r13",
-    "r14",
-    "r15",
-    "r16",
-    "r17",
-    "r18",
-    "r19",
-    "r20",
-    "r21",
-    "r22",
-    "r23",
-    "r24",
-    "r25",
-    "r26",
-    "r27",
-    "r28",
-    "r29",
-    "r30",
-    "r31"
+static const char tcg_target_reg_names[TCG_TARGET_NB_REGS][4] = {
+    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
+    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
+    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
+    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
+    "v0",  "v1",  "v2",  "v3",  "v4",  "v5",  "v6",  "v7",
+    "v8",  "v9",  "v10", "v11", "v12", "v13", "v14", "v15",
+    "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+    "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31",
 };
 #endif
 
@@ -139,6 +118,26 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_R5,
     TCG_REG_R4,
     TCG_REG_R3,
+
+    /* V0 and V1 reserved as temporaries; V20 - V31 are call-saved */
+    TCG_REG_V2,   /* call clobbered, vectors */
+    TCG_REG_V3,
+    TCG_REG_V4,
+    TCG_REG_V5,
+    TCG_REG_V6,
+    TCG_REG_V7,
+    TCG_REG_V8,
+    TCG_REG_V9,
+    TCG_REG_V10,
+    TCG_REG_V11,
+    TCG_REG_V12,
+    TCG_REG_V13,
+    TCG_REG_V14,
+    TCG_REG_V15,
+    TCG_REG_V16,
+    TCG_REG_V17,
+    TCG_REG_V18,
+    TCG_REG_V19,
 };
 
 static const int tcg_target_call_iarg_regs[] = {
@@ -2808,6 +2807,27 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R11);
     tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_R12);
 
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V0);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V1);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V2);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V3);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V4);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V5);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V6);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V7);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V8);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V9);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V10);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V11);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V12);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V13);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V14);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V15);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V16);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V17);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V18);
+    tcg_regset_set_reg(tcg_target_call_clobber_regs, TCG_REG_V19);
+
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R0); /* tcg temp */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R1); /* stack pointer */
@@ -2818,6 +2838,8 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_R13); /* thread pointer */
 #endif
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1); /* mem temp */
+    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP1);
+    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP2);
     if (USE_REG_TB) {
         tcg_regset_set_reg(s->reserved_regs, TCG_REG_TB);  /* tb->tc_ptr */
     }
-- 
2.7.4


