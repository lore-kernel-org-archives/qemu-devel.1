Received: from eggs.gnu.org ([2001:4830:134:3::10]:43050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfHV-0002FW-GW
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfHU-0000S4-Em
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:54:33 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:45370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfHU-0000Ru-9e
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:54:32 -0400
Received: by mail-qk0-x242.google.com with SMTP id c64-v6so7318554qkf.12
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 17:54:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ae7aaf06-aa49-a317-a218-b72522814f3e@amsat.org>
Date: Sat, 12 May 2018 21:54:27 -0300
MIME-Version: 1.0
In-Reply-To: <20180511035240.4016-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 8/9] target/unicore32: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>

On 05/11/2018 12:52 AM, Richard Henderson wrote:
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/unicore32/translate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
> index 5b51f2166d..63619e7d2c 100644
> --- a/target/unicore32/translate.c
> +++ b/target/unicore32/translate.c
> @@ -2101,7 +2101,9 @@ void uc32_cpu_dump_state(CPUState *cs, FILE *f,
>                  psr & (1 << 28) ? 'V' : '-',
>                  cpu_mode_names[psr & 0xf]);
>  
> -    cpu_dump_state_ucf64(env, f, cpu_fprintf, flags);
> +    if (flags & CPU_DUMP_FPU) {
> +        cpu_dump_state_ucf64(env, f, cpu_fprintf, flags);
> +    }
>  }
>  
>  void restore_state_to_opc(CPUUniCore32State *env, TranslationBlock *tb,
> 
