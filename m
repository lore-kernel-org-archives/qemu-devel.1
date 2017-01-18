Received: from eggs.gnu.org ([2001:4830:134:3::10]:46761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTwOR-0006ps-B0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cTwOO-0008Uu-9n
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:59:39 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:53144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cTwOO-0008Um-0h
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:59:36 -0500
References: <20170118192428.2661-1-bobby.prani@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7a6dc301-1e55-48f8-5d28-7562562c98c6@vivier.eu>
Date: Wed, 18 Jan 2017 20:59:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170118192428.2661-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] linux-user: fix settime old value
 location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, peter.maydell@linaro.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

Le 18/01/2017 à 20:24, Pranith Kumar a écrit :
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> old_value is the 4th argument of timer_settime(), not the 2nd.
> 
> CC: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> [pranith: review comments]
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/syscall.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7b77503f94..724607be43 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12027,7 +12027,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              target_to_host_itimerspec(&hspec_new, arg3);

as said by Peter in his first comment, target_to_host_itimerspec() can
return -TARGET_EFAULT. You should fix that too.

Thanks,
Laurent
