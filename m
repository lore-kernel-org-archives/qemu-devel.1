Received: from eggs.gnu.org ([2001:4830:134:3::10]:45910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDoP-0000Yj-PD
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDoM-0008Qv-TJ
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:30:33 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDoJ-0008PS-P1
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:30:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id d10-v6so2431110wrs.5
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:30:25 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-38-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fe2729b7-60b1-bac6-2a3f-b9cec01f3c82@linaro.org>
Date: Sun, 21 Oct 2018 14:30:20 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-38-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 37/56] mips: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, James Hogan <jhogan@kernel.org>

On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> @@ -60,7 +60,7 @@ static bool mips_cpu_has_work(CPUState *cs)
>      /* Prior to MIPS Release 6 it is implementation dependent if non-enabled
>         interrupts wake-up the CPU, however most of the implementations only
>         check for interrupts that can be taken. */
> -    if ((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
> +    if ((cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
>          cpu_mips_hw_interrupts_pending(env)) {
>          if (cpu_mips_hw_interrupts_enabled(env) ||
>              (env->insn_flags & ISA_MIPS32R6)) {
> @@ -72,7 +72,7 @@ static bool mips_cpu_has_work(CPUState *cs)
>      if (env->CP0_Config3 & (1 << CP0C3_MT)) {
>          /* The QEMU model will issue an _WAKE request whenever the CPUs
>             should be woken up.  */
> -        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
> +        if (cpu_interrupt_request(cs) & CPU_INTERRUPT_WAKE) {
>              has_work = true;
>          }
>  
> @@ -82,7 +82,7 @@ static bool mips_cpu_has_work(CPUState *cs)
>      }
>      /* MIPS Release 6 has the ability to halt the CPU.  */
>      if (env->CP0_Config5 & (1 << CP0C5_VP)) {
> -        if (cs->interrupt_request & CPU_INTERRUPT_WAKE) {
> +        if (cpu_interrupt_request(cs) & CPU_INTERRUPT_WAKE) {
>              has_work = true;
>          }
>          if (!mips_vp_active(env)) {

Multiple calls.


r~
