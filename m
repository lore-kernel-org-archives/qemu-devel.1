Received: from eggs.gnu.org ([2001:4830:134:3::10]:45004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhRD-0002fO-IG
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhR8-0001Qr-TF
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:38:59 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:37225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhR8-0001QS-Ot
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:38:54 -0400
Received: by mail-qt0-x242.google.com with SMTP id a18-v6so6474906qtj.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 17:38:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1353d863-8a7d-25cc-e09e-9d36569549ac@amsat.org>
Date: Thu, 28 Jun 2018 21:38:50 -0300
MIME-Version: 1.0
In-Reply-To: <20180629001538.11415-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/6] target/arm: Prune a57 features from max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 06/28/2018 09:15 PM, Richard Henderson wrote:
> There is no need to re-set these 9 features already
> implied by the call to aarch64_a57_initfn.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/cpu64.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 3b4bc73ffa..8040493d5c 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -235,19 +235,10 @@ static void aarch64_max_initfn(Object *obj)
>           * whereas the architecture requires them to be present in both if
>           * present in either.
>           */
> -        set_feature(&cpu->env, ARM_FEATURE_V8);
> -        set_feature(&cpu->env, ARM_FEATURE_VFP4);
> -        set_feature(&cpu->env, ARM_FEATURE_NEON);
> -        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_AES);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
>          set_feature(&cpu->env, ARM_FEATURE_V8_SHA512);
>          set_feature(&cpu->env, ARM_FEATURE_V8_SHA3);
>          set_feature(&cpu->env, ARM_FEATURE_V8_SM3);
>          set_feature(&cpu->env, ARM_FEATURE_V8_SM4);
> -        set_feature(&cpu->env, ARM_FEATURE_V8_PMULL);
> -        set_feature(&cpu->env, ARM_FEATURE_CRC);
>          set_feature(&cpu->env, ARM_FEATURE_V8_ATOMICS);
>          set_feature(&cpu->env, ARM_FEATURE_V8_RDM);
>          set_feature(&cpu->env, ARM_FEATURE_V8_DOTPROD);
> 
