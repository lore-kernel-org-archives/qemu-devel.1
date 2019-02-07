Received: from eggs.gnu.org ([209.51.188.92]:40382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1griz7-0007nE-FQ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1griz3-0003XE-Ob
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:40:51 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1griyx-0003S7-Tb
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:40:46 -0500
Received: by mail-wm1-x342.google.com with SMTP id p6so6528283wmc.1
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 04:40:36 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-9-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-9-cota@braap.org>
Date: Thu, 07 Feb 2019 12:40:34 +0000
Message-ID: <87tvhfn54t.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 08/73] tcg-runtime: define
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

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/tcg-runtime.h | 2 ++
>  accel/tcg/tcg-runtime.c | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index dfe325625c..46386bb564 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, pt=
r, env)
>
>  DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
>
> +DEF_HELPER_FLAGS_2(cpu_halted_set, TCG_CALL_NO_RWG, void, env, i32)
> +
>  #ifdef CONFIG_SOFTMMU
>
>  DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
> diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> index d0d4484406..4aa038465f 100644
> --- a/accel/tcg/tcg-runtime.c
> +++ b/accel/tcg/tcg-runtime.c
> @@ -167,3 +167,10 @@ void HELPER(exit_atomic)(CPUArchState *env)
>  {
>      cpu_loop_exit_atomic(ENV_GET_CPU(env), GETPC());
>  }
> +
> +void HELPER(cpu_halted_set)(CPUArchState *env, uint32_t val)
> +{
> +    CPUState *cpu =3D ENV_GET_CPU(env);
> +
> +    cpu->halted =3D val;
> +}


--
Alex Benn=C3=A9e
