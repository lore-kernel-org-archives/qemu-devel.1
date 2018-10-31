Received: from eggs.gnu.org ([2001:4830:134:3::10]:49866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtU8-0001tC-L5
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtU5-0006OX-IE
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:36:48 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtU3-0006Mz-Ez
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:36:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id y15-v6so17217894wru.9
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:36:42 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-44-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-44-cota@braap.org>
Date: Wed, 31 Oct 2018 16:36:39 +0000
Message-ID: <87in1i6pk8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 44/71] cris: convert to
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/cris/cpu.c    | 2 +-
>  target/cris/helper.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/cris/cpu.c b/target/cris/cpu.c
> index a23aba2688..3cdba581e6 100644
> --- a/target/cris/cpu.c
> +++ b/target/cris/cpu.c
> @@ -37,7 +37,7 @@ static void cris_cpu_set_pc(CPUState *cs, vaddr value)
>
>  static bool cris_cpu_has_work(CPUState *cs)
>  {
> -    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_N=
MI);
> +    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRU=
PT_NMI);
>  }
>
>  /* CPUClass::reset() */
> diff --git a/target/cris/helper.c b/target/cris/helper.c
> index d2ec349191..e3fa19363f 100644
> --- a/target/cris/helper.c
> +++ b/target/cris/helper.c
> @@ -116,7 +116,7 @@ int cris_cpu_handle_mmu_fault(CPUState *cs, vaddr add=
ress, int size, int rw,
>      if (r > 0) {
>          qemu_log_mask(CPU_LOG_MMU,
>                  "%s returns %d irqreq=3D%x addr=3D%" VADDR_PRIx " phy=3D=
%x vec=3D%x"
> -                " pc=3D%x\n", __func__, r, cs->interrupt_request, addres=
s,
> +                " pc=3D%x\n", __func__, r, cpu_interrupt_request(cs), ad=
dress,
>                  res.phy, res.bf_vec, env->pc);
>      }
>      return r;
> @@ -130,7 +130,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
>
>      D_LOG("exception index=3D%d interrupt_req=3D%d\n",
>            cs->exception_index,
> -          cs->interrupt_request);
> +          cpu_interrupt_request(cs));
>
>      if (env->dslot) {
>          /* CRISv10 never takes interrupts while in a delay-slot.  */
> @@ -192,7 +192,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
>
>      D_LOG("exception index=3D%d interrupt_req=3D%d\n",
>            cs->exception_index,
> -          cs->interrupt_request);
> +          cpu_interrupt_request(cs));
>
>      switch (cs->exception_index) {
>      case EXCP_BREAK:


--
Alex Benn=C3=A9e
