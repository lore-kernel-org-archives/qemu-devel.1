Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2B6C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EDD2070A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EDD2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJfA-0004Nu-Qj
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJWE-0006cy-Qz
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJWA-0008I6-UX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:06 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37797)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJWA-0008FW-Gy
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:02 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MTREY-1ipvPh21AC-00TojG; Fri, 20 Mar 2020 16:24:58 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 27/32] linux-user,mips: move content of mips_syscall_args
Date: Fri, 20 Mar 2020 16:24:03 +0100
Message-Id: <20200320152408.182899-28-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8YZQ23G3Xtlc2qipOftnD+wNEanZBiWTHY7chiYKvZCRCsDDalW
 pSebm8rPDnY9KLSpn/yoTV1L9kb9KSHZfXgX151IJOWEqx8ZQh4SgFQDBN+rB9uANuNnIO4
 LviE7nxjmpAV/afvkaq1UPNKebkmoZ2i5zf2nkK/DahzWPmkbI1JWDEaMduEbVEtmtYw4rE
 kO2pFkV5/opU5ksoZox4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bwIYOnUEBMw=:QWNEBsdNHsemQTwJ4SUNwm
 gKhc8fdKmLZuKllQQazzkaUr+qZKAEoex/rc/qx7/+W5lOtgYqMMMXIBdij2XZQGWQ+uv7mWi
 z9nsHXmcodqjidHNNzmQna+b/mw+KCCvp9yd/AxkQDMwMpLE/BvPR+ESojZErk0Y7zGnPRG7v
 ejTP1ySoP4jCjHIWsrgyMGIUEAh1UMS8rWkfTDxK3ed9rRQb90Xv9r9LTrrB5V2NeA2P5Z1xx
 KjYf+3TXNjlfw1n9vSbfGKiMSTyzxfV8+DBVTKuQx/Ueka8N9BLTkmHceJh1VguPTydcecDqO
 IPM8vAB7SNKp9+0yEKBKvSzFH1cc06Abt75wMGYVx0JuzNAOBcZlajHvXN7NC0Jqqp2vNsBon
 s1Pyjx/Gy88cx65UFXxyjd/WKccHEkm9OFyeQrUp3tMPUikIxUDMW88qEmpZNtEE0/pIeNKrS
 9su1Y7m7ZROr2YhUrX1XiZltUQ32gnfVbK8e5sgTeRHM4pzzxhFXoSf4U85exi9lB/Uc0C2Zm
 y1mWsMY1AsgcbxXp9sRktFndbw4MRXKvvJ43t1ucIhTgr4kOXVBi07usJ/Zgt+huFd5J/2GK1
 CkS49NknVdWakoLmhNsUCJrtJzMYIsZrWgxsweWTZHj3vkO/4Q/ik4nzkwR0LDd4f1O0FlS+b
 JbC2AGAQg3lgLEjvtbYO8gonSjVqdKStzEtKDLXBx/Rnl/jjVO3tqTlRcTLuGDDxuQFxSIu5T
 JhdLRHa9S5X9QMii9F5CgdXUQ3rtwthBmmBpZwyDdhHa523pp+St8EE8b2YT3Mx5/MW+b7qxR
 ZGYr0gox3y0ypfy88qO3Y/Wcg1sqcbjkH+kRz0DfcpLcmcHpT4gowG22g2vHPQr0wsyTejX
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move content of mips_syscall_args to mips-syscall-args-o32.c.inc to
ease automatic update. No functionnal change

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-21-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/cpu_loop.c             | 440 +------------------------
 linux-user/mips/syscall-args-o32.c.inc | 438 ++++++++++++++++++++++++
 2 files changed, 439 insertions(+), 439 deletions(-)
 create mode 100644 linux-user/mips/syscall-args-o32.c.inc

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 396367d81d8d..553e8ca7f576 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -26,447 +26,9 @@
 
 # ifdef TARGET_ABI_MIPSO32
 #  define MIPS_SYSCALL_NUMBER_UNUSED -1
-#  define MIPS_SYS(name, args) args,
 static const int8_t mips_syscall_args[] = {
-        MIPS_SYS(sys_syscall    , 8)    /* 4000 */
-        MIPS_SYS(sys_exit       , 1)
-        MIPS_SYS(sys_fork       , 0)
-        MIPS_SYS(sys_read       , 3)
-        MIPS_SYS(sys_write      , 3)
-        MIPS_SYS(sys_open       , 3)    /* 4005 */
-        MIPS_SYS(sys_close      , 1)
-        MIPS_SYS(sys_waitpid    , 3)
-        MIPS_SYS(sys_creat      , 2)
-        MIPS_SYS(sys_link       , 2)
-        MIPS_SYS(sys_unlink     , 1)    /* 4010 */
-        MIPS_SYS(sys_execve     , 0)
-        MIPS_SYS(sys_chdir      , 1)
-        MIPS_SYS(sys_time       , 1)
-        MIPS_SYS(sys_mknod      , 3)
-        MIPS_SYS(sys_chmod      , 2)    /* 4015 */
-        MIPS_SYS(sys_lchown     , 3)
-        MIPS_SYS(sys_ni_syscall , 0)
-        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_stat */
-        MIPS_SYS(sys_lseek      , 3)
-        MIPS_SYS(sys_getpid     , 0)    /* 4020 */
-        MIPS_SYS(sys_mount      , 5)
-        MIPS_SYS(sys_umount     , 1)
-        MIPS_SYS(sys_setuid     , 1)
-        MIPS_SYS(sys_getuid     , 0)
-        MIPS_SYS(sys_stime      , 1)    /* 4025 */
-        MIPS_SYS(sys_ptrace     , 4)
-        MIPS_SYS(sys_alarm      , 1)
-        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_fstat */
-        MIPS_SYS(sys_pause      , 0)
-        MIPS_SYS(sys_utime      , 2)    /* 4030 */
-        MIPS_SYS(sys_ni_syscall , 0)
-        MIPS_SYS(sys_ni_syscall , 0)
-        MIPS_SYS(sys_access     , 2)
-        MIPS_SYS(sys_nice       , 1)
-        MIPS_SYS(sys_ni_syscall , 0)    /* 4035 */
-        MIPS_SYS(sys_sync       , 0)
-        MIPS_SYS(sys_kill       , 2)
-        MIPS_SYS(sys_rename     , 2)
-        MIPS_SYS(sys_mkdir      , 2)
-        MIPS_SYS(sys_rmdir      , 1)    /* 4040 */
-        MIPS_SYS(sys_dup                , 1)
-        MIPS_SYS(sys_pipe       , 0)
-        MIPS_SYS(sys_times      , 1)
-        MIPS_SYS(sys_ni_syscall , 0)
-        MIPS_SYS(sys_brk                , 1)    /* 4045 */
-        MIPS_SYS(sys_setgid     , 1)
-        MIPS_SYS(sys_getgid     , 0)
-        MIPS_SYS(sys_ni_syscall , 0)    /* was signal(2) */
-        MIPS_SYS(sys_geteuid    , 0)
-        MIPS_SYS(sys_getegid    , 0)    /* 4050 */
-        MIPS_SYS(sys_acct       , 0)
-        MIPS_SYS(sys_umount2    , 2)
-        MIPS_SYS(sys_ni_syscall , 0)
-        MIPS_SYS(sys_ioctl      , 3)
-        MIPS_SYS(sys_fcntl      , 3)    /* 4055 */
-        MIPS_SYS(sys_ni_syscall , 2)
-        MIPS_SYS(sys_setpgid    , 2)
-        MIPS_SYS(sys_ni_syscall , 0)
-        MIPS_SYS(sys_olduname   , 1)
-        MIPS_SYS(sys_umask      , 1)    /* 4060 */
-        MIPS_SYS(sys_chroot     , 1)
-        MIPS_SYS(sys_ustat      , 2)
-        MIPS_SYS(sys_dup2       , 2)
-        MIPS_SYS(sys_getppid    , 0)
-        MIPS_SYS(sys_getpgrp    , 0)    /* 4065 */
-        MIPS_SYS(sys_setsid     , 0)
-        MIPS_SYS(sys_sigaction  , 3)
-        MIPS_SYS(sys_sgetmask   , 0)
-        MIPS_SYS(sys_ssetmask   , 1)
-        MIPS_SYS(sys_setreuid   , 2)    /* 4070 */
-        MIPS_SYS(sys_setregid   , 2)
-        MIPS_SYS(sys_sigsuspend , 0)
-        MIPS_SYS(sys_sigpending , 1)
-        MIPS_SYS(sys_sethostname        , 2)
-        MIPS_SYS(sys_setrlimit  , 2)    /* 4075 */
-        MIPS_SYS(sys_getrlimit  , 2)
-        MIPS_SYS(sys_getrusage  , 2)
-        MIPS_SYS(sys_gettimeofday, 2)
-        MIPS_SYS(sys_settimeofday, 2)
-        MIPS_SYS(sys_getgroups  , 2)    /* 4080 */
-        MIPS_SYS(sys_setgroups  , 2)
-        MIPS_SYS(sys_ni_syscall , 0)    /* old_select */
-        MIPS_SYS(sys_symlink    , 2)
-        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_lstat */
-        MIPS_SYS(sys_readlink   , 3)    /* 4085 */
-        MIPS_SYS(sys_uselib     , 1)
-        MIPS_SYS(sys_swapon     , 2)
-        MIPS_SYS(sys_reboot     , 3)
-        MIPS_SYS(old_readdir    , 3)
-        MIPS_SYS(old_mmap       , 6)    /* 4090 */
-        MIPS_SYS(sys_munmap     , 2)
-        MIPS_SYS(sys_truncate   , 2)
-        MIPS_SYS(sys_ftruncate  , 2)
-        MIPS_SYS(sys_fchmod     , 2)
-        MIPS_SYS(sys_fchown     , 3)    /* 4095 */
-        MIPS_SYS(sys_getpriority        , 2)
-        MIPS_SYS(sys_setpriority        , 3)
-        MIPS_SYS(sys_ni_syscall , 0)
-        MIPS_SYS(sys_statfs     , 2)
-        MIPS_SYS(sys_fstatfs    , 2)    /* 4100 */
-        MIPS_SYS(sys_ni_syscall , 0)    /* was ioperm(2) */
-        MIPS_SYS(sys_socketcall , 2)
-        MIPS_SYS(sys_syslog     , 3)
-        MIPS_SYS(sys_setitimer  , 3)
-        MIPS_SYS(sys_getitimer  , 2)    /* 4105 */
-        MIPS_SYS(sys_newstat    , 2)
-        MIPS_SYS(sys_newlstat   , 2)
-        MIPS_SYS(sys_newfstat   , 2)
-        MIPS_SYS(sys_uname      , 1)
-        MIPS_SYS(sys_ni_syscall , 0)    /* 4110 was iopl(2) */
-        MIPS_SYS(sys_vhangup    , 0)
-        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_idle() */
-        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_vm86 */
-        MIPS_SYS(sys_wait4      , 4)
-        MIPS_SYS(sys_swapoff    , 1)    /* 4115 */
-        MIPS_SYS(sys_sysinfo    , 1)
-        MIPS_SYS(sys_ipc                , 6)
-        MIPS_SYS(sys_fsync      , 1)
-        MIPS_SYS(sys_sigreturn  , 0)
-        MIPS_SYS(sys_clone      , 6)    /* 4120 */
-        MIPS_SYS(sys_setdomainname, 2)
-        MIPS_SYS(sys_newuname   , 1)
-        MIPS_SYS(sys_ni_syscall , 0)    /* sys_modify_ldt */
-        MIPS_SYS(sys_adjtimex   , 1)
-        MIPS_SYS(sys_mprotect   , 3)    /* 4125 */
-        MIPS_SYS(sys_sigprocmask        , 3)
-        MIPS_SYS(sys_ni_syscall , 0)    /* was create_module */
-        MIPS_SYS(sys_init_module        , 5)
-        MIPS_SYS(sys_delete_module, 1)
-        MIPS_SYS(sys_ni_syscall , 0)    /* 4130 was get_kernel_syms */
-        MIPS_SYS(sys_quotactl   , 0)
-        MIPS_SYS(sys_getpgid    , 1)
-        MIPS_SYS(sys_fchdir     , 1)
-        MIPS_SYS(sys_bdflush    , 2)
-        MIPS_SYS(sys_sysfs      , 3)    /* 4135 */
-        MIPS_SYS(sys_personality        , 1)
-        MIPS_SYS(sys_ni_syscall , 0)    /* for afs_syscall */
-        MIPS_SYS(sys_setfsuid   , 1)
-        MIPS_SYS(sys_setfsgid   , 1)
-        MIPS_SYS(sys_llseek     , 5)    /* 4140 */
-        MIPS_SYS(sys_getdents   , 3)
-        MIPS_SYS(sys_select     , 5)
-        MIPS_SYS(sys_flock      , 2)
-        MIPS_SYS(sys_msync      , 3)
-        MIPS_SYS(sys_readv      , 3)    /* 4145 */
-        MIPS_SYS(sys_writev     , 3)
-        MIPS_SYS(sys_cacheflush , 3)
-        MIPS_SYS(sys_cachectl   , 3)
-        MIPS_SYS(sys_sysmips    , 4)
-        MIPS_SYS(sys_ni_syscall , 0)    /* 4150 */
-        MIPS_SYS(sys_getsid     , 1)
-        MIPS_SYS(sys_fdatasync  , 0)
-        MIPS_SYS(sys_sysctl     , 1)
-        MIPS_SYS(sys_mlock      , 2)
-        MIPS_SYS(sys_munlock    , 2)    /* 4155 */
-        MIPS_SYS(sys_mlockall   , 1)
-        MIPS_SYS(sys_munlockall , 0)
-        MIPS_SYS(sys_sched_setparam, 2)
-        MIPS_SYS(sys_sched_getparam, 2)
-        MIPS_SYS(sys_sched_setscheduler, 3)     /* 4160 */
-        MIPS_SYS(sys_sched_getscheduler, 1)
-        MIPS_SYS(sys_sched_yield        , 0)
-        MIPS_SYS(sys_sched_get_priority_max, 1)
-        MIPS_SYS(sys_sched_get_priority_min, 1)
-        MIPS_SYS(sys_sched_rr_get_interval, 2)  /* 4165 */
-        MIPS_SYS(sys_nanosleep, 2)
-        MIPS_SYS(sys_mremap     , 5)
-        MIPS_SYS(sys_accept     , 3)
-        MIPS_SYS(sys_bind       , 3)
-        MIPS_SYS(sys_connect    , 3)    /* 4170 */
-        MIPS_SYS(sys_getpeername        , 3)
-        MIPS_SYS(sys_getsockname        , 3)
-        MIPS_SYS(sys_getsockopt , 5)
-        MIPS_SYS(sys_listen     , 2)
-        MIPS_SYS(sys_recv       , 4)    /* 4175 */
-        MIPS_SYS(sys_recvfrom   , 6)
-        MIPS_SYS(sys_recvmsg    , 3)
-        MIPS_SYS(sys_send       , 4)
-        MIPS_SYS(sys_sendmsg    , 3)
-        MIPS_SYS(sys_sendto     , 6)    /* 4180 */
-        MIPS_SYS(sys_setsockopt , 5)
-        MIPS_SYS(sys_shutdown   , 2)
-        MIPS_SYS(sys_socket     , 3)
-        MIPS_SYS(sys_socketpair , 4)
-        MIPS_SYS(sys_setresuid  , 3)    /* 4185 */
-        MIPS_SYS(sys_getresuid  , 3)
-        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_query_module */
-        MIPS_SYS(sys_poll       , 3)
-        MIPS_SYS(sys_nfsservctl , 3)
-        MIPS_SYS(sys_setresgid  , 3)    /* 4190 */
-        MIPS_SYS(sys_getresgid  , 3)
-        MIPS_SYS(sys_prctl      , 5)
-        MIPS_SYS(sys_rt_sigreturn, 0)
-        MIPS_SYS(sys_rt_sigaction, 4)
-        MIPS_SYS(sys_rt_sigprocmask, 4) /* 4195 */
-        MIPS_SYS(sys_rt_sigpending, 2)
-        MIPS_SYS(sys_rt_sigtimedwait, 4)
-        MIPS_SYS(sys_rt_sigqueueinfo, 3)
-        MIPS_SYS(sys_rt_sigsuspend, 0)
-        MIPS_SYS(sys_pread64    , 6)    /* 4200 */
-        MIPS_SYS(sys_pwrite64   , 6)
-        MIPS_SYS(sys_chown      , 3)
-        MIPS_SYS(sys_getcwd     , 2)
-        MIPS_SYS(sys_capget     , 2)
-        MIPS_SYS(sys_capset     , 2)    /* 4205 */
-        MIPS_SYS(sys_sigaltstack        , 2)
-        MIPS_SYS(sys_sendfile   , 4)
-        MIPS_SYS(sys_ni_syscall , 0)
-        MIPS_SYS(sys_ni_syscall , 0)
-        MIPS_SYS(sys_mmap2      , 6)    /* 4210 */
-        MIPS_SYS(sys_truncate64 , 4)
-        MIPS_SYS(sys_ftruncate64        , 4)
-        MIPS_SYS(sys_stat64     , 2)
-        MIPS_SYS(sys_lstat64    , 2)
-        MIPS_SYS(sys_fstat64    , 2)    /* 4215 */
-        MIPS_SYS(sys_pivot_root , 2)
-        MIPS_SYS(sys_mincore    , 3)
-        MIPS_SYS(sys_madvise    , 3)
-        MIPS_SYS(sys_getdents64 , 3)
-        MIPS_SYS(sys_fcntl64    , 3)    /* 4220 */
-        MIPS_SYS(sys_ni_syscall , 0)
-        MIPS_SYS(sys_gettid     , 0)
-        MIPS_SYS(sys_readahead  , 5)
-        MIPS_SYS(sys_setxattr   , 5)
-        MIPS_SYS(sys_lsetxattr  , 5)    /* 4225 */
-        MIPS_SYS(sys_fsetxattr  , 5)
-        MIPS_SYS(sys_getxattr   , 4)
-        MIPS_SYS(sys_lgetxattr  , 4)
-        MIPS_SYS(sys_fgetxattr  , 4)
-        MIPS_SYS(sys_listxattr  , 3)    /* 4230 */
-        MIPS_SYS(sys_llistxattr , 3)
-        MIPS_SYS(sys_flistxattr , 3)
-        MIPS_SYS(sys_removexattr        , 2)
-        MIPS_SYS(sys_lremovexattr, 2)
-        MIPS_SYS(sys_fremovexattr, 2)   /* 4235 */
-        MIPS_SYS(sys_tkill      , 2)
-        MIPS_SYS(sys_sendfile64 , 5)
-        MIPS_SYS(sys_futex      , 6)
-        MIPS_SYS(sys_sched_setaffinity, 3)
-        MIPS_SYS(sys_sched_getaffinity, 3)      /* 4240 */
-        MIPS_SYS(sys_io_setup   , 2)
-        MIPS_SYS(sys_io_destroy , 1)
-        MIPS_SYS(sys_io_getevents, 5)
-        MIPS_SYS(sys_io_submit  , 3)
-        MIPS_SYS(sys_io_cancel  , 3)    /* 4245 */
-        MIPS_SYS(sys_exit_group , 1)
-        MIPS_SYS(sys_lookup_dcookie, 3)
-        MIPS_SYS(sys_epoll_create, 1)
-        MIPS_SYS(sys_epoll_ctl  , 4)
-        MIPS_SYS(sys_epoll_wait , 3)    /* 4250 */
-        MIPS_SYS(sys_remap_file_pages, 5)
-        MIPS_SYS(sys_set_tid_address, 1)
-        MIPS_SYS(sys_restart_syscall, 0)
-        MIPS_SYS(sys_fadvise64_64, 7)
-        MIPS_SYS(sys_statfs64   , 3)    /* 4255 */
-        MIPS_SYS(sys_fstatfs64  , 2)
-        MIPS_SYS(sys_timer_create, 3)
-        MIPS_SYS(sys_timer_settime, 4)
-        MIPS_SYS(sys_timer_gettime, 2)
-        MIPS_SYS(sys_timer_getoverrun, 1)       /* 4260 */
-        MIPS_SYS(sys_timer_delete, 1)
-        MIPS_SYS(sys_clock_settime, 2)
-        MIPS_SYS(sys_clock_gettime, 2)
-        MIPS_SYS(sys_clock_getres, 2)
-        MIPS_SYS(sys_clock_nanosleep, 4)        /* 4265 */
-        MIPS_SYS(sys_tgkill     , 3)
-        MIPS_SYS(sys_utimes     , 2)
-        MIPS_SYS(sys_mbind      , 4)
-        MIPS_SYS(sys_ni_syscall , 0)    /* sys_get_mempolicy */
-        MIPS_SYS(sys_ni_syscall , 0)    /* 4270 sys_set_mempolicy */
-        MIPS_SYS(sys_mq_open    , 4)
-        MIPS_SYS(sys_mq_unlink  , 1)
-        MIPS_SYS(sys_mq_timedsend, 5)
-        MIPS_SYS(sys_mq_timedreceive, 5)
-        MIPS_SYS(sys_mq_notify  , 2)    /* 4275 */
-        MIPS_SYS(sys_mq_getsetattr, 3)
-        MIPS_SYS(sys_ni_syscall , 0)    /* sys_vserver */
-        MIPS_SYS(sys_waitid     , 4)
-        MIPS_SYS(sys_ni_syscall , 0)    /* available, was setaltroot */
-        MIPS_SYS(sys_add_key    , 5)
-        MIPS_SYS(sys_request_key, 4)
-        MIPS_SYS(sys_keyctl     , 5)
-        MIPS_SYS(sys_set_thread_area, 1)
-        MIPS_SYS(sys_inotify_init, 0)
-        MIPS_SYS(sys_inotify_add_watch, 3) /* 4285 */
-        MIPS_SYS(sys_inotify_rm_watch, 2)
-        MIPS_SYS(sys_migrate_pages, 4)
-        MIPS_SYS(sys_openat, 4)
-        MIPS_SYS(sys_mkdirat, 3)
-        MIPS_SYS(sys_mknodat, 4)        /* 4290 */
-        MIPS_SYS(sys_fchownat, 5)
-        MIPS_SYS(sys_futimesat, 3)
-        MIPS_SYS(sys_fstatat64, 4)
-        MIPS_SYS(sys_unlinkat, 3)
-        MIPS_SYS(sys_renameat, 4)       /* 4295 */
-        MIPS_SYS(sys_linkat, 5)
-        MIPS_SYS(sys_symlinkat, 3)
-        MIPS_SYS(sys_readlinkat, 4)
-        MIPS_SYS(sys_fchmodat, 3)
-        MIPS_SYS(sys_faccessat, 3)      /* 4300 */
-        MIPS_SYS(sys_pselect6, 6)
-        MIPS_SYS(sys_ppoll, 5)
-        MIPS_SYS(sys_unshare, 1)
-        MIPS_SYS(sys_splice, 6)
-        MIPS_SYS(sys_sync_file_range, 7) /* 4305 */
-        MIPS_SYS(sys_tee, 4)
-        MIPS_SYS(sys_vmsplice, 4)
-        MIPS_SYS(sys_move_pages, 6)
-        MIPS_SYS(sys_set_robust_list, 2)
-        MIPS_SYS(sys_get_robust_list, 3) /* 4310 */
-        MIPS_SYS(sys_kexec_load, 4)
-        MIPS_SYS(sys_getcpu, 3)
-        MIPS_SYS(sys_epoll_pwait, 6)
-        MIPS_SYS(sys_ioprio_set, 3)
-        MIPS_SYS(sys_ioprio_get, 2)
-        MIPS_SYS(sys_utimensat, 4)
-        MIPS_SYS(sys_signalfd, 3)
-        MIPS_SYS(sys_ni_syscall, 0)     /* was timerfd */
-        MIPS_SYS(sys_eventfd, 1)
-        MIPS_SYS(sys_fallocate, 6)      /* 4320 */
-        MIPS_SYS(sys_timerfd_create, 2)
-        MIPS_SYS(sys_timerfd_gettime, 2)
-        MIPS_SYS(sys_timerfd_settime, 4)
-        MIPS_SYS(sys_signalfd4, 4)
-        MIPS_SYS(sys_eventfd2, 2)       /* 4325 */
-        MIPS_SYS(sys_epoll_create1, 1)
-        MIPS_SYS(sys_dup3, 3)
-        MIPS_SYS(sys_pipe2, 2)
-        MIPS_SYS(sys_inotify_init1, 1)
-        MIPS_SYS(sys_preadv, 5)         /* 4330 */
-        MIPS_SYS(sys_pwritev, 5)
-        MIPS_SYS(sys_rt_tgsigqueueinfo, 4)
-        MIPS_SYS(sys_perf_event_open, 5)
-        MIPS_SYS(sys_accept4, 4)
-        MIPS_SYS(sys_recvmmsg, 5)       /* 4335 */
-        MIPS_SYS(sys_fanotify_init, 2)
-        MIPS_SYS(sys_fanotify_mark, 6)
-        MIPS_SYS(sys_prlimit64, 4)
-        MIPS_SYS(sys_name_to_handle_at, 5)
-        MIPS_SYS(sys_open_by_handle_at, 3) /* 4340 */
-        MIPS_SYS(sys_clock_adjtime, 2)
-        MIPS_SYS(sys_syncfs, 1)
-        MIPS_SYS(sys_sendmmsg, 4)
-        MIPS_SYS(sys_setns, 2)
-        MIPS_SYS(sys_process_vm_readv, 6) /* 345 */
-        MIPS_SYS(sys_process_vm_writev, 6)
-        MIPS_SYS(sys_kcmp, 5)
-        MIPS_SYS(sys_finit_module, 3)
-        MIPS_SYS(sys_sched_setattr, 2)
-        MIPS_SYS(sys_sched_getattr, 3)  /* 350 */
-        MIPS_SYS(sys_renameat2, 5)
-        MIPS_SYS(sys_seccomp, 3)
-        MIPS_SYS(sys_getrandom, 3)
-        MIPS_SYS(sys_memfd_create, 2)
-        MIPS_SYS(sys_bpf, 3)            /* 355 */
-        MIPS_SYS(sys_execveat, 5)
-        MIPS_SYS(sys_userfaultfd, 1)
-        MIPS_SYS(sys_membarrier, 2)
-        MIPS_SYS(sys_mlock2, 3)
-        MIPS_SYS(sys_copy_file_range, 6) /* 360 */
-        MIPS_SYS(sys_preadv2, 6)
-        MIPS_SYS(sys_pwritev2, 6)
-        MIPS_SYS(sys_pkey_mprotect, 4)
-        MIPS_SYS(sys_pkey_alloc, 2)
-        MIPS_SYS(sys_pkey_free, 1)                 /* 365 */
-        MIPS_SYS(sys_statx, 5)
-        MIPS_SYS(sys_rseq, 4)
-        MIPS_SYS(sys_io_pgetevents, 6)
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,                /* 370 */
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,                /* 375 */
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,                /* 380 */
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,                /* 385 */
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,                /* 390 */
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYSCALL_NUMBER_UNUSED,
-        MIPS_SYS(sys_semget, 3)
-        MIPS_SYS(sys_semctl, 4)
-        MIPS_SYS(sys_shmget, 3)                    /* 395 */
-        MIPS_SYS(sys_shmctl, 3)
-        MIPS_SYS(sys_shmat, 3)
-        MIPS_SYS(sys_shmdt, 1)
-        MIPS_SYS(sys_msgget, 2)
-        MIPS_SYS(sys_msgsnd, 4)                    /* 400 */
-        MIPS_SYS(sys_msgrcv, 5)
-        MIPS_SYS(sys_msgctl, 3)
-        MIPS_SYS(sys_clock_gettime64, 2)
-        MIPS_SYS(sys_clock_settime64, 2)
-        MIPS_SYS(sys_clock_adjtime64, 2)           /* 405 */
-        MIPS_SYS(sys_clock_getres_time64, 2)
-        MIPS_SYS(sys_clock_nanosleep_time64, 4)
-        MIPS_SYS(sys_timer_gettime64, 2)
-        MIPS_SYS(sys_timer_settime64, 4)
-        MIPS_SYS(sys_timerfd_gettime64, 2)         /* 410 */
-        MIPS_SYS(sys_timerfd_settime64, 4)
-        MIPS_SYS(sys_utimensat_time64, 4)
-        MIPS_SYS(sys_pselect6_time64, 6)
-        MIPS_SYS(sys_ppoll_time64, 5)
-        MIPS_SYSCALL_NUMBER_UNUSED,                /* 415 */
-        MIPS_SYS(sys_io_pgetevents_time64, 6)
-        MIPS_SYS(sys_recvmmsg_time64, 5)
-        MIPS_SYS(sys_mq_timedsend_time64, 5)
-        MIPS_SYS(sys_mq_timedreceive_time64, 5)
-        MIPS_SYS(sys_semtimedop_time64, 4)         /* 420 */
-        MIPS_SYS(sys_rt_sigtimedwait_time64, 4)
-        MIPS_SYS(sys_futex_time64, 6)
-        MIPS_SYS(sys_sched_rr_get_interval_time64, 2)
-        MIPS_SYS(sys_pidfd_send_signal, 4)
-        MIPS_SYS(sys_io_uring_setup, 2)            /* 425 */
-        MIPS_SYS(sys_io_uring_enter, 6)
-        MIPS_SYS(sys_io_uring_register, 4)
-        MIPS_SYS(sys_open_tree, 3)
-        MIPS_SYS(sys_move_mount, 5)
-        MIPS_SYS(sys_fsopen, 2)                    /* 430 */
-        MIPS_SYS(sys_fsconfig, 5)
-        MIPS_SYS(sys_fsmount, 3)
-        MIPS_SYS(sys_fspick, 3)
-        MIPS_SYS(sys_pidfd_open, 2)
-        MIPS_SYS(sys_clone3, 2)                    /* 435 */
-
+#include "syscall-args-o32.c.inc"
 };
-#  undef MIPS_SYS
 # endif /* O32 */
 
 /* Break codes */
diff --git a/linux-user/mips/syscall-args-o32.c.inc b/linux-user/mips/syscall-args-o32.c.inc
new file mode 100644
index 000000000000..f060b061441a
--- /dev/null
+++ b/linux-user/mips/syscall-args-o32.c.inc
@@ -0,0 +1,438 @@
+#  define MIPS_SYS(name, args) args,
+        MIPS_SYS(sys_syscall    , 8)    /* 4000 */
+        MIPS_SYS(sys_exit       , 1)
+        MIPS_SYS(sys_fork       , 0)
+        MIPS_SYS(sys_read       , 3)
+        MIPS_SYS(sys_write      , 3)
+        MIPS_SYS(sys_open       , 3)    /* 4005 */
+        MIPS_SYS(sys_close      , 1)
+        MIPS_SYS(sys_waitpid    , 3)
+        MIPS_SYS(sys_creat      , 2)
+        MIPS_SYS(sys_link       , 2)
+        MIPS_SYS(sys_unlink     , 1)    /* 4010 */
+        MIPS_SYS(sys_execve     , 0)
+        MIPS_SYS(sys_chdir      , 1)
+        MIPS_SYS(sys_time       , 1)
+        MIPS_SYS(sys_mknod      , 3)
+        MIPS_SYS(sys_chmod      , 2)    /* 4015 */
+        MIPS_SYS(sys_lchown     , 3)
+        MIPS_SYS(sys_ni_syscall , 0)
+        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_stat */
+        MIPS_SYS(sys_lseek      , 3)
+        MIPS_SYS(sys_getpid     , 0)    /* 4020 */
+        MIPS_SYS(sys_mount      , 5)
+        MIPS_SYS(sys_umount     , 1)
+        MIPS_SYS(sys_setuid     , 1)
+        MIPS_SYS(sys_getuid     , 0)
+        MIPS_SYS(sys_stime      , 1)    /* 4025 */
+        MIPS_SYS(sys_ptrace     , 4)
+        MIPS_SYS(sys_alarm      , 1)
+        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_fstat */
+        MIPS_SYS(sys_pause      , 0)
+        MIPS_SYS(sys_utime      , 2)    /* 4030 */
+        MIPS_SYS(sys_ni_syscall , 0)
+        MIPS_SYS(sys_ni_syscall , 0)
+        MIPS_SYS(sys_access     , 2)
+        MIPS_SYS(sys_nice       , 1)
+        MIPS_SYS(sys_ni_syscall , 0)    /* 4035 */
+        MIPS_SYS(sys_sync       , 0)
+        MIPS_SYS(sys_kill       , 2)
+        MIPS_SYS(sys_rename     , 2)
+        MIPS_SYS(sys_mkdir      , 2)
+        MIPS_SYS(sys_rmdir      , 1)    /* 4040 */
+        MIPS_SYS(sys_dup                , 1)
+        MIPS_SYS(sys_pipe       , 0)
+        MIPS_SYS(sys_times      , 1)
+        MIPS_SYS(sys_ni_syscall , 0)
+        MIPS_SYS(sys_brk                , 1)    /* 4045 */
+        MIPS_SYS(sys_setgid     , 1)
+        MIPS_SYS(sys_getgid     , 0)
+        MIPS_SYS(sys_ni_syscall , 0)    /* was signal(2) */
+        MIPS_SYS(sys_geteuid    , 0)
+        MIPS_SYS(sys_getegid    , 0)    /* 4050 */
+        MIPS_SYS(sys_acct       , 0)
+        MIPS_SYS(sys_umount2    , 2)
+        MIPS_SYS(sys_ni_syscall , 0)
+        MIPS_SYS(sys_ioctl      , 3)
+        MIPS_SYS(sys_fcntl      , 3)    /* 4055 */
+        MIPS_SYS(sys_ni_syscall , 2)
+        MIPS_SYS(sys_setpgid    , 2)
+        MIPS_SYS(sys_ni_syscall , 0)
+        MIPS_SYS(sys_olduname   , 1)
+        MIPS_SYS(sys_umask      , 1)    /* 4060 */
+        MIPS_SYS(sys_chroot     , 1)
+        MIPS_SYS(sys_ustat      , 2)
+        MIPS_SYS(sys_dup2       , 2)
+        MIPS_SYS(sys_getppid    , 0)
+        MIPS_SYS(sys_getpgrp    , 0)    /* 4065 */
+        MIPS_SYS(sys_setsid     , 0)
+        MIPS_SYS(sys_sigaction  , 3)
+        MIPS_SYS(sys_sgetmask   , 0)
+        MIPS_SYS(sys_ssetmask   , 1)
+        MIPS_SYS(sys_setreuid   , 2)    /* 4070 */
+        MIPS_SYS(sys_setregid   , 2)
+        MIPS_SYS(sys_sigsuspend , 0)
+        MIPS_SYS(sys_sigpending , 1)
+        MIPS_SYS(sys_sethostname        , 2)
+        MIPS_SYS(sys_setrlimit  , 2)    /* 4075 */
+        MIPS_SYS(sys_getrlimit  , 2)
+        MIPS_SYS(sys_getrusage  , 2)
+        MIPS_SYS(sys_gettimeofday, 2)
+        MIPS_SYS(sys_settimeofday, 2)
+        MIPS_SYS(sys_getgroups  , 2)    /* 4080 */
+        MIPS_SYS(sys_setgroups  , 2)
+        MIPS_SYS(sys_ni_syscall , 0)    /* old_select */
+        MIPS_SYS(sys_symlink    , 2)
+        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_lstat */
+        MIPS_SYS(sys_readlink   , 3)    /* 4085 */
+        MIPS_SYS(sys_uselib     , 1)
+        MIPS_SYS(sys_swapon     , 2)
+        MIPS_SYS(sys_reboot     , 3)
+        MIPS_SYS(old_readdir    , 3)
+        MIPS_SYS(old_mmap       , 6)    /* 4090 */
+        MIPS_SYS(sys_munmap     , 2)
+        MIPS_SYS(sys_truncate   , 2)
+        MIPS_SYS(sys_ftruncate  , 2)
+        MIPS_SYS(sys_fchmod     , 2)
+        MIPS_SYS(sys_fchown     , 3)    /* 4095 */
+        MIPS_SYS(sys_getpriority        , 2)
+        MIPS_SYS(sys_setpriority        , 3)
+        MIPS_SYS(sys_ni_syscall , 0)
+        MIPS_SYS(sys_statfs     , 2)
+        MIPS_SYS(sys_fstatfs    , 2)    /* 4100 */
+        MIPS_SYS(sys_ni_syscall , 0)    /* was ioperm(2) */
+        MIPS_SYS(sys_socketcall , 2)
+        MIPS_SYS(sys_syslog     , 3)
+        MIPS_SYS(sys_setitimer  , 3)
+        MIPS_SYS(sys_getitimer  , 2)    /* 4105 */
+        MIPS_SYS(sys_newstat    , 2)
+        MIPS_SYS(sys_newlstat   , 2)
+        MIPS_SYS(sys_newfstat   , 2)
+        MIPS_SYS(sys_uname      , 1)
+        MIPS_SYS(sys_ni_syscall , 0)    /* 4110 was iopl(2) */
+        MIPS_SYS(sys_vhangup    , 0)
+        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_idle() */
+        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_vm86 */
+        MIPS_SYS(sys_wait4      , 4)
+        MIPS_SYS(sys_swapoff    , 1)    /* 4115 */
+        MIPS_SYS(sys_sysinfo    , 1)
+        MIPS_SYS(sys_ipc                , 6)
+        MIPS_SYS(sys_fsync      , 1)
+        MIPS_SYS(sys_sigreturn  , 0)
+        MIPS_SYS(sys_clone      , 6)    /* 4120 */
+        MIPS_SYS(sys_setdomainname, 2)
+        MIPS_SYS(sys_newuname   , 1)
+        MIPS_SYS(sys_ni_syscall , 0)    /* sys_modify_ldt */
+        MIPS_SYS(sys_adjtimex   , 1)
+        MIPS_SYS(sys_mprotect   , 3)    /* 4125 */
+        MIPS_SYS(sys_sigprocmask        , 3)
+        MIPS_SYS(sys_ni_syscall , 0)    /* was create_module */
+        MIPS_SYS(sys_init_module        , 5)
+        MIPS_SYS(sys_delete_module, 1)
+        MIPS_SYS(sys_ni_syscall , 0)    /* 4130 was get_kernel_syms */
+        MIPS_SYS(sys_quotactl   , 0)
+        MIPS_SYS(sys_getpgid    , 1)
+        MIPS_SYS(sys_fchdir     , 1)
+        MIPS_SYS(sys_bdflush    , 2)
+        MIPS_SYS(sys_sysfs      , 3)    /* 4135 */
+        MIPS_SYS(sys_personality        , 1)
+        MIPS_SYS(sys_ni_syscall , 0)    /* for afs_syscall */
+        MIPS_SYS(sys_setfsuid   , 1)
+        MIPS_SYS(sys_setfsgid   , 1)
+        MIPS_SYS(sys_llseek     , 5)    /* 4140 */
+        MIPS_SYS(sys_getdents   , 3)
+        MIPS_SYS(sys_select     , 5)
+        MIPS_SYS(sys_flock      , 2)
+        MIPS_SYS(sys_msync      , 3)
+        MIPS_SYS(sys_readv      , 3)    /* 4145 */
+        MIPS_SYS(sys_writev     , 3)
+        MIPS_SYS(sys_cacheflush , 3)
+        MIPS_SYS(sys_cachectl   , 3)
+        MIPS_SYS(sys_sysmips    , 4)
+        MIPS_SYS(sys_ni_syscall , 0)    /* 4150 */
+        MIPS_SYS(sys_getsid     , 1)
+        MIPS_SYS(sys_fdatasync  , 0)
+        MIPS_SYS(sys_sysctl     , 1)
+        MIPS_SYS(sys_mlock      , 2)
+        MIPS_SYS(sys_munlock    , 2)    /* 4155 */
+        MIPS_SYS(sys_mlockall   , 1)
+        MIPS_SYS(sys_munlockall , 0)
+        MIPS_SYS(sys_sched_setparam, 2)
+        MIPS_SYS(sys_sched_getparam, 2)
+        MIPS_SYS(sys_sched_setscheduler, 3)     /* 4160 */
+        MIPS_SYS(sys_sched_getscheduler, 1)
+        MIPS_SYS(sys_sched_yield        , 0)
+        MIPS_SYS(sys_sched_get_priority_max, 1)
+        MIPS_SYS(sys_sched_get_priority_min, 1)
+        MIPS_SYS(sys_sched_rr_get_interval, 2)  /* 4165 */
+        MIPS_SYS(sys_nanosleep, 2)
+        MIPS_SYS(sys_mremap     , 5)
+        MIPS_SYS(sys_accept     , 3)
+        MIPS_SYS(sys_bind       , 3)
+        MIPS_SYS(sys_connect    , 3)    /* 4170 */
+        MIPS_SYS(sys_getpeername        , 3)
+        MIPS_SYS(sys_getsockname        , 3)
+        MIPS_SYS(sys_getsockopt , 5)
+        MIPS_SYS(sys_listen     , 2)
+        MIPS_SYS(sys_recv       , 4)    /* 4175 */
+        MIPS_SYS(sys_recvfrom   , 6)
+        MIPS_SYS(sys_recvmsg    , 3)
+        MIPS_SYS(sys_send       , 4)
+        MIPS_SYS(sys_sendmsg    , 3)
+        MIPS_SYS(sys_sendto     , 6)    /* 4180 */
+        MIPS_SYS(sys_setsockopt , 5)
+        MIPS_SYS(sys_shutdown   , 2)
+        MIPS_SYS(sys_socket     , 3)
+        MIPS_SYS(sys_socketpair , 4)
+        MIPS_SYS(sys_setresuid  , 3)    /* 4185 */
+        MIPS_SYS(sys_getresuid  , 3)
+        MIPS_SYS(sys_ni_syscall , 0)    /* was sys_query_module */
+        MIPS_SYS(sys_poll       , 3)
+        MIPS_SYS(sys_nfsservctl , 3)
+        MIPS_SYS(sys_setresgid  , 3)    /* 4190 */
+        MIPS_SYS(sys_getresgid  , 3)
+        MIPS_SYS(sys_prctl      , 5)
+        MIPS_SYS(sys_rt_sigreturn, 0)
+        MIPS_SYS(sys_rt_sigaction, 4)
+        MIPS_SYS(sys_rt_sigprocmask, 4) /* 4195 */
+        MIPS_SYS(sys_rt_sigpending, 2)
+        MIPS_SYS(sys_rt_sigtimedwait, 4)
+        MIPS_SYS(sys_rt_sigqueueinfo, 3)
+        MIPS_SYS(sys_rt_sigsuspend, 0)
+        MIPS_SYS(sys_pread64    , 6)    /* 4200 */
+        MIPS_SYS(sys_pwrite64   , 6)
+        MIPS_SYS(sys_chown      , 3)
+        MIPS_SYS(sys_getcwd     , 2)
+        MIPS_SYS(sys_capget     , 2)
+        MIPS_SYS(sys_capset     , 2)    /* 4205 */
+        MIPS_SYS(sys_sigaltstack        , 2)
+        MIPS_SYS(sys_sendfile   , 4)
+        MIPS_SYS(sys_ni_syscall , 0)
+        MIPS_SYS(sys_ni_syscall , 0)
+        MIPS_SYS(sys_mmap2      , 6)    /* 4210 */
+        MIPS_SYS(sys_truncate64 , 4)
+        MIPS_SYS(sys_ftruncate64        , 4)
+        MIPS_SYS(sys_stat64     , 2)
+        MIPS_SYS(sys_lstat64    , 2)
+        MIPS_SYS(sys_fstat64    , 2)    /* 4215 */
+        MIPS_SYS(sys_pivot_root , 2)
+        MIPS_SYS(sys_mincore    , 3)
+        MIPS_SYS(sys_madvise    , 3)
+        MIPS_SYS(sys_getdents64 , 3)
+        MIPS_SYS(sys_fcntl64    , 3)    /* 4220 */
+        MIPS_SYS(sys_ni_syscall , 0)
+        MIPS_SYS(sys_gettid     , 0)
+        MIPS_SYS(sys_readahead  , 5)
+        MIPS_SYS(sys_setxattr   , 5)
+        MIPS_SYS(sys_lsetxattr  , 5)    /* 4225 */
+        MIPS_SYS(sys_fsetxattr  , 5)
+        MIPS_SYS(sys_getxattr   , 4)
+        MIPS_SYS(sys_lgetxattr  , 4)
+        MIPS_SYS(sys_fgetxattr  , 4)
+        MIPS_SYS(sys_listxattr  , 3)    /* 4230 */
+        MIPS_SYS(sys_llistxattr , 3)
+        MIPS_SYS(sys_flistxattr , 3)
+        MIPS_SYS(sys_removexattr        , 2)
+        MIPS_SYS(sys_lremovexattr, 2)
+        MIPS_SYS(sys_fremovexattr, 2)   /* 4235 */
+        MIPS_SYS(sys_tkill      , 2)
+        MIPS_SYS(sys_sendfile64 , 5)
+        MIPS_SYS(sys_futex      , 6)
+        MIPS_SYS(sys_sched_setaffinity, 3)
+        MIPS_SYS(sys_sched_getaffinity, 3)      /* 4240 */
+        MIPS_SYS(sys_io_setup   , 2)
+        MIPS_SYS(sys_io_destroy , 1)
+        MIPS_SYS(sys_io_getevents, 5)
+        MIPS_SYS(sys_io_submit  , 3)
+        MIPS_SYS(sys_io_cancel  , 3)    /* 4245 */
+        MIPS_SYS(sys_exit_group , 1)
+        MIPS_SYS(sys_lookup_dcookie, 3)
+        MIPS_SYS(sys_epoll_create, 1)
+        MIPS_SYS(sys_epoll_ctl  , 4)
+        MIPS_SYS(sys_epoll_wait , 3)    /* 4250 */
+        MIPS_SYS(sys_remap_file_pages, 5)
+        MIPS_SYS(sys_set_tid_address, 1)
+        MIPS_SYS(sys_restart_syscall, 0)
+        MIPS_SYS(sys_fadvise64_64, 7)
+        MIPS_SYS(sys_statfs64   , 3)    /* 4255 */
+        MIPS_SYS(sys_fstatfs64  , 2)
+        MIPS_SYS(sys_timer_create, 3)
+        MIPS_SYS(sys_timer_settime, 4)
+        MIPS_SYS(sys_timer_gettime, 2)
+        MIPS_SYS(sys_timer_getoverrun, 1)       /* 4260 */
+        MIPS_SYS(sys_timer_delete, 1)
+        MIPS_SYS(sys_clock_settime, 2)
+        MIPS_SYS(sys_clock_gettime, 2)
+        MIPS_SYS(sys_clock_getres, 2)
+        MIPS_SYS(sys_clock_nanosleep, 4)        /* 4265 */
+        MIPS_SYS(sys_tgkill     , 3)
+        MIPS_SYS(sys_utimes     , 2)
+        MIPS_SYS(sys_mbind      , 4)
+        MIPS_SYS(sys_ni_syscall , 0)    /* sys_get_mempolicy */
+        MIPS_SYS(sys_ni_syscall , 0)    /* 4270 sys_set_mempolicy */
+        MIPS_SYS(sys_mq_open    , 4)
+        MIPS_SYS(sys_mq_unlink  , 1)
+        MIPS_SYS(sys_mq_timedsend, 5)
+        MIPS_SYS(sys_mq_timedreceive, 5)
+        MIPS_SYS(sys_mq_notify  , 2)    /* 4275 */
+        MIPS_SYS(sys_mq_getsetattr, 3)
+        MIPS_SYS(sys_ni_syscall , 0)    /* sys_vserver */
+        MIPS_SYS(sys_waitid     , 4)
+        MIPS_SYS(sys_ni_syscall , 0)    /* available, was setaltroot */
+        MIPS_SYS(sys_add_key    , 5)
+        MIPS_SYS(sys_request_key, 4)
+        MIPS_SYS(sys_keyctl     , 5)
+        MIPS_SYS(sys_set_thread_area, 1)
+        MIPS_SYS(sys_inotify_init, 0)
+        MIPS_SYS(sys_inotify_add_watch, 3) /* 4285 */
+        MIPS_SYS(sys_inotify_rm_watch, 2)
+        MIPS_SYS(sys_migrate_pages, 4)
+        MIPS_SYS(sys_openat, 4)
+        MIPS_SYS(sys_mkdirat, 3)
+        MIPS_SYS(sys_mknodat, 4)        /* 4290 */
+        MIPS_SYS(sys_fchownat, 5)
+        MIPS_SYS(sys_futimesat, 3)
+        MIPS_SYS(sys_fstatat64, 4)
+        MIPS_SYS(sys_unlinkat, 3)
+        MIPS_SYS(sys_renameat, 4)       /* 4295 */
+        MIPS_SYS(sys_linkat, 5)
+        MIPS_SYS(sys_symlinkat, 3)
+        MIPS_SYS(sys_readlinkat, 4)
+        MIPS_SYS(sys_fchmodat, 3)
+        MIPS_SYS(sys_faccessat, 3)      /* 4300 */
+        MIPS_SYS(sys_pselect6, 6)
+        MIPS_SYS(sys_ppoll, 5)
+        MIPS_SYS(sys_unshare, 1)
+        MIPS_SYS(sys_splice, 6)
+        MIPS_SYS(sys_sync_file_range, 7) /* 4305 */
+        MIPS_SYS(sys_tee, 4)
+        MIPS_SYS(sys_vmsplice, 4)
+        MIPS_SYS(sys_move_pages, 6)
+        MIPS_SYS(sys_set_robust_list, 2)
+        MIPS_SYS(sys_get_robust_list, 3) /* 4310 */
+        MIPS_SYS(sys_kexec_load, 4)
+        MIPS_SYS(sys_getcpu, 3)
+        MIPS_SYS(sys_epoll_pwait, 6)
+        MIPS_SYS(sys_ioprio_set, 3)
+        MIPS_SYS(sys_ioprio_get, 2)
+        MIPS_SYS(sys_utimensat, 4)
+        MIPS_SYS(sys_signalfd, 3)
+        MIPS_SYS(sys_ni_syscall, 0)     /* was timerfd */
+        MIPS_SYS(sys_eventfd, 1)
+        MIPS_SYS(sys_fallocate, 6)      /* 4320 */
+        MIPS_SYS(sys_timerfd_create, 2)
+        MIPS_SYS(sys_timerfd_gettime, 2)
+        MIPS_SYS(sys_timerfd_settime, 4)
+        MIPS_SYS(sys_signalfd4, 4)
+        MIPS_SYS(sys_eventfd2, 2)       /* 4325 */
+        MIPS_SYS(sys_epoll_create1, 1)
+        MIPS_SYS(sys_dup3, 3)
+        MIPS_SYS(sys_pipe2, 2)
+        MIPS_SYS(sys_inotify_init1, 1)
+        MIPS_SYS(sys_preadv, 5)         /* 4330 */
+        MIPS_SYS(sys_pwritev, 5)
+        MIPS_SYS(sys_rt_tgsigqueueinfo, 4)
+        MIPS_SYS(sys_perf_event_open, 5)
+        MIPS_SYS(sys_accept4, 4)
+        MIPS_SYS(sys_recvmmsg, 5)       /* 4335 */
+        MIPS_SYS(sys_fanotify_init, 2)
+        MIPS_SYS(sys_fanotify_mark, 6)
+        MIPS_SYS(sys_prlimit64, 4)
+        MIPS_SYS(sys_name_to_handle_at, 5)
+        MIPS_SYS(sys_open_by_handle_at, 3) /* 4340 */
+        MIPS_SYS(sys_clock_adjtime, 2)
+        MIPS_SYS(sys_syncfs, 1)
+        MIPS_SYS(sys_sendmmsg, 4)
+        MIPS_SYS(sys_setns, 2)
+        MIPS_SYS(sys_process_vm_readv, 6) /* 345 */
+        MIPS_SYS(sys_process_vm_writev, 6)
+        MIPS_SYS(sys_kcmp, 5)
+        MIPS_SYS(sys_finit_module, 3)
+        MIPS_SYS(sys_sched_setattr, 2)
+        MIPS_SYS(sys_sched_getattr, 3)  /* 350 */
+        MIPS_SYS(sys_renameat2, 5)
+        MIPS_SYS(sys_seccomp, 3)
+        MIPS_SYS(sys_getrandom, 3)
+        MIPS_SYS(sys_memfd_create, 2)
+        MIPS_SYS(sys_bpf, 3)            /* 355 */
+        MIPS_SYS(sys_execveat, 5)
+        MIPS_SYS(sys_userfaultfd, 1)
+        MIPS_SYS(sys_membarrier, 2)
+        MIPS_SYS(sys_mlock2, 3)
+        MIPS_SYS(sys_copy_file_range, 6) /* 360 */
+        MIPS_SYS(sys_preadv2, 6)
+        MIPS_SYS(sys_pwritev2, 6)
+        MIPS_SYS(sys_pkey_mprotect, 4)
+        MIPS_SYS(sys_pkey_alloc, 2)
+        MIPS_SYS(sys_pkey_free, 1)                 /* 365 */
+        MIPS_SYS(sys_statx, 5)
+        MIPS_SYS(sys_rseq, 4)
+        MIPS_SYS(sys_io_pgetevents, 6)
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,                /* 370 */
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,                /* 375 */
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,                /* 380 */
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,                /* 385 */
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,                /* 390 */
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYS(sys_semget, 3)
+        MIPS_SYS(sys_semctl, 4)
+        MIPS_SYS(sys_shmget, 3)                    /* 395 */
+        MIPS_SYS(sys_shmctl, 3)
+        MIPS_SYS(sys_shmat, 3)
+        MIPS_SYS(sys_shmdt, 1)
+        MIPS_SYS(sys_msgget, 2)
+        MIPS_SYS(sys_msgsnd, 4)                    /* 400 */
+        MIPS_SYS(sys_msgrcv, 5)
+        MIPS_SYS(sys_msgctl, 3)
+        MIPS_SYS(sys_clock_gettime64, 2)
+        MIPS_SYS(sys_clock_settime64, 2)
+        MIPS_SYS(sys_clock_adjtime64, 2)           /* 405 */
+        MIPS_SYS(sys_clock_getres_time64, 2)
+        MIPS_SYS(sys_clock_nanosleep_time64, 4)
+        MIPS_SYS(sys_timer_gettime64, 2)
+        MIPS_SYS(sys_timer_settime64, 4)
+        MIPS_SYS(sys_timerfd_gettime64, 2)         /* 410 */
+        MIPS_SYS(sys_timerfd_settime64, 4)
+        MIPS_SYS(sys_utimensat_time64, 4)
+        MIPS_SYS(sys_pselect6_time64, 6)
+        MIPS_SYS(sys_ppoll_time64, 5)
+        MIPS_SYSCALL_NUMBER_UNUSED,                /* 415 */
+        MIPS_SYS(sys_io_pgetevents_time64, 6)
+        MIPS_SYS(sys_recvmmsg_time64, 5)
+        MIPS_SYS(sys_mq_timedsend_time64, 5)
+        MIPS_SYS(sys_mq_timedreceive_time64, 5)
+        MIPS_SYS(sys_semtimedop_time64, 4)         /* 420 */
+        MIPS_SYS(sys_rt_sigtimedwait_time64, 4)
+        MIPS_SYS(sys_futex_time64, 6)
+        MIPS_SYS(sys_sched_rr_get_interval_time64, 2)
+        MIPS_SYS(sys_pidfd_send_signal, 4)
+        MIPS_SYS(sys_io_uring_setup, 2)            /* 425 */
+        MIPS_SYS(sys_io_uring_enter, 6)
+        MIPS_SYS(sys_io_uring_register, 4)
+        MIPS_SYS(sys_open_tree, 3)
+        MIPS_SYS(sys_move_mount, 5)
+        MIPS_SYS(sys_fsopen, 2)                    /* 430 */
+        MIPS_SYS(sys_fsconfig, 5)
+        MIPS_SYS(sys_fsmount, 3)
+        MIPS_SYS(sys_fspick, 3)
+        MIPS_SYS(sys_pidfd_open, 2)
+        MIPS_SYS(sys_clone3, 2)                    /* 435 */
+#  undef MIPS_SYS
-- 
2.25.1


