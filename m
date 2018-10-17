Received: from eggs.gnu.org ([2001:4830:134:3::10]:45207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCZKg-00018k-BE
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 20:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCZKd-0007oZ-4I
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 20:05:02 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCZKc-0007o4-TF
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 20:04:59 -0400
Received: by mail-pf1-x442.google.com with SMTP id c25-v6so12244675pfe.6
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 17:04:58 -0700 (PDT)
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-12-aclindsa@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <be878ed3-509f-8ed8-8c28-71e3d0214837@linaro.org>
Date: Tue, 16 Oct 2018 17:04:54 -0700
MIME-Version: 1.0
In-Reply-To: <20181010203735.27918-12-aclindsa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 11/14] target/arm: PMU: Add instruction
 and cycle events
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
> + * Return the underlying cycle count for the PMU cycle counters. If we're in
> + * usermode, simply return 0.
> + */
> +static uint64_t cycles_get_count(CPUARMState *env)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                   ARM_CPU_FREQ, NANOSECONDS_PER_SECOND);
> +#else
> +    return 0;
> +#endif
> +}

Usually we pass through the host cycle counter.
See cpu_get_host_ticks().


r~
