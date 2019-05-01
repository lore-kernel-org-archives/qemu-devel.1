Received: from eggs.gnu.org ([209.51.188.92]:34391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLsvL-0002WW-MN
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hLsvJ-00050Q-OC
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:21:39 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hLsvH-0004sV-8u
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:21:37 -0400
Received: by mail-pl1-x641.google.com with SMTP id a59so1093091pla.5
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 10:21:33 -0700 (PDT)
Date: Wed, 01 May 2019 10:21:31 -0700 (PDT)
In-Reply-To: <20190425172636.11128-2-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-6fa8c1f8-fe4c-4d72-b0ea-c9809704637e@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org

On Thu, 25 Apr 2019 10:26:35 PDT (-0700), richard.henderson@linaro.org wrote:
> ---
>  target/riscv/translate.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
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

I've attemeted to fixup the patch on my for-master, let me know if I've screwed
something up!
