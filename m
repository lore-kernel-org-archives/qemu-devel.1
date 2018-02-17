Received: from eggs.gnu.org ([2001:4830:134:3::10]:59391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1en6Fg-0002WT-Ly
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1en6Fc-0006an-Mc
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:26:20 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:56661)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1en6Fc-0006XV-CE
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:26:16 -0500
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-7-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <37f08596-8de0-9fd9-9318-063056350cf5@vivier.eu>
Date: Sat, 17 Feb 2018 18:26:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180124130126.20871-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/11] linux-user/strace: improve recvmsg()
 output
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
>  linux-user/strace.list | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 947ff04eab..ae6dc8fecf 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -1107,7 +1107,7 @@
>  { TARGET_NR_recvmmsg, "recvmmsg" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_recvmsg
> -{ TARGET_NR_recvmsg, "recvmsg" , NULL, NULL, NULL },
> +{ TARGET_NR_recvmsg, "recvmsg" , "%s(%d,%p,%#x)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_remap_file_pages
>  { TARGET_NR_remap_file_pages, "remap_file_pages" , NULL, NULL, NULL },
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
