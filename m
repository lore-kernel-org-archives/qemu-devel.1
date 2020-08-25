Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5ACC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E68720639
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E68720639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kASxw-0007eh-Gd
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 03:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kASwo-0006h1-Np
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:00:47 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kASwl-0006l6-Qz
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:00:46 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MRVy9-1jwUKJ0wh3-00NQat; Tue, 25 Aug 2020 09:00:38 +0200
Subject: Re: [PATCH v2 1/2] linux-user: Add support for ppoll_time64() and
 pselect6_time64()
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200824223050.92032-1-Filip.Bozuta@syrmia.com>
 <20200824223050.92032-2-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0798950c-1b72-f4f1-5ee0-e9822d3ea161@vivier.eu>
Date: Tue, 25 Aug 2020 09:00:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824223050.92032-2-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GBTtAD0DOJHID8gsT8ejcLeU/rUIOE7jaKte5JSBgywamy/a6WD
 PcFQuiOx0pMyDadxS95boAes9sPwoTn8UYtCXmK51/+MC5Dom39mmYmypIhCTG/Xx8fcdSP
 XSZY1HK02X3pyjDDj/QO/L8GpMdu550LG7aO8o9o2JFLZdAVj5VMxmAuJSC1OP64yRzg627
 Di8xwAv6w1QYJttoIG//w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xTAnL9Ypq1w=:VebG1iztXJ/wSbkPSsajrY
 GQ6o1Rig2FNazaJPuN6D9VW5Ayb6Sb+1HeUgADe8K7120fdW6cFQxs+wEaUPkve2KafAyOgUT
 3GCQOG1RtBRqHw1LCuid0yLu6d57/YXv2UHojxEnjBNVuXR10dxMjSj0SGrw1qXC2HkINOoEO
 FccrKreQ+em68d3FRumsgWkqY2jSb1pN2AhLgu6F9b/nE22pSeN08M94VTv0zFku713Qg4mJK
 KKwxbXdbr33V+vYs2xFxBvW7utPAhLzOK9XZy09ZWPWFRVqN3DzzFEZt2QoI8UNpKsdYBB+6V
 bB6QxAuZC1Louafa8Q270gfRo2mVf41wKXVywmLHu4mbQaZt+WyQxHSta5AwACH0WQDZiKRVv
 VMktTt8/9HBuKx6gZbUVwBN+hqXQCbUoPaT/RX7hIp7ZyYkbpbVWEuu425H7wD5Wqy9fEL5Fh
 euYE0gkfafxfaxMAIqIseylEJGc8MYdFkvIHY8nxHWtCXWLZr7XoRYxL8/Bgaoqmy+Vb8oCo6
 zsoym9QBZ/39+0Z1/xq/533aXQob1eipTpU6MXRtCfqt6NxcQAuZqht7jfbqSep0UlMxYH0Q2
 9aMzT39MHSLUPRJPduMhWQUGsOxeesf6pbXALPUSkPY5Zwz4EOgygZlplFMfFkljQoK3+g/XL
 KL50pA+exekXFXrJAcoNxwJj8yfSRQN3RQeFJH/8TkjkQIMJzaQwrzovwVZi0olmxebO8S6wR
 LHexksY5vvIK1+5xTlGDgYxWKvicR3OarLfhVZylqdde6T9jDOqLxIa3SMK+Y9cwG5foMXvlg
 fu+FfYKVwFQJUjDXhk3qfitUA/dyU9ZcCWpeUO8+rjm8ogcNlppVIDagHQKENgXTA5bCzxb
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 03:00:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/08/2020 à 00:30, Filip Bozuta a écrit :
> This patch introduces functionality for following time64 syscalls:
> 
> *ppoll_time64
> 
>     This is a year 2038 safe variant of:
> 
>     int poll(struct pollfd *fds, nfds_t nfds, int timeout)
>     -- wait for some event on a file descriptor --
>     man page: https://man7.org/linux/man-pages/man2/ppoll.2.html
> 
> *pselect6_time64
> 
>     This is a year 2038 safe variant of:
> 
>     int pselect6(int nfds, fd_set *readfds, fd_set *writefds,
>                  fd_set *exceptfds, const struct timespec *timeout,
>                  const sigset_t *sigmask);
>     -- synchronous I/O multiplexing --
>     man page: https://man7.org/linux/man-pages/man2/pselect6.2.html
> 
> Implementation notes:
> 
>     Year 2038 safe syscalls in this patch were implemented
>     with the same code as their regular variants (ppoll() and pselect()).
>     This code was moved to new functions ('do_ppoll()' and 'do_pselect6()')
>     that take a 'bool time64' from which a right 'struct timespec' converting
>     function is called.
>     (target_to_host/host_to_target_timespec() for regular and
>      target_to_host/host_to_target_timespec64() for time64 variants)
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/syscall.c | 462 +++++++++++++++++++++++--------------------
>  1 file changed, 251 insertions(+), 211 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1211e759c2..fc6a6e32e4 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -397,7 +397,7 @@ static int sys_getcwd1(char *buf, size_t size)
>    return strlen(buf)+1;
>  }
>  
> -#ifdef TARGET_NR_utimensat
> +#if defined(TARGET_NR_utimensat)
>  #if defined(__NR_utimensat)
>  #define __NR_sys_utimensat __NR_utimensat
>  _syscall4(int,sys_utimensat,int,dirfd,const char *,pathname,
> @@ -763,11 +763,11 @@ safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
>                int, options, struct rusage *, rusage)
>  safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
>  #if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
> -    defined(TARGET_NR_pselect6)
> +    defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
>  safe_syscall6(int, pselect6, int, nfds, fd_set *, readfds, fd_set *, writefds, \
>                fd_set *, exceptfds, struct timespec *, timeout, void *, sig)
>  #endif
> -#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_poll)
> +#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_ppoll_time64)
>  safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
>                struct timespec *, tsp, const sigset_t *, sigmask,
>                size_t, sigsetsize)
> @@ -984,7 +984,7 @@ abi_long do_brk(abi_ulong new_brk)
>  }
>  
>  #if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
> -    defined(TARGET_NR_pselect6)
> +    defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
>  static inline abi_long copy_from_user_fdset(fd_set *fds,
>                                              abi_ulong target_fds_addr,
>                                              int n)
> @@ -1252,7 +1252,8 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
>  }
>  #endif
>  
> -#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64)
> +#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64) || \
> +    defined(TARGET_NR_pselect6_time64) || defined(TARGET_NR_ppoll_time64)
>  static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
>                                                   abi_ulong target_addr)
>  {
> @@ -1458,6 +1459,237 @@ static abi_long do_old_select(abi_ulong arg1)
>  #endif
>  #endif
>  
> +#if defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
> +static abi_long do_pselect6(abi_long arg1, abi_long arg2, abi_long arg3,
> +                            abi_long arg4, abi_long arg5, abi_long arg6,
> +                            bool time64)
> +{
> +    abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
> +    fd_set rfds, wfds, efds;
> +    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
> +    struct timespec ts, *ts_ptr;
> +    abi_long ret;
> +
> +    /*
> +     * The 6th arg is actually two args smashed together,
> +     * so we cannot use the C library.
> +     */
> +    sigset_t set;
> +    struct {
> +        sigset_t *set;
> +        size_t size;
> +    } sig, *sig_ptr;
> +
> +    abi_ulong arg_sigset, arg_sigsize, *arg7;
> +    target_sigset_t *target_sigset;
> +
> +    n = arg1;
> +    rfd_addr = arg2;
> +    wfd_addr = arg3;
> +    efd_addr = arg4;
> +    ts_addr = arg5;
> +
> +    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
> +    if (ret) {
> +        return ret;
> +    }
> +    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
> +    if (ret) {
> +        return ret;
> +    }
> +    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    /*
> +     * This takes a timespec, and not a timeval, so we cannot
> +     * use the do_select() helper ...
> +     */
> +    if (ts_addr) {
> +        if (time64) {
> +            if (target_to_host_timespec64(&ts, ts_addr)) {
> +                return -TARGET_EFAULT;
> +            }
> +        } else {
> +            if (target_to_host_timespec(&ts, ts_addr)) {
> +                return -TARGET_EFAULT;
> +            }
> +        }
> +            ts_ptr = &ts;
> +    } else {
> +        ts_ptr = NULL;
> +    }
> +
> +    /* Extract the two packed args for the sigset */
> +    if (arg6) {
> +        sig_ptr = &sig;
> +        sig.size = SIGSET_T_SIZE;
> +
> +        arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
> +        if (!arg7) {
> +            return -TARGET_EFAULT;
> +        }
> +        arg_sigset = tswapal(arg7[0]);
> +        arg_sigsize = tswapal(arg7[1]);
> +        unlock_user(arg7, arg6, 0);
> +
> +        if (arg_sigset) {
> +            sig.set = &set;
> +            if (arg_sigsize != sizeof(*target_sigset)) {
> +                /* Like the kernel, we enforce correct size sigsets */
> +                return -TARGET_EINVAL;
> +            }
> +            target_sigset = lock_user(VERIFY_READ, arg_sigset,
> +                                      sizeof(*target_sigset), 1);
> +            if (!target_sigset) {
> +                return -TARGET_EFAULT;
> +            }
> +            target_to_host_sigset(&set, target_sigset);
> +            unlock_user(target_sigset, arg_sigset, 0);
> +        } else {
> +            sig.set = NULL;
> +        }
> +    } else {
> +        sig_ptr = NULL;
> +    }
> +
> +    ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
> +                                  ts_ptr, sig_ptr));
> +
> +    if (!is_error(ret)) {
> +        if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n)) {
> +            return -TARGET_EFAULT;
> +        }
> +        if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n)) {
> +            return -TARGET_EFAULT;
> +        }
> +        if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n)) {
> +            return -TARGET_EFAULT;
> +        }
> +        if (time64) {
> +            if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
> +                return -TARGET_EFAULT;
> +            }
> +        } else {
> +            if (ts_addr && host_to_target_timespec64(ts_addr, &ts)) {
> +                return -TARGET_EFAULT;
> +            }
> +        }
> +    }
> +    return ret;
> +}
> +#endif
> +
> +#if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll) || \
> +    defined(TARGET_NR_ppoll_time64)
> +static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
> +                         abi_long arg4, abi_long arg5, bool ppoll, bool time64)
> +{
> +    struct target_pollfd *target_pfd;
> +    unsigned int nfds = arg2;
> +    struct pollfd *pfd;
> +    unsigned int i;
> +    abi_long ret;
> +
> +    pfd = NULL;
> +    target_pfd = NULL;
> +    if (nfds) {
> +        if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
> +            return -TARGET_EINVAL;
> +        }
> +        target_pfd = lock_user(VERIFY_WRITE, arg1,
> +                               sizeof(struct target_pollfd) * nfds, 1);
> +        if (!target_pfd) {
> +            return -TARGET_EFAULT;
> +        }
> +
> +        pfd = alloca(sizeof(struct pollfd) * nfds);
> +        for (i = 0; i < nfds; i++) {
> +            pfd[i].fd = tswap32(target_pfd[i].fd);
> +            pfd[i].events = tswap16(target_pfd[i].events);
> +        }
> +    }
> +    if (ppoll) {
> +        struct timespec _timeout_ts, *timeout_ts = &_timeout_ts;
> +        target_sigset_t *target_set;
> +        sigset_t _set, *set = &_set;
> +
> +        if (arg3) {
> +            if (time64) {
> +                if (target_to_host_timespec64(timeout_ts, arg3)) {
> +                    unlock_user(target_pfd, arg1, 0);
> +                    return -TARGET_EFAULT;
> +                }
> +            } else {
> +                if (target_to_host_timespec(timeout_ts, arg3)) {
> +                    unlock_user(target_pfd, arg1, 0);
> +                    return -TARGET_EFAULT;
> +                }
> +            }
> +        } else {
> +            timeout_ts = NULL;
> +        }
> +
> +        if (arg4) {
> +            if (arg5 != sizeof(target_sigset_t)) {
> +                unlock_user(target_pfd, arg1, 0);
> +                return -TARGET_EINVAL;
> +            }
> +
> +            target_set = lock_user(VERIFY_READ, arg4,
> +                                   sizeof(target_sigset_t), 1);
> +            if (!target_set) {
> +                unlock_user(target_pfd, arg1, 0);
> +                return -TARGET_EFAULT;
> +            }
> +            target_to_host_sigset(set, target_set);
> +        } else {
> +            set = NULL;
> +        }
> +
> +        ret = get_errno(safe_ppoll(pfd, nfds, timeout_ts,
> +                                   set, SIGSET_T_SIZE));
> +
> +        if (!is_error(ret) && arg3) {
> +            if (time64) {
> +                if (host_to_target_timespec64(arg3, timeout_ts)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            } else {
> +                if (host_to_target_timespec(arg3, timeout_ts)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            }
> +        }
> +        if (arg4) {
> +            unlock_user(target_set, arg4, 0);
> +        }
> +    } else {
> +          struct timespec ts, *pts;
> +
> +          if (arg3 >= 0) {
> +              /* Convert ms to secs, ns */
> +              ts.tv_sec = arg3 / 1000;
> +              ts.tv_nsec = (arg3 % 1000) * 1000000LL;
> +              pts = &ts;
> +          } else {
> +              /* -ve poll() timeout means "infinite" */
> +              pts = NULL;
> +          }
> +          ret = get_errno(safe_ppoll(pfd, nfds, pts, NULL, 0));
> +    }
> +
> +    if (!is_error(ret)) {
> +        for (i = 0; i < nfds; i++) {
> +            target_pfd[i].revents = tswap16(pfd[i].revents);
> +        }
> +    }
> +    unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
> +    return ret;
> +}
> +#endif
> +
>  static abi_long do_pipe2(int host_pipe[], int flags)
>  {
>  #ifdef CONFIG_PIPE2
> @@ -9045,106 +9277,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #endif
>  #ifdef TARGET_NR_pselect6
>      case TARGET_NR_pselect6:
> -        {
> -            abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
> -            fd_set rfds, wfds, efds;
> -            fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
> -            struct timespec ts, *ts_ptr;
> -
> -            /*
> -             * The 6th arg is actually two args smashed together,
> -             * so we cannot use the C library.
> -             */
> -            sigset_t set;
> -            struct {
> -                sigset_t *set;
> -                size_t size;
> -            } sig, *sig_ptr;
> -
> -            abi_ulong arg_sigset, arg_sigsize, *arg7;
> -            target_sigset_t *target_sigset;
> -
> -            n = arg1;
> -            rfd_addr = arg2;
> -            wfd_addr = arg3;
> -            efd_addr = arg4;
> -            ts_addr = arg5;
> -
> -            ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
> -            if (ret) {
> -                return ret;
> -            }
> -            ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
> -            if (ret) {
> -                return ret;
> -            }
> -            ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
> -            if (ret) {
> -                return ret;
> -            }
> -
> -            /*
> -             * This takes a timespec, and not a timeval, so we cannot
> -             * use the do_select() helper ...
> -             */
> -            if (ts_addr) {
> -                if (target_to_host_timespec(&ts, ts_addr)) {
> -                    return -TARGET_EFAULT;
> -                }
> -                ts_ptr = &ts;
> -            } else {
> -                ts_ptr = NULL;
> -            }
> -
> -            /* Extract the two packed args for the sigset */
> -            if (arg6) {
> -                sig_ptr = &sig;
> -                sig.size = SIGSET_T_SIZE;
> -
> -                arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
> -                if (!arg7) {
> -                    return -TARGET_EFAULT;
> -                }
> -                arg_sigset = tswapal(arg7[0]);
> -                arg_sigsize = tswapal(arg7[1]);
> -                unlock_user(arg7, arg6, 0);
> -
> -                if (arg_sigset) {
> -                    sig.set = &set;
> -                    if (arg_sigsize != sizeof(*target_sigset)) {
> -                        /* Like the kernel, we enforce correct size sigsets */
> -                        return -TARGET_EINVAL;
> -                    }
> -                    target_sigset = lock_user(VERIFY_READ, arg_sigset,
> -                                              sizeof(*target_sigset), 1);
> -                    if (!target_sigset) {
> -                        return -TARGET_EFAULT;
> -                    }
> -                    target_to_host_sigset(&set, target_sigset);
> -                    unlock_user(target_sigset, arg_sigset, 0);
> -                } else {
> -                    sig.set = NULL;
> -                }
> -            } else {
> -                sig_ptr = NULL;
> -            }
> -
> -            ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
> -                                          ts_ptr, sig_ptr));
> -
> -            if (!is_error(ret)) {
> -                if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n))
> -                    return -TARGET_EFAULT;
> -                if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n))
> -                    return -TARGET_EFAULT;
> -                if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
> -                    return -TARGET_EFAULT;
> -
> -                if (ts_addr && host_to_target_timespec(ts_addr, &ts))
> -                    return -TARGET_EFAULT;
> -            }
> -        }
> -        return ret;
> +        return do_pselect6(arg1, arg2, arg3, arg4, arg5, arg6, false);
> +#endif
> +#ifdef TARGET_NR_pselect6_time64
> +    case TARGET_NR_pselect6_time64:
> +        return do_pselect6(arg1, arg2, arg3, arg4, arg5, arg6, true);
>  #endif
>  #ifdef TARGET_NR_symlink
>      case TARGET_NR_symlink:
> @@ -10076,114 +10213,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR__newselect:
>          return do_select(arg1, arg2, arg3, arg4, arg5);
>  #endif
> -#if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll)
> -# ifdef TARGET_NR_poll
> +#ifdef TARGET_NR_poll
>      case TARGET_NR_poll:
> -# endif
> -# ifdef TARGET_NR_ppoll
> +        return do_ppoll(arg1, arg2, arg3, arg4, arg5, false, false);
> +#endif
> +#ifdef TARGET_NR_ppoll
>      case TARGET_NR_ppoll:
> -# endif
> -        {
> -            struct target_pollfd *target_pfd;
> -            unsigned int nfds = arg2;
> -            struct pollfd *pfd;
> -            unsigned int i;
> -
> -            pfd = NULL;
> -            target_pfd = NULL;
> -            if (nfds) {
> -                if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
> -                    return -TARGET_EINVAL;
> -                }
> -
> -                target_pfd = lock_user(VERIFY_WRITE, arg1,
> -                                       sizeof(struct target_pollfd) * nfds, 1);
> -                if (!target_pfd) {
> -                    return -TARGET_EFAULT;
> -                }
> -
> -                pfd = alloca(sizeof(struct pollfd) * nfds);
> -                for (i = 0; i < nfds; i++) {
> -                    pfd[i].fd = tswap32(target_pfd[i].fd);
> -                    pfd[i].events = tswap16(target_pfd[i].events);
> -                }
> -            }
> -
> -            switch (num) {
> -# ifdef TARGET_NR_ppoll
> -            case TARGET_NR_ppoll:
> -            {
> -                struct timespec _timeout_ts, *timeout_ts = &_timeout_ts;
> -                target_sigset_t *target_set;
> -                sigset_t _set, *set = &_set;
> -
> -                if (arg3) {
> -                    if (target_to_host_timespec(timeout_ts, arg3)) {
> -                        unlock_user(target_pfd, arg1, 0);
> -                        return -TARGET_EFAULT;
> -                    }
> -                } else {
> -                    timeout_ts = NULL;
> -                }
> -
> -                if (arg4) {
> -                    if (arg5 != sizeof(target_sigset_t)) {
> -                        unlock_user(target_pfd, arg1, 0);
> -                        return -TARGET_EINVAL;
> -                    }
> -
> -                    target_set = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
> -                    if (!target_set) {
> -                        unlock_user(target_pfd, arg1, 0);
> -                        return -TARGET_EFAULT;
> -                    }
> -                    target_to_host_sigset(set, target_set);
> -                } else {
> -                    set = NULL;
> -                }
> -
> -                ret = get_errno(safe_ppoll(pfd, nfds, timeout_ts,
> -                                           set, SIGSET_T_SIZE));
> -
> -                if (!is_error(ret) && arg3) {
> -                    host_to_target_timespec(arg3, timeout_ts);
> -                }
> -                if (arg4) {
> -                    unlock_user(target_set, arg4, 0);
> -                }
> -                break;
> -            }
> -# endif
> -# ifdef TARGET_NR_poll
> -            case TARGET_NR_poll:
> -            {
> -                struct timespec ts, *pts;
> -
> -                if (arg3 >= 0) {
> -                    /* Convert ms to secs, ns */
> -                    ts.tv_sec = arg3 / 1000;
> -                    ts.tv_nsec = (arg3 % 1000) * 1000000LL;
> -                    pts = &ts;
> -                } else {
> -                    /* -ve poll() timeout means "infinite" */
> -                    pts = NULL;
> -                }
> -                ret = get_errno(safe_ppoll(pfd, nfds, pts, NULL, 0));
> -                break;
> -            }
> -# endif
> -            default:
> -                g_assert_not_reached();
> -            }
> -
> -            if (!is_error(ret)) {
> -                for(i = 0; i < nfds; i++) {
> -                    target_pfd[i].revents = tswap16(pfd[i].revents);
> -                }
> -            }
> -            unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
> -        }
> -        return ret;
> +        return do_ppoll(arg1, arg2, arg3, arg4, arg5, true, false);
> +#endif
> +#ifdef TARGET_NR_ppoll_time64
> +    case TARGET_NR_ppoll_time64:
> +        return do_ppoll(arg1, arg2, arg3, arg4, arg5, true, true);
>  #endif
>      case TARGET_NR_flock:
>          /* NOTE: the flock constant seems to be the same for every
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

