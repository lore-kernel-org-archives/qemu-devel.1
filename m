Received: from eggs.gnu.org ([2001:4830:134:3::10]:50863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtX6-0004S7-9U
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtX5-0007mP-Kp
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:39:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtX5-0007la-Bn
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:39:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id x12-v6so17228638wrw.8
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:39:51 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-52-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-52-cota@braap.org>
Date: Wed, 31 Oct 2018 16:39:48 +0000
Message-ID: <877ehy6pez.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 52/71] moxie: convert to
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Green <green@moxielogic.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Anthony Green <green@moxielogic.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/moxie/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
> index 8d67eb6727..bad92cfc61 100644
> --- a/target/moxie/cpu.c
> +++ b/target/moxie/cpu.c
> @@ -33,7 +33,7 @@ static void moxie_cpu_set_pc(CPUState *cs, vaddr value)
>
>  static bool moxie_cpu_has_work(CPUState *cs)
>  {
> -    return cs->interrupt_request & CPU_INTERRUPT_HARD;
> +    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
>  }
>
>  static void moxie_cpu_reset(CPUState *s)


--
Alex Benn=C3=A9e
