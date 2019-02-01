Received: from eggs.gnu.org ([209.51.188.92]:46285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpaXx-0006us-RN
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpaXv-0003tT-9F
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:16:01 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpaXq-0003md-Vd
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:15:58 -0500
Received: by mail-ot1-x344.google.com with SMTP id w25so6218795otm.13
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 07:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20190125225714.10234-1-richard.henderson@linaro.org>
	<20190125225714.10234-7-richard.henderson@linaro.org>
In-Reply-To: <20190125225714.10234-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Feb 2019 15:15:30 +0000
Message-ID: <CAFEAcA9WFmTBHO_t7brwfQ6ppEe9-d_5D1zKkxYik-Vf1ZT_Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/6] linux-user: Implement PR_PAC_RESET_KEYS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 25 Jan 2019 at 22:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_syscall.h |  7 ++++++
>  linux-user/syscall.c                | 33 +++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)

> @@ -9691,6 +9691,39 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  }
>              }
>              return ret;
> +        case TARGET_PR_PAC_RESET_KEYS:
> +            {
> +                CPUARMState *env = cpu_env;
> +                ARMCPU *cpu = arm_env_get_cpu(env);

The kernel implementation of this returns EINVAL if any
of arg3/arg4/arg5 are non-zero.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
