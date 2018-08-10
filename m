Received: from eggs.gnu.org ([2001:4830:134:3::10]:53279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fo91V-0003Jm-Rl
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fo91V-0006kg-1F
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:08:17 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:40725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fo91U-0006k9-Qe
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 11:08:16 -0400
Received: by mail-pl0-x22a.google.com with SMTP id s17-v6so4159104plp.7
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 08:08:16 -0700 (PDT)
References: <20180809214356.27690-1-cota@braap.org>
	<20180809214356.27690-4-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca842f1d-5a3f-cf7b-b0ac-d594cc1d4bad@linaro.org>
Date: Fri, 10 Aug 2018 08:08:13 -0700
MIME-Version: 1.0
In-Reply-To: <20180809214356.27690-4-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/riscv: call
 tcg_lookup_and_goto_ptr on DISAS_TOO_MANY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 08/09/2018 02:43 PM, Emilio G. Cota wrote:
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 66a80ca772..98e0311606 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1872,7 +1872,7 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>          if (ctx->base.singlestep_enabled) {
>              gen_exception_debug();
>          } else {
> -            tcg_gen_exit_tb(NULL, 0);
> +            tcg_gen_lookup_and_goto_ptr();
>          }
>          break;
>      case DISAS_NORETURN:

This could just as easily use

  case DISAS_TOO_MANY:
    gen_goto_tb(ctx, 0, ctx->base.pc_next);


r~
