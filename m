Received: from eggs.gnu.org ([2001:4830:134:3::10]:43132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfID-00074X-9S
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfI8-0000iy-Ho
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:55:17 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fHfI8-0000im-D5
	for qemu-devel@nongnu.org; Sat, 12 May 2018 20:55:12 -0400
Received: by mail-qk0-x242.google.com with SMTP id 11-v6so7347615qkk.4
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 17:55:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <289e9617-5f85-e5e5-f6a1-ba2ad17a7ecc@amsat.org>
Date: Sat, 12 May 2018 21:55:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180511035240.4016-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 9/9] target/xtensa: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

On 05/11/2018 12:52 AM, Richard Henderson wrote:
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/xtensa/translate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 4f6d03059f..2afe395ecf 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -1244,7 +1244,8 @@ void xtensa_cpu_dump_state(CPUState *cs, FILE *f,
>          }
>      }
>  
> -    if (xtensa_option_enabled(env->config, XTENSA_OPTION_FP_COPROCESSOR)) {
> +    if ((flags & CPU_DUMP_FPU) &&
> +        xtensa_option_enabled(env->config, XTENSA_OPTION_FP_COPROCESSOR)) {
>          cpu_fprintf(f, "\n");
>  
>          for (i = 0; i < 16; ++i) {
> 
