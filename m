Received: from eggs.gnu.org ([2001:4830:134:3::10]:33716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dxrk4-0001Q7-Tb
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dxrk1-00072B-NV
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:37:56 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:5982)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dxrk1-00070v-Dc
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:37:53 -0400
References: <1506677707-2758-1-git-send-email-jiang.biao2@zte.com.cn>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <48c15000-9b44-6200-5cf0-50ded4332b30@imgtec.com>
Date: Fri, 29 Sep 2017 10:37:47 +0100
MIME-Version: 1.0
In-Reply-To: <1506677707-2758-1-git-send-email-jiang.biao2@zte.com.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
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
To: Jiang Biao <jiang.biao2@zte.com.cn>, aurelien@aurel32.net
Cc: qemu-devel@nongnu.org, zhong.weidong@zte.com.cn
List-ID: <qemu-devel.nongnu.org>



On 29/09/2017 10:35, Jiang Biao wrote:
> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>  target/mips/translate.c | 48 ------------------------------------------------
>  1 file changed, 48 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 559f8fe..7c102a4 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -5133,7 +5133,6 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              rn = "Context";
>              break;
>          case 1:
> -//            gen_helper_mfc0_contextconfig(arg); /* SmartMIPS ASE */
>              rn = "ContextConfig";
>              goto cp0_unimplemented;
>          case 2:
> @@ -5455,19 +5454,15 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              rn = "Debug";
>              break;
>          case 1:
> -//            gen_helper_mfc0_tracecontrol(arg); /* PDtrace support */
>              rn = "TraceControl";
>              goto cp0_unimplemented;
>          case 2:
> -//            gen_helper_mfc0_tracecontrol2(arg); /* PDtrace support */
>              rn = "TraceControl2";
>              goto cp0_unimplemented;
>          case 3:
> -//            gen_helper_mfc0_usertracedata(arg); /* PDtrace support */
>              rn = "UserTraceData";
>              goto cp0_unimplemented;
>          case 4:
> -//            gen_helper_mfc0_tracebpc(arg); /* PDtrace support */
>              rn = "TraceBPC";
>              goto cp0_unimplemented;
>          default:
> @@ -5493,31 +5488,24 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              rn = "Performance0";
>              break;
>          case 1:
> -//            gen_helper_mfc0_performance1(arg);
>              rn = "Performance1";
>              goto cp0_unimplemented;
>          case 2:
> -//            gen_helper_mfc0_performance2(arg);
>              rn = "Performance2";
>              goto cp0_unimplemented;
>          case 3:
> -//            gen_helper_mfc0_performance3(arg);
>              rn = "Performance3";
>              goto cp0_unimplemented;
>          case 4:
> -//            gen_helper_mfc0_performance4(arg);
>              rn = "Performance4";
>              goto cp0_unimplemented;
>          case 5:
> -//            gen_helper_mfc0_performance5(arg);
>              rn = "Performance5";
>              goto cp0_unimplemented;
>          case 6:
> -//            gen_helper_mfc0_performance6(arg);
>              rn = "Performance6";
>              goto cp0_unimplemented;
>          case 7:
> -//            gen_helper_mfc0_performance7(arg);
>              rn = "Performance7";
>              goto cp0_unimplemented;
>          default:
> @@ -5785,7 +5773,6 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              rn = "Context";
>              break;
>          case 1:
> -//            gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
>              rn = "ContextConfig";
>              goto cp0_unimplemented;
>          case 2:
> @@ -6110,13 +6097,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              rn = "Debug";
>              break;
>          case 1:
> -//            gen_helper_mtc0_tracecontrol(cpu_env, arg); /* PDtrace support */
>              rn = "TraceControl";
>              /* Stop translation as we may have switched the execution mode */
>              ctx->bstate = BS_STOP;
>              goto cp0_unimplemented;
>          case 2:
> -//            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
>              rn = "TraceControl2";
>              /* Stop translation as we may have switched the execution mode */
>              ctx->bstate = BS_STOP;
> @@ -6124,13 +6109,11 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>          case 3:
>              /* Stop translation as we may have switched the execution mode */
>              ctx->bstate = BS_STOP;
> -//            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
>              rn = "UserTraceData";
>              /* Stop translation as we may have switched the execution mode */
>              ctx->bstate = BS_STOP;
>              goto cp0_unimplemented;
>          case 4:
> -//            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
>              /* Stop translation as we may have switched the execution mode */
>              ctx->bstate = BS_STOP;
>              rn = "TraceBPC";
> @@ -6157,31 +6140,24 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              rn = "Performance0";
>              break;
>          case 1:
> -//            gen_helper_mtc0_performance1(arg);
>              rn = "Performance1";
>              goto cp0_unimplemented;
>          case 2:
> -//            gen_helper_mtc0_performance2(arg);
>              rn = "Performance2";
>              goto cp0_unimplemented;
>          case 3:
> -//            gen_helper_mtc0_performance3(arg);
>              rn = "Performance3";
>              goto cp0_unimplemented;
>          case 4:
> -//            gen_helper_mtc0_performance4(arg);
>              rn = "Performance4";
>              goto cp0_unimplemented;
>          case 5:
> -//            gen_helper_mtc0_performance5(arg);
>              rn = "Performance5";
>              goto cp0_unimplemented;
>          case 6:
> -//            gen_helper_mtc0_performance6(arg);
>              rn = "Performance6";
>              goto cp0_unimplemented;
>          case 7:
> -//            gen_helper_mtc0_performance7(arg);
>              rn = "Performance7";
>              goto cp0_unimplemented;
>          default:
> @@ -6447,7 +6423,6 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              rn = "Context";
>              break;
>          case 1:
> -//            gen_helper_dmfc0_contextconfig(arg); /* SmartMIPS ASE */
>              rn = "ContextConfig";
>              goto cp0_unimplemented;
>          case 2:
> @@ -6762,19 +6737,15 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              rn = "Debug";
>              break;
>          case 1:
> -//            gen_helper_dmfc0_tracecontrol(arg, cpu_env); /* PDtrace support */
>              rn = "TraceControl";
>              goto cp0_unimplemented;
>          case 2:
> -//            gen_helper_dmfc0_tracecontrol2(arg, cpu_env); /* PDtrace support */
>              rn = "TraceControl2";
>              goto cp0_unimplemented;
>          case 3:
> -//            gen_helper_dmfc0_usertracedata(arg, cpu_env); /* PDtrace support */
>              rn = "UserTraceData";
>              goto cp0_unimplemented;
>          case 4:
> -//            gen_helper_dmfc0_tracebpc(arg, cpu_env); /* PDtrace support */
>              rn = "TraceBPC";
>              goto cp0_unimplemented;
>          default:
> @@ -6799,31 +6770,24 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              rn = "Performance0";
>              break;
>          case 1:
> -//            gen_helper_dmfc0_performance1(arg);
>              rn = "Performance1";
>              goto cp0_unimplemented;
>          case 2:
> -//            gen_helper_dmfc0_performance2(arg);
>              rn = "Performance2";
>              goto cp0_unimplemented;
>          case 3:
> -//            gen_helper_dmfc0_performance3(arg);
>              rn = "Performance3";
>              goto cp0_unimplemented;
>          case 4:
> -//            gen_helper_dmfc0_performance4(arg);
>              rn = "Performance4";
>              goto cp0_unimplemented;
>          case 5:
> -//            gen_helper_dmfc0_performance5(arg);
>              rn = "Performance5";
>              goto cp0_unimplemented;
>          case 6:
> -//            gen_helper_dmfc0_performance6(arg);
>              rn = "Performance6";
>              goto cp0_unimplemented;
>          case 7:
> -//            gen_helper_dmfc0_performance7(arg);
>              rn = "Performance7";
>              goto cp0_unimplemented;
>          default:
> @@ -7083,7 +7047,6 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              rn = "Context";
>              break;
>          case 1:
> -//           gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS ASE */
>              rn = "ContextConfig";
>              goto cp0_unimplemented;
>          case 2:
> @@ -7410,25 +7373,21 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              rn = "Debug";
>              break;
>          case 1:
> -//            gen_helper_mtc0_tracecontrol(cpu_env, arg); /* PDtrace support */
>              /* Stop translation as we may have switched the execution mode */
>              ctx->bstate = BS_STOP;
>              rn = "TraceControl";
>              goto cp0_unimplemented;
>          case 2:
> -//            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace support */
>              /* Stop translation as we may have switched the execution mode */
>              ctx->bstate = BS_STOP;
>              rn = "TraceControl2";
>              goto cp0_unimplemented;
>          case 3:
> -//            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace support */
>              /* Stop translation as we may have switched the execution mode */
>              ctx->bstate = BS_STOP;
>              rn = "UserTraceData";
>              goto cp0_unimplemented;
>          case 4:
> -//            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace support */
>              /* Stop translation as we may have switched the execution mode */
>              ctx->bstate = BS_STOP;
>              rn = "TraceBPC";
> @@ -7455,31 +7414,24 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>              rn = "Performance0";
>              break;
>          case 1:
> -//            gen_helper_mtc0_performance1(cpu_env, arg);
>              rn = "Performance1";
>              goto cp0_unimplemented;
>          case 2:
> -//            gen_helper_mtc0_performance2(cpu_env, arg);
>              rn = "Performance2";
>              goto cp0_unimplemented;
>          case 3:
> -//            gen_helper_mtc0_performance3(cpu_env, arg);
>              rn = "Performance3";
>              goto cp0_unimplemented;
>          case 4:
> -//            gen_helper_mtc0_performance4(cpu_env, arg);
>              rn = "Performance4";
>              goto cp0_unimplemented;
>          case 5:
> -//            gen_helper_mtc0_performance5(cpu_env, arg);
>              rn = "Performance5";
>              goto cp0_unimplemented;
>          case 6:
> -//            gen_helper_mtc0_performance6(cpu_env, arg);
>              rn = "Performance6";
>              goto cp0_unimplemented;
>          case 7:
> -//            gen_helper_mtc0_performance7(cpu_env, arg);
>              rn = "Performance7";
>              goto cp0_unimplemented;
>          default:
> 

Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>

Regards,
Yongbok
