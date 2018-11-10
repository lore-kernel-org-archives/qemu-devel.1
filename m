Received: from eggs.gnu.org ([2001:4830:134:3::10]:40212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLYnp-0006cD-P5
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 14:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLYnn-0006O7-SE
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 14:20:17 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181110121711.15257-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3bc7635b-bb80-2780-ebf6-297b5914e4aa@amsat.org>
Date: Sat, 10 Nov 2018 20:20:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181110121711.15257-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-3.1] target/arm: Fix typo in
 tlbi_aa64_vmalle1_write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

On 11/10/18 1:17 PM, Richard Henderson wrote:
> This would cause an infinite recursion or loop.

Hehe :)

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 96301930cc..a327988c66 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3155,7 +3155,7 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      CPUState *cs = ENV_GET_CPU(env);
>  
>      if (tlb_force_broadcast(env)) {
> -        tlbi_aa64_vmalle1_write(env, NULL, value);
> +        tlbi_aa64_vmalle1is_write(env, NULL, value);
>          return;
>      }
>  
> 
