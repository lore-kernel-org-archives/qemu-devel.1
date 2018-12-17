Received: from eggs.gnu.org ([2001:4830:134:3::10]:46690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYsSh-000267-5L
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYsSc-0001mQ-AY
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:57:31 -0500
Received: from chuckie.co.uk ([82.165.15.123]:52786
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gYsSc-0001lT-3y
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:57:26 -0500
References: <20181213050453.9677-1-cota@braap.org>
	<20181213050453.9677-56-cota@braap.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <33d65215-74ee-cd80-589e-f7244f3d66bd@ilande.co.uk>
Date: Mon, 17 Dec 2018 12:57:16 +0000
MIME-Version: 1.0
In-Reply-To: <20181213050453.9677-56-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 55/73] sparc: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>

On 13/12/2018 05:04, Emilio G. Cota wrote:

> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
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
>              env->interrupt_index = 0;
>              cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> @@ -87,7 +87,7 @@ void cpu_check_irqs(CPUSPARCState *env)
>                  break;
>              }
>          }
> -    } else if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
> +    } else if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
>          trace_sparc64_cpu_check_irqs_disabled(pil, env->pil_in, env->softint,
>                                                env->interrupt_index);
>          env->interrupt_index = 0;
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 0f090ece54..88427283c1 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -709,7 +709,7 @@ static bool sparc_cpu_has_work(CPUState *cs)
>      SPARCCPU *cpu = SPARC_CPU(cs);
>      CPUSPARCState *env = &cpu->env;
>  
> -    return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
> +    return (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
>             cpu_interrupts_enabled(env);
>  }

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
