Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB520C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 20:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD80B20760
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 20:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD80B20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEf1B-0002uy-Ui
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 16:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kEf0b-0002Ue-4l
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 16:42:01 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kEf0Y-0003Oo-4c
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 16:42:00 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M7sUE-1k9hBr3iMc-0051AQ; Sat, 05 Sep 2020 22:41:54 +0200
Subject: Re: [PATCH v2 1/2] linux-user: Add support for ppoll_time64() and
 pselect6_time64()
From: Laurent Vivier <laurent@vivier.eu>
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200824223050.92032-1-Filip.Bozuta@syrmia.com>
 <20200824223050.92032-2-Filip.Bozuta@syrmia.com>
 <1920aafd-aecf-eb9d-1474-df639a23107a@vivier.eu>
 <c519996a-95b7-fe1f-8d83-6caea7ab0bb1@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <00eef592-bcc8-1d61-ff85-1d25ca284234@vivier.eu>
Date: Sat, 5 Sep 2020 22:41:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c519996a-95b7-fe1f-8d83-6caea7ab0bb1@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0Y7wlwpH7XZOUNBE+ANvKpCE/gOMn+UAr1t6guKVhHul2L5det1
 7uzaRuvT76Tdw+raCjjEV0wjyAGklHMzi0qe21BL+QYfPXU5ShOj++2oKW7rQPuGRU7bbP3
 +ZU5daRAnwzm913FaTomQxDuizFVs8o+3fCbPrnq1uoRVbG3MOROF2NFqNyBIQbRXYgwYzK
 nXmGSBBwH79uq+xKIxC8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TP4DMlj72So=:VL/F7pZDftdmpYg/te575z
 5AZpXMuhUXtbQUMCoP7dFqsAlE36GicwIzQH8hMWY1uxtLqb/qPW1wdL7mw9gg5CwXRFI1JKm
 LilOdOZpg11nhUqVm0Gc3Kkegsl47NmkmCQLolg3W4XJOwNZr7DNqRT7nU1hHElBvyCeli9JA
 fVRYpygvxdD1n55FuR3uHu2uq82tjesJDkXniW+Wd8NsRdRSJqxLCLYqRoDH39eEB783/ZqrP
 jenNcwaxZ13mODkS2jv8NiHfTUk0YTuohljGdGsVXwpSuQqqBLQllhF6VQ8MeNDJJVpbc5dvO
 hl1QhKytghAmGQx6ybJ1jDEfKD+kg/+6e314IyKhvLUMPGRn0XHU5mEEzduGyj7VruUtOxb3X
 IFIRpa1yMmkCfgnQQ6KykpIPfOLd9GOHhJBjCmd2c7ofJaSoP7klo5D6YaEKJOJnLf11z6Z8b
 kNTY0nzxoC29agMIDtH0IDDMMNDfvAZuGpsoRLiye6gxu0Ad3XJwP6RCfKhjyss5NRWbyuGUS
 sLE1yt9/EKQC/Te2uybhoSqReQ1/vbQsvCSBkKANalgXXnM5iKmulAE8nVgy0uPulFASVmjKk
 EZNEacOoOGKq8KrE7OSQutDKiRIL6umjp+3YArQHgq+tUlYrjst4FS7v46iC7Xk7+G7wpTDUc
 Hi8OLIpCRGdA7yZf0lSg16J8lzPa/1hilasXtDp0f9S9cLMj5D2YM5JtxKmmnM7MbuWuHIoDH
 Uvy1i7cmhC7WK7t/mCqRovBkTEZ5RAoI0TjDYi5vb05CB/j9GwBIkFnPpYP9P3taGtvkIG2tb
 d3ECvqTHSYW7waQxOxu7k0QJy/jyoRFkcc3hs+7OI1wgzHD2sXxD/dMKBCe66J4zBtTRVTs
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 16:41:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
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

Le 25/08/2020 à 17:23, Laurent Vivier a écrit :
> Le 25/08/2020 à 09:17, Laurent Vivier a écrit :
>> Le 25/08/2020 à 00:30, Filip Bozuta a écrit :
>>> This patch introduces functionality for following time64 syscalls:
>>>
>>> *ppoll_time64
>>>
>>>     This is a year 2038 safe variant of:
>>>
>>>     int poll(struct pollfd *fds, nfds_t nfds, int timeout)
>>>     -- wait for some event on a file descriptor --
>>>     man page: https://man7.org/linux/man-pages/man2/ppoll.2.html
>>>
>>> *pselect6_time64
>>>
>>>     This is a year 2038 safe variant of:
>>>
>>>     int pselect6(int nfds, fd_set *readfds, fd_set *writefds,
>>>                  fd_set *exceptfds, const struct timespec *timeout,
>>>                  const sigset_t *sigmask);
>>>     -- synchronous I/O multiplexing --
>>>     man page: https://man7.org/linux/man-pages/man2/pselect6.2.html
>>>
>>> Implementation notes:
>>>
>>>     Year 2038 safe syscalls in this patch were implemented
>>>     with the same code as their regular variants (ppoll() and pselect()).
>>>     This code was moved to new functions ('do_ppoll()' and 'do_pselect6()')
>>>     that take a 'bool time64' from which a right 'struct timespec' converting
>>>     function is called.
>>>     (target_to_host/host_to_target_timespec() for regular and
>>>      target_to_host/host_to_target_timespec64() for time64 variants)
>>>
>>> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
>>> ---
>>>  linux-user/syscall.c | 462 +++++++++++++++++++++++--------------------
>>>  1 file changed, 251 insertions(+), 211 deletions(-)
>>>
>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>> index 1211e759c2..fc6a6e32e4 100644
>>> --- a/linux-user/syscall.c
>>> +++ b/linux-user/syscall.c
>>> @@ -397,7 +397,7 @@ static int sys_getcwd1(char *buf, size_t size)
>>>    return strlen(buf)+1;
>>>  }
>>>  
>>> -#ifdef TARGET_NR_utimensat
>>> +#if defined(TARGET_NR_utimensat)
>>>  #if defined(__NR_utimensat)
>>>  #define __NR_sys_utimensat __NR_utimensat
>>>  _syscall4(int,sys_utimensat,int,dirfd,const char *,pathname,
>>> @@ -763,11 +763,11 @@ safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
>>>                int, options, struct rusage *, rusage)
>>>  safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
>>>  #if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
>>> -    defined(TARGET_NR_pselect6)
>>> +    defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
>>>  safe_syscall6(int, pselect6, int, nfds, fd_set *, readfds, fd_set *, writefds, \
>>>                fd_set *, exceptfds, struct timespec *, timeout, void *, sig)
>>>  #endif
>>> -#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_poll)
>>> +#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_ppoll_time64)
>>>  safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
>>>                struct timespec *, tsp, const sigset_t *, sigmask,
>>>                size_t, sigsetsize)
>>> @@ -984,7 +984,7 @@ abi_long do_brk(abi_ulong new_brk)
>>>  }
>>>  
>>>  #if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
>>> -    defined(TARGET_NR_pselect6)
>>> +    defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
>>>  static inline abi_long copy_from_user_fdset(fd_set *fds,
>>>                                              abi_ulong target_fds_addr,
>>>                                              int n)
>>> @@ -1252,7 +1252,8 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
>>>  }
>>>  #endif
>>>  
>>> -#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64)
>>> +#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64) || \
>>> +    defined(TARGET_NR_pselect6_time64) || defined(TARGET_NR_ppoll_time64)
>>>  static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
>>>                                                   abi_ulong target_addr)
>>>  {
>>> @@ -1458,6 +1459,237 @@ static abi_long do_old_select(abi_ulong arg1)
>>>  #endif
>>>  #endif
>>>  
>>> +#if defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6_time64)
>>> +static abi_long do_pselect6(abi_long arg1, abi_long arg2, abi_long arg3,
>>> +                            abi_long arg4, abi_long arg5, abi_long arg6,
>>> +                            bool time64)
>>> +{
>>> +    abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
>>> +    fd_set rfds, wfds, efds;
>>> +    fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
>>> +    struct timespec ts, *ts_ptr;
>>> +    abi_long ret;
>>> +
>>> +    /*
>>> +     * The 6th arg is actually two args smashed together,
>>> +     * so we cannot use the C library.
>>> +     */
>>> +    sigset_t set;
>>> +    struct {
>>> +        sigset_t *set;
>>> +        size_t size;
>>> +    } sig, *sig_ptr;
>>> +
>>> +    abi_ulong arg_sigset, arg_sigsize, *arg7;
>>> +    target_sigset_t *target_sigset;
>>> +
>>> +    n = arg1;
>>> +    rfd_addr = arg2;
>>> +    wfd_addr = arg3;
>>> +    efd_addr = arg4;
>>> +    ts_addr = arg5;
>>> +
>>> +    ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +    ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +    ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    /*
>>> +     * This takes a timespec, and not a timeval, so we cannot
>>> +     * use the do_select() helper ...
>>> +     */
>>> +    if (ts_addr) {
>>> +        if (time64) {
>>> +            if (target_to_host_timespec64(&ts, ts_addr)) {
>>> +                return -TARGET_EFAULT;
>>> +            }
>>> +        } else {
>>> +            if (target_to_host_timespec(&ts, ts_addr)) {
>>> +                return -TARGET_EFAULT;
>>> +            }
>>> +        }
>>> +            ts_ptr = &ts;
>>> +    } else {
>>> +        ts_ptr = NULL;
>>> +    }
>>> +
>>> +    /* Extract the two packed args for the sigset */
>>> +    if (arg6) {
>>> +        sig_ptr = &sig;
>>> +        sig.size = SIGSET_T_SIZE;
>>> +
>>> +        arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
>>> +        if (!arg7) {
>>> +            return -TARGET_EFAULT;
>>> +        }
>>> +        arg_sigset = tswapal(arg7[0]);
>>> +        arg_sigsize = tswapal(arg7[1]);
>>> +        unlock_user(arg7, arg6, 0);
>>> +
>>> +        if (arg_sigset) {
>>> +            sig.set = &set;
>>> +            if (arg_sigsize != sizeof(*target_sigset)) {
>>> +                /* Like the kernel, we enforce correct size sigsets */
>>> +                return -TARGET_EINVAL;
>>> +            }
>>> +            target_sigset = lock_user(VERIFY_READ, arg_sigset,
>>> +                                      sizeof(*target_sigset), 1);
>>> +            if (!target_sigset) {
>>> +                return -TARGET_EFAULT;
>>> +            }
>>> +            target_to_host_sigset(&set, target_sigset);
>>> +            unlock_user(target_sigset, arg_sigset, 0);
>>> +        } else {
>>> +            sig.set = NULL;
>>> +        }
>>> +    } else {
>>> +        sig_ptr = NULL;
>>> +    }
>>> +
>>> +    ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
>>> +                                  ts_ptr, sig_ptr));
>>> +
>>> +    if (!is_error(ret)) {
>>> +        if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n)) {
>>> +            return -TARGET_EFAULT;
>>> +        }
>>> +        if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n)) {
>>> +            return -TARGET_EFAULT;
>>> +        }
>>> +        if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n)) {
>>> +            return -TARGET_EFAULT;
>>> +        }
>>> +        if (time64) {
>>> +            if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
>>> +                return -TARGET_EFAULT;
>>> +            }
>>> +        } else {
>>> +            if (ts_addr && host_to_target_timespec64(ts_addr, &ts)) {
>>> +                return -TARGET_EFAULT;
>>> +            }
>>> +        }
>>> +    }
>>> +    return ret;
>>> +}
>>> +#endif
>>> +
>>> +#if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll) || \
>>> +    defined(TARGET_NR_ppoll_time64)
>>> +static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
>>> +                         abi_long arg4, abi_long arg5, bool ppoll, bool time64)
>>> +{
>>> +    struct target_pollfd *target_pfd;
>>> +    unsigned int nfds = arg2;
>>> +    struct pollfd *pfd;
>>> +    unsigned int i;
>>> +    abi_long ret;
>>> +
>>> +    pfd = NULL;
>>> +    target_pfd = NULL;
>>> +    if (nfds) {
>>> +        if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
>>> +            return -TARGET_EINVAL;
>>> +        }
>>> +        target_pfd = lock_user(VERIFY_WRITE, arg1,
>>> +                               sizeof(struct target_pollfd) * nfds, 1);
>>> +        if (!target_pfd) {
>>> +            return -TARGET_EFAULT;
>>> +        }
>>> +
>>> +        pfd = alloca(sizeof(struct pollfd) * nfds);
>>> +        for (i = 0; i < nfds; i++) {
>>> +            pfd[i].fd = tswap32(target_pfd[i].fd);
>>> +            pfd[i].events = tswap16(target_pfd[i].events);
>>> +        }
>>> +    }
>>> +    if (ppoll) {
>>> +        struct timespec _timeout_ts, *timeout_ts = &_timeout_ts;
>>> +        target_sigset_t *target_set;
>>> +        sigset_t _set, *set = &_set;
>>> +
>>> +        if (arg3) {
>>> +            if (time64) {
>>> +                if (target_to_host_timespec64(timeout_ts, arg3)) {
>>> +                    unlock_user(target_pfd, arg1, 0);
>>> +                    return -TARGET_EFAULT;
>>> +                }
>>> +            } else {
>>> +                if (target_to_host_timespec(timeout_ts, arg3)) {
>>> +                    unlock_user(target_pfd, arg1, 0);
>>> +                    return -TARGET_EFAULT;
>>> +                }
>>> +            }
>>> +        } else {
>>> +            timeout_ts = NULL;
>>> +        }
>>> +
>>> +        if (arg4) {
>>> +            if (arg5 != sizeof(target_sigset_t)) {
>>> +                unlock_user(target_pfd, arg1, 0);
>>> +                return -TARGET_EINVAL;
>>> +            }
>>> +
>>> +            target_set = lock_user(VERIFY_READ, arg4,
>>> +                                   sizeof(target_sigset_t), 1);
>>> +            if (!target_set) {
>>> +                unlock_user(target_pfd, arg1, 0);
>>> +                return -TARGET_EFAULT;
>>> +            }
>>> +            target_to_host_sigset(set, target_set);
>>> +        } else {
>>> +            set = NULL;
>>> +        }
>>> +
>>> +        ret = get_errno(safe_ppoll(pfd, nfds, timeout_ts,
>>> +                                   set, SIGSET_T_SIZE));
>>> +
>>> +        if (!is_error(ret) && arg3) {
>>> +            if (time64) {
>>> +                if (host_to_target_timespec64(arg3, timeout_ts)) {
>>> +                    return -TARGET_EFAULT;
>>> +                }
>>> +            } else {
>>> +                if (host_to_target_timespec(arg3, timeout_ts)) {
>>> +                    return -TARGET_EFAULT;
>>> +                }
>>> +            }
>>> +        }
>>> +        if (arg4) {
>>> +            unlock_user(target_set, arg4, 0);
>>> +        }
>>> +    } else {
>>> +          struct timespec ts, *pts;
>>> +
>>> +          if (arg3 >= 0) {
>>> +              /* Convert ms to secs, ns */
>>> +              ts.tv_sec = arg3 / 1000;
>>> +              ts.tv_nsec = (arg3 % 1000) * 1000000LL;
>>> +              pts = &ts;
>>> +          } else {
>>> +              /* -ve poll() timeout means "infinite" */
>>> +              pts = NULL;
>>> +          }
>>> +          ret = get_errno(safe_ppoll(pfd, nfds, pts, NULL, 0));
>>> +    }
>>> +
>>> +    if (!is_error(ret)) {
>>> +        for (i = 0; i < nfds; i++) {
>>> +            target_pfd[i].revents = tswap16(pfd[i].revents);
>>> +        }
>>> +    }
>>> +    unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
>>> +    return ret;
>>> +}
>>> +#endif
>>> +
>>>  static abi_long do_pipe2(int host_pipe[], int flags)
>>>  {
>>>  #ifdef CONFIG_PIPE2
>>> @@ -9045,106 +9277,11 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>>>  #endif
>>>  #ifdef TARGET_NR_pselect6
>>>      case TARGET_NR_pselect6:
>>> -        {
>>> -            abi_long rfd_addr, wfd_addr, efd_addr, n, ts_addr;
>>> -            fd_set rfds, wfds, efds;
>>> -            fd_set *rfds_ptr, *wfds_ptr, *efds_ptr;
>>> -            struct timespec ts, *ts_ptr;
>>> -
>>> -            /*
>>> -             * The 6th arg is actually two args smashed together,
>>> -             * so we cannot use the C library.
>>> -             */
>>> -            sigset_t set;
>>> -            struct {
>>> -                sigset_t *set;
>>> -                size_t size;
>>> -            } sig, *sig_ptr;
>>> -
>>> -            abi_ulong arg_sigset, arg_sigsize, *arg7;
>>> -            target_sigset_t *target_sigset;
>>> -
>>> -            n = arg1;
>>> -            rfd_addr = arg2;
>>> -            wfd_addr = arg3;
>>> -            efd_addr = arg4;
>>> -            ts_addr = arg5;
>>> -
>>> -            ret = copy_from_user_fdset_ptr(&rfds, &rfds_ptr, rfd_addr, n);
>>> -            if (ret) {
>>> -                return ret;
>>> -            }
>>> -            ret = copy_from_user_fdset_ptr(&wfds, &wfds_ptr, wfd_addr, n);
>>> -            if (ret) {
>>> -                return ret;
>>> -            }
>>> -            ret = copy_from_user_fdset_ptr(&efds, &efds_ptr, efd_addr, n);
>>> -            if (ret) {
>>> -                return ret;
>>> -            }
>>> -
>>> -            /*
>>> -             * This takes a timespec, and not a timeval, so we cannot
>>> -             * use the do_select() helper ...
>>> -             */
>>> -            if (ts_addr) {
>>> -                if (target_to_host_timespec(&ts, ts_addr)) {
>>> -                    return -TARGET_EFAULT;
>>> -                }
>>> -                ts_ptr = &ts;
>>> -            } else {
>>> -                ts_ptr = NULL;
>>> -            }
>>> -
>>> -            /* Extract the two packed args for the sigset */
>>> -            if (arg6) {
>>> -                sig_ptr = &sig;
>>> -                sig.size = SIGSET_T_SIZE;
>>> -
>>> -                arg7 = lock_user(VERIFY_READ, arg6, sizeof(*arg7) * 2, 1);
>>> -                if (!arg7) {
>>> -                    return -TARGET_EFAULT;
>>> -                }
>>> -                arg_sigset = tswapal(arg7[0]);
>>> -                arg_sigsize = tswapal(arg7[1]);
>>> -                unlock_user(arg7, arg6, 0);
>>> -
>>> -                if (arg_sigset) {
>>> -                    sig.set = &set;
>>> -                    if (arg_sigsize != sizeof(*target_sigset)) {
>>> -                        /* Like the kernel, we enforce correct size sigsets */
>>> -                        return -TARGET_EINVAL;
>>> -                    }
>>> -                    target_sigset = lock_user(VERIFY_READ, arg_sigset,
>>> -                                              sizeof(*target_sigset), 1);
>>> -                    if (!target_sigset) {
>>> -                        return -TARGET_EFAULT;
>>> -                    }
>>> -                    target_to_host_sigset(&set, target_sigset);
>>> -                    unlock_user(target_sigset, arg_sigset, 0);
>>> -                } else {
>>> -                    sig.set = NULL;
>>> -                }
>>> -            } else {
>>> -                sig_ptr = NULL;
>>> -            }
>>> -
>>> -            ret = get_errno(safe_pselect6(n, rfds_ptr, wfds_ptr, efds_ptr,
>>> -                                          ts_ptr, sig_ptr));
>>> -
>>> -            if (!is_error(ret)) {
>>> -                if (rfd_addr && copy_to_user_fdset(rfd_addr, &rfds, n))
>>> -                    return -TARGET_EFAULT;
>>> -                if (wfd_addr && copy_to_user_fdset(wfd_addr, &wfds, n))
>>> -                    return -TARGET_EFAULT;
>>> -                if (efd_addr && copy_to_user_fdset(efd_addr, &efds, n))
>>> -                    return -TARGET_EFAULT;
>>> -
>>> -                if (ts_addr && host_to_target_timespec(ts_addr, &ts))
>>> -                    return -TARGET_EFAULT;
>>> -            }
>>> -        }
>>> -        return ret;
>>> +        return do_pselect6(arg1, arg2, arg3, arg4, arg5, arg6, false);
>>> +#endif
>>> +#ifdef TARGET_NR_pselect6_time64
>>> +    case TARGET_NR_pselect6_time64:
>>> +        return do_pselect6(arg1, arg2, arg3, arg4, arg5, arg6, true);
>>>  #endif
>>>  #ifdef TARGET_NR_symlink
>>>      case TARGET_NR_symlink:
>>> @@ -10076,114 +10213,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>>>      case TARGET_NR__newselect:
>>>          return do_select(arg1, arg2, arg3, arg4, arg5);
>>>  #endif
>>> -#if defined(TARGET_NR_poll) || defined(TARGET_NR_ppoll)
>>> -# ifdef TARGET_NR_poll
>>> +#ifdef TARGET_NR_poll
>>>      case TARGET_NR_poll:
>>> -# endif
>>> -# ifdef TARGET_NR_ppoll
>>> +        return do_ppoll(arg1, arg2, arg3, arg4, arg5, false, false);
>>> +#endif
>>> +#ifdef TARGET_NR_ppoll
>>>      case TARGET_NR_ppoll:
>>> -# endif
>>> -        {
>>> -            struct target_pollfd *target_pfd;
>>> -            unsigned int nfds = arg2;
>>> -            struct pollfd *pfd;
>>> -            unsigned int i;
>>> -
>>> -            pfd = NULL;
>>> -            target_pfd = NULL;
>>> -            if (nfds) {
>>> -                if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
>>> -                    return -TARGET_EINVAL;
>>> -                }
>>> -
>>> -                target_pfd = lock_user(VERIFY_WRITE, arg1,
>>> -                                       sizeof(struct target_pollfd) * nfds, 1);
>>> -                if (!target_pfd) {
>>> -                    return -TARGET_EFAULT;
>>> -                }
>>> -
>>> -                pfd = alloca(sizeof(struct pollfd) * nfds);
>>> -                for (i = 0; i < nfds; i++) {
>>> -                    pfd[i].fd = tswap32(target_pfd[i].fd);
>>> -                    pfd[i].events = tswap16(target_pfd[i].events);
>>> -                }
>>> -            }
>>> -
>>> -            switch (num) {
>>> -# ifdef TARGET_NR_ppoll
>>> -            case TARGET_NR_ppoll:
>>> -            {
>>> -                struct timespec _timeout_ts, *timeout_ts = &_timeout_ts;
>>> -                target_sigset_t *target_set;
>>> -                sigset_t _set, *set = &_set;
>>> -
>>> -                if (arg3) {
>>> -                    if (target_to_host_timespec(timeout_ts, arg3)) {
>>> -                        unlock_user(target_pfd, arg1, 0);
>>> -                        return -TARGET_EFAULT;
>>> -                    }
>>> -                } else {
>>> -                    timeout_ts = NULL;
>>> -                }
>>> -
>>> -                if (arg4) {
>>> -                    if (arg5 != sizeof(target_sigset_t)) {
>>> -                        unlock_user(target_pfd, arg1, 0);
>>> -                        return -TARGET_EINVAL;
>>> -                    }
>>> -
>>> -                    target_set = lock_user(VERIFY_READ, arg4, sizeof(target_sigset_t), 1);
>>> -                    if (!target_set) {
>>> -                        unlock_user(target_pfd, arg1, 0);
>>> -                        return -TARGET_EFAULT;
>>> -                    }
>>> -                    target_to_host_sigset(set, target_set);
>>> -                } else {
>>> -                    set = NULL;
>>> -                }
>>> -
>>> -                ret = get_errno(safe_ppoll(pfd, nfds, timeout_ts,
>>> -                                           set, SIGSET_T_SIZE));
>>> -
>>> -                if (!is_error(ret) && arg3) {
>>> -                    host_to_target_timespec(arg3, timeout_ts);
>>> -                }
>>> -                if (arg4) {
>>> -                    unlock_user(target_set, arg4, 0);
>>> -                }
>>> -                break;
>>> -            }
>>> -# endif
>>> -# ifdef TARGET_NR_poll
>>> -            case TARGET_NR_poll:
>>> -            {
>>> -                struct timespec ts, *pts;
>>> -
>>> -                if (arg3 >= 0) {
>>> -                    /* Convert ms to secs, ns */
>>> -                    ts.tv_sec = arg3 / 1000;
>>> -                    ts.tv_nsec = (arg3 % 1000) * 1000000LL;
>>> -                    pts = &ts;
>>> -                } else {
>>> -                    /* -ve poll() timeout means "infinite" */
>>> -                    pts = NULL;
>>> -                }
>>> -                ret = get_errno(safe_ppoll(pfd, nfds, pts, NULL, 0));
>>> -                break;
>>> -            }
>>> -# endif
>>> -            default:
>>> -                g_assert_not_reached();
>>> -            }
>>> -
>>> -            if (!is_error(ret)) {
>>> -                for(i = 0; i < nfds; i++) {
>>> -                    target_pfd[i].revents = tswap16(pfd[i].revents);
>>> -                }
>>> -            }
>>> -            unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
>>> -        }
>>> -        return ret;
>>> +        return do_ppoll(arg1, arg2, arg3, arg4, arg5, true, false);
>>> +#endif
>>> +#ifdef TARGET_NR_ppoll_time64
>>> +    case TARGET_NR_ppoll_time64:
>>> +        return do_ppoll(arg1, arg2, arg3, arg4, arg5, true, true);
>>>  #endif
>>>      case TARGET_NR_flock:
>>>          /* NOTE: the flock constant seems to be the same for every
>>>
>>
>> Applied to my linux-user-for-5.2 branch.
> 
> 
> I have removed it from my branch because this patch breaks "go run
> hello.go" on armhf/bionic:
> 
> # cat /tmp/hello.go
> package main
> 
> import "fmt"
> 
> func main() {
>         fmt.Println("Hello World!")
> }
> 
> # go run /tmp/hello.go
> fatal error: unexpected signal during runtime execution
> fatal error: unexpected signal during runtime execution
> panic during panic
> [signal SIGSEGV: segmentation violation code=0x1 addr=0x0 pc=0x0]
> ...
> 

I've re-applied this patch to linux-user-for-5.2 with this change that
fixes the problem above:

--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1568,11 +1568,11 @@ static abi_long do_pselect6(abi_long arg1,
abi_long arg2, abi_long arg3,
             return -TARGET_EFAULT;
         }
         if (time64) {
-            if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
+            if (ts_addr && host_to_target_timespec64(ts_addr, &ts)) {
                 return -TARGET_EFAULT;
             }
         } else {
-            if (ts_addr && host_to_target_timespec64(ts_addr, &ts)) {
+            if (ts_addr && host_to_target_timespec(ts_addr, &ts)) {
                 return -TARGET_EFAULT;
             }
         }

Thanks,
Laurent


