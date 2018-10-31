Received: from eggs.gnu.org ([2001:4830:134:3::10]:50829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtX4-0004S5-WE
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtX0-0007k5-He
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:39:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtWx-0007ib-0G
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:39:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id r10-v6so17246469wrv.6
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:39:42 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-51-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-51-cota@braap.org>
Date: Wed, 31 Oct 2018 16:39:40 +0000
Message-ID: <878t2e6pf7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 51/71] alpha: convert to
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/alpha/cpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index a953897fcc..4e8965fb6c 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -42,10 +42,10 @@ static bool alpha_cpu_has_work(CPUState *cs)
>         assume that if a CPU really wants to stay asleep, it will mask
>         interrupts at the chipset level, which will prevent these bits
>         from being set in the first place.  */
> -    return cs->interrupt_request & (CPU_INTERRUPT_HARD
> -                                    | CPU_INTERRUPT_TIMER
> -                                    | CPU_INTERRUPT_SMP
> -                                    | CPU_INTERRUPT_MCHK);
> +    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD
> +                                        | CPU_INTERRUPT_TIMER
> +                                        | CPU_INTERRUPT_SMP
> +                                        | CPU_INTERRUPT_MCHK);
>  }
>
>  static void alpha_cpu_disas_set_info(CPUState *cpu, disassemble_info *in=
fo)


--
Alex Benn=C3=A9e
