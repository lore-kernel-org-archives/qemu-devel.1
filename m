Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E017C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA5320735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA5320735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEvE-0007Mz-W9
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEW3-0005rq-1q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEVy-0000ym-CP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:26 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43669)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEVx-0000sy-Us
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:22 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MoNyA-1jcFeS2uj2-00oogu; Tue, 17 Mar 2020 16:52:17 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 33/37] linux-user,mips: update syscall-args-o32.c.inc
Date: Tue, 17 Mar 2020 16:51:12 +0100
Message-Id: <20200317155116.1227513-34-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SqvIeCONWST0cU7H3MHLUYK80e7IHihYrnFOURkZxBbwXHBJJFS
 r4aRwOhNyXqt7d0Gox+228aRM9JSNXz6LSUg/3zL2rUs25U0yh/y5dH5JpOzFmV5USijiE4
 VP5xK+6AFYOe0MakdzfMy31qpZSZvELH5Y8Hb7/kssXfFbGYYPVcMPbGt/DZBG8IyPw2jqD
 /J9Vm/KSgEZ2UudQXvcfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GgkrAccRpe8=:gXr4xtMBwzWqbphb91b99P
 /u5LS2T4Mm9b+MEobqcfMZFI9QLyMGK0u6PfVlNWJUa7MKpMuV3Mzin9xxKRUY0XKh9+CBxxq
 hI60BMGGIC5eZQqPFJXSBXO4V+EHAyrQBQ5cKbhlpxnLVRL9SQBF2k3b1iJmIFoe9TQLR3siH
 Cw00jFvIfs5O6m1V7Q7Cl85aFDiHDw2xTFcZcZmbQ7KD+kGZtyoTXIXIRtn9LdXnYrX4lvysI
 H5Y9qRD6hUqKuyCUXB0jdANZKxCFSD2lTSKMl6zsizZKro1LRwLPGKBBnkLacmnrasi4+nvQT
 sKuu4mfZ5k9LkOleRMqjyhdKWEapiB+uHwLXkR3H8Dc4X0b/KnV1T0zG1ULavsZ2dKWjQFQuh
 7icXbIgNDuzrys+eMAfAVFeIlhTULxMa5t8JHh0E0XYIQhdclrkkiMC0g9vHuusokr5Xake4A
 ZQalWb98N+pdHH882rzMRcP83Sa9L8kTkvCe2Pn6oW1aXNHXL/enD36CoADhkZO4q4USvMMYv
 cnPWIEtBWzaxqu4XgS/gBWRQAHPtotSr+KJgq/tgU+WPnj1nb4MEjoK2/uHY9qRFVduFVwXvv
 vOS+3xwa5n6Q98wTOX9EqEQ1QtywVLFshK8c4aaNwj0OWqmjkTSQd+l1iaijLHFy6JcKfb01s
 8VxhQpnkwRoq6pO7fz9AhURhY3m8O1bIe097vifZFQJX3H4ChpuH7Dpc9UMvRzk0L7C7iP1te
 ESrF/Mj1O+QfZed5AFI8ghW5kUfCbGDBTF3Cr3dYOmg28Ls2139WBP62dNElDYeFUfipgL8qU
 EBJ6eMY+IkQo7NjZ5BD2Cm3aWPR6ML+Hi60oQa0TAALJBrzbSL4p/BFyv5TWI0jyieng6Ue
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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

Add a script to update the file from strace github and run it

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-22-laurent@vivier.eu>
[lv: added file in MAINTAINERS]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                            |   1 +
 linux-user/mips/syscall-args-o32.c.inc | 874 ++++++++++++-------------
 scripts/update-mips-syscall-args.sh    |  57 ++
 3 files changed, 494 insertions(+), 438 deletions(-)
 create mode 100755 scripts/update-mips-syscall-args.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 709832758e51..958e05b27f15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2449,6 +2449,7 @@ F: linux-user/
 F: default-configs/*-linux-user.mak
 F: scripts/qemu-binfmt-conf.sh
 F: scripts/update-syscalltbl.sh
+F: scripts/update-mips-syscall-args.sh
 
 Tiny Code Generator (TCG)
 -------------------------
diff --git a/linux-user/mips/syscall-args-o32.c.inc b/linux-user/mips/syscall-args-o32.c.inc
index f060b061441a..0ad35857b4e4 100644
--- a/linux-user/mips/syscall-args-o32.c.inc
+++ b/linux-user/mips/syscall-args-o32.c.inc
@@ -1,438 +1,436 @@
-#  define MIPS_SYS(name, args) args,
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
-#  undef MIPS_SYS
+    [   0] = 7, /* syscall */
+    [   1] = 1, /* exit */
+    [   2] = 0, /* fork */
+    [   3] = 3, /* read */
+    [   4] = 3, /* write */
+    [   5] = 3, /* open */
+    [   6] = 1, /* close */
+    [   7] = 3, /* waitpid */
+    [   8] = 2, /* creat */
+    [   9] = 2, /* link */
+    [  10] = 1, /* unlink */
+    [  11] = 3, /* execve */
+    [  12] = 1, /* chdir */
+    [  13] = 1, /* time */
+    [  14] = 3, /* mknod */
+    [  15] = 2, /* chmod */
+    [  16] = 3, /* lchown */
+    [  17] = 0, /* break */
+    [  18] = 2, /* oldstat */
+    [  19] = 3, /* lseek */
+    [  20] = 0, /* getpid */
+    [  21] = 5, /* mount */
+    [  22] = 1, /* umount */
+    [  23] = 1, /* setuid */
+    [  24] = 0, /* getuid */
+    [  25] = 1, /* stime */
+    [  26] = 4, /* ptrace */
+    [  27] = 1, /* alarm */
+    [  28] = 2, /* oldfstat */
+    [  29] = 0, /* pause */
+    [  30] = 2, /* utime */
+    [  31] = 0, /* stty */
+    [  32] = 0, /* gtty */
+    [  33] = 2, /* access */
+    [  34] = 1, /* nice */
+    [  35] = 1, /* ftime */
+    [  36] = 0, /* sync */
+    [  37] = 2, /* kill */
+    [  38] = 2, /* rename */
+    [  39] = 2, /* mkdir */
+    [  40] = 1, /* rmdir */
+    [  41] = 1, /* dup */
+    [  42] = 0, /* pipe */
+    [  43] = 1, /* times */
+    [  44] = 0, /* prof */
+    [  45] = 1, /* brk */
+    [  46] = 1, /* setgid */
+    [  47] = 0, /* getgid */
+    [  48] = 2, /* signal */
+    [  49] = 0, /* geteuid */
+    [  50] = 0, /* getegid */
+    [  51] = 1, /* acct */
+    [  52] = 2, /* umount2 */
+    [  53] = 0, /* lock */
+    [  54] = 3, /* ioctl */
+    [  55] = 3, /* fcntl */
+    [  56] = 0, /* mpx */
+    [  57] = 2, /* setpgid */
+    [  58] = 0, /* ulimit */
+    [  59] = 1, /* oldolduname */
+    [  60] = 1, /* umask */
+    [  61] = 1, /* chroot */
+    [  62] = 2, /* ustat */
+    [  63] = 2, /* dup2 */
+    [  64] = 0, /* getppid */
+    [  65] = 0, /* getpgrp */
+    [  66] = 0, /* setsid */
+    [  67] = 3, /* sigaction */
+    [  68] = 0, /* sgetmask */
+    [  69] = 1, /* ssetmask */
+    [  70] = 2, /* setreuid */
+    [  71] = 2, /* setregid */
+    [  72] = 1, /* sigsuspend */
+    [  73] = 1, /* sigpending */
+    [  74] = 2, /* sethostname */
+    [  75] = 2, /* setrlimit */
+    [  76] = 2, /* getrlimit */
+    [  77] = 2, /* getrusage */
+    [  78] = 2, /* gettimeofday */
+    [  79] = 2, /* settimeofday */
+    [  80] = 2, /* getgroups */
+    [  81] = 2, /* setgroups */
+    [  82] = 0, /* reserved82 */
+    [  83] = 2, /* symlink */
+    [  84] = 2, /* oldlstat */
+    [  85] = 3, /* readlink */
+    [  86] = 1, /* uselib */
+    [  87] = 2, /* swapon */
+    [  88] = 4, /* reboot */
+    [  89] = 3, /* readdir */
+    [  90] = 6, /* mmap */
+    [  91] = 2, /* munmap */
+    [  92] = 2, /* truncate */
+    [  93] = 2, /* ftruncate */
+    [  94] = 2, /* fchmod */
+    [  95] = 3, /* fchown */
+    [  96] = 2, /* getpriority */
+    [  97] = 3, /* setpriority */
+    [  98] = 0, /* profil */
+    [  99] = 2, /* statfs */
+    [ 100] = 2, /* fstatfs */
+    [ 101] = 3, /* ioperm */
+    [ 102] = 2, /* socketcall */
+    [ 103] = 3, /* syslog */
+    [ 104] = 3, /* setitimer */
+    [ 105] = 2, /* getitimer */
+    [ 106] = 2, /* stat */
+    [ 107] = 2, /* lstat */
+    [ 108] = 2, /* fstat */
+    [ 109] = 1, /* olduname */
+    [ 110] = 1, /* iopl */
+    [ 111] = 0, /* vhangup */
+    [ 112] = 0, /* idle */
+    [ 113] = 5, /* vm86 */
+    [ 114] = 4, /* wait4 */
+    [ 115] = 1, /* swapoff */
+    [ 116] = 1, /* sysinfo */
+    [ 117] = 6, /* ipc */
+    [ 118] = 1, /* fsync */
+    [ 119] = 0, /* sigreturn */
+    [ 120] = 5, /* clone */
+    [ 121] = 2, /* setdomainname */
+    [ 122] = 1, /* uname */
+    [ 123] = 0, /* modify_ldt */
+    [ 124] = 1, /* adjtimex */
+    [ 125] = 3, /* mprotect */
+    [ 126] = 3, /* sigprocmask */
+    [ 127] = 2, /* create_module */
+    [ 128] = 3, /* init_module */
+    [ 129] = 2, /* delete_module */
+    [ 130] = 1, /* get_kernel_syms */
+    [ 131] = 4, /* quotactl */
+    [ 132] = 1, /* getpgid */
+    [ 133] = 1, /* fchdir */
+    [ 134] = 2, /* bdflush */
+    [ 135] = 3, /* sysfs */
+    [ 136] = 1, /* personality */
+    [ 137] = 0, /* afs_syscall */
+    [ 138] = 1, /* setfsuid */
+    [ 139] = 1, /* setfsgid */
+    [ 140] = 5, /* _llseek */
+    [ 141] = 3, /* getdents */
+    [ 142] = 5, /* _newselect */
+    [ 143] = 2, /* flock */
+    [ 144] = 3, /* msync */
+    [ 145] = 3, /* readv */
+    [ 146] = 3, /* writev */
+    [ 147] = 3, /* cacheflush */
+    [ 148] = 3, /* cachectl */
+    [ 149] = 4, /* sysmips */
+    [ 150] = 0, /* setup */
+    [ 151] = 1, /* getsid */
+    [ 152] = 1, /* fdatasync */
+    [ 153] = 1, /* _sysctl */
+    [ 154] = 2, /* mlock */
+    [ 155] = 2, /* munlock */
+    [ 156] = 1, /* mlockall */
+    [ 157] = 0, /* munlockall */
+    [ 158] = 2, /* sched_setparam */
+    [ 159] = 2, /* sched_getparam */
+    [ 160] = 3, /* sched_setscheduler */
+    [ 161] = 1, /* sched_getscheduler */
+    [ 162] = 0, /* sched_yield */
+    [ 163] = 1, /* sched_get_priority_max */
+    [ 164] = 1, /* sched_get_priority_min */
+    [ 165] = 2, /* sched_rr_get_interval */
+    [ 166] = 2, /* nanosleep */
+    [ 167] = 5, /* mremap */
+    [ 168] = 3, /* accept */
+    [ 169] = 3, /* bind */
+    [ 170] = 3, /* connect */
+    [ 171] = 3, /* getpeername */
+    [ 172] = 3, /* getsockname */
+    [ 173] = 5, /* getsockopt */
+    [ 174] = 2, /* listen */
+    [ 175] = 4, /* recv */
+    [ 176] = 6, /* recvfrom */
+    [ 177] = 3, /* recvmsg */
+    [ 178] = 4, /* send */
+    [ 179] = 3, /* sendmsg */
+    [ 180] = 6, /* sendto */
+    [ 181] = 5, /* setsockopt */
+    [ 182] = 2, /* shutdown */
+    [ 183] = 3, /* socket */
+    [ 184] = 4, /* socketpair */
+    [ 185] = 3, /* setresuid */
+    [ 186] = 3, /* getresuid */
+    [ 187] = 5, /* query_module */
+    [ 188] = 3, /* poll */
+    [ 189] = 3, /* nfsservctl */
+    [ 190] = 3, /* setresgid */
+    [ 191] = 3, /* getresgid */
+    [ 192] = 5, /* prctl */
+    [ 193] = 0, /* rt_sigreturn */
+    [ 194] = 4, /* rt_sigaction */
+    [ 195] = 4, /* rt_sigprocmask */
+    [ 196] = 2, /* rt_sigpending */
+    [ 197] = 4, /* rt_sigtimedwait */
+    [ 198] = 3, /* rt_sigqueueinfo */
+    [ 199] = 2, /* rt_sigsuspend */
+    [ 200] = 6, /* pread64 */
+    [ 201] = 6, /* pwrite64 */
+    [ 202] = 3, /* chown */
+    [ 203] = 2, /* getcwd */
+    [ 204] = 2, /* capget */
+    [ 205] = 2, /* capset */
+    [ 206] = 2, /* sigaltstack */
+    [ 207] = 4, /* sendfile */
+    [ 208] = 5, /* getpmsg */
+    [ 209] = 5, /* putpmsg */
+    [ 210] = 6, /* mmap2 */
+    [ 211] = 4, /* truncate64 */
+    [ 212] = 4, /* ftruncate64 */
+    [ 213] = 2, /* stat64 */
+    [ 214] = 2, /* lstat64 */
+    [ 215] = 2, /* fstat64 */
+    [ 216] = 2, /* pivot_root */
+    [ 217] = 3, /* mincore */
+    [ 218] = 3, /* madvise */
+    [ 219] = 3, /* getdents64 */
+    [ 220] = 3, /* fcntl64 */
+    [ 221] = 0, /* reserved221 */
+    [ 222] = 0, /* gettid */
+    [ 223] = 5, /* readahead */
+    [ 224] = 5, /* setxattr */
+    [ 225] = 5, /* lsetxattr */
+    [ 226] = 5, /* fsetxattr */
+    [ 227] = 4, /* getxattr */
+    [ 228] = 4, /* lgetxattr */
+    [ 229] = 4, /* fgetxattr */
+    [ 230] = 3, /* listxattr */
+    [ 231] = 3, /* llistxattr */
+    [ 232] = 3, /* flistxattr */
+    [ 233] = 2, /* removexattr */
+    [ 234] = 2, /* lremovexattr */
+    [ 235] = 2, /* fremovexattr */
+    [ 236] = 2, /* tkill */
+    [ 237] = 4, /* sendfile64 */
+    [ 238] = 6, /* futex */
+    [ 239] = 3, /* sched_setaffinity */
+    [ 240] = 3, /* sched_getaffinity */
+    [ 241] = 2, /* io_setup */
+    [ 242] = 1, /* io_destroy */
+    [ 243] = 5, /* io_getevents */
+    [ 244] = 3, /* io_submit */
+    [ 245] = 3, /* io_cancel */
+    [ 246] = 1, /* exit_group */
+    [ 247] = 4, /* lookup_dcookie */
+    [ 248] = 1, /* epoll_create */
+    [ 249] = 4, /* epoll_ctl */
+    [ 250] = 4, /* epoll_wait */
+    [ 251] = 5, /* remap_file_pages */
+    [ 252] = 1, /* set_tid_address */
+    [ 253] = 0, /* restart_syscall */
+    [ 254] = 7, /* fadvise64 */
+    [ 255] = 3, /* statfs64 */
+    [ 256] = 3, /* fstatfs64 */
+    [ 257] = 3, /* timer_create */
+    [ 258] = 4, /* timer_settime */
+    [ 259] = 2, /* timer_gettime */
+    [ 260] = 1, /* timer_getoverrun */
+    [ 261] = 1, /* timer_delete */
+    [ 262] = 2, /* clock_settime */
+    [ 263] = 2, /* clock_gettime */
+    [ 264] = 2, /* clock_getres */
+    [ 265] = 4, /* clock_nanosleep */
+    [ 266] = 3, /* tgkill */
+    [ 267] = 2, /* utimes */
+    [ 268] = 6, /* mbind */
+    [ 269] = 5, /* get_mempolicy */
+    [ 270] = 3, /* set_mempolicy */
+    [ 271] = 4, /* mq_open */
+    [ 272] = 1, /* mq_unlink */
+    [ 273] = 5, /* mq_timedsend */
+    [ 274] = 5, /* mq_timedreceive */
+    [ 275] = 2, /* mq_notify */
+    [ 276] = 3, /* mq_getsetattr */
+    [ 277] = 5, /* vserver */
+    [ 278] = 5, /* waitid */
+    [ 279] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 280] = 5, /* add_key */
+    [ 281] = 4, /* request_key */
+    [ 282] = 5, /* keyctl */
+    [ 283] = 1, /* set_thread_area */
+    [ 284] = 0, /* inotify_init */
+    [ 285] = 3, /* inotify_add_watch */
+    [ 286] = 2, /* inotify_rm_watch */
+    [ 287] = 4, /* migrate_pages */
+    [ 288] = 4, /* openat */
+    [ 289] = 3, /* mkdirat */
+    [ 290] = 4, /* mknodat */
+    [ 291] = 5, /* fchownat */
+    [ 292] = 3, /* futimesat */
+    [ 293] = 4, /* fstatat64 */
+    [ 294] = 3, /* unlinkat */
+    [ 295] = 4, /* renameat */
+    [ 296] = 5, /* linkat */
+    [ 297] = 3, /* symlinkat */
+    [ 298] = 4, /* readlinkat */
+    [ 299] = 3, /* fchmodat */
+    [ 300] = 3, /* faccessat */
+    [ 301] = 6, /* pselect6 */
+    [ 302] = 5, /* ppoll */
+    [ 303] = 1, /* unshare */
+    [ 304] = 6, /* splice */
+    [ 305] = 7, /* sync_file_range */
+    [ 306] = 4, /* tee */
+    [ 307] = 4, /* vmsplice */
+    [ 308] = 6, /* move_pages */
+    [ 309] = 2, /* set_robust_list */
+    [ 310] = 3, /* get_robust_list */
+    [ 311] = 4, /* kexec_load */
+    [ 312] = 3, /* getcpu */
+    [ 313] = 6, /* epoll_pwait */
+    [ 314] = 3, /* ioprio_set */
+    [ 315] = 2, /* ioprio_get */
+    [ 316] = 4, /* utimensat */
+    [ 317] = 3, /* signalfd */
+    [ 318] = 4, /* timerfd */
+    [ 319] = 1, /* eventfd */
+    [ 320] = 6, /* fallocate */
+    [ 321] = 2, /* timerfd_create */
+    [ 322] = 2, /* timerfd_gettime */
+    [ 323] = 4, /* timerfd_settime */
+    [ 324] = 4, /* signalfd4 */
+    [ 325] = 2, /* eventfd2 */
+    [ 326] = 1, /* epoll_create1 */
+    [ 327] = 3, /* dup3 */
+    [ 328] = 2, /* pipe2 */
+    [ 329] = 1, /* inotify_init1 */
+    [ 330] = 5, /* preadv */
+    [ 331] = 5, /* pwritev */
+    [ 332] = 4, /* rt_tgsigqueueinfo */
+    [ 333] = 5, /* perf_event_open */
+    [ 334] = 4, /* accept4 */
+    [ 335] = 5, /* recvmmsg */
+    [ 336] = 2, /* fanotify_init */
+    [ 337] = 6, /* fanotify_mark */
+    [ 338] = 4, /* prlimit64 */
+    [ 339] = 5, /* name_to_handle_at */
+    [ 340] = 3, /* open_by_handle_at */
+    [ 341] = 2, /* clock_adjtime */
+    [ 342] = 1, /* syncfs */
+    [ 343] = 4, /* sendmmsg */
+    [ 344] = 2, /* setns */
+    [ 345] = 6, /* process_vm_readv */
+    [ 346] = 6, /* process_vm_writev */
+    [ 347] = 5, /* kcmp */
+    [ 348] = 3, /* finit_module */
+    [ 349] = 3, /* sched_setattr */
+    [ 350] = 4, /* sched_getattr */
+    [ 351] = 5, /* renameat2 */
+    [ 352] = 3, /* seccomp */
+    [ 353] = 3, /* getrandom */
+    [ 354] = 2, /* memfd_create */
+    [ 355] = 3, /* bpf */
+    [ 356] = 5, /* execveat */
+    [ 357] = 1, /* userfaultfd */
+    [ 358] = 2, /* membarrier */
+    [ 359] = 3, /* mlock2 */
+    [ 360] = 6, /* copy_file_range */
+    [ 361] = 6, /* preadv2 */
+    [ 362] = 6, /* pwritev2 */
+    [ 363] = 4, /* pkey_mprotect */
+    [ 364] = 2, /* pkey_alloc */
+    [ 365] = 1, /* pkey_free */
+    [ 366] = 5, /* statx */
+    [ 367] = 4, /* rseq */
+    [ 368] = 6, /* io_pgetevents */
+    [ 369] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 370] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 371] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 372] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 373] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 374] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 375] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 376] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 377] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 378] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 379] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 380] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 381] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 382] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 383] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 384] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 385] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 386] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 387] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 388] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 389] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 390] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 391] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 392] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 393] = 3, /* semget */
+    [ 394] = 4, /* semctl */
+    [ 395] = 3, /* shmget */
+    [ 396] = 3, /* shmctl */
+    [ 397] = 3, /* shmat */
+    [ 398] = 1, /* shmdt */
+    [ 399] = 2, /* msgget */
+    [ 400] = 4, /* msgsnd */
+    [ 401] = 5, /* msgrcv */
+    [ 402] = 3, /* msgctl */
+    [ 403] = 2, /* clock_gettime64 */
+    [ 404] = 2, /* clock_settime64 */
+    [ 405] = 2, /* clock_adjtime64 */
+    [ 406] = 2, /* clock_getres_time64 */
+    [ 407] = 4, /* clock_nanosleep_time64 */
+    [ 408] = 2, /* timer_gettime64 */
+    [ 409] = 4, /* timer_settime64 */
+    [ 410] = 2, /* timerfd_gettime64 */
+    [ 411] = 4, /* timerfd_settime64 */
+    [ 412] = 4, /* utimensat_time64 */
+    [ 413] = 6, /* pselect6_time64 */
+    [ 414] = 5, /* ppoll_time64 */
+    [ 415] = MIPS_SYSCALL_NUMBER_UNUSED,
+    [ 416] = 6, /* io_pgetevents_time64 */
+    [ 417] = 5, /* recvmmsg_time64 */
+    [ 418] = 5, /* mq_timedsend_time64 */
+    [ 419] = 5, /* mq_timedreceive_time64 */
+    [ 420] = 4, /* semtimedop_time64 */
+    [ 421] = 4, /* rt_sigtimedwait_time64 */
+    [ 422] = 6, /* futex_time64 */
+    [ 423] = 2, /* sched_rr_get_interval_time64 */
+    [ 424] = 4, /* pidfd_send_signal */
+    [ 425] = 2, /* io_uring_setup */
+    [ 426] = 6, /* io_uring_enter */
+    [ 427] = 4, /* io_uring_register */
+    [ 428] = 3, /* open_tree */
+    [ 429] = 5, /* move_mount */
+    [ 430] = 2, /* fsopen */
+    [ 431] = 5, /* fsconfig */
+    [ 432] = 3, /* fsmount */
+    [ 433] = 3, /* fspick */
+    [ 434] = 2, /* pidfd_open */
+    [ 435] = 2, /* clone3 */
diff --git a/scripts/update-mips-syscall-args.sh b/scripts/update-mips-syscall-args.sh
new file mode 100755
index 000000000000..4f0dda4b83bc
--- /dev/null
+++ b/scripts/update-mips-syscall-args.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+
+URL=https://raw.githubusercontent.com/strace/strace/master
+FILES="sysent.h sysent_shorthand_defs.h linux/mips/syscallent-compat.h \
+       linux/mips/syscallent-o32.h linux/syscallent-common-32.h \
+       linux/syscallent-common.h"
+
+output="$1"
+if [ "$output" = "" ] ; then
+    output="$PWD"
+fi
+
+INC=linux-user/mips/syscall-args-o32.c.inc
+
+TMP=$(mktemp -d)
+cd $TMP
+
+for file in $FILES; do
+    curl -O $URL/$file
+done
+
+> subcall32.h
+
+cat > gen_mips_o32.c <<EOF
+#include <stdio.h>
+
+#define LINUX_MIPSO32
+#define MAX_ARGS 7
+
+#include "sysent.h"
+#include "sysent_shorthand_defs.h"
+
+#define SEN(syscall_name) 0,0
+const struct_sysent sysent0[] = {
+#include  "syscallent-o32.h"
+};
+
+int main(void)
+{
+    int i;
+
+    for (i = 4000; i < sizeof(sysent0) / sizeof(struct_sysent); i++) {
+        if (sysent0[i].sys_name == NULL) {
+            printf("    [% 4d] = MIPS_SYSCALL_NUMBER_UNUSED,\n", i - 4000);
+        } else {
+            printf("    [% 4d] = %d, /* %s */\n", i - 4000,
+                   sysent0[i].nargs, sysent0[i].sys_name);
+        }
+    }
+
+    return 0;
+}
+EOF
+
+cc -o gen_mips_o32 gen_mips_o32.c && ./gen_mips_o32 > "$output/$INC"
+
+rm -fr "$TMP"
-- 
2.24.1


