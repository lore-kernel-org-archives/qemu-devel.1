Received: from eggs.gnu.org ([2001:4830:134:3::10]:59110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2wbD-0004fZ-0f
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 06:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f2wb9-00081C-RJ
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 06:22:03 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48037)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f2wb9-0007ya-IF
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 06:21:59 -0400
References: <20180401221253.1382-1-jcmvbkbc@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <00725c19-b0f2-8f7a-c7e3-ed68326d820c@vivier.eu>
Date: Mon, 2 Apr 2018 12:21:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180401221253.1382-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: linux-user: fix fadvise64
 call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 02/04/2018 à 00:12, Max Filippov a écrit :
> fadvise64_64 on xtensa passes advice as the second argument and so must
> be handled similar to PPC.
> 
> This fixes glibc testsuite tests posix/tst-posix_fadvise and
> posix/tst-posix_fadvise64.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 924fd68efcdd..5ef517613577 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11509,7 +11509,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>  
>  #ifdef TARGET_NR_fadvise64_64
>      case TARGET_NR_fadvise64_64:
> -#if defined(TARGET_PPC)
> +#if defined(TARGET_PPC) || defined(TARGET_XTENSA)
>          /* 6 args: fd, advice, offset (high, low), len (high, low) */
>          ret = arg2;
>          arg2 = arg3;
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
