Received: from eggs.gnu.org ([2001:4830:134:3::10]:36697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRSZ-0001eE-SM
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRSU-0004mC-1u
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:00:31 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:12429)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRST-0004m5-Rd
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:00:25 -0400
References: <20170304185652.10675-1-f4bug@amsat.org>
	<20170304185652.10675-4-f4bug@amsat.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <4cd52fc8-ee8d-06a8-71c8-03e177377d1c@imgtec.com>
Date: Mon, 13 Mar 2017 15:00:24 +0000
MIME-Version: 1.0
In-Reply-To: <20170304185652.10675-4-f4bug@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] target-mips: log bad coprocessor0
 register accesses with LOG_UNIMP
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
>  target/mips/translate.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 1fe0ff39f2..5c030a90cd 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -4872,7 +4872,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
>      return;
> =20
>  cp0_unimplemented:
> -    LOG_DISAS("mfhc0 %s (reg %d sel %d)\n", rn, reg, sel);
> +    qemu_log_mask(LOG_UNIMP, "mfhc0 %s (reg %d sel %d)\n", rn, reg, se=
l);
>      tcg_gen_movi_tl(arg, 0);
>  }
> =20
> @@ -4944,7 +4944,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
> =20
>      (void)rn; /* avoid a compiler warning */
>  cp0_unimplemented:
> -    LOG_DISAS("mthc0 %s (reg %d sel %d)\n", rn, reg, sel);
> +    qemu_log_mask(LOG_UNIMP, "mthc0 %s (reg %d sel %d)\n", rn, reg, se=
l);
>  }
> =20
>  static inline void gen_mfc0_unimplemented(DisasContext *ctx, TCGv arg)
> @@ -5627,7 +5627,7 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
>      return;
> =20
>  cp0_unimplemented:
> -    LOG_DISAS("mfc0 %s (reg %d sel %d)\n", rn, reg, sel);
> +    qemu_log_mask(LOG_UNIMP, "mfc0 %s (reg %d sel %d)\n", rn, reg, sel=
);
>      gen_mfc0_unimplemented(ctx, arg);
>  }
> =20
> @@ -6294,7 +6294,7 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
>      return;
> =20
>  cp0_unimplemented:
> -    LOG_DISAS("mtc0 %s (reg %d sel %d)\n", rn, reg, sel);
> +    qemu_log_mask(LOG_UNIMP, "mtc0 %s (reg %d sel %d)\n", rn, reg, sel=
);
>  }
> =20
>  #if defined(TARGET_MIPS64)
> @@ -6928,7 +6928,7 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
>      return;
> =20
>  cp0_unimplemented:
> -    LOG_DISAS("dmfc0 %s (reg %d sel %d)\n", rn, reg, sel);
> +    qemu_log_mask(LOG_UNIMP, "dmfc0 %s (reg %d sel %d)\n", rn, reg, se=
l);
>      gen_mfc0_unimplemented(ctx, arg);
>  }
> =20
> @@ -7593,7 +7593,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
>      return;
> =20
>  cp0_unimplemented:
> -    LOG_DISAS("dmtc0 %s (reg %d sel %d)\n", rn, reg, sel);
> +    qemu_log_mask(LOG_UNIMP, "dmtc0 %s (reg %d sel %d)\n", rn, reg, se=
l);
>  }
>  #endif /* TARGET_MIPS64 */
> =20
>=20

Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
