Received: from eggs.gnu.org ([2001:4830:134:3::10]:54741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eihFV-00016Q-Kf
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eihFR-0000Dr-PR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:55:57 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:37420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eihFR-0000D5-I7
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:55:53 -0500
Received: by mail-pl0-x244.google.com with SMTP id ay8so11819324plb.4
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:55:53 -0800 (PST)
References: <1517811767-75958-1-git-send-email-mjc@sifive.com>
	<1517811767-75958-5-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e8ac6889-2231-5947-fd7c-8c927e993b29@linaro.org>
Date: Mon, 5 Feb 2018 05:55:49 -0800
MIME-Version: 1.0
In-Reply-To: <1517811767-75958-5-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 05/22] RISC-V CPU Helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/04/2018 10:22 PM, Michael Clark wrote:
> Privileged control and status register helpers and page fault handling.
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/helper.c    | 464 ++++++++++++++++++++++++++++++++++
>  target/riscv/helper.h    |  78 ++++++
>  target/riscv/op_helper.c | 644 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1186 insertions(+)
>  create mode 100644 target/riscv/helper.c
>  create mode 100644 target/riscv/helper.h
>  create mode 100644 target/riscv/op_helper.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> +{
> +#if !defined(CONFIG_USER_ONLY)
> +    if (interrupt_request & CPU_INTERRUPT_HARD) {
> +        RISCVCPU *cpu = RISCV_CPU(cs);
> +        CPURISCVState *env = &cpu->env;
> +        int interruptno = riscv_cpu_hw_interrupts_pending(env);
> +        if (interruptno + 1) {

Perhaps clearer as (interrupno >= 0) or (interruptno != -1).
But it's not actively wrong, so tidy at your convenience.


r~
