Received: from eggs.gnu.org ([2001:4830:134:3::10]:50028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtUe-0002GS-D0
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtUX-0006dV-0u
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:37:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtUV-0006ZV-1e
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:37:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id w7-v6so4733177wmc.1
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:37:09 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-49-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-49-cota@braap.org>
Date: Wed, 31 Oct 2018 16:37:06 +0000
Message-ID: <87efc66pjh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 49/71] nios: convert to
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
Cc: qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Paolo Bonzini <pbonzini@redhat.com>, Chris Wulff <crwulff@gmail.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/nios2/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
> index fbfaa2ce26..49a75414d3 100644
> --- a/target/nios2/cpu.c
> +++ b/target/nios2/cpu.c
> @@ -36,7 +36,7 @@ static void nios2_cpu_set_pc(CPUState *cs, vaddr value)
>
>  static bool nios2_cpu_has_work(CPUState *cs)
>  {
> -    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_N=
MI);
> +    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRU=
PT_NMI);
>  }
>
>  /* CPUClass::reset() */


--
Alex Benn=C3=A9e
