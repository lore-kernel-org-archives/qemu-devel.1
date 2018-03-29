Received: from eggs.gnu.org ([2001:4830:134:3::10]:34729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1a4t-0001mL-FZ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1a4q-0006x4-0E
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:07:03 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1a4p-0006vm-Nk
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:06:59 -0400
Received: by mail-wm0-x244.google.com with SMTP id h76so11740210wme.4
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 09:06:59 -0700 (PDT)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-16-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519709965-29833-16-git-send-email-cota@braap.org>
Date: Thu, 29 Mar 2018 17:06:56 +0100
Message-ID: <87muyq7tnj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/16] translate-all: remove tb_lock
 mention from cpu_restore_state_from_tb
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

> tb_lock was needed when the function did retranslation. However,
> since fca8a500d519 ("tcg: Save insn data and use it in
> cpu_restore_state_from_tb") we don't do retranslation.
>
> Get rid of the comment.

I think we need to modify the comment in cpu_restore_state as well:

  Either way we need return early as we can't resolve it here.

>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translate-all.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 9ab6477..ee49d03 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -357,9 +357,7 @@ static int encode_search(TranslationBlock *tb, uint8_=
t *block)
>      return p - block;
>  }
>
> -/* The cpu state corresponding to 'searched_pc' is restored.
> - * Called with tb_lock held.
> - */
> +/* The cpu state corresponding to 'searched_pc' is restored */
>  static int cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
>                                       uintptr_t searched_pc)
>  {


--
Alex Benn=C3=A9e
