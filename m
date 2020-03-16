Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B735C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F058620674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F058620674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuDM-00064g-5b
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsQB-00084E-FP
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsQ6-0004WS-Vf
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:55 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:55897)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsQ6-0004Gg-H5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:50 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MzCMN-1jYzwM1n8d-00wF4u; Mon, 16 Mar 2020 17:16:38 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 27/38] linux-user, i386: add syscall table generation support
Date: Mon, 16 Mar 2020 17:15:39 +0100
Message-Id: <20200316161550.336150-28-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iVEe7mysu3pCXfP9wm7+C3ivj67ICdaNeJ5nTdX1Xna6KN97kQ5
 6v0+mUZfaYHVIGgAe6TcZVq2d0ahlXcXq0Za2kwKJX9lGa+AiH1JFJl6Be2XuUHV4la3Wvk
 c+0WhsFAnrejfSNFerr9y19w/6i9Am1Uyw7XpIsJKQW8C4HCecsOK9yuwnYvotIJqnhl7RA
 p9puGf2pIxYy0AFZgzSNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vaJDGwGkq24=:5EcHid/4DuNLmx6+nKjkQZ
 5t10inJgtjjJ7ZFvoVL1kQ6SSe/KS3tbKoJxA5PEzcACUMxhiu2JqNmn+jCchjHC3EPgFP2Cy
 VSPecFx9UblNyYJDFo5mcV8dX870jUk05UdJ2ko34bWbBCF/AjpUErTUsX8+Fgp81AGUWJbpy
 xtLA6yKixN2ZKXPmcjsDekiYpFBIjLpa+AMuKuVIas1PlH9U6wz2PdBMsQc5zmZFimvkPDWyj
 8kPWBjW81Qm8x4j9YTWW2w8c6LKgBvINX18AFD8Va/k5DpyqLSPzfJO3C9xDkPXGgKqNIuMxb
 oNfFfbnf3usvl8Yg1Ps1/OTIZ4hZzEaFMYYBf4N8xJJTxkDEKUiHsLktcOcuHP7sXNwhUyKzC
 sdIlgNKvVuNLKxaVvW6smyLgvWvnsjFpfLKGFJR6FlyTKQJfwaYochv042RsScLftDeNXDC8+
 e4TiA1crBsixFDS7A6duP+OtPvDc6dhwXRJd20c35CONkQx1HPi1stZnBbOD9zl4uiMNvStXi
 Lt0yMUnwOshx0WYCdxmtT/+IVcM4or4WUDQUeaMqBOUOStNfXH99t2nfsqOCUikV8nbp1wK2q
 zm8wDqIWYeObErhD5cBWhdFJ2PItk7qbK+CCLsrMM2UnpYjZv08SC9DvZ/Fr9I8UlyVqxMHZ/
 mmw4LIwchJIxAjvs0/D7B6B8JUW99wg/Ld98TA8URFip7uzYAY5bt7RpP1TKAiQN2Da3OrTuy
 dz/F1slGF5H6HTsUAmGOnG2JFsJKQPlVnfTcfEfCmWZ3wUv1t4KcJV1TPgGAMoMOVNaWC3cRV
 TP4+LIWWHXFopGU9RTadJuWHWt49n1kJf8pzhon7CjtyzArYp9gpnMVy0MUKMFGTLRZ15kt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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

Copy syscall_32.tbl and syscallhdr.sh from linux/arch/x86/kernel/syscalls v5.5
Update syscallhdr.sh to generate QEMU syscall_nr.h

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-15-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                      |   3 +-
 linux-user/Makefile.objs       |   1 +
 linux-user/i386/Makefile.objs  |   5 +
 linux-user/i386/syscall_32.tbl | 442 +++++++++++++++++++++++++++++++++
 linux-user/i386/syscall_nr.h   | 387 -----------------------------
 linux-user/i386/syscallhdr.sh  |  28 +++
 6 files changed, 478 insertions(+), 388 deletions(-)
 create mode 100644 linux-user/i386/Makefile.objs
 create mode 100644 linux-user/i386/syscall_32.tbl
 delete mode 100644 linux-user/i386/syscall_nr.h
 create mode 100644 linux-user/i386/syscallhdr.sh

diff --git a/configure b/configure
index 0f063c368f2a..84bedad04b21 100755
--- a/configure
+++ b/configure
@@ -1890,7 +1890,7 @@ rm -f */config-devices.mak.d
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
 for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc s390x sparc sparc64 \
-    ; do
+    i386 ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
@@ -7788,6 +7788,7 @@ case "$target_name" in
   i386)
     mttcg="yes"
 	gdb_xml_files="i386-32bit.xml"
+    TARGET_SYSTBL_ABI=i386
   ;;
   x86_64)
     TARGET_BASE_ARCH=i386
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 36f20cad794c..720d9773b813 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -10,6 +10,7 @@ obj-$(TARGET_AARCH64) += arm/semihost.o
 obj-$(TARGET_ALPHA) += alpha/
 obj-$(TARGET_ARM) += arm/
 obj-$(TARGET_HPPA) += hppa/
+obj-$(TARGET_I386) += i386/
 obj-$(TARGET_M68K) += m68k/
 obj-$(TARGET_MICROBLAZE) += microblaze/
 obj-$(TARGET_PPC) += ppc/
diff --git a/linux-user/i386/Makefile.objs b/linux-user/i386/Makefile.objs
new file mode 100644
index 000000000000..c25cf17bfb64
--- /dev/null
+++ b/linux-user/i386/Makefile.objs
@@ -0,0 +1,5 @@
+generated-files-y += linux-user/i386/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/i386/syscallhdr.sh
+%/syscall_nr.h: $(SRC_PATH)/linux-user/i386/syscall_32.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/i386/syscall_32.tbl b/linux-user/i386/syscall_32.tbl
new file mode 100644
index 000000000000..15908eb9b17e
--- /dev/null
+++ b/linux-user/i386/syscall_32.tbl
@@ -0,0 +1,442 @@
+#
+# 32-bit system call numbers and entry vectors
+#
+# The format is:
+# <number> <abi> <name> <entry point> <compat entry point>
+#
+# The __ia32_sys and __ia32_compat_sys stubs are created on-the-fly for
+# sys_*() system calls and compat_sys_*() compat system calls if
+# IA32_EMULATION is defined, and expect struct pt_regs *regs as their only
+# parameter.
+#
+# The abi is always "i386" for this file.
+#
+0	i386	restart_syscall		sys_restart_syscall		__ia32_sys_restart_syscall
+1	i386	exit			sys_exit			__ia32_sys_exit
+2	i386	fork			sys_fork			__ia32_sys_fork
+3	i386	read			sys_read			__ia32_sys_read
+4	i386	write			sys_write			__ia32_sys_write
+5	i386	open			sys_open			__ia32_compat_sys_open
+6	i386	close			sys_close			__ia32_sys_close
+7	i386	waitpid			sys_waitpid			__ia32_sys_waitpid
+8	i386	creat			sys_creat			__ia32_sys_creat
+9	i386	link			sys_link			__ia32_sys_link
+10	i386	unlink			sys_unlink			__ia32_sys_unlink
+11	i386	execve			sys_execve			__ia32_compat_sys_execve
+12	i386	chdir			sys_chdir			__ia32_sys_chdir
+13	i386	time			sys_time32			__ia32_sys_time32
+14	i386	mknod			sys_mknod			__ia32_sys_mknod
+15	i386	chmod			sys_chmod			__ia32_sys_chmod
+16	i386	lchown			sys_lchown16			__ia32_sys_lchown16
+17	i386	break
+18	i386	oldstat			sys_stat			__ia32_sys_stat
+19	i386	lseek			sys_lseek			__ia32_compat_sys_lseek
+20	i386	getpid			sys_getpid			__ia32_sys_getpid
+21	i386	mount			sys_mount			__ia32_compat_sys_mount
+22	i386	umount			sys_oldumount			__ia32_sys_oldumount
+23	i386	setuid			sys_setuid16			__ia32_sys_setuid16
+24	i386	getuid			sys_getuid16			__ia32_sys_getuid16
+25	i386	stime			sys_stime32			__ia32_sys_stime32
+26	i386	ptrace			sys_ptrace			__ia32_compat_sys_ptrace
+27	i386	alarm			sys_alarm			__ia32_sys_alarm
+28	i386	oldfstat		sys_fstat			__ia32_sys_fstat
+29	i386	pause			sys_pause			__ia32_sys_pause
+30	i386	utime			sys_utime32			__ia32_sys_utime32
+31	i386	stty
+32	i386	gtty
+33	i386	access			sys_access			__ia32_sys_access
+34	i386	nice			sys_nice			__ia32_sys_nice
+35	i386	ftime
+36	i386	sync			sys_sync			__ia32_sys_sync
+37	i386	kill			sys_kill			__ia32_sys_kill
+38	i386	rename			sys_rename			__ia32_sys_rename
+39	i386	mkdir			sys_mkdir			__ia32_sys_mkdir
+40	i386	rmdir			sys_rmdir			__ia32_sys_rmdir
+41	i386	dup			sys_dup				__ia32_sys_dup
+42	i386	pipe			sys_pipe			__ia32_sys_pipe
+43	i386	times			sys_times			__ia32_compat_sys_times
+44	i386	prof
+45	i386	brk			sys_brk				__ia32_sys_brk
+46	i386	setgid			sys_setgid16			__ia32_sys_setgid16
+47	i386	getgid			sys_getgid16			__ia32_sys_getgid16
+48	i386	signal			sys_signal			__ia32_sys_signal
+49	i386	geteuid			sys_geteuid16			__ia32_sys_geteuid16
+50	i386	getegid			sys_getegid16			__ia32_sys_getegid16
+51	i386	acct			sys_acct			__ia32_sys_acct
+52	i386	umount2			sys_umount			__ia32_sys_umount
+53	i386	lock
+54	i386	ioctl			sys_ioctl			__ia32_compat_sys_ioctl
+55	i386	fcntl			sys_fcntl			__ia32_compat_sys_fcntl64
+56	i386	mpx
+57	i386	setpgid			sys_setpgid			__ia32_sys_setpgid
+58	i386	ulimit
+59	i386	oldolduname		sys_olduname			__ia32_sys_olduname
+60	i386	umask			sys_umask			__ia32_sys_umask
+61	i386	chroot			sys_chroot			__ia32_sys_chroot
+62	i386	ustat			sys_ustat			__ia32_compat_sys_ustat
+63	i386	dup2			sys_dup2			__ia32_sys_dup2
+64	i386	getppid			sys_getppid			__ia32_sys_getppid
+65	i386	getpgrp			sys_getpgrp			__ia32_sys_getpgrp
+66	i386	setsid			sys_setsid			__ia32_sys_setsid
+67	i386	sigaction		sys_sigaction			__ia32_compat_sys_sigaction
+68	i386	sgetmask		sys_sgetmask			__ia32_sys_sgetmask
+69	i386	ssetmask		sys_ssetmask			__ia32_sys_ssetmask
+70	i386	setreuid		sys_setreuid16			__ia32_sys_setreuid16
+71	i386	setregid		sys_setregid16			__ia32_sys_setregid16
+72	i386	sigsuspend		sys_sigsuspend			__ia32_sys_sigsuspend
+73	i386	sigpending		sys_sigpending			__ia32_compat_sys_sigpending
+74	i386	sethostname		sys_sethostname			__ia32_sys_sethostname
+75	i386	setrlimit		sys_setrlimit			__ia32_compat_sys_setrlimit
+76	i386	getrlimit		sys_old_getrlimit		__ia32_compat_sys_old_getrlimit
+77	i386	getrusage		sys_getrusage			__ia32_compat_sys_getrusage
+78	i386	gettimeofday		sys_gettimeofday		__ia32_compat_sys_gettimeofday
+79	i386	settimeofday		sys_settimeofday		__ia32_compat_sys_settimeofday
+80	i386	getgroups		sys_getgroups16			__ia32_sys_getgroups16
+81	i386	setgroups		sys_setgroups16			__ia32_sys_setgroups16
+82	i386	select			sys_old_select			__ia32_compat_sys_old_select
+83	i386	symlink			sys_symlink			__ia32_sys_symlink
+84	i386	oldlstat		sys_lstat			__ia32_sys_lstat
+85	i386	readlink		sys_readlink			__ia32_sys_readlink
+86	i386	uselib			sys_uselib			__ia32_sys_uselib
+87	i386	swapon			sys_swapon			__ia32_sys_swapon
+88	i386	reboot			sys_reboot			__ia32_sys_reboot
+89	i386	readdir			sys_old_readdir			__ia32_compat_sys_old_readdir
+90	i386	mmap			sys_old_mmap			__ia32_compat_sys_x86_mmap
+91	i386	munmap			sys_munmap			__ia32_sys_munmap
+92	i386	truncate		sys_truncate			__ia32_compat_sys_truncate
+93	i386	ftruncate		sys_ftruncate			__ia32_compat_sys_ftruncate
+94	i386	fchmod			sys_fchmod			__ia32_sys_fchmod
+95	i386	fchown			sys_fchown16			__ia32_sys_fchown16
+96	i386	getpriority		sys_getpriority			__ia32_sys_getpriority
+97	i386	setpriority		sys_setpriority			__ia32_sys_setpriority
+98	i386	profil
+99	i386	statfs			sys_statfs			__ia32_compat_sys_statfs
+100	i386	fstatfs			sys_fstatfs			__ia32_compat_sys_fstatfs
+101	i386	ioperm			sys_ioperm			__ia32_sys_ioperm
+102	i386	socketcall		sys_socketcall			__ia32_compat_sys_socketcall
+103	i386	syslog			sys_syslog			__ia32_sys_syslog
+104	i386	setitimer		sys_setitimer			__ia32_compat_sys_setitimer
+105	i386	getitimer		sys_getitimer			__ia32_compat_sys_getitimer
+106	i386	stat			sys_newstat			__ia32_compat_sys_newstat
+107	i386	lstat			sys_newlstat			__ia32_compat_sys_newlstat
+108	i386	fstat			sys_newfstat			__ia32_compat_sys_newfstat
+109	i386	olduname		sys_uname			__ia32_sys_uname
+110	i386	iopl			sys_iopl			__ia32_sys_iopl
+111	i386	vhangup			sys_vhangup			__ia32_sys_vhangup
+112	i386	idle
+113	i386	vm86old			sys_vm86old			__ia32_sys_ni_syscall
+114	i386	wait4			sys_wait4			__ia32_compat_sys_wait4
+115	i386	swapoff			sys_swapoff			__ia32_sys_swapoff
+116	i386	sysinfo			sys_sysinfo			__ia32_compat_sys_sysinfo
+117	i386	ipc			sys_ipc				__ia32_compat_sys_ipc
+118	i386	fsync			sys_fsync			__ia32_sys_fsync
+119	i386	sigreturn		sys_sigreturn			__ia32_compat_sys_sigreturn
+120	i386	clone			sys_clone			__ia32_compat_sys_x86_clone
+121	i386	setdomainname		sys_setdomainname		__ia32_sys_setdomainname
+122	i386	uname			sys_newuname			__ia32_sys_newuname
+123	i386	modify_ldt		sys_modify_ldt			__ia32_sys_modify_ldt
+124	i386	adjtimex		sys_adjtimex_time32			__ia32_sys_adjtimex_time32
+125	i386	mprotect		sys_mprotect			__ia32_sys_mprotect
+126	i386	sigprocmask		sys_sigprocmask			__ia32_compat_sys_sigprocmask
+127	i386	create_module
+128	i386	init_module		sys_init_module			__ia32_sys_init_module
+129	i386	delete_module		sys_delete_module		__ia32_sys_delete_module
+130	i386	get_kernel_syms
+131	i386	quotactl		sys_quotactl			__ia32_compat_sys_quotactl32
+132	i386	getpgid			sys_getpgid			__ia32_sys_getpgid
+133	i386	fchdir			sys_fchdir			__ia32_sys_fchdir
+134	i386	bdflush			sys_bdflush			__ia32_sys_bdflush
+135	i386	sysfs			sys_sysfs			__ia32_sys_sysfs
+136	i386	personality		sys_personality			__ia32_sys_personality
+137	i386	afs_syscall
+138	i386	setfsuid		sys_setfsuid16			__ia32_sys_setfsuid16
+139	i386	setfsgid		sys_setfsgid16			__ia32_sys_setfsgid16
+140	i386	_llseek			sys_llseek			__ia32_sys_llseek
+141	i386	getdents		sys_getdents			__ia32_compat_sys_getdents
+142	i386	_newselect		sys_select			__ia32_compat_sys_select
+143	i386	flock			sys_flock			__ia32_sys_flock
+144	i386	msync			sys_msync			__ia32_sys_msync
+145	i386	readv			sys_readv			__ia32_compat_sys_readv
+146	i386	writev			sys_writev			__ia32_compat_sys_writev
+147	i386	getsid			sys_getsid			__ia32_sys_getsid
+148	i386	fdatasync		sys_fdatasync			__ia32_sys_fdatasync
+149	i386	_sysctl			sys_sysctl			__ia32_compat_sys_sysctl
+150	i386	mlock			sys_mlock			__ia32_sys_mlock
+151	i386	munlock			sys_munlock			__ia32_sys_munlock
+152	i386	mlockall		sys_mlockall			__ia32_sys_mlockall
+153	i386	munlockall		sys_munlockall			__ia32_sys_munlockall
+154	i386	sched_setparam		sys_sched_setparam		__ia32_sys_sched_setparam
+155	i386	sched_getparam		sys_sched_getparam		__ia32_sys_sched_getparam
+156	i386	sched_setscheduler	sys_sched_setscheduler		__ia32_sys_sched_setscheduler
+157	i386	sched_getscheduler	sys_sched_getscheduler		__ia32_sys_sched_getscheduler
+158	i386	sched_yield		sys_sched_yield			__ia32_sys_sched_yield
+159	i386	sched_get_priority_max	sys_sched_get_priority_max	__ia32_sys_sched_get_priority_max
+160	i386	sched_get_priority_min	sys_sched_get_priority_min	__ia32_sys_sched_get_priority_min
+161	i386	sched_rr_get_interval	sys_sched_rr_get_interval_time32	__ia32_sys_sched_rr_get_interval_time32
+162	i386	nanosleep		sys_nanosleep_time32		__ia32_sys_nanosleep_time32
+163	i386	mremap			sys_mremap			__ia32_sys_mremap
+164	i386	setresuid		sys_setresuid16			__ia32_sys_setresuid16
+165	i386	getresuid		sys_getresuid16			__ia32_sys_getresuid16
+166	i386	vm86			sys_vm86			__ia32_sys_ni_syscall
+167	i386	query_module
+168	i386	poll			sys_poll			__ia32_sys_poll
+169	i386	nfsservctl
+170	i386	setresgid		sys_setresgid16			__ia32_sys_setresgid16
+171	i386	getresgid		sys_getresgid16			__ia32_sys_getresgid16
+172	i386	prctl			sys_prctl			__ia32_sys_prctl
+173	i386	rt_sigreturn		sys_rt_sigreturn		__ia32_compat_sys_rt_sigreturn
+174	i386	rt_sigaction		sys_rt_sigaction		__ia32_compat_sys_rt_sigaction
+175	i386	rt_sigprocmask		sys_rt_sigprocmask		__ia32_compat_sys_rt_sigprocmask
+176	i386	rt_sigpending		sys_rt_sigpending		__ia32_compat_sys_rt_sigpending
+177	i386	rt_sigtimedwait		sys_rt_sigtimedwait_time32	__ia32_compat_sys_rt_sigtimedwait_time32
+178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		__ia32_compat_sys_rt_sigqueueinfo
+179	i386	rt_sigsuspend		sys_rt_sigsuspend		__ia32_compat_sys_rt_sigsuspend
+180	i386	pread64			sys_pread64			__ia32_compat_sys_x86_pread
+181	i386	pwrite64		sys_pwrite64			__ia32_compat_sys_x86_pwrite
+182	i386	chown			sys_chown16			__ia32_sys_chown16
+183	i386	getcwd			sys_getcwd			__ia32_sys_getcwd
+184	i386	capget			sys_capget			__ia32_sys_capget
+185	i386	capset			sys_capset			__ia32_sys_capset
+186	i386	sigaltstack		sys_sigaltstack			__ia32_compat_sys_sigaltstack
+187	i386	sendfile		sys_sendfile			__ia32_compat_sys_sendfile
+188	i386	getpmsg
+189	i386	putpmsg
+190	i386	vfork			sys_vfork			__ia32_sys_vfork
+191	i386	ugetrlimit		sys_getrlimit			__ia32_compat_sys_getrlimit
+192	i386	mmap2			sys_mmap_pgoff			__ia32_sys_mmap_pgoff
+193	i386	truncate64		sys_truncate64			__ia32_compat_sys_x86_truncate64
+194	i386	ftruncate64		sys_ftruncate64			__ia32_compat_sys_x86_ftruncate64
+195	i386	stat64			sys_stat64			__ia32_compat_sys_x86_stat64
+196	i386	lstat64			sys_lstat64			__ia32_compat_sys_x86_lstat64
+197	i386	fstat64			sys_fstat64			__ia32_compat_sys_x86_fstat64
+198	i386	lchown32		sys_lchown			__ia32_sys_lchown
+199	i386	getuid32		sys_getuid			__ia32_sys_getuid
+200	i386	getgid32		sys_getgid			__ia32_sys_getgid
+201	i386	geteuid32		sys_geteuid			__ia32_sys_geteuid
+202	i386	getegid32		sys_getegid			__ia32_sys_getegid
+203	i386	setreuid32		sys_setreuid			__ia32_sys_setreuid
+204	i386	setregid32		sys_setregid			__ia32_sys_setregid
+205	i386	getgroups32		sys_getgroups			__ia32_sys_getgroups
+206	i386	setgroups32		sys_setgroups			__ia32_sys_setgroups
+207	i386	fchown32		sys_fchown			__ia32_sys_fchown
+208	i386	setresuid32		sys_setresuid			__ia32_sys_setresuid
+209	i386	getresuid32		sys_getresuid			__ia32_sys_getresuid
+210	i386	setresgid32		sys_setresgid			__ia32_sys_setresgid
+211	i386	getresgid32		sys_getresgid			__ia32_sys_getresgid
+212	i386	chown32			sys_chown			__ia32_sys_chown
+213	i386	setuid32		sys_setuid			__ia32_sys_setuid
+214	i386	setgid32		sys_setgid			__ia32_sys_setgid
+215	i386	setfsuid32		sys_setfsuid			__ia32_sys_setfsuid
+216	i386	setfsgid32		sys_setfsgid			__ia32_sys_setfsgid
+217	i386	pivot_root		sys_pivot_root			__ia32_sys_pivot_root
+218	i386	mincore			sys_mincore			__ia32_sys_mincore
+219	i386	madvise			sys_madvise			__ia32_sys_madvise
+220	i386	getdents64		sys_getdents64			__ia32_sys_getdents64
+221	i386	fcntl64			sys_fcntl64			__ia32_compat_sys_fcntl64
+# 222 is unused
+# 223 is unused
+224	i386	gettid			sys_gettid			__ia32_sys_gettid
+225	i386	readahead		sys_readahead			__ia32_compat_sys_x86_readahead
+226	i386	setxattr		sys_setxattr			__ia32_sys_setxattr
+227	i386	lsetxattr		sys_lsetxattr			__ia32_sys_lsetxattr
+228	i386	fsetxattr		sys_fsetxattr			__ia32_sys_fsetxattr
+229	i386	getxattr		sys_getxattr			__ia32_sys_getxattr
+230	i386	lgetxattr		sys_lgetxattr			__ia32_sys_lgetxattr
+231	i386	fgetxattr		sys_fgetxattr			__ia32_sys_fgetxattr
+232	i386	listxattr		sys_listxattr			__ia32_sys_listxattr
+233	i386	llistxattr		sys_llistxattr			__ia32_sys_llistxattr
+234	i386	flistxattr		sys_flistxattr			__ia32_sys_flistxattr
+235	i386	removexattr		sys_removexattr			__ia32_sys_removexattr
+236	i386	lremovexattr		sys_lremovexattr		__ia32_sys_lremovexattr
+237	i386	fremovexattr		sys_fremovexattr		__ia32_sys_fremovexattr
+238	i386	tkill			sys_tkill			__ia32_sys_tkill
+239	i386	sendfile64		sys_sendfile64			__ia32_sys_sendfile64
+240	i386	futex			sys_futex_time32		__ia32_sys_futex_time32
+241	i386	sched_setaffinity	sys_sched_setaffinity		__ia32_compat_sys_sched_setaffinity
+242	i386	sched_getaffinity	sys_sched_getaffinity		__ia32_compat_sys_sched_getaffinity
+243	i386	set_thread_area		sys_set_thread_area		__ia32_sys_set_thread_area
+244	i386	get_thread_area		sys_get_thread_area		__ia32_sys_get_thread_area
+245	i386	io_setup		sys_io_setup			__ia32_compat_sys_io_setup
+246	i386	io_destroy		sys_io_destroy			__ia32_sys_io_destroy
+247	i386	io_getevents		sys_io_getevents_time32		__ia32_sys_io_getevents_time32
+248	i386	io_submit		sys_io_submit			__ia32_compat_sys_io_submit
+249	i386	io_cancel		sys_io_cancel			__ia32_sys_io_cancel
+250	i386	fadvise64		sys_fadvise64			__ia32_compat_sys_x86_fadvise64
+# 251 is available for reuse (was briefly sys_set_zone_reclaim)
+252	i386	exit_group		sys_exit_group			__ia32_sys_exit_group
+253	i386	lookup_dcookie		sys_lookup_dcookie		__ia32_compat_sys_lookup_dcookie
+254	i386	epoll_create		sys_epoll_create		__ia32_sys_epoll_create
+255	i386	epoll_ctl		sys_epoll_ctl			__ia32_sys_epoll_ctl
+256	i386	epoll_wait		sys_epoll_wait			__ia32_sys_epoll_wait
+257	i386	remap_file_pages	sys_remap_file_pages		__ia32_sys_remap_file_pages
+258	i386	set_tid_address		sys_set_tid_address		__ia32_sys_set_tid_address
+259	i386	timer_create		sys_timer_create		__ia32_compat_sys_timer_create
+260	i386	timer_settime		sys_timer_settime32		__ia32_sys_timer_settime32
+261	i386	timer_gettime		sys_timer_gettime32		__ia32_sys_timer_gettime32
+262	i386	timer_getoverrun	sys_timer_getoverrun		__ia32_sys_timer_getoverrun
+263	i386	timer_delete		sys_timer_delete		__ia32_sys_timer_delete
+264	i386	clock_settime		sys_clock_settime32		__ia32_sys_clock_settime32
+265	i386	clock_gettime		sys_clock_gettime32		__ia32_sys_clock_gettime32
+266	i386	clock_getres		sys_clock_getres_time32		__ia32_sys_clock_getres_time32
+267	i386	clock_nanosleep		sys_clock_nanosleep_time32	__ia32_sys_clock_nanosleep_time32
+268	i386	statfs64		sys_statfs64			__ia32_compat_sys_statfs64
+269	i386	fstatfs64		sys_fstatfs64			__ia32_compat_sys_fstatfs64
+270	i386	tgkill			sys_tgkill			__ia32_sys_tgkill
+271	i386	utimes			sys_utimes_time32		__ia32_sys_utimes_time32
+272	i386	fadvise64_64		sys_fadvise64_64		__ia32_compat_sys_x86_fadvise64_64
+273	i386	vserver
+274	i386	mbind			sys_mbind			__ia32_sys_mbind
+275	i386	get_mempolicy		sys_get_mempolicy		__ia32_compat_sys_get_mempolicy
+276	i386	set_mempolicy		sys_set_mempolicy		__ia32_sys_set_mempolicy
+277	i386	mq_open			sys_mq_open			__ia32_compat_sys_mq_open
+278	i386	mq_unlink		sys_mq_unlink			__ia32_sys_mq_unlink
+279	i386	mq_timedsend		sys_mq_timedsend_time32		__ia32_sys_mq_timedsend_time32
+280	i386	mq_timedreceive		sys_mq_timedreceive_time32	__ia32_sys_mq_timedreceive_time32
+281	i386	mq_notify		sys_mq_notify			__ia32_compat_sys_mq_notify
+282	i386	mq_getsetattr		sys_mq_getsetattr		__ia32_compat_sys_mq_getsetattr
+283	i386	kexec_load		sys_kexec_load			__ia32_compat_sys_kexec_load
+284	i386	waitid			sys_waitid			__ia32_compat_sys_waitid
+# 285 sys_setaltroot
+286	i386	add_key			sys_add_key			__ia32_sys_add_key
+287	i386	request_key		sys_request_key			__ia32_sys_request_key
+288	i386	keyctl			sys_keyctl			__ia32_compat_sys_keyctl
+289	i386	ioprio_set		sys_ioprio_set			__ia32_sys_ioprio_set
+290	i386	ioprio_get		sys_ioprio_get			__ia32_sys_ioprio_get
+291	i386	inotify_init		sys_inotify_init		__ia32_sys_inotify_init
+292	i386	inotify_add_watch	sys_inotify_add_watch		__ia32_sys_inotify_add_watch
+293	i386	inotify_rm_watch	sys_inotify_rm_watch		__ia32_sys_inotify_rm_watch
+294	i386	migrate_pages		sys_migrate_pages		__ia32_sys_migrate_pages
+295	i386	openat			sys_openat			__ia32_compat_sys_openat
+296	i386	mkdirat			sys_mkdirat			__ia32_sys_mkdirat
+297	i386	mknodat			sys_mknodat			__ia32_sys_mknodat
+298	i386	fchownat		sys_fchownat			__ia32_sys_fchownat
+299	i386	futimesat		sys_futimesat_time32		__ia32_sys_futimesat_time32
+300	i386	fstatat64		sys_fstatat64			__ia32_compat_sys_x86_fstatat
+301	i386	unlinkat		sys_unlinkat			__ia32_sys_unlinkat
+302	i386	renameat		sys_renameat			__ia32_sys_renameat
+303	i386	linkat			sys_linkat			__ia32_sys_linkat
+304	i386	symlinkat		sys_symlinkat			__ia32_sys_symlinkat
+305	i386	readlinkat		sys_readlinkat			__ia32_sys_readlinkat
+306	i386	fchmodat		sys_fchmodat			__ia32_sys_fchmodat
+307	i386	faccessat		sys_faccessat			__ia32_sys_faccessat
+308	i386	pselect6		sys_pselect6_time32		__ia32_compat_sys_pselect6_time32
+309	i386	ppoll			sys_ppoll_time32		__ia32_compat_sys_ppoll_time32
+310	i386	unshare			sys_unshare			__ia32_sys_unshare
+311	i386	set_robust_list		sys_set_robust_list		__ia32_compat_sys_set_robust_list
+312	i386	get_robust_list		sys_get_robust_list		__ia32_compat_sys_get_robust_list
+313	i386	splice			sys_splice			__ia32_sys_splice
+314	i386	sync_file_range		sys_sync_file_range		__ia32_compat_sys_x86_sync_file_range
+315	i386	tee			sys_tee				__ia32_sys_tee
+316	i386	vmsplice		sys_vmsplice			__ia32_compat_sys_vmsplice
+317	i386	move_pages		sys_move_pages			__ia32_compat_sys_move_pages
+318	i386	getcpu			sys_getcpu			__ia32_sys_getcpu
+319	i386	epoll_pwait		sys_epoll_pwait			__ia32_sys_epoll_pwait
+320	i386	utimensat		sys_utimensat_time32		__ia32_sys_utimensat_time32
+321	i386	signalfd		sys_signalfd			__ia32_compat_sys_signalfd
+322	i386	timerfd_create		sys_timerfd_create		__ia32_sys_timerfd_create
+323	i386	eventfd			sys_eventfd			__ia32_sys_eventfd
+324	i386	fallocate		sys_fallocate			__ia32_compat_sys_x86_fallocate
+325	i386	timerfd_settime		sys_timerfd_settime32		__ia32_sys_timerfd_settime32
+326	i386	timerfd_gettime		sys_timerfd_gettime32		__ia32_sys_timerfd_gettime32
+327	i386	signalfd4		sys_signalfd4			__ia32_compat_sys_signalfd4
+328	i386	eventfd2		sys_eventfd2			__ia32_sys_eventfd2
+329	i386	epoll_create1		sys_epoll_create1		__ia32_sys_epoll_create1
+330	i386	dup3			sys_dup3			__ia32_sys_dup3
+331	i386	pipe2			sys_pipe2			__ia32_sys_pipe2
+332	i386	inotify_init1		sys_inotify_init1		__ia32_sys_inotify_init1
+333	i386	preadv			sys_preadv			__ia32_compat_sys_preadv
+334	i386	pwritev			sys_pwritev			__ia32_compat_sys_pwritev
+335	i386	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		__ia32_compat_sys_rt_tgsigqueueinfo
+336	i386	perf_event_open		sys_perf_event_open		__ia32_sys_perf_event_open
+337	i386	recvmmsg		sys_recvmmsg_time32		__ia32_compat_sys_recvmmsg_time32
+338	i386	fanotify_init		sys_fanotify_init		__ia32_sys_fanotify_init
+339	i386	fanotify_mark		sys_fanotify_mark		__ia32_compat_sys_fanotify_mark
+340	i386	prlimit64		sys_prlimit64			__ia32_sys_prlimit64
+341	i386	name_to_handle_at	sys_name_to_handle_at		__ia32_sys_name_to_handle_at
+342	i386	open_by_handle_at	sys_open_by_handle_at		__ia32_compat_sys_open_by_handle_at
+343	i386	clock_adjtime		sys_clock_adjtime32		__ia32_sys_clock_adjtime32
+344	i386	syncfs			sys_syncfs			__ia32_sys_syncfs
+345	i386	sendmmsg		sys_sendmmsg			__ia32_compat_sys_sendmmsg
+346	i386	setns			sys_setns			__ia32_sys_setns
+347	i386	process_vm_readv	sys_process_vm_readv		__ia32_compat_sys_process_vm_readv
+348	i386	process_vm_writev	sys_process_vm_writev		__ia32_compat_sys_process_vm_writev
+349	i386	kcmp			sys_kcmp			__ia32_sys_kcmp
+350	i386	finit_module		sys_finit_module		__ia32_sys_finit_module
+351	i386	sched_setattr		sys_sched_setattr		__ia32_sys_sched_setattr
+352	i386	sched_getattr		sys_sched_getattr		__ia32_sys_sched_getattr
+353	i386	renameat2		sys_renameat2			__ia32_sys_renameat2
+354	i386	seccomp			sys_seccomp			__ia32_sys_seccomp
+355	i386	getrandom		sys_getrandom			__ia32_sys_getrandom
+356	i386	memfd_create		sys_memfd_create		__ia32_sys_memfd_create
+357	i386	bpf			sys_bpf				__ia32_sys_bpf
+358	i386	execveat		sys_execveat			__ia32_compat_sys_execveat
+359	i386	socket			sys_socket			__ia32_sys_socket
+360	i386	socketpair		sys_socketpair			__ia32_sys_socketpair
+361	i386	bind			sys_bind			__ia32_sys_bind
+362	i386	connect			sys_connect			__ia32_sys_connect
+363	i386	listen			sys_listen			__ia32_sys_listen
+364	i386	accept4			sys_accept4			__ia32_sys_accept4
+365	i386	getsockopt		sys_getsockopt			__ia32_compat_sys_getsockopt
+366	i386	setsockopt		sys_setsockopt			__ia32_compat_sys_setsockopt
+367	i386	getsockname		sys_getsockname			__ia32_sys_getsockname
+368	i386	getpeername		sys_getpeername			__ia32_sys_getpeername
+369	i386	sendto			sys_sendto			__ia32_sys_sendto
+370	i386	sendmsg			sys_sendmsg			__ia32_compat_sys_sendmsg
+371	i386	recvfrom		sys_recvfrom			__ia32_compat_sys_recvfrom
+372	i386	recvmsg			sys_recvmsg			__ia32_compat_sys_recvmsg
+373	i386	shutdown		sys_shutdown			__ia32_sys_shutdown
+374	i386	userfaultfd		sys_userfaultfd			__ia32_sys_userfaultfd
+375	i386	membarrier		sys_membarrier			__ia32_sys_membarrier
+376	i386	mlock2			sys_mlock2			__ia32_sys_mlock2
+377	i386	copy_file_range		sys_copy_file_range		__ia32_sys_copy_file_range
+378	i386	preadv2			sys_preadv2			__ia32_compat_sys_preadv2
+379	i386	pwritev2		sys_pwritev2			__ia32_compat_sys_pwritev2
+380	i386	pkey_mprotect		sys_pkey_mprotect		__ia32_sys_pkey_mprotect
+381	i386	pkey_alloc		sys_pkey_alloc			__ia32_sys_pkey_alloc
+382	i386	pkey_free		sys_pkey_free			__ia32_sys_pkey_free
+383	i386	statx			sys_statx			__ia32_sys_statx
+384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
+385	i386	io_pgetevents		sys_io_pgetevents_time32	__ia32_compat_sys_io_pgetevents
+386	i386	rseq			sys_rseq			__ia32_sys_rseq
+393	i386	semget			sys_semget    			__ia32_sys_semget
+394	i386	semctl			sys_semctl    			__ia32_compat_sys_semctl
+395	i386	shmget			sys_shmget    			__ia32_sys_shmget
+396	i386	shmctl			sys_shmctl    			__ia32_compat_sys_shmctl
+397	i386	shmat			sys_shmat     			__ia32_compat_sys_shmat
+398	i386	shmdt			sys_shmdt     			__ia32_sys_shmdt
+399	i386	msgget			sys_msgget    			__ia32_sys_msgget
+400	i386	msgsnd			sys_msgsnd    			__ia32_compat_sys_msgsnd
+401	i386	msgrcv			sys_msgrcv    			__ia32_compat_sys_msgrcv
+402	i386	msgctl			sys_msgctl    			__ia32_compat_sys_msgctl
+403	i386	clock_gettime64		sys_clock_gettime		__ia32_sys_clock_gettime
+404	i386	clock_settime64		sys_clock_settime		__ia32_sys_clock_settime
+405	i386	clock_adjtime64		sys_clock_adjtime		__ia32_sys_clock_adjtime
+406	i386	clock_getres_time64	sys_clock_getres		__ia32_sys_clock_getres
+407	i386	clock_nanosleep_time64	sys_clock_nanosleep		__ia32_sys_clock_nanosleep
+408	i386	timer_gettime64		sys_timer_gettime		__ia32_sys_timer_gettime
+409	i386	timer_settime64		sys_timer_settime		__ia32_sys_timer_settime
+410	i386	timerfd_gettime64	sys_timerfd_gettime		__ia32_sys_timerfd_gettime
+411	i386	timerfd_settime64	sys_timerfd_settime		__ia32_sys_timerfd_settime
+412	i386	utimensat_time64	sys_utimensat			__ia32_sys_utimensat
+413	i386	pselect6_time64		sys_pselect6			__ia32_compat_sys_pselect6_time64
+414	i386	ppoll_time64		sys_ppoll			__ia32_compat_sys_ppoll_time64
+416	i386	io_pgetevents_time64	sys_io_pgetevents		__ia32_sys_io_pgetevents
+417	i386	recvmmsg_time64		sys_recvmmsg			__ia32_compat_sys_recvmmsg_time64
+418	i386	mq_timedsend_time64	sys_mq_timedsend		__ia32_sys_mq_timedsend
+419	i386	mq_timedreceive_time64	sys_mq_timedreceive		__ia32_sys_mq_timedreceive
+420	i386	semtimedop_time64	sys_semtimedop			__ia32_sys_semtimedop
+421	i386	rt_sigtimedwait_time64	sys_rt_sigtimedwait		__ia32_compat_sys_rt_sigtimedwait_time64
+422	i386	futex_time64		sys_futex			__ia32_sys_futex
+423	i386	sched_rr_get_interval_time64	sys_sched_rr_get_interval	__ia32_sys_sched_rr_get_interval
+424	i386	pidfd_send_signal	sys_pidfd_send_signal		__ia32_sys_pidfd_send_signal
+425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
+426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
+427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
+428	i386	open_tree		sys_open_tree			__ia32_sys_open_tree
+429	i386	move_mount		sys_move_mount			__ia32_sys_move_mount
+430	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
+431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
+432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
+433	i386	fspick			sys_fspick			__ia32_sys_fspick
+434	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
+435	i386	clone3			sys_clone3			__ia32_sys_clone3
diff --git a/linux-user/i386/syscall_nr.h b/linux-user/i386/syscall_nr.h
deleted file mode 100644
index 3234ec21c6ef..000000000000
--- a/linux-user/i386/syscall_nr.h
+++ /dev/null
@@ -1,387 +0,0 @@
-/*
- * This file contains the system call numbers.
- */
-
-#ifndef LINUX_USER_I386_SYSCALL_NR_H
-#define LINUX_USER_I386_SYSCALL_NR_H
-
-#define TARGET_NR_restart_syscall      0
-#define TARGET_NR_exit		  1
-#define TARGET_NR_fork		  2
-#define TARGET_NR_read		  3
-#define TARGET_NR_write		  4
-#define TARGET_NR_open		  5
-#define TARGET_NR_close		  6
-#define TARGET_NR_waitpid		  7
-#define TARGET_NR_creat		  8
-#define TARGET_NR_link		  9
-#define TARGET_NR_unlink		 10
-#define TARGET_NR_execve		 11
-#define TARGET_NR_chdir		 12
-#define TARGET_NR_time		 13
-#define TARGET_NR_mknod		 14
-#define TARGET_NR_chmod		 15
-#define TARGET_NR_lchown		 16
-#define TARGET_NR_break		 17
-#define TARGET_NR_oldstat		 18
-#define TARGET_NR_lseek		 19
-#define TARGET_NR_getpid		 20
-#define TARGET_NR_mount		 21
-#define TARGET_NR_umount		 22
-#define TARGET_NR_setuid		 23
-#define TARGET_NR_getuid		 24
-#define TARGET_NR_stime		 25
-#define TARGET_NR_ptrace		 26
-#define TARGET_NR_alarm		 27
-#define TARGET_NR_oldfstat		 28
-#define TARGET_NR_pause		 29
-#define TARGET_NR_utime		 30
-#define TARGET_NR_stty		 31
-#define TARGET_NR_gtty		 32
-#define TARGET_NR_access		 33
-#define TARGET_NR_nice		 34
-#define TARGET_NR_ftime		 35
-#define TARGET_NR_sync		 36
-#define TARGET_NR_kill		 37
-#define TARGET_NR_rename		 38
-#define TARGET_NR_mkdir		 39
-#define TARGET_NR_rmdir		 40
-#define TARGET_NR_dup		 41
-#define TARGET_NR_pipe		 42
-#define TARGET_NR_times		 43
-#define TARGET_NR_prof		 44
-#define TARGET_NR_brk		 45
-#define TARGET_NR_setgid		 46
-#define TARGET_NR_getgid		 47
-#define TARGET_NR_signal		 48
-#define TARGET_NR_geteuid		 49
-#define TARGET_NR_getegid		 50
-#define TARGET_NR_acct		 51
-#define TARGET_NR_umount2		 52
-#define TARGET_NR_lock		 53
-#define TARGET_NR_ioctl		 54
-#define TARGET_NR_fcntl		 55
-#define TARGET_NR_mpx		 56
-#define TARGET_NR_setpgid		 57
-#define TARGET_NR_ulimit		 58
-#define TARGET_NR_oldolduname	 59
-#define TARGET_NR_umask		 60
-#define TARGET_NR_chroot		 61
-#define TARGET_NR_ustat		 62
-#define TARGET_NR_dup2		 63
-#define TARGET_NR_getppid		 64
-#define TARGET_NR_getpgrp		 65
-#define TARGET_NR_setsid		 66
-#define TARGET_NR_sigaction		 67
-#define TARGET_NR_sgetmask		 68
-#define TARGET_NR_ssetmask		 69
-#define TARGET_NR_setreuid		 70
-#define TARGET_NR_setregid		 71
-#define TARGET_NR_sigsuspend		 72
-#define TARGET_NR_sigpending		 73
-#define TARGET_NR_sethostname	 74
-#define TARGET_NR_setrlimit		 75
-#define TARGET_NR_getrlimit		 76	/* Back compatible 2Gig limited rlimit */
-#define TARGET_NR_getrusage		 77
-#define TARGET_NR_gettimeofday	 78
-#define TARGET_NR_settimeofday	 79
-#define TARGET_NR_getgroups		 80
-#define TARGET_NR_setgroups		 81
-#define TARGET_NR_select		 82
-#define TARGET_NR_symlink		 83
-#define TARGET_NR_oldlstat		 84
-#define TARGET_NR_readlink		 85
-#define TARGET_NR_uselib		 86
-#define TARGET_NR_swapon		 87
-#define TARGET_NR_reboot		 88
-#define TARGET_NR_readdir		 89
-#define TARGET_NR_mmap		 90
-#define TARGET_NR_munmap		 91
-#define TARGET_NR_truncate		 92
-#define TARGET_NR_ftruncate		 93
-#define TARGET_NR_fchmod		 94
-#define TARGET_NR_fchown		 95
-#define TARGET_NR_getpriority	 96
-#define TARGET_NR_setpriority	 97
-#define TARGET_NR_profil		 98
-#define TARGET_NR_statfs		 99
-#define TARGET_NR_fstatfs		100
-#define TARGET_NR_ioperm		101
-#define TARGET_NR_socketcall		102
-#define TARGET_NR_syslog		103
-#define TARGET_NR_setitimer		104
-#define TARGET_NR_getitimer		105
-#define TARGET_NR_stat		106
-#define TARGET_NR_lstat		107
-#define TARGET_NR_fstat		108
-#define TARGET_NR_olduname		109
-#define TARGET_NR_iopl		110
-#define TARGET_NR_vhangup		111
-#define TARGET_NR_idle		112
-#define TARGET_NR_vm86old		113
-#define TARGET_NR_wait4		114
-#define TARGET_NR_swapoff		115
-#define TARGET_NR_sysinfo		116
-#define TARGET_NR_ipc		117
-#define TARGET_NR_fsync		118
-#define TARGET_NR_sigreturn		119
-#define TARGET_NR_clone		120
-#define TARGET_NR_setdomainname	121
-#define TARGET_NR_uname		122
-#define TARGET_NR_modify_ldt		123
-#define TARGET_NR_adjtimex		124
-#define TARGET_NR_mprotect		125
-#define TARGET_NR_sigprocmask	126
-#define TARGET_NR_create_module	127
-#define TARGET_NR_init_module	128
-#define TARGET_NR_delete_module	129
-#define TARGET_NR_get_kernel_syms	130
-#define TARGET_NR_quotactl		131
-#define TARGET_NR_getpgid		132
-#define TARGET_NR_fchdir		133
-#define TARGET_NR_bdflush		134
-#define TARGET_NR_sysfs		135
-#define TARGET_NR_personality	136
-#define TARGET_NR_afs_syscall	137 /* Syscall for Andrew File System */
-#define TARGET_NR_setfsuid		138
-#define TARGET_NR_setfsgid		139
-#define TARGET_NR__llseek		140
-#define TARGET_NR_getdents		141
-#define TARGET_NR__newselect		142
-#define TARGET_NR_flock		143
-#define TARGET_NR_msync		144
-#define TARGET_NR_readv		145
-#define TARGET_NR_writev		146
-#define TARGET_NR_getsid		147
-#define TARGET_NR_fdatasync		148
-#define TARGET_NR__sysctl		149
-#define TARGET_NR_mlock		150
-#define TARGET_NR_munlock		151
-#define TARGET_NR_mlockall		152
-#define TARGET_NR_munlockall		153
-#define TARGET_NR_sched_setparam		154
-#define TARGET_NR_sched_getparam		155
-#define TARGET_NR_sched_setscheduler		156
-#define TARGET_NR_sched_getscheduler		157
-#define TARGET_NR_sched_yield		158
-#define TARGET_NR_sched_get_priority_max	159
-#define TARGET_NR_sched_get_priority_min	160
-#define TARGET_NR_sched_rr_get_interval	161
-#define TARGET_NR_nanosleep		162
-#define TARGET_NR_mremap		163
-#define TARGET_NR_setresuid		164
-#define TARGET_NR_getresuid		165
-#define TARGET_NR_vm86		166
-#define TARGET_NR_query_module	167
-#define TARGET_NR_poll		168
-#define TARGET_NR_nfsservctl		169
-#define TARGET_NR_setresgid		170
-#define TARGET_NR_getresgid		171
-#define TARGET_NR_prctl              172
-#define TARGET_NR_rt_sigreturn	173
-#define TARGET_NR_rt_sigaction	174
-#define TARGET_NR_rt_sigprocmask	175
-#define TARGET_NR_rt_sigpending	176
-#define TARGET_NR_rt_sigtimedwait	177
-#define TARGET_NR_rt_sigqueueinfo	178
-#define TARGET_NR_rt_sigsuspend	179
-#define TARGET_NR_pread64               180
-#define TARGET_NR_pwrite64              181
-#define TARGET_NR_chown		182
-#define TARGET_NR_getcwd		183
-#define TARGET_NR_capget		184
-#define TARGET_NR_capset		185
-#define TARGET_NR_sigaltstack	186
-#define TARGET_NR_sendfile		187
-#define TARGET_NR_getpmsg		188	/* some people actually want streams */
-#define TARGET_NR_putpmsg		189	/* some people actually want streams */
-#define TARGET_NR_vfork		190
-#define TARGET_NR_ugetrlimit		191	/* SuS compliant getrlimit */
-#define TARGET_NR_mmap2		192
-#define TARGET_NR_truncate64		193
-#define TARGET_NR_ftruncate64	194
-#define TARGET_NR_stat64		195
-#define TARGET_NR_lstat64		196
-#define TARGET_NR_fstat64		197
-#define TARGET_NR_lchown32		198
-#define TARGET_NR_getuid32		199
-#define TARGET_NR_getgid32		200
-#define TARGET_NR_geteuid32		201
-#define TARGET_NR_getegid32		202
-#define TARGET_NR_setreuid32		203
-#define TARGET_NR_setregid32		204
-#define TARGET_NR_getgroups32	205
-#define TARGET_NR_setgroups32	206
-#define TARGET_NR_fchown32		207
-#define TARGET_NR_setresuid32	208
-#define TARGET_NR_getresuid32	209
-#define TARGET_NR_setresgid32	210
-#define TARGET_NR_getresgid32	211
-#define TARGET_NR_chown32		212
-#define TARGET_NR_setuid32		213
-#define TARGET_NR_setgid32		214
-#define TARGET_NR_setfsuid32		215
-#define TARGET_NR_setfsgid32		216
-#define TARGET_NR_pivot_root		217
-#define TARGET_NR_mincore		218
-#define TARGET_NR_madvise		219
-#define TARGET_NR_madvise1		219	/* delete when C lib stub is removed */
-#define TARGET_NR_getdents64		220
-#define TARGET_NR_fcntl64		221
-/* 223 is unused */
-#define TARGET_NR_gettid		224
-#define TARGET_NR_readahead		225
-#define TARGET_NR_setxattr		226
-#define TARGET_NR_lsetxattr		227
-#define TARGET_NR_fsetxattr		228
-#define TARGET_NR_getxattr		229
-#define TARGET_NR_lgetxattr		230
-#define TARGET_NR_fgetxattr		231
-#define TARGET_NR_listxattr		232
-#define TARGET_NR_llistxattr		233
-#define TARGET_NR_flistxattr		234
-#define TARGET_NR_removexattr	235
-#define TARGET_NR_lremovexattr	236
-#define TARGET_NR_fremovexattr	237
-#define TARGET_NR_tkill		238
-#define TARGET_NR_sendfile64		239
-#define TARGET_NR_futex		240
-#define TARGET_NR_sched_setaffinity	241
-#define TARGET_NR_sched_getaffinity	242
-#define TARGET_NR_set_thread_area	243
-#define TARGET_NR_get_thread_area	244
-#define TARGET_NR_io_setup		245
-#define TARGET_NR_io_destroy		246
-#define TARGET_NR_io_getevents	247
-#define TARGET_NR_io_submit		248
-#define TARGET_NR_io_cancel		249
-#define TARGET_NR_fadvise64		250
-/* 251 is available for reuse (was briefly sys_set_zone_reclaim) */
-#define TARGET_NR_exit_group		252
-#define TARGET_NR_lookup_dcookie	253
-#define TARGET_NR_epoll_create	254
-#define TARGET_NR_epoll_ctl		255
-#define TARGET_NR_epoll_wait		256
-#define TARGET_NR_remap_file_pages	257
-#define TARGET_NR_set_tid_address	258
-#define TARGET_NR_timer_create	259
-#define TARGET_NR_timer_settime	(TARGET_NR_timer_create+1)
-#define TARGET_NR_timer_gettime	(TARGET_NR_timer_create+2)
-#define TARGET_NR_timer_getoverrun	(TARGET_NR_timer_create+3)
-#define TARGET_NR_timer_delete	(TARGET_NR_timer_create+4)
-#define TARGET_NR_clock_settime	(TARGET_NR_timer_create+5)
-#define TARGET_NR_clock_gettime	(TARGET_NR_timer_create+6)
-#define TARGET_NR_clock_getres	(TARGET_NR_timer_create+7)
-#define TARGET_NR_clock_nanosleep	(TARGET_NR_timer_create+8)
-#define TARGET_NR_statfs64		268
-#define TARGET_NR_fstatfs64		269
-#define TARGET_NR_tgkill		270
-#define TARGET_NR_utimes		271
-#define TARGET_NR_fadvise64_64	272
-#define TARGET_NR_vserver		273
-#define TARGET_NR_mbind		274
-#define TARGET_NR_get_mempolicy	275
-#define TARGET_NR_set_mempolicy	276
-#define TARGET_NR_mq_open 		277
-#define TARGET_NR_mq_unlink		(TARGET_NR_mq_open+1)
-#define TARGET_NR_mq_timedsend	(TARGET_NR_mq_open+2)
-#define TARGET_NR_mq_timedreceive	(TARGET_NR_mq_open+3)
-#define TARGET_NR_mq_notify		(TARGET_NR_mq_open+4)
-#define TARGET_NR_mq_getsetattr	(TARGET_NR_mq_open+5)
-#define TARGET_NR_kexec_load		283
-#define TARGET_NR_waitid		284
-/* #define TARGET_NR_sys_setaltroot	285 */
-#define TARGET_NR_add_key		286
-#define TARGET_NR_request_key	287
-#define TARGET_NR_keyctl		288
-#define TARGET_NR_ioprio_set		289
-#define TARGET_NR_ioprio_get		290
-#define TARGET_NR_inotify_init	291
-#define TARGET_NR_inotify_add_watch	292
-#define TARGET_NR_inotify_rm_watch	293
-#define TARGET_NR_migrate_pages	294
-#define TARGET_NR_openat		295
-#define TARGET_NR_mkdirat		296
-#define TARGET_NR_mknodat		297
-#define TARGET_NR_fchownat		298
-#define TARGET_NR_futimesat		299
-#define TARGET_NR_fstatat64		300
-#define TARGET_NR_unlinkat		301
-#define TARGET_NR_renameat		302
-#define TARGET_NR_linkat		303
-#define TARGET_NR_symlinkat		304
-#define TARGET_NR_readlinkat		305
-#define TARGET_NR_fchmodat		306
-#define TARGET_NR_faccessat		307
-#define TARGET_NR_pselect6		308
-#define TARGET_NR_ppoll		309
-#define TARGET_NR_unshare		310
-#define TARGET_NR_set_robust_list	311
-#define TARGET_NR_get_robust_list	312
-#define TARGET_NR_splice		313
-#define TARGET_NR_sync_file_range	314
-#define TARGET_NR_tee		315
-#define TARGET_NR_vmsplice		316
-#define TARGET_NR_move_pages		317
-#define TARGET_NR_getcpu		318
-#define TARGET_NR_epoll_pwait	319
-#define TARGET_NR_utimensat		320
-#define TARGET_NR_signalfd		321
-#define TARGET_NR_timerfd_create	322
-#define TARGET_NR_eventfd		323
-#define TARGET_NR_fallocate		324
-#define TARGET_NR_timerfd_settime	325
-#define TARGET_NR_timerfd_gettime	326
-#define TARGET_NR_signalfd4		327
-#define TARGET_NR_eventfd2		328
-#define TARGET_NR_epoll_create1	329
-#define TARGET_NR_dup3			330
-#define TARGET_NR_pipe2		331
-#define TARGET_NR_inotify_init1	332
-#define TARGET_NR_preadv                333
-#define TARGET_NR_pwritev               334
-#define TARGET_NR_rt_tgsigqueueinfo     335
-#define TARGET_NR_perf_event_open       336
-#define TARGET_NR_recvmmsg              337
-#define TARGET_NR_fanotify_init         338
-#define TARGET_NR_fanotify_mark         339
-#define TARGET_NR_prlimit64             340
-#define TARGET_NR_name_to_handle_at     341
-#define TARGET_NR_open_by_handle_at     342
-#define TARGET_NR_clock_adjtime         343
-#define TARGET_NR_syncfs                344
-#define TARGET_NR_sendmmsg              345
-#define TARGET_NR_setns                 346
-#define TARGET_NR_process_vm_readv      347
-#define TARGET_NR_process_vm_writev     348
-#define TARGET_NR_kcmp                  349
-#define TARGET_NR_finit_module          350
-#define TARGET_NR_sched_setattr         351
-#define TARGET_NR_sched_getattr         352
-#define TARGET_NR_renameat2             353
-#define TARGET_NR_seccomp               354
-#define TARGET_NR_getrandom             355
-#define TARGET_NR_memfd_create          356
-#define TARGET_NR_bpf                   357
-#define TARGET_NR_execveat              358
-#define TARGET_NR_socket                359
-#define TARGET_NR_socketpair            360
-#define TARGET_NR_bind                  361
-#define TARGET_NR_connect               362
-#define TARGET_NR_listen                363
-#define TARGET_NR_accept4               364
-#define TARGET_NR_getsockopt            365
-#define TARGET_NR_setsockopt            366
-#define TARGET_NR_getsockname           367
-#define TARGET_NR_getpeername           368
-#define TARGET_NR_sendto                369
-#define TARGET_NR_sendmsg               370
-#define TARGET_NR_recvfrom              371
-#define TARGET_NR_recvmsg               372
-#define TARGET_NR_shutdown              373
-#define TARGET_NR_userfaultfd           374
-#define TARGET_NR_membarrier            375
-#define TARGET_NR_mlock2                376
-#define TARGET_NR_copy_file_range       377
-
-#endif
diff --git a/linux-user/i386/syscallhdr.sh b/linux-user/i386/syscallhdr.sh
new file mode 100644
index 000000000000..b2eca96db7e8
--- /dev/null
+++ b/linux-user/i386/syscallhdr.sh
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
+fileguard=LINUX_USER_I386_`basename "$out" | sed \
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
2.24.1


