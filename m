Received: from eggs.gnu.org ([2001:4830:134:3::10]:46079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fmY5R-0006IV-Vi
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 01:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fmY5R-0001SG-0e
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 01:29:45 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1fmY5Q-0001S0-RL
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 01:29:44 -0400
Received: by mail-qt0-x242.google.com with SMTP id t5-v6so12542572qtn.3
	for <qemu-devel@nongnu.org>; Sun, 05 Aug 2018 22:29:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180805233258.31892-1-richard.henderson@linaro.org>
References: <20180805233258.31892-1-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Mon, 6 Aug 2018 07:29:43 +0200
Message-ID: <CABoDooNeBaYo46FVii0vjT-K5QtTx+Bg34WETrJcLJpPRHoV6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg/optimize: Do not skip default
 processing of dup_vec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello,

On Mon, Aug 6, 2018 at 1:32 AM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> If we do not opimize away dup_vec, we must mark its output as changed.
>
> Fixes: 170ba88f45b
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  tcg/optimize.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index d4ea67e541..5dbe11c3c8 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1094,9 +1094,9 @@ void tcg_optimize(TCGContext *s)
>                  tmp = arg_info(op->args[1])->val;
>                  tmp = dup_const(TCGOP_VECE(op), tmp);
>                  tcg_opt_gen_movi(s, op, op->args[0], tmp);
> -                continue;
> +                break;
>              }
> -            break;
> +            goto do_default;
>
>          CASE_OP_32_64(not):
>          CASE_OP_32_64(neg):
> --
> 2.17.1
>
