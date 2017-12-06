Received: from eggs.gnu.org ([2001:4830:134:3::10]:45621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eMhjS-0003CW-Gm
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 16:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eMhjR-0006fY-NM
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 16:59:58 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:49214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1eMhjR-0006Kd-FN
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 16:59:57 -0500
Date: Wed, 6 Dec 2017 22:59:43 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20171206215943.GA17913@aurel32.net>
References: <20171205170013.22337-1-f4bug@amsat.org>
	<20171205170013.22337-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20171205170013.22337-3-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] target/sh4: add missing
 tcg_temp_free() in _decode_opc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-15?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Vladimir Prus <vladimir.prus@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

On 2017-12-05 14:00, Philippe Mathieu-Daud=E9 wrote:
> missed in c55497ecb8c and 852d481faf7.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  target/sh4/translate.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 5aeaabdd8d..62d01227fc 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -604,6 +604,7 @@ static void _decode_opc(DisasContext * ctx)
>  	    tcg_gen_subi_i32(addr, REG(B11_8), 4);
>              tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx, MO_TEUL);
>  	    tcg_gen_mov_i32(REG(B11_8), addr);
> +        tcg_temp_free(addr);
>  	}
>  	return;
>      case 0x6004:		/* mov.b @Rm+,Rn */
> @@ -1527,6 +1528,7 @@ static void _decode_opc(DisasContext * ctx)
>              tcg_gen_qemu_ld_i32(val, REG(B11_8), ctx->memidx, MO_TEUL);
>              gen_helper_movcal(cpu_env, REG(B11_8), val);
>              tcg_gen_qemu_st_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL=
);
> +            tcg_temp_free(val);
>          }
>          ctx->has_movcal =3D 1;
>  	return;

Good catch!

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
