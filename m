Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F419EC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85362070A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85362070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJed-000361-Qe
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJW5-0006Fs-CB
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJW1-00083s-BN
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:57 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40695)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJW0-00083C-Te
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:53 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MSKly-1ir1LM3bvU-00SiGY; Fri, 20 Mar 2020 16:24:49 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 22/32] linux-user,
 x86_64: add syscall table generation support
Date: Fri, 20 Mar 2020 16:23:58 +0100
Message-Id: <20200320152408.182899-23-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v+9wG+b0irjVPEgzGTfiXiBvaKKac8g9UTfPSdMehF3tL4XSksr
 cN+oCoS2Rc9tkwWZcNZ0VovxM2uHrjPMGK+7OJY31QZBm+WQzHpLx/UCPDJoYWJah57jl1v
 wZgQjZbj6M1N4WzI/XOAqFv8NrnjeoXZ0wGvG6In1ZlN37tqT0ZJ2LHzleMox5CKar10WMD
 Z1BYD1Nfq6/NmmGmW8qHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jaUqnPC0qF0=:AApSDbkG1RJcLC1hodowLy
 Apv8Z4uqkaf54iSzKAovMSRZMm8l20m380ghOfNfxdTD/VTKW+G04V7SXoEIhuABzLn0yS5Ms
 tYqMcIUKW3svaeZc/vKbcMp0myBEmRdBMztriC6/jVj/2wDNRTKiaJfaejpd7pvjbaSKZfm0G
 clnFMW3CtFQBZrYi8YZsfRpo6tT6hySb68PNQzb+9TjA2lM879llCfljW9vUzx7bxyLfVWpNf
 kwLiPj4++fcT53NBu3/L7k0iXj/1Vuv1wy7a5derNQGjt2Tf1BoPC14OEISmeS06LSaK+CeLY
 jlMJjjI3N/uKGh1Vh9QQdhxdDuin0N170d3IU/QSOvZmBLnz3YjtipZ+4PECiqT96/Qu0TRvB
 cB7E+glSp0tp7S3O0sC2qbnDflZT1MK1V757Z+6Y4OaVENb8dFvPst/ehKHSS1/kS3raBr1PD
 IZh8YKyg0GlC4k/U2zZABBuUIy8GX9E9H9vX5LzuUDYiyIFSZP88MehX60MalbmAAm9EZejR5
 waZK6EnNO32jorKiiIx9KqPDys422kIY9wVHWOBz/z3iHqRoye+TpuiAMW/xcrwux6IPJa15l
 7PMXzDBU/Jkg3LIj/tojhn6hfiezvcO3HPT75r6Dx//Ndt6fxD7LEOMDgDFe4tHq+Hh8aXBZT
 4b4Tog9yA7xz4DIHji7CIKaxr8AKmU5RdsxZAY2hUJM8bx2jEfmZzMix50/iohCA2dMkl24Np
 nhPbhoULTHst1Dgr3/D6p9EAckJpAHUsn1JH8nnQBDrZM1JLSsK6azG5/DBV0U7j3z0XvtXKN
 08w3bnO5Ztuy0+WNvtpBqotlx1aRzmiWn7O+n8BL2Qn+NkecOP0HlCeLWXeWbS0Jlk/lLS2
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

Copy syscall_64.tbl and syscallhdr.sh from linux/arch/x86/kernel/syscalls v5.5
Update syscallhdr.sh to generate QEMU syscall_nr.h

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-16-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                        |   3 +-
 linux-user/Makefile.objs         |   1 +
 linux-user/x86_64/Makefile.objs  |   5 +
 linux-user/x86_64/syscall_64.tbl | 402 +++++++++++++++++++++++++++++++
 linux-user/x86_64/syscall_nr.h   | 356 ---------------------------
 linux-user/x86_64/syscallhdr.sh  |  28 +++
 6 files changed, 438 insertions(+), 357 deletions(-)
 create mode 100644 linux-user/x86_64/Makefile.objs
 create mode 100644 linux-user/x86_64/syscall_64.tbl
 delete mode 100644 linux-user/x86_64/syscall_nr.h
 create mode 100644 linux-user/x86_64/syscallhdr.sh

diff --git a/configure b/configure
index 84bedad04b21..eda37fd47669 100755
--- a/configure
+++ b/configure
@@ -1890,7 +1890,7 @@ rm -f */config-devices.mak.d
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
 for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc s390x sparc sparc64 \
-    i386 ; do
+    i386 x86_64 ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
@@ -7792,6 +7792,7 @@ case "$target_name" in
   ;;
   x86_64)
     TARGET_BASE_ARCH=i386
+    TARGET_SYSTBL_ABI=common,64
     mttcg="yes"
 	gdb_xml_files="i386-64bit.xml"
   ;;
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 720d9773b813..1791bc48cd17 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -19,4 +19,5 @@ obj-$(TARGET_S390X) += s390x/
 obj-$(TARGET_SH4) += sh4/
 obj-$(TARGET_SPARC) += sparc/
 obj-$(TARGET_SPARC64) += $(TARGET_ABI_DIR)/
+obj-$(TARGET_X86_64) += x86_64/
 obj-$(TARGET_XTENSA) += xtensa/
diff --git a/linux-user/x86_64/Makefile.objs b/linux-user/x86_64/Makefile.objs
new file mode 100644
index 000000000000..2cef1d48becc
--- /dev/null
+++ b/linux-user/x86_64/Makefile.objs
@@ -0,0 +1,5 @@
+generated-files-y += linux-user/x86_64/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/x86_64/syscallhdr.sh
+%/syscall_nr.h: $(SRC_PATH)/linux-user/x86_64/syscall_64.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/x86_64/syscall_64.tbl b/linux-user/x86_64/syscall_64.tbl
new file mode 100644
index 000000000000..c29976eca4a8
--- /dev/null
+++ b/linux-user/x86_64/syscall_64.tbl
@@ -0,0 +1,402 @@
+#
+# 64-bit system call numbers and entry vectors
+#
+# The format is:
+# <number> <abi> <name> <entry point>
+#
+# The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
+#
+# The abi is "common", "64" or "x32" for this file.
+#
+0	common	read			__x64_sys_read
+1	common	write			__x64_sys_write
+2	common	open			__x64_sys_open
+3	common	close			__x64_sys_close
+4	common	stat			__x64_sys_newstat
+5	common	fstat			__x64_sys_newfstat
+6	common	lstat			__x64_sys_newlstat
+7	common	poll			__x64_sys_poll
+8	common	lseek			__x64_sys_lseek
+9	common	mmap			__x64_sys_mmap
+10	common	mprotect		__x64_sys_mprotect
+11	common	munmap			__x64_sys_munmap
+12	common	brk			__x64_sys_brk
+13	64	rt_sigaction		__x64_sys_rt_sigaction
+14	common	rt_sigprocmask		__x64_sys_rt_sigprocmask
+15	64	rt_sigreturn		__x64_sys_rt_sigreturn/ptregs
+16	64	ioctl			__x64_sys_ioctl
+17	common	pread64			__x64_sys_pread64
+18	common	pwrite64		__x64_sys_pwrite64
+19	64	readv			__x64_sys_readv
+20	64	writev			__x64_sys_writev
+21	common	access			__x64_sys_access
+22	common	pipe			__x64_sys_pipe
+23	common	select			__x64_sys_select
+24	common	sched_yield		__x64_sys_sched_yield
+25	common	mremap			__x64_sys_mremap
+26	common	msync			__x64_sys_msync
+27	common	mincore			__x64_sys_mincore
+28	common	madvise			__x64_sys_madvise
+29	common	shmget			__x64_sys_shmget
+30	common	shmat			__x64_sys_shmat
+31	common	shmctl			__x64_sys_shmctl
+32	common	dup			__x64_sys_dup
+33	common	dup2			__x64_sys_dup2
+34	common	pause			__x64_sys_pause
+35	common	nanosleep		__x64_sys_nanosleep
+36	common	getitimer		__x64_sys_getitimer
+37	common	alarm			__x64_sys_alarm
+38	common	setitimer		__x64_sys_setitimer
+39	common	getpid			__x64_sys_getpid
+40	common	sendfile		__x64_sys_sendfile64
+41	common	socket			__x64_sys_socket
+42	common	connect			__x64_sys_connect
+43	common	accept			__x64_sys_accept
+44	common	sendto			__x64_sys_sendto
+45	64	recvfrom		__x64_sys_recvfrom
+46	64	sendmsg			__x64_sys_sendmsg
+47	64	recvmsg			__x64_sys_recvmsg
+48	common	shutdown		__x64_sys_shutdown
+49	common	bind			__x64_sys_bind
+50	common	listen			__x64_sys_listen
+51	common	getsockname		__x64_sys_getsockname
+52	common	getpeername		__x64_sys_getpeername
+53	common	socketpair		__x64_sys_socketpair
+54	64	setsockopt		__x64_sys_setsockopt
+55	64	getsockopt		__x64_sys_getsockopt
+56	common	clone			__x64_sys_clone/ptregs
+57	common	fork			__x64_sys_fork/ptregs
+58	common	vfork			__x64_sys_vfork/ptregs
+59	64	execve			__x64_sys_execve/ptregs
+60	common	exit			__x64_sys_exit
+61	common	wait4			__x64_sys_wait4
+62	common	kill			__x64_sys_kill
+63	common	uname			__x64_sys_newuname
+64	common	semget			__x64_sys_semget
+65	common	semop			__x64_sys_semop
+66	common	semctl			__x64_sys_semctl
+67	common	shmdt			__x64_sys_shmdt
+68	common	msgget			__x64_sys_msgget
+69	common	msgsnd			__x64_sys_msgsnd
+70	common	msgrcv			__x64_sys_msgrcv
+71	common	msgctl			__x64_sys_msgctl
+72	common	fcntl			__x64_sys_fcntl
+73	common	flock			__x64_sys_flock
+74	common	fsync			__x64_sys_fsync
+75	common	fdatasync		__x64_sys_fdatasync
+76	common	truncate		__x64_sys_truncate
+77	common	ftruncate		__x64_sys_ftruncate
+78	common	getdents		__x64_sys_getdents
+79	common	getcwd			__x64_sys_getcwd
+80	common	chdir			__x64_sys_chdir
+81	common	fchdir			__x64_sys_fchdir
+82	common	rename			__x64_sys_rename
+83	common	mkdir			__x64_sys_mkdir
+84	common	rmdir			__x64_sys_rmdir
+85	common	creat			__x64_sys_creat
+86	common	link			__x64_sys_link
+87	common	unlink			__x64_sys_unlink
+88	common	symlink			__x64_sys_symlink
+89	common	readlink		__x64_sys_readlink
+90	common	chmod			__x64_sys_chmod
+91	common	fchmod			__x64_sys_fchmod
+92	common	chown			__x64_sys_chown
+93	common	fchown			__x64_sys_fchown
+94	common	lchown			__x64_sys_lchown
+95	common	umask			__x64_sys_umask
+96	common	gettimeofday		__x64_sys_gettimeofday
+97	common	getrlimit		__x64_sys_getrlimit
+98	common	getrusage		__x64_sys_getrusage
+99	common	sysinfo			__x64_sys_sysinfo
+100	common	times			__x64_sys_times
+101	64	ptrace			__x64_sys_ptrace
+102	common	getuid			__x64_sys_getuid
+103	common	syslog			__x64_sys_syslog
+104	common	getgid			__x64_sys_getgid
+105	common	setuid			__x64_sys_setuid
+106	common	setgid			__x64_sys_setgid
+107	common	geteuid			__x64_sys_geteuid
+108	common	getegid			__x64_sys_getegid
+109	common	setpgid			__x64_sys_setpgid
+110	common	getppid			__x64_sys_getppid
+111	common	getpgrp			__x64_sys_getpgrp
+112	common	setsid			__x64_sys_setsid
+113	common	setreuid		__x64_sys_setreuid
+114	common	setregid		__x64_sys_setregid
+115	common	getgroups		__x64_sys_getgroups
+116	common	setgroups		__x64_sys_setgroups
+117	common	setresuid		__x64_sys_setresuid
+118	common	getresuid		__x64_sys_getresuid
+119	common	setresgid		__x64_sys_setresgid
+120	common	getresgid		__x64_sys_getresgid
+121	common	getpgid			__x64_sys_getpgid
+122	common	setfsuid		__x64_sys_setfsuid
+123	common	setfsgid		__x64_sys_setfsgid
+124	common	getsid			__x64_sys_getsid
+125	common	capget			__x64_sys_capget
+126	common	capset			__x64_sys_capset
+127	64	rt_sigpending		__x64_sys_rt_sigpending
+128	64	rt_sigtimedwait		__x64_sys_rt_sigtimedwait
+129	64	rt_sigqueueinfo		__x64_sys_rt_sigqueueinfo
+130	common	rt_sigsuspend		__x64_sys_rt_sigsuspend
+131	64	sigaltstack		__x64_sys_sigaltstack
+132	common	utime			__x64_sys_utime
+133	common	mknod			__x64_sys_mknod
+134	64	uselib
+135	common	personality		__x64_sys_personality
+136	common	ustat			__x64_sys_ustat
+137	common	statfs			__x64_sys_statfs
+138	common	fstatfs			__x64_sys_fstatfs
+139	common	sysfs			__x64_sys_sysfs
+140	common	getpriority		__x64_sys_getpriority
+141	common	setpriority		__x64_sys_setpriority
+142	common	sched_setparam		__x64_sys_sched_setparam
+143	common	sched_getparam		__x64_sys_sched_getparam
+144	common	sched_setscheduler	__x64_sys_sched_setscheduler
+145	common	sched_getscheduler	__x64_sys_sched_getscheduler
+146	common	sched_get_priority_max	__x64_sys_sched_get_priority_max
+147	common	sched_get_priority_min	__x64_sys_sched_get_priority_min
+148	common	sched_rr_get_interval	__x64_sys_sched_rr_get_interval
+149	common	mlock			__x64_sys_mlock
+150	common	munlock			__x64_sys_munlock
+151	common	mlockall		__x64_sys_mlockall
+152	common	munlockall		__x64_sys_munlockall
+153	common	vhangup			__x64_sys_vhangup
+154	common	modify_ldt		__x64_sys_modify_ldt
+155	common	pivot_root		__x64_sys_pivot_root
+156	64	_sysctl			__x64_sys_sysctl
+157	common	prctl			__x64_sys_prctl
+158	common	arch_prctl		__x64_sys_arch_prctl
+159	common	adjtimex		__x64_sys_adjtimex
+160	common	setrlimit		__x64_sys_setrlimit
+161	common	chroot			__x64_sys_chroot
+162	common	sync			__x64_sys_sync
+163	common	acct			__x64_sys_acct
+164	common	settimeofday		__x64_sys_settimeofday
+165	common	mount			__x64_sys_mount
+166	common	umount2			__x64_sys_umount
+167	common	swapon			__x64_sys_swapon
+168	common	swapoff			__x64_sys_swapoff
+169	common	reboot			__x64_sys_reboot
+170	common	sethostname		__x64_sys_sethostname
+171	common	setdomainname		__x64_sys_setdomainname
+172	common	iopl			__x64_sys_iopl/ptregs
+173	common	ioperm			__x64_sys_ioperm
+174	64	create_module
+175	common	init_module		__x64_sys_init_module
+176	common	delete_module		__x64_sys_delete_module
+177	64	get_kernel_syms
+178	64	query_module
+179	common	quotactl		__x64_sys_quotactl
+180	64	nfsservctl
+181	common	getpmsg
+182	common	putpmsg
+183	common	afs_syscall
+184	common	tuxcall
+185	common	security
+186	common	gettid			__x64_sys_gettid
+187	common	readahead		__x64_sys_readahead
+188	common	setxattr		__x64_sys_setxattr
+189	common	lsetxattr		__x64_sys_lsetxattr
+190	common	fsetxattr		__x64_sys_fsetxattr
+191	common	getxattr		__x64_sys_getxattr
+192	common	lgetxattr		__x64_sys_lgetxattr
+193	common	fgetxattr		__x64_sys_fgetxattr
+194	common	listxattr		__x64_sys_listxattr
+195	common	llistxattr		__x64_sys_llistxattr
+196	common	flistxattr		__x64_sys_flistxattr
+197	common	removexattr		__x64_sys_removexattr
+198	common	lremovexattr		__x64_sys_lremovexattr
+199	common	fremovexattr		__x64_sys_fremovexattr
+200	common	tkill			__x64_sys_tkill
+201	common	time			__x64_sys_time
+202	common	futex			__x64_sys_futex
+203	common	sched_setaffinity	__x64_sys_sched_setaffinity
+204	common	sched_getaffinity	__x64_sys_sched_getaffinity
+205	64	set_thread_area
+206	64	io_setup		__x64_sys_io_setup
+207	common	io_destroy		__x64_sys_io_destroy
+208	common	io_getevents		__x64_sys_io_getevents
+209	64	io_submit		__x64_sys_io_submit
+210	common	io_cancel		__x64_sys_io_cancel
+211	64	get_thread_area
+212	common	lookup_dcookie		__x64_sys_lookup_dcookie
+213	common	epoll_create		__x64_sys_epoll_create
+214	64	epoll_ctl_old
+215	64	epoll_wait_old
+216	common	remap_file_pages	__x64_sys_remap_file_pages
+217	common	getdents64		__x64_sys_getdents64
+218	common	set_tid_address		__x64_sys_set_tid_address
+219	common	restart_syscall		__x64_sys_restart_syscall
+220	common	semtimedop		__x64_sys_semtimedop
+221	common	fadvise64		__x64_sys_fadvise64
+222	64	timer_create		__x64_sys_timer_create
+223	common	timer_settime		__x64_sys_timer_settime
+224	common	timer_gettime		__x64_sys_timer_gettime
+225	common	timer_getoverrun	__x64_sys_timer_getoverrun
+226	common	timer_delete		__x64_sys_timer_delete
+227	common	clock_settime		__x64_sys_clock_settime
+228	common	clock_gettime		__x64_sys_clock_gettime
+229	common	clock_getres		__x64_sys_clock_getres
+230	common	clock_nanosleep		__x64_sys_clock_nanosleep
+231	common	exit_group		__x64_sys_exit_group
+232	common	epoll_wait		__x64_sys_epoll_wait
+233	common	epoll_ctl		__x64_sys_epoll_ctl
+234	common	tgkill			__x64_sys_tgkill
+235	common	utimes			__x64_sys_utimes
+236	64	vserver
+237	common	mbind			__x64_sys_mbind
+238	common	set_mempolicy		__x64_sys_set_mempolicy
+239	common	get_mempolicy		__x64_sys_get_mempolicy
+240	common	mq_open			__x64_sys_mq_open
+241	common	mq_unlink		__x64_sys_mq_unlink
+242	common	mq_timedsend		__x64_sys_mq_timedsend
+243	common	mq_timedreceive		__x64_sys_mq_timedreceive
+244	64	mq_notify		__x64_sys_mq_notify
+245	common	mq_getsetattr		__x64_sys_mq_getsetattr
+246	64	kexec_load		__x64_sys_kexec_load
+247	64	waitid			__x64_sys_waitid
+248	common	add_key			__x64_sys_add_key
+249	common	request_key		__x64_sys_request_key
+250	common	keyctl			__x64_sys_keyctl
+251	common	ioprio_set		__x64_sys_ioprio_set
+252	common	ioprio_get		__x64_sys_ioprio_get
+253	common	inotify_init		__x64_sys_inotify_init
+254	common	inotify_add_watch	__x64_sys_inotify_add_watch
+255	common	inotify_rm_watch	__x64_sys_inotify_rm_watch
+256	common	migrate_pages		__x64_sys_migrate_pages
+257	common	openat			__x64_sys_openat
+258	common	mkdirat			__x64_sys_mkdirat
+259	common	mknodat			__x64_sys_mknodat
+260	common	fchownat		__x64_sys_fchownat
+261	common	futimesat		__x64_sys_futimesat
+262	common	newfstatat		__x64_sys_newfstatat
+263	common	unlinkat		__x64_sys_unlinkat
+264	common	renameat		__x64_sys_renameat
+265	common	linkat			__x64_sys_linkat
+266	common	symlinkat		__x64_sys_symlinkat
+267	common	readlinkat		__x64_sys_readlinkat
+268	common	fchmodat		__x64_sys_fchmodat
+269	common	faccessat		__x64_sys_faccessat
+270	common	pselect6		__x64_sys_pselect6
+271	common	ppoll			__x64_sys_ppoll
+272	common	unshare			__x64_sys_unshare
+273	64	set_robust_list		__x64_sys_set_robust_list
+274	64	get_robust_list		__x64_sys_get_robust_list
+275	common	splice			__x64_sys_splice
+276	common	tee			__x64_sys_tee
+277	common	sync_file_range		__x64_sys_sync_file_range
+278	64	vmsplice		__x64_sys_vmsplice
+279	64	move_pages		__x64_sys_move_pages
+280	common	utimensat		__x64_sys_utimensat
+281	common	epoll_pwait		__x64_sys_epoll_pwait
+282	common	signalfd		__x64_sys_signalfd
+283	common	timerfd_create		__x64_sys_timerfd_create
+284	common	eventfd			__x64_sys_eventfd
+285	common	fallocate		__x64_sys_fallocate
+286	common	timerfd_settime		__x64_sys_timerfd_settime
+287	common	timerfd_gettime		__x64_sys_timerfd_gettime
+288	common	accept4			__x64_sys_accept4
+289	common	signalfd4		__x64_sys_signalfd4
+290	common	eventfd2		__x64_sys_eventfd2
+291	common	epoll_create1		__x64_sys_epoll_create1
+292	common	dup3			__x64_sys_dup3
+293	common	pipe2			__x64_sys_pipe2
+294	common	inotify_init1		__x64_sys_inotify_init1
+295	64	preadv			__x64_sys_preadv
+296	64	pwritev			__x64_sys_pwritev
+297	64	rt_tgsigqueueinfo	__x64_sys_rt_tgsigqueueinfo
+298	common	perf_event_open		__x64_sys_perf_event_open
+299	64	recvmmsg		__x64_sys_recvmmsg
+300	common	fanotify_init		__x64_sys_fanotify_init
+301	common	fanotify_mark		__x64_sys_fanotify_mark
+302	common	prlimit64		__x64_sys_prlimit64
+303	common	name_to_handle_at	__x64_sys_name_to_handle_at
+304	common	open_by_handle_at	__x64_sys_open_by_handle_at
+305	common	clock_adjtime		__x64_sys_clock_adjtime
+306	common	syncfs			__x64_sys_syncfs
+307	64	sendmmsg		__x64_sys_sendmmsg
+308	common	setns			__x64_sys_setns
+309	common	getcpu			__x64_sys_getcpu
+310	64	process_vm_readv	__x64_sys_process_vm_readv
+311	64	process_vm_writev	__x64_sys_process_vm_writev
+312	common	kcmp			__x64_sys_kcmp
+313	common	finit_module		__x64_sys_finit_module
+314	common	sched_setattr		__x64_sys_sched_setattr
+315	common	sched_getattr		__x64_sys_sched_getattr
+316	common	renameat2		__x64_sys_renameat2
+317	common	seccomp			__x64_sys_seccomp
+318	common	getrandom		__x64_sys_getrandom
+319	common	memfd_create		__x64_sys_memfd_create
+320	common	kexec_file_load		__x64_sys_kexec_file_load
+321	common	bpf			__x64_sys_bpf
+322	64	execveat		__x64_sys_execveat/ptregs
+323	common	userfaultfd		__x64_sys_userfaultfd
+324	common	membarrier		__x64_sys_membarrier
+325	common	mlock2			__x64_sys_mlock2
+326	common	copy_file_range		__x64_sys_copy_file_range
+327	64	preadv2			__x64_sys_preadv2
+328	64	pwritev2		__x64_sys_pwritev2
+329	common	pkey_mprotect		__x64_sys_pkey_mprotect
+330	common	pkey_alloc		__x64_sys_pkey_alloc
+331	common	pkey_free		__x64_sys_pkey_free
+332	common	statx			__x64_sys_statx
+333	common	io_pgetevents		__x64_sys_io_pgetevents
+334	common	rseq			__x64_sys_rseq
+# don't use numbers 387 through 423, add new calls after the last
+# 'common' entry
+424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
+425	common	io_uring_setup		__x64_sys_io_uring_setup
+426	common	io_uring_enter		__x64_sys_io_uring_enter
+427	common	io_uring_register	__x64_sys_io_uring_register
+428	common	open_tree		__x64_sys_open_tree
+429	common	move_mount		__x64_sys_move_mount
+430	common	fsopen			__x64_sys_fsopen
+431	common	fsconfig		__x64_sys_fsconfig
+432	common	fsmount			__x64_sys_fsmount
+433	common	fspick			__x64_sys_fspick
+434	common	pidfd_open		__x64_sys_pidfd_open
+435	common	clone3			__x64_sys_clone3/ptregs
+
+#
+# x32-specific system call numbers start at 512 to avoid cache impact
+# for native 64-bit operation. The __x32_compat_sys stubs are created
+# on-the-fly for compat_sys_*() compatibility system calls if X86_X32
+# is defined.
+#
+512	x32	rt_sigaction		__x32_compat_sys_rt_sigaction
+513	x32	rt_sigreturn		sys32_x32_rt_sigreturn
+514	x32	ioctl			__x32_compat_sys_ioctl
+515	x32	readv			__x32_compat_sys_readv
+516	x32	writev			__x32_compat_sys_writev
+517	x32	recvfrom		__x32_compat_sys_recvfrom
+518	x32	sendmsg			__x32_compat_sys_sendmsg
+519	x32	recvmsg			__x32_compat_sys_recvmsg
+520	x32	execve			__x32_compat_sys_execve/ptregs
+521	x32	ptrace			__x32_compat_sys_ptrace
+522	x32	rt_sigpending		__x32_compat_sys_rt_sigpending
+523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait_time64
+524	x32	rt_sigqueueinfo		__x32_compat_sys_rt_sigqueueinfo
+525	x32	sigaltstack		__x32_compat_sys_sigaltstack
+526	x32	timer_create		__x32_compat_sys_timer_create
+527	x32	mq_notify		__x32_compat_sys_mq_notify
+528	x32	kexec_load		__x32_compat_sys_kexec_load
+529	x32	waitid			__x32_compat_sys_waitid
+530	x32	set_robust_list		__x32_compat_sys_set_robust_list
+531	x32	get_robust_list		__x32_compat_sys_get_robust_list
+532	x32	vmsplice		__x32_compat_sys_vmsplice
+533	x32	move_pages		__x32_compat_sys_move_pages
+534	x32	preadv			__x32_compat_sys_preadv64
+535	x32	pwritev			__x32_compat_sys_pwritev64
+536	x32	rt_tgsigqueueinfo	__x32_compat_sys_rt_tgsigqueueinfo
+537	x32	recvmmsg		__x32_compat_sys_recvmmsg_time64
+538	x32	sendmmsg		__x32_compat_sys_sendmmsg
+539	x32	process_vm_readv	__x32_compat_sys_process_vm_readv
+540	x32	process_vm_writev	__x32_compat_sys_process_vm_writev
+541	x32	setsockopt		__x32_compat_sys_setsockopt
+542	x32	getsockopt		__x32_compat_sys_getsockopt
+543	x32	io_setup		__x32_compat_sys_io_setup
+544	x32	io_submit		__x32_compat_sys_io_submit
+545	x32	execveat		__x32_compat_sys_execveat/ptregs
+546	x32	preadv2			__x32_compat_sys_preadv64v2
+547	x32	pwritev2		__x32_compat_sys_pwritev64v2
diff --git a/linux-user/x86_64/syscall_nr.h b/linux-user/x86_64/syscall_nr.h
deleted file mode 100644
index e5d14eca223d..000000000000
--- a/linux-user/x86_64/syscall_nr.h
+++ /dev/null
@@ -1,356 +0,0 @@
-#ifndef LINUX_USER_X86_64_SYSCALL_NR_H
-#define LINUX_USER_X86_64_SYSCALL_NR_H
-
-#define TARGET_NR_read                                0
-#define TARGET_NR_write                               1
-#define TARGET_NR_open                                2
-#define TARGET_NR_close                               3
-#define TARGET_NR_stat                                4
-#define TARGET_NR_fstat                               5
-#define TARGET_NR_lstat                               6
-#define TARGET_NR_poll                                7
-#define TARGET_NR_lseek                               8
-#define TARGET_NR_mmap                                9
-#define TARGET_NR_mprotect                           10
-#define TARGET_NR_munmap                             11
-#define TARGET_NR_brk                                12
-#define TARGET_NR_rt_sigaction                       13
-#define TARGET_NR_rt_sigprocmask                     14
-#define TARGET_NR_rt_sigreturn                       15
-#define TARGET_NR_ioctl                              16
-#define TARGET_NR_pread64                            17
-#define TARGET_NR_pwrite64                           18
-#define TARGET_NR_readv                              19
-#define TARGET_NR_writev                             20
-#define TARGET_NR_access                             21
-#define TARGET_NR_pipe                               22
-#define TARGET_NR_select                             23
-#define TARGET_NR_sched_yield                        24
-#define TARGET_NR_mremap                             25
-#define TARGET_NR_msync                              26
-#define TARGET_NR_mincore                            27
-#define TARGET_NR_madvise                            28
-#define TARGET_NR_shmget                             29
-#define TARGET_NR_shmat                              30
-#define TARGET_NR_shmctl                             31
-#define TARGET_NR_dup                                32
-#define TARGET_NR_dup2                               33
-#define TARGET_NR_pause                              34
-#define TARGET_NR_nanosleep                          35
-#define TARGET_NR_getitimer                          36
-#define TARGET_NR_alarm                              37
-#define TARGET_NR_setitimer                          38
-#define TARGET_NR_getpid                             39
-#define TARGET_NR_sendfile                           40
-#define TARGET_NR_socket                             41
-#define TARGET_NR_connect                            42
-#define TARGET_NR_accept                             43
-#define TARGET_NR_sendto                             44
-#define TARGET_NR_recvfrom                           45
-#define TARGET_NR_sendmsg                            46
-#define TARGET_NR_recvmsg                            47
-#define TARGET_NR_shutdown                           48
-#define TARGET_NR_bind                               49
-#define TARGET_NR_listen                             50
-#define TARGET_NR_getsockname                        51
-#define TARGET_NR_getpeername                        52
-#define TARGET_NR_socketpair                         53
-#define TARGET_NR_setsockopt                         54
-#define TARGET_NR_getsockopt                         55
-#define TARGET_NR_clone                              56
-#define TARGET_NR_fork                               57
-#define TARGET_NR_vfork                              58
-#define TARGET_NR_execve                             59
-#define TARGET_NR_exit                               60
-#define TARGET_NR_wait4                              61
-#define TARGET_NR_kill                               62
-#define TARGET_NR_uname                              63
-#define TARGET_NR_semget                             64
-#define TARGET_NR_semop                              65
-#define TARGET_NR_semctl                             66
-#define TARGET_NR_shmdt                              67
-#define TARGET_NR_msgget                             68
-#define TARGET_NR_msgsnd                             69
-#define TARGET_NR_msgrcv                             70
-#define TARGET_NR_msgctl                             71
-#define TARGET_NR_fcntl                              72
-#define TARGET_NR_flock                              73
-#define TARGET_NR_fsync                              74
-#define TARGET_NR_fdatasync                          75
-#define TARGET_NR_truncate                           76
-#define TARGET_NR_ftruncate                          77
-#define TARGET_NR_getdents                           78
-#define TARGET_NR_getcwd                             79
-#define TARGET_NR_chdir                              80
-#define TARGET_NR_fchdir                             81
-#define TARGET_NR_rename                             82
-#define TARGET_NR_mkdir                              83
-#define TARGET_NR_rmdir                              84
-#define TARGET_NR_creat                              85
-#define TARGET_NR_link                               86
-#define TARGET_NR_unlink                             87
-#define TARGET_NR_symlink                            88
-#define TARGET_NR_readlink                           89
-#define TARGET_NR_chmod                              90
-#define TARGET_NR_fchmod                             91
-#define TARGET_NR_chown                              92
-#define TARGET_NR_fchown                             93
-#define TARGET_NR_lchown                             94
-#define TARGET_NR_umask                              95
-#define TARGET_NR_gettimeofday                       96
-#define TARGET_NR_getrlimit                          97
-#define TARGET_NR_getrusage                          98
-#define TARGET_NR_sysinfo                            99
-#define TARGET_NR_times                             100
-#define TARGET_NR_ptrace                            101
-#define TARGET_NR_getuid                            102
-#define TARGET_NR_syslog                            103
-#define TARGET_NR_getgid                            104
-#define TARGET_NR_setuid                            105
-#define TARGET_NR_setgid                            106
-#define TARGET_NR_geteuid                           107
-#define TARGET_NR_getegid                           108
-#define TARGET_NR_setpgid                           109
-#define TARGET_NR_getppid                           110
-#define TARGET_NR_getpgrp                           111
-#define TARGET_NR_setsid                            112
-#define TARGET_NR_setreuid                          113
-#define TARGET_NR_setregid                          114
-#define TARGET_NR_getgroups                         115
-#define TARGET_NR_setgroups                         116
-#define TARGET_NR_setresuid                         117
-#define TARGET_NR_getresuid                         118
-#define TARGET_NR_setresgid                         119
-#define TARGET_NR_getresgid                         120
-#define TARGET_NR_getpgid                           121
-#define TARGET_NR_setfsuid                          122
-#define TARGET_NR_setfsgid                          123
-#define TARGET_NR_getsid                            124
-#define TARGET_NR_capget                            125
-#define TARGET_NR_capset                            126
-#define TARGET_NR_rt_sigpending                     127
-#define TARGET_NR_rt_sigtimedwait                   128
-#define TARGET_NR_rt_sigqueueinfo                   129
-#define TARGET_NR_rt_sigsuspend                     130
-#define TARGET_NR_sigaltstack                       131
-#define TARGET_NR_utime                             132
-#define TARGET_NR_mknod                             133
-#define TARGET_NR_uselib                            134
-#define TARGET_NR_personality                       135
-#define TARGET_NR_ustat                             136
-#define TARGET_NR_statfs                            137
-#define TARGET_NR_fstatfs                           138
-#define TARGET_NR_sysfs                             139
-#define TARGET_NR_getpriority                       140
-#define TARGET_NR_setpriority                       141
-#define TARGET_NR_sched_setparam                    142
-#define TARGET_NR_sched_getparam                    143
-#define TARGET_NR_sched_setscheduler                144
-#define TARGET_NR_sched_getscheduler                145
-#define TARGET_NR_sched_get_priority_max            146
-#define TARGET_NR_sched_get_priority_min            147
-#define TARGET_NR_sched_rr_get_interval             148
-#define TARGET_NR_mlock                             149
-#define TARGET_NR_munlock                           150
-#define TARGET_NR_mlockall                          151
-#define TARGET_NR_munlockall                        152
-#define TARGET_NR_vhangup                           153
-#define TARGET_NR_modify_ldt                        154
-#define TARGET_NR_pivot_root                        155
-#define TARGET_NR__sysctl                           156
-#define TARGET_NR_prctl                             157
-#define TARGET_NR_arch_prctl                        158
-#define TARGET_NR_adjtimex                          159
-#define TARGET_NR_setrlimit                         160
-#define TARGET_NR_chroot                            161
-#define TARGET_NR_sync                              162
-#define TARGET_NR_acct                              163
-#define TARGET_NR_settimeofday                      164
-#define TARGET_NR_mount                             165
-#define TARGET_NR_umount2                           166
-#define TARGET_NR_swapon                            167
-#define TARGET_NR_swapoff                           168
-#define TARGET_NR_reboot                            169
-#define TARGET_NR_sethostname                       170
-#define TARGET_NR_setdomainname                     171
-#define TARGET_NR_iopl                              172
-#define TARGET_NR_ioperm                            173
-#define TARGET_NR_create_module                     174
-#define TARGET_NR_init_module                       175
-#define TARGET_NR_delete_module                     176
-#define TARGET_NR_get_kernel_syms                   177
-#define TARGET_NR_query_module                      178
-#define TARGET_NR_quotactl                          179
-#define TARGET_NR_nfsservctl                        180
-#define TARGET_NR_getpmsg                           181	/* reserved for LiS/STREAMS */
-#define TARGET_NR_putpmsg                           182	/* reserved for LiS/STREAMS */
-#define TARGET_NR_afs_syscall                       183	/* reserved for AFS */
-#define TARGET_NR_tuxcall      		184 /* reserved for tux */
-#define TARGET_NR_security			185
-#define TARGET_NR_gettid		186
-#define TARGET_NR_readahead		187
-#define TARGET_NR_setxattr		188
-#define TARGET_NR_lsetxattr		189
-#define TARGET_NR_fsetxattr		190
-#define TARGET_NR_getxattr		191
-#define TARGET_NR_lgetxattr		192
-#define TARGET_NR_fgetxattr		193
-#define TARGET_NR_listxattr		194
-#define TARGET_NR_llistxattr		195
-#define TARGET_NR_flistxattr		196
-#define TARGET_NR_removexattr	197
-#define TARGET_NR_lremovexattr	198
-#define TARGET_NR_fremovexattr	199
-#define TARGET_NR_tkill	200
-#define TARGET_NR_time      201
-#define TARGET_NR_futex     202
-#define TARGET_NR_sched_setaffinity    203
-#define TARGET_NR_sched_getaffinity     204
-#define TARGET_NR_set_thread_area	205
-#define TARGET_NR_io_setup	206
-#define TARGET_NR_io_destroy	207
-#define TARGET_NR_io_getevents	208
-#define TARGET_NR_io_submit	209
-#define TARGET_NR_io_cancel	210
-#define TARGET_NR_get_thread_area	211
-#define TARGET_NR_lookup_dcookie	212
-#define TARGET_NR_epoll_create	213
-#define TARGET_NR_epoll_ctl_old	214
-#define TARGET_NR_epoll_wait_old	215
-#define TARGET_NR_remap_file_pages	216
-#define TARGET_NR_getdents64	217
-#define TARGET_NR_set_tid_address	218
-#define TARGET_NR_restart_syscall	219
-#define TARGET_NR_semtimedop		220
-#define TARGET_NR_fadvise64		221
-#define TARGET_NR_timer_create		222
-#define TARGET_NR_timer_settime		223
-#define TARGET_NR_timer_gettime		224
-#define TARGET_NR_timer_getoverrun		225
-#define TARGET_NR_timer_delete	226
-#define TARGET_NR_clock_settime	227
-#define TARGET_NR_clock_gettime	228
-#define TARGET_NR_clock_getres	229
-#define TARGET_NR_clock_nanosleep	230
-#define TARGET_NR_exit_group		231
-#define TARGET_NR_epoll_wait		232
-#define TARGET_NR_epoll_ctl		233
-#define TARGET_NR_tgkill		234
-#define TARGET_NR_utimes		235
-#define TARGET_NR_vserver		236
-#define TARGET_NR_mbind 		237
-#define TARGET_NR_set_mempolicy 	238
-#define TARGET_NR_get_mempolicy 	239
-#define TARGET_NR_mq_open 		240
-#define TARGET_NR_mq_unlink 		241
-#define TARGET_NR_mq_timedsend 	242
-#define TARGET_NR_mq_timedreceive	243
-#define TARGET_NR_mq_notify 		244
-#define TARGET_NR_mq_getsetattr 	245
-#define TARGET_NR_kexec_load 	246
-#define TARGET_NR_waitid		247
-#define TARGET_NR_add_key		248
-#define TARGET_NR_request_key	249
-#define TARGET_NR_keyctl		250
-#define TARGET_NR_ioprio_set		251
-#define TARGET_NR_ioprio_get		252
-#define TARGET_NR_inotify_init	253
-#define TARGET_NR_inotify_add_watch	254
-#define TARGET_NR_inotify_rm_watch	255
-#define TARGET_NR_migrate_pages	256
-#define TARGET_NR_openat		257
-#define TARGET_NR_mkdirat		258
-#define TARGET_NR_mknodat		259
-#define TARGET_NR_fchownat		260
-#define TARGET_NR_futimesat		261
-#define TARGET_NR_newfstatat		262
-#define TARGET_NR_unlinkat		263
-#define TARGET_NR_renameat		264
-#define TARGET_NR_linkat		265
-#define TARGET_NR_symlinkat		266
-#define TARGET_NR_readlinkat		267
-#define TARGET_NR_fchmodat		268
-#define TARGET_NR_faccessat		269
-#define TARGET_NR_pselect6		270
-#define TARGET_NR_ppoll		271
-#define TARGET_NR_unshare		272
-#define TARGET_NR_set_robust_list	273
-#define TARGET_NR_get_robust_list	274
-#define TARGET_NR_splice		275
-#define TARGET_NR_tee		276
-#define TARGET_NR_sync_file_range	277
-#define TARGET_NR_vmsplice		278
-#define TARGET_NR_move_pages		279
-#define TARGET_NR_utimensat		280
-#define TARGET_NR_epoll_pwait	281
-#define TARGET_NR_signalfd		282
-#define TARGET_NR_timerfd_create	283
-#define TARGET_NR_eventfd		284
-#define TARGET_NR_fallocate		285
-#define TARGET_NR_timerfd_settime	286
-#define TARGET_NR_timerfd_gettime	287
-#define TARGET_NR_accept4		288
-#define TARGET_NR_signalfd4		289
-#define TARGET_NR_eventfd2		290
-#define TARGET_NR_epoll_create1	291
-#define TARGET_NR_dup3			292
-#define TARGET_NR_pipe2		293
-#define TARGET_NR_inotify_init1	294
-#define TARGET_NR_preadv                295
-#define TARGET_NR_pwritev               296
-#define TARGET_NR_rt_tgsigqueueinfo     297
-#define TARGET_NR_perf_event_open       298
-#define TARGET_NR_recvmmsg              299
-#define TARGET_NR_fanotify_init         300
-#define TARGET_NR_fanotify_mark         301
-#define TARGET_NR_prlimit64             302
-#define TARGET_NR_name_to_handle_at     303
-#define TARGET_NR_open_by_handle_at     304
-#define TARGET_NR_clock_adjtime         305
-#define TARGET_NR_syncfs                306
-#define TARGET_NR_sendmmsg              307
-#define TARGET_NR_setns                 308
-#define TARGET_NR_getcpu                309
-#define TARGET_NR_process_vm_readv      310
-#define TARGET_NR_process_vm_writev     311
-#define TARGET_NR_kcmp                  312
-#define TARGET_NR_finit_module          313
-#define TARGET_NR_sched_setattr         314
-#define TARGET_NR_sched_getattr         315
-#define TARGET_NR_renameat2             316
-#define TARGET_NR_seccomp               317
-#define TARGET_NR_getrandom             318
-#define TARGET_NR_memfd_create          319
-#define TARGET_NR_kexec_file_load       320
-#define TARGET_NR_bpf                   321
-#define TARGET_NR_execveat              322
-#define TARGET_NR_userfaultfd           323
-#define TARGET_NR_membarrier            324
-#define TARGET_NR_mlock2                325
-#define TARGET_NR_copy_file_range       326
-#define TARGET_NR_preadv2               327
-#define TARGET_NR_pwritev2              328
-#define TARGET_NR_pkey_mprotect         329
-#define TARGET_NR_pkey_alloc            330
-#define TARGET_NR_pkey_free             331
-#define TARGET_NR_statx                 332
-#define TARGET_NR_io_pgetevents         333
-#define TARGET_NR_rseq                  334
-/*
- * don't use numbers 387 through 423, add new calls after the last
- * 'common' entry
- */
-#define TARGET_NR_pidfd_send_signal     424
-#define TARGET_NR_io_uring_setup        425
-#define TARGET_NR_io_uring_enter        426
-#define TARGET_NR_io_uring_register     427
-#define TARGET_NR_open_tree             428
-#define TARGET_NR_move_mount            429
-#define TARGET_NR_fsopen                430
-#define TARGET_NR_fsconfig              431
-#define TARGET_NR_fsmount               432
-#define TARGET_NR_fspick                433
-#define TARGET_NR_pidfd_open            434
-#define TARGET_NR_clone3                435
-
-#endif
diff --git a/linux-user/x86_64/syscallhdr.sh b/linux-user/x86_64/syscallhdr.sh
new file mode 100644
index 000000000000..182be52a74f5
--- /dev/null
+++ b/linux-user/x86_64/syscallhdr.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+prefix="$4"
+offset="$5"
+
+fileguard=LINUX_USER_X86_64_`basename "$out" | sed \
+    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
+    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
+    echo "#ifndef ${fileguard}"
+    echo "#define ${fileguard} 1"
+    echo ""
+
+    while read nr abi name entry ; do
+    if [ -z "$offset" ]; then
+        echo "#define TARGET_NR_${prefix}${name} $nr"
+    else
+        echo "#define TARGET_NR_${prefix}${name} ($offset + $nr)"
+        fi
+    done
+
+    echo ""
+    echo "#endif /* ${fileguard} */"
+) > "$out"
-- 
2.25.1


