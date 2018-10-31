Received: from eggs.gnu.org ([2001:4830:134:3::10]:49735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtTe-0001Xa-Oi
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtTa-0006Be-Ct
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:36:18 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtTX-0006A2-MS
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:36:14 -0400
Received: by mail-wm1-x342.google.com with SMTP id s10-v6so15767067wmc.5
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:36:10 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-43-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-43-cota@braap.org>
Date: Wed, 31 Oct 2018 16:36:08 +0000
Message-ID: <87k1ly6pl3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 43/71] sh4: convert to
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/sh4/cpu.c    | 2 +-
>  target/sh4/helper.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index b9f393b7c7..58ea212f53 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -45,7 +45,7 @@ static void superh_cpu_synchronize_from_tb(CPUState *cs=
, TranslationBlock *tb)
>
>  static bool superh_cpu_has_work(CPUState *cs)
>  {
> -    return cs->interrupt_request & CPU_INTERRUPT_HARD;
> +    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
>  }
>
>  /* CPUClass::reset() */
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index 2ff0cf4060..8463da5bc8 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -83,7 +83,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
>  {
>      SuperHCPU *cpu =3D SUPERH_CPU(cs);
>      CPUSH4State *env =3D &cpu->env;
> -    int do_irq =3D cs->interrupt_request & CPU_INTERRUPT_HARD;
> +    int do_irq =3D cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
>      int do_exp, irq_vector =3D cs->exception_index;
>
>      /* prioritize exceptions over interrupts */


--
Alex Benn=C3=A9e
