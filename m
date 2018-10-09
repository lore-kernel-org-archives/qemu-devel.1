Received: from eggs.gnu.org ([2001:4830:134:3::10]:33889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9wWb-0006Hf-BV
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9wWO-0008C1-1z
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:14:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9wWN-0008Bn-4v
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:14:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id z25-v6so11613936wmf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 11:14:13 -0700 (PDT)
References: <20181009174557.16125-1-cota@braap.org>
	<20181009174557.16125-2-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181009174557.16125-2-cota@braap.org>
Date: Tue, 09 Oct 2018 19:14:10 +0100
Message-ID: <877eirm1hp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/6] target/alpha: remove tlb_flush from
 alpha_cpu_initfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> As far as I can tell tlb_flush does not need to be called
> this early. tlb_flush is eventually called after the CPU
> has been realized.
>
> This change paves the way to the introduction of tlb_init,
> which will be called from cpu_exec_realizefn.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/alpha/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index b08078e7fc..a953897fcc 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -201,7 +201,6 @@ static void alpha_cpu_initfn(Object *obj)
>      CPUAlphaState *env =3D &cpu->env;
>
>      cs->env_ptr =3D env;
> -    tlb_flush(cs);
>
>      env->lock_addr =3D -1;
>  #if defined(CONFIG_USER_ONLY)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
