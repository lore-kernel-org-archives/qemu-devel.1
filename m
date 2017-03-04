Received: from eggs.gnu.org ([2001:4830:134:3::10]:58116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEs3-0006sp-T7
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEs0-0008Et-R3
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:35 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:32984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEs0-0008El-MA
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:32 -0500
Received: by mail-qk0-x241.google.com with SMTP id j127so16936811qke.0
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 10:57:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  4 Mar 2017 15:56:51 -0300
Message-Id: <20170304185652.10675-5-f4bug@amsat.org>
In-Reply-To: <20170304185652.10675-1-f4bug@amsat.org>
References: <20170304185652.10675-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/5] target-mips: replace break by goto
 cp0_unimplemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

this fixes many warnings like:

target/mips/translate.c:6253:13: warning: Value stored to 'rn' is never read
            rn = "invalid sel";
            ^    ~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/translate.c | 88 ++++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 5c030a90cd..fc11e15a17 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5458,19 +5458,19 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 1:
 //            gen_helper_mfc0_tracecontrol(arg); /* PDtrace support */
             rn = "TraceControl";
-//            break;
+            goto cp0_unimplemented;
         case 2:
 //            gen_helper_mfc0_tracecontrol2(arg); /* PDtrace support */
             rn = "TraceControl2";
-//            break;
+            goto cp0_unimplemented;
         case 3:
 //            gen_helper_mfc0_usertracedata(arg); /* PDtrace support */
             rn = "UserTraceData";
-//            break;
+            goto cp0_unimplemented;
         case 4:
 //            gen_helper_mfc0_tracebpc(arg); /* PDtrace support */
             rn = "TraceBPC";
-//            break;
+            goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
         }
@@ -5496,31 +5496,31 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 1:
 //            gen_helper_mfc0_performance1(arg);
             rn = "Performance1";
-//            break;
+            goto cp0_unimplemented;
         case 2:
 //            gen_helper_mfc0_performance2(arg);
             rn = "Performance2";
-//            break;
+            goto cp0_unimplemented;
         case 3:
 //            gen_helper_mfc0_performance3(arg);
             rn = "Performance3";
-//            break;
+            goto cp0_unimplemented;
         case 4:
 //            gen_helper_mfc0_performance4(arg);
             rn = "Performance4";
-//            break;
+            goto cp0_unimplemented;
         case 5:
 //            gen_helper_mfc0_performance5(arg);
             rn = "Performance5";
-//            break;
+            goto cp0_unimplemented;
         case 6:
 //            gen_helper_mfc0_performance6(arg);
             rn = "Performance6";
-//            break;
+            goto cp0_unimplemented;
         case 7:
 //            gen_helper_mfc0_performance7(arg);
             rn = "Performance7";
-//            break;
+            goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
         }
@@ -6116,13 +6116,13 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "TraceControl";
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
-//            break;
+            goto cp0_unimplemented;
         case 2:
 //            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
             rn = "TraceControl2";
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
-//            break;
+            goto cp0_unimplemented;
         case 3:
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
@@ -6130,13 +6130,13 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             rn = "UserTraceData";
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
-//            break;
+            goto cp0_unimplemented;
         case 4:
 //            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
             rn = "TraceBPC";
-//            break;
+            goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
         }
@@ -6161,31 +6161,31 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 1:
 //            gen_helper_mtc0_performance1(arg);
             rn = "Performance1";
-//            break;
+            goto cp0_unimplemented;
         case 2:
 //            gen_helper_mtc0_performance2(arg);
             rn = "Performance2";
-//            break;
+            goto cp0_unimplemented;
         case 3:
 //            gen_helper_mtc0_performance3(arg);
             rn = "Performance3";
-//            break;
+            goto cp0_unimplemented;
         case 4:
 //            gen_helper_mtc0_performance4(arg);
             rn = "Performance4";
-//            break;
+            goto cp0_unimplemented;
         case 5:
 //            gen_helper_mtc0_performance5(arg);
             rn = "Performance5";
-//            break;
+            goto cp0_unimplemented;
         case 6:
 //            gen_helper_mtc0_performance6(arg);
             rn = "Performance6";
-//            break;
+            goto cp0_unimplemented;
         case 7:
 //            gen_helper_mtc0_performance7(arg);
             rn = "Performance7";
-//            break;
+            goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
         }
@@ -6766,19 +6766,19 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 1:
 //            gen_helper_dmfc0_tracecontrol(arg, cpu_env); /* PDtrace support */
             rn = "TraceControl";
-//            break;
+            goto cp0_unimplemented;
         case 2:
 //            gen_helper_dmfc0_tracecontrol2(arg, cpu_env); /* PDtrace support */
             rn = "TraceControl2";
-//            break;
+            goto cp0_unimplemented;
         case 3:
 //            gen_helper_dmfc0_usertracedata(arg, cpu_env); /* PDtrace support */
             rn = "UserTraceData";
-//            break;
+            goto cp0_unimplemented;
         case 4:
 //            gen_helper_dmfc0_tracebpc(arg, cpu_env); /* PDtrace support */
             rn = "TraceBPC";
-//            break;
+            goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
         }
@@ -6803,31 +6803,31 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 1:
 //            gen_helper_dmfc0_performance1(arg);
             rn = "Performance1";
-//            break;
+            goto cp0_unimplemented;
         case 2:
 //            gen_helper_dmfc0_performance2(arg);
             rn = "Performance2";
-//            break;
+            goto cp0_unimplemented;
         case 3:
 //            gen_helper_dmfc0_performance3(arg);
             rn = "Performance3";
-//            break;
+            goto cp0_unimplemented;
         case 4:
 //            gen_helper_dmfc0_performance4(arg);
             rn = "Performance4";
-//            break;
+            goto cp0_unimplemented;
         case 5:
 //            gen_helper_dmfc0_performance5(arg);
             rn = "Performance5";
-//            break;
+            goto cp0_unimplemented;
         case 6:
 //            gen_helper_dmfc0_performance6(arg);
             rn = "Performance6";
-//            break;
+            goto cp0_unimplemented;
         case 7:
 //            gen_helper_dmfc0_performance7(arg);
             rn = "Performance7";
-//            break;
+            goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
         }
@@ -7417,25 +7417,25 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
             rn = "TraceControl";
-//            break;
+            goto cp0_unimplemented;
         case 2:
 //            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
             rn = "TraceControl2";
-//            break;
+            goto cp0_unimplemented;
         case 3:
 //            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
             rn = "UserTraceData";
-//            break;
+            goto cp0_unimplemented;
         case 4:
 //            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
             /* Stop translation as we may have switched the execution mode */
             ctx->bstate = BS_STOP;
             rn = "TraceBPC";
-//            break;
+            goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
         }
@@ -7460,31 +7460,31 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         case 1:
 //            gen_helper_mtc0_performance1(cpu_env, arg);
             rn = "Performance1";
-//            break;
+            goto cp0_unimplemented;
         case 2:
 //            gen_helper_mtc0_performance2(cpu_env, arg);
             rn = "Performance2";
-//            break;
+            goto cp0_unimplemented;
         case 3:
 //            gen_helper_mtc0_performance3(cpu_env, arg);
             rn = "Performance3";
-//            break;
+            goto cp0_unimplemented;
         case 4:
 //            gen_helper_mtc0_performance4(cpu_env, arg);
             rn = "Performance4";
-//            break;
+            goto cp0_unimplemented;
         case 5:
 //            gen_helper_mtc0_performance5(cpu_env, arg);
             rn = "Performance5";
-//            break;
+            goto cp0_unimplemented;
         case 6:
 //            gen_helper_mtc0_performance6(cpu_env, arg);
             rn = "Performance6";
-//            break;
+            goto cp0_unimplemented;
         case 7:
 //            gen_helper_mtc0_performance7(cpu_env, arg);
             rn = "Performance7";
-//            break;
+            goto cp0_unimplemented;
         default:
             goto cp0_unimplemented;
         }
-- 
2.11.0
