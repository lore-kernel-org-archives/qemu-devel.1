Received: from eggs.gnu.org ([2001:4830:134:3::10]:58697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFOYt-0006WY-4O
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFOYq-00014g-31
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:02:19 -0500
Received: from mail-wj0-f178.google.com ([209.85.210.178]:33969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFOYp-00014X-SS
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:02:16 -0500
Received: by mail-wj0-f178.google.com with SMTP id tg4so19604797wjb.1
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 09:02:15 -0800 (PST)
References: <20161201051433.17168-1-bobby.prani@gmail.com>
	<20161201051433.17168-2-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20161201051433.17168-2-bobby.prani@gmail.com>
Date: Fri, 09 Dec 2016 17:01:13 +0000
Message-ID: <87oa0lxciu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/19] linux-user: fix settime old value
 location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>


Pranith Kumar <bobby.prani@gmail.com> writes:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> old_value is the 4th argument of timer_settime(), not the 2nd.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

but this should really be sent in another series.

> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7b77503..5bd477a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12027,7 +12027,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              target_to_host_itimerspec(&hspec_new, arg3);
>              ret = get_errno(
>                            timer_settime(htimer, arg2, &hspec_new, &hspec_old));
> -            host_to_target_itimerspec(arg2, &hspec_old);
> +            host_to_target_itimerspec(arg4, &hspec_old);
>          }
>          break;
>      }


--
Alex Bennée
