Received: from eggs.gnu.org ([2001:4830:134:3::10]:58070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gDYVt-00020K-FA
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gDYVq-0005Ve-5a
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:24:41 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gDYVp-0005Sv-RH
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 13:24:37 -0400
Received: by mail-pg1-x542.google.com with SMTP id c10-v6so16046078pgq.4
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 10:24:37 -0700 (PDT)
Date: Fri, 19 Oct 2018 10:24:34 -0700 (PDT)
In-Reply-To: <20181019010625.25294-17-cota@braap.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-f66ea843-b706-430e-b102-59f3a9ac4636@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v3 16/56] riscv: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, alistair23@gmail.com

On Thu, 18 Oct 2018 18:05:45 PDT (-0700), cota@braap.org wrote:
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Alistair Francis <alistair23@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/riscv/op_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index aec7558e1b..b5c32241dd 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -736,7 +736,7 @@ void helper_wfi(CPURISCVState *env)
>  {
>      CPUState *cs = CPU(riscv_env_get_cpu(env));
>
> -    cs->halted = 1;
> +    cpu_halted_set(cs, 1);
>      cs->exception_index = EXCP_HLT;
>      cpu_loop_exit(cs);
>  }

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
