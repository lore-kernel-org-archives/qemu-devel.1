Received: from eggs.gnu.org ([2001:4830:134:3::10]:49632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fS3R2-0007m5-T7
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 12:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fS3Qz-0005kF-C1
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 12:43:20 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:41307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fS3Qz-0005jW-6v
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 12:43:17 -0400
Received: by mail-qt0-x244.google.com with SMTP id y20-v6so18201548qto.8
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 09:43:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
	<20180610030220.3777-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8507c400-7e3a-9979-5687-52abba42bf79@amsat.org>
Date: Sun, 10 Jun 2018 13:43:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180610030220.3777-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 001/108] linux-user: Remove DEBUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu

On 06/10/2018 12:00 AM, Richard Henderson wrote:
> This is redundant with both -strace and actual tracing.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  linux-user/syscall.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7b9ac3b408..c212149245 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -163,7 +163,6 @@
>   * (The one remaining unallocated bit is 0x1000 which used to be CLONE_PID.)
>   */
>  
> -//#define DEBUG
>  /* Define DEBUG_ERESTARTSYS to force every syscall to be restarted
>   * once. This exercises the codepaths for restart.
>   */
> @@ -5777,9 +5776,6 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
>          ie++;
>      }
>      arg_type = ie->arg_type;
> -#if defined(DEBUG)
> -    gemu_log("ioctl: cmd=0x%04lx (%s)\n", (long)cmd, ie->name);
> -#endif
>      if (ie->do_ioctl) {
>          return ie->do_ioctl(ie, buf_temp, fd, cmd, arg);
>      } else if (!ie->host_cmd) {
> @@ -7980,9 +7976,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>      }
>  #endif
>  
> -#ifdef DEBUG
> -    gemu_log("syscall %d", num);
> -#endif
>      trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
>      if(do_strace)
>          print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> @@ -12772,9 +12765,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>          break;
>      }
>  fail:
> -#ifdef DEBUG
> -    gemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);
> -#endif
>      if(do_strace)
>          print_syscall_ret(num, ret);
>      trace_guest_user_syscall_ret(cpu, num, ret);
> 
