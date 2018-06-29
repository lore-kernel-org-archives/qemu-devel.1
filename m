Received: from eggs.gnu.org ([2001:4830:134:3::10]:45124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhSC-0003Mw-8K
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhS7-0001vo-Ic
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:40:00 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:43105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYhS7-0001vb-EY
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:39:55 -0400
Received: by mail-qk0-x242.google.com with SMTP id z74-v6so4067964qkb.10
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 17:39:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180629001538.11415-1-richard.henderson@linaro.org>
	<20180629001538.11415-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a91d18a7-187f-1574-be85-b2e4c54a0430@amsat.org>
Date: Thu, 28 Jun 2018 21:39:52 -0300
MIME-Version: 1.0
In-Reply-To: <20180629001538.11415-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/6] target/arm: Prune a15 features from max
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
> There is no need to re-set these 3 features already
> implied by the call to aarch64_a15_initfn.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/cpu.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index aa62315cea..878cc6c7e8 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1796,9 +1796,6 @@ static void arm_max_initfn(Object *obj)
>           * since we don't correctly set the ID registers to advertise them,
>           */
>          set_feature(&cpu->env, ARM_FEATURE_V8);
> -        set_feature(&cpu->env, ARM_FEATURE_VFP4);
> -        set_feature(&cpu->env, ARM_FEATURE_NEON);
> -        set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
>          set_feature(&cpu->env, ARM_FEATURE_V8_AES);
>          set_feature(&cpu->env, ARM_FEATURE_V8_SHA1);
>          set_feature(&cpu->env, ARM_FEATURE_V8_SHA256);
> 
