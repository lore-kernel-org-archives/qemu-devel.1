Received: from eggs.gnu.org ([209.51.188.92]:53138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1grWyG-0001QX-Mi
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 18:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1grWyF-0006oO-8y
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 18:51:12 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1grWyF-0006nc-2C
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 18:51:11 -0500
Received: by mail-lj1-x243.google.com with SMTP id g11-v6so7747814ljk.3
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 15:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-25-cota@braap.org>
In-Reply-To: <20190130004811.27372-25-cota@braap.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Feb 2019 15:50:29 -0800
Message-ID: <CAKmqyKO1=+2FLzXRt2zbiKP5TVf498rVn63mhmWT1QyWfyNa6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 24/73] riscv: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Tue, Jan 29, 2019 at 4:48 PM Emilio G. Cota <cota@braap.org> wrote:
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <alistair23@gmail.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/op_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 81bd1a77ea..261d6fbfe9 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -125,7 +125,7 @@ void helper_wfi(CPURISCVState *env)
>  {
>      CPUState *cs = CPU(riscv_env_get_cpu(env));
>
> -    cs->halted = 1;
> +    cpu_halted_set(cs, 1);
>      cs->exception_index = EXCP_HLT;
>      cpu_loop_exit(cs);
>  }
> --
> 2.17.1
>
