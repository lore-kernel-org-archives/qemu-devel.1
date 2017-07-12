Received: from eggs.gnu.org ([2001:4830:134:3::10]:60068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVImU-0008Nl-Av
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVImP-0004OL-IF
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:38:22 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:35929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVImP-0004Nq-BW
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:38:17 -0400
Received: by mail-wr0-f181.google.com with SMTP id c11so36230940wrc.3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 07:38:17 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-6-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1499586614-20507-6-git-send-email-cota@braap.org>
Date: Wed, 12 Jul 2017 15:37:14 +0100
Message-ID: <87mv8990x1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/22] exec-all: fix typos in
 TranslationBlock's documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  include/exec/exec-all.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 8096d64..8326e7d 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -341,7 +341,7 @@ struct TranslationBlock {
>      /* The following data are used to directly call another TB from
>       * the code of this one. This can be done either by emitting direct or
>       * indirect native jump instructions. These jumps are reset so that the TB
> -     * just continue its execution. The TB can be linked to another one by
> +     * just continues its execution. The TB can be linked to another one by
>       * setting one of the jump targets (or patching the jump instruction). Only
>       * two of such jumps are supported.
>       */
> @@ -352,7 +352,7 @@ struct TranslationBlock {
>  #else
>      uintptr_t jmp_target_addr[2]; /* target address for indirect jump */
>  #endif
> -    /* Each TB has an assosiated circular list of TBs jumping to this one.
> +    /* Each TB has an associated circular list of TBs jumping to this one.
>       * jmp_list_first points to the first TB jumping to this one.
>       * jmp_list_next is used to point to the next TB in a list.
>       * Since each TB can have two jumps, it can participate in two lists.


--
Alex Bennée
