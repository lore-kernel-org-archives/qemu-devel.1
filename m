Received: from eggs.gnu.org ([2001:4830:134:3::10]:56060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dxrOz-0005M6-0T
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiang.biao2@zte.com.cn>) id 1dxrOu-0004jY-WD
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:16:08 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:42756 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiang.biao2@zte.com.cn>)
	id 1dxrOu-0004dw-Cf
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:16:04 -0400
From: Jiang Biao <jiang.biao2@zte.com.cn>
Date: Fri, 29 Sep 2017 17:35:07 +0800
Message-Id: <1506677707-2758-1-git-send-email-jiang.biao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] target/mips: remove commented out codes in
 translate.c
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: aurelien@aurel32.net, yongbok.kim@imgtec.com
Cc: qemu-devel@nongnu.org, zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 target/mips/translate.c | 48 ------------------------------------------------
 1 file changed, 48 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 559f8fe..7c102a4 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5133,7 +5133,6 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "Context";
             break;
         case 1:
-//            gen_helper_mfc0_contextconfig(arg); /* SmartMIPS ASE */
             rn = "ContextConfig";
             goto cp0_unimplemented;
         case 2:
@@ -5455,19 +5454,15 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "Debug";
             break;
         case 1:
-//            gen_helper_mfc0_tracecontrol(arg); /* PDtrace support */
             rn = "TraceControl";
             goto cp0_unimplemented;
         case 2:
-//            gen_helper_mfc0_tracecontrol2(arg); /* PDtrace support */
             rn = "TraceControl2";
             goto cp0_unimplemented;
         case 3:
-//            gen_helper_mfc0_usertracedata(arg); /* PDtrace support */
             rn = "UserTraceData";
             goto cp0_unimplemented;
         case 4:
-//            gen_helper_mfc0_tracebpc(arg); /* PDtrace support */
             rn = "TraceBPC";
             goto cp0_unimplemented;
         default:
@@ -5493,31 +5488,24 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "Performance0";
             break;
         case 1:
-//            gen_helper_mfc0_performance1(arg);
             rn = "Performance1";
             goto cp0_unimplemented;
         case 2:
-//            gen_helper_mfc0_performance2(arg);
             rn = "Performance2";
             goto cp0_unimplemented;
         case 3:
-//            gen_helper_mfc0_performance3(arg);
             rn = "Performance3";
             goto cp0_unimplemented;
         case 4:
-//            gen_helper_mfc0_performance4(arg);
             rn = "Performance4";
             goto cp0_unimplemented;
         case 5:
-//            gen_helper_mfc0_performance5(arg);
             rn = "Performance5";
             goto cp0_unimplemented;
         case 6:
-//            gen_helper_mfc0_performance6(arg);
             rn = "Performance6";
             goto cp0_unimplemented;
         case 7:
-//            gen_helper_mfc0_performance7(arg);
             rn = "Performance7";
             goto cp0_unimplemented;
         default:
@@ -5785,7 +5773,6 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "Context";
             break;
         case 1:
-//            gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
             rn = "ContextConfig";
             goto cp0_unimplemented;
         case 2:
@@ -6110,13 +6097,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "Debug";
             break;
         case 1:
-//            gen_helper_mtc0_tracecontrol(cpu_env, arg); /* PDtrace support */
             rn = "TraceControl";
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
             goto cp0_unimplemented;
         case 2:
-//            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
             rn = "TraceControl2";
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
@@ -6124,13 +6109,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 3:
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
-//            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
             rn = "UserTraceData";
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
             goto cp0_unimplemented;
         case 4:
-//            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
             rn = "TraceBPC";
@@ -6157,31 +6140,24 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "Performance0";
             break;
         case 1:
-//            gen_helper_mtc0_performance1(arg);
             rn = "Performance1";
             goto cp0_unimplemented;
         case 2:
-//            gen_helper_mtc0_performance2(arg);
             rn = "Performance2";
             goto cp0_unimplemented;
         case 3:
-//            gen_helper_mtc0_performance3(arg);
             rn = "Performance3";
             goto cp0_unimplemented;
         case 4:
-//            gen_helper_mtc0_performance4(arg);
             rn = "Performance4";
             goto cp0_unimplemented;
         case 5:
-//            gen_helper_mtc0_performance5(arg);
             rn = "Performance5";
             goto cp0_unimplemented;
         case 6:
-//            gen_helper_mtc0_performance6(arg);
             rn = "Performance6";
             goto cp0_unimplemented;
         case 7:
-//            gen_helper_mtc0_performance7(arg);
             rn = "Performance7";
             goto cp0_unimplemented;
         default:
@@ -6447,7 +6423,6 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "Context";
             break;
         case 1:
-//            gen_helper_dmfc0_contextconfig(arg); /* SmartMIPS ASE */
             rn = "ContextConfig";
             goto cp0_unimplemented;
         case 2:
@@ -6762,19 +6737,15 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "Debug";
             break;
         case 1:
-//            gen_helper_dmfc0_tracecontrol(arg, cpu_env); /* PDtrace support */
             rn = "TraceControl";
             goto cp0_unimplemented;
         case 2:
-//            gen_helper_dmfc0_tracecontrol2(arg, cpu_env); /* PDtrace support */
             rn = "TraceControl2";
             goto cp0_unimplemented;
         case 3:
-//            gen_helper_dmfc0_usertracedata(arg, cpu_env); /* PDtrace support */
             rn = "UserTraceData";
             goto cp0_unimplemented;
         case 4:
-//            gen_helper_dmfc0_tracebpc(arg, cpu_env); /* PDtrace support */
             rn = "TraceBPC";
             goto cp0_unimplemented;
         default:
@@ -6799,31 +6770,24 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "Performance0";
             break;
         case 1:
-//            gen_helper_dmfc0_performance1(arg);
             rn = "Performance1";
             goto cp0_unimplemented;
         case 2:
-//            gen_helper_dmfc0_performance2(arg);
             rn = "Performance2";
             goto cp0_unimplemented;
         case 3:
-//            gen_helper_dmfc0_performance3(arg);
             rn = "Performance3";
             goto cp0_unimplemented;
         case 4:
-//            gen_helper_dmfc0_performance4(arg);
             rn = "Performance4";
             goto cp0_unimplemented;
         case 5:
-//            gen_helper_dmfc0_performance5(arg);
             rn = "Performance5";
             goto cp0_unimplemented;
         case 6:
-//            gen_helper_dmfc0_performance6(arg);
             rn = "Performance6";
             goto cp0_unimplemented;
         case 7:
-//            gen_helper_dmfc0_performance7(arg);
             rn = "Performance7";
             goto cp0_unimplemented;
         default:
@@ -7083,7 +7047,6 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "Context";
             break;
         case 1:
-//           gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
             rn = "ContextConfig";
             goto cp0_unimplemented;
         case 2:
@@ -7410,25 +7373,21 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "Debug";
             break;
         case 1:
-//            gen_helper_mtc0_tracecontrol(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
             rn = "TraceControl";
             goto cp0_unimplemented;
         case 2:
-//            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
             rn = "TraceControl2";
             goto cp0_unimplemented;
         case 3:
-//            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
             rn = "UserTraceData";
             goto cp0_unimplemented;
         case 4:
-//            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
             rn = "TraceBPC";
@@ -7455,31 +7414,24 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "Performance0";
             break;
         case 1:
-//            gen_helper_mtc0_performance1(cpu_env, arg);
             rn = "Performance1";
             goto cp0_unimplemented;
         case 2:
-//            gen_helper_mtc0_performance2(cpu_env, arg);
             rn = "Performance2";
             goto cp0_unimplemented;
         case 3:
-//            gen_helper_mtc0_performance3(cpu_env, arg);
             rn = "Performance3";
             goto cp0_unimplemented;
         case 4:
-//            gen_helper_mtc0_performance4(cpu_env, arg);
             rn = "Performance4";
             goto cp0_unimplemented;
         case 5:
-//            gen_helper_mtc0_performance5(cpu_env, arg);
             rn = "Performance5";
             goto cp0_unimplemented;
         case 6:
-//            gen_helper_mtc0_performance6(cpu_env, arg);
             rn = "Performance6";
             goto cp0_unimplemented;
         case 7:
-//            gen_helper_mtc0_performance7(cpu_env, arg);
             rn = "Performance7";
             goto cp0_unimplemented;
         default:
-- 
2.7.4
