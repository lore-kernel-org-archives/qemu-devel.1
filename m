Received: from eggs.gnu.org ([209.51.188.92]:45713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hJl4V-0006pT-Tq
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hJkrE-0000A7-Ik
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:20:37 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hJkrE-00007d-9B
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:20:36 -0400
Received: by mail-lj1-x243.google.com with SMTP id q10so813437ljc.6
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 13:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190425172636.11128-1-richard.henderson@linaro.org>
	<20190425172636.11128-2-richard.henderson@linaro.org>
In-Reply-To: <20190425172636.11128-2-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 25 Apr 2019 13:18:44 -0700
Message-ID: <CAKmqyKObPbN9P_o7rwsd9=7mW+eohAt_cJrGC_gJwf8jmCfWyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] fixup! target/riscv: Name the argument
 sets for all of insn32 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>

On Thu, Apr 25, 2019 at 10:28 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> ---
>  target/riscv/translate.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Not sure how this will work with a fixup, but still:
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index d1f599a92d..009c146e8f 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -713,12 +713,19 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>   * initially declared by the 32-bit decoder, which results in duplicate
>   * declaration warnings.  Suppress them.
>   */
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wredundant-decls"
> +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> +# pragma GCC diagnostic push
> +# pragma GCC diagnostic ignored "-Wredundant-decls"
> +# ifdef __clang__
> +#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
> +# endif
> +#endif
>
>  #include "decode_insn16.inc.c"
>
> -#pragma GCC diagnostic pop
> +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> +# pragma GCC diagnostic pop
> +#endif
>
>  static void decode_opc(DisasContext *ctx)
>  {
> --
> 2.17.1
>
>
