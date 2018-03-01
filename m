Received: from eggs.gnu.org ([2001:4830:134:3::10]:36075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erO8x-0003eo-U8
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erO8o-0001kh-8w
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:21:07 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:37442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erO8n-0001k1-Vu
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:20:58 -0500
Received: by mail-ot0-x241.google.com with SMTP id t2so5519272otj.4
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 05:20:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228193125.20577-17-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
	<20180228193125.20577-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 13:20:36 +0000
Message-ID: <CAFEAcA_o86z59NmYJhbdLbZnvZ0kdAuSRqLrwrVkysS_+EDqqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 16/16] target/arm: Enable
 ARM_FEATURE_V8_FCMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 28 February 2018 at 19:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Enable it for the "any" CPU used by *-linux-user.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c   | 1 +
>  target/arm/cpu64.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index ca5fb1162a..452bc32f10 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1651,6 +1651,7 @@ static void arm_any_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>      set_feature(&cpu->env, ARM_FEATURE_CRC);
>      set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
>      cpu->midr = 0xffffffff;
>  }
>  #endif
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 7246866e7d..4228713b19 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -232,6 +232,7 @@ static void aarch64_any_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_CRC);
>      set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
>      set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
>      cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
>      cpu->dcz_blocksize = 7; /*  512 bytes */
>  }
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

We should be setting some hwcap bits in linux-user for these new feature
bits (and RDM), right?

thanks
-- PMM
