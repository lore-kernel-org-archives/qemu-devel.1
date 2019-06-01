Return-Path: <SRS0=gcBw=UA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C46C28CC4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 18:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482F125840
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2019 18:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482F125840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hX8pM-00044K-G5
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 14:34:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hX8nR-0002sY-SE
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 14:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hX8nQ-0005tG-K7
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 14:32:01 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:59823 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hX8nQ-0005Pv-9c
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 14:32:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 575951A1D46;
	Sat,  1 Jun 2019 20:30:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 34EDC1A1CFE;
	Sat,  1 Jun 2019 20:30:55 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Sat,  1 Jun 2019 20:30:39 +0200
Message-Id: <1559413846-4402-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559413846-4402-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559413846-4402-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 1/8] target/mips: Add emulation of MMI
 instruction PCPYH
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Add emulation of MMI instruction PCPYH. The emulation is implemented
using TCG front end operations directly to achieve better performance.

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1551712405-2530-2-git-send-email-mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 70552fe..704eb2b 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -24357,6 +24357,68 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
  *                     PEXTUW
  */
 
+/*
+ *  PCPYH rd, rt
+ *
+ *    Parallel Copy Halfword
+ *
+ *   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *  +-----------+---------+---------+---------+---------+-----------+
+ *  |    MMI    |0 0 0 0 0|   rt    |   rd    |  PCPYH  |    MMI3   |
+ *  +-----------+---------+---------+---------+---------+-----------+
+ */
+static void gen_mmi_pcpyh(DisasContext *ctx)
+{
+    uint32_t pd, rt, rd;
+    uint32_t opcode;
+
+    opcode = ctx->opcode;
+
+    pd = extract32(opcode, 21, 5);
+    rt = extract32(opcode, 16, 5);
+    rd = extract32(opcode, 11, 5);
+
+    if (unlikely(pd != 0)) {
+        generate_exception_end(ctx, EXCP_RI);
+    } else if (rd == 0) {
+        /* nop */
+    } else if (rt == 0) {
+        tcg_gen_movi_i64(cpu_gpr[rd], 0);
+        tcg_gen_movi_i64(cpu_mmr[rd], 0);
+    } else {
+        TCGv_i64 t0 = tcg_temp_new();
+        TCGv_i64 t1 = tcg_temp_new();
+        uint64_t mask = (1ULL << 16) - 1;
+
+        tcg_gen_andi_i64(t0, cpu_gpr[rt], mask);
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+
+        tcg_gen_mov_i64(cpu_gpr[rd], t1);
+
+        tcg_gen_andi_i64(t0, cpu_mmr[rt], mask);
+        tcg_gen_movi_i64(t1, 0);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+        tcg_gen_shli_i64(t0, t0, 16);
+        tcg_gen_or_i64(t1, t0, t1);
+
+        tcg_gen_mov_i64(cpu_mmr[rd], t1);
+
+        tcg_temp_free(t0);
+        tcg_temp_free(t1);
+    }
+}
+
 #endif
 
 
@@ -27409,10 +27471,12 @@ static void decode_mmi3(CPUMIPSState *env, DisasContext *ctx)
     case MMI_OPC_3_POR:        /* TODO: MMI_OPC_3_POR */
     case MMI_OPC_3_PNOR:       /* TODO: MMI_OPC_3_PNOR */
     case MMI_OPC_3_PEXCH:      /* TODO: MMI_OPC_3_PEXCH */
-    case MMI_OPC_3_PCPYH:      /* TODO: MMI_OPC_3_PCPYH */
     case MMI_OPC_3_PEXCW:      /* TODO: MMI_OPC_3_PEXCW */
         generate_exception_end(ctx, EXCP_RI); /* TODO: MMI_OPC_CLASS_MMI3 */
         break;
+    case MMI_OPC_3_PCPYH:
+        gen_mmi_pcpyh(ctx);
+        break;
     default:
         MIPS_INVAL("TX79 MMI class MMI3");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.4


