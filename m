Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE73AC1975A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 11:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9917A2076F
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 11:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9917A2076F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD4qH-00011l-Qh
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 07:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jD4pU-0000ZU-9L
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jD4pS-0005Y9-LB
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 07:19:44 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44831)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jD4pS-0005XD-By; Sat, 14 Mar 2020 07:19:42 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N3bGP-1jMbAh3qD5-010Z29; Sat, 14 Mar 2020 12:19:37 +0100
Subject: Re: [PATCH v8 3/4] linux-user: Support futex_time64
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1584143748.git.alistair.francis@wdc.com>
 <517832730838e1d0b5eda26781b280854d792f9e.1584143748.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5b33e81e-e8ff-5222-e802-31690aa1a36c@vivier.eu>
Date: Sat, 14 Mar 2020 12:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <517832730838e1d0b5eda26781b280854d792f9e.1584143748.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:esGc8YyL/wVlB1zfrOiNrp74XNnT1/+wPIhOxyBJISie52nQ82F
 V5LZd0IBmh4+SbCu1A2ZXL95zCjNLRJxK69Z3YvFzOFr/b4R+Kw3biGygbJmIl2JfU8a5oT
 NPnWhBIGXydqZ857EcP2aTLNEjDE+LNG8x9MHQP7m5hy6wkmVllz4CLGf2wnT9PKh2OmCCT
 +XmheV4HZ5diVJGWZAZ9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:34T2+eQIMQM=:0LgDchGWSpKEA8OStiFx1X
 ABktkpnH6plg9GTo8QLqIZgQGgxppAqfzXu+qL2MCY7c49kDtHlagDKQ8BTPX2NdG6gQeydGL
 kPcMYal37Bxr3rjg3D4qK5soJDhUwCf9IGoN+uHvW5QB/J6ndMQc9qdz/LEYJGym3DhupfkLK
 UNuryfZI6I58rp3GvaXxhYWkYNQKjcVTLUO6JAi8r4ENOMJ+keBBRx0THn0ZXIbqEoyoA4/QB
 Kthpltc/GxsvUh/C/A7EeZmQlECsazhwYT5kgfRH2akStIvDIOmIXT+Qd0jXbP/t3B1am6De3
 OI3kGux6LyVnmx6krycr9J1LD2ttijWJ0nLWlTk3j4m8v9Htef8ogOisTXmaZCH929B2Wz9Oh
 OvMgDgtZZYidrk17VlImH7+Omlqu4J4QmYdLJaxsg1gQaTIvWppVTPwwzpOBDV+SK8Mevuu2N
 G6MUoRrLOa6iDJ2/roXqYeowVBul5VIWNHAfefeR7oPo/HUGpcC8s6kTthJFLLwsaK73zUxVl
 OKpW5BOBYmEWsYXo3WaPdmaOrWTK7TgNrGpioFUWE53xKo71wakD0vDkrGFyTuHMz++kw+ynq
 /TQXSafor8MvCEKFriEmZ+CDV596AhdnwxERQSMCVjZQZtj4UFMGz0gHA9Pso98TfWcAZuoDB
 ueTrFkZdnAB2RfjXOwxPBdEYrbNAWJ0yut5SLpIK6bPkIRBAAFL1satEMqU6U+yc4yhpb4HTE
 sYy7t91ryvNXBMi2CANcHEKKq6XESREnTtHOxeMpNzoA9m9LG5zzCuBsklQky76KQBDSTiTnv
 Ozl5rOi3LJ7t3nrKHZ+yghzhl5Xc3cSa2TRqipoxx5+0o5lypF3Ey01Ztb7AnuBDADX1XGD
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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

Le 14/03/2020 à 00:56, Alistair Francis a écrit :
> Add support for host and target futex_time64. If futex_time64 exists on
> the host we try that first before falling back to the standard futux
> syscall.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/syscall.c | 144 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 131 insertions(+), 13 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 60fd775d9c..b3bfb02688 100644
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
>  #define __NR_sys_inotify_init __NR_inotify_init
>  #define __NR_sys_inotify_add_watch __NR_inotify_add_watch
>  #define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
> @@ -295,10 +300,16 @@ _syscall1(int,exit_group,int,error_code)
>  #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
>  _syscall1(int,set_tid_address,int *,tidptr)
>  #endif
> -#if defined(TARGET_NR_futex) && defined(__NR_futex)
> +#if (defined(TARGET_NR_futex) && defined(__NR_futex)) || \
> +    (defined(TARGET_NR_futex_time64) && \
> +        (HOST_LONG_BITS == 64 && defined(__NR_futex)))
>  _syscall6(int,sys_futex,int *,uaddr,int,op,int,val,
>            const struct timespec *,timeout,int *,uaddr2,int,val3)
>  #endif
> +#if (defined(TARGET_NR_futex_time64) && defined(__NR_futex_teim64))
> +_syscall6(int,sys_futex_time64,int *,uaddr,int,op,int,val,
> +          const struct timespec *,timeout,int *,uaddr2,int,val3)
> +#endif
>  #define __NR_sys_sched_getaffinity __NR_sched_getaffinity
>  _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
>            unsigned long *, user_mask_ptr);
> @@ -762,10 +773,14 @@ safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
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
>  safe_syscall2(int, rt_sigsuspend, sigset_t *, newset, size_t, sigsetsize)
>  safe_syscall2(int, kill, pid_t, pid, int, sig)
>  safe_syscall2(int, tkill, int, tid, int, sig)
> @@ -1229,7 +1244,7 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
>  }
>  #endif
>  
> -#if defined(TARGET_NR_clock_settime64)
> +#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64)
>  static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
>                                                   abi_ulong target_addr)
>  {
> @@ -6890,6 +6905,55 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
>  }
>  #endif
>  
> +static int do_sys_futex(int *uaddr, int op, int val,
> +                         const struct timespec *timeout, int *uaddr2,
> +                         int val3)
> +{
> +#if HOST_LONG_BITS == 64
> +#if defined(__NR_futex)
> +    /* always a 64-bit time_t, it doesn't define _time64 version  */
> +    return sys_futex(uaddr, op, val, timeout, uaddr2, val3);
> +
> +#endif
> +#else /* HOST_LONG_BITS == 64 */
> +#if defined(__NR_futex_time64)
> +    if (sizeof(timeout->tv_sec) == 8) {
> +        /* _time64 function on 32bit arch */
> +        return sys_futex_time64(uaddr, op, val, timeout, uaddr2, val3);
> +    }
> +#endif
> +#if defined(__NR_futex)
> +    /* old function on 32bit arch */
> +    return sys_futex(uaddr, op, val, timeout, uaddr2, val3);
> +#endif
> +#endif /* HOST_LONG_BITS == 64 */
> +    g_assert_not_reached();
> +}
> +
> +static int do_safe_futex(int *uaddr, int op, int val,
> +                         const struct timespec *timeout, int *uaddr2,
> +                         int val3)
> +{
> +#if HOST_LONG_BITS == 64
> +#if defined(__NR_futex)
> +    /* always a 64-bit time_t, it doesn't define _time64 version  */
> +    return get_errno(safe_futex(uaddr, op, val, timeout, uaddr2, val3));
> +#endif
> +#else /* HOST_LONG_BITS == 64 */
> +#if defined(__NR_futex_time64)
> +    if (sizeof(timeout->tv_sec) == 8) {
> +        /* _time64 function on 32bit arch */
> +        return get_errno(safe_futex_time64(uaddr, op, val, timeout, uaddr2,
> +                                           val3));
> +    }
> +#endif
> +#if defined(__NR_futex)
> +    /* old function on 32bit arch */
> +    return get_errno(safe_futex(uaddr, op, val, timeout, uaddr2, val3));
> +#endif
> +#endif /* HOST_LONG_BITS == 64 */
> +    return -TARGET_ENOSYS;
> +}
>  
>  /* ??? Using host futex calls even when target atomic operations
>     are not really atomic probably breaks things.  However implementing
> @@ -6919,12 +6983,61 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
>          } else {
>              pts = NULL;
>          }
> -        return get_errno(safe_futex(g2h(uaddr), op, tswap32(val),
> +        return get_errno(do_safe_futex(g2h(uaddr), op, tswap32(val),
> +                         pts, NULL, val3));
> +    case FUTEX_WAKE:
> +        return get_errno(do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
> +    case FUTEX_FD:
> +        return get_errno(do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
> +    case FUTEX_REQUEUE:
> +    case FUTEX_CMP_REQUEUE:
> +    case FUTEX_WAKE_OP:
> +        /* For FUTEX_REQUEUE, FUTEX_CMP_REQUEUE, and FUTEX_WAKE_OP, the
> +           TIMEOUT parameter is interpreted as a uint32_t by the kernel.
> +           But the prototype takes a `struct timespec *'; insert casts
> +           to satisfy the compiler.  We do not need to tswap TIMEOUT
> +           since it's not compared to guest memory.  */
> +        pts = (struct timespec *)(uintptr_t) timeout;
> +        return get_errno(do_safe_futex(g2h(uaddr), op, val, pts,
> +                                       g2h(uaddr2),
> +                                       (base_op == FUTEX_CMP_REQUEUE
> +                                        ? tswap32(val3)
> +                                        : val3)));
> +    default:
> +        return -TARGET_ENOSYS;
> +    }
> +}
> +#endif
> +
> +#if defined(TARGET_NR_futex_time64)
> +static int do_futex_time64(target_ulong uaddr, int op, int val, target_ulong timeout,
> +                           target_ulong uaddr2, int val3)
> +{
> +    struct timespec ts, *pts;
> +    int base_op;
> +
> +    /* ??? We assume FUTEX_* constants are the same on both host
> +       and target.  */
> +#ifdef FUTEX_CMD_MASK
> +    base_op = op & FUTEX_CMD_MASK;
> +#else
> +    base_op = op;
> +#endif
> +    switch (base_op) {
> +    case FUTEX_WAIT:
> +    case FUTEX_WAIT_BITSET:
> +        if (timeout) {
> +            pts = &ts;
> +            target_to_host_timespec64(pts, timeout);
> +        } else {
> +            pts = NULL;
> +        }
> +        return get_errno(do_safe_futex(g2h(uaddr), op, tswap32(val),
>                           pts, NULL, val3));
>      case FUTEX_WAKE:
> -        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
> +        return get_errno(do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
>      case FUTEX_FD:
> -        return get_errno(safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
> +        return get_errno(do_safe_futex(g2h(uaddr), op, val, NULL, NULL, 0));
>      case FUTEX_REQUEUE:
>      case FUTEX_CMP_REQUEUE:
>      case FUTEX_WAKE_OP:
> @@ -6934,16 +7047,17 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
>             to satisfy the compiler.  We do not need to tswap TIMEOUT
>             since it's not compared to guest memory.  */
>          pts = (struct timespec *)(uintptr_t) timeout;
> -        return get_errno(safe_futex(g2h(uaddr), op, val, pts,
> -                                    g2h(uaddr2),
> -                                    (base_op == FUTEX_CMP_REQUEUE
> -                                     ? tswap32(val3)
> -                                     : val3)));
> +        return get_errno(do_safe_futex(g2h(uaddr), op, val, pts,
> +                                       g2h(uaddr2),
> +                                       (base_op == FUTEX_CMP_REQUEUE
> +                                        ? tswap32(val3)
> +                                        : val3)));
>      default:
>          return -TARGET_ENOSYS;
>      }
>  }
>  #endif
> +
>  #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
>  static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
>                                       abi_long handle, abi_long mount_id,
> @@ -7505,7 +7619,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ts = cpu->opaque;
>              if (ts->child_tidptr) {
>                  put_user_u32(0, ts->child_tidptr);
> -                sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
> +                do_sys_futex(g2h(ts->child_tidptr), FUTEX_WAKE, INT_MAX,
>                            NULL, NULL, 0);
>              }
>              thread_cpu = NULL;
> @@ -11597,6 +11711,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_futex:
>          return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
>  #endif
> +#ifdef TARGET_NR_futex_time64
> +    case TARGET_NR_futex_time64:
> +        return do_futex_time64(arg1, arg2, arg3, arg4, arg5, arg6);
> +#endif
>  #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
>      case TARGET_NR_inotify_init:
>          ret = get_errno(sys_inotify_init());
> 

Applied to my linux-user branch.

Thanks,
Laurent

