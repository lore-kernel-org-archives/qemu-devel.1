Received: from eggs.gnu.org ([2001:4830:134:3::10]:34071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC9qi-0002IF-Tx
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC9qe-0004ZT-W0
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:52:24 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC9qU-0004IR-TK
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:52:13 -0400
Received: by mail-pg1-x542.google.com with SMTP id v133-v6so9727889pgb.2
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 13:51:55 -0700 (PDT)
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-7-aclindsa@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b58c1b9d-f3d7-198e-e31e-d276effc42a9@linaro.org>
Date: Mon, 15 Oct 2018 13:51:51 -0700
MIME-Version: 1.0
In-Reply-To: <20181010203735.27918-7-aclindsa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 06/14] target/arm: Filter cycle counter
 based on PMCCFILTR_EL0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aclindsa@gmail.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

On 10/10/18 1:37 PM, Aaron Lindsay wrote:
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -584,7 +584,7 @@ static int cpu_pre_save(void *opaque)
>  {
>      ARMCPU *cpu = opaque;
>  
> -    pmccntr_op_start(&cpu->env);
> +    pmu_op_start(&cpu->env);

Does it make sense to move this patch earlier so that these hooks are modified
once?  No big deal if not.


> +static inline bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)

Drop the inline.  This function is pretty big; we should let the compiler choose.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
