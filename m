Received: from eggs.gnu.org ([2001:4830:134:3::10]:33673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3oh-00019F-HC
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3oe-0000sp-FT
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:44:51 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fa3oe-0000sW-4p
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:44:48 -0400
References: <20180702175030.18621-1-f4bug@amsat.org>
	<20180702175030.18621-14-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <82aecc83-3a6a-cbf9-dd7b-b0be1ae9282f@vivier.eu>
Date: Mon, 2 Jul 2018 20:44:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180702175030.18621-14-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 13/13] linux-user/strace: Improve
 recvfrom() output
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
> index f80d655835..a85b4a10e5 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -2008,6 +2008,22 @@ print_getsockname(const struct syscallname *name,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_recvfrom)
> +static void
> +print_recvfrom(const struct syscallname *name,
> +               abi_long arg0, abi_long arg1, abi_long arg2,
> +               abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);
> +    print_buf(arg1, arg2, 0);

The content of the buffer is not relevant here as it is displayed before
the data are received. I think you should only print the pointer and the
length.

Thanks,
Laurent
