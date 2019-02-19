Received: from eggs.gnu.org ([209.51.188.92]:53670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gw6mQ-0001uE-6P
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gw6mM-0005p4-VE
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:53:52 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gw6mM-0005Qt-2x
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:53:50 -0500
Received: by mail-wr1-x442.google.com with SMTP id r5so8941220wrg.9
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 06:53:45 -0800 (PST)
References: <20190214040652.4811-1-richard.henderson@linaro.org>
	<20190214040652.4811-4-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190214040652.4811-4-richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 14:53:43 +0000
Message-ID: <87a7ir6d8o.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] target/arm: Assert hflags is correct
 in cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Make sure that we are updating env->hflags everywhere required.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Arguably this is a debugging aid and we don't need it the git history,
nevertheless:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d8249f0eae..3c8724883d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -13902,11 +13902,13 @@ void cpu_get_tb_cpu_state(CPUARMState *env, tar=
get_ulong *pc,
>      if (is_a64(env)) {
>          *pc =3D env->pc;
>          flags =3D rebuild_hflags_a64(env, current_el);
> +        assert(flags =3D=3D env->hflags);
>          flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
>          pstate_for_ss =3D env->pstate;
>      } else {
>          *pc =3D env->regs[15];
>          flags =3D rebuild_hflags_a32(env, current_el);
> +        assert(flags =3D=3D env->hflags);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_=
bits);
>          pstate_for_ss =3D env->uncached_cpsr;


--
Alex Benn=C3=A9e
