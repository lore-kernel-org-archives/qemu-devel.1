Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAFCC2D0EB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FE02077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 17:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPTnjMNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FE02077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHAAA-0002Dj-VZ
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 13:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jHA9O-0001iT-Kx
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jHA9M-0004Jk-Qv
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 13:49:10 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:45179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jHA9M-0004JS-MX; Wed, 25 Mar 2020 13:49:08 -0400
Received: by mail-vs1-xe43.google.com with SMTP id x82so2052759vsc.12;
 Wed, 25 Mar 2020 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cPLkRAKlWOcXsQFYe7cbBfkPV9YTCAb16AFUMS26xiA=;
 b=QPTnjMNG7O5EJi+drLVh1YuVjsJ+vg3HX63jwoLgrH750S4TAaXnSkQvtYrdRkNNWr
 MW/NQPjq60qHkDaqN2bRcPgB1BEfrfrm62yQqWwSQA60ElM2cfVv8UbRKFcvv23eGO8M
 nSOBo1ATlDuewGnA+OvGMIxmSOJAhJ5A+EQWn6BX+MWMhDLRlQE953504woRb7wjB7bH
 w12rrtpGWIZJiPJMmDd4L6D2BGn6P7GXNi9Utg7K3+ZmRJt4UbpRcT/vnOar3LY3z8Gc
 Tjazwoaq2DAKiq9wDPJAfhDmeu8h061njs8R/jFQzbmeJT2lAwT1fI9AlQhdNKYsDLBk
 sLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cPLkRAKlWOcXsQFYe7cbBfkPV9YTCAb16AFUMS26xiA=;
 b=HrmUzgyZMJ84ApvZCclq6pWtppvL+RVveIU82VFZb2e+PTqokcrWPQ+0cE8wbVgVPQ
 dNazm5nN5SmzJ6WZ8bgw00x0glLKllBoOfmQCLdSl9knc6xHJoUvQM0dYKJUKw12lqzH
 HRAVmZB0HCicGRKF4CMTK6wibaNl5pYOXHU8COYk7Ci9MP4eXRyEofYBlhbP2A2NJhWO
 uF9pD8DkQdpSpUJHUde3mjR3DdckURLx50gGLOyxu4/RlMB5E0nchGG1ccqHiaEkFdGy
 vd9zvBUfD572qvA4orgFl63hLqkNmJYGKR7lWJU0aQsnDieCJL/Px8VxsIvPUr+3Db3y
 mQXA==
X-Gm-Message-State: ANhLgQ2I3IBh3/U69b9x62Rv0nvYZkI/UCGyDp9LVupwIXLc1eBPY9A9
 globHBN7sFrhnCk8RQI4ppDAw4+cPNQaEbwLECM=
X-Google-Smtp-Source: ADFU+vs3SylU/8LwXiAJXPgfd5WYVXy/O4bvPC+3ay+OLT4YtLWRcbOM9N9veOYB3Sc8WWHsTiW+WcapobDuEklto8w=
X-Received: by 2002:a67:1b81:: with SMTP id b123mr3829223vsb.172.1585158547647; 
 Wed, 25 Mar 2020 10:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584571250.git.alistair.francis@wdc.com>
 <d9390e368a9a1fd32d52aa771815e6e3d40cb1d4.1584571250.git.alistair.francis@wdc.com>
In-Reply-To: <d9390e368a9a1fd32d52aa771815e6e3d40cb1d4.1584571250.git.alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2020 10:41:08 -0700
Message-ID: <CAKmqyKNTpfDvWx85eAK2YNRgzxHRMA8NBvJJf081X3O76B=ekQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] linux-user: Support futex_time64
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e43
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 18, 2020 at 3:54 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Add support for host and target futex_time64. If futex_time64 exists on
> the host we try that first before falling back to the standard futux
> syscall.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

@Laurent did you see this?

I guess it's a little late for 5.0 but it would be nice to support.

Alistair

> ---
>  linux-user/syscall.c | 144 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 131 insertions(+), 13 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 60fd775d9c..3354f41bb2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -245,7 +245,12 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,  \
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
> +#if defined(__NR_futex_time64)
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
> --
> 2.25.1
>

