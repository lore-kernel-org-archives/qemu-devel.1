Received: from eggs.gnu.org ([2001:4830:134:3::10]:36967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dugKV-0002v9-Vv
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dugKS-0002Js-Tl
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:50:24 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dugKS-0002Gn-KT
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:50:20 -0400
References: <d137f607-aa48-e388-02b2-1f1b104439e2@vivier.eu>
	<20170919230643.87425-1-carenas@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d1448f7f-2ac4-1830-8a02-c5bbca98db09@vivier.eu>
Date: Wed, 20 Sep 2017 10:26:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170919230643.87425-1-carenas@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] linux-user: fix TARGET_SO_LINGER for
 sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, gang.chen.5i5j@gmail.com, riku.voipio@iki.fi, rth@twiddle.net

Le 20/09/2017 à 01:06, Carlo Marcelo Arenas Belón a écrit :
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  linux-user/socket.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/socket.h b/linux-user/socket.h
> index 7051cd2cf4..129f9b4713 100644
> --- a/linux-user/socket.h
> +++ b/linux-user/socket.h
> @@ -246,8 +246,12 @@
>      #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
>      #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
>  
> +    #define TARGET_SO_LINGER         0x0080
> +
>      #define TARGET_SO_PASSSEC        31
>  #else
> +    #define TARGET_SO_LINGER         13
> +
>      #define TARGET_SO_PASSSEC        34
>  #endif


The change is correct but it should be added below, in the "For
setsockopt(2)" section, adding a TARGET_SPARC section, like we have a
TARGET_PPC section.

>  
> @@ -268,7 +272,7 @@
>      #define TARGET_SO_OOBINLINE    10
>      #define TARGET_SO_NO_CHECK     11
>      #define TARGET_SO_PRIORITY     12
> -    #define TARGET_SO_LINGER       13
> +

Don't add a blank line

>      #define TARGET_SO_BSDCOMPAT    14
>      /* To add :#define TARGET_SO_REUSEPORT 15 */
>  #if defined(TARGET_PPC)
> 

But a better change would be to move all socket defines to a new file
linux-user/sparc/sockbits.h (like for TARGET_HPPA).

Laurent
