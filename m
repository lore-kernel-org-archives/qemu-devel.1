Received: from eggs.gnu.org ([2001:4830:134:3::10]:45712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnieP-0005z5-F6
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnieK-0006q7-Rv
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:58:41 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:33611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fnieK-0006pc-KB
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:58:36 -0400
Received: by mail-wm0-x236.google.com with SMTP id r24-v6so2015225wmh.0
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 03:58:36 -0700 (PDT)
References: <20180809034033.10579-1-richard.henderson@linaro.org>
	<20180809034033.10579-10-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180809034033.10579-10-richard.henderson@linaro.org>
Date: Thu, 09 Aug 2018 11:58:34 +0100
Message-ID: <87h8k3q011.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/11] target/arm: Reformat integer
 register dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-stable@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> With PC, there are 33 registers.  Three per line lines up nicely
> without overflowing 80 columns.
>
> Cc: qemu-stable@nongnu.org (3.0.1)
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/translate-a64.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 45a6c2a3aa..358f169c75 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -137,14 +137,13 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
>      int el =3D arm_current_el(env);
>      const char *ns_status;
>
> -    cpu_fprintf(f, "PC=3D%016"PRIx64"  SP=3D%016"PRIx64"\n",
> -            env->pc, env->xregs[31]);
> -    for (i =3D 0; i < 31; i++) {
> -        cpu_fprintf(f, "X%02d=3D%016"PRIx64, i, env->xregs[i]);
> -        if ((i % 4) =3D=3D 3) {
> -            cpu_fprintf(f, "\n");
> +    cpu_fprintf(f, " PC=3D%016" PRIx64 " ", env->pc);
> +    for (i =3D 0; i < 32; i++) {
> +        if (i =3D=3D 31) {
> +            cpu_fprintf(f, " SP=3D%016" PRIx64 "\n", env->xregs[i]);
>          } else {
> -            cpu_fprintf(f, " ");
> +            cpu_fprintf(f, "X%02d=3D%016" PRIx64 "%s", i, env->xregs[i],
> +                        (i + 2) % 3 ? " " : "\n");
>          }
>      }


--
Alex Benn=C3=A9e
