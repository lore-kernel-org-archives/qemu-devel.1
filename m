Received: from eggs.gnu.org ([2001:4830:134:3::10]:48970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtS0-0000Uo-OR
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtRm-0004cs-6C
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:34:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtRk-0004IT-4t
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:34:21 -0400
Received: by mail-wm1-x341.google.com with SMTP id l2-v6so9632899wmh.3
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:34:02 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-32-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-32-cota@braap.org>
Date: Wed, 31 Oct 2018 16:33:59 +0000
Message-ID: <87pnvq6poo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 32/71] exec: use cpu_reset_interrupt
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
> ---
>  exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/exec.c b/exec.c
> index 4fd831ef06..cd171adb93 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -776,7 +776,7 @@ static int cpu_common_post_load(void *opaque, int ver=
sion_id)
>
>      /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
>         version_id is increased. */
> -    cpu->interrupt_request &=3D ~0x01;
> +    cpu_reset_interrupt(cpu, 1);

I mean this does raise a question about why 0x1 doesn't have it's own
nice define (along with a description of what it means) but I guess that
is lost to the mists of time.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>      tlb_flush(cpu);
>
>      /* loadvm has just updated the content of RAM, bypassing the


--
Alex Benn=C3=A9e
