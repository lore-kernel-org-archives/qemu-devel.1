Received: from eggs.gnu.org ([2001:4830:134:3::10]:52435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtbJ-0000uq-FM
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtb8-0002SW-MP
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:44:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtb8-0002Rl-Eu
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:44:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id x12-v6so17243953wrw.8
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:44:01 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-54-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-54-cota@braap.org>
Date: Wed, 31 Oct 2018 16:43:59 +0000
Message-ID: <8736sm6p80.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 54/71] openrisc: convert to
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Stafford Horne <shorne@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/openrisc/cputimer.c | 2 +-
>  target/openrisc/cpu.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
> index 850f88761c..739404e4f5 100644
> --- a/hw/openrisc/cputimer.c
> +++ b/hw/openrisc/cputimer.c
> @@ -102,7 +102,7 @@ static void openrisc_timer_cb(void *opaque)
>          CPUState *cs =3D CPU(cpu);
>
>          cpu->env.ttmr |=3D TTMR_IP;
> -        cs->interrupt_request |=3D CPU_INTERRUPT_TIMER;
> +        cpu_interrupt_request_or(cs, CPU_INTERRUPT_TIMER);
>      }
>
>      switch (cpu->env.ttmr & TTMR_M) {
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index fb7cb5c507..cdbc9353b7 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -32,8 +32,8 @@ static void openrisc_cpu_set_pc(CPUState *cs, vaddr val=
ue)
>
>  static bool openrisc_cpu_has_work(CPUState *cs)
>  {
> -    return cs->interrupt_request & (CPU_INTERRUPT_HARD |
> -                                    CPU_INTERRUPT_TIMER);
> +    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD |
> +                                        CPU_INTERRUPT_TIMER);
>  }
>
>  static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *inf=
o)


--
Alex Benn=C3=A9e
