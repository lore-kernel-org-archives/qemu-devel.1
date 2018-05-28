Received: from eggs.gnu.org ([2001:4830:134:3::10]:45204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN73O-0002lM-IL
	for qemu-devel@nongnu.org; Sun, 27 May 2018 21:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN73L-0004Es-FA
	for qemu-devel@nongnu.org; Sun, 27 May 2018 21:34:30 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:32979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fN73L-0004EM-Al
	for qemu-devel@nongnu.org; Sun, 27 May 2018 21:34:27 -0400
Received: by mail-qt0-x242.google.com with SMTP id e8-v6so13244059qth.0
	for <qemu-devel@nongnu.org>; Sun, 27 May 2018 18:34:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180527141324.11937-1-richard.henderson@linaro.org>
	<20180527141324.11937-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <55ffc391-cf4a-4123-dba5-f8f56a67cc4e@amsat.org>
Date: Sun, 27 May 2018 22:34:22 -0300
MIME-Version: 1.0
In-Reply-To: <20180527141324.11937-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/20] target/openrisc: Remove DISAS_JUMP &
 DISAS_TB_JUMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

On 05/27/2018 11:13 AM, Richard Henderson wrote:
> These values are unused.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/openrisc/translate.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index e7c96ca990..f4f2f37e28 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -41,9 +41,7 @@
>                    ## __VA_ARGS__)
>  
>  /* is_jmp field values */
> -#define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamically */
>  #define DISAS_UPDATE  DISAS_TARGET_1 /* cpu state was modified dynamically */
> -#define DISAS_TB_JUMP DISAS_TARGET_2 /* only pc was modified statically */
>  
>  typedef struct DisasContext {
>      DisasContextBase base;
> @@ -1467,8 +1465,6 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>              gen_goto_tb(dc, 0, dc->base.pc_next);
>              break;
>          case DISAS_NORETURN:
> -        case DISAS_JUMP:
> -        case DISAS_TB_JUMP:
>              break;
>          case DISAS_UPDATE:
>              /* indicate that the hash table must be used
> 
