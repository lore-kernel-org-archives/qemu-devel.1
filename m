Received: from eggs.gnu.org ([2001:4830:134:3::10]:49366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtSp-00011Z-0w
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtSa-0005Dj-W8
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:35:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtST-00056L-Ni
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:35:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id n5-v6so17180567wrw.12
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:35:05 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-35-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-35-cota@braap.org>
Date: Wed, 31 Oct 2018 16:35:03 +0000
Message-ID: <87lg6e6pmw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 35/71] openrisc: use cpu_reset_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Cc: Stafford Horne <shorne@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/openrisc/sys_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index ab4d8fb520..c645cc896d 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -170,7 +170,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulon=
g spr, target_ulong rb)
>                  env->ttmr =3D (rb & ~TTMR_IP) | ip;
>              } else {    /* Clear IP bit.  */
>                  env->ttmr =3D rb & ~TTMR_IP;
> -                cs->interrupt_request &=3D ~CPU_INTERRUPT_TIMER;
> +                cpu_reset_interrupt(cs, CPU_INTERRUPT_TIMER);
>              }
>
>              cpu_openrisc_timer_update(cpu);


--
Alex Benn=C3=A9e
