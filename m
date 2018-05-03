Received: from eggs.gnu.org ([2001:4830:134:3::10]:50654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEFCU-0004QX-J1
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEFCT-0003Ab-RT
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:27:14 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:46497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEFCT-0003AI-Lb
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:27:13 -0400
Received: by mail-ot0-x242.google.com with SMTP id t1-v6so20811116ott.13
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 07:27:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427002651.28356-10-richard.henderson@linaro.org>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 15:26:52 +0100
Message-ID: <CAFEAcA9v7C-TPtE-4SLrhNGXyO+SbN5WiYVkXSkiMxUaFKieRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 9/9] target/arm: Enable
 ARM_FEATURE_V8_ATOMICS for user-only
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

On 27 April 2018 at 01:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu64.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 991d764674..c50dcd4077 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -248,6 +248,7 @@ static void aarch64_max_initfn(Object *obj)
>          set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
>          set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
>          set_feature(&cpu->env, ARM_FEATURE_CRC);
> +        set_feature(&cpu->env, ARM_FEATURE_V8_ATOMICS);
>          set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
>          set_feature(&cpu->env, ARM_FEATURE_V8_FP16);
>          set_feature(&cpu->env, ARM_FEATURE_V8_FCMA);
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
