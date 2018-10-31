Received: from eggs.gnu.org ([2001:4830:134:3::10]:49966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtUN-000233-44
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtUI-0006Uy-99
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:37:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtUH-0006UU-Vk
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:36:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id y144-v6so15085829wmd.4
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:36:57 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-46-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-46-cota@braap.org>
Date: Wed, 31 Oct 2018 16:36:55 +0000
Message-ID: <87ftwm6pjs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 46/71] lm32: convert to
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Michael Walle <michael@walle.cc>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/lm32/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
> index b7499cb627..1508bb6199 100644
> --- a/target/lm32/cpu.c
> +++ b/target/lm32/cpu.c
> @@ -101,7 +101,7 @@ static void lm32_cpu_init_cfg_reg(LM32CPU *cpu)
>
>  static bool lm32_cpu_has_work(CPUState *cs)
>  {
> -    return cs->interrupt_request & CPU_INTERRUPT_HARD;
> +    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
>  }
>
>  /* CPUClass::reset() */


--
Alex Benn=C3=A9e
