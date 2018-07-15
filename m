Received: from eggs.gnu.org ([2001:4830:134:3::10]:35170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fei38-000466-TB
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 10:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fei35-0007tk-NG
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 10:30:58 -0400
References: <20180712194454.26765-1-sw@weilnetz.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98121629-3cd8-c0a5-f779-ccaa6298fdb1@redhat.com>
Date: Sun, 15 Jul 2018 16:30:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180712194454.26765-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel: Fix typo and grammar in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, QEMU Developer <qemu-devel@nongnu.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 12/07/2018 21:44, Stefan Weil wrote:
> The typo was found by codespell.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  accel/tcg/translate-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 49d77fad44..1571987113 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1795,7 +1795,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      tb->jmp_dest[0] = (uintptr_t)NULL;
>      tb->jmp_dest[1] = (uintptr_t)NULL;
>  
> -    /* init original jump addresses wich has been set during tcg_gen_code() */
> +    /* init original jump addresses which have been set during tcg_gen_code() */
>      if (tb->jmp_reset_offset[0] != TB_JMP_RESET_OFFSET_INVALID) {
>          tb_reset_jump(tb, 0);
>      }
> 

Queued, thanks.

Paolo
