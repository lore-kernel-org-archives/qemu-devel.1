Received: from eggs.gnu.org ([2001:4830:134:3::10]:59093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1en6Dq-0001NX-7n
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1en6Dm-0004GN-AQ
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:24:26 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:52373)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1en6Dl-0004EL-Vt
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 12:24:22 -0500
References: <20180124130126.20871-1-f4bug@amsat.org>
	<20180124130126.20871-8-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <08c8b196-0548-ce5c-998c-cf34545298be@vivier.eu>
Date: Sat, 17 Feb 2018 18:24:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180124130126.20871-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/11] linux-user/strace: improve bind()
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
>  linux-user/strace.c    | 13 +++++++++++++
>  linux-user/strace.list |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 70ecb1fc98..4b8ab6bcfb 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1935,6 +1935,19 @@ print_socketcall(const struct syscallname *name,
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
> +    print_raw_param(TARGET_ABI_FMT_ld, arg0, 0);

Other functions use "%d" for fd.

Thanks,
Laurent
