Received: from eggs.gnu.org ([2001:4830:134:3::10]:52616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtbp-0001ay-Vi
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtbm-0002uA-28
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:44:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtbl-0002lB-Pc
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:44:41 -0400
Received: by mail-wr1-x42f.google.com with SMTP id i17-v6so17202167wre.7
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:44:22 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-55-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-55-cota@braap.org>
Date: Wed, 31 Oct 2018 16:44:19 +0000
Message-ID: <871s866p7g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 55/71] unicore32: convert to
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/unicore32/cpu.c     | 2 +-
>  target/unicore32/softmmu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
> index 2b49d1ca40..65c5334551 100644
> --- a/target/unicore32/cpu.c
> +++ b/target/unicore32/cpu.c
> @@ -29,7 +29,7 @@ static void uc32_cpu_set_pc(CPUState *cs, vaddr value)
>
>  static bool uc32_cpu_has_work(CPUState *cs)
>  {
> -    return cs->interrupt_request &
> +    return cpu_interrupt_request(cs) &
>          (CPU_INTERRUPT_HARD | CPU_INTERRUPT_EXITTB);
>  }
>
> diff --git a/target/unicore32/softmmu.c b/target/unicore32/softmmu.c
> index 00c7e0d028..f58e2361e0 100644
> --- a/target/unicore32/softmmu.c
> +++ b/target/unicore32/softmmu.c
> @@ -119,7 +119,7 @@ void uc32_cpu_do_interrupt(CPUState *cs)
>      /* The PC already points to the proper instruction.  */
>      env->regs[30] =3D env->regs[31];
>      env->regs[31] =3D addr;
> -    cs->interrupt_request |=3D CPU_INTERRUPT_EXITTB;
> +    cpu_interrupt_request_or(cs, CPU_INTERRUPT_EXITTB);
>  }
>
>  static int get_phys_addr_ucv2(CPUUniCore32State *env, uint32_t address,


--
Alex Benn=C3=A9e
