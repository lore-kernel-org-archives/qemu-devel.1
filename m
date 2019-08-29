Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD51AC3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F152189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 10:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F152189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Hvr-0000WZ-JM
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 06:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hch-0005ST-NO
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i3Hcd-0005oc-Jn
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45431 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i3Hcc-0005Q9-E9
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 06:25:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 7BBF01A2258;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 392DE1A21B6;
 Thu, 29 Aug 2019 12:25:25 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 12:25:04 +0200
Message-Id: <1567074313-22998-23-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 22/31] target/mips: Clean up handling of CP0
 register 23
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of CP0 register 23.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1567009614-12438-23-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/cpu.h       |   6 +++
 target/mips/translate.c | 126 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 89 insertions(+), 43 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index b4866a5..168a6d7 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -405,6 +405,12 @@ typedef struct mips_def_t mips_def_t;
 /* CP0 Register 22 */
 /* CP0 Register 23 */
 #define CP0_REG23__DEBUG           0
+#define CP0_REG23__TRACECONTROL    1
+#define CP0_REG23__TRACECONTROL2   2
+#define CP0_REG23__USERTRACEDATA1  3
+#define CP0_REG23__TRACEIBPC       4
+#define CP0_REG23__TRACEDBPC       5
+#define CP0_REG23__DEBUG2          6
 /* CP0 Register 24 */
 #define CP0_REG24__DEPC            0
 /* CP0 Register 25 */
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 55b0005..610631f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7371,25 +7371,34 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_23:
         switch (sel) {
-        case 0:
+        case CP0_REG23__DEBUG:
             gen_helper_mfc0_debug(arg, cpu_env); /* EJTAG support */
             register_name = "Debug";
             break;
-        case 1:
-//            gen_helper_mfc0_tracecontrol(arg); /* PDtrace support */
+        case CP0_REG23__TRACECONTROL:
+            /* PDtrace support */
+            /* gen_helper_mfc0_tracecontrol(arg);  */
             register_name = "TraceControl";
             goto cp0_unimplemented;
-        case 2:
-//            gen_helper_mfc0_tracecontrol2(arg); /* PDtrace support */
+        case CP0_REG23__TRACECONTROL2:
+            /* PDtrace support */
+            /* gen_helper_mfc0_tracecontrol2(arg); */
             register_name = "TraceControl2";
             goto cp0_unimplemented;
-        case 3:
-//            gen_helper_mfc0_usertracedata(arg); /* PDtrace support */
-            register_name = "UserTraceData";
+        case CP0_REG23__USERTRACEDATA1:
+            /* PDtrace support */
+            /* gen_helper_mfc0_usertracedata1(arg);*/
+            register_name = "UserTraceData1";
             goto cp0_unimplemented;
-        case 4:
-//            gen_helper_mfc0_tracebpc(arg); /* PDtrace support */
-            register_name = "TraceBPC";
+        case CP0_REG23__TRACEIBPC:
+            /* PDtrace support */
+            /* gen_helper_mfc0_traceibpc(arg);     */
+            register_name = "TraceIBPC";
+            goto cp0_unimplemented;
+        case CP0_REG23__TRACEDBPC:
+            /* PDtrace support */
+            /* gen_helper_mfc0_tracedbpc(arg);     */
+            register_name = "TraceDBPC";
             goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
@@ -8105,38 +8114,49 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_23:
         switch (sel) {
-        case 0:
+        case CP0_REG23__DEBUG:
             gen_helper_mtc0_debug(cpu_env, arg); /* EJTAG support */
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp = DISAS_EXIT;
             register_name = "Debug";
             break;
-        case 1:
-//            gen_helper_mtc0_tracecontrol(cpu_env, arg); /* PDtrace support */
+        case CP0_REG23__TRACECONTROL:
+            /* PDtrace support */
+            /* gen_helper_mtc0_tracecontrol(cpu_env, arg);  */
             register_name = "TraceControl";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             goto cp0_unimplemented;
-        case 2:
-//            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
+        case CP0_REG23__TRACECONTROL2:
+            /* PDtrace support */
+            /* gen_helper_mtc0_tracecontrol2(cpu_env, arg); */
             register_name = "TraceControl2";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             goto cp0_unimplemented;
-        case 3:
+        case CP0_REG23__USERTRACEDATA1:
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-//            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
+            /* PDtrace support */
+            /* gen_helper_mtc0_usertracedata1(cpu_env, arg);*/
             register_name = "UserTraceData";
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             goto cp0_unimplemented;
-        case 4:
-//            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
+        case CP0_REG23__TRACEIBPC:
+            /* PDtrace support */
+            /* gen_helper_mtc0_traceibpc(cpu_env, arg);     */
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            register_name = "TraceBPC";
+            register_name = "TraceIBPC";
+            goto cp0_unimplemented;
+        case CP0_REG23__TRACEDBPC:
+            /* PDtrace support */
+            /* gen_helper_mtc0_tracedbpc(cpu_env, arg);     */
+            /* Stop translation as we may have switched the execution mode */
+            ctx->base.is_jmp = DISAS_STOP;
+            register_name = "TraceDBPC";
             goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
@@ -8840,25 +8860,34 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_23:
         switch (sel) {
-        case 0:
+        case CP0_REG23__DEBUG:
             gen_helper_mfc0_debug(arg, cpu_env); /* EJTAG support */
             register_name = "Debug";
             break;
-        case 1:
-//            gen_helper_dmfc0_tracecontrol(arg, cpu_env); /* PDtrace support */
+        case CP0_REG23__TRACECONTROL:
+            /* PDtrace support */
+            /* gen_helper_dmfc0_tracecontrol(arg, cpu_env);  */
             register_name = "TraceControl";
             goto cp0_unimplemented;
-        case 2:
-//            gen_helper_dmfc0_tracecontrol2(arg, cpu_env); /* PDtrace support */
+        case CP0_REG23__TRACECONTROL2:
+            /* PDtrace support */
+            /* gen_helper_dmfc0_tracecontrol2(arg, cpu_env); */
             register_name = "TraceControl2";
             goto cp0_unimplemented;
-        case 3:
-//            gen_helper_dmfc0_usertracedata(arg, cpu_env); /* PDtrace support */
-            register_name = "UserTraceData";
+        case CP0_REG23__USERTRACEDATA1:
+            /* PDtrace support */
+            /* gen_helper_dmfc0_usertracedata1(arg, cpu_env);*/
+            register_name = "UserTraceData1";
             goto cp0_unimplemented;
-        case 4:
-//            gen_helper_dmfc0_tracebpc(arg, cpu_env); /* PDtrace support */
-            register_name = "TraceBPC";
+        case CP0_REG23__TRACEIBPC:
+            /* PDtrace support */
+            /* gen_helper_dmfc0_traceibpc(arg, cpu_env);     */
+            register_name = "TraceIBPC";
+            goto cp0_unimplemented;
+        case CP0_REG23__TRACEDBPC:
+            /* PDtrace support */
+            /* gen_helper_dmfc0_tracedbpc(arg, cpu_env);     */
+            register_name = "TraceDBPC";
             goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
@@ -9557,36 +9586,47 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         break;
     case CP0_REGISTER_23:
         switch (sel) {
-        case 0:
+        case CP0_REG23__DEBUG:
             gen_helper_mtc0_debug(cpu_env, arg); /* EJTAG support */
             /* DISAS_STOP isn't good enough here, hflags may have changed. */
             gen_save_pc(ctx->base.pc_next + 4);
             ctx->base.is_jmp = DISAS_EXIT;
             register_name = "Debug";
             break;
-        case 1:
-//            gen_helper_mtc0_tracecontrol(cpu_env, arg); /* PDtrace support */
+        case CP0_REG23__TRACECONTROL:
+            /* PDtrace support */
+            /* gen_helper_mtc0_tracecontrol(cpu_env, arg);  */
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             register_name = "TraceControl";
             goto cp0_unimplemented;
-        case 2:
-//            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
+        case CP0_REG23__TRACECONTROL2:
+            /* PDtrace support */
+            /* gen_helper_mtc0_tracecontrol2(cpu_env, arg); */
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
             register_name = "TraceControl2";
             goto cp0_unimplemented;
-        case 3:
-//            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
+        case CP0_REG23__USERTRACEDATA1:
+            /* PDtrace support */
+            /* gen_helper_mtc0_usertracedata1(cpu_env, arg);*/
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            register_name = "UserTraceData";
+            register_name = "UserTraceData1";
             goto cp0_unimplemented;
-        case 4:
-//            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
+        case CP0_REG23__TRACEIBPC:
+            /* PDtrace support */
+            /* gen_helper_mtc0_traceibpc(cpu_env, arg);     */
+            /* Stop translation as we may have switched the execution mode */
+            ctx->base.is_jmp = DISAS_STOP;
+            register_name = "TraceIBPC";
+            goto cp0_unimplemented;
+        case CP0_REG23__TRACEDBPC:
+            /* PDtrace support */
+            /* gen_helper_mtc0_tracedbpc(cpu_env, arg);     */
             /* Stop translation as we may have switched the execution mode */
             ctx->base.is_jmp = DISAS_STOP;
-            register_name = "TraceBPC";
+            register_name = "TraceDBPC";
             goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
-- 
2.7.4


