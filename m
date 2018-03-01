Received: from eggs.gnu.org ([2001:4830:134:3::10]:35774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erO7m-0002da-Tr
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erO7m-0001DM-0V
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:19:54 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erO7l-0001DB-SE
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:19:53 -0500
Received: by mail-oi0-x243.google.com with SMTP id c83so4442176oib.1
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 05:19:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228193125.20577-10-richard.henderson@linaro.org>
References: <20180228193125.20577-1-richard.henderson@linaro.org>
	<20180228193125.20577-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 13:19:33 +0000
Message-ID: <CAFEAcA-9JBhK5q5UzXHKBDYi8z12tKhDhTw693oHZYEc3O_WNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 09/16] target/arm: Enable
 ARM_FEATURE_V8_RDM
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
> index 1b3ae62db6..ca5fb1162a 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1650,6 +1650,7 @@ static void arm_any_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>      set_feature(&cpu->env, ARM_FEATURE_CRC);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
>      cpu->midr = 0xffffffff;
>  }
>  #endif
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 9743bdc8c3..7246866e7d 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -230,6 +230,7 @@ static void aarch64_any_initfn(Object *obj)
>      set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
>      set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>      set_feature(&cpu->env, ARM_FEATURE_CRC);
> +    set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
>      set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
>      cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
>      cpu->dcz_blocksize = 7; /*  512 bytes */
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
