Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B686C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F19C120651
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 12:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eio8PVTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19C120651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnMLa-0000hj-6X
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 08:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52151)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnMLP-0000CL-4p
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnMLN-0000Us-PD
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:14:07 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnMLN-0000Tq-GP
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 08:14:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id w9so16616137wmd.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gJZSxxkesJ4xFyxOL/py9rKSL0eJjs0bk0rm4uZiEgw=;
 b=eio8PVTCiQ4kRa/KtUGiUdqikyUZBSo/Fcr1S8/UOL/86uyIkbMsehqizQ26BWuphM
 yqAjFZ8D2XdlvYhi8QfsRGbhN0YrHrpLH+BMSBFnS+qVHj0XlV48sSVO3MjaTPAS0CGD
 kHlSBuJTxbELbOT7zSXSdjw8yeBZXogmaTObKS42BiagMXG0qv4jFM9DnptYXZUg1pcU
 v1JD2X1/O1f8QRLxB795jc1MmtW/dGt2Ow33kPv13SE8eCNAdTKQE2XvyqVOQwx2EXSM
 nZkFEiznGk9Soz5moR+azieWuGNF1f5l8xSXZ2hMxJLJhItsRNONSQwWv+rE4FrIHqxd
 uGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gJZSxxkesJ4xFyxOL/py9rKSL0eJjs0bk0rm4uZiEgw=;
 b=lE+ca0b8BvxfG5c8pe2Je7nSZaBdsAJ7zePzk/LP16aOp5miUQO0VxBIKNyA7uEVT0
 BzewsCeBO/FpHO+03pfdVMMtg7DFckx2aJCQDJobU2e27c9TyGjTnYABPAM3+oGkLdSv
 kxnq3MRAn2YsPNl88zVjeQq1fo4s37A6QuuJj4QM+QQo6hu52lO7jClk3DrR8H7Y0ryf
 PYMEED7bcP6dsBZmz/Y83oajGOyTPgW73DMPVaKBme+4MHZoEGrKOUnS18977l/LE8lx
 unXSy2bDQE15q86LyxYpYoYokr04c0EJ74MRF8dOWoL3C8g9FV9kNUVRfEf3aHKQ5+XS
 Vvkw==
X-Gm-Message-State: APjAAAVuySIPii3RrexZJyn0gIbympzMgEOYFhZBoyBC1plAomxeBZbh
 Bf1Q400YkNsEK3jfV0dRQfsu0Q==
X-Google-Smtp-Source: APXvYqwVZijL4S+YJWKU9Em2Nyl3QEsi7r8R8bdy1nvs4Uk19itNP+Jml3QCg2gBLT0EHl0595YAIw==
X-Received: by 2002:a1c:630a:: with SMTP id x10mr32029283wmb.113.1563279243673; 
 Tue, 16 Jul 2019 05:14:03 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g11sm20316918wru.24.2019.07.16.05.14.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 16 Jul 2019 05:14:03 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B18AA1FF87;
 Tue, 16 Jul 2019 13:14:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 13:13:52 +0100
Message-Id: <20190716121352.302-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [RFC PATCH for 4.1?] target/ppc: move opcode decode
 tables to PowerPCCPU
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
Cc: "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 1836558@bugs.launchpad.net,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The opcode decode tables aren't really part of the CPUPPCState but an
internal implementation detail for the translator. This can cause
problems with memcpy in cpu_copy as any table created during
ppc_cpu_realize get written over causing a memory leak. To avoid this
move the tables into PowerPCCPU which is better suited to hold
internal implementation details.

Attempts to fix: https://bugs.launchpad.net/qemu/+bug/1836558
Cc: 1836558@bugs.launchpad.net
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/ppc/cpu.h                |  8 ++++----
 target/ppc/translate.c          |  3 ++-
 target/ppc/translate_init.inc.c | 16 +++++++---------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c9beba2a5c0..10e34b69b75 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1104,10 +1104,6 @@ struct CPUPPCState {
     bool resume_as_sreset;
 #endif
 
-    /* Those resources are used only during code translation */
-    /* opcode handlers */
-    opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
-
     /* Those resources are used only in QEMU core */
     target_ulong hflags;      /* hflags is a MSR & HFLAGS_MASK         */
     target_ulong hflags_nmsr; /* specific hflags, not coming from MSR */
@@ -1191,6 +1187,10 @@ struct PowerPCCPU {
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
 
+    /* Those resources are used only during code translation */
+    /* opcode handlers */
+    opc_handler_t *opcodes[PPC_CPU_OPCODES_LEN];
+
     /* Fields related to migration compatibility hacks */
     bool pre_2_8_migration;
     target_ulong mig_msr_mask;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a5de280365..c0faab8a824 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7857,6 +7857,7 @@ static bool ppc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
 static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = cs->env_ptr;
     opc_handler_t **table, *handler;
 
@@ -7874,7 +7875,7 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
               opc3(ctx->opcode), opc4(ctx->opcode),
               ctx->le_mode ? "little" : "big");
     ctx->base.pc_next += 4;
-    table = env->opcodes;
+    table = cpu->opcodes;
     handler = table[opc1(ctx->opcode)];
     if (is_indirect_opcode(handler)) {
         table = ind_table(handler);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 86fc8f2e316..9cd2033bb92 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9440,14 +9440,13 @@ static void fix_opcode_tables(opc_handler_t **ppc_opcodes)
 static void create_ppc_opcodes(PowerPCCPU *cpu, Error **errp)
 {
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    CPUPPCState *env = &cpu->env;
     opcode_t *opc;
 
-    fill_new_table(env->opcodes, PPC_CPU_OPCODES_LEN);
+    fill_new_table(cpu->opcodes, PPC_CPU_OPCODES_LEN);
     for (opc = opcodes; opc < &opcodes[ARRAY_SIZE(opcodes)]; opc++) {
         if (((opc->handler.type & pcc->insns_flags) != 0) ||
             ((opc->handler.type2 & pcc->insns_flags2) != 0)) {
-            if (register_insn(env->opcodes, opc) < 0) {
+            if (register_insn(cpu->opcodes, opc) < 0) {
                 error_setg(errp, "ERROR initializing PowerPC instruction "
                            "0x%02x 0x%02x 0x%02x", opc->opc1, opc->opc2,
                            opc->opc3);
@@ -9455,7 +9454,7 @@ static void create_ppc_opcodes(PowerPCCPU *cpu, Error **errp)
             }
         }
     }
-    fix_opcode_tables(env->opcodes);
+    fix_opcode_tables(cpu->opcodes);
     fflush(stdout);
     fflush(stderr);
 }
@@ -10023,7 +10022,6 @@ static void ppc_cpu_unrealize(DeviceState *dev, Error **errp)
 {
     PowerPCCPU *cpu = POWERPC_CPU(dev);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    CPUPPCState *env = &cpu->env;
     Error *local_err = NULL;
     opc_handler_t **table, **table_2;
     int i, j, k;
@@ -10035,11 +10033,11 @@ static void ppc_cpu_unrealize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < PPC_CPU_OPCODES_LEN; i++) {
-        if (env->opcodes[i] == &invalid_handler) {
+        if (cpu->opcodes[i] == &invalid_handler) {
             continue;
         }
-        if (is_indirect_opcode(env->opcodes[i])) {
-            table = ind_table(env->opcodes[i]);
+        if (is_indirect_opcode(cpu->opcodes[i])) {
+            table = ind_table(cpu->opcodes[i]);
             for (j = 0; j < PPC_CPU_INDIRECT_OPCODES_LEN; j++) {
                 if (table[j] == &invalid_handler) {
                     continue;
@@ -10057,7 +10055,7 @@ static void ppc_cpu_unrealize(DeviceState *dev, Error **errp)
                                              ~PPC_INDIRECT));
                 }
             }
-            g_free((opc_handler_t *)((uintptr_t)env->opcodes[i] &
+            g_free((opc_handler_t *)((uintptr_t)cpu->opcodes[i] &
                 ~PPC_INDIRECT));
         }
     }
-- 
2.20.1


