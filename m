Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6944EC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AD72072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KBZJW+d9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AD72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9weE-0006Sr-D0
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=32645a587=alistair.francis@wdc.com>)
 id 1j9wbS-0002Sc-8c
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=32645a587=alistair.francis@wdc.com>)
 id 1j9wbQ-00085L-4x
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:56:18 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9551)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=32645a587=alistair.francis@wdc.com>)
 id 1j9wbP-00084P-6w; Thu, 05 Mar 2020 14:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583438175; x=1614974175;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vdVrDoGuUVUg6zjr31AFKizCaEe5SMyey3A1hVLUh5M=;
 b=KBZJW+d9m0I7vDIP6t87WSks5oRcX8WXNQfwvUYmq0Q+vKSXHJSBespA
 jhuAgPqux8DuVMvst6FTW2fyDdUXOmy19lHhTSTDrQRZ6RhczATa28GHZ
 wKAldd3xcWKSx7IkBl58OmT1/oGwVoQGGUL6O75GBPOFGUkJfu0vwqTek
 SaG+augFhBNYdmPfOFy0/ZiAVzwlq7NjrZVAWD7LqczdpoF9Jfcict34w
 U+ZgESllQem5SQie1xQsFB2R1nyy4VWejWuLecY8FaWih5rTso1vbud0O
 2OVheCBGqzUkc6K6uI8sy3w1VPAByRxm8Ik8oVzfhSkLAED/Zx+YdT2Jd A==;
IronPort-SDR: J3lSSilmNY4RGca2+rzD0h64FRYiMtmCPUMHqPQbhUDGGiA9W+m/DfNzVIsqcNFhDzyE9zel1h
 1BdCyTmDpPNCBBW0/h8C0fyNN5mwey4m/9FNi8Dzqi6Y/CV0ghTfApxKC3TpG5RgVSExTEGLS4
 iJ2XaNoSXBLbVKQJSdJU/VcHZTZBvta5aNvybeoPPdWaJG856b3cSlPS+bEjBgv0ylUxqVQ4oW
 JIJXCfNvXBynjLHzSGzbT/TFk+TLWz2qsiTPNXiD6dIpKrSBHxOsHMR8NCQ6dshG/yw6KbjkMU
 xKo=
X-IronPort-AV: E=Sophos;i="5.70,519,1574092800"; d="scan'208";a="132119759"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2020 03:56:13 +0800
IronPort-SDR: ioenvXkRJMqQBxPfoIsubLRBnO33azY/Eio+hvL0J8dM9+4jnjsQs0sRSVTSxebOVaXg9jMsZl
 mZVC4I3J9dcNAN/1VYRKil0bdcZ5yedN8t8zJlywrE9k5Ar3TxxOABrzSNewrWWU03Oqd6JEfr
 498aNHKyX6cczpSf8faR73xmS1APUWig8+HIq7sKPU5D4suqErE9zPZJ7amwOSmLqSh9R09cIi
 b1GOHWhwc6/o0UlJkPBm6025nyonVloxNgZ8oO5w8D4+HqfkxZx3DAkDmFy+kwrMn1BfvwMa+m
 y+n3nRMaNYVfEfLJ6m7prU7b
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 11:48:24 -0800
IronPort-SDR: ASi/DMiwlY2kcpXnEIn9pKXlM9BKWgUYQ4BksLtlK4ZqYiqOA7F8bxaNrcxmeqhqBMMlpZ+Pvw
 6Hshrpa+rL8quI4YpSARHCXadN6ybRv8PE26eXMUsYBxsHIWSCRLijRjMEooePI9SelQkWJX+J
 cDOKxO27kSfi758nb3zTZGLOOCfdE1hJ2fOSyawmObe9XjTHz4tga352s+KSK5H9jGq5PoZV4s
 i363DOGZPHcF6vJHka3BYA4U5X4CmffEKPrX2IFrJFHzG2OrrHo4v9e0c86ByE4St4yYh9+bfA
 Uvo=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 05 Mar 2020 11:56:13 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, aleksandar.m.mail@gmail.com,
 laurent@vivier.eu
Subject: [PATCH v5 1/3] linux-user: Protect more syscalls
Date: Thu,  5 Mar 2020 11:48:56 -0800
Message-Id: <72e025129270d09c899a48435908d52894587160.1583437651.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583437651.git.alistair.francis@wdc.com>
References: <cover.1583437651.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New y2038 safe 32-bit architectures (like RISC-V) don't support old
syscalls with a 32-bit time_t. The kernel defines new *_time64 versions
of these syscalls. Add some more #ifdefs to syscall.c in linux-user to
allow us to compile without these old syscalls.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/strace.c  |  2 ++
 linux-user/syscall.c | 77 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 4f7130b2ff..6420ccd97b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -775,6 +775,7 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
 #define TARGET_TIME_OOP      3   /* leap second in progress */
 #define TARGET_TIME_WAIT     4   /* leap second has occurred */
 #define TARGET_TIME_ERROR    5   /* clock not synchronized */
+#ifdef TARGET_NR_adjtimex
 static void
 print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
 {
@@ -813,6 +814,7 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
 
     qemu_log("\n");
 }
+#endif
 
 UNUSED static struct flags access_flags[] = {
     FLAG_GENERIC(F_OK),
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d27d10807..c000fb07c5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -245,7 +245,11 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #define __NR_sys_rt_sigqueueinfo __NR_rt_sigqueueinfo
 #define __NR_sys_rt_tgsigqueueinfo __NR_rt_tgsigqueueinfo
 #define __NR_sys_syslog __NR_syslog
-#define __NR_sys_futex __NR_futex
+#ifdef __NR_futex
+# define __NR_sys_futex __NR_futex
+#elif defined(__NR_futex_time64)
+# define __NR_sys_futex __NR_futex_time64
+#endif
 #define __NR_sys_inotify_init __NR_inotify_init
 #define __NR_sys_inotify_add_watch __NR_inotify_add_watch
 #define __NR_sys_inotify_rm_watch __NR_inotify_rm_watch
@@ -295,7 +299,9 @@ _syscall1(int,exit_group,int,error_code)
 #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
 _syscall1(int,set_tid_address,int *,tidptr)
 #endif
-#if defined(TARGET_NR_futex) && defined(__NR_futex)
+#if ((defined(TARGET_NR_futex) || defined(TARGET_NR_futex_time64)) && \
+         defined(__NR_futex)) || \
+    (defined(TARGET_NR_futex_time64) && defined(__NR_futex_time64))
 _syscall6(int,sys_futex,int *,uaddr,int,op,int,val,
           const struct timespec *,timeout,int *,uaddr2,int,val3)
 #endif
@@ -742,21 +748,30 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
 safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
 safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
               int, flags, mode_t, mode)
+#if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
 safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
               struct rusage *, rusage)
+#endif
 safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
               int, options, struct rusage *, rusage)
 safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)
+#if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
+    defined(TARGET_NR_pselect6)
 safe_syscall6(int, pselect6, int, nfds, fd_set *, readfds, fd_set *, writefds, \
               fd_set *, exceptfds, struct timespec *, timeout, void *, sig)
+#endif
+#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_poll)
 safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
               struct timespec *, tsp, const sigset_t *, sigmask,
               size_t, sigsetsize)
+#endif
 safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, events,
               int, maxevents, int, timeout, const sigset_t *, sigmask,
               size_t, sigsetsize)
+#ifdef TARGET_NR_futex
 safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
               const struct timespec *,timeout,int *,uaddr2,int,val3)
+#endif
 safe_syscall2(int, rt_sigsuspend, sigset_t *, newset, size_t, sigsetsize)
 safe_syscall2(int, kill, pid_t, pid, int, sig)
 safe_syscall2(int, tkill, int, tid, int, sig)
@@ -776,12 +791,16 @@ safe_syscall6(ssize_t, recvfrom, int, fd, void *, buf, size_t, len,
 safe_syscall3(ssize_t, sendmsg, int, fd, const struct msghdr *, msg, int, flags)
 safe_syscall3(ssize_t, recvmsg, int, fd, struct msghdr *, msg, int, flags)
 safe_syscall2(int, flock, int, fd, int, operation)
+#ifdef TARGET_NR_rt_sigtimedwait
 safe_syscall4(int, rt_sigtimedwait, const sigset_t *, these, siginfo_t *, uinfo,
               const struct timespec *, uts, size_t, sigsetsize)
+#endif
 safe_syscall4(int, accept4, int, fd, struct sockaddr *, addr, socklen_t *, len,
               int, flags)
+#if defined(TARGET_NR_nanosleep)
 safe_syscall2(int, nanosleep, const struct timespec *, req,
               struct timespec *, rem)
+#endif
 #ifdef TARGET_NR_clock_nanosleep
 safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
               const struct timespec *, req, struct timespec *, rem)
@@ -803,10 +822,14 @@ safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
               unsigned, nsops, const struct timespec *, timeout)
 #endif
 #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
+# ifdef TARGET_NR_mq_timedsend
 safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
               size_t, len, unsigned, prio, const struct timespec *, timeout)
+# endif
+# ifdef TARGET_NR_mq_timedreceive
 safe_syscall5(int, mq_timedreceive, int, mqdes, char *, msg_ptr,
               size_t, len, unsigned *, prio, const struct timespec *, timeout)
+# endif
 #endif
 /* We do ioctl like this rather than via safe_syscall3 to preserve the
  * "third argument might be integer or pointer or not present" behaviour of
@@ -946,6 +969,8 @@ abi_long do_brk(abi_ulong new_brk)
     return target_brk;
 }
 
+#if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
+    defined(TARGET_NR_pselect6)
 static inline abi_long copy_from_user_fdset(fd_set *fds,
                                             abi_ulong target_fds_addr,
                                             int n)
@@ -1021,6 +1046,7 @@ static inline abi_long copy_to_user_fdset(abi_ulong target_fds_addr,
 
     return 0;
 }
+#endif
 
 #if defined(__alpha__)
 #define HOST_HZ 1024
@@ -1067,6 +1093,7 @@ static inline abi_long host_to_target_rusage(abi_ulong target_addr,
     return 0;
 }
 
+#ifdef TARGET_NR_setrlimit
 static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
 {
     abi_ulong target_rlim_swap;
@@ -1082,7 +1109,9 @@ static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
     
     return result;
 }
+#endif
 
+#if defined(TARGET_NR_getrlimit) || defined(TARGET_NR_ugetrlimit)
 static inline abi_ulong host_to_target_rlim(rlim_t rlim)
 {
     abi_ulong target_rlim_swap;
@@ -1096,6 +1125,7 @@ static inline abi_ulong host_to_target_rlim(rlim_t rlim)
     
     return result;
 }
+#endif
 
 static inline int target_to_host_resource(int code)
 {
@@ -1186,6 +1216,11 @@ static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
     return 0;
 }
 
+#if defined(TARGET_NR_futex) || defined(TARGET_NR_rt_sigtimedwait) || \
+    defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6) || \
+    defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || \
+    defined(TARGET_NR_utimensat) || defined(TARGET_NR_mq_timedsend) || \
+    defined(TARGET_NR_mq_timedreceive)
 static inline abi_long target_to_host_timespec(struct timespec *host_ts,
                                                abi_ulong target_addr)
 {
@@ -1199,6 +1234,7 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
     unlock_user_struct(target_ts, target_addr, 0);
     return 0;
 }
+#endif
 
 static inline abi_long host_to_target_timespec(abi_ulong target_addr,
                                                struct timespec *host_ts)
@@ -1228,6 +1264,7 @@ static inline abi_long host_to_target_timespec64(abi_ulong target_addr,
     return 0;
 }
 
+#if defined(TARGET_NR_settimeofday)
 static inline abi_long copy_from_user_timezone(struct timezone *tz,
                                                abi_ulong target_tz_addr)
 {
@@ -1244,6 +1281,7 @@ static inline abi_long copy_from_user_timezone(struct timezone *tz,
 
     return 0;
 }
+#endif
 
 #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
 #include <mqueue.h>
@@ -6565,6 +6603,8 @@ static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
 }
 #endif
 
+#if defined(TARGET_NR_timer_settime) || \
+    (defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD))
 static inline abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
                                                  abi_ulong target_addr)
 {
@@ -6584,7 +6624,11 @@ static inline abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
     unlock_user_struct(target_itspec, target_addr, 1);
     return 0;
 }
+#endif
 
+#if ((defined(TARGET_NR_timerfd_gettime) || \
+      defined(TARGET_NR_timerfd_settime)) && defined(CONFIG_TIMERFD)) || \
+    defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
 static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
                                                struct itimerspec *host_its)
 {
@@ -6603,7 +6647,10 @@ static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
     unlock_user_struct(target_itspec, target_addr, 0);
     return 0;
 }
+#endif
 
+#if defined(TARGET_NR_adjtimex) || \
+    (defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME))
 static inline abi_long target_to_host_timex(struct timex *host_tx,
                                             abi_long target_addr)
 {
@@ -6673,7 +6720,7 @@ static inline abi_long host_to_target_timex(abi_long target_addr,
     unlock_user_struct(target_tx, target_addr, 1);
     return 0;
 }
-
+#endif
 
 static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
                                                abi_ulong target_addr)
@@ -6840,6 +6887,7 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
    futexes locally would make futexes shared between multiple processes
    tricky.  However they're probably useless because guest atomic
    operations won't work either.  */
+#ifdef TARGET_NR_futex
 static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
                     target_ulong uaddr2, int val3)
 {
@@ -6886,6 +6934,7 @@ static int do_futex(target_ulong uaddr, int op, int val, target_ulong timeout,
         return -TARGET_ENOSYS;
     }
 }
+#endif
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
 static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
                                      abi_long handle, abi_long mount_id,
@@ -8494,6 +8543,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#ifdef TARGET_NR_rt_sigtimedwait
     case TARGET_NR_rt_sigtimedwait:
         {
             sigset_t set;
@@ -8530,6 +8580,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
     case TARGET_NR_rt_sigqueueinfo:
         {
             siginfo_t uinfo;
@@ -8629,6 +8680,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#if defined(TARGET_NR_gettimeofday)
     case TARGET_NR_gettimeofday:
         {
             struct timeval tv;
@@ -8639,6 +8691,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
+#if defined(TARGET_NR_settimeofday)
     case TARGET_NR_settimeofday:
         {
             struct timeval tv, *ptv = NULL;
@@ -8660,6 +8714,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             return get_errno(settimeofday(ptv, ptz));
         }
+#endif
 #if defined(TARGET_NR_select)
     case TARGET_NR_select:
 #if defined(TARGET_WANT_NI_OLD_SELECT)
@@ -9131,6 +9186,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #ifdef TARGET_NR_sendmmsg
     case TARGET_NR_sendmmsg:
         return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 1);
+#endif
+#ifdef TARGET_NR_recvmmsg
     case TARGET_NR_recvmmsg:
         return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0);
 #endif
@@ -9305,6 +9362,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg5,
                           arg6, arg7, arg8, 0);
 #endif
+#if defined(TARGET_NR_wait4)
     case TARGET_NR_wait4:
         {
             int status;
@@ -9332,6 +9390,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
 #ifdef TARGET_NR_swapoff
     case TARGET_NR_swapoff:
         if (!(p = lock_user_string(arg1)))
@@ -9476,6 +9535,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return do_vm86(cpu_env, arg1, arg2);
 #endif
 #endif
+#if defined(TARGET_NR_adjtimex)
     case TARGET_NR_adjtimex:
         {
             struct timex host_buf;
@@ -9491,6 +9551,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
 #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
     case TARGET_NR_clock_adjtime:
         {
@@ -10007,6 +10068,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return get_errno(sched_get_priority_max(arg1));
     case TARGET_NR_sched_get_priority_min:
         return get_errno(sched_get_priority_min(arg1));
+#ifdef TARGET_NR_sched_rr_get_interval
     case TARGET_NR_sched_rr_get_interval:
         {
             struct timespec ts;
@@ -10016,6 +10078,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
+#if defined(TARGET_NR_nanosleep)
     case TARGET_NR_nanosleep:
         {
             struct timespec req, rem;
@@ -10026,6 +10090,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
+#endif
     case TARGET_NR_prctl:
         switch (arg1) {
         case PR_GET_PDEATHSIG:
@@ -11496,8 +11561,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         }
         return ret;
 #endif
+#ifdef TARGET_NR_futex
     case TARGET_NR_futex:
         return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
+#endif
 #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
     case TARGET_NR_inotify_init:
         ret = get_errno(sys_inotify_init());
@@ -11562,6 +11629,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         unlock_user (p, arg1, 0);
         return ret;
 
+#ifdef TARGET_NR_mq_timedsend
     case TARGET_NR_mq_timedsend:
         {
             struct timespec ts;
@@ -11577,7 +11645,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user (p, arg2, arg3);
         }
         return ret;
+#endif
 
+#ifdef TARGET_NR_mq_timedreceive
     case TARGET_NR_mq_timedreceive:
         {
             struct timespec ts;
@@ -11598,6 +11668,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 put_user_u32(prio, arg4);
         }
         return ret;
+#endif
 
     /* Not implemented for now... */
 /*     case TARGET_NR_mq_notify: */
-- 
2.25.1


