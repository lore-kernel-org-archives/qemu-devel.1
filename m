Received: from eggs.gnu.org ([2001:4830:134:3::10]:40890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHt8l-0005zk-Ie
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHt8V-0007Iu-Kc
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:14:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHt8S-0007BA-4q
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:14:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id v24-v6so5874116wmh.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:14:14 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-28-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-28-cota@braap.org>
Date: Wed, 31 Oct 2018 16:14:11 +0000
Message-ID: <87wopy6qlo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 28/71] openrisc: convert to cpu_halted
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

> Cc: Stafford Horne <shorne@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/openrisc/sys_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index b66a45c1e0..ab4d8fb520 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -137,7 +137,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulon=
g spr, target_ulong rb)
>          if (env->pmr & PMR_DME || env->pmr & PMR_SME) {
>              cpu_restore_state(cs, GETPC(), true);
>              env->pc +=3D 4;
> -            cs->halted =3D 1;
> +            cpu_halted_set(cs, 1);
>              raise_exception(cpu, EXCP_HALTED);
>          }
>          break;


--
Alex Benn=C3=A9e
