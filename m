Received: from eggs.gnu.org ([2001:4830:134:3::10]:36890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRSo-0001pt-Af
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRSj-0004yw-Qk
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:00:46 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:63847)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRSj-0004yh-GY
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:00:41 -0400
References: <20170304185652.10675-1-f4bug@amsat.org>
	<20170304185652.10675-5-f4bug@amsat.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <d63db7d0-61aa-c30e-298f-08036f16bb43@imgtec.com>
Date: Mon, 13 Mar 2017 15:00:38 +0000
MIME-Version: 1.0
In-Reply-To: <20170304185652.10675-5-f4bug@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] target-mips: replace break by goto
 cp0_unimplemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org



On 04/03/2017 18:56, Philippe Mathieu-Daud=C3=A9 wrote:
> this fixes many warnings like:
>=20
> target/mips/translate.c:6253:13: warning: Value stored to 'rn' is never=
 read
>             rn =3D "invalid sel";
>             ^    ~~~~~~~~~~~~~
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/mips/translate.c | 88 ++++++++++++++++++++++++-----------------=
--------
>  1 file changed, 44 insertions(+), 44 deletions(-)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 5c030a90cd..fc11e15a17 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -5458,19 +5458,19 @@ static void gen_mfc0(DisasContext *ctx, TCGv ar=
g, int reg, int sel)
>          case 1:
>  //            gen_helper_mfc0_tracecontrol(arg); /* PDtrace support */
>              rn =3D "TraceControl";
> -//            break;
> +            goto cp0_unimplemented;
>          case 2:
>  //            gen_helper_mfc0_tracecontrol2(arg); /* PDtrace support *=
/
>              rn =3D "TraceControl2";
> -//            break;
> +            goto cp0_unimplemented;
>          case 3:
>  //            gen_helper_mfc0_usertracedata(arg); /* PDtrace support *=
/
>              rn =3D "UserTraceData";
> -//            break;
> +            goto cp0_unimplemented;
>          case 4:
>  //            gen_helper_mfc0_tracebpc(arg); /* PDtrace support */
>              rn =3D "TraceBPC";
> -//            break;
> +            goto cp0_unimplemented;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -5496,31 +5496,31 @@ static void gen_mfc0(DisasContext *ctx, TCGv ar=
g, int reg, int sel)
>          case 1:
>  //            gen_helper_mfc0_performance1(arg);
>              rn =3D "Performance1";
> -//            break;
> +            goto cp0_unimplemented;
>          case 2:
>  //            gen_helper_mfc0_performance2(arg);
>              rn =3D "Performance2";
> -//            break;
> +            goto cp0_unimplemented;
>          case 3:
>  //            gen_helper_mfc0_performance3(arg);
>              rn =3D "Performance3";
> -//            break;
> +            goto cp0_unimplemented;
>          case 4:
>  //            gen_helper_mfc0_performance4(arg);
>              rn =3D "Performance4";
> -//            break;
> +            goto cp0_unimplemented;
>          case 5:
>  //            gen_helper_mfc0_performance5(arg);
>              rn =3D "Performance5";
> -//            break;
> +            goto cp0_unimplemented;
>          case 6:
>  //            gen_helper_mfc0_performance6(arg);
>              rn =3D "Performance6";
> -//            break;
> +            goto cp0_unimplemented;
>          case 7:
>  //            gen_helper_mfc0_performance7(arg);
>              rn =3D "Performance7";
> -//            break;
> +            goto cp0_unimplemented;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -6116,13 +6116,13 @@ static void gen_mtc0(DisasContext *ctx, TCGv ar=
g, int reg, int sel)
>              rn =3D "TraceControl";
>              /* Stop translation as we may have switched the execution =
mode */
>              ctx->bstate =3D BS_STOP;
> -//            break;
> +            goto cp0_unimplemented;
>          case 2:
>  //            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace =
support */
>              rn =3D "TraceControl2";
>              /* Stop translation as we may have switched the execution =
mode */
>              ctx->bstate =3D BS_STOP;
> -//            break;
> +            goto cp0_unimplemented;
>          case 3:
>              /* Stop translation as we may have switched the execution =
mode */
>              ctx->bstate =3D BS_STOP;
> @@ -6130,13 +6130,13 @@ static void gen_mtc0(DisasContext *ctx, TCGv ar=
g, int reg, int sel)
>              rn =3D "UserTraceData";
>              /* Stop translation as we may have switched the execution =
mode */
>              ctx->bstate =3D BS_STOP;
> -//            break;
> +            goto cp0_unimplemented;
>          case 4:
>  //            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace suppo=
rt */
>              /* Stop translation as we may have switched the execution =
mode */
>              ctx->bstate =3D BS_STOP;
>              rn =3D "TraceBPC";
> -//            break;
> +            goto cp0_unimplemented;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -6161,31 +6161,31 @@ static void gen_mtc0(DisasContext *ctx, TCGv ar=
g, int reg, int sel)
>          case 1:
>  //            gen_helper_mtc0_performance1(arg);
>              rn =3D "Performance1";
> -//            break;
> +            goto cp0_unimplemented;
>          case 2:
>  //            gen_helper_mtc0_performance2(arg);
>              rn =3D "Performance2";
> -//            break;
> +            goto cp0_unimplemented;
>          case 3:
>  //            gen_helper_mtc0_performance3(arg);
>              rn =3D "Performance3";
> -//            break;
> +            goto cp0_unimplemented;
>          case 4:
>  //            gen_helper_mtc0_performance4(arg);
>              rn =3D "Performance4";
> -//            break;
> +            goto cp0_unimplemented;
>          case 5:
>  //            gen_helper_mtc0_performance5(arg);
>              rn =3D "Performance5";
> -//            break;
> +            goto cp0_unimplemented;
>          case 6:
>  //            gen_helper_mtc0_performance6(arg);
>              rn =3D "Performance6";
> -//            break;
> +            goto cp0_unimplemented;
>          case 7:
>  //            gen_helper_mtc0_performance7(arg);
>              rn =3D "Performance7";
> -//            break;
> +            goto cp0_unimplemented;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -6766,19 +6766,19 @@ static void gen_dmfc0(DisasContext *ctx, TCGv a=
rg, int reg, int sel)
>          case 1:
>  //            gen_helper_dmfc0_tracecontrol(arg, cpu_env); /* PDtrace =
support */
>              rn =3D "TraceControl";
> -//            break;
> +            goto cp0_unimplemented;
>          case 2:
>  //            gen_helper_dmfc0_tracecontrol2(arg, cpu_env); /* PDtrace=
 support */
>              rn =3D "TraceControl2";
> -//            break;
> +            goto cp0_unimplemented;
>          case 3:
>  //            gen_helper_dmfc0_usertracedata(arg, cpu_env); /* PDtrace=
 support */
>              rn =3D "UserTraceData";
> -//            break;
> +            goto cp0_unimplemented;
>          case 4:
>  //            gen_helper_dmfc0_tracebpc(arg, cpu_env); /* PDtrace supp=
ort */
>              rn =3D "TraceBPC";
> -//            break;
> +            goto cp0_unimplemented;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -6803,31 +6803,31 @@ static void gen_dmfc0(DisasContext *ctx, TCGv a=
rg, int reg, int sel)
>          case 1:
>  //            gen_helper_dmfc0_performance1(arg);
>              rn =3D "Performance1";
> -//            break;
> +            goto cp0_unimplemented;
>          case 2:
>  //            gen_helper_dmfc0_performance2(arg);
>              rn =3D "Performance2";
> -//            break;
> +            goto cp0_unimplemented;
>          case 3:
>  //            gen_helper_dmfc0_performance3(arg);
>              rn =3D "Performance3";
> -//            break;
> +            goto cp0_unimplemented;
>          case 4:
>  //            gen_helper_dmfc0_performance4(arg);
>              rn =3D "Performance4";
> -//            break;
> +            goto cp0_unimplemented;
>          case 5:
>  //            gen_helper_dmfc0_performance5(arg);
>              rn =3D "Performance5";
> -//            break;
> +            goto cp0_unimplemented;
>          case 6:
>  //            gen_helper_dmfc0_performance6(arg);
>              rn =3D "Performance6";
> -//            break;
> +            goto cp0_unimplemented;
>          case 7:
>  //            gen_helper_dmfc0_performance7(arg);
>              rn =3D "Performance7";
> -//            break;
> +            goto cp0_unimplemented;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -7417,25 +7417,25 @@ static void gen_dmtc0(DisasContext *ctx, TCGv a=
rg, int reg, int sel)
>              /* Stop translation as we may have switched the execution =
mode */
>              ctx->bstate =3D BS_STOP;
>              rn =3D "TraceControl";
> -//            break;
> +            goto cp0_unimplemented;
>          case 2:
>  //            gen_helper_mtc0_tracecontrol2(cpu_env, arg); /* PDtrace =
support */
>              /* Stop translation as we may have switched the execution =
mode */
>              ctx->bstate =3D BS_STOP;
>              rn =3D "TraceControl2";
> -//            break;
> +            goto cp0_unimplemented;
>          case 3:
>  //            gen_helper_mtc0_usertracedata(cpu_env, arg); /* PDtrace =
support */
>              /* Stop translation as we may have switched the execution =
mode */
>              ctx->bstate =3D BS_STOP;
>              rn =3D "UserTraceData";
> -//            break;
> +            goto cp0_unimplemented;
>          case 4:
>  //            gen_helper_mtc0_tracebpc(cpu_env, arg); /* PDtrace suppo=
rt */
>              /* Stop translation as we may have switched the execution =
mode */
>              ctx->bstate =3D BS_STOP;
>              rn =3D "TraceBPC";
> -//            break;
> +            goto cp0_unimplemented;
>          default:
>              goto cp0_unimplemented;
>          }
> @@ -7460,31 +7460,31 @@ static void gen_dmtc0(DisasContext *ctx, TCGv a=
rg, int reg, int sel)
>          case 1:
>  //            gen_helper_mtc0_performance1(cpu_env, arg);
>              rn =3D "Performance1";
> -//            break;
> +            goto cp0_unimplemented;
>          case 2:
>  //            gen_helper_mtc0_performance2(cpu_env, arg);
>              rn =3D "Performance2";
> -//            break;
> +            goto cp0_unimplemented;
>          case 3:
>  //            gen_helper_mtc0_performance3(cpu_env, arg);
>              rn =3D "Performance3";
> -//            break;
> +            goto cp0_unimplemented;
>          case 4:
>  //            gen_helper_mtc0_performance4(cpu_env, arg);
>              rn =3D "Performance4";
> -//            break;
> +            goto cp0_unimplemented;
>          case 5:
>  //            gen_helper_mtc0_performance5(cpu_env, arg);
>              rn =3D "Performance5";
> -//            break;
> +            goto cp0_unimplemented;
>          case 6:
>  //            gen_helper_mtc0_performance6(cpu_env, arg);
>              rn =3D "Performance6";
> -//            break;
> +            goto cp0_unimplemented;
>          case 7:
>  //            gen_helper_mtc0_performance7(cpu_env, arg);
>              rn =3D "Performance7";
> -//            break;
> +            goto cp0_unimplemented;
>          default:
>              goto cp0_unimplemented;
>          }
>=20

Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
