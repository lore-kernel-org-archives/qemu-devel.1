Received: from eggs.gnu.org ([2001:4830:134:3::10]:50661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1cP6vq-0008C3-RN
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:14:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1cP6vm-00071G-Qk
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:14:10 -0500
Received: from jessie.kos.to ([212.47.231.226]:41386 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1cP6vm-000710-Js
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:14:06 -0500
Date: Thu, 5 Jan 2017 12:14:05 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20170105121405.GC19094@kos.to>
References: <1480003738-8754-1-git-send-email-Lena.Djokic@rt-rk.com>
	<1480003738-8754-6-git-send-email-Lena.Djokic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1480003738-8754-6-git-send-email-Lena.Djokic@rt-rk.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/7] linux-user: Fix readahead
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lena Djokic <Lena.Djokic@rt-rk.com>
Cc: qemu-devel@nongnu.org

On Thu, Nov 24, 2016 at 05:08:56PM +0100, Lena Djokic wrote:
> Calculation of 64-bit offset was not correct for all cases.

Thanks, applied to linux-user
 
> Signed-off-by: Lena Djokic <Lena.Djokic@rt-rk.com>
> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1b59a71..61c4126 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11296,7 +11296,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              arg3 = arg4;
>              arg4 = arg5;
>          }
> -        ret = get_errno(readahead(arg1, ((off64_t)arg3 << 32) | arg2, arg4));
> +        ret = get_errno(readahead(arg1, target_offset64(arg2, arg3) , arg4));
>  #else
>          ret = get_errno(readahead(arg1, arg2, arg3));
>  #endif
> -- 
> 2.7.4
> 
