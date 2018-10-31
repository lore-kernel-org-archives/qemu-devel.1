Received: from eggs.gnu.org ([2001:4830:134:3::10]:35025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHomp-0003v6-6n
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHoml-0002ct-6l
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:35:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHomk-0001nF-6O
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:35:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id d17-v6so15779899wre.11
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 04:35:12 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-8-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-8-cota@braap.org>
Date: Wed, 31 Oct 2018 11:35:09 +0000
Message-ID: <87lg6e8i36.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 08/71] ppc: convert to
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>


Emilio G. Cota <cota@braap.org> writes:

> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/ppc/translate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4e59dd5f42..2d31b5f7a1 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1609,8 +1609,7 @@ GEN_LOGICAL2(nor, tcg_gen_nor_tl, 0x03, PPC_INTEGER=
);
>  static void gen_pause(DisasContext *ctx)
>  {
>      TCGv_i32 t0 =3D tcg_const_i32(0);
> -    tcg_gen_st_i32(t0, cpu_env,
> -                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halte=
d));
> +    gen_helper_cpu_halted_set(cpu_env, t0);
>      tcg_temp_free_i32(t0);
>
>      /* Stop translation, this gives other CPUs a chance to run */
> @@ -3543,8 +3542,7 @@ static void gen_sync(DisasContext *ctx)
>  static void gen_wait(DisasContext *ctx)
>  {
>      TCGv_i32 t0 =3D tcg_const_i32(1);
> -    tcg_gen_st_i32(t0, cpu_env,
> -                   -offsetof(PowerPCCPU, env) + offsetof(CPUState, halte=
d));
> +    gen_helper_cpu_halted_set(cpu_env, t0);
>      tcg_temp_free_i32(t0);
>      /* Stop translation, as the CPU is supposed to sleep from now */
>      gen_exception_nip(ctx, EXCP_HLT, ctx->base.pc_next);


--
Alex Benn=C3=A9e
