Received: from eggs.gnu.org ([2001:4830:134:3::10]:53476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFRZl-0000Ap-Gp
	for qemu-devel@nongnu.org; Mon, 29 May 2017 16:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFRZh-0004H4-7C
	for qemu-devel@nongnu.org; Mon, 29 May 2017 16:47:41 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dFRZh-0004Ge-2L
	for qemu-devel@nongnu.org; Mon, 29 May 2017 16:47:37 -0400
Received: by mail-oi0-x241.google.com with SMTP id w138so13038278oiw.3
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 13:47:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-2-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <86541e07-9bb4-735c-1f7f-915302a11653@amsat.org>
Date: Mon, 29 May 2017 17:47:33 -0300
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/29] target/s390x: remove dead code in
 translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 05/29/2017 04:24 PM, Aurelien Jarno wrote:
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/s390x/translate.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 97ca639a34..f7598184a6 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -5467,10 +5467,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
>              gen_io_start();
>          }
>
> -        status = NO_EXIT;
> -        if (status == NO_EXIT) {
> -            status = translate_one(env, &dc);
> -        }
> +        status = translate_one(env, &dc);
>
>          /* If we reach a page boundary, are single stepping,
>             or exhaust instruction count, stop generation.  */
>
