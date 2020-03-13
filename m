Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33EBC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D6B20752
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D6B20752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCsA5-0001op-Jb
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jCs99-0000yB-JK
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jCs97-0002tV-CO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:47:11 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38507)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jCs95-0002my-Mc; Fri, 13 Mar 2020 17:47:08 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MYeV3-1ipvPe20Qt-00Vcuv; Fri, 13 Mar 2020 22:46:57 +0100
Subject: Re: [PATCH v7 1/4] linux-user: Protect more syscalls
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, aleksandar.m.mail@gmail.com
References: <cover.1584051142.git.alistair.francis@wdc.com>
 <9ffc3cc6226756895157f16622be5f6edfa2aee6.1584051142.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cf30118c-6470-0141-3ed2-7ef1708e99d8@vivier.eu>
Date: Fri, 13 Mar 2020 22:46:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9ffc3cc6226756895157f16622be5f6edfa2aee6.1584051142.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LN290cGJDJP0Z6TthTcj9usfQ7mkpvsIl9oijeySX6A2umxcHHM
 4ULfL93YArJ6GPnNlN3Lj8BWt5Iezf/s859DfZtwgV++LWW9Di46DtXbdR6wkjQ6b9ndXzG
 Vhr25nmdV260Au66GDsxVRwAD1z7Nsnu4VZWZ5/fRbu79CzEcwCFZktDdpGpO7jGc3y/Yoj
 yR5Pr0BSoHmnpPuWq13NQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:50F3osfyLg4=:M+LOGtMRGcIuLlaS80OmZv
 2Ugu4y5N6lYY2xiJkt9FAPGX04/J5VfBleYd7G4aNuz1/DrDC8D/T44Rz1wjyRJKqA+db6NA7
 ctnvYA0B0H2p/yZlTkBfjzc6rR7RXkjV5NvoqbISL06f5ns8/VpuAHpwotCtebbXveWyYxXNU
 JuAGwXrdTUyAqHxQGb+B8/DtdQ+uC6AH+77x08mD43KXeS4sX7txUzsJU18eRK9vRVByQZlOt
 dsVH95ZWCO44VF0cbWxQSI/asa+EALMIt49yyjgn+V0yWbVdYDTMgLbvxGx0OEmAmhQOm6clw
 x80qElvyHUEGUttxwGy9zGRbQGcBmN7/Bs066nxtdRUcRdpF78aCEJg1k5KBYcTJz2HPH4AlX
 P6MIJE0GFAQMrar02YAgBBKRMzCN0Dgd7OJmUCiz19V5j6d/xb7wvouLYQbYr8AE5Didc/R0h
 NcVh1p3kz68gBFJ2qW1KjreVq3Bq9GGkQb+13S5JquZYhi/xcGByIyVuFi8D82e5RD5phuFev
 EG1vsVptzDbEOjH68JQB6edkY07zFftGBRAzpQenpo/JKssHFU/6ou6/bk+vYzW6QUO9DNr1E
 Sm3id0E3FlNESntBlxbWZquGWAwlRs8YQb6GKggiuIX2/wrmHYIxsfy+0YyOvJ6T4DMxntHca
 y/BMNgbaBWAm2R8i8SXLJuZ/DWBv7iCBQ6r6jZ9PwZ4749ZhYDvzXMD/yVuoa+RDVs5qJUyFc
 sxXxwJmiZLBlwwkrbhZOXyp7QSRuKb2QXaBPd8Wofm4WH47vAbnX8QzyL3z9n2mCeqiP/ecUg
 6a4wfkfcQKKuhEpPxazI47qu6Bfa+imT3/m33IjOKalpCgHqvuinBnEdn2jdg+wv1B8LGim
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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

Le 12/03/2020 à 23:13, Alistair Francis a écrit :
> New y2038 safe 32-bit architectures (like RISC-V) don't support old
> syscalls with a 32-bit time_t. The kernel defines new *_time64 versions
> of these syscalls. Add some more #ifdefs to syscall.c in linux-user to
> allow us to compile without these old syscalls.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/strace.c  |  2 ++
>  linux-user/syscall.c | 68 ++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 4f7130b2ff..6420ccd97b 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -775,6 +775,7 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
>  #define TARGET_TIME_OOP      3   /* leap second in progress */
>  #define TARGET_TIME_WAIT     4   /* leap second has occurred */
>  #define TARGET_TIME_ERROR    5   /* clock not synchronized */
> +#ifdef TARGET_NR_adjtimex
>  static void
>  print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
>  {
> @@ -813,6 +814,7 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
>  
>      qemu_log("\n");
>  }
> +#endif
>  
>  UNUSED static struct flags access_flags[] = {
>      FLAG_GENERIC(F_OK),
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8d27d10807..909bec94a5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -742,21 +742,30 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
>  safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
>  safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
>                int, flags, mode_t, mode)
> +#if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
>  safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
>                struct rusage *, rusage)
> +#endif
>  safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
>                int, options, struct rusage *, rusage)
>  safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
> +#if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
> +    defined(TARGET_NR_pselect6)
>  safe_syscall6(int, pselect6, int, nfds, fd_set *, readfds, fd_set *, writefds, \
>                fd_set *, exceptfds, struct timespec *, timeout, void *, sig)
> +#endif
> +#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_poll)
>  safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
>                struct timespec *, tsp, const sigset_t *, sigmask,
>                size_t, sigsetsize)
> +#endif
>  safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, events,
>                int, maxevents, int, timeout, const sigset_t *, sigmask,
>                size_t, sigsetsize)
> +#ifdef TARGET_NR_futex
>  safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
>                const struct timespec *,timeout,int *,uaddr2,int,val3)
> +#endif
>  safe_syscall2(int, rt_sigsuspend, sigset_t *, newset, size_t, sigsetsize)
>  safe_syscall2(int, kill, pid_t, pid, int, sig)
>  safe_syscall2(int, tkill, int, tid, int, sig)
> @@ -776,12 +785,16 @@ safe_syscall6(ssize_t, recvfrom, int, fd, void *, buf, size_t, len,
>  safe_syscall3(ssize_t, sendmsg, int, fd, const struct msghdr *, msg, int, flags)
>  safe_syscall3(ssize_t, recvmsg, int, fd, struct msghdr *, msg, int, flags)
>  safe_syscall2(int, flock, int, fd, int, operation)
> +#ifdef TARGET_NR_rt_sigtimedwait
>  safe_syscall4(int, rt_sigtimedwait, const sigset_t *, these, siginfo_t *, uinfo,
>                const struct timespec *, uts, size_t, sigsetsize)
> +#endif
>  safe_syscall4(int, accept4, int, fd, struct sockaddr *, addr, socklen_t *, len,
>                int, flags)
> +#if defined(TARGET_NR_nanosleep)
>  safe_syscall2(int, nanosleep, const struct timespec *, req,
>                struct timespec *, rem)
> +#endif
>  #ifdef TARGET_NR_clock_nanosleep
>  safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
>                const struct timespec *, req, struct timespec *, rem)
> @@ -802,9 +815,11 @@ safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
>  safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
>                unsigned, nsops, const struct timespec *, timeout)
>  #endif
> -#if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
> +#ifdef TARGET_NR_mq_timedsend
>  safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
>                size_t, len, unsigned, prio, const struct timespec *, timeout)
> +#endif
> +#ifdef TARGET_NR_mq_timedreceive
>  safe_syscall5(int, mq_timedreceive, int, mqdes, char *, msg_ptr,
>                size_t, len, unsigned *, prio, const struct timespec *, timeout)
>  #endif
> @@ -946,6 +961,8 @@ abi_long do_brk(abi_ulong new_brk)
>      return target_brk;
>  }
>  
> +#if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
> +    defined(TARGET_NR_pselect6)
>  static inline abi_long copy_from_user_fdset(fd_set *fds,
>                                              abi_ulong target_fds_addr,
>                                              int n)
> @@ -1021,6 +1038,7 @@ static inline abi_long copy_to_user_fdset(abi_ulong target_fds_addr,
>  
>      return 0;
>  }
> +#endif
>  
>  #if defined(__alpha__)
>  #define HOST_HZ 1024
> @@ -1067,6 +1085,7 @@ static inline abi_long host_to_target_rusage(abi_ulong target_addr,
>      return 0;
>  }
>  
> +#ifdef TARGET_NR_setrlimit
>  static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
>  {
>      abi_ulong target_rlim_swap;
> @@ -1082,7 +1101,9 @@ static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
>      
>      return result;
>  }
> +#endif
>  
> +#if defined(TARGET_NR_getrlimit) || defined(TARGET_NR_ugetrlimit)
>  static inline abi_ulong host_to_target_rlim(rlim_t rlim)
>  {
>      abi_ulong target_rlim_swap;
> @@ -1096,6 +1117,7 @@ static inline abi_ulong host_to_target_rlim(rlim_t rlim)
>      
>      return result;
>  }
> +#endif
>  
>  static inline int target_to_host_resource(int code)
>  {
> @@ -1186,6 +1208,12 @@ static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
>      return 0;
>  }
>  
> +#if defined(TARGET_NR_futex) || \
> +    defined(TARGET_NR_rt_sigtimedwait) || \
> +    defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6) || \
> +    defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || \
> +    defined(TARGET_NR_utimensat) || defined(TARGET_NR_mq_timedsend) || \
> +    defined(TARGET_NR_mq_timedreceive)
>  static inline abi_long target_to_host_timespec(struct timespec *host_ts,
>                                                 abi_ulong target_addr)
>  {
> @@ -1199,6 +1227,7 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
>      unlock_user_struct(target_ts, target_addr, 0);
>      return 0;
>  }
> +#endif
>  
>  static inline abi_long host_to_target_timespec(abi_ulong target_addr,
>                                                 struct timespec *host_ts)
> @@ -1228,6 +1257,7 @@ static inline abi_long host_to_target_timespec64(abi_ulong target_addr,
>      return 0;
>  }
>  
> +#if defined(TARGET_NR_settimeofday)
>  static inline abi_long copy_from_user_timezone(struct timezone *tz,
>                                                 abi_ulong target_tz_addr)
>  {
> @@ -1244,6 +1274,7 @@ static inline abi_long copy_from_user_timezone(struct timezone *tz,
>  
>      return 0;
>  }
> +#endif
>  
>  #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
>  #include <mqueue.h>
> @@ -6565,6 +6596,8 @@ static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_timer_settime) || \
> +    (defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD))
>  static inline abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
>                                                   abi_ulong target_addr)
>  {
> @@ -6584,7 +6617,11 @@ static inline abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
>      unlock_user_struct(target_itspec, target_addr, 1);
>      return 0;
>  }
> +#endif
>  
> +#if ((defined(TARGET_NR_timerfd_gettime) || \
> +      defined(TARGET_NR_timerfd_settime)) && defined(CONFIG_TIMERFD)) || \
> +    defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
>  static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
>                                                 struct itimerspec *host_its)
>  {
> @@ -6603,7 +6640,10 @@ static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
>      unlock_user_struct(target_itspec, target_addr, 0);
>      return 0;
>  }
> +#endif
>  
> +#if defined(TARGET_NR_adjtimex) || \
> +    (defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME))
>  static inline abi_long target_to_host_timex(struct timex *host_tx,
>                                              abi_long target_addr)
>  {
> @@ -6673,7 +6713,7 @@ static inline abi_long host_to_target_timex(abi_long target_addr,
>      unlock_user_struct(target_tx, target_addr, 1);
>      return 0;
>  }
> -
> +#endif
>  
>  static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
>                                                 abi_ulong target_addr)
> @@ -6840,6 +6880,7 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
>     futexes locally would make futexes shared between multiple processes
>     tricky.  However they're probably useless because guest atomic
>     operations won't work either.  */
> +#if defined(TARGET_NR_futex)
>  static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
>                      target_ulong uaddr2, int val3)
>  {
> @@ -6886,6 +6927,7 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
>          return -TARGET_ENOSYS;
>      }
>  }
> +#endif
>  #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
>  static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
>                                       abi_long handle, abi_long mount_id,
> @@ -8494,6 +8536,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>          }
>          return ret;
> +#ifdef TARGET_NR_rt_sigtimedwait
>      case TARGET_NR_rt_sigtimedwait:
>          {
>              sigset_t set;
> @@ -8530,6 +8573,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>          }
>          return ret;
> +#endif
>      case TARGET_NR_rt_sigqueueinfo:
>          {
>              siginfo_t uinfo;
> @@ -8629,6 +8673,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>          }
>          return ret;
> +#if defined(TARGET_NR_gettimeofday)
>      case TARGET_NR_gettimeofday:
>          {
>              struct timeval tv;
> @@ -8639,6 +8684,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>          }
>          return ret;
> +#endif
> +#if defined(TARGET_NR_settimeofday)
>      case TARGET_NR_settimeofday:
>          {
>              struct timeval tv, *ptv = NULL;
> @@ -8660,6 +8707,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  
>              return get_errno(settimeofday(ptv, ptz));
>          }
> +#endif
>  #if defined(TARGET_NR_select)
>      case TARGET_NR_select:
>  #if defined(TARGET_WANT_NI_OLD_SELECT)
> @@ -9131,6 +9179,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>  #ifdef TARGET_NR_sendmmsg
>      case TARGET_NR_sendmmsg:
>          return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 1);
> +#endif
> +#ifdef TARGET_NR_recvmmsg
>      case TARGET_NR_recvmmsg:
>          return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0);
>  #endif
> @@ -9305,6 +9355,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
>                            arg6, arg7, arg8, 0);
>  #endif
> +#if defined(TARGET_NR_wait4)
>      case TARGET_NR_wait4:
>          {
>              int status;
> @@ -9332,6 +9383,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>          }
>          return ret;
> +#endif
>  #ifdef TARGET_NR_swapoff
>      case TARGET_NR_swapoff:
>          if (!(p = lock_user_string(arg1)))
> @@ -9476,6 +9528,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return do_vm86(cpu_env, arg1, arg2);
>  #endif
>  #endif
> +#if defined(TARGET_NR_adjtimex)
>      case TARGET_NR_adjtimex:
>          {
>              struct timex host_buf;
> @@ -9491,6 +9544,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>          }
>          return ret;
> +#endif
>  #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
>      case TARGET_NR_clock_adjtime:
>          {
> @@ -10007,6 +10061,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return get_errno(sched_get_priority_max(arg1));
>      case TARGET_NR_sched_get_priority_min:
>          return get_errno(sched_get_priority_min(arg1));
> +#ifdef TARGET_NR_sched_rr_get_interval
>      case TARGET_NR_sched_rr_get_interval:
>          {
>              struct timespec ts;
> @@ -10016,6 +10071,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>          }
>          return ret;
> +#endif
> +#if defined(TARGET_NR_nanosleep)
>      case TARGET_NR_nanosleep:
>          {
>              struct timespec req, rem;
> @@ -10026,6 +10083,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>          }
>          return ret;
> +#endif
>      case TARGET_NR_prctl:
>          switch (arg1) {
>          case PR_GET_PDEATHSIG:
> @@ -11496,8 +11554,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          }
>          return ret;
>  #endif
> +#ifdef TARGET_NR_futex
>      case TARGET_NR_futex:
>          return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
> +#endif
>  #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
>      case TARGET_NR_inotify_init:
>          ret = get_errno(sys_inotify_init());
> @@ -11562,6 +11622,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          unlock_user (p, arg1, 0);
>          return ret;
>  
> +#ifdef TARGET_NR_mq_timedsend
>      case TARGET_NR_mq_timedsend:
>          {
>              struct timespec ts;
> @@ -11577,7 +11638,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              unlock_user (p, arg2, arg3);
>          }
>          return ret;
> +#endif
>  
> +#ifdef TARGET_NR_mq_timedreceive
>      case TARGET_NR_mq_timedreceive:
>          {
>              struct timespec ts;
> @@ -11598,6 +11661,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>                  put_user_u32(prio, arg4);
>          }
>          return ret;
> +#endif
>  
>      /* Not implemented for now... */
>  /*     case TARGET_NR_mq_notify: */
> 

Applied to my linux-user branch.

Thanks,
Laurent

