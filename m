Received: from eggs.gnu.org ([2001:4830:134:3::10]:36546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRSJ-0001OZ-Ga
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRSF-0004i2-Ll
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:00:15 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:25728)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRSF-0004hn-GA
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:00:11 -0400
References: <20170304185652.10675-1-f4bug@amsat.org>
	<20170304185652.10675-3-f4bug@amsat.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <f3ca2944-46c9-6965-47d7-9533fdebb9f1@imgtec.com>
Date: Mon, 13 Mar 2017 15:00:10 +0000
MIME-Version: 1.0
In-Reply-To: <20170304185652.10675-3-f4bug@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] target-mips: remove old & unuseful
 comments
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/mips/translate.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 8b4a072ecb..1fe0ff39f2 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -5137,7 +5137,6 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
>  //            gen_helper_mfc0_contextconfig(arg); /* SmartMIPS ASE */
>              rn =3D "ContextConfig";
>              goto cp0_unimplemented;
> -//            break;
>          case 2:
>              CP0_CHECK(ctx->ulri);
>              tcg_gen_ld32s_tl(arg, cpu_env,
> @@ -5791,7 +5790,6 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
>  //            gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIP=
S ASE */
>              rn =3D "ContextConfig";
>              goto cp0_unimplemented;
> -//            break;
>          case 2:
>              CP0_CHECK(ctx->ulri);
>              tcg_gen_st_tl(arg, cpu_env,
> @@ -6454,7 +6452,6 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
>  //            gen_helper_dmfc0_contextconfig(arg); /* SmartMIPS ASE */
>              rn =3D "ContextConfig";
>              goto cp0_unimplemented;
> -//            break;
>          case 2:
>              CP0_CHECK(ctx->ulri);
>              tcg_gen_ld_tl(arg, cpu_env,
> @@ -7092,7 +7089,6 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
>  //           gen_helper_mtc0_contextconfig(cpu_env, arg); /* SmartMIPS=
 ASE */
>              rn =3D "ContextConfig";
>              goto cp0_unimplemented;
> -//           break;
>          case 2:
>              CP0_CHECK(ctx->ulri);
>              tcg_gen_st_tl(arg, cpu_env,
>=20

Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
