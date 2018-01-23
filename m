Received: from eggs.gnu.org ([2001:4830:134:3::10]:55677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edmbF-0000tu-3q
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 19:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edmbC-00038z-1d
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 19:38:05 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:61894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edmbB-00038g-Nb
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 19:38:01 -0500
References: <mvmk1w9lreq.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <40b82ee1-416b-20c6-4745-218d8e3cdd24@vivier.eu>
Date: Tue, 23 Jan 2018 01:37:58 +0100
MIME-Version: 1.0
In-Reply-To: <mvmk1w9lreq.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: implement renameat2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org

Le 22/01/2018 à 18:44, Andreas Schwab a écrit :
> This is needed for new architectures like RISC-V which do not provide any
> other rename-like syscall.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  linux-user/syscall.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5e54889522..12ca06c65a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -598,6 +598,23 @@ static int sys_utimensat(int dirfd, const char *pathname,
>  #endif
>  #endif /* TARGET_NR_utimensat */
>  
> +#ifdef TARGET_NR_renameat2
> +#if defined(__NR_renameat2)
> +#define __NR_sys_renameat2 __NR_renameat2
> +_syscall5(int, sys_renameat2, int, oldfd, const char *, old, int, newfd,
> +          const char *, new, unsigned int, flags)
> +#else
> +static int sys_renameat2(int oldfd, const char *old,
> +                         int newfd, const chat *new, int flags)

"const char *" would look better.

And, please, test it (build/run).

Thanks,
Laurent
