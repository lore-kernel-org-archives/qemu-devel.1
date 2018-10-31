Received: from eggs.gnu.org ([2001:4830:134:3::10]:42219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHp7H-0008WP-Lx
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHp7D-0008JF-HG
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:56:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHp7C-0008AF-Vc
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:56:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id s10-v6so14824870wmc.5
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 04:56:49 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-15-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-15-cota@braap.org>
Date: Wed, 31 Oct 2018 11:56:46 +0000
Message-ID: <87d0rq8h35.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 15/71] tcg-runtime: convert to
 cpu_halted_set
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

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/tcg-runtime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
> index 4aa038465f..70e3c9de71 100644
> --- a/accel/tcg/tcg-runtime.c
> +++ b/accel/tcg/tcg-runtime.c
> @@ -172,5 +172,5 @@ void HELPER(cpu_halted_set)(CPUArchState *env, uint32=
_t val)
>  {
>      CPUState *cpu =3D ENV_GET_CPU(env);
>
> -    cpu->halted =3D val;
> +    cpu_halted_set(cpu, val);
>  }


--
Alex Benn=C3=A9e
