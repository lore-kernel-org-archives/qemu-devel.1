Received: from eggs.gnu.org ([2001:4830:134:3::10]:54574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dvRKe-0007ii-PC
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dvRKa-0003Tl-R0
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:01:40 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:61655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dvRKa-0003SM-HD
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:01:36 -0400
References: <20170922140237.10869-1-carenas@gmail.com>
	<20170922140237.10869-6-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <57170a30-6932-a8f9-343c-1ce1f7c331b1@vivier.eu>
Date: Fri, 22 Sep 2017 19:01:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170922140237.10869-6-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 5/6] linux-user: fix 64bit versions of sparc
 and mips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, riku.voipio@iki.fi

Le 22/09/2017 à 16:02, Carlo Marcelo Arenas Belón a écrit :
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  linux-user/mips64/sockbits.h  | 1 +
>  linux-user/socket.h           | 4 ++--
>  linux-user/sparc64/sockbits.h | 1 +

Who includes the two new files?

Moreover TARGET_MIPS/TARGET_SPARC (base arch) are always defined when
TARGET_MIPS64/TARGET_SPARC64 (target arch) are defined.

So I think this patch is useless.

Thanks,
Laurent

>  3 files changed, 4 insertions(+), 2 deletions(-)
>  create mode 100644 linux-user/mips64/sockbits.h
>  create mode 100644 linux-user/sparc64/sockbits.h
> 
> diff --git a/linux-user/mips64/sockbits.h b/linux-user/mips64/sockbits.h
> new file mode 100644
> index 0000000000..e6b6d31ac9
> --- /dev/null
> +++ b/linux-user/mips64/sockbits.h
> @@ -0,0 +1 @@
> +#include "../mips/sockbits.h"
> diff --git a/linux-user/socket.h b/linux-user/socket.h
> index dfa692286b..6fd486c6b1 100644
> --- a/linux-user/socket.h
> +++ b/linux-user/socket.h
> @@ -1,10 +1,10 @@
> -#if defined(TARGET_MIPS)
> +#if defined(TARGET_MIPS) || defined(TARGET_MIPS64)
>  #include "mips/sockbits.h"
>  #elif defined(TARGET_ALPHA)
>  #include "alpha/sockbits.h"
>  #elif defined(TARGET_HPPA)
>  #include "hppa/sockbits.h"
> -#elif defined(TARGET_SPARC)
> +#elif defined(TARGET_SPARC) || defined(TARGET_SPARC64)
>  #include "sparc/sockbits.h"
>  #else
>  
> diff --git a/linux-user/sparc64/sockbits.h b/linux-user/sparc64/sockbits.h
> new file mode 100644
> index 0000000000..658899e4d3
> --- /dev/null
> +++ b/linux-user/sparc64/sockbits.h
> @@ -0,0 +1 @@
> +#include "../sparc/sockbits.h"
> 
