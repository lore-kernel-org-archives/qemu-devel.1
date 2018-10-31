Received: from eggs.gnu.org ([2001:4830:134:3::10]:40944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHt8o-000621-Sj
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHt8o-0007Qe-0u
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:14:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHt8l-0007N6-TY
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:14:45 -0400
Received: by mail-wr1-x441.google.com with SMTP id u1-v6so17174508wrn.0
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:14:41 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-21-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-21-cota@braap.org>
Date: Wed, 31 Oct 2018 16:14:39 +0000
Message-ID: <87va5i6qkw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 21/71] m68k: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>


Emilio G. Cota <cota@braap.org> writes:

> Cc: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/m68k/op_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 8d09ed91c4..61ba1a6dec 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -237,7 +237,7 @@ static void cf_interrupt_all(CPUM68KState *env, int i=
s_hw)
>                  do_m68k_semihosting(env, env->dregs[0]);
>                  return;
>              }
> -            cs->halted =3D 1;
> +            cpu_halted_set(cs, 1);
>              cs->exception_index =3D EXCP_HLT;
>              cpu_loop_exit(cs);
>              return;


--
Alex Benn=C3=A9e
