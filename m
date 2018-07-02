Received: from eggs.gnu.org ([2001:4830:134:3::10]:57871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3h9-0005bl-AN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3h6-0003Zn-8Z
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:37:03 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fa3h5-0003YO-Up
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:37:00 -0400
References: <20180702175030.18621-1-f4bug@amsat.org>
	<20180702175030.18621-10-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0a983a01-f808-3658-fde5-9d70a30e9153@vivier.eu>
Date: Mon, 2 Jul 2018 20:36:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180702175030.18621-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 09/13] linux-user/strace: improve
 sendto() output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>

Le 02/07/2018 à 19:50, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-By: Guido Günther <agx@sigxcpu.org>
> ---
>  linux-user/strace.c    | 16 ++++++++++++++++
>  linux-user/strace.list |  2 +-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index b8e585a87d..390a50d45a 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1971,6 +1971,22 @@ print_bind(const struct syscallname *name,
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
> +    print_raw_param("%d", arg0, 0);

TARGET_ABI_FMT_ld

otherwise:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
