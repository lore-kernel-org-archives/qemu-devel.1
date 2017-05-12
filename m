Received: from eggs.gnu.org ([2001:4830:134:3::10]:53426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9KT4-0006im-7i
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9KT1-0004DE-6o
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:59:30 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9KT1-0004D3-3P
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:59:27 -0400
Received: by mail-qt0-x241.google.com with SMTP id l39so8738410qtb.1
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:59:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170510182636.17791-1-aurelien@aurel32.net>
	<20170510182636.17791-9-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8ed11d92-6909-f811-cb07-6c1dc08c3119@amsat.org>
Date: Fri, 12 May 2017 20:59:23 -0300
MIME-Version: 1.0
In-Reply-To: <20170510182636.17791-9-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 08/15] target/sh4: fold ctx->bstate =
 BS_BRANCH into gen_conditional_jump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/10/2017 03:26 PM, Aurelien Jarno wrote:
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/sh4/translate.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 8cee7d333f..a4c7a0895b 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -279,6 +279,7 @@ static void gen_conditional_jump(DisasContext * ctx,
>      gen_goto_tb(ctx, 0, ifnott);
>      gen_set_label(l1);
>      gen_goto_tb(ctx, 1, ift);
> +    ctx->bstate = BS_BRANCH;
>  }
>
>  /* Delayed conditional jump (bt or bf) */
> @@ -1158,9 +1159,7 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0x8b00:		/* bf label */
>  	CHECK_NOT_DELAY_SLOT
> -	    gen_conditional_jump(ctx, ctx->pc + 2,
> -				 ctx->pc + 4 + B7_0s * 2);
> -	ctx->bstate = BS_BRANCH;
> +        gen_conditional_jump(ctx, ctx->pc + 2, ctx->pc + 4 + B7_0s * 2);
>  	return;
>      case 0x8f00:		/* bf/s label */
>  	CHECK_NOT_DELAY_SLOT
> @@ -1170,9 +1169,7 @@ static void _decode_opc(DisasContext * ctx)
>  	return;
>      case 0x8900:		/* bt label */
>  	CHECK_NOT_DELAY_SLOT
> -	    gen_conditional_jump(ctx, ctx->pc + 4 + B7_0s * 2,
> -				 ctx->pc + 2);
> -	ctx->bstate = BS_BRANCH;
> +        gen_conditional_jump(ctx, ctx->pc + 4 + B7_0s * 2, ctx->pc + 2);
>  	return;
>      case 0x8d00:		/* bt/s label */
>  	CHECK_NOT_DELAY_SLOT
>
