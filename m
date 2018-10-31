Received: from eggs.gnu.org ([2001:4830:134:3::10]:38819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHoyT-0000Cv-FP
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHoyQ-0007X8-8x
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:47:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHoyP-0007A6-Uf
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:47:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id i17-v6so16081376wre.7
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 04:47:25 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-13-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-13-cota@braap.org>
Date: Wed, 31 Oct 2018 11:47:22 +0000
Message-ID: <87efc68hit.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 13/71] microblaze: convert to
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/microblaze/translate.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 78ca265b04..008b84d456 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1233,9 +1233,7 @@ static void dec_br(DisasContext *dc)
>              LOG_DIS("sleep\n");
>
>              t_sync_flags(dc);
> -            tcg_gen_st_i32(tmp_1, cpu_env,
> -                           -offsetof(MicroBlazeCPU, env)
> -                           +offsetof(CPUState, halted));
> +            gen_helper_cpu_halted_set(cpu_env, tmp_1);
>              tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc + 4);
>              gen_helper_raise_exception(cpu_env, tmp_hlt);
>              tcg_temp_free_i32(tmp_hlt);


--
Alex Benn=C3=A9e
