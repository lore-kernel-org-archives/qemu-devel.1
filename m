Received: from eggs.gnu.org ([2001:4830:134:3::10]:51887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emNXQ-0004LQ-Gw
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:41:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1emNXL-0003D6-Kv
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:41:40 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52633)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1emNXL-0003Ct-Az
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:41:35 -0500
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-3-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <331c79b5-87eb-a04a-8ad3-37f91f95cbc4@vivier.eu>
Date: Thu, 15 Feb 2018 18:41:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180124130126.20871-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/11] linux-user/strace: improve sendto()
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
>  linux-user/strace.c    | 16 ++++++++++++++++
>  linux-user/strace.list |  2 +-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 7eb5e2ab48..e7272f4ede 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1922,6 +1922,22 @@ print_socketcall(const struct syscallname *name,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_sendto)
> +static void
> +print_sendto(const struct syscallname *name,
> +             abi_long arg0, abi_long arg1, abi_long arg2,
> +             abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param(TARGET_ABI_FMT_ld, arg0, 0);

Other strace functions (accept(), fcntl(), ...) use "%d" for fd.

Thanks,
Laurent
