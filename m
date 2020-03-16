Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2311C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD3620409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD3620409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuHJ-00042Q-Lv
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsQI-0008ET-WC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsQD-0005eM-Uc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:52571)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsQD-0005UI-FK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:57 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N7xml-1jQAEd0lTn-0154ma; Mon, 16 Mar 2020 17:16:32 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 24/38] linux-user, s390x: add syscall table generation support
Date: Mon, 16 Mar 2020 17:15:36 +0100
Message-Id: <20200316161550.336150-25-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UUNxt1/7IlF2FC/VJc4w+Nj8wmAvQEILa/uGrikWniHQ9vHVMJi
 lNO99CA4mb/0/XIxFCi3F8a/x7mH6TKmeAnDRXn63c1kmDv2HcEux3vy78y6YX5s5tbYIZU
 iyffZxJ/l/Kl0WyqADb7ArbS6OVE+S2v78wdUUvRzXCj5mWbFIB+q9e+v4myUdOMy36lTB1
 x/YtgaDLktu9XxSRpXy/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Tms/27cCuc=:rqnbS/2heDNxk1hHOybsGf
 maGjk4IE0Z800SFryLbLUZ9Kajhf4XVWtxiiUHyuVwq3PNTERj8mli+WttxCVcOJbfnsD4hrU
 1acBvdEHZI2EJGN7Y3EOFTOWCci8f7ZRIoV3SyVBVbn2AsEexrz+KVgadlWBlAZ3oRFbjAA5F
 pfkw1M9t81x40lgaPjJIkJDqbx1BOXNDodBaJyf7cbsA71Tthjl9imJoxg3jvd3SujMooldJE
 DKrApRFOB4tkTYYOl6/1FdSmJaBs1J21wcXyIS/GUC2o2GsvMTChrdJ1wMo+c3FJpPpXM4yOp
 erkeLTbIpZeIWMIcCWmySUtnDGjas+MtbbMfbTnKZCOEMiFL1f0yiQYZAImzpNxOYnYWa7GmP
 Ixb34SJsb7wV5ymigjp0WBqiyxQtQ0JmkQuFDKw3Xsf8B7E2mtS7Zgt2hLw1ps/JfiTx/JnRo
 ahlIJlJ1SYMMuMuEWTXxQAB7lwuqj5jSLq0RF6BzA+IWVs5P01Yxi9+TsFRN2qJ9gkm0Q9P1l
 GfqrmCsdTrI7IOeViRNHhD+qn3k2JjU3j+ykT28TopGopvg/3jHNfD5O3FJEZKlOzHx+wUJW1
 diOihPdapTZjF6Sxo6E599zpm9/PPfrc7DgkGLTJfclXT6SnGOTw6GBP06OiDKJZt3O6ualFM
 jM8euUbDkQozThezcq8BZ0q3rPYgyVnxhdYGR+DLsTk3FKt6DiNRGZFIL6IPo6Zt4+N5OVpQw
 ecJuVeE+23bXZHLsGQpa1/E6uAV8XhB5fKJFDI7PrlvQRZwJerqi36JXsRa4ho4o2dg8/5nyE
 ser0C/JS8GvLxdjWbceqobalBWOgXtEE8hbLd1KT3/LZsLkPehcbKUDKDVuj9cftt1UPYj0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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

Copy syscall.tbl from linux/arch/s390x/kernel/syscalls v5.5
Copy syscallhdr.sh from m68k.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-12-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                      |   3 +-
 linux-user/Makefile.objs       |   1 +
 linux-user/s390x/Makefile.objs |   5 +
 linux-user/s390x/syscall.tbl   | 440 +++++++++++++++++++++++++++++++++
 linux-user/s390x/syscall_nr.h  | 331 -------------------------
 linux-user/s390x/syscallhdr.sh |  32 +++
 6 files changed, 480 insertions(+), 332 deletions(-)
 create mode 100644 linux-user/s390x/Makefile.objs
 create mode 100644 linux-user/s390x/syscall.tbl
 delete mode 100644 linux-user/s390x/syscall_nr.h
 create mode 100755 linux-user/s390x/syscallhdr.sh

diff --git a/configure b/configure
index f2500823ba52..8805fab48279 100755
--- a/configure
+++ b/configure
@@ -1889,7 +1889,7 @@ rm -f */config-devices.mak.d
 
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
-for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc ; do
+for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc s390x ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
@@ -7912,6 +7912,7 @@ case "$target_name" in
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   s390x)
+    TARGET_SYSTBL_ABI=common,64
     mttcg=yes
     gdb_xml_files="s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-gs.xml"
   ;;
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 8b00dad687b2..f4e666e74c91 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -14,5 +14,6 @@ obj-$(TARGET_M68K) += m68k/
 obj-$(TARGET_MICROBLAZE) += microblaze/
 obj-$(TARGET_PPC) += ppc/
 obj-$(TARGET_PPC64) += ppc/
+obj-$(TARGET_S390X) += s390x/
 obj-$(TARGET_SH4) += sh4/
 obj-$(TARGET_XTENSA) += xtensa/
diff --git a/linux-user/s390x/Makefile.objs b/linux-user/s390x/Makefile.objs
new file mode 100644
index 000000000000..f30f1625ccff
--- /dev/null
+++ b/linux-user/s390x/Makefile.objs
@@ -0,0 +1,5 @@
+generated-files-y += linux-user/s390x/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/s390x/syscallhdr.sh
+%/syscall_nr.h: $(SRC_PATH)/linux-user/s390x/syscall.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/s390x/syscall.tbl b/linux-user/s390x/syscall.tbl
new file mode 100644
index 000000000000..3054e9c035a3
--- /dev/null
+++ b/linux-user/s390x/syscall.tbl
@@ -0,0 +1,440 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# System call table for s390
+#
+# Format:
+#
+# <nr> <abi> <syscall> <entry-64bit> <compat-entry>
+#
+# where <abi> can be common, 64, or 32
+
+1    common	exit			sys_exit			sys_exit
+2    common	fork			sys_fork			sys_fork
+3    common	read			sys_read			compat_sys_s390_read
+4    common	write			sys_write			compat_sys_s390_write
+5    common	open			sys_open			compat_sys_open
+6    common	close			sys_close			sys_close
+7    common	restart_syscall		sys_restart_syscall		sys_restart_syscall
+8    common	creat			sys_creat			sys_creat
+9    common	link			sys_link			sys_link
+10   common	unlink			sys_unlink			sys_unlink
+11   common	execve			sys_execve			compat_sys_execve
+12   common	chdir			sys_chdir			sys_chdir
+13   32		time			-				sys_time32
+14   common	mknod			sys_mknod			sys_mknod
+15   common	chmod			sys_chmod			sys_chmod
+16   32		lchown			-				sys_lchown16
+19   common	lseek			sys_lseek			compat_sys_lseek
+20   common	getpid			sys_getpid			sys_getpid
+21   common	mount			sys_mount			compat_sys_mount
+22   common	umount			sys_oldumount			sys_oldumount
+23   32		setuid			-				sys_setuid16
+24   32		getuid			-				sys_getuid16
+25   32		stime			-				sys_stime32
+26   common	ptrace			sys_ptrace			compat_sys_ptrace
+27   common	alarm			sys_alarm			sys_alarm
+29   common	pause			sys_pause			sys_pause
+30   common	utime			sys_utime			sys_utime32
+33   common	access			sys_access			sys_access
+34   common	nice			sys_nice			sys_nice
+36   common	sync			sys_sync			sys_sync
+37   common	kill			sys_kill			sys_kill
+38   common	rename			sys_rename			sys_rename
+39   common	mkdir			sys_mkdir			sys_mkdir
+40   common	rmdir			sys_rmdir			sys_rmdir
+41   common	dup			sys_dup				sys_dup
+42   common	pipe			sys_pipe			sys_pipe
+43   common	times			sys_times			compat_sys_times
+45   common	brk			sys_brk				sys_brk
+46   32		setgid			-				sys_setgid16
+47   32		getgid			-				sys_getgid16
+48   common	signal			sys_signal			sys_signal
+49   32		geteuid			-				sys_geteuid16
+50   32		getegid			-				sys_getegid16
+51   common	acct			sys_acct			sys_acct
+52   common	umount2			sys_umount			sys_umount
+54   common	ioctl			sys_ioctl			compat_sys_ioctl
+55   common	fcntl			sys_fcntl			compat_sys_fcntl
+57   common	setpgid			sys_setpgid			sys_setpgid
+60   common	umask			sys_umask			sys_umask
+61   common	chroot			sys_chroot			sys_chroot
+62   common	ustat			sys_ustat			compat_sys_ustat
+63   common	dup2			sys_dup2			sys_dup2
+64   common	getppid			sys_getppid			sys_getppid
+65   common	getpgrp			sys_getpgrp			sys_getpgrp
+66   common	setsid			sys_setsid			sys_setsid
+67   common	sigaction		sys_sigaction			compat_sys_sigaction
+70   32		setreuid		-				sys_setreuid16
+71   32		setregid		-				sys_setregid16
+72   common	sigsuspend		sys_sigsuspend			sys_sigsuspend
+73   common	sigpending		sys_sigpending			compat_sys_sigpending
+74   common	sethostname		sys_sethostname			sys_sethostname
+75   common	setrlimit		sys_setrlimit			compat_sys_setrlimit
+76   32		getrlimit		-				compat_sys_old_getrlimit
+77   common	getrusage		sys_getrusage			compat_sys_getrusage
+78   common	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
+79   common	settimeofday		sys_settimeofday		compat_sys_settimeofday
+80   32		getgroups		-				sys_getgroups16
+81   32		setgroups		-				sys_setgroups16
+83   common	symlink			sys_symlink			sys_symlink
+85   common	readlink		sys_readlink			sys_readlink
+86   common	uselib			sys_uselib			sys_uselib
+87   common	swapon			sys_swapon			sys_swapon
+88   common	reboot			sys_reboot			sys_reboot
+89   common	readdir			-				compat_sys_old_readdir
+90   common	mmap			sys_old_mmap			compat_sys_s390_old_mmap
+91   common	munmap			sys_munmap			sys_munmap
+92   common	truncate		sys_truncate			compat_sys_truncate
+93   common	ftruncate		sys_ftruncate			compat_sys_ftruncate
+94   common	fchmod			sys_fchmod			sys_fchmod
+95   32		fchown			-				sys_fchown16
+96   common	getpriority		sys_getpriority			sys_getpriority
+97   common	setpriority		sys_setpriority			sys_setpriority
+99   common	statfs			sys_statfs			compat_sys_statfs
+100  common	fstatfs			sys_fstatfs			compat_sys_fstatfs
+101  32		ioperm			-				-
+102  common	socketcall		sys_socketcall			compat_sys_socketcall
+103  common	syslog			sys_syslog			sys_syslog
+104  common	setitimer		sys_setitimer			compat_sys_setitimer
+105  common	getitimer		sys_getitimer			compat_sys_getitimer
+106  common	stat			sys_newstat			compat_sys_newstat
+107  common	lstat			sys_newlstat			compat_sys_newlstat
+108  common	fstat			sys_newfstat			compat_sys_newfstat
+110  common	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
+111  common	vhangup			sys_vhangup			sys_vhangup
+112  common	idle			-				-
+114  common	wait4			sys_wait4			compat_sys_wait4
+115  common	swapoff			sys_swapoff			sys_swapoff
+116  common	sysinfo			sys_sysinfo			compat_sys_sysinfo
+117  common	ipc			sys_s390_ipc			compat_sys_s390_ipc
+118  common	fsync			sys_fsync			sys_fsync
+119  common	sigreturn		sys_sigreturn			compat_sys_sigreturn
+120  common	clone			sys_clone			sys_clone
+121  common	setdomainname		sys_setdomainname		sys_setdomainname
+122  common	uname			sys_newuname			sys_newuname
+124  common	adjtimex		sys_adjtimex			sys_adjtimex_time32
+125  common	mprotect		sys_mprotect			sys_mprotect
+126  common	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
+127  common	create_module		-				-
+128  common	init_module		sys_init_module			sys_init_module
+129  common	delete_module		sys_delete_module		sys_delete_module
+130  common	get_kernel_syms		-				-
+131  common	quotactl		sys_quotactl			sys_quotactl
+132  common	getpgid			sys_getpgid			sys_getpgid
+133  common	fchdir			sys_fchdir			sys_fchdir
+134  common	bdflush			sys_bdflush			sys_bdflush
+135  common	sysfs			sys_sysfs			sys_sysfs
+136  common	personality		sys_s390_personality		sys_s390_personality
+137  common	afs_syscall		-				-
+138  32		setfsuid		-				sys_setfsuid16
+139  32		setfsgid		-				sys_setfsgid16
+140  32		_llseek			-				sys_llseek
+141  common	getdents		sys_getdents			compat_sys_getdents
+142  32		_newselect		-				compat_sys_select
+142  64		select			sys_select			-
+143  common	flock			sys_flock			sys_flock
+144  common	msync			sys_msync			sys_msync
+145  common	readv			sys_readv			compat_sys_readv
+146  common	writev			sys_writev			compat_sys_writev
+147  common	getsid			sys_getsid			sys_getsid
+148  common	fdatasync		sys_fdatasync			sys_fdatasync
+149  common	_sysctl			sys_sysctl			compat_sys_sysctl
+150  common	mlock			sys_mlock			sys_mlock
+151  common	munlock			sys_munlock			sys_munlock
+152  common	mlockall		sys_mlockall			sys_mlockall
+153  common	munlockall		sys_munlockall			sys_munlockall
+154  common	sched_setparam		sys_sched_setparam		sys_sched_setparam
+155  common	sched_getparam		sys_sched_getparam		sys_sched_getparam
+156  common	sched_setscheduler	sys_sched_setscheduler		sys_sched_setscheduler
+157  common	sched_getscheduler	sys_sched_getscheduler		sys_sched_getscheduler
+158  common	sched_yield		sys_sched_yield			sys_sched_yield
+159  common	sched_get_priority_max	sys_sched_get_priority_max	sys_sched_get_priority_max
+160  common	sched_get_priority_min	sys_sched_get_priority_min	sys_sched_get_priority_min
+161  common	sched_rr_get_interval	sys_sched_rr_get_interval	sys_sched_rr_get_interval_time32
+162  common	nanosleep		sys_nanosleep			sys_nanosleep_time32
+163  common	mremap			sys_mremap			sys_mremap
+164  32		setresuid		-				sys_setresuid16
+165  32		getresuid		-				sys_getresuid16
+167  common	query_module		-				-
+168  common	poll			sys_poll			sys_poll
+169  common	nfsservctl		-				-
+170  32		setresgid		-				sys_setresgid16
+171  32		getresgid		-				sys_getresgid16
+172  common	prctl			sys_prctl			sys_prctl
+173  common	rt_sigreturn		sys_rt_sigreturn		compat_sys_rt_sigreturn
+174  common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
+175  common	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+176  common	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
+177  common	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time32
+178  common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+179  common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+180  common	pread64			sys_pread64			compat_sys_s390_pread64
+181  common	pwrite64		sys_pwrite64			compat_sys_s390_pwrite64
+182  32		chown			-				sys_chown16
+183  common	getcwd			sys_getcwd			sys_getcwd
+184  common	capget			sys_capget			sys_capget
+185  common	capset			sys_capset			sys_capset
+186  common	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
+187  common	sendfile		sys_sendfile64			compat_sys_sendfile
+188  common	getpmsg			-				-
+189  common	putpmsg			-				-
+190  common	vfork			sys_vfork			sys_vfork
+191  32		ugetrlimit		-				compat_sys_getrlimit
+191  64		getrlimit		sys_getrlimit			-
+192  32		mmap2			-				compat_sys_s390_mmap2
+193  32		truncate64		-				compat_sys_s390_truncate64
+194  32		ftruncate64		-				compat_sys_s390_ftruncate64
+195  32		stat64			-				compat_sys_s390_stat64
+196  32		lstat64			-				compat_sys_s390_lstat64
+197  32		fstat64			-				compat_sys_s390_fstat64
+198  32		lchown32		-				sys_lchown
+198  64		lchown			sys_lchown			-
+199  32		getuid32		-				sys_getuid
+199  64		getuid			sys_getuid			-
+200  32		getgid32		-				sys_getgid
+200  64		getgid			sys_getgid			-
+201  32		geteuid32		-				sys_geteuid
+201  64		geteuid			sys_geteuid			-
+202  32		getegid32		-				sys_getegid
+202  64		getegid			sys_getegid			-
+203  32		setreuid32		-				sys_setreuid
+203  64		setreuid		sys_setreuid			-
+204  32		setregid32		-				sys_setregid
+204  64		setregid		sys_setregid			-
+205  32		getgroups32		-				sys_getgroups
+205  64		getgroups		sys_getgroups			-
+206  32		setgroups32		-				sys_setgroups
+206  64		setgroups		sys_setgroups			-
+207  32		fchown32		-				sys_fchown
+207  64		fchown			sys_fchown			-
+208  32		setresuid32		-				sys_setresuid
+208  64		setresuid		sys_setresuid			-
+209  32		getresuid32		-				sys_getresuid
+209  64		getresuid		sys_getresuid			-
+210  32		setresgid32		-				sys_setresgid
+210  64		setresgid		sys_setresgid			-
+211  32		getresgid32		-				sys_getresgid
+211  64		getresgid		sys_getresgid			-
+212  32		chown32			-				sys_chown
+212  64		chown			sys_chown			-
+213  32		setuid32		-				sys_setuid
+213  64		setuid			sys_setuid			-
+214  32		setgid32		-				sys_setgid
+214  64		setgid			sys_setgid			-
+215  32		setfsuid32		-				sys_setfsuid
+215  64		setfsuid		sys_setfsuid			-
+216  32		setfsgid32		-				sys_setfsgid
+216  64		setfsgid		sys_setfsgid			-
+217  common	pivot_root		sys_pivot_root			sys_pivot_root
+218  common	mincore			sys_mincore			sys_mincore
+219  common	madvise			sys_madvise			sys_madvise
+220  common	getdents64		sys_getdents64			sys_getdents64
+221  32		fcntl64			-				compat_sys_fcntl64
+222  common	readahead		sys_readahead			compat_sys_s390_readahead
+223  32		sendfile64		-				compat_sys_sendfile64
+224  common	setxattr		sys_setxattr			sys_setxattr
+225  common	lsetxattr		sys_lsetxattr			sys_lsetxattr
+226  common	fsetxattr		sys_fsetxattr			sys_fsetxattr
+227  common	getxattr		sys_getxattr			sys_getxattr
+228  common	lgetxattr		sys_lgetxattr			sys_lgetxattr
+229  common	fgetxattr		sys_fgetxattr			sys_fgetxattr
+230  common	listxattr		sys_listxattr			sys_listxattr
+231  common	llistxattr		sys_llistxattr			sys_llistxattr
+232  common	flistxattr		sys_flistxattr			sys_flistxattr
+233  common	removexattr		sys_removexattr			sys_removexattr
+234  common	lremovexattr		sys_lremovexattr		sys_lremovexattr
+235  common	fremovexattr		sys_fremovexattr		sys_fremovexattr
+236  common	gettid			sys_gettid			sys_gettid
+237  common	tkill			sys_tkill			sys_tkill
+238  common	futex			sys_futex			sys_futex_time32
+239  common	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
+240  common	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
+241  common	tgkill			sys_tgkill			sys_tgkill
+243  common	io_setup		sys_io_setup			compat_sys_io_setup
+244  common	io_destroy		sys_io_destroy			sys_io_destroy
+245  common	io_getevents		sys_io_getevents		sys_io_getevents_time32
+246  common	io_submit		sys_io_submit			compat_sys_io_submit
+247  common	io_cancel		sys_io_cancel			sys_io_cancel
+248  common	exit_group		sys_exit_group			sys_exit_group
+249  common	epoll_create		sys_epoll_create		sys_epoll_create
+250  common	epoll_ctl		sys_epoll_ctl			sys_epoll_ctl
+251  common	epoll_wait		sys_epoll_wait			sys_epoll_wait
+252  common	set_tid_address		sys_set_tid_address		sys_set_tid_address
+253  common	fadvise64		sys_fadvise64_64		compat_sys_s390_fadvise64
+254  common	timer_create		sys_timer_create		compat_sys_timer_create
+255  common	timer_settime		sys_timer_settime		sys_timer_settime32
+256  common	timer_gettime		sys_timer_gettime		sys_timer_gettime32
+257  common	timer_getoverrun	sys_timer_getoverrun		sys_timer_getoverrun
+258  common	timer_delete		sys_timer_delete		sys_timer_delete
+259  common	clock_settime		sys_clock_settime		sys_clock_settime32
+260  common	clock_gettime		sys_clock_gettime		sys_clock_gettime32
+261  common	clock_getres		sys_clock_getres		sys_clock_getres_time32
+262  common	clock_nanosleep		sys_clock_nanosleep		sys_clock_nanosleep_time32
+264  32		fadvise64_64		-				compat_sys_s390_fadvise64_64
+265  common	statfs64		sys_statfs64			compat_sys_statfs64
+266  common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
+267  common	remap_file_pages	sys_remap_file_pages		sys_remap_file_pages
+268  common	mbind			sys_mbind			compat_sys_mbind
+269  common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
+270  common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
+271  common	mq_open			sys_mq_open			compat_sys_mq_open
+272  common	mq_unlink		sys_mq_unlink			sys_mq_unlink
+273  common	mq_timedsend		sys_mq_timedsend		sys_mq_timedsend_time32
+274  common	mq_timedreceive		sys_mq_timedreceive		sys_mq_timedreceive_time32
+275  common	mq_notify		sys_mq_notify			compat_sys_mq_notify
+276  common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
+277  common	kexec_load		sys_kexec_load			compat_sys_kexec_load
+278  common	add_key			sys_add_key			sys_add_key
+279  common	request_key		sys_request_key			sys_request_key
+280  common	keyctl			sys_keyctl			compat_sys_keyctl
+281  common	waitid			sys_waitid			compat_sys_waitid
+282  common	ioprio_set		sys_ioprio_set			sys_ioprio_set
+283  common	ioprio_get		sys_ioprio_get			sys_ioprio_get
+284  common	inotify_init		sys_inotify_init		sys_inotify_init
+285  common	inotify_add_watch	sys_inotify_add_watch		sys_inotify_add_watch
+286  common	inotify_rm_watch	sys_inotify_rm_watch		sys_inotify_rm_watch
+287  common	migrate_pages		sys_migrate_pages		compat_sys_migrate_pages
+288  common	openat			sys_openat			compat_sys_openat
+289  common	mkdirat			sys_mkdirat			sys_mkdirat
+290  common	mknodat			sys_mknodat			sys_mknodat
+291  common	fchownat		sys_fchownat			sys_fchownat
+292  common	futimesat		sys_futimesat			sys_futimesat_time32
+293  32		fstatat64		-				compat_sys_s390_fstatat64
+293  64		newfstatat		sys_newfstatat			-
+294  common	unlinkat		sys_unlinkat			sys_unlinkat
+295  common	renameat		sys_renameat			sys_renameat
+296  common	linkat			sys_linkat			sys_linkat
+297  common	symlinkat		sys_symlinkat			sys_symlinkat
+298  common	readlinkat		sys_readlinkat			sys_readlinkat
+299  common	fchmodat		sys_fchmodat			sys_fchmodat
+300  common	faccessat		sys_faccessat			sys_faccessat
+301  common	pselect6		sys_pselect6			compat_sys_pselect6_time32
+302  common	ppoll			sys_ppoll			compat_sys_ppoll_time32
+303  common	unshare			sys_unshare			sys_unshare
+304  common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
+305  common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
+306  common	splice			sys_splice			sys_splice
+307  common	sync_file_range		sys_sync_file_range		compat_sys_s390_sync_file_range
+308  common	tee			sys_tee				sys_tee
+309  common	vmsplice		sys_vmsplice			compat_sys_vmsplice
+310  common	move_pages		sys_move_pages			compat_sys_move_pages
+311  common	getcpu			sys_getcpu			sys_getcpu
+312  common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
+313  common	utimes			sys_utimes			sys_utimes_time32
+314  common	fallocate		sys_fallocate			compat_sys_s390_fallocate
+315  common	utimensat		sys_utimensat			sys_utimensat_time32
+316  common	signalfd		sys_signalfd			compat_sys_signalfd
+317  common	timerfd			-				-
+318  common	eventfd			sys_eventfd			sys_eventfd
+319  common	timerfd_create		sys_timerfd_create		sys_timerfd_create
+320  common	timerfd_settime		sys_timerfd_settime		sys_timerfd_settime32
+321  common	timerfd_gettime		sys_timerfd_gettime		sys_timerfd_gettime32
+322  common	signalfd4		sys_signalfd4			compat_sys_signalfd4
+323  common	eventfd2		sys_eventfd2			sys_eventfd2
+324  common	inotify_init1		sys_inotify_init1		sys_inotify_init1
+325  common	pipe2			sys_pipe2			sys_pipe2
+326  common	dup3			sys_dup3			sys_dup3
+327  common	epoll_create1		sys_epoll_create1		sys_epoll_create1
+328  common	preadv			sys_preadv			compat_sys_preadv
+329  common	pwritev			sys_pwritev			compat_sys_pwritev
+330  common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+331  common	perf_event_open		sys_perf_event_open		sys_perf_event_open
+332  common	fanotify_init		sys_fanotify_init		sys_fanotify_init
+333  common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
+334  common	prlimit64		sys_prlimit64			sys_prlimit64
+335  common	name_to_handle_at	sys_name_to_handle_at		sys_name_to_handle_at
+336  common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
+337  common	clock_adjtime		sys_clock_adjtime		sys_clock_adjtime32
+338  common	syncfs			sys_syncfs			sys_syncfs
+339  common	setns			sys_setns			sys_setns
+340  common	process_vm_readv	sys_process_vm_readv		compat_sys_process_vm_readv
+341  common	process_vm_writev	sys_process_vm_writev		compat_sys_process_vm_writev
+342  common	s390_runtime_instr	sys_s390_runtime_instr		sys_s390_runtime_instr
+343  common	kcmp			sys_kcmp			sys_kcmp
+344  common	finit_module		sys_finit_module		sys_finit_module
+345  common	sched_setattr		sys_sched_setattr		sys_sched_setattr
+346  common	sched_getattr		sys_sched_getattr		sys_sched_getattr
+347  common	renameat2		sys_renameat2			sys_renameat2
+348  common	seccomp			sys_seccomp			sys_seccomp
+349  common	getrandom		sys_getrandom			sys_getrandom
+350  common	memfd_create		sys_memfd_create		sys_memfd_create
+351  common	bpf			sys_bpf				sys_bpf
+352  common	s390_pci_mmio_write	sys_s390_pci_mmio_write		sys_s390_pci_mmio_write
+353  common	s390_pci_mmio_read	sys_s390_pci_mmio_read		sys_s390_pci_mmio_read
+354  common	execveat		sys_execveat			compat_sys_execveat
+355  common	userfaultfd		sys_userfaultfd			sys_userfaultfd
+356  common	membarrier		sys_membarrier			sys_membarrier
+357  common	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg_time32
+358  common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
+359  common	socket			sys_socket			sys_socket
+360  common	socketpair		sys_socketpair			sys_socketpair
+361  common	bind			sys_bind			sys_bind
+362  common	connect			sys_connect			sys_connect
+363  common	listen			sys_listen			sys_listen
+364  common	accept4			sys_accept4			sys_accept4
+365  common	getsockopt		sys_getsockopt			compat_sys_getsockopt
+366  common	setsockopt		sys_setsockopt			compat_sys_setsockopt
+367  common	getsockname		sys_getsockname			sys_getsockname
+368  common	getpeername		sys_getpeername			sys_getpeername
+369  common	sendto			sys_sendto			sys_sendto
+370  common	sendmsg			sys_sendmsg			compat_sys_sendmsg
+371  common	recvfrom		sys_recvfrom			compat_sys_recvfrom
+372  common	recvmsg			sys_recvmsg			compat_sys_recvmsg
+373  common	shutdown		sys_shutdown			sys_shutdown
+374  common	mlock2			sys_mlock2			sys_mlock2
+375  common	copy_file_range		sys_copy_file_range		sys_copy_file_range
+376  common	preadv2			sys_preadv2			compat_sys_preadv2
+377  common	pwritev2		sys_pwritev2			compat_sys_pwritev2
+378  common	s390_guarded_storage	sys_s390_guarded_storage	sys_s390_guarded_storage
+379  common	statx			sys_statx			sys_statx
+380  common	s390_sthyi		sys_s390_sthyi			sys_s390_sthyi
+381  common	kexec_file_load		sys_kexec_file_load		sys_kexec_file_load
+382  common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
+383  common	rseq			sys_rseq			sys_rseq
+384  common	pkey_mprotect		sys_pkey_mprotect		sys_pkey_mprotect
+385  common	pkey_alloc		sys_pkey_alloc			sys_pkey_alloc
+386  common	pkey_free		sys_pkey_free			sys_pkey_free
+# room for arch specific syscalls
+392	64	semtimedop		sys_semtimedop			-
+393  common	semget			sys_semget			sys_semget
+394  common	semctl			sys_semctl			compat_sys_semctl
+395  common	shmget			sys_shmget			sys_shmget
+396  common	shmctl			sys_shmctl			compat_sys_shmctl
+397  common	shmat			sys_shmat			compat_sys_shmat
+398  common	shmdt			sys_shmdt 			sys_shmdt
+399  common	msgget			sys_msgget			sys_msgget
+400  common	msgsnd			sys_msgsnd			compat_sys_msgsnd
+401  common	msgrcv			sys_msgrcv			compat_sys_msgrcv
+402  common	msgctl			sys_msgctl			compat_sys_msgctl
+403	32	clock_gettime64		-				sys_clock_gettime
+404	32	clock_settime64		-				sys_clock_settime
+405	32	clock_adjtime64		-				sys_clock_adjtime
+406	32	clock_getres_time64	-				sys_clock_getres
+407	32	clock_nanosleep_time64	-				sys_clock_nanosleep
+408	32	timer_gettime64		-				sys_timer_gettime
+409	32	timer_settime64		-				sys_timer_settime
+410	32	timerfd_gettime64	-				sys_timerfd_gettime
+411	32	timerfd_settime64	-				sys_timerfd_settime
+412	32	utimensat_time64	-				sys_utimensat
+413	32	pselect6_time64		-				compat_sys_pselect6_time64
+414	32	ppoll_time64		-				compat_sys_ppoll_time64
+416	32	io_pgetevents_time64	-				sys_io_pgetevents
+417	32	recvmmsg_time64		-				compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64	-				sys_mq_timedsend
+419	32	mq_timedreceive_time64	-				sys_mq_timedreceive
+420	32	semtimedop_time64	-				sys_semtimedop
+421	32	rt_sigtimedwait_time64	-				compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64		-				sys_futex
+423	32	sched_rr_get_interval_time64	-			sys_sched_rr_get_interval
+424  common	pidfd_send_signal	sys_pidfd_send_signal		sys_pidfd_send_signal
+425  common	io_uring_setup		sys_io_uring_setup              sys_io_uring_setup
+426  common	io_uring_enter		sys_io_uring_enter              sys_io_uring_enter
+427  common	io_uring_register	sys_io_uring_register           sys_io_uring_register
+428  common	open_tree		sys_open_tree			sys_open_tree
+429  common	move_mount		sys_move_mount			sys_move_mount
+430  common	fsopen			sys_fsopen			sys_fsopen
+431  common	fsconfig		sys_fsconfig			sys_fsconfig
+432  common	fsmount			sys_fsmount			sys_fsmount
+433  common	fspick			sys_fspick			sys_fspick
+434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
+435  common	clone3			sys_clone3			sys_clone3
diff --git a/linux-user/s390x/syscall_nr.h b/linux-user/s390x/syscall_nr.h
deleted file mode 100644
index 261da1b0c30e..000000000000
--- a/linux-user/s390x/syscall_nr.h
+++ /dev/null
@@ -1,331 +0,0 @@
-/*
- * This file contains the system call numbers.
- */
-
-#ifndef LINUX_USER_S390X_SYSCALL_NR_H
-#define LINUX_USER_S390X_SYSCALL_NR_H
-
-#define TARGET_NR_exit                 1
-#define TARGET_NR_fork                 2
-#define TARGET_NR_read                 3
-#define TARGET_NR_write                4
-#define TARGET_NR_open                 5
-#define TARGET_NR_close                6
-#define TARGET_NR_restart_syscall         7
-#define TARGET_NR_creat                8
-#define TARGET_NR_link                 9
-#define TARGET_NR_unlink              10
-#define TARGET_NR_execve              11
-#define TARGET_NR_chdir               12
-#define TARGET_NR_mknod               14
-#define TARGET_NR_chmod               15
-#define TARGET_NR_lseek               19
-#define TARGET_NR_getpid              20
-#define TARGET_NR_mount               21
-#define TARGET_NR_umount              22
-#define TARGET_NR_ptrace              26
-#define TARGET_NR_alarm               27
-#define TARGET_NR_pause               29
-#define TARGET_NR_utime               30
-#define TARGET_NR_access              33
-#define TARGET_NR_nice                34
-#define TARGET_NR_sync                36
-#define TARGET_NR_kill                37
-#define TARGET_NR_rename              38
-#define TARGET_NR_mkdir               39
-#define TARGET_NR_rmdir               40
-#define TARGET_NR_dup                 41
-#define TARGET_NR_pipe                42
-#define TARGET_NR_times               43
-#define TARGET_NR_brk                 45
-#define TARGET_NR_signal              48
-#define TARGET_NR_acct                51
-#define TARGET_NR_umount2             52
-#define TARGET_NR_ioctl               54
-#define TARGET_NR_fcntl               55
-#define TARGET_NR_setpgid             57
-#define TARGET_NR_umask               60
-#define TARGET_NR_chroot              61
-#define TARGET_NR_ustat               62
-#define TARGET_NR_dup2                63
-#define TARGET_NR_getppid             64
-#define TARGET_NR_getpgrp             65
-#define TARGET_NR_setsid              66
-#define TARGET_NR_sigaction           67
-#define TARGET_NR_sigsuspend          72
-#define TARGET_NR_sigpending          73
-#define TARGET_NR_sethostname         74
-#define TARGET_NR_setrlimit           75
-#define TARGET_NR_getrusage           77
-#define TARGET_NR_gettimeofday        78
-#define TARGET_NR_settimeofday        79
-#define TARGET_NR_symlink             83
-#define TARGET_NR_readlink            85
-#define TARGET_NR_uselib              86
-#define TARGET_NR_swapon              87
-#define TARGET_NR_reboot              88
-#define TARGET_NR_readdir             89
-#define TARGET_NR_mmap                90
-#define TARGET_NR_munmap              91
-#define TARGET_NR_truncate            92
-#define TARGET_NR_ftruncate           93
-#define TARGET_NR_fchmod              94
-#define TARGET_NR_getpriority         96
-#define TARGET_NR_setpriority         97
-#define TARGET_NR_statfs              99
-#define TARGET_NR_fstatfs            100
-#define TARGET_NR_socketcall         102
-#define TARGET_NR_syslog             103
-#define TARGET_NR_setitimer          104
-#define TARGET_NR_getitimer          105
-#define TARGET_NR_stat               106
-#define TARGET_NR_lstat              107
-#define TARGET_NR_fstat              108
-#define TARGET_NR_lookup_dcookie     110
-#define TARGET_NR_vhangup            111
-#define TARGET_NR_idle               112
-#define TARGET_NR_wait4              114
-#define TARGET_NR_swapoff            115
-#define TARGET_NR_sysinfo            116
-#define TARGET_NR_ipc                117
-#define TARGET_NR_fsync              118
-#define TARGET_NR_sigreturn          119
-#define TARGET_NR_clone              120
-#define TARGET_NR_setdomainname      121
-#define TARGET_NR_uname              122
-#define TARGET_NR_adjtimex           124
-#define TARGET_NR_mprotect           125
-#define TARGET_NR_sigprocmask        126
-#define TARGET_NR_create_module      127
-#define TARGET_NR_init_module        128
-#define TARGET_NR_delete_module      129
-#define TARGET_NR_get_kernel_syms    130
-#define TARGET_NR_quotactl           131
-#define TARGET_NR_getpgid            132
-#define TARGET_NR_fchdir             133
-#define TARGET_NR_bdflush            134
-#define TARGET_NR_sysfs              135
-#define TARGET_NR_personality        136
-#define TARGET_NR_afs_syscall        137 /* Syscall for Andrew File System */
-#define TARGET_NR_getdents           141
-#define TARGET_NR_select                142
-#define TARGET_NR_flock              143
-#define TARGET_NR_msync              144
-#define TARGET_NR_readv              145
-#define TARGET_NR_writev             146
-#define TARGET_NR_getsid             147
-#define TARGET_NR_fdatasync          148
-#define TARGET_NR__sysctl            149
-#define TARGET_NR_mlock              150
-#define TARGET_NR_munlock            151
-#define TARGET_NR_mlockall           152
-#define TARGET_NR_munlockall         153
-#define TARGET_NR_sched_setparam             154
-#define TARGET_NR_sched_getparam             155
-#define TARGET_NR_sched_setscheduler         156
-#define TARGET_NR_sched_getscheduler         157
-#define TARGET_NR_sched_yield                158
-#define TARGET_NR_sched_get_priority_max     159
-#define TARGET_NR_sched_get_priority_min     160
-#define TARGET_NR_sched_rr_get_interval      161
-#define TARGET_NR_nanosleep          162
-#define TARGET_NR_mremap             163
-#define TARGET_NR_query_module       167
-#define TARGET_NR_poll               168
-#define TARGET_NR_nfsservctl         169
-#define TARGET_NR_prctl              172
-#define TARGET_NR_rt_sigreturn       173
-#define TARGET_NR_rt_sigaction       174
-#define TARGET_NR_rt_sigprocmask     175
-#define TARGET_NR_rt_sigpending      176
-#define TARGET_NR_rt_sigtimedwait    177
-#define TARGET_NR_rt_sigqueueinfo    178
-#define TARGET_NR_rt_sigsuspend      179
-#define TARGET_NR_pread64            180
-#define TARGET_NR_pwrite64           181
-#define TARGET_NR_getcwd             183
-#define TARGET_NR_capget             184
-#define TARGET_NR_capset             185
-#define TARGET_NR_sigaltstack        186
-#define TARGET_NR_sendfile           187
-#define TARGET_NR_getpmsg               188
-#define TARGET_NR_putpmsg               189
-#define TARGET_NR_vfork         190
-#define TARGET_NR_getrlimit             191     /* SuS compliant getrlimit */
-#define TARGET_NR_lchown                198
-#define TARGET_NR_getuid                199
-#define TARGET_NR_getgid                200
-#define TARGET_NR_geteuid               201
-#define TARGET_NR_getegid               202
-#define TARGET_NR_setreuid              203
-#define TARGET_NR_setregid              204
-#define TARGET_NR_getgroups     205
-#define TARGET_NR_setgroups     206
-#define TARGET_NR_fchown                207
-#define TARGET_NR_setresuid     208
-#define TARGET_NR_getresuid     209
-#define TARGET_NR_setresgid     210
-#define TARGET_NR_getresgid     211
-#define TARGET_NR_chown                 212
-#define TARGET_NR_setuid                213
-#define TARGET_NR_setgid                214
-#define TARGET_NR_setfsuid              215
-#define TARGET_NR_setfsgid              216
-#define TARGET_NR_pivot_root         217
-#define TARGET_NR_mincore            218
-#define TARGET_NR_madvise            219
-#define TARGET_NR_getdents64            220
-#define TARGET_NR_readahead             222
-#define TARGET_NR_setxattr              224
-#define TARGET_NR_lsetxattr             225
-#define TARGET_NR_fsetxattr             226
-#define TARGET_NR_getxattr              227
-#define TARGET_NR_lgetxattr             228
-#define TARGET_NR_fgetxattr             229
-#define TARGET_NR_listxattr             230
-#define TARGET_NR_llistxattr            231
-#define TARGET_NR_flistxattr            232
-#define TARGET_NR_removexattr   233
-#define TARGET_NR_lremovexattr  234
-#define TARGET_NR_fremovexattr  235
-#define TARGET_NR_gettid                236
-#define TARGET_NR_tkill         237
-#define TARGET_NR_futex         238
-#define TARGET_NR_sched_setaffinity     239
-#define TARGET_NR_sched_getaffinity     240
-#define TARGET_NR_tgkill                241
-/* Number 242 is reserved for tux */
-#define TARGET_NR_io_setup              243
-#define TARGET_NR_io_destroy            244
-#define TARGET_NR_io_getevents  245
-#define TARGET_NR_io_submit             246
-#define TARGET_NR_io_cancel             247
-#define TARGET_NR_exit_group            248
-#define TARGET_NR_epoll_create  249
-#define TARGET_NR_epoll_ctl             250
-#define TARGET_NR_epoll_wait            251
-#define TARGET_NR_set_tid_address       252
-#define TARGET_NR_fadvise64             253
-#define TARGET_NR_timer_create  254
-#define TARGET_NR_timer_settime (TARGET_NR_timer_create + 1)
-#define TARGET_NR_timer_gettime (TARGET_NR_timer_create + 2)
-#define TARGET_NR_timer_getoverrun      (TARGET_NR_timer_create + 3)
-#define TARGET_NR_timer_delete  (TARGET_NR_timer_create + 4)
-#define TARGET_NR_clock_settime (TARGET_NR_timer_create + 5)
-#define TARGET_NR_clock_gettime (TARGET_NR_timer_create + 6)
-#define TARGET_NR_clock_getres  (TARGET_NR_timer_create + 7)
-#define TARGET_NR_clock_nanosleep       (TARGET_NR_timer_create + 8)
-/* Number 263 is reserved for vserver */
-#define TARGET_NR_statfs64              265
-#define TARGET_NR_fstatfs64             266
-#define TARGET_NR_remap_file_pages      267
-/* Number 268 is reserved for new sys_mbind */
-/* Number 269 is reserved for new sys_get_mempolicy */
-/* Number 270 is reserved for new sys_set_mempolicy */
-#define TARGET_NR_mq_open               271
-#define TARGET_NR_mq_unlink             272
-#define TARGET_NR_mq_timedsend  273
-#define TARGET_NR_mq_timedreceive       274
-#define TARGET_NR_mq_notify             275
-#define TARGET_NR_mq_getsetattr 276
-#define TARGET_NR_kexec_load            277
-#define TARGET_NR_add_key               278
-#define TARGET_NR_request_key   279
-#define TARGET_NR_keyctl                280
-#define TARGET_NR_waitid                281
-#define TARGET_NR_ioprio_set            282
-#define TARGET_NR_ioprio_get            283
-#define TARGET_NR_inotify_init  284
-#define TARGET_NR_inotify_add_watch     285
-#define TARGET_NR_inotify_rm_watch      286
-/* Number 287 is reserved for new sys_migrate_pages */
-#define TARGET_NR_openat                288
-#define TARGET_NR_mkdirat               289
-#define TARGET_NR_mknodat               290
-#define TARGET_NR_fchownat              291
-#define TARGET_NR_futimesat             292
-#define TARGET_NR_newfstatat            293
-#define TARGET_NR_unlinkat              294
-#define TARGET_NR_renameat              295
-#define TARGET_NR_linkat                296
-#define TARGET_NR_symlinkat             297
-#define TARGET_NR_readlinkat            298
-#define TARGET_NR_fchmodat              299
-#define TARGET_NR_faccessat             300
-#define TARGET_NR_pselect6              301
-#define TARGET_NR_ppoll         302
-#define TARGET_NR_unshare               303
-#define TARGET_NR_set_robust_list       304
-#define TARGET_NR_get_robust_list       305
-#define TARGET_NR_splice                306
-#define TARGET_NR_sync_file_range       307
-#define TARGET_NR_tee           308
-#define TARGET_NR_vmsplice              309
-/* Number 310 is reserved for new sys_move_pages */
-#define TARGET_NR_getcpu                311
-#define TARGET_NR_epoll_pwait   312
-#define TARGET_NR_utimes                313
-#define TARGET_NR_fallocate             314
-#define TARGET_NR_utimensat             315
-#define TARGET_NR_signalfd              316
-#define TARGET_NR_timerfd               317
-#define TARGET_NR_eventfd               318
-#define TARGET_NR_timerfd_create        319
-#define TARGET_NR_timerfd_settime       320
-#define TARGET_NR_timerfd_gettime       321
-#define TARGET_NR_signalfd4             322
-#define TARGET_NR_eventfd2              323
-#define TARGET_NR_inotify_init1 324
-#define TARGET_NR_pipe2         325
-#define TARGET_NR_dup3          326
-#define TARGET_NR_epoll_create1 327
-#define TARGET_NR_preadv                328
-#define TARGET_NR_pwritev               329
-#define TARGET_NR_rt_tgsigqueueinfo     330
-#define TARGET_NR_perf_event_open       331
-#define TARGET_NR_fanotify_init         332
-#define TARGET_NR_fanotify_mark         333
-#define TARGET_NR_prlimit64             334
-#define TARGET_NR_name_to_handle_at     335
-#define TARGET_NR_open_by_handle_at     336
-#define TARGET_NR_clock_adjtime         337
-#define TARGET_NR_syncfs                338
-#define TARGET_NR_setns                 339
-#define TARGET_NR_process_vm_readv      340
-#define TARGET_NR_process_vm_writev     341
-#define TARGET_NR_s390_runtime_instr    342
-#define TARGET_NR_kcmp                  343
-#define TARGET_NR_finit_module          344
-#define TARGET_NR_sched_setattr         345
-#define TARGET_NR_sched_getattr         346
-#define TARGET_NR_renameat2             347
-#define TARGET_NR_seccomp               348
-#define TARGET_NR_getrandom             349
-#define TARGET_NR_memfd_create          350
-#define TARGET_NR_bpf                   351
-#define TARGET_NR_s390_pci_mmio_write   352
-#define TARGET_NR_s390_pci_mmio_read    353
-#define TARGET_NR_execveat              354
-#define TARGET_NR_userfaultfd           355
-#define TARGET_NR_membarrier            356
-#define TARGET_NR_recvmmsg              357
-#define TARGET_NR_sendmmsg              358
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
-#define TARGET_NR_mlock2                374
-
-
-#endif
diff --git a/linux-user/s390x/syscallhdr.sh b/linux-user/s390x/syscallhdr.sh
new file mode 100755
index 000000000000..85a99c48deea
--- /dev/null
+++ b/linux-user/s390x/syscallhdr.sh
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
+fileguard=LINUX_USER_S390X_`basename "$out" | sed \
+    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
+    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
+    printf "#ifndef %s\n" "${fileguard}"
+    printf "#define %s\n" "${fileguard}"
+    printf "\n"
+
+    nxt=0
+    while read nr abi name entry ; do
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
+    printf "#endif /* %s */\n" "${fileguard}"
+) > "$out"
-- 
2.24.1


