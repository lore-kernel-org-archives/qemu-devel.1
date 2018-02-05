Received: from eggs.gnu.org ([2001:4830:134:3::10]:52410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eih5O-0000mx-SY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eih5K-0003MI-D8
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:30 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:41604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eih5K-0003LQ-2U
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:45:26 -0500
Received: by mail-pl0-x243.google.com with SMTP id k8so9585980pli.8
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 05:45:25 -0800 (PST)
References: <1517811767-75958-1-git-send-email-mjc@sifive.com>
	<1517811767-75958-3-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f880f730-a999-b15d-1196-ce49ae63a266@linaro.org>
Date: Mon, 5 Feb 2018 05:45:22 -0800
MIME-Version: 1.0
In-Reply-To: <1517811767-75958-3-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/22] RISC-V CPU Core Definition
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
> Add CPU state header, CPU definitions and initialization routines
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/cpu.c      | 385 ++++++++++++++++++++++++++++++++++++++++++++
>  target/riscv/cpu.h      | 256 +++++++++++++++++++++++++++++
>  target/riscv/cpu_bits.h | 417 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1058 insertions(+)
>  create mode 100644 target/riscv/cpu.c
>  create mode 100644 target/riscv/cpu.h
>  create mode 100644 target/riscv/cpu_bits.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> 
> +static const RISCVCPUInfo riscv_cpus[] = {
> +#ifdef CONFIG_USER_ONLY
> +    { TYPE_RISCV_CPU_ANY,                riscv_any_cpu_init },
> +#else
> +    { TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_09, riscv_imafdcsu_priv1_9_cpu_init },
> +    { TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_10, riscv_imafdcsu_priv1_10_cpu_init },
> +    { TYPE_RISCV_CPU_IMACU_PRIV_1_10,    riscv_imacu_priv1_10_cpu_init },
> +    { TYPE_RISCV_CPU_IMAC_PRIV_1_10,     riscv_imac_priv1_10_cpu_init },
> +#endif
> +    { NULL, NULL }
> +};

I do wonder if there might be value in providing the more restricted cpus for
CONFIG_USER_ONLY as well.  E.g. toolchain testing, so that you can be sure that
the compiler doesn't emit an instruction that is invalid for a given MISA.


r~
