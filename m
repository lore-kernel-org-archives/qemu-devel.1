Received: from eggs.gnu.org ([2001:4830:134:3::10]:49150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1Pk-0006lj-54
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1Pg-0005kH-7j
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:42:48 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:32936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1Pg-0005jQ-3P
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:42:44 -0400
Received: by mail-vk0-x244.google.com with SMTP id g189so2824094vke.0
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 14:42:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.7fbcecb0d0061824a32985f26b9c1b7f816203b0.1501667615.git-series.james.hogan@imgtec.com>
	<de6d5c5610c6b5887e72e60a999963c9d414742b.1501667615.git-series.james.hogan@imgtec.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0f1c8596-e5eb-5ab0-2ba8-b2a8fa71db00@amsat.org>
Date: Wed, 2 Aug 2017 18:42:39 -0300
MIME-Version: 1.0
In-Reply-To: <de6d5c5610c6b5887e72e60a999963c9d414742b.1501667615.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/3] target/mips: Drop redundant
 gen_io_start/stop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@imgtec.com>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

On 08/02/2017 06:59 AM, James Hogan wrote:
> DMTC0 CP0_Cause does a redundant gen_io_start() and gen_io_end() pair,
> even though this is done for all DMTC0 operations outside of the switch
> statement. Remove these redundant calls.
> 
> Fixes: 5dc5d9f055c5 ("mips: more fixes to the MIPS interrupt glue logic")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
>   target/mips/translate.c | 8 --------
>   1 file changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 6b41f7b65e00..6e724ac71dcd 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -7403,15 +7403,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
>           switch (sel) {
>           case 0:
>               save_cpu_state(ctx, 1);
> -            /* Mark as an IO operation because we may trigger a software
> -               interrupt.  */
> -            if (ctx->tb->cflags & CF_USE_ICOUNT) {
> -                gen_io_start();
> -            }
>               gen_helper_mtc0_cause(cpu_env, arg);
> -            if (ctx->tb->cflags & CF_USE_ICOUNT) {
> -                gen_io_end();
> -            }
>               /* Stop translation as we may have triggered an intetrupt. BS_STOP
>                * isn't sufficient, we need to ensure we break out of translated
>                * code to check for pending interrupts.  */
> 
