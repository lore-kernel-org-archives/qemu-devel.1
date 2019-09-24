Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59590C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEC0207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEC0207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkub-0001VX-V4
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iCkrN-0007z5-NU
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iCkrJ-0001EZ-UH
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:03 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46874 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iCkrG-0001Aa-UT
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:28:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id C32021A22AB;
 Tue, 24 Sep 2019 15:26:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 94B411A221B;
 Tue, 24 Sep 2019 15:26:48 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/11] target/mips: Clean up translate.c
Date: Tue, 24 Sep 2019 15:26:37 +0200
Message-Id: <1569331602-2586-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569331602-2586-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1569331602-2586-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
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
Cc: arikalo@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Mostly fix errors and warnings reported by 'checkpatch.pl -f'.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index f211995..cc5af2a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7118,7 +7118,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             tcg_gen_andi_tl(arg, arg, ~0xffff);
             register_name = "BadInstrX";
             break;
-       default:
+        default:
             goto cp0_unimplemented;
         }
         break;
@@ -7545,7 +7545,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case CP0_REG31__KSCRATCH6:
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_ld_tl(arg, cpu_env,
-                          offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
+                          offsetof(CPUMIPSState, CP0_KScratch[sel - 2]));
             tcg_gen_ext32s_tl(arg, arg);
             register_name = "KScratch";
             break;
@@ -8295,7 +8295,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case CP0_REG31__KSCRATCH6:
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_st_tl(arg, cpu_env,
-                          offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
+                          offsetof(CPUMIPSState, CP0_KScratch[sel - 2]));
             register_name = "KScratch";
             break;
         default:
@@ -8387,17 +8387,20 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             break;
         case CP0_REG01__YQMASK:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
-            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_YQMask));
+            tcg_gen_ld_tl(arg, cpu_env,
+                          offsetof(CPUMIPSState, CP0_YQMask));
             register_name = "YQMask";
             break;
         case CP0_REG01__VPESCHEDULE:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
-            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_VPESchedule));
+            tcg_gen_ld_tl(arg, cpu_env,
+                          offsetof(CPUMIPSState, CP0_VPESchedule));
             register_name = "VPESchedule";
             break;
         case CP0_REG01__VPESCHEFBACK:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
-            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_VPEScheFBack));
+            tcg_gen_ld_tl(arg, cpu_env,
+                          offsetof(CPUMIPSState, CP0_VPEScheFBack));
             register_name = "VPEScheFBack";
             break;
         case CP0_REG01__VPEOPT:
@@ -8412,7 +8415,8 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     case CP0_REGISTER_02:
         switch (sel) {
         case CP0_REG02__ENTRYLO0:
-            tcg_gen_ld_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_EntryLo0));
+            tcg_gen_ld_tl(arg, cpu_env,
+                          offsetof(CPUMIPSState, CP0_EntryLo0));
             register_name = "EntryLo0";
             break;
         case CP0_REG02__TCSTATUS:
@@ -8756,7 +8760,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config5));
             register_name = "Config5";
             break;
-       /* 6,7 are implementation dependent */
+        /* 6,7 are implementation dependent */
         case CP0_REG16__CONFIG6:
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_Config6));
             register_name = "Config6";
@@ -8837,7 +8841,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         }
         break;
     case CP0_REGISTER_21:
-       /* Officially reserved, but sel 0 is used for R1x000 framemask */
+        /* Officially reserved, but sel 0 is used for R1x000 framemask */
         CP0_CHECK(!(ctx->insn_flags & ISA_MIPS32R6));
         switch (sel) {
         case 0:
@@ -9022,7 +9026,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case CP0_REG31__KSCRATCH6:
             CP0_CHECK(ctx->kscrexist & (1 << sel));
             tcg_gen_ld_tl(arg, cpu_env,
-                          offsetof(CPUMIPSState, CP0_KScratch[sel-2]));
+                          offsetof(CPUMIPSState, CP0_KScratch[sel - 2]));
             register_name = "KScratch";
             break;
         default:
@@ -9112,12 +9116,14 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             break;
         case CP0_REG01__VPESCHEDULE:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
-            tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_VPESchedule));
+            tcg_gen_st_tl(arg, cpu_env,
+                          offsetof(CPUMIPSState, CP0_VPESchedule));
             register_name = "VPESchedule";
             break;
         case CP0_REG01__VPESCHEFBACK:
             CP0_CHECK(ctx->insn_flags & ASE_MT);
-            tcg_gen_st_tl(arg, cpu_env, offsetof(CPUMIPSState, CP0_VPEScheFBack));
+            tcg_gen_st_tl(arg, cpu_env,
+                          offsetof(CPUMIPSState, CP0_VPEScheFBack));
             register_name = "VPEScheFBack";
             break;
         case CP0_REG01__VPEOPT:
-- 
2.7.4


