Received: from eggs.gnu.org ([2001:4830:134:3::10]:45898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAPUu-0000VH-M4
	for qemu-devel@nongnu.org; Mon, 15 May 2017 19:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAPUr-0007sT-Jo
	for qemu-devel@nongnu.org; Mon, 15 May 2017 19:33:52 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAPUr-0007sI-Dq
	for qemu-devel@nongnu.org; Mon, 15 May 2017 19:33:49 -0400
Received: by mail-qk0-x244.google.com with SMTP id k74so20097571qke.2
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 16:33:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
	<1494860396-24930-2-git-send-email-Milos.Stojanovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e44a26c-ff7f-1865-bcc8-8d3282173d52@amsat.org>
Date: Mon, 15 May 2017 20:33:44 -0300
MIME-Version: 1.0
In-Reply-To: <1494860396-24930-2-git-send-email-Milos.Stojanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/16] linux-user: add strace for
 getuid(), gettid(), getppid(), geteuid()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <Milos.Stojanovic@rt-rk.com>, qemu-devel@nongnu.org, riku.voipio@iki.fi
Cc: Miodrag.Dinic@rt-rk.com, laurent@vivier.eu, Petar.Jovanovic@rt-rk.com, Aleksandar.Markovic@rt-rk.com, yongbok.kim@imgtec.com

On 05/15/2017 11:59 AM, Miloš Stojanović wrote:
> Improve strace support for syscalls getuid(), gettid(), getppid()
> and geteuid(). Since these system calls don't have arguments, "%s()"
> is added in the corresponding strace.list entry so that no arguments
> are printed.
>
> getuid:
> Prior to this commit, typical strace output used to look like this:
> 4894 getuid(4894,0,0,274886293296,-3689348814741910323,4832615904) = 1000
> After this commit, it looks like this:
> 4894 getuid() = 1000
>
> gettid:
> Prior to this commit, typical strace output used to look like this:
> 8307 gettid(0,0,64,0,4832630528,4832615840) = 8307
> After this commit, it looks like this:
> 8307 gettid() = 8307
>
> getppid:
> Prior to this commit, typical strace output used to look like this:
> 20588 getppid(20588,64,0,4832630528,4832615888,0) = 20625
> After this commit, it looks like this:
> 20588 getppid() = 20625
>
> geteuid:
> Prior to this commit, typical strace output used to look like this:
> 20588 geteuid(64,0,0,4832615888,0,-9151031864016699136) = 1000
> After this commit, it looks like this:
> 20588 geteuid() = 1000
>
> Signed-off-by: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/strace.list | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 3b1282e..6e33788 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -290,7 +290,7 @@
>  { TARGET_NR_getegid32, "getegid32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_geteuid
> -{ TARGET_NR_geteuid, "geteuid" , NULL, NULL, NULL },
> +{ TARGET_NR_geteuid, "geteuid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_geteuid32
>  { TARGET_NR_geteuid32, "geteuid32" , NULL, NULL, NULL },
> @@ -338,7 +338,7 @@
>  { TARGET_NR_getpmsg, "getpmsg" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getppid
> -{ TARGET_NR_getppid, "getppid" , NULL, NULL, NULL },
> +{ TARGET_NR_getppid, "getppid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getpriority
>  { TARGET_NR_getpriority, "getpriority", "%s(%#x,%#x)", NULL, NULL },
> @@ -381,13 +381,13 @@
>    NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_gettid
> -{ TARGET_NR_gettid, "gettid" , NULL, NULL, NULL },
> +{ TARGET_NR_gettid, "gettid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_gettimeofday
>  { TARGET_NR_gettimeofday, "gettimeofday" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getuid
> -{ TARGET_NR_getuid, "getuid" , NULL, NULL, NULL },
> +{ TARGET_NR_getuid, "getuid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getuid32
>  { TARGET_NR_getuid32, "getuid32" , NULL, NULL, NULL },
>
