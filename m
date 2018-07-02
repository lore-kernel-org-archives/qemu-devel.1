Received: from eggs.gnu.org ([2001:4830:134:3::10]:35010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3qb-0001th-Vo
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fa3qY-0002cy-UB
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:46:50 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:60421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fa3qY-0002c1-HY
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:46:46 -0400
References: <20180702175030.18621-1-f4bug@amsat.org>
	<20180702175030.18621-13-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <93bfb2be-4259-725f-d78d-46cb569afa4e@vivier.eu>
Date: Mon, 2 Jul 2018 20:46:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180702175030.18621-13-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 12/13] linux-user/strace: Improve
 getsockname() output
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
> index 9ab11059e4..f80d655835 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1995,6 +1995,19 @@ print_bind(const struct syscallname *name,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_getsockname)
> +static void
> +print_getsockname(const struct syscallname *name,
> +                  abi_long arg0, abi_long arg1, abi_long arg2,
> +                  abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);

TARGET_AB_FMT_ld

otherwise:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
