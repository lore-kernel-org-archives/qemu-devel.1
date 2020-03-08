Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E732C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 18:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ACF120663
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 18:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACF120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB0Y3-0006Bh-Gv
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 14:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jB0Uf-0004m4-0P
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 14:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jB0Ud-0001PY-B1
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 14:17:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46601)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jB0UZ-0001LO-J8; Sun, 08 Mar 2020 14:17:35 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N2V8T-1jLM871GBD-013syP; Sun, 08 Mar 2020 19:17:28 +0100
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, aleksandar.m.mail@gmail.com
References: <cover.1583518447.git.alistair.francis@wdc.com>
 <b7595a50debfc704e63fde17425eb399a5e5a707.1583518447.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v6 3/4] linux-user: Support futex_time64
Message-ID: <155e6064-c76f-abee-8f07-d7f70c8cfd75@vivier.eu>
Date: Sun, 8 Mar 2020 19:17:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b7595a50debfc704e63fde17425eb399a5e5a707.1583518447.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8ka/rHKS6/RLSVOKdbXaq+ar4WOfG30Ow2zQsEyHG8O5S2TFCu6
 hOQRdsydh7rDf5j5/XJmBbdOGq3Qliaa7+9QImWvbqBPXGb5OvT8qEZYTN16mr2IzvZc5h7
 gbVQi41S/dwTWGObLoDCmz1DRmsBYbdLN/QtHLl+cBflT9+VKwucqnTV7hYTXEqdaDXnf8g
 63TBiO/K7HpXA7Usjx79Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EqNu1kpeLpE=:hVH8+HxHcC2lfo64aS4gE8
 qVwZUS15G6fWRnW2yZ4OIiIKoB13RLJ0n8p6ETSIExFNvGM/WsLEZWZEhqIbLB54HqKAxGNcn
 cu1CYu01l8052SzIBORRon1oXPg89FN8q1cV30m3lhKAb8Koux3UWKoHlhd7U7hkPfC4+G5LE
 Q1hJ6QNM9sS1HiMKCXCcETkDjUouOL+kZxNPJrDLDlG3W+g5dvX1f1QWPW2WX/yN9SXRKOZOK
 MoQS8iuNsy90sxJUva7W8uvC6D5fJHJTOevS/YfZ2p0cKPAAXnLSp7ICkwhnIuBJYwqBPIvvt
 3L1AakYNMvnXu02isJZ8amCk4z2Mg3CeCriQ9IPezR7dOU+3Cz9kLEl22DSv96e78as7JgmD1
 Szdj5CmM3XP9BIqyKLE7Tg7V0IPftDFMCR33qBt090byFlI529n5JsZCZdqhGOvGII0DivYiE
 cOYoy4NO8Iw6nnPJ3uIHEinHxP2iR0dU1hCL7nschiXCcPZweJ33GEntXI9qXFqZfg3Fq/LxT
 GBSXNsaQ43BQczxlOiZIbP9ttSXvEFPIbf7uTFCcUNcirLq6Fv0D6oLZleWurq7bkzzZZu4AF
 L5tf5rHdA+o8jeJNQ5N2PMcMUxawu7mPRwCq4xLW4exaxGjLeGKtJVZEPA7DoBboyo+77Z1S4
 nKd+dPX66uHzEkvANWZyJTmwwX26MuLySNQBtr1tG/MfXw0jQkH5im6kr5o58IW24nPLL20sK
 YzZ3qmmBMRHs6DVCrbfJagCP7u0szOyoONdmkC3honFQdULN7SWLR5fbgzrJOzZ3ThCMGBEtG
 RIBTZ88mzhDAom2MqlLYGEM1vHQfcs/ArMTU14LeCeEAdXGZXjfaI1k5Iqed1MLw9NxT/23
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 06/03/2020 à 19:24, Alistair Francis a écrit :
> Add support for host and target futex_time64. If futex_time64 exists on
> the host we try that first before falling back to the standard futux
> syscall.

In fact there are two definitions for futex: one to use as system call
in TARGET_NR_exit (sys_futex) and one to use to translate
TARGET_NR_futex (see d509eeb13c9c ("linux-user: Use safe_syscall for
futex syscall")).

We also rely on the system timespec definition, so I'm not sure anymore
we can use both 32bit and 64bit host syscalls (it's more complicated
than I expected...)


> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/syscall.c | 98 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 80 insertions(+), 18 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 0f219b26c1..8a50e2d3dc 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -245,7 +245,12 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
>  #define __NR_sys_rt_sigqueueinfo __NR_rt_sigqueueinfo
>  #define __NR_sys_rt_tgsigqueueinfo __NR_rt_tgsigqueueinfo
>  #define __NR_sys_syslog __NR_syslog
> -#define __NR_sys_futex __NR_futex
> +#if defined(__NR_futex)
> +# define __NR_sys_futex __NR_futex
> +#endif
> +#if defined(__NR_futex_time64)
> +# define __NR_sys_futex_time64 __NR_futex_time64
> +#endif

As you don't use futex_time64() in TARGET_NR_exit, you don't need to
define it.

>  #define __NR_sys_inotify_init __NR_inotify_init
>  #define __NR_sys_inotify_add_watch __NR_inotify_add_watch
>  #define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
> @@ -295,10 +300,15 @@ _syscall1(int,exit_group,int,error_code)
>  #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
>  _syscall1(int,set_tid_address,int *,tidptr)
>  #endif
> -#if defined(TARGET_NR_futex) && defined(__NR_futex)
> +#if (defined(TARGET_NR_futex) || defined(TARGET_NR_futex_time64)) && \
> +    defined(__NR_futex)
>  _syscall6(int,sys_futex,int *,uaddr,int,op,int,val,
>            const struct timespec *,timeout,int *,uaddr2,int,val3)
>  #endif
> +#if defined(TARGET_NR_futex_time64) && defined(__NR_futex_time64)
> +_syscall6(int,sys_futex_time64,int *,uaddr,int,op,int,val,
> +          const struct timespec *,timeout,int *,uaddr2,int,val3)
> +#endif

We don't need them as the sys_ version are not used in TARGET_NR_futex
and TARGET_NR_futex_time64...

>  #define __NR_sys_sched_getaffinity __NR_sched_getaffinity
>  _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
>            unsigned long *, user_mask_ptr);
> @@ -762,10 +772,14 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
>  safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, events,
>                int, maxevents, int, timeout, const sigset_t *, sigmask,
>                size_t, sigsetsize)
> -#ifdef TARGET_NR_futex
> +#if defined(__NR_futex)
>  safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
>                const struct timespec *,timeout,int *,uaddr2,int,val3)
>  #endif
> +#if defined(__NR_futex_time64)
> +safe_syscall6(int,futex_time64,int *,uaddr,int,op,int,val, \
> +              const struct timespec *,timeout,int *,uaddr2,int,val3)
> +#endif

... we use these ones, the safe_ version.

>  safe_syscall2(int, rt_sigsuspend, sigset_t *, newset, size_t, sigsetsize)
>  safe_syscall2(int, kill, pid_t, pid, int, sig)
>  safe_syscall2(int, tkill, int, tid, int, sig)
> @@ -1210,7 +1224,7 @@ static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
>      return 0;
>  }
>  
> -#if defined(TARGET_NR_futex) || \
> +#if defined(TARGET_NR_futex) || defined(TARGET_NR_futex_time64) || \
>      defined(TARGET_NR_rt_sigtimedwait) || \
>      defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6) || \
>      defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || \
> @@ -6898,12 +6912,12 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
>     futexes locally would make futexes shared between multiple processes
>     tricky.  However they're probably useless because guest atomic
>     operations won't work either.  */
> -#if defined(TARGET_NR_futex)
> +#if defined(TARGET_NR_futex) || defined(TARGET_NR_futex_time64)
>  static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
>                      target_ulong uaddr2, int val3)
>  {
>      struct timespec ts, *pts;
> -    int base_op;
> +    int base_op, err = -ENOSYS;
>  
>      /* ??? We assume FUTEX_* constants are the same on both host
>         and target.  */
> @@ -6915,18 +6929,49 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
>      switch (base_op) {
>      case FUTEX_WAIT:
>      case FUTEX_WAIT_BITSET:
> +#ifdef __NR_futex_time64
> +        struct __kernel_timespec ts64, *pts64;
> +
>          if (timeout) {
> -            pts = &ts;
> -            target_to_host_timespec(pts, timeout);
> +            pts64 = &ts64;
> +            target_to_host_timespec64(pts64, timeout);

We use __kernel_timespec with a function that takes timespec.
If system defines __NR_futex_time64 we can guess it uses the 64bit
version of timespec but I'm not sure compiler is happy with that.

Moreover you guess timeout is the target 64bit version and you don't
know that.

>          } else {
> -            pts = NULL;
> +            pts64 = NULL;
> +        }
> +
> +        err = get_errno(safe_futex_time64(g2h(uaddr), op, tswap32(val),
> +                         pts64, NULL, val3));
> +#endif
> +#ifdef __NR_futex
> +        if (err == -ENOSYS) {
> +            if (timeout) {
> +                pts = &ts;
> +                target_to_host_timespec(pts, timeout);

But if __NR_futex_time64 is defined, we guessed timespec is 64bit, so it
cannot be used with target_to_host_timespec().

You guess timeout is the target 32bit version and you don't know that:
you must pass the syscall number (TARGET_NR_futex and
TARGET_NR_futex_time64) to use the good version of the target structure.

target_to_host_timespec64() is to use with the 64bit _target_ syscall,
target_to_host_timespec() with the 32bit _target_ syscall.

To ease the translation you should decorelate target and host syscalls.
To ease the definition of this function you should rely on the system
timespec definition (it appears to be complicated to support both
syscalls because of the timespec definition).

Something like:

static int do_safe_futex(int *uaddr, int op, int val,
                         const struct timespec *timeout, int *uaddr2,
                         int val3)
{
#if HOST_LONG_BITS == 64
#if defined(__NR_futex)
    /* always a 64-bit time_t, it doesn't define _time64 version  */
    return get_errno(safe_futex(uaddr, op, val, timeout, uaddr2, val3));
#endif
#else
#if defined(__NR_futex_time64)
    if (sizeof(timeout->tv_sec) == 8) {
        /* _time64 function on 32bit arch */
        return get_errno(safe_futex_time64(uaddr, op, val, timeout,
uaddr2, val3));
    }
#endif
#if defined(__NR_futex)
    /* old function on 32bit arch */
    return get_errno(safe_futex(uaddr, op, val, timeout, uaddr2, val3));
#endif
#endif
    return -TARGET_ENOSYS;
}

and use it as-is in do_futex() and define a do_futex_time64() that use
it with target_to_host_timespec64() (or add a parameter to do_futex() to
select timespec type).

You should also define a do_sys_futex() to use with TARGET_NR_exit.

> +            } else {
> +                pts = NULL;
> +            }
> +            return get_errno(safe_futex(g2h(uaddr), op, tswap32(val),
> +                             pts, NULL, val3));
>          }
> -        return get_errno(safe_futex(g2h(uaddr), op, tswap32(val),
> -                         pts, NULL, val3));
> +#endif
>      case FUTEX_WAKE:
> -        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
> +#ifdef __NR_futex_time64
> +        err = get_errno(safe_futex_time64(g2h(uaddr), op, val, NULL, NULL, 0));
> +#endif
> +#ifdef __NR_futex
> +        if (err == -ENOSYS) {
> +            return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
> +        }
> +#endif
>      case FUTEX_FD:
> -        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
> +#ifdef __NR_futex_time64
> +        err = get_errno(safe_futex_time64(g2h(uaddr), op, val, NULL, NULL, 0));
> +#endif
> +#ifdef __NR_futex
> +        if (err == -ENOSYS) {
> +            return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
> +        }
> +#endif
>      case FUTEX_REQUEUE:
>      case FUTEX_CMP_REQUEUE:
>      case FUTEX_WAKE_OP:
> @@ -6935,12 +6980,25 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
>             But the prototype takes a `struct timespec *'; insert casts
>             to satisfy the compiler.  We do not need to tswap TIMEOUT
>             since it's not compared to guest memory.  */
> +#ifdef __NR_futex_time64
> +        struct __kernel_timespec *pts64;
> +        pts64 = (struct __kernel_timespec *)(uintptr_t) timeout;
> +        ret = get_errno(safe_futex_time64(g2h(uaddr), op, val, pts64,
> +                                   g2h(uaddr2),
> +                                   (base_op == FUTEX_CMP_REQUEUE
> +                                    ? tswap32(val3)
> +                                    : val3)));
> +#endif
> +#ifdef __NR_futex
>          pts = (struct timespec *)(uintptr_t) timeout;
> -        return get_errno(safe_futex(g2h(uaddr), op, val, pts,
> -                                    g2h(uaddr2),
> -                                    (base_op == FUTEX_CMP_REQUEUE
> -                                     ? tswap32(val3)
> -                                     : val3)));
> +        if (err == -ENOSYS) {
> +            return get_errno(safe_futex(g2h(uaddr), op, val, pts,
> +                                      g2h(uaddr2),
> +                                      (base_op == FUTEX_CMP_REQUEUE
> +                                       ? tswap32(val3)
> +                                       : val3)));
> +        }
> +#endif
>      default:
>          return -TARGET_ENOSYS;
>      }
> @@ -11599,6 +11657,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_futex:
>          return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
>  #endif
> +#ifdef TARGET_NR_futex_time64
> +    case TARGET_NR_futex_time64:
> +        return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);

How do you know if arg4 is target_kernel_timespec (64bit) or
target_timespec (32bit) in the function?

So you should define a do_futex64() function or pass the the syscall
number to the function.

> +#endif
>  #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
>      case TARGET_NR_inotify_init:
>          ret = get_errno(sys_inotify_init());
> 

Thanks,
Laurent

