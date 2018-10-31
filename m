Received: from eggs.gnu.org ([2001:4830:134:3::10]:38426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHowp-0006Ro-5C
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHowj-0005ki-Jr
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:46:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHowj-0005jp-By
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:46:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id y16so16127451wrw.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 04:46:01 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-12-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-12-cota@braap.org>
Date: Wed, 31 Oct 2018 11:45:58 +0000
Message-ID: <87ftwm8hl5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 12/71] alpha: convert to
 helper_cpu_halted_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/alpha/translate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index e5d62850c5..25cd95931d 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -1226,8 +1226,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx=
, int palcode)
>              /* WTINT */
>              {
>                  TCGv_i32 tmp =3D tcg_const_i32(1);
> -                tcg_gen_st_i32(tmp, cpu_env, -offsetof(AlphaCPU, env) +
> -                                             offsetof(CPUState, halted));
> +                gen_helper_cpu_halted_set(cpu_env, tmp);
>                  tcg_temp_free_i32(tmp);
>              }
>              tcg_gen_movi_i64(ctx->ir[IR_V0], 0);
> @@ -1382,8 +1381,7 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TC=
Gv vb, int regno)
>          /* WAIT */
>          {
>              TCGv_i32 tmp =3D tcg_const_i32(1);
> -            tcg_gen_st_i32(tmp, cpu_env, -offsetof(AlphaCPU, env) +
> -                                         offsetof(CPUState, halted));
> +            gen_helper_cpu_halted_set(cpu_env, tmp);
>              tcg_temp_free_i32(tmp);
>          }
>          return gen_excp(ctx, EXCP_HALTED, 0);


--
Alex Benn=C3=A9e
