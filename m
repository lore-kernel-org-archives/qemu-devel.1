Received: from eggs.gnu.org ([2001:4830:134:3::10]:55071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3bT-0004aE-50
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3bP-0007DO-6B
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:31:11 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57509)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fa3bO-00079z-TJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:31:07 -0400
References: <20180702175030.18621-1-f4bug@amsat.org>
	<20180702175030.18621-9-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <802d4bb6-c067-c87e-5089-3e523f29bcd2@vivier.eu>
Date: Mon, 2 Jul 2018 20:30:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180702175030.18621-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 08/13] linux-user/strace: Improve bind()
 output
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
>  linux-user/strace.c    | 13 +++++++++++++
>  linux-user/strace.list |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 77e36467cd..b8e585a87d 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1958,6 +1958,19 @@ print_socketcall(const struct syscallname *name,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_bind)
> +static void
> +print_bind(const struct syscallname *name,
> +           abi_long arg0, abi_long arg1, abi_long arg2,
> +           abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);

As arg0 is abi_long I think you should use TARGET_ABI_FMT_ld.
(see do_print_sockaddr()).

Thanks,
Laurent
