Received: from eggs.gnu.org ([2001:4830:134:3::10]:42330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfCH-0005S0-Oj
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfCE-0005gb-LF
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:49:09 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:42675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfCE-0005gQ-Gy
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:49:06 -0400
Received: by mail-qt0-x241.google.com with SMTP id c2-v6so11888329qtn.9
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 17:49:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2cae9a38-bcb3-d071-da03-4f1ab7dc4c42@amsat.org>
Date: Sat, 12 May 2018 21:49:01 -0300
MIME-Version: 1.0
In-Reply-To: <20180511035240.4016-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/9] target/mips: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 05/11/2018 12:52 AM, Richard Henderson wrote:
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/mips/translate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index d05ee67e63..136947adc5 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -20445,8 +20445,9 @@ void mips_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
>                  env->CP0_Config2, env->CP0_Config3);
>      cpu_fprintf(f, "    Config4 0x%08x Config5 0x%08x\n",
>                  env->CP0_Config4, env->CP0_Config5);
> -    if (env->hflags & MIPS_HFLAG_FPU)
> +    if ((flags & CPU_DUMP_FPU) && (env->hflags & MIPS_HFLAG_FPU)) {
>          fpu_dump_state(env, f, cpu_fprintf, flags);
> +    }
>  }
>  
>  void mips_tcg_init(void)
> 
