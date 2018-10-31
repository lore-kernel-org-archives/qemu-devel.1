Received: from eggs.gnu.org ([2001:4830:134:3::10]:33597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHrMs-00015y-3z
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHrMm-0007KD-IG
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:21:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHrMl-0007H4-TT
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:21:04 -0400
Received: by mail-wm1-x343.google.com with SMTP id y144-v6so14655350wmd.4
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 07:21:00 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-20-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-20-cota@braap.org>
Date: Wed, 31 Oct 2018 14:20:57 +0000
Message-ID: <875zxi8aeu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 20/71] lm32: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Michael Walle <michael@walle.cc>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/lm32/op_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
> index 234d55e056..392634441b 100644
> --- a/target/lm32/op_helper.c
> +++ b/target/lm32/op_helper.c
> @@ -31,7 +31,7 @@ void HELPER(hlt)(CPULM32State *env)
>  {
>      CPUState *cs =3D CPU(lm32_env_get_cpu(env));
>
> -    cs->halted =3D 1;
> +    cpu_halted_set(cs, 1);
>      cs->exception_index =3D EXCP_HLT;
>      cpu_loop_exit(cs);
>  }
> @@ -44,7 +44,7 @@ void HELPER(ill)(CPULM32State *env)
>              "Connect a debugger or switch to the monitor console "
>              "to find out more.\n");
>      vm_stop(RUN_STATE_PAUSED);
> -    cs->halted =3D 1;
> +    cpu_halted_set(cs, 1);
>      raise_exception(env, EXCP_HALTED);
>  #endif
>  }


--
Alex Benn=C3=A9e
