Received: from eggs.gnu.org ([209.51.188.92]:59577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs3tZ-0001RD-So
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:00:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs3tV-00067s-8B
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:00:33 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gs3tV-000650-1V
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:00:29 -0500
Received: by mail-wm1-x343.google.com with SMTP id f16so2916467wmh.4
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 03:00:28 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-40-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-40-cota@braap.org>
Date: Fri, 08 Feb 2019 11:00:23 +0000
Message-ID: <87ef8imto8.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 39/73] i386: convert to
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
> ---
>  target/i386/cpu.c        | 2 +-
>  target/i386/helper.c     | 4 ++--
>  target/i386/svm_helper.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a37b984b61..35dea8c152 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5678,7 +5678,7 @@ int x86_cpu_pending_interrupt(CPUState *cs, int int=
errupt_request)
>
>  static bool x86_cpu_has_work(CPUState *cs)
>  {
> -    return x86_cpu_pending_interrupt(cs, cs->interrupt_request) !=3D 0;
> +    return x86_cpu_pending_interrupt(cs, cpu_interrupt_request(cs))
>  !=3D 0;

This is fine in itself but is there a chance of a race with the
env->eflags/hflags/hflags2 that x86_cpu_pending_interrupt deals with?
Are they only ever self vCPU references?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
