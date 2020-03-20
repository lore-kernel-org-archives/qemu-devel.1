Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AE3C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5AD2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5AD2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJYX-0002iM-NV
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJVo-0005kv-U5
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJVl-0007hc-9Y
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:40 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55073)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJVk-0007fz-Sz
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:37 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MZCX1-1ikhpe0NTF-00VCAd; Fri, 20 Mar 2020 16:24:32 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 10/32] linux-user, hppa: add syscall table generation support
Date: Fri, 20 Mar 2020 16:23:46 +0100
Message-Id: <20200320152408.182899-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rKiHxaqn2qM8YDHa/CgLXRfY7/zADaoQItw0svqhylBqOKXegFE
 Ajd8xJScknyDO+MaFUdPY1aoBr1jWegTFHwku2yDBJjPM6KvzAziCbNO6DVfOFVmPe0Gvdk
 lXsvHNG6QHcJafou1m44LT7IhoFg600BPUeYI/KMxv3vFbeHwFttpcvY533DlXR920JI4L+
 Uu5xqgIrLYBJDbTtBYyTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iteC3esU0eg=:7Cmz12dHyyl8WNHvG88bp9
 chgUc5DfzXVPAsNmSlu+jA6FLjGpBHjF63wxahWidNlwolXsY6CilU819Cm7CRHsJw9EB6yQP
 5DiB11PwUYxPlm22coL6/n7PM6Qq2KDmypM0cwR6DDeYsUmX5eItbHrcWbiz5fSxgOh+ZmiS1
 kFAh0Sl8uudgw4G+drx2Le0zCsPLOKztL0Qee/k0Gn3jgL8a/Lt6V0stNX1DFvsDeSDSwRszQ
 OMW1uA+MQasg2daCTCwDQQ5tL0tKs4fcRgz80mWckaveKmLbsgDAyJsS4lLaQ7kLBN6MzGVsh
 b/QVi0soBgs9LclAAMMUNnFHkx2RHOm8k4ZLfl3SWvvErzTL8FOmMILYkKWWBDtK6PN2eLW/4
 L8WD+uu0icQOQVoRBPhX6zDLLhxM1ldguzPs8+EovIKfTNis4NQzbqzXE57xHPM8g5sZTGws5
 FmfTZy1sl27QhlR6nZ6KVjzsZVWN2Q6+PvIwwXP6OoMgXKd3Co/tY57uXBoIIcIxY23/QAPxk
 NGI4YywFz95bT+7mxmz7HcrPADXmgEp1IfI9nQqGpF0ZmF5nq6izHcDF08EjZFjox42OaxOiO
 u09dJ8K612BWaGEIaxx9LLtX2oR1X0XnU7483dletJ3ahbz8V5UtzWjtd3pIAv9LCUZoV6nXF
 EZCXVSm0Th94YQ/0kg0CvD6FLMRJ/uXHR83I7aCtDPHXtu/IHE+BXkuITf5n6T3zwPOsrct3E
 Em8DB//CGpzuxovgVbdOsidZbrr2U/cFwTiVX54aqt8qbKLEYwBlNYaDgE435g19csN+10Dia
 dvN0ZN8zXQCQZKHy9GmUN+OAczBiA3ItLb6hfKJNWji/MowUYNzGW5oNTt2XHPSauIifN3W
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Copy syscall.tbl and syscallhdr.sh from linux/arch/parisc/kernel/syscalls v5.5
Update syscallhdr.sh to generate QEMU syscall_nr.h

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200310103403.3284090-4-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                     |   3 +-
 linux-user/Makefile.objs      |   1 +
 linux-user/hppa/Makefile.objs |   5 +
 linux-user/hppa/syscall.tbl   | 435 ++++++++++++++++++++++++++++++++++
 linux-user/hppa/syscall_nr.h  | 358 ----------------------------
 linux-user/hppa/syscallhdr.sh |  32 +++
 6 files changed, 475 insertions(+), 359 deletions(-)
 create mode 100644 linux-user/hppa/Makefile.objs
 create mode 100644 linux-user/hppa/syscall.tbl
 delete mode 100644 linux-user/hppa/syscall_nr.h
 create mode 100644 linux-user/hppa/syscallhdr.sh

diff --git a/configure b/configure
index 5a024d249008..d96b767947af 100755
--- a/configure
+++ b/configure
@@ -1889,7 +1889,7 @@ rm -f */config-devices.mak.d
 
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
-for arch in alpha ; do
+for arch in alpha hppa ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
@@ -7814,6 +7814,7 @@ case "$target_name" in
   ;;
   hppa)
     mttcg="yes"
+    TARGET_SYSTBL_ABI=common,32
   ;;
   lm32)
   ;;
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index a1afb4d21f9f..9f8e001241d5 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -10,3 +10,4 @@ obj-$(TARGET_ARM) += arm/semihost.o
 obj-$(TARGET_AARCH64) += arm/semihost.o
 
 obj-$(TARGET_ALPHA) += alpha/
+obj-$(TARGET_HPPA) += hppa/
diff --git a/linux-user/hppa/Makefile.objs b/linux-user/hppa/Makefile.objs
new file mode 100644
index 000000000000..f8368be6f314
--- /dev/null
+++ b/linux-user/hppa/Makefile.objs
@@ -0,0 +1,5 @@
+generated-files-y += linux-user/hppa/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/hppa/syscallhdr.sh
+%/syscall_nr.h: $(SRC_PATH)/linux-user/hppa/syscall.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/hppa/syscall.tbl b/linux-user/hppa/syscall.tbl
new file mode 100644
index 000000000000..285ff516150c
--- /dev/null
+++ b/linux-user/hppa/syscall.tbl
@@ -0,0 +1,435 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for parisc
+#
+# The format is:
+# <number> <abi> <name> <entry point> <compat entry point>
+#
+# The <abi> can be common, 64, or 32 for this file.
+#
+0	common	restart_syscall		sys_restart_syscall
+1	common	exit			sys_exit
+2	common	fork			sys_fork_wrapper
+3	common	read			sys_read
+4	common	write			sys_write
+5	common	open			sys_open			compat_sys_open
+6	common	close			sys_close
+7	common	waitpid			sys_waitpid
+8	common	creat			sys_creat
+9	common	link			sys_link
+10	common	unlink			sys_unlink
+11	common	execve			sys_execve			compat_sys_execve
+12	common	chdir			sys_chdir
+13	32	time			sys_time32
+13	64	time			sys_time
+14	common	mknod			sys_mknod
+15	common	chmod			sys_chmod
+16	common	lchown			sys_lchown
+17	common	socket			sys_socket
+18	common	stat			sys_newstat			compat_sys_newstat
+19	common	lseek			sys_lseek			compat_sys_lseek
+20	common	getpid			sys_getpid
+21	common	mount			sys_mount			compat_sys_mount
+22	common	bind			sys_bind
+23	common	setuid			sys_setuid
+24	common	getuid			sys_getuid
+25	32	stime			sys_stime32
+25	64	stime			sys_stime
+26	common	ptrace			sys_ptrace			compat_sys_ptrace
+27	common	alarm			sys_alarm
+28	common	fstat			sys_newfstat			compat_sys_newfstat
+29	common	pause			sys_pause
+30	32	utime			sys_utime32
+30	64	utime			sys_utime
+31	common	connect			sys_connect
+32	common	listen			sys_listen
+33	common	access			sys_access
+34	common	nice			sys_nice
+35	common	accept			sys_accept
+36	common	sync			sys_sync
+37	common	kill			sys_kill
+38	common	rename			sys_rename
+39	common	mkdir			sys_mkdir
+40	common	rmdir			sys_rmdir
+41	common	dup			sys_dup
+42	common	pipe			sys_pipe
+43	common	times			sys_times			compat_sys_times
+44	common	getsockname		sys_getsockname
+45	common	brk			sys_brk
+46	common	setgid			sys_setgid
+47	common	getgid			sys_getgid
+48	common	signal			sys_signal
+49	common	geteuid			sys_geteuid
+50	common	getegid			sys_getegid
+51	common	acct			sys_acct
+52	common	umount2			sys_umount
+53	common	getpeername		sys_getpeername
+54	common	ioctl			sys_ioctl			compat_sys_ioctl
+55	common	fcntl			sys_fcntl			compat_sys_fcntl
+56	common	socketpair		sys_socketpair
+57	common	setpgid			sys_setpgid
+58	common	send			sys_send
+59	common	uname			sys_newuname
+60	common	umask			sys_umask
+61	common	chroot			sys_chroot
+62	common	ustat			sys_ustat			compat_sys_ustat
+63	common	dup2			sys_dup2
+64	common	getppid			sys_getppid
+65	common	getpgrp			sys_getpgrp
+66	common	setsid			sys_setsid
+67	common	pivot_root		sys_pivot_root
+68	common	sgetmask		sys_sgetmask			sys32_unimplemented
+69	common	ssetmask		sys_ssetmask			sys32_unimplemented
+70	common	setreuid		sys_setreuid
+71	common	setregid		sys_setregid
+72	common	mincore			sys_mincore
+73	common	sigpending		sys_sigpending			compat_sys_sigpending
+74	common	sethostname		sys_sethostname
+75	common	setrlimit		sys_setrlimit			compat_sys_setrlimit
+76	common	getrlimit		sys_getrlimit			compat_sys_getrlimit
+77	common	getrusage		sys_getrusage			compat_sys_getrusage
+78	common	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
+79	common	settimeofday		sys_settimeofday		compat_sys_settimeofday
+80	common	getgroups		sys_getgroups
+81	common	setgroups		sys_setgroups
+82	common	sendto			sys_sendto
+83	common	symlink			sys_symlink
+84	common	lstat			sys_newlstat			compat_sys_newlstat
+85	common	readlink		sys_readlink
+86	common	uselib			sys_ni_syscall
+87	common	swapon			sys_swapon
+88	common	reboot			sys_reboot
+89	common	mmap2			sys_mmap2
+90	common	mmap			sys_mmap
+91	common	munmap			sys_munmap
+92	common	truncate		sys_truncate			compat_sys_truncate
+93	common	ftruncate		sys_ftruncate			compat_sys_ftruncate
+94	common	fchmod			sys_fchmod
+95	common	fchown			sys_fchown
+96	common	getpriority		sys_getpriority
+97	common	setpriority		sys_setpriority
+98	common	recv			sys_recv
+99	common	statfs			sys_statfs			compat_sys_statfs
+100	common	fstatfs			sys_fstatfs			compat_sys_fstatfs
+101	common	stat64			sys_stat64
+# 102 was socketcall
+103	common	syslog			sys_syslog
+104	common	setitimer		sys_setitimer			compat_sys_setitimer
+105	common	getitimer		sys_getitimer			compat_sys_getitimer
+106	common	capget			sys_capget
+107	common	capset			sys_capset
+108	32	pread64			parisc_pread64
+108	64	pread64			sys_pread64
+109	32	pwrite64		parisc_pwrite64
+109	64	pwrite64		sys_pwrite64
+110	common	getcwd			sys_getcwd
+111	common	vhangup			sys_vhangup
+112	common	fstat64			sys_fstat64
+113	common	vfork			sys_vfork_wrapper
+114	common	wait4			sys_wait4			compat_sys_wait4
+115	common	swapoff			sys_swapoff
+116	common	sysinfo			sys_sysinfo			compat_sys_sysinfo
+117	common	shutdown		sys_shutdown
+118	common	fsync			sys_fsync
+119	common	madvise			sys_madvise
+120	common	clone			sys_clone_wrapper
+121	common	setdomainname		sys_setdomainname
+122	common	sendfile		sys_sendfile			compat_sys_sendfile
+123	common	recvfrom		sys_recvfrom
+124	32	adjtimex		sys_adjtimex_time32
+124	64	adjtimex		sys_adjtimex
+125	common	mprotect		sys_mprotect
+126	common	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
+# 127 was create_module
+128	common	init_module		sys_init_module
+129	common	delete_module		sys_delete_module
+# 130 was get_kernel_syms
+131	common	quotactl		sys_quotactl
+132	common	getpgid			sys_getpgid
+133	common	fchdir			sys_fchdir
+134	common	bdflush			sys_bdflush
+135	common	sysfs			sys_sysfs
+136	32	personality		parisc_personality
+136	64	personality		sys_personality
+# 137 was afs_syscall
+138	common	setfsuid		sys_setfsuid
+139	common	setfsgid		sys_setfsgid
+140	common	_llseek			sys_llseek
+141	common	getdents		sys_getdents			compat_sys_getdents
+142	common	_newselect		sys_select			compat_sys_select
+143	common	flock			sys_flock
+144	common	msync			sys_msync
+145	common	readv			sys_readv			compat_sys_readv
+146	common	writev			sys_writev			compat_sys_writev
+147	common	getsid			sys_getsid
+148	common	fdatasync		sys_fdatasync
+149	common	_sysctl			sys_sysctl			compat_sys_sysctl
+150	common	mlock			sys_mlock
+151	common	munlock			sys_munlock
+152	common	mlockall		sys_mlockall
+153	common	munlockall		sys_munlockall
+154	common	sched_setparam		sys_sched_setparam
+155	common	sched_getparam		sys_sched_getparam
+156	common	sched_setscheduler	sys_sched_setscheduler
+157	common	sched_getscheduler	sys_sched_getscheduler
+158	common	sched_yield		sys_sched_yield
+159	common	sched_get_priority_max	sys_sched_get_priority_max
+160	common	sched_get_priority_min	sys_sched_get_priority_min
+161	32	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+161	64	sched_rr_get_interval	sys_sched_rr_get_interval
+162	32	nanosleep		sys_nanosleep_time32
+162	64	nanosleep		sys_nanosleep
+163	common	mremap			sys_mremap
+164	common	setresuid		sys_setresuid
+165	common	getresuid		sys_getresuid
+166	common	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
+# 167 was query_module
+168	common	poll			sys_poll
+# 169 was nfsservctl
+170	common	setresgid		sys_setresgid
+171	common	getresgid		sys_getresgid
+172	common	prctl			sys_prctl
+173	common	rt_sigreturn		sys_rt_sigreturn_wrapper
+174	common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
+175	common	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+176	common	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
+177	32	rt_sigtimedwait		sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+177	64	rt_sigtimedwait		sys_rt_sigtimedwait
+178	common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+179	common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+180	common	chown			sys_chown
+181	common	setsockopt		sys_setsockopt			compat_sys_setsockopt
+182	common	getsockopt		sys_getsockopt			compat_sys_getsockopt
+183	common	sendmsg			sys_sendmsg			compat_sys_sendmsg
+184	common	recvmsg			sys_recvmsg			compat_sys_recvmsg
+185	common	semop			sys_semop
+186	common	semget			sys_semget
+187	common	semctl			sys_semctl			compat_sys_semctl
+188	common	msgsnd			sys_msgsnd			compat_sys_msgsnd
+189	common	msgrcv			sys_msgrcv			compat_sys_msgrcv
+190	common	msgget			sys_msgget
+191	common	msgctl			sys_msgctl			compat_sys_msgctl
+192	common	shmat			sys_shmat			compat_sys_shmat
+193	common	shmdt			sys_shmdt
+194	common	shmget			sys_shmget
+195	common	shmctl			sys_shmctl			compat_sys_shmctl
+# 196 was getpmsg
+# 197 was putpmsg
+198	common	lstat64			sys_lstat64
+199	32	truncate64		parisc_truncate64
+199	64	truncate64		sys_truncate64
+200	32	ftruncate64		parisc_ftruncate64
+200	64	ftruncate64		sys_ftruncate64
+201	common	getdents64		sys_getdents64
+202	common	fcntl64			sys_fcntl64			compat_sys_fcntl64
+# 203 was attrctl
+# 204 was acl_get
+# 205 was acl_set
+206	common	gettid			sys_gettid
+207	32	readahead		parisc_readahead
+207	64	readahead		sys_readahead
+208	common	tkill			sys_tkill
+209	common	sendfile64		sys_sendfile64			compat_sys_sendfile64
+210	32	futex			sys_futex_time32
+210	64	futex			sys_futex
+211	common	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
+212	common	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
+# 213 was set_thread_area
+# 214 was get_thread_area
+215	common	io_setup		sys_io_setup			compat_sys_io_setup
+216	common	io_destroy		sys_io_destroy
+217	32	io_getevents		sys_io_getevents_time32
+217	64	io_getevents		sys_io_getevents
+218	common	io_submit		sys_io_submit			compat_sys_io_submit
+219	common	io_cancel		sys_io_cancel
+# 220 was alloc_hugepages
+# 221 was free_hugepages
+222	common	exit_group		sys_exit_group
+223	common	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
+224	common	epoll_create		sys_epoll_create
+225	common	epoll_ctl		sys_epoll_ctl
+226	common	epoll_wait		sys_epoll_wait
+227	common	remap_file_pages	sys_remap_file_pages
+228	32	semtimedop		sys_semtimedop_time32
+228	64	semtimedop		sys_semtimedop
+229	common	mq_open			sys_mq_open			compat_sys_mq_open
+230	common	mq_unlink		sys_mq_unlink
+231	32	mq_timedsend		sys_mq_timedsend_time32
+231	64	mq_timedsend		sys_mq_timedsend
+232	32	mq_timedreceive		sys_mq_timedreceive_time32
+232	64	mq_timedreceive		sys_mq_timedreceive
+233	common	mq_notify		sys_mq_notify			compat_sys_mq_notify
+234	common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
+235	common	waitid			sys_waitid			compat_sys_waitid
+236	32	fadvise64_64		parisc_fadvise64_64
+236	64	fadvise64_64		sys_fadvise64_64
+237	common	set_tid_address		sys_set_tid_address
+238	common	setxattr		sys_setxattr
+239	common	lsetxattr		sys_lsetxattr
+240	common	fsetxattr		sys_fsetxattr
+241	common	getxattr		sys_getxattr
+242	common	lgetxattr		sys_lgetxattr
+243	common	fgetxattr		sys_fgetxattr
+244	common	listxattr		sys_listxattr
+245	common	llistxattr		sys_llistxattr
+246	common	flistxattr		sys_flistxattr
+247	common	removexattr		sys_removexattr
+248	common	lremovexattr		sys_lremovexattr
+249	common	fremovexattr		sys_fremovexattr
+250	common	timer_create		sys_timer_create		compat_sys_timer_create
+251	32	timer_settime		sys_timer_settime32
+251	64	timer_settime		sys_timer_settime
+252	32	timer_gettime		sys_timer_gettime32
+252	64	timer_gettime		sys_timer_gettime
+253	common	timer_getoverrun	sys_timer_getoverrun
+254	common	timer_delete		sys_timer_delete
+255	32	clock_settime		sys_clock_settime32
+255	64	clock_settime		sys_clock_settime
+256	32	clock_gettime		sys_clock_gettime32
+256	64	clock_gettime		sys_clock_gettime
+257	32	clock_getres		sys_clock_getres_time32
+257	64	clock_getres		sys_clock_getres
+258	32	clock_nanosleep		sys_clock_nanosleep_time32
+258	64	clock_nanosleep		sys_clock_nanosleep
+259	common	tgkill			sys_tgkill
+260	common	mbind			sys_mbind			compat_sys_mbind
+261	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
+262	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
+# 263 was vserver
+264	common	add_key			sys_add_key
+265	common	request_key		sys_request_key
+266	common	keyctl			sys_keyctl			compat_sys_keyctl
+267	common	ioprio_set		sys_ioprio_set
+268	common	ioprio_get		sys_ioprio_get
+269	common	inotify_init		sys_inotify_init
+270	common	inotify_add_watch	sys_inotify_add_watch
+271	common	inotify_rm_watch	sys_inotify_rm_watch
+272	common	migrate_pages		sys_migrate_pages
+273	32	pselect6		sys_pselect6_time32		compat_sys_pselect6_time32
+273	64	pselect6		sys_pselect6
+274	32	ppoll			sys_ppoll_time32		compat_sys_ppoll_time32
+274	64	ppoll			sys_ppoll
+275	common	openat			sys_openat			compat_sys_openat
+276	common	mkdirat			sys_mkdirat
+277	common	mknodat			sys_mknodat
+278	common	fchownat		sys_fchownat
+279	32	futimesat		sys_futimesat_time32
+279	64	futimesat		sys_futimesat
+280	common	fstatat64		sys_fstatat64
+281	common	unlinkat		sys_unlinkat
+282	common	renameat		sys_renameat
+283	common	linkat			sys_linkat
+284	common	symlinkat		sys_symlinkat
+285	common	readlinkat		sys_readlinkat
+286	common	fchmodat		sys_fchmodat
+287	common	faccessat		sys_faccessat
+288	common	unshare			sys_unshare
+289	common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
+290	common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
+291	common	splice			sys_splice
+292	32	sync_file_range		parisc_sync_file_range
+292	64	sync_file_range		sys_sync_file_range
+293	common	tee			sys_tee
+294	common	vmsplice		sys_vmsplice			compat_sys_vmsplice
+295	common	move_pages		sys_move_pages			compat_sys_move_pages
+296	common	getcpu			sys_getcpu
+297	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
+298	common	statfs64		sys_statfs64			compat_sys_statfs64
+299	common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
+300	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
+301	32	utimensat		sys_utimensat_time32
+301	64	utimensat		sys_utimensat
+302	common	signalfd		sys_signalfd			compat_sys_signalfd
+# 303 was timerfd
+304	common	eventfd			sys_eventfd
+305	32	fallocate		parisc_fallocate
+305	64	fallocate		sys_fallocate
+306	common	timerfd_create		sys_timerfd_create
+307	32	timerfd_settime		sys_timerfd_settime32
+307	64	timerfd_settime		sys_timerfd_settime
+308	32	timerfd_gettime		sys_timerfd_gettime32
+308	64	timerfd_gettime		sys_timerfd_gettime
+309	common	signalfd4		sys_signalfd4			compat_sys_signalfd4
+310	common	eventfd2		sys_eventfd2
+311	common	epoll_create1		sys_epoll_create1
+312	common	dup3			sys_dup3
+313	common	pipe2			sys_pipe2
+314	common	inotify_init1		sys_inotify_init1
+315	common	preadv	sys_preadv	compat_sys_preadv
+316	common	pwritev	sys_pwritev	compat_sys_pwritev
+317	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+318	common	perf_event_open		sys_perf_event_open
+319	32	recvmmsg		sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+319	64	recvmmsg		sys_recvmmsg
+320	common	accept4			sys_accept4
+321	common	prlimit64		sys_prlimit64
+322	common	fanotify_init		sys_fanotify_init
+323	common	fanotify_mark		sys_fanotify_mark		sys32_fanotify_mark
+324	32	clock_adjtime		sys_clock_adjtime32
+324	64	clock_adjtime		sys_clock_adjtime
+325	common	name_to_handle_at	sys_name_to_handle_at
+326	common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
+327	common	syncfs			sys_syncfs
+328	common	setns			sys_setns
+329	common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
+330	common	process_vm_readv	sys_process_vm_readv		compat_sys_process_vm_readv
+331	common	process_vm_writev	sys_process_vm_writev		compat_sys_process_vm_writev
+332	common	kcmp			sys_kcmp
+333	common	finit_module		sys_finit_module
+334	common	sched_setattr		sys_sched_setattr
+335	common	sched_getattr		sys_sched_getattr
+336	32	utimes			sys_utimes_time32
+336	64	utimes			sys_utimes
+337	common	renameat2		sys_renameat2
+338	common	seccomp			sys_seccomp
+339	common	getrandom		sys_getrandom
+340	common	memfd_create		sys_memfd_create
+341	common	bpf			sys_bpf
+342	common	execveat		sys_execveat			compat_sys_execveat
+343	common	membarrier		sys_membarrier
+344	common	userfaultfd		sys_userfaultfd
+345	common	mlock2			sys_mlock2
+346	common	copy_file_range		sys_copy_file_range
+347	common	preadv2			sys_preadv2			compat_sys_preadv2
+348	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
+349	common	statx			sys_statx
+350	32	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
+350	64	io_pgetevents		sys_io_pgetevents
+351	common	pkey_mprotect		sys_pkey_mprotect
+352	common	pkey_alloc		sys_pkey_alloc
+353	common	pkey_free		sys_pkey_free
+354	common	rseq			sys_rseq
+355	common	kexec_file_load		sys_kexec_file_load		sys_kexec_file_load
+# up to 402 is unassigned and reserved for arch specific syscalls
+403	32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
+404	32	clock_settime64			sys_clock_settime		sys_clock_settime
+405	32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
+406	32	clock_getres_time64		sys_clock_getres		sys_clock_getres
+407	32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
+408	32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
+409	32	timer_settime64			sys_timer_settime		sys_timer_settime
+410	32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
+411	32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
+412	32	utimensat_time64		sys_utimensat			sys_utimensat
+413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
+419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
+420	32	semtimedop_time64		sys_semtimedop			sys_semtimedop
+421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64			sys_futex			sys_futex
+423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
+435	common	clone3				sys_clone3_wrapper
diff --git a/linux-user/hppa/syscall_nr.h b/linux-user/hppa/syscall_nr.h
deleted file mode 100644
index ae41e9432170..000000000000
--- a/linux-user/hppa/syscall_nr.h
+++ /dev/null
@@ -1,358 +0,0 @@
-/*
- * This file contains the system call numbers.
- */
-
-#ifndef LINUX_USER_HPPA_SYSCALL_NR_H
-#define LINUX_USER_HPPA_SYSCALL_NR_H
-
-#define TARGET_NR_restart_syscall 0
-#define TARGET_NR_exit            1
-#define TARGET_NR_fork            2
-#define TARGET_NR_read            3
-#define TARGET_NR_write           4
-#define TARGET_NR_open            5
-#define TARGET_NR_close           6
-#define TARGET_NR_waitpid         7
-#define TARGET_NR_creat           8
-#define TARGET_NR_link            9
-#define TARGET_NR_unlink         10
-#define TARGET_NR_execve         11
-#define TARGET_NR_chdir          12
-#define TARGET_NR_time           13
-#define TARGET_NR_mknod          14
-#define TARGET_NR_chmod          15
-#define TARGET_NR_lchown         16
-#define TARGET_NR_socket         17
-#define TARGET_NR_stat           18
-#define TARGET_NR_lseek          19
-#define TARGET_NR_getpid         20
-#define TARGET_NR_mount          21
-#define TARGET_NR_bind           22
-#define TARGET_NR_setuid         23
-#define TARGET_NR_getuid         24
-#define TARGET_NR_stime          25
-#define TARGET_NR_ptrace         26
-#define TARGET_NR_alarm          27
-#define TARGET_NR_fstat          28
-#define TARGET_NR_pause          29
-#define TARGET_NR_utime          30
-#define TARGET_NR_connect        31
-#define TARGET_NR_listen         32
-#define TARGET_NR_access         33
-#define TARGET_NR_nice           34
-#define TARGET_NR_accept         35
-#define TARGET_NR_sync           36
-#define TARGET_NR_kill           37
-#define TARGET_NR_rename         38
-#define TARGET_NR_mkdir          39
-#define TARGET_NR_rmdir          40
-#define TARGET_NR_dup            41
-#define TARGET_NR_pipe           42
-#define TARGET_NR_times          43
-#define TARGET_NR_getsockname    44
-#define TARGET_NR_brk            45
-#define TARGET_NR_setgid         46
-#define TARGET_NR_getgid         47
-#define TARGET_NR_signal         48
-#define TARGET_NR_geteuid        49
-#define TARGET_NR_getegid        50
-#define TARGET_NR_acct           51
-#define TARGET_NR_umount2        52
-#define TARGET_NR_getpeername    53
-#define TARGET_NR_ioctl          54
-#define TARGET_NR_fcntl          55
-#define TARGET_NR_socketpair     56
-#define TARGET_NR_setpgid        57
-#define TARGET_NR_send           58
-#define TARGET_NR_uname          59
-#define TARGET_NR_umask          60
-#define TARGET_NR_chroot         61
-#define TARGET_NR_ustat          62
-#define TARGET_NR_dup2           63
-#define TARGET_NR_getppid        64
-#define TARGET_NR_getpgrp        65
-#define TARGET_NR_setsid         66
-#define TARGET_NR_pivot_root     67
-#define TARGET_NR_sgetmask       68
-#define TARGET_NR_ssetmask       69
-#define TARGET_NR_setreuid       70
-#define TARGET_NR_setregid       71
-#define TARGET_NR_mincore        72
-#define TARGET_NR_sigpending     73
-#define TARGET_NR_sethostname    74
-#define TARGET_NR_setrlimit      75
-#define TARGET_NR_getrlimit      76
-#define TARGET_NR_getrusage      77
-#define TARGET_NR_gettimeofday   78
-#define TARGET_NR_settimeofday   79
-#define TARGET_NR_getgroups      80
-#define TARGET_NR_setgroups      81
-#define TARGET_NR_sendto         82
-#define TARGET_NR_symlink        83
-#define TARGET_NR_lstat          84
-#define TARGET_NR_readlink       85
-#define TARGET_NR_uselib         86
-#define TARGET_NR_swapon         87
-#define TARGET_NR_reboot         88
-#define TARGET_NR_mmap2          89
-#define TARGET_NR_mmap           90
-#define TARGET_NR_munmap         91
-#define TARGET_NR_truncate       92
-#define TARGET_NR_ftruncate      93
-#define TARGET_NR_fchmod         94
-#define TARGET_NR_fchown         95
-#define TARGET_NR_getpriority    96
-#define TARGET_NR_setpriority    97
-#define TARGET_NR_recv           98
-#define TARGET_NR_statfs         99
-#define TARGET_NR_fstatfs       100
-#define TARGET_NR_stat64        101
-#define TARGET_NR_socketcall    102
-#define TARGET_NR_syslog        103
-#define TARGET_NR_setitimer     104
-#define TARGET_NR_getitimer     105
-#define TARGET_NR_capget        106
-#define TARGET_NR_capset        107
-#define TARGET_NR_pread64       108
-#define TARGET_NR_pwrite64      109
-#define TARGET_NR_getcwd        110
-#define TARGET_NR_vhangup       111
-#define TARGET_NR_fstat64       112
-#define TARGET_NR_vfork         113
-#define TARGET_NR_wait4         114
-#define TARGET_NR_swapoff       115
-#define TARGET_NR_sysinfo       116
-#define TARGET_NR_shutdown      117
-#define TARGET_NR_fsync         118
-#define TARGET_NR_madvise       119
-#define TARGET_NR_clone         120
-#define TARGET_NR_setdomainname 121
-#define TARGET_NR_sendfile      122
-#define TARGET_NR_recvfrom      123
-#define TARGET_NR_adjtimex      124
-#define TARGET_NR_mprotect      125
-#define TARGET_NR_sigprocmask   126
-#define TARGET_NR_create_module 127
-#define TARGET_NR_init_module   128
-#define TARGET_NR_delete_module 129
-#define TARGET_NR_get_kernel_syms 130
-#define TARGET_NR_quotactl      131
-#define TARGET_NR_getpgid       132
-#define TARGET_NR_fchdir        133
-#define TARGET_NR_bdflush       134
-#define TARGET_NR_sysfs         135
-#define TARGET_NR_personality   136
-#define TARGET_NR_afs_syscall   137 /* Syscall for Andrew File System */
-#define TARGET_NR_setfsuid      138
-#define TARGET_NR_setfsgid      139
-#define TARGET_NR__llseek       140
-#define TARGET_NR_getdents      141
-#define TARGET_NR__newselect    142
-#define TARGET_NR_flock         143
-#define TARGET_NR_msync         144
-#define TARGET_NR_readv         145
-#define TARGET_NR_writev        146
-#define TARGET_NR_getsid        147
-#define TARGET_NR_fdatasync     148
-#define TARGET_NR__sysctl       149
-#define TARGET_NR_mlock         150
-#define TARGET_NR_munlock       151
-#define TARGET_NR_mlockall      152
-#define TARGET_NR_munlockall    153
-#define TARGET_NR_sched_setparam          154
-#define TARGET_NR_sched_getparam          155
-#define TARGET_NR_sched_setscheduler      156
-#define TARGET_NR_sched_getscheduler      157
-#define TARGET_NR_sched_yield             158
-#define TARGET_NR_sched_get_priority_max  159
-#define TARGET_NR_sched_get_priority_min  160
-#define TARGET_NR_sched_rr_get_interval   161
-#define TARGET_NR_nanosleep     162
-#define TARGET_NR_mremap        163
-#define TARGET_NR_setresuid     164
-#define TARGET_NR_getresuid     165
-#define TARGET_NR_sigaltstack   166
-#define TARGET_NR_query_module  167
-#define TARGET_NR_poll          168
-#define TARGET_NR_nfsservctl    169
-#define TARGET_NR_setresgid     170
-#define TARGET_NR_getresgid     171
-#define TARGET_NR_prctl         172
-#define TARGET_NR_rt_sigreturn          173
-#define TARGET_NR_rt_sigaction          174
-#define TARGET_NR_rt_sigprocmask        175
-#define TARGET_NR_rt_sigpending         176
-#define TARGET_NR_rt_sigtimedwait       177
-#define TARGET_NR_rt_sigqueueinfo       178
-#define TARGET_NR_rt_sigsuspend         179
-#define TARGET_NR_chown         180
-#define TARGET_NR_setsockopt    181
-#define TARGET_NR_getsockopt    182
-#define TARGET_NR_sendmsg       183
-#define TARGET_NR_recvmsg       184
-#define TARGET_NR_semop         185
-#define TARGET_NR_semget        186
-#define TARGET_NR_semctl        187
-#define TARGET_NR_msgsnd        188
-#define TARGET_NR_msgrcv        189
-#define TARGET_NR_msgget        190
-#define TARGET_NR_msgctl        191
-#define TARGET_NR_shmat         192
-#define TARGET_NR_shmdt         193
-#define TARGET_NR_shmget        194
-#define TARGET_NR_shmctl        195
-#define TARGET_NR_getpmsg       196
-#define TARGET_NR_putpmsg       197
-#define TARGET_NR_lstat64       198
-#define TARGET_NR_truncate64    199
-#define TARGET_NR_ftruncate64   200
-#define TARGET_NR_getdents64    201
-#define TARGET_NR_fcntl64       202
-#define TARGET_NR_attrctl       203
-#define TARGET_NR_acl_get       204
-#define TARGET_NR_acl_set       205
-#define TARGET_NR_gettid        206
-#define TARGET_NR_readahead     207
-#define TARGET_NR_tkill         208
-#define TARGET_NR_sendfile64    209
-#define TARGET_NR_futex         210
-#define TARGET_NR_sched_setaffinity 211
-#define TARGET_NR_sched_getaffinity 212
-#define TARGET_NR_set_thread_area   213
-#define TARGET_NR_get_thread_area   214
-#define TARGET_NR_io_setup          215
-#define TARGET_NR_io_destroy        216
-#define TARGET_NR_io_getevents      217
-#define TARGET_NR_io_submit         218
-#define TARGET_NR_io_cancel         219
-#define TARGET_NR_alloc_hugepages   220
-#define TARGET_NR_free_hugepages    221
-#define TARGET_NR_exit_group        222
-#define TARGET_NR_lookup_dcookie    223
-#define TARGET_NR_epoll_create      224
-#define TARGET_NR_epoll_ctl         225
-#define TARGET_NR_epoll_wait        226
-#define TARGET_NR_remap_file_pages  227
-#define TARGET_NR_semtimedop        228
-#define TARGET_NR_mq_open           229
-#define TARGET_NR_mq_unlink         230
-#define TARGET_NR_mq_timedsend      231
-#define TARGET_NR_mq_timedreceive   232
-#define TARGET_NR_mq_notify         233
-#define TARGET_NR_mq_getsetattr     234
-#define TARGET_NR_waitid            235
-#define TARGET_NR_fadvise64_64      236
-#define TARGET_NR_set_tid_address   237
-#define TARGET_NR_setxattr          238
-#define TARGET_NR_lsetxattr         239
-#define TARGET_NR_fsetxattr         240
-#define TARGET_NR_getxattr          241
-#define TARGET_NR_lgetxattr         242
-#define TARGET_NR_fgetxattr         243
-#define TARGET_NR_listxattr         244
-#define TARGET_NR_llistxattr        245
-#define TARGET_NR_flistxattr        246
-#define TARGET_NR_removexattr       247
-#define TARGET_NR_lremovexattr      248
-#define TARGET_NR_fremovexattr      249
-#define TARGET_NR_timer_create      250
-#define TARGET_NR_timer_settime     251
-#define TARGET_NR_timer_gettime     252
-#define TARGET_NR_timer_getoverrun  253
-#define TARGET_NR_timer_delete      254
-#define TARGET_NR_clock_settime     255
-#define TARGET_NR_clock_gettime     256
-#define TARGET_NR_clock_getres      257
-#define TARGET_NR_clock_nanosleep   258
-#define TARGET_NR_tgkill            259
-#define TARGET_NR_mbind             260
-#define TARGET_NR_get_mempolicy     261
-#define TARGET_NR_set_mempolicy     262
-#define TARGET_NR_vserver           263
-#define TARGET_NR_add_key           264
-#define TARGET_NR_request_key       265
-#define TARGET_NR_keyctl            266
-#define TARGET_NR_ioprio_set        267
-#define TARGET_NR_ioprio_get        268
-#define TARGET_NR_inotify_init      269
-#define TARGET_NR_inotify_add_watch 270
-#define TARGET_NR_inotify_rm_watch  271
-#define TARGET_NR_migrate_pages     272
-#define TARGET_NR_pselect6          273
-#define TARGET_NR_ppoll             274
-#define TARGET_NR_openat            275
-#define TARGET_NR_mkdirat           276
-#define TARGET_NR_mknodat           277
-#define TARGET_NR_fchownat          278
-#define TARGET_NR_futimesat         279
-#define TARGET_NR_fstatat64         280
-#define TARGET_NR_unlinkat          281
-#define TARGET_NR_renameat          282
-#define TARGET_NR_linkat            283
-#define TARGET_NR_symlinkat         284
-#define TARGET_NR_readlinkat        285
-#define TARGET_NR_fchmodat          286
-#define TARGET_NR_faccessat         287
-#define TARGET_NR_unshare           288
-#define TARGET_NR_set_robust_list   289
-#define TARGET_NR_get_robust_list   290
-#define TARGET_NR_splice            291
-#define TARGET_NR_sync_file_range   292
-#define TARGET_NR_tee               293
-#define TARGET_NR_vmsplice          294
-#define TARGET_NR_move_pages        295
-#define TARGET_NR_getcpu            296
-#define TARGET_NR_epoll_pwait       297
-#define TARGET_NR_statfs64          298
-#define TARGET_NR_fstatfs64         299
-#define TARGET_NR_kexec_load        300
-#define TARGET_NR_utimensat         301
-#define TARGET_NR_signalfd          302
-#define TARGET_NR_timerfd           303
-#define TARGET_NR_eventfd           304
-#define TARGET_NR_fallocate         305
-#define TARGET_NR_timerfd_create    306
-#define TARGET_NR_timerfd_settime   307
-#define TARGET_NR_timerfd_gettime   308
-#define TARGET_NR_signalfd4         309
-#define TARGET_NR_eventfd2          310
-#define TARGET_NR_epoll_create1     311
-#define TARGET_NR_dup3              312
-#define TARGET_NR_pipe2             313
-#define TARGET_NR_inotify_init1     314
-#define TARGET_NR_preadv            315
-#define TARGET_NR_pwritev           316
-#define TARGET_NR_rt_tgsigqueueinfo 317
-#define TARGET_NR_perf_event_open   318
-#define TARGET_NR_recvmmsg          319
-#define TARGET_NR_accept4           320
-#define TARGET_NR_prlimit64         321
-#define TARGET_NR_fanotify_init     322
-#define TARGET_NR_fanotify_mark     323
-#define TARGET_NR_clock_adjtime     324
-#define TARGET_NR_name_to_handle_at 325
-#define TARGET_NR_open_by_handle_at 326
-#define TARGET_NR_syncfs            327
-#define TARGET_NR_setns             328
-#define TARGET_NR_sendmmsg          329
-#define TARGET_NR_process_vm_readv  330
-#define TARGET_NR_process_vm_writev 331
-#define TARGET_NR_kcmp              332
-#define TARGET_NR_finit_module      333
-#define TARGET_NR_sched_setattr     334
-#define TARGET_NR_sched_getattr     335
-#define TARGET_NR_utimes            336
-#define TARGET_NR_renameat2         337
-#define TARGET_NR_seccomp           338
-#define TARGET_NR_getrandom         339
-#define TARGET_NR_memfd_create      340
-#define TARGET_NR_bpf               341
-#define TARGET_NR_execveat          342
-#define TARGET_NR_membarrier        343
-#define TARGET_NR_userfaultfd       344
-#define TARGET_NR_mlock2            345
-#define TARGET_NR_copy_file_range   346
-#define TARGET_NR_preadv2           347
-#define TARGET_NR_pwritev2          348
-
-#endif
diff --git a/linux-user/hppa/syscallhdr.sh b/linux-user/hppa/syscallhdr.sh
new file mode 100644
index 000000000000..ac91a9576213
--- /dev/null
+++ b/linux-user/hppa/syscallhdr.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+prefix="$4"
+offset="$5"
+
+fileguard=LINUX_USER_HPPA_`basename "$out" | sed \
+    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
+    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
+    printf "#ifndef %s\n" "${fileguard}"
+    printf "#define %s\n" "${fileguard}"
+    printf "\n"
+
+    nxt=0
+    while read nr abi name entry compat ; do
+        if [ -z "$offset" ]; then
+            printf "#define TARGET_NR_%s%s\t%s\n" \
+                "${prefix}" "${name}" "${nr}"
+        else
+            printf "#define TARGET_NR_%s%s\t(%s + %s)\n" \
+                "${prefix}" "${name}" "${offset}" "${nr}"
+        fi
+        nxt=$((nr+1))
+    done
+
+    printf "\n"
+    printf "#endif /* %s */" "${fileguard}"
+) > "$out"
-- 
2.25.1


