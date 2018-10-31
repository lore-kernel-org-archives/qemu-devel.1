Received: from eggs.gnu.org ([2001:4830:134:3::10]:50943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtXO-0004n3-54
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtXJ-0007sq-Pd
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:40:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtXJ-0007sS-Ic
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:40:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id y15-v6so17230510wru.9
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:40:05 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-53-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-53-cota@braap.org>
Date: Wed, 31 Oct 2018 16:40:02 +0000
Message-ID: <875zxi6pel.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 53/71] sparc: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/sparc64/sparc64.c | 4 ++--
>  target/sparc/cpu.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
> index 372bbd4f5b..58faeb111a 100644
> --- a/hw/sparc64/sparc64.c
> +++ b/hw/sparc64/sparc64.c
> @@ -56,7 +56,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>      /* The bit corresponding to psrpil is (1<< psrpil), the next bit
>         is (2 << psrpil). */
>      if (pil < (2 << env->psrpil)) {
> -        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
> +        if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
>              trace_sparc64_cpu_check_irqs_reset_irq(env->interrupt_index);
>              env->interrupt_index =3D 0;
>              cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> @@ -87,7 +87,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>                  break;
>              }
>          }
> -    } else if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
> +    } else if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
>          trace_sparc64_cpu_check_irqs_disabled(pil, env->pil_in, env->sof=
tint,
>                                                env->interrupt_index);
>          env->interrupt_index =3D 0;
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 0f090ece54..88427283c1 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -709,7 +709,7 @@ static bool sparc_cpu_has_work(CPUState *cs)
>      SPARCCPU *cpu =3D SPARC_CPU(cs);
>      CPUSPARCState *env =3D &cpu->env;
>
> -    return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
> +    return (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
>             cpu_interrupts_enabled(env);
>  }


--
Alex Benn=C3=A9e
