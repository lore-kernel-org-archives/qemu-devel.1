Received: from eggs.gnu.org ([2001:4830:134:3::10]:34053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9wWk-0006Jp-L4
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9wWj-0008IF-7O
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:14:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9wWi-0008H5-Q5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:14:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id a8-v6so2996026wmf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 11:14:36 -0700 (PDT)
References: <20181009174557.16125-1-cota@braap.org>
	<20181009174557.16125-3-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181009174557.16125-3-cota@braap.org>
Date: Tue, 09 Oct 2018 19:14:34 +0100
Message-ID: <875zybm1h1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/6] target/unicore32: remove tlb_flush
 from uc32_init_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>


Emilio G. Cota <cota@braap.org> writes:

> As far as I can tell tlb_flush does not need to be called
> this early. tlb_flush is eventually called after the CPU
> has been realized.
>
> This change paves the way to the introduction of tlb_init,
> which will be called from cpu_exec_realizefn.
>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/unicore32/cpu.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
> index 68f978d80b..2b49d1ca40 100644
> --- a/target/unicore32/cpu.c
> +++ b/target/unicore32/cpu.c
> @@ -116,8 +116,6 @@ static void uc32_cpu_initfn(Object *obj)
>      env->uncached_asr =3D ASR_MODE_PRIV;
>      env->regs[31] =3D 0x03000000;
>  #endif
> -
> -    tlb_flush(cs);
>  }
>
>  static const VMStateDescription vmstate_uc32_cpu =3D {

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
