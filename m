Received: from eggs.gnu.org ([2001:4830:134:3::10]:39506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gBOe5-00073T-6M
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gBOe0-00079j-38
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:28:13 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gBOdz-00078t-KD
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 14:28:08 -0400
References: <20181010223656.31632-1-f4bug@amsat.org>
	<20181010223656.31632-10-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9d8e318c-719c-c6ec-37c3-f2355ab8e7be@vivier.eu>
Date: Sat, 13 Oct 2018 20:27:49 +0200
MIME-Version: 1.0
In-Reply-To: <20181010223656.31632-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 09/10] linux-user/strace: Improve bind()
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

On 11/10/2018 00:36, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-By: Guido Günther <agx@sigxcpu.org>
> ---
>  linux-user/strace.c    | 13 +++++++++++++
>  linux-user/strace.list |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 14ec5f9f23..9f7480c449 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1966,6 +1966,19 @@ print_socketcall(const struct syscallname *name,
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
> +    print_sockfd(arg0, 0);

print_sockfd() is only defined if TARGET_NR_socketcall is defined, so in
this case it can be undefined.

Thanks,
Laurent
