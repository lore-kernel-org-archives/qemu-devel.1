Received: from eggs.gnu.org ([209.51.188.92]:35542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs4Dt-00088f-7v
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gs4Dq-0006Mh-Ti
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:21:32 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gs4Dn-0006Ii-KM
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:21:28 -0500
Received: by mail-wr1-x442.google.com with SMTP id r2so3112450wrv.10
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 03:21:24 -0800 (PST)
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-61-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190130004811.27372-61-cota@braap.org>
Date: Fri, 08 Feb 2019 11:21:22 +0000
Message-ID: <87a7j6msp9.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 60/73] cpu: convert to interrupt_request
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

> This finishes the conversion to interrupt_request.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  qom/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 00add81a7f..f2695be9b2 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -275,7 +275,7 @@ static void cpu_common_reset(CPUState *cpu)
>          log_cpu_state(cpu, cc->reset_dump_flags);
>      }
>
> -    cpu->interrupt_request =3D 0;
> +    cpu_interrupt_request_set(cpu, 0);
>      cpu_halted_set(cpu, 0);
>      cpu->mem_io_pc =3D 0;
>      cpu->mem_io_vaddr =3D 0;
> @@ -412,7 +412,7 @@ static vaddr cpu_adjust_watchpoint_address(CPUState *=
cpu, vaddr addr, int len)
>
>  static void generic_handle_interrupt(CPUState *cpu, int mask)
>  {
> -    cpu->interrupt_request |=3D mask;
> +    cpu_interrupt_request_or(cpu, mask);
>
>      if (!qemu_cpu_is_self(cpu)) {
>          qemu_cpu_kick(cpu);


--
Alex Benn=C3=A9e
