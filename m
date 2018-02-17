Received: from eggs.gnu.org ([2001:4830:134:3::10]:57459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1en65c-0004w7-II
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1en65X-00087X-HS
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:15:56 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:43709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1en65X-000877-7R
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:15:51 -0500
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-10-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f94012fe-95be-95b8-90a9-17d8b7d2356e@vivier.eu>
Date: Sat, 17 Feb 2018 18:15:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180124130126.20871-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/11] linux-user/strace: improve
 capget()/capset() output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

Le 24/01/2018 à 14:01, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/strace.list | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index f90c0e8ee4..f09234345f 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -59,10 +59,10 @@
>  { TARGET_NR_cacheflush, "cacheflush" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_capget
> -{ TARGET_NR_capget, "capget" , NULL, NULL, NULL },
> +{ TARGET_NR_capget, "capget" , "%s(%p,%p)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_capset
> -{ TARGET_NR_capset, "capset" , NULL, NULL, NULL },
> +{ TARGET_NR_capset, "capset" , "%s(%p,%p)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_chdir
>  { TARGET_NR_chdir, "chdir" , NULL, print_chdir, NULL },
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
