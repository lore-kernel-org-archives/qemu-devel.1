Received: from eggs.gnu.org ([209.51.188.92]:41797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLLd9-0002hl-0x
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLLd7-0001ls-TA
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:48:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLLd7-0001kt-Ms
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 01:48:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so2315729wmf.1
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 22:48:35 -0700 (PDT)
References: <20190429003339.22956-1-driver1998@foxmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f63055b-f5a6-8972-a227-3ba1bcd0004b@redhat.com>
Date: Tue, 30 Apr 2019 07:48:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190429003339.22956-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] include/qemu/osdep.h: Move the
 __USE_MINGW_ANSI_STDIO define up to avoid confliction.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: driver1998 <driver1998@foxmail.com>, qemu-devel@nongnu.org

Hi,

On 4/29/19 2:33 AM, driver1998 wrote:
> Signed-off-by: driver1998 <driver1998@foxmail.com>

Is driver1998 your real name? :)

> ---
>  include/qemu/osdep.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 303d315c5d..af2b91f0b8 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -85,17 +85,17 @@ extern int daemon(int, int);
>  #endif
>  #endif
>  
> +/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */

As the comment says, this definition is used by <stdio.h>.
I suppose you encountered an issue with one of the following headers
including it earlier, which is odd...
Can you paste the error you are trying to fix?

Thanks,

Phil.

> +#ifdef __MINGW32__
> +#define __USE_MINGW_ANSI_STDIO 1
> +#endif
> +
>  #include <stdarg.h>
>  #include <stddef.h>
>  #include <stdbool.h>
>  #include <stdint.h>
>  #include <sys/types.h>
>  #include <stdlib.h>
> -
> -/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or later) */
> -#ifdef __MINGW32__
> -#define __USE_MINGW_ANSI_STDIO 1
> -#endif
>  #include <stdio.h>
>  
>  #include <string.h>
> 
