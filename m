Received: from eggs.gnu.org ([2001:4830:134:3::10]:46252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAPWz-0001GI-LV
	for qemu-devel@nongnu.org; Mon, 15 May 2017 19:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAPWw-00005v-Il
	for qemu-devel@nongnu.org; Mon, 15 May 2017 19:36:01 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:32769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAPWw-00005m-Ds
	for qemu-devel@nongnu.org; Mon, 15 May 2017 19:35:58 -0400
Received: by mail-qt0-x243.google.com with SMTP id a46so18308101qte.0
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 16:35:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
	<1494860396-24930-6-git-send-email-Milos.Stojanovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff06e3de-e330-9e52-39b6-11324eafe92b@amsat.org>
Date: Mon, 15 May 2017 20:35:53 -0300
MIME-Version: 1.0
In-Reply-To: <1494860396-24930-6-git-send-email-Milos.Stojanovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/16] linux-user: fix argument type
 declaration of rt_sigqueinfo() syscall
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
> Change the type of the first argument of rt_sigqueinfo() from int to pid_t
> in the syscall declaration to match specifications of the system call.
>
> Proper spacing is added to satisfy checkpatch.pl.
>
> Signed-off-by: Miloš Stojanović <Milos.Stojanovic@rt-rk.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ff03e1a..9ec7ccd 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -274,7 +274,7 @@ _syscall3(int, sys_getdents64, uint, fd, struct linux_dirent64 *, dirp, uint, co
>  _syscall5(int, _llseek,  uint,  fd, ulong, hi, ulong, lo,
>            loff_t *, res, uint, wh);
>  #endif
> -_syscall3(int,sys_rt_sigqueueinfo,int,pid,int,sig,siginfo_t *,uinfo)
> +_syscall3(int, sys_rt_sigqueueinfo, pid_t, pid, int, sig, siginfo_t *, uinfo)
>  _syscall3(int,sys_syslog,int,type,char*,bufp,int,len)
>  #ifdef __NR_exit_group
>  _syscall1(int,exit_group,int,error_code)
>
