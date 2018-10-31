Received: from eggs.gnu.org ([2001:4830:134:3::10]:43252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtFU-0004GN-FI
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtFT-0004pP-Nu
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:21:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtFS-0004lF-S0
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:21:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id g9-v6so17155725wrq.4
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:21:32 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-31-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-31-cota@braap.org>
Date: Wed, 31 Oct 2018 16:21:30 +0000
Message-ID: <87r2g66q9h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 31/71] ppc: use cpu_reset_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>


Emilio G. Cota <cota@braap.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/ppc/excp_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 5e1778584a..737c9c72be 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -880,7 +880,7 @@ bool ppc_cpu_exec_interrupt(CPUState *cs, int interru=
pt_request)
>      if (interrupt_request & CPU_INTERRUPT_HARD) {
>          ppc_hw_interrupt(env);
>          if (env->pending_interrupts =3D=3D 0) {
> -            cs->interrupt_request &=3D ~CPU_INTERRUPT_HARD;
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
>          }
>          return true;
>      }


--
Alex Benn=C3=A9e
