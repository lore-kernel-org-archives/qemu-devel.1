Received: from eggs.gnu.org ([2001:4830:134:3::10]:40643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHt88-0004we-S0
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHt85-0006xz-Gn
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:14:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHt85-0006tU-4L
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:14:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id 74-v6so8929937wrb.13
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:13:52 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-26-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-26-cota@braap.org>
Date: Wed, 31 Oct 2018 16:13:49 +0000
Message-ID: <87zhuu6qma.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 26/71] xtensa: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/xtensa/cpu.c       | 2 +-
>  target/xtensa/helper.c    | 2 +-
>  target/xtensa/op_helper.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index a54dbe4260..d4ca35e6cc 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -86,7 +86,7 @@ static void xtensa_cpu_reset(CPUState *s)
>
>  #ifndef CONFIG_USER_ONLY
>      reset_mmu(env);
> -    s->halted =3D env->runstall;
> +    cpu_halted_set(s, env->runstall);
>  #endif
>  }
>
> diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
> index 501082f55b..dd6819fbad 100644
> --- a/target/xtensa/helper.c
> +++ b/target/xtensa/helper.c
> @@ -807,7 +807,7 @@ void xtensa_runstall(CPUXtensaState *env, bool runsta=
ll)
>      CPUState *cpu =3D CPU(xtensa_env_get_cpu(env));
>
>      env->runstall =3D runstall;
> -    cpu->halted =3D runstall;
> +    cpu_halted_set(cpu, runstall);
>      if (runstall) {
>          cpu_interrupt(cpu, CPU_INTERRUPT_HALT);
>      } else {
> diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
> index e4b42ab3e5..510040b593 100644
> --- a/target/xtensa/op_helper.c
> +++ b/target/xtensa/op_helper.c
> @@ -414,7 +414,7 @@ void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, =
uint32_t intlevel)
>      }
>
>      cpu =3D CPU(xtensa_env_get_cpu(env));
> -    cpu->halted =3D 1;
> +    cpu_halted_set(cpu, 1);
>      HELPER(exception)(env, EXCP_HLT);
>  }


--
Alex Benn=C3=A9e
