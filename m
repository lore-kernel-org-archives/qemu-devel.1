Received: from eggs.gnu.org ([2001:4830:134:3::10]:37229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dxs3k-0005cV-8y
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dxs3h-0001LA-6V
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:58:16 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dxs3g-0001Jz-UE
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:58:13 -0400
Received: by mail-pg0-x243.google.com with SMTP id u136so1116080pgc.0
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 02:58:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506677707-2758-1-git-send-email-jiang.biao2@zte.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5e146f0b-3c7c-b0a7-cea2-1d20bfcfc2d2@amsat.org>
Date: Fri, 29 Sep 2017 06:58:08 -0300
MIME-Version: 1.0
In-Reply-To: <1506677707-2758-1-git-send-email-jiang.biao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/mips: remove commented out codes in
 translate.c
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Jiang Biao <jiang.biao2@zte.com.cn>, aurelien@aurel32.net, yongbok.kim@imgtec.com
Cc: zhong.weidong@zte.com.cn, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Hi Jiang,

I'm not sure it is really helpful to remove those comment, they are here 
as debt to the project, reminding what should be implemented.

Are you proposing to accept this instructions will never get implemented?

Regards,

Phil.

On 09/29/2017 06:35 AM, Jiang Biao wrote:
> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>   target/mips/translate.c | 48 ------------------------------------------------
>   1 file changed, 48 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 559f8fe..7c102a4 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -5133,7 +5133,6 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>               rn = "Context";
>               break;
>           case 1:
> -//            gen_helper_mfc0_contextconfig(arg); /* SmartMIPS ASE */
>               rn = "ContextConfig";
>               goto cp0_unimplemented;
>           case 2:
> @@ -5455,19 +5454,15 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>               rn = "Debug";
>               break;
>           case 1:
> -//            gen_helper_mfc0_tracecontrol(arg); /* PDtrace support */
>               rn = "TraceControl";
>               goto cp0_unimplemented;
>           case 2:
> -//            gen_helper_mfc0_tracecontrol2(arg); /* PDtrace support */
>               rn = "TraceControl2";
>               goto cp0_unimplemented;
>           case 3:
> -//            gen_helper_mfc0_usertracedata(arg); /* PDtrace support */
>               rn = "UserTraceData";
>               goto cp0_unimplemented;
>           case 4:
> -//            gen_helper_mfc0_tracebpc(arg); /* PDtrace support */
>               rn = "TraceBPC";
>               goto cp0_unimplemented;
>           default:
> @@ -5493,31 +5488,24 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>               rn = "Performance0";
>               break;
>           case 1:
> -//            gen_helper_mfc0_performance1(arg);
>               rn = "Performance1";
>               goto cp0_unimplemented;
>           case 2:
> -//            gen_helper_mfc0_performance2(arg);
>               rn = "Performance2";
>               goto cp0_unimplemented;
>           case 3:
> -//            gen_helper_mfc0_performance3(arg);
>               rn = "Performance3";
>               goto cp0_unimplemented;
>           case 4:
> -//            gen_helper_mfc0_performance4(arg);
>               rn = "Performance4";
>               goto cp0_unimplemented;
>           case 5:
> -//            gen_helper_mfc0_performance5(arg);
>               rn = "Performance5";
>               goto cp0_unimplemented;
>           case 6:
> -//            gen_helper_mfc0_performance6(arg);
>               rn = "Performance6";
>               goto cp0_unimplemented;
>           case 7:
> -//            gen_helper_mfc0_performance7(arg);
>               rn = "Performance7";
>               goto cp0_unimplemented;
>           default:
> @@ -5785,7 +5773,6 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>               rn = "Context";
>               break;
>           case 1:
> -//            gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
>               rn = "ContextConfig";
>               goto cp0_unimplemented;
>           case 2:
> @@ -6110,13 +6097,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>               rn = "Debug";
>               break;
>           case 1:
> -//            gen_helper_mtc0_tracecontrol(cpu_env, arg); /* PDtrace support */
>               rn = "TraceControl";
>               /* Stop translation as we may have switched the execution mode */
>               ctx->bstate = BS_STOP;
>               goto cp0_unimplemented;
>           case 2:
> -//            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
>               rn = "TraceControl2";
>               /* Stop translation as we may have switched the execution mode */
>               ctx->bstate = BS_STOP;
> @@ -6124,13 +6109,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>           case 3:
>               /* Stop translation as we may have switched the execution mode */
>               ctx->bstate = BS_STOP;
> -//            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
>               rn = "UserTraceData";
>               /* Stop translation as we may have switched the execution mode */
>               ctx->bstate = BS_STOP;
>               goto cp0_unimplemented;
>           case 4:
> -//            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
>               /* Stop translation as we may have switched the execution mode */
>               ctx->bstate = BS_STOP;
>               rn = "TraceBPC";
> @@ -6157,31 +6140,24 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>               rn = "Performance0";
>               break;
>           case 1:
> -//            gen_helper_mtc0_performance1(arg);
>               rn = "Performance1";
>               goto cp0_unimplemented;
>           case 2:
> -//            gen_helper_mtc0_performance2(arg);
>               rn = "Performance2";
>               goto cp0_unimplemented;
>           case 3:
> -//            gen_helper_mtc0_performance3(arg);
>               rn = "Performance3";
>               goto cp0_unimplemented;
>           case 4:
> -//            gen_helper_mtc0_performance4(arg);
>               rn = "Performance4";
>               goto cp0_unimplemented;
>           case 5:
> -//            gen_helper_mtc0_performance5(arg);
>               rn = "Performance5";
>               goto cp0_unimplemented;
>           case 6:
> -//            gen_helper_mtc0_performance6(arg);
>               rn = "Performance6";
>               goto cp0_unimplemented;
>           case 7:
> -//            gen_helper_mtc0_performance7(arg);
>               rn = "Performance7";
>               goto cp0_unimplemented;
>           default:
> @@ -6447,7 +6423,6 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>               rn = "Context";
>               break;
>           case 1:
> -//            gen_helper_dmfc0_contextconfig(arg); /* SmartMIPS ASE */
>               rn = "ContextConfig";
>               goto cp0_unimplemented;
>           case 2:
> @@ -6762,19 +6737,15 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>               rn = "Debug";
>               break;
>           case 1:
> -//            gen_helper_dmfc0_tracecontrol(arg, cpu_env); /* PDtrace support */
>               rn = "TraceControl";
>               goto cp0_unimplemented;
>           case 2:
> -//            gen_helper_dmfc0_tracecontrol2(arg, cpu_env); /* PDtrace support */
>               rn = "TraceControl2";
>               goto cp0_unimplemented;
>           case 3:
> -//            gen_helper_dmfc0_usertracedata(arg, cpu_env); /* PDtrace support */
>               rn = "UserTraceData";
>               goto cp0_unimplemented;
>           case 4:
> -//            gen_helper_dmfc0_tracebpc(arg, cpu_env); /* PDtrace support */
>               rn = "TraceBPC";
>               goto cp0_unimplemented;
>           default:
> @@ -6799,31 +6770,24 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>               rn = "Performance0";
>               break;
>           case 1:
> -//            gen_helper_dmfc0_performance1(arg);
>               rn = "Performance1";
>               goto cp0_unimplemented;
>           case 2:
> -//            gen_helper_dmfc0_performance2(arg);
>               rn = "Performance2";
>               goto cp0_unimplemented;
>           case 3:
> -//            gen_helper_dmfc0_performance3(arg);
>               rn = "Performance3";
>               goto cp0_unimplemented;
>           case 4:
> -//            gen_helper_dmfc0_performance4(arg);
>               rn = "Performance4";
>               goto cp0_unimplemented;
>           case 5:
> -//            gen_helper_dmfc0_performance5(arg);
>               rn = "Performance5";
>               goto cp0_unimplemented;
>           case 6:
> -//            gen_helper_dmfc0_performance6(arg);
>               rn = "Performance6";
>               goto cp0_unimplemented;
>           case 7:
> -//            gen_helper_dmfc0_performance7(arg);
>               rn = "Performance7";
>               goto cp0_unimplemented;
>           default:
> @@ -7083,7 +7047,6 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>               rn = "Context";
>               break;
>           case 1:
> -//           gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
>               rn = "ContextConfig";
>               goto cp0_unimplemented;
>           case 2:
> @@ -7410,25 +7373,21 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>               rn = "Debug";
>               break;
>           case 1:
> -//            gen_helper_mtc0_tracecontrol(cpu_env, arg); /* PDtrace support */
>               /* Stop translation as we may have switched the execution mode */
>               ctx->bstate = BS_STOP;
>               rn = "TraceControl";
>               goto cp0_unimplemented;
>           case 2:
> -//            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
>               /* Stop translation as we may have switched the execution mode */
>               ctx->bstate = BS_STOP;
>               rn = "TraceControl2";
>               goto cp0_unimplemented;
>           case 3:
> -//            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
>               /* Stop translation as we may have switched the execution mode */
>               ctx->bstate = BS_STOP;
>               rn = "UserTraceData";
>               goto cp0_unimplemented;
>           case 4:
> -//            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
>               /* Stop translation as we may have switched the execution mode */
>               ctx->bstate = BS_STOP;
>               rn = "TraceBPC";
> @@ -7455,31 +7414,24 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>               rn = "Performance0";
>               break;
>           case 1:
> -//            gen_helper_mtc0_performance1(cpu_env, arg);
>               rn = "Performance1";
>               goto cp0_unimplemented;
>           case 2:
> -//            gen_helper_mtc0_performance2(cpu_env, arg);
>               rn = "Performance2";
>               goto cp0_unimplemented;
>           case 3:
> -//            gen_helper_mtc0_performance3(cpu_env, arg);
>               rn = "Performance3";
>               goto cp0_unimplemented;
>           case 4:
> -//            gen_helper_mtc0_performance4(cpu_env, arg);
>               rn = "Performance4";
>               goto cp0_unimplemented;
>           case 5:
> -//            gen_helper_mtc0_performance5(cpu_env, arg);
>               rn = "Performance5";
>               goto cp0_unimplemented;
>           case 6:
> -//            gen_helper_mtc0_performance6(cpu_env, arg);
>               rn = "Performance6";
>               goto cp0_unimplemented;
>           case 7:
> -//            gen_helper_mtc0_performance7(cpu_env, arg);
>               rn = "Performance7";
>               goto cp0_unimplemented;
>           default:
> 
