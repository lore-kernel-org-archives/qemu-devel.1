Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43463C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD13A24649
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD13A24649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcI8-0001tV-3o
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBcEW-0004ue-Lq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBcEM-0000po-B5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:35:32 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37495)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBcE1-0008TO-TI; Tue, 10 Mar 2020 06:35:02 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MG9Pg-1j8Hks0DfQ-00GVoX; Tue, 10 Mar 2020 11:34:27 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/21] linux-user, sparc,
 sparc64: add syscall table generation support
Date: Tue, 10 Mar 2020 11:33:54 +0100
Message-Id: <20200310103403.3284090-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310103403.3284090-1-laurent@vivier.eu>
References: <20200310103403.3284090-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DoMGV7vTQLHYeV36ZBkNRQSE2YYJEnR0CkIRoJiC8pxQ8zjmxk7
 XZCqDk7q6pYh/aChHkGhsJ/WlflLYCzKz5kiv/hoLgD1n7AvShHpxmQ1b1P7YBhnfWiTMjS
 BzfSWk9of5u7uqU3qIq5VaXE4O6yhBL3HE0ofTjzIfMl22L1aqQQ38z8Arsa18d4u8u7ypi
 gzdhCu1PHTQc1pVXvxo3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sMNs+VE8dic=:bX4jxoAHtWa43tFOf5hDeM
 rk4TXvsnuCByyQd2Pi6BIdTsGTNmAMzm3FRimL/yW99RFytwm69Rxua8lgjeKEORGg/nG0EZR
 U02SFqDt91hYhkfPOI/NHRiQa/VpMxlSGEwyAYl3Mc9sgoCbp84ls+7hLW+X/HUxNeKVJQPyt
 m0Rwm1HcIpXKbB3aUHi+fKgUhwzwW71eqfdS8eLgydyy4p281qLLyAJT3C1IFI6buaRlClgxB
 hlXCo6b1wVTHUiNaMtRfCexQAduo6iXiyZdlkabvZ2mfPpnm3oL7KDAaK9BB8tr176trNsQUl
 USTUHNsQiOtl+skUwo7VRuEnLcB26lRVl20XFIQf1NRtbRCMb+f/+E/ZmgjI/mkEEoLUzqH1H
 IOLFi5KUrZ73WnlmbDEA8IP/4hfonr7jYxhnJ2BQ6THy0h82Qpu+YuRTKmoDGXjccirvrmF4M
 qbBWMTV21L8X6oZyPG3D5q/+uwa6uMpAOnWYn4YauZVV5wUf2y7txz93NxxE78lrKK1kXJAMw
 xrwyzl3C18yNkQx6XvX7CD7BIMCYDlo0zWyuvIFi1BDEvDOlTxDK6MmMyF+ENhOcOH82pS46e
 qNW1BGkPmTwz8VSe1BHm7hZc6Z/eBnj1lRpw4UNo2uAgGDikm7inYqWbUB73O1/9jAYfnSkJE
 XLl2FVdwnginrTgmT8HchBhSFVy3uEt64o/OuEG7KuVDoXhxmfpUak7tNP81OoaNhDW+/QqN8
 Ca/UVUy5yCG924AykqeAhNHcFPzeftgRx6AuYOENwwRNxeREy0GLDWxJMJeg5iERlGZciJ+DU
 BPbo/WV0YhRm26TPCW34HUYXxpG5NMlK375qike8RrkZzN6csfJj5H2bn5VRo6N44qp66N7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Copy syscall.tbl and syscallhdr.sh from linux/arch/sparc/kernel/syscalls v5.5
Update syscallhdr.sh to generate QEMU syscall_nr.h

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
---
 configure                        |   6 +-
 linux-user/Makefile.objs         |   2 +
 linux-user/sparc/Makefile.objs   |   5 +
 linux-user/sparc/syscall.tbl     | 483 +++++++++++++++++++++++++++++++
 linux-user/sparc/syscall_nr.h    | 363 -----------------------
 linux-user/sparc/syscallhdr.sh   |  32 ++
 linux-user/sparc64/Makefile.objs |   5 +
 linux-user/sparc64/syscall.tbl   | 483 +++++++++++++++++++++++++++++++
 linux-user/sparc64/syscall_nr.h  | 366 -----------------------
 linux-user/sparc64/syscallhdr.sh |  32 ++
 10 files changed, 1047 insertions(+), 730 deletions(-)
 create mode 100644 linux-user/sparc/Makefile.objs
 create mode 100644 linux-user/sparc/syscall.tbl
 delete mode 100644 linux-user/sparc/syscall_nr.h
 create mode 100644 linux-user/sparc/syscallhdr.sh
 create mode 100644 linux-user/sparc64/Makefile.objs
 create mode 100644 linux-user/sparc64/syscall.tbl
 delete mode 100644 linux-user/sparc64/syscall_nr.h
 create mode 100644 linux-user/sparc64/syscallhdr.sh

diff --git a/configure b/configure
index 8805fab48279..0f063c368f2a 100755
--- a/configure
+++ b/configure
@@ -1889,7 +1889,8 @@ rm -f */config-devices.mak.d
 
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
-for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc s390x ; do
+for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc s390x sparc sparc64 \
+    ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
@@ -7901,14 +7902,17 @@ case "$target_name" in
     bflt="yes"
   ;;
   sparc)
+    TARGET_SYSTBL_ABI=common,32
   ;;
   sparc64)
     TARGET_BASE_ARCH=sparc
+    TARGET_SYSTBL_ABI=common,64
   ;;
   sparc32plus)
     TARGET_ARCH=sparc64
     TARGET_BASE_ARCH=sparc
     TARGET_ABI_DIR=sparc
+    TARGET_SYSTBL_ABI=common,32
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
   s390x)
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index f4e666e74c91..36f20cad794c 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -16,4 +16,6 @@ obj-$(TARGET_PPC) += ppc/
 obj-$(TARGET_PPC64) += ppc/
 obj-$(TARGET_S390X) += s390x/
 obj-$(TARGET_SH4) += sh4/
+obj-$(TARGET_SPARC) += sparc/
+obj-$(TARGET_SPARC64) += $(TARGET_ABI_DIR)/
 obj-$(TARGET_XTENSA) += xtensa/
diff --git a/linux-user/sparc/Makefile.objs b/linux-user/sparc/Makefile.objs
new file mode 100644
index 000000000000..29d3f066cbab
--- /dev/null
+++ b/linux-user/sparc/Makefile.objs
@@ -0,0 +1,5 @@
+generated-files-y += linux-user/sparc/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/sparc/syscallhdr.sh
+%/syscall_nr.h: $(SRC_PATH)/linux-user/sparc/syscall.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/sparc/syscall.tbl b/linux-user/sparc/syscall.tbl
new file mode 100644
index 000000000000..8c8cc7537fb2
--- /dev/null
+++ b/linux-user/sparc/syscall.tbl
@@ -0,0 +1,483 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for sparc
+#
+# The format is:
+# <number> <abi> <name> <entry point> <compat entry point>
+#
+# The <abi> can be common, 64, or 32 for this file.
+#
+0	common	restart_syscall		sys_restart_syscall
+1	32	exit			sys_exit			sparc_exit
+1	64	exit			sparc_exit
+2	common	fork			sys_fork
+3	common	read			sys_read
+4	common	write			sys_write
+5	common	open			sys_open			compat_sys_open
+6	common	close			sys_close
+7	common	wait4			sys_wait4			compat_sys_wait4
+8	common	creat			sys_creat
+9	common	link			sys_link
+10	common	unlink			sys_unlink
+11	32	execv			sunos_execv
+11	64	execv			sys_nis_syscall
+12	common	chdir			sys_chdir
+13	32    	chown			sys_chown16
+13	64	chown			sys_chown
+14	common	mknod			sys_mknod
+15	common	chmod			sys_chmod
+16	32	lchown			sys_lchown16
+16	64	lchown			sys_lchown
+17	common	brk			sys_brk
+18	common	perfctr			sys_nis_syscall
+19	common	lseek			sys_lseek			compat_sys_lseek
+20	common	getpid			sys_getpid
+21	common	capget			sys_capget
+22	common	capset			sys_capset
+23	32    	setuid			sys_setuid16
+23	64    	setuid			sys_setuid
+24	32	getuid			sys_getuid16
+24	64   	getuid			sys_getuid
+25	common	vmsplice		sys_vmsplice			compat_sys_vmsplice
+26	common	ptrace			sys_ptrace			compat_sys_ptrace
+27	common	alarm			sys_alarm
+28	common	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
+29	32    	pause			sys_pause
+29	64    	pause			sys_nis_syscall
+30	32	utime			sys_utime32
+30	64	utime			sys_utime
+31	32    	lchown32		sys_lchown
+32	32    	fchown32		sys_fchown
+33	common	access			sys_access
+34	common	nice			sys_nice
+35	32    	chown32			sys_chown
+36	common	sync			sys_sync
+37	common	kill			sys_kill
+38	common	stat			sys_newstat			compat_sys_newstat
+39	32	sendfile		sys_sendfile			compat_sys_sendfile
+39	64	sendfile		sys_sendfile64
+40	common	lstat			sys_newlstat			compat_sys_newlstat
+41	common	dup			sys_dup
+42	common	pipe			sys_sparc_pipe
+43	common	times			sys_times			compat_sys_times
+44	32    	getuid32		sys_getuid
+45	common	umount2			sys_umount
+46	32	setgid			sys_setgid16
+46	64	setgid			sys_setgid
+47	32	getgid			sys_getgid16
+47	64	getgid			sys_getgid
+48	common	signal			sys_signal
+49	32	geteuid			sys_geteuid16
+49	64	geteuid			sys_geteuid
+50	32	getegid			sys_getegid16
+50	64	getegid			sys_getegid
+51	common	acct			sys_acct
+52	64	memory_ordering		sys_memory_ordering
+53	32	getgid32		sys_getgid
+54	common	ioctl			sys_ioctl			compat_sys_ioctl
+55	common	reboot			sys_reboot
+56	32    	mmap2			sys_mmap2			sys32_mmap2
+57	common	symlink			sys_symlink
+58	common	readlink		sys_readlink
+59	32	execve			sys_execve			sys32_execve
+59	64	execve			sys64_execve
+60	common	umask			sys_umask
+61	common	chroot			sys_chroot
+62	common	fstat			sys_newfstat			compat_sys_newfstat
+63	common	fstat64			sys_fstat64			compat_sys_fstat64
+64	common	getpagesize		sys_getpagesize
+65	common	msync			sys_msync
+66	common	vfork			sys_vfork
+67	common	pread64			sys_pread64			compat_sys_pread64
+68	common	pwrite64		sys_pwrite64			compat_sys_pwrite64
+69	32    	geteuid32		sys_geteuid
+70	32	getegid32		sys_getegid
+71	common	mmap			sys_mmap
+72	32	setreuid32		sys_setreuid
+73	32	munmap			sys_munmap
+73	64	munmap			sys_64_munmap
+74	common	mprotect		sys_mprotect
+75	common	madvise			sys_madvise
+76	common	vhangup			sys_vhangup
+77	32	truncate64		sys_truncate64			compat_sys_truncate64
+78	common	mincore			sys_mincore
+79	32	getgroups		sys_getgroups16
+79	64	getgroups		sys_getgroups
+80	32	setgroups		sys_setgroups16
+80	64	setgroups		sys_setgroups
+81	common	getpgrp			sys_getpgrp
+82	32	setgroups32		sys_setgroups
+83	common	setitimer		sys_setitimer			compat_sys_setitimer
+84	32	ftruncate64		sys_ftruncate64			compat_sys_ftruncate64
+85	common	swapon			sys_swapon
+86	common	getitimer		sys_getitimer			compat_sys_getitimer
+87	32	setuid32		sys_setuid
+88	common	sethostname		sys_sethostname
+89	32	setgid32		sys_setgid
+90	common	dup2			sys_dup2
+91	32	setfsuid32		sys_setfsuid
+92	common	fcntl			sys_fcntl			compat_sys_fcntl
+93	common	select			sys_select
+94	32	setfsgid32		sys_setfsgid
+95	common	fsync			sys_fsync
+96	common	setpriority		sys_setpriority
+97	common	socket			sys_socket
+98	common	connect			sys_connect
+99	common	accept			sys_accept
+100	common	getpriority		sys_getpriority
+101	common	rt_sigreturn		sys_rt_sigreturn		sys32_rt_sigreturn
+102	common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
+103	common	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+104	common	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
+105	32	rt_sigtimedwait		sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+105	64	rt_sigtimedwait		sys_rt_sigtimedwait
+106	common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+107	common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+108	32	setresuid32		sys_setresuid
+108	64	setresuid		sys_setresuid
+109	32	getresuid32		sys_getresuid
+109	64	getresuid		sys_getresuid
+110	32	setresgid32		sys_setresgid
+110	64	setresgid		sys_setresgid
+111	32	getresgid32		sys_getresgid
+111	64	getresgid		sys_getresgid
+112	32	setregid32		sys_setregid
+113	common	recvmsg			sys_recvmsg			compat_sys_recvmsg
+114	common	sendmsg			sys_sendmsg			compat_sys_sendmsg
+115	32	getgroups32		sys_getgroups
+116	common	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
+117	common	getrusage		sys_getrusage			compat_sys_getrusage
+118	common	getsockopt		sys_getsockopt			compat_sys_getsockopt
+119	common	getcwd			sys_getcwd
+120	common	readv			sys_readv			compat_sys_readv
+121	common	writev			sys_writev			compat_sys_writev
+122	common	settimeofday		sys_settimeofday		compat_sys_settimeofday
+123	32	fchown			sys_fchown16
+123	64	fchown			sys_fchown
+124	common	fchmod			sys_fchmod
+125	common	recvfrom		sys_recvfrom
+126	32	setreuid		sys_setreuid16
+126	64	setreuid		sys_setreuid
+127	32	setregid		sys_setregid16
+127	64	setregid		sys_setregid
+128	common	rename			sys_rename
+129	common	truncate		sys_truncate			compat_sys_truncate
+130	common	ftruncate		sys_ftruncate			compat_sys_ftruncate
+131	common	flock			sys_flock
+132	common	lstat64			sys_lstat64			compat_sys_lstat64
+133	common	sendto			sys_sendto
+134	common	shutdown		sys_shutdown
+135	common	socketpair		sys_socketpair
+136	common	mkdir			sys_mkdir
+137	common	rmdir			sys_rmdir
+138	32	utimes			sys_utimes_time32
+138	64	utimes			sys_utimes
+139	common	stat64			sys_stat64			compat_sys_stat64
+140	common	sendfile64		sys_sendfile64
+141	common	getpeername		sys_getpeername
+142	32	futex			sys_futex_time32
+142	64	futex			sys_futex
+143	common	gettid			sys_gettid
+144	common	getrlimit		sys_getrlimit			compat_sys_getrlimit
+145	common	setrlimit		sys_setrlimit			compat_sys_setrlimit
+146	common	pivot_root		sys_pivot_root
+147	common	prctl			sys_prctl
+148	common	pciconfig_read		sys_pciconfig_read
+149	common	pciconfig_write		sys_pciconfig_write
+150	common	getsockname		sys_getsockname
+151	common	inotify_init		sys_inotify_init
+152	common	inotify_add_watch	sys_inotify_add_watch
+153	common	poll			sys_poll
+154	common	getdents64		sys_getdents64
+155	32	fcntl64			sys_fcntl64			compat_sys_fcntl64
+156	common	inotify_rm_watch	sys_inotify_rm_watch
+157	common	statfs			sys_statfs			compat_sys_statfs
+158	common	fstatfs			sys_fstatfs			compat_sys_fstatfs
+159	common	umount			sys_oldumount
+160	common	sched_set_affinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
+161	common	sched_get_affinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
+162	common	getdomainname		sys_getdomainname
+163	common	setdomainname		sys_setdomainname
+164	64	utrap_install		sys_utrap_install
+165	common	quotactl		sys_quotactl
+166	common	set_tid_address		sys_set_tid_address
+167	common	mount			sys_mount			compat_sys_mount
+168	common	ustat			sys_ustat			compat_sys_ustat
+169	common	setxattr		sys_setxattr
+170	common	lsetxattr		sys_lsetxattr
+171	common	fsetxattr		sys_fsetxattr
+172	common	getxattr		sys_getxattr
+173	common	lgetxattr		sys_lgetxattr
+174	common	getdents		sys_getdents			compat_sys_getdents
+175	common	setsid			sys_setsid
+176	common	fchdir			sys_fchdir
+177	common	fgetxattr		sys_fgetxattr
+178	common	listxattr		sys_listxattr
+179	common	llistxattr		sys_llistxattr
+180	common	flistxattr		sys_flistxattr
+181	common	removexattr		sys_removexattr
+182	common	lremovexattr		sys_lremovexattr
+183	32	sigpending		sys_sigpending			compat_sys_sigpending
+183	64	sigpending		sys_nis_syscall
+184	common	query_module		sys_ni_syscall
+185	common	setpgid			sys_setpgid
+186	common	fremovexattr		sys_fremovexattr
+187	common	tkill			sys_tkill
+188	32	exit_group		sys_exit_group			sparc_exit_group
+188	64	exit_group		sparc_exit_group
+189	common	uname			sys_newuname
+190	common	init_module		sys_init_module
+191	32	personality		sys_personality			sys_sparc64_personality
+191	64	personality		sys_sparc64_personality
+192	32	remap_file_pages	sys_sparc_remap_file_pages	sys_remap_file_pages
+192	64	remap_file_pages	sys_remap_file_pages
+193	common	epoll_create		sys_epoll_create
+194	common	epoll_ctl		sys_epoll_ctl
+195	common	epoll_wait		sys_epoll_wait
+196	common	ioprio_set		sys_ioprio_set
+197	common	getppid			sys_getppid
+198	32	sigaction		sys_sparc_sigaction		compat_sys_sparc_sigaction
+198	64	sigaction		sys_nis_syscall
+199	common	sgetmask		sys_sgetmask
+200	common	ssetmask		sys_ssetmask
+201	32	sigsuspend		sys_sigsuspend
+201	64	sigsuspend		sys_nis_syscall
+202	common	oldlstat		sys_newlstat			compat_sys_newlstat
+203	common	uselib			sys_uselib
+204	32	readdir			sys_old_readdir			compat_sys_old_readdir
+204	64	readdir			sys_nis_syscall
+205	common	readahead		sys_readahead			compat_sys_readahead
+206	common	socketcall		sys_socketcall			sys32_socketcall
+207	common	syslog			sys_syslog
+208	common	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
+209	common	fadvise64		sys_fadvise64			compat_sys_fadvise64
+210	common	fadvise64_64		sys_fadvise64_64		compat_sys_fadvise64_64
+211	common	tgkill			sys_tgkill
+212	common	waitpid			sys_waitpid
+213	common	swapoff			sys_swapoff
+214	common	sysinfo			sys_sysinfo			compat_sys_sysinfo
+215	32	ipc			sys_ipc				compat_sys_ipc
+215	64	ipc			sys_sparc_ipc
+216	32	sigreturn		sys_sigreturn			sys32_sigreturn
+216	64	sigreturn		sys_nis_syscall
+217	common	clone			sys_clone
+218	common	ioprio_get		sys_ioprio_get
+219	32	adjtimex		sys_adjtimex_time32
+219	64	adjtimex		sys_sparc_adjtimex
+220	32	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
+220	64	sigprocmask		sys_nis_syscall
+221	common	create_module		sys_ni_syscall
+222	common	delete_module		sys_delete_module
+223	common	get_kernel_syms		sys_ni_syscall
+224	common	getpgid			sys_getpgid
+225	common	bdflush			sys_bdflush
+226	common	sysfs			sys_sysfs
+227	common	afs_syscall		sys_nis_syscall
+228	common	setfsuid		sys_setfsuid16
+229	common	setfsgid		sys_setfsgid16
+230	common	_newselect		sys_select			compat_sys_select
+231	32	time			sys_time32
+232	common	splice			sys_splice
+233	32	stime			sys_stime32
+233	64	stime			sys_stime
+234	common	statfs64		sys_statfs64			compat_sys_statfs64
+235	common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
+236	common	_llseek			sys_llseek
+237	common	mlock			sys_mlock
+238	common	munlock			sys_munlock
+239	common	mlockall		sys_mlockall
+240	common	munlockall		sys_munlockall
+241	common	sched_setparam		sys_sched_setparam
+242	common	sched_getparam		sys_sched_getparam
+243	common	sched_setscheduler	sys_sched_setscheduler
+244	common	sched_getscheduler	sys_sched_getscheduler
+245	common	sched_yield		sys_sched_yield
+246	common	sched_get_priority_max	sys_sched_get_priority_max
+247	common	sched_get_priority_min	sys_sched_get_priority_min
+248	32	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+248	64	sched_rr_get_interval	sys_sched_rr_get_interval
+249	32	nanosleep		sys_nanosleep_time32
+249	64	nanosleep		sys_nanosleep
+250	32	mremap			sys_mremap
+250	64	mremap			sys_64_mremap
+251	common	_sysctl			sys_sysctl			compat_sys_sysctl
+252	common	getsid			sys_getsid
+253	common	fdatasync		sys_fdatasync
+254	32	nfsservctl		sys_ni_syscall			sys_nis_syscall
+254	64	nfsservctl		sys_nis_syscall
+255	common	sync_file_range		sys_sync_file_range		compat_sys_sync_file_range
+256	32	clock_settime		sys_clock_settime32
+256	64	clock_settime		sys_clock_settime
+257	32	clock_gettime		sys_clock_gettime32
+257	64	clock_gettime		sys_clock_gettime
+258	32	clock_getres		sys_clock_getres_time32
+258	64	clock_getres		sys_clock_getres
+259	32	clock_nanosleep		sys_clock_nanosleep_time32
+259	64	clock_nanosleep		sys_clock_nanosleep
+260	common	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
+261	common	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
+262	32	timer_settime		sys_timer_settime32
+262	64	timer_settime		sys_timer_settime
+263	32	timer_gettime		sys_timer_gettime32
+263	64	timer_gettime		sys_timer_gettime
+264	common	timer_getoverrun	sys_timer_getoverrun
+265	common	timer_delete		sys_timer_delete
+266	common	timer_create		sys_timer_create		compat_sys_timer_create
+# 267 was vserver
+267	common	vserver			sys_nis_syscall
+268	common	io_setup		sys_io_setup			compat_sys_io_setup
+269	common	io_destroy		sys_io_destroy
+270	common	io_submit		sys_io_submit			compat_sys_io_submit
+271	common	io_cancel		sys_io_cancel
+272	32	io_getevents		sys_io_getevents_time32
+272	64	io_getevents		sys_io_getevents
+273	common	mq_open			sys_mq_open			compat_sys_mq_open
+274	common	mq_unlink		sys_mq_unlink
+275	32	mq_timedsend		sys_mq_timedsend_time32
+275	64	mq_timedsend		sys_mq_timedsend
+276	32	mq_timedreceive		sys_mq_timedreceive_time32
+276	64	mq_timedreceive		sys_mq_timedreceive
+277	common	mq_notify		sys_mq_notify			compat_sys_mq_notify
+278	common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
+279	common	waitid			sys_waitid			compat_sys_waitid
+280	common	tee			sys_tee
+281	common	add_key			sys_add_key
+282	common	request_key		sys_request_key
+283	common	keyctl			sys_keyctl			compat_sys_keyctl
+284	common	openat			sys_openat			compat_sys_openat
+285	common	mkdirat			sys_mkdirat
+286	common	mknodat			sys_mknodat
+287	common	fchownat		sys_fchownat
+288	32	futimesat		sys_futimesat_time32
+288	64	futimesat		sys_futimesat
+289	common	fstatat64		sys_fstatat64			compat_sys_fstatat64
+290	common	unlinkat		sys_unlinkat
+291	common	renameat		sys_renameat
+292	common	linkat			sys_linkat
+293	common	symlinkat		sys_symlinkat
+294	common	readlinkat		sys_readlinkat
+295	common	fchmodat		sys_fchmodat
+296	common	faccessat		sys_faccessat
+297	32	pselect6		sys_pselect6_time32		compat_sys_pselect6_time32
+297	64	pselect6		sys_pselect6
+298	32	ppoll			sys_ppoll_time32		compat_sys_ppoll_time32
+298	64	ppoll			sys_ppoll
+299	common	unshare			sys_unshare
+300	common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
+301	common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
+302	common	migrate_pages		sys_migrate_pages		compat_sys_migrate_pages
+303	common	mbind			sys_mbind			compat_sys_mbind
+304	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
+305	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
+306	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
+307	common	move_pages		sys_move_pages			compat_sys_move_pages
+308	common	getcpu			sys_getcpu
+309	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
+310	32	utimensat		sys_utimensat_time32
+310	64	utimensat		sys_utimensat
+311	common	signalfd		sys_signalfd			compat_sys_signalfd
+312	common	timerfd_create		sys_timerfd_create
+313	common	eventfd			sys_eventfd
+314	common	fallocate		sys_fallocate			compat_sys_fallocate
+315	32	timerfd_settime		sys_timerfd_settime32
+315	64	timerfd_settime		sys_timerfd_settime
+316	32	timerfd_gettime		sys_timerfd_gettime32
+316	64	timerfd_gettime		sys_timerfd_gettime
+317	common	signalfd4		sys_signalfd4			compat_sys_signalfd4
+318	common	eventfd2		sys_eventfd2
+319	common	epoll_create1		sys_epoll_create1
+320	common	dup3			sys_dup3
+321	common	pipe2			sys_pipe2
+322	common	inotify_init1		sys_inotify_init1
+323	common	accept4			sys_accept4
+324	common	preadv			sys_preadv			compat_sys_preadv
+325	common	pwritev			sys_pwritev			compat_sys_pwritev
+326	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+327	common	perf_event_open		sys_perf_event_open
+328	32	recvmmsg		sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+328	64	recvmmsg		sys_recvmmsg
+329	common	fanotify_init		sys_fanotify_init
+330	common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
+331	common	prlimit64		sys_prlimit64
+332	common	name_to_handle_at	sys_name_to_handle_at
+333	common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
+334	32	clock_adjtime		sys_clock_adjtime32
+334	64	clock_adjtime		sys_sparc_clock_adjtime
+335	common	syncfs			sys_syncfs
+336	common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
+337	common	setns			sys_setns
+338	common	process_vm_readv	sys_process_vm_readv		compat_sys_process_vm_readv
+339	common	process_vm_writev	sys_process_vm_writev		compat_sys_process_vm_writev
+340	32	kern_features		sys_ni_syscall			sys_kern_features
+340	64	kern_features		sys_kern_features
+341	common	kcmp			sys_kcmp
+342	common	finit_module		sys_finit_module
+343	common	sched_setattr		sys_sched_setattr
+344	common	sched_getattr		sys_sched_getattr
+345	common	renameat2		sys_renameat2
+346	common	seccomp			sys_seccomp
+347	common	getrandom		sys_getrandom
+348	common	memfd_create		sys_memfd_create
+349	common	bpf			sys_bpf
+350	32	execveat		sys_execveat			sys32_execveat
+350	64	execveat		sys64_execveat
+351	common	membarrier		sys_membarrier
+352	common	userfaultfd		sys_userfaultfd
+353	common	bind			sys_bind
+354	common	listen			sys_listen
+355	common	setsockopt		sys_setsockopt			compat_sys_setsockopt
+356	common	mlock2			sys_mlock2
+357	common	copy_file_range		sys_copy_file_range
+358	common	preadv2			sys_preadv2			compat_sys_preadv2
+359	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
+360	common	statx			sys_statx
+361	32	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
+361	64	io_pgetevents		sys_io_pgetevents
+362	common	pkey_mprotect		sys_pkey_mprotect
+363	common	pkey_alloc		sys_pkey_alloc
+364	common	pkey_free		sys_pkey_free
+365	common	rseq			sys_rseq
+# room for arch specific syscalls
+392	64	semtimedop			sys_semtimedop
+393	common	semget			sys_semget
+394	common	semctl			sys_semctl			compat_sys_semctl
+395	common	shmget			sys_shmget
+396	common	shmctl			sys_shmctl			compat_sys_shmctl
+397	common	shmat			sys_shmat			compat_sys_shmat
+398	common	shmdt			sys_shmdt
+399	common	msgget			sys_msgget
+400	common	msgsnd			sys_msgsnd			compat_sys_msgsnd
+401	common	msgrcv			sys_msgrcv			compat_sys_msgrcv
+402	common	msgctl			sys_msgctl			compat_sys_msgctl
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
+# 435 reserved for clone3
diff --git a/linux-user/sparc/syscall_nr.h b/linux-user/sparc/syscall_nr.h
deleted file mode 100644
index 162099f9ce38..000000000000
--- a/linux-user/sparc/syscall_nr.h
+++ /dev/null
@@ -1,363 +0,0 @@
-#ifndef LINUX_USER_SPARC_SYSCALL_NR_H
-#define LINUX_USER_SPARC_SYSCALL_NR_H
-
-#define TARGET_NR_exit                 1 /* Common                                      */
-#define TARGET_NR_fork                 2 /* Common                                      */
-#define TARGET_NR_read                 3 /* Common                                      */
-#define TARGET_NR_write                4 /* Common                                      */
-#define TARGET_NR_open                 5 /* Common                                      */
-#define TARGET_NR_close                6 /* Common                                      */
-#define TARGET_NR_wait4                7 /* Common                                      */
-#define TARGET_NR_creat                8 /* Common                                      */
-#define TARGET_NR_link                 9 /* Common                                      */
-#define TARGET_NR_unlink              10 /* Common                                      */
-#define TARGET_NR_execv               11 /* SunOS Specific                              */
-#define TARGET_NR_chdir               12 /* Common                                      */
-#define TARGET_NR_chown		 13 /* Common					   */
-#define TARGET_NR_mknod               14 /* Common                                      */
-#define TARGET_NR_chmod               15 /* Common                                      */
-#define TARGET_NR_lchown              16 /* Common                                      */
-#define TARGET_NR_brk                 17 /* Common                                      */
-#define TARGET_NR_perfctr             18 /* Performance counter operations              */
-#define TARGET_NR_lseek               19 /* Common                                      */
-#define TARGET_NR_getpid              20 /* Common                                      */
-#define TARGET_NR_capget		 21 /* Linux Specific				   */
-#define TARGET_NR_capset		 22 /* Linux Specific				   */
-#define TARGET_NR_setuid              23 /* Implemented via setreuid in SunOS           */
-#define TARGET_NR_getuid              24 /* Common                                      */
-#define TARGET_NR_vmsplice            25
-#define TARGET_NR_ptrace              26 /* Common                                      */
-#define TARGET_NR_alarm               27 /* Implemented via setitimer in SunOS          */
-#define TARGET_NR_sigaltstack	 28 /* Common					   */
-#define TARGET_NR_pause               29 /* Is sigblock(0)->sigpause() in SunOS         */
-#define TARGET_NR_utime               30 /* Implemented via utimes() under SunOS        */
-#define TARGET_NR_lchown32            31 /* Linux sparc32 specific                      */
-#define TARGET_NR_fchown32            32 /* Linux sparc32 specific                      */
-#define TARGET_NR_access              33 /* Common                                      */
-#define TARGET_NR_nice                34 /* Implemented via get/setpriority() in SunOS  */
-#define TARGET_NR_chown32             35 /* Linux sparc32 specific                      */
-#define TARGET_NR_sync                36 /* Common                                      */
-#define TARGET_NR_kill                37 /* Common                                      */
-#define TARGET_NR_stat                38 /* Common                                      */
-#define TARGET_NR_sendfile		 39 /* Linux Specific				   */
-#define TARGET_NR_lstat               40 /* Common                                      */
-#define TARGET_NR_dup                 41 /* Common                                      */
-#define TARGET_NR_pipe                42 /* Common                                      */
-#define TARGET_NR_times               43 /* Implemented via getrusage() in SunOS        */
-#define TARGET_NR_getuid32            44 /* Linux sparc32 specific                      */
-#define TARGET_NR_umount2             45 /* Linux Specific                              */
-#define TARGET_NR_setgid              46 /* Implemented via setregid() in SunOS         */
-#define TARGET_NR_getgid              47 /* Common                                      */
-#define TARGET_NR_signal              48 /* Implemented via sigvec() in SunOS           */
-#define TARGET_NR_geteuid             49 /* SunOS calls getuid()                        */
-#define TARGET_NR_getegid             50 /* SunOS calls getgid()                        */
-#define TARGET_NR_acct                51 /* Common                                      */
-#define TARGET_NR_getgid32            53 /* Linux sparc32 specific                      */
-#define TARGET_NR_ioctl               54 /* Common                                      */
-#define TARGET_NR_reboot              55 /* Common                                      */
-#define TARGET_NR_mmap2		 56 /* Linux sparc32 Specific			   */
-#define TARGET_NR_symlink             57 /* Common                                      */
-#define TARGET_NR_readlink            58 /* Common                                      */
-#define TARGET_NR_execve              59 /* Common                                      */
-#define TARGET_NR_umask               60 /* Common                                      */
-#define TARGET_NR_chroot              61 /* Common                                      */
-#define TARGET_NR_fstat               62 /* Common                                      */
-#define TARGET_NR_fstat64		 63 /* Linux sparc32 Specific			   */
-#define TARGET_NR_getpagesize         64 /* Common                                      */
-#define TARGET_NR_msync               65 /* Common in newer 1.3.x revs...               */
-#define TARGET_NR_vfork               66 /* Common                                      */
-#define TARGET_NR_pread64             67 /* Linux Specific */
-#define TARGET_NR_pwrite64            68 /* Linux Specific */
-#define TARGET_NR_geteuid32           69 /* Linux sparc32, sbrk under SunOS             */
-#define TARGET_NR_getegid32           70 /* Linux sparc32, sstk under SunOS             */
-#define TARGET_NR_mmap                71 /* Common                                      */
-#define TARGET_NR_setreuid32          72 /* Linux sparc32, vadvise under SunOS          */
-#define TARGET_NR_munmap              73 /* Common                                      */
-#define TARGET_NR_mprotect            74 /* Common                                      */
-#define TARGET_NR_madvise             75 /* Common                                      */
-#define TARGET_NR_vhangup             76 /* Common                                      */
-#define TARGET_NR_truncate64		 77 /* Linux sparc32 Specific			   */
-#define TARGET_NR_mincore             78 /* Common                                      */
-#define TARGET_NR_getgroups           79 /* Common                                      */
-#define TARGET_NR_setgroups           80 /* Common                                      */
-#define TARGET_NR_getpgrp             81 /* Common                                      */
-#define TARGET_NR_setgroups32         82 /* Linux sparc32, setpgrp under SunOS          */
-#define TARGET_NR_setitimer           83 /* Common                                      */
-#define TARGET_NR_ftruncate64	 84 /* Linux sparc32 Specific			   */
-#define TARGET_NR_swapon              85 /* Common                                      */
-#define TARGET_NR_getitimer           86 /* Common                                      */
-#define TARGET_NR_setuid32            87 /* Linux sparc32, gethostname under SunOS      */
-#define TARGET_NR_sethostname         88 /* Common                                      */
-#define TARGET_NR_setgid32            89 /* Linux sparc32, getdtablesize under SunOS    */
-#define TARGET_NR_dup2                90 /* Common                                      */
-#define TARGET_NR_setfsuid32          91 /* Linux sparc32, getdopt under SunOS          */
-#define TARGET_NR_fcntl               92 /* Common                                      */
-#define TARGET_NR_select              93 /* Common                                      */
-#define TARGET_NR_setfsgid32          94 /* Linux sparc32, setdopt under SunOS          */
-#define TARGET_NR_fsync               95 /* Common                                      */
-#define TARGET_NR_setpriority         96 /* Common                                      */
-#define TARGET_NR_socket              97 /* Common                                      */
-#define TARGET_NR_connect             98 /* Common                                      */
-#define TARGET_NR_accept              99 /* Common                                      */
-#define TARGET_NR_getpriority        100 /* Common                                      */
-#define TARGET_NR_rt_sigreturn       101 /* Linux Specific                              */
-#define TARGET_NR_rt_sigaction       102 /* Linux Specific                              */
-#define TARGET_NR_rt_sigprocmask     103 /* Linux Specific                              */
-#define TARGET_NR_rt_sigpending      104 /* Linux Specific                              */
-#define TARGET_NR_rt_sigtimedwait    105 /* Linux Specific                              */
-#define TARGET_NR_rt_sigqueueinfo    106 /* Linux Specific                              */
-#define TARGET_NR_rt_sigsuspend      107 /* Linux Specific                              */
-#define TARGET_NR_setresuid32        108 /* Linux Specific, sigvec under SunOS	   */
-#define TARGET_NR_getresuid32        109 /* Linux Specific, sigblock under SunOS	   */
-#define TARGET_NR_setresgid32        110 /* Linux Specific, sigsetmask under SunOS	   */
-#define TARGET_NR_getresgid32        111 /* Linux Specific, sigpause under SunOS	   */
-#define TARGET_NR_setregid32         112 /* Linux sparc32, sigstack under SunOS         */
-#define TARGET_NR_recvmsg            113 /* Common                                      */
-#define TARGET_NR_sendmsg            114 /* Common                                      */
-#define TARGET_NR_getgroups32        115 /* Linux sparc32, vtrace under SunOS           */
-#define TARGET_NR_gettimeofday       116 /* Common                                      */
-#define TARGET_NR_getrusage          117 /* Common                                      */
-#define TARGET_NR_getsockopt         118 /* Common                                      */
-#define TARGET_NR_getcwd		119 /* Linux Specific				   */
-#define TARGET_NR_readv              120 /* Common                                      */
-#define TARGET_NR_writev             121 /* Common                                      */
-#define TARGET_NR_settimeofday       122 /* Common                                      */
-#define TARGET_NR_fchown             123 /* Common                                      */
-#define TARGET_NR_fchmod             124 /* Common                                      */
-#define TARGET_NR_recvfrom           125 /* Common                                      */
-#define TARGET_NR_setreuid           126 /* Common                                      */
-#define TARGET_NR_setregid           127 /* Common                                      */
-#define TARGET_NR_rename             128 /* Common                                      */
-#define TARGET_NR_truncate           129 /* Common                                      */
-#define TARGET_NR_ftruncate          130 /* Common                                      */
-#define TARGET_NR_flock              131 /* Common                                      */
-#define TARGET_NR_lstat64		132 /* Linux sparc32 Specific			   */
-#define TARGET_NR_sendto             133 /* Common                                      */
-#define TARGET_NR_shutdown           134 /* Common                                      */
-#define TARGET_NR_socketpair         135 /* Common                                      */
-#define TARGET_NR_mkdir              136 /* Common                                      */
-#define TARGET_NR_rmdir              137 /* Common                                      */
-#define TARGET_NR_utimes             138 /* SunOS Specific                              */
-#define TARGET_NR_stat64		139 /* Linux sparc32 Specific			   */
-#define TARGET_NR_sendfile64         140
-#define TARGET_NR_getpeername        141 /* Common                                      */
-#define TARGET_NR_futex              142 /* gethostid under SunOS                       */
-#define TARGET_NR_gettid             143 /* ENOSYS under SunOS                          */
-#define TARGET_NR_getrlimit          144 /* Common                                      */
-#define TARGET_NR_setrlimit          145 /* Common                                      */
-#define TARGET_NR_pivot_root		146 /* Linux Specific, killpg under SunOS          */
-#define TARGET_NR_prctl		147 /* ENOSYS under SunOS                          */
-#define TARGET_NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
-#define TARGET_NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
-#define TARGET_NR_getsockname        150 /* Common                                      */
-#define TARGET_NR_inotify_init       151
-#define TARGET_NR_inotify_add_watch  152
-#define TARGET_NR_poll               153 /* Common                                      */
-#define TARGET_NR_getdents64		154 /* Linux specific				   */
-#define TARGET_NR_fcntl64		155 /* Linux sparc32 Specific                      */
-#define TARGET_NR_inotify_rm_watch   156
-#define TARGET_NR_statfs             157 /* Common                                      */
-#define TARGET_NR_fstatfs            158 /* Common                                      */
-#define TARGET_NR_umount             159 /* Common                                      */
-#define TARGET_NR_sched_set_affinity 160
-#define TARGET_NR_sched_get_affinity 161
-#define TARGET_NR_getdomainname      162 /* SunOS Specific                              */
-#define TARGET_NR_setdomainname      163 /* Common                                      */
-#define TARGET_NR_quotactl           165 /* Common                                      */
-#define TARGET_NR_set_tid_address    166 /* Linux specific, exportfs under SunOS        */
-#define TARGET_NR_mount              167 /* Common                                      */
-#define TARGET_NR_ustat              168 /* Common                                      */
-#define TARGET_NR_setxattr           169
-#define TARGET_NR_lsetxattr          170
-#define TARGET_NR_fsetxattr          171
-#define TARGET_NR_getxattr           172
-#define TARGET_NR_lgetxattr          173
-#define TARGET_NR_getdents           174 /* Common                                      */
-#define TARGET_NR_setsid             175 /* Common                                      */
-#define TARGET_NR_fchdir             176 /* Common                                      */
-#define TARGET_NR_fgetxattr          177
-#define TARGET_NR_listxattr          178
-#define TARGET_NR_llistxattr         179
-#define TARGET_NR_flistxattr         180
-#define TARGET_NR_removexattr        181
-#define TARGET_NR_lremovexattr       182
-#define TARGET_NR_sigpending         183 /* Common                                      */
-#define TARGET_NR_query_module	184 /* Linux Specific				   */
-#define TARGET_NR_setpgid            185 /* Common                                      */
-#define TARGET_NR_fremovexattr       186
-#define TARGET_NR_tkill              187 /* SunOS: fpathconf                            */
-#define TARGET_NR_exit_group	     188 /* Linux specific, sysconf undef SunOS         */
-#define TARGET_NR_uname              189 /* Linux Specific                              */
-#define TARGET_NR_init_module        190 /* Linux Specific                              */
-#define TARGET_NR_personality        191 /* Linux Specific                              */
-#define TARGET_NR_remap_file_pages   192
-#define TARGET_NR_epoll_create       193
-#define TARGET_NR_epoll_ctl          194
-#define TARGET_NR_epoll_wait         195
-#define TARGET_NR_ioprio_set         196
-#define TARGET_NR_getppid            197 /* Linux Specific                              */
-#define TARGET_NR_sigaction          198 /* Linux Specific                              */
-#define TARGET_NR_sgetmask           199 /* Linux Specific                              */
-#define TARGET_NR_ssetmask           200 /* Linux Specific                              */
-#define TARGET_NR_sigsuspend         201 /* Linux Specific                              */
-#define TARGET_NR_oldlstat           202 /* Linux Specific                              */
-#define TARGET_NR_uselib             203 /* Linux Specific                              */
-#define TARGET_NR_readdir            204 /* Linux Specific                              */
-#define TARGET_NR_readahead          205 /* Linux Specific                              */
-#define TARGET_NR_socketcall         206 /* Linux Specific                              */
-#define TARGET_NR_syslog             207 /* Linux Specific                              */
-#define TARGET_NR_lookup_dcookie     208 /* Linux Specific                              */
-#define TARGET_NR_fadvise64          209 /* Linux Specific                              */
-#define TARGET_NR_fadvise64_64       210 /* Linux Specific                              */
-#define TARGET_NR_tgkill             211 /* Linux Specific                              */
-#define TARGET_NR_waitpid            212 /* Linux Specific                              */
-#define TARGET_NR_swapoff            213 /* Linux Specific                              */
-#define TARGET_NR_sysinfo            214 /* Linux Specific                              */
-#define TARGET_NR_ipc                215 /* Linux Specific                              */
-#define TARGET_NR_sigreturn          216 /* Linux Specific                              */
-#define TARGET_NR_clone              217 /* Linux Specific                              */
-#define TARGET_NR_ioprio_get         218
-#define TARGET_NR_adjtimex           219 /* Linux Specific                              */
-#define TARGET_NR_sigprocmask        220 /* Linux Specific                              */
-#define TARGET_NR_create_module      221 /* Linux Specific                              */
-#define TARGET_NR_delete_module      222 /* Linux Specific                              */
-#define TARGET_NR_get_kernel_syms    223 /* Linux Specific                              */
-#define TARGET_NR_getpgid            224 /* Linux Specific                              */
-#define TARGET_NR_bdflush            225 /* Linux Specific                              */
-#define TARGET_NR_sysfs              226 /* Linux Specific                              */
-#define TARGET_NR_afs_syscall        227 /* Linux Specific                              */
-#define TARGET_NR_setfsuid           228 /* Linux Specific                              */
-#define TARGET_NR_setfsgid           229 /* Linux Specific                              */
-#define TARGET_NR__newselect         230 /* Linux Specific                              */
-#define TARGET_NR_time               231 /* Linux Specific                              */
-#define TARGET_NR_splice             232
-#define TARGET_NR_stime              233 /* Linux Specific                              */
-#define TARGET_NR_statfs64           234 /* Linux Specific                              */
-#define TARGET_NR_fstatfs64          235 /* Linux Specific                              */
-#define TARGET_NR__llseek            236 /* Linux Specific                              */
-#define TARGET_NR_mlock              237
-#define TARGET_NR_munlock            238
-#define TARGET_NR_mlockall           239
-#define TARGET_NR_munlockall         240
-#define TARGET_NR_sched_setparam     241
-#define TARGET_NR_sched_getparam     242
-#define TARGET_NR_sched_setscheduler 243
-#define TARGET_NR_sched_getscheduler 244
-#define TARGET_NR_sched_yield        245
-#define TARGET_NR_sched_get_priority_max 246
-#define TARGET_NR_sched_get_priority_min 247
-#define TARGET_NR_sched_rr_get_interval  248
-#define TARGET_NR_nanosleep          249
-#define TARGET_NR_mremap             250
-#define TARGET_NR__sysctl            251
-#define TARGET_NR_getsid             252
-#define TARGET_NR_fdatasync          253
-#define TARGET_NR_nfsservctl         254
-#define TARGET_NR_sync_file_range    255
-#define TARGET_NR_clock_settime	256
-#define TARGET_NR_clock_gettime	257
-#define TARGET_NR_clock_getres	258
-#define TARGET_NR_clock_nanosleep	259
-#define TARGET_NR_sched_getaffinity	260
-#define TARGET_NR_sched_setaffinity	261
-#define TARGET_NR_timer_settime	262
-#define TARGET_NR_timer_gettime	263
-#define TARGET_NR_timer_getoverrun	264
-#define TARGET_NR_timer_delete	265
-#define TARGET_NR_timer_create	266
-/* #define TARGET_NR_vserver		267 Reserved for VSERVER */
-#define TARGET_NR_io_setup		268
-#define TARGET_NR_io_destroy		269
-#define TARGET_NR_io_submit		270
-#define TARGET_NR_io_cancel		271
-#define TARGET_NR_io_getevents	272
-#define TARGET_NR_mq_open		273
-#define TARGET_NR_mq_unlink		274
-#define TARGET_NR_mq_timedsend	275
-#define TARGET_NR_mq_timedreceive	276
-#define TARGET_NR_mq_notify		277
-#define TARGET_NR_mq_getsetattr	278
-#define TARGET_NR_waitid		279
-#define TARGET_NR_tee		280
-#define TARGET_NR_add_key		281
-#define TARGET_NR_request_key	282
-#define TARGET_NR_keyctl		283
-#define TARGET_NR_openat		284
-#define TARGET_NR_mkdirat		285
-#define TARGET_NR_mknodat		286
-#define TARGET_NR_fchownat		287
-#define TARGET_NR_futimesat		288
-#define TARGET_NR_fstatat64		289
-#define TARGET_NR_unlinkat		290
-#define TARGET_NR_renameat		291
-#define TARGET_NR_linkat		292
-#define TARGET_NR_symlinkat		293
-#define TARGET_NR_readlinkat		294
-#define TARGET_NR_fchmodat		295
-#define TARGET_NR_faccessat		296
-#define TARGET_NR_pselect6		297
-#define TARGET_NR_ppoll		298
-#define TARGET_NR_unshare		299
-#define TARGET_NR_set_robust_list	300
-#define TARGET_NR_get_robust_list	301
-#define TARGET_NR_migrate_pages	302
-#define TARGET_NR_mbind		303
-#define TARGET_NR_get_mempolicy	304
-#define TARGET_NR_set_mempolicy	305
-#define TARGET_NR_kexec_load		306
-#define TARGET_NR_move_pages		307
-#define TARGET_NR_getcpu		308
-#define TARGET_NR_epoll_pwait	309
-#define TARGET_NR_utimensat		310
-#define TARGET_NR_signalfd		311
-#define TARGET_NR_timerfd_create	312
-#define TARGET_NR_eventfd		313
-#define TARGET_NR_fallocate		314
-#define TARGET_NR_timerfd_settime	315
-#define TARGET_NR_timerfd_gettime	316
-#define TARGET_NR_signalfd4		317
-#define TARGET_NR_eventfd2		318
-#define TARGET_NR_epoll_create1	319
-#define TARGET_NR_dup3			320
-#define TARGET_NR_pipe2		321
-#define TARGET_NR_inotify_init1	322
-#define TARGET_NR_accept4		323
-#define TARGET_NR_preadv                324
-#define TARGET_NR_pwritev               325
-#define TARGET_NR_rt_tgsigqueueinfo     326
-#define TARGET_NR_perf_event_open       327
-#define TARGET_NR_recvmmsg              328
-#define TARGET_NR_fanotify_init         329
-#define TARGET_NR_fanotify_mark         330
-#define TARGET_NR_prlimit64             331
-#define TARGET_NR_name_to_handle_at     332
-#define TARGET_NR_open_by_handle_at     333
-#define TARGET_NR_clock_adjtime         334
-#define TARGET_NR_syncfs                335
-#define TARGET_NR_sendmmsg              336
-#define TARGET_NR_setns                 337
-#define TARGET_NR_process_vm_readv      338
-#define TARGET_NR_process_vm_writev     339
-#define TARGET_NR_kern_features         340
-#define TARGET_NR_kcmp                  341
-#define TARGET_NR_finit_module          342
-#define TARGET_NR_sched_setattr         343
-#define TARGET_NR_sched_getattr         344
-#define TARGET_NR_renameat2             345
-#define TARGET_NR_seccomp               346
-#define TARGET_NR_getrandom             347
-#define TARGET_NR_memfd_create          348
-#define TARGET_NR_bpf                   349
-#define TARGET_NR_execveat              350
-#define TARGET_NR_membarrier            351
-#define TARGET_NR_userfaultfd           352
-#define TARGET_NR_bind                  353
-#define TARGET_NR_listen                354
-#define TARGET_NR_setsockopt            355
-#define TARGET_NR_mlock2                356
-#define TARGET_NR_copy_file_range       357
-#define TARGET_NR_preadv2               358
-#define TARGET_NR_pwritev2              359
-#define TARGET_NR_statx                 360
-
-#endif
diff --git a/linux-user/sparc/syscallhdr.sh b/linux-user/sparc/syscallhdr.sh
new file mode 100644
index 000000000000..34a99dc83269
--- /dev/null
+++ b/linux-user/sparc/syscallhdr.sh
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
+fileguard=LINUX_USER_SPARC_`basename "$out" | sed \
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
diff --git a/linux-user/sparc64/Makefile.objs b/linux-user/sparc64/Makefile.objs
new file mode 100644
index 000000000000..afcd535bc4a4
--- /dev/null
+++ b/linux-user/sparc64/Makefile.objs
@@ -0,0 +1,5 @@
+generated-files-y += linux-user/sparc64/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/sparc64/syscallhdr.sh
+%/syscall_nr.h: $(SRC_PATH)/linux-user/sparc/syscall.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/sparc64/syscall.tbl b/linux-user/sparc64/syscall.tbl
new file mode 100644
index 000000000000..8c8cc7537fb2
--- /dev/null
+++ b/linux-user/sparc64/syscall.tbl
@@ -0,0 +1,483 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for sparc
+#
+# The format is:
+# <number> <abi> <name> <entry point> <compat entry point>
+#
+# The <abi> can be common, 64, or 32 for this file.
+#
+0	common	restart_syscall		sys_restart_syscall
+1	32	exit			sys_exit			sparc_exit
+1	64	exit			sparc_exit
+2	common	fork			sys_fork
+3	common	read			sys_read
+4	common	write			sys_write
+5	common	open			sys_open			compat_sys_open
+6	common	close			sys_close
+7	common	wait4			sys_wait4			compat_sys_wait4
+8	common	creat			sys_creat
+9	common	link			sys_link
+10	common	unlink			sys_unlink
+11	32	execv			sunos_execv
+11	64	execv			sys_nis_syscall
+12	common	chdir			sys_chdir
+13	32    	chown			sys_chown16
+13	64	chown			sys_chown
+14	common	mknod			sys_mknod
+15	common	chmod			sys_chmod
+16	32	lchown			sys_lchown16
+16	64	lchown			sys_lchown
+17	common	brk			sys_brk
+18	common	perfctr			sys_nis_syscall
+19	common	lseek			sys_lseek			compat_sys_lseek
+20	common	getpid			sys_getpid
+21	common	capget			sys_capget
+22	common	capset			sys_capset
+23	32    	setuid			sys_setuid16
+23	64    	setuid			sys_setuid
+24	32	getuid			sys_getuid16
+24	64   	getuid			sys_getuid
+25	common	vmsplice		sys_vmsplice			compat_sys_vmsplice
+26	common	ptrace			sys_ptrace			compat_sys_ptrace
+27	common	alarm			sys_alarm
+28	common	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
+29	32    	pause			sys_pause
+29	64    	pause			sys_nis_syscall
+30	32	utime			sys_utime32
+30	64	utime			sys_utime
+31	32    	lchown32		sys_lchown
+32	32    	fchown32		sys_fchown
+33	common	access			sys_access
+34	common	nice			sys_nice
+35	32    	chown32			sys_chown
+36	common	sync			sys_sync
+37	common	kill			sys_kill
+38	common	stat			sys_newstat			compat_sys_newstat
+39	32	sendfile		sys_sendfile			compat_sys_sendfile
+39	64	sendfile		sys_sendfile64
+40	common	lstat			sys_newlstat			compat_sys_newlstat
+41	common	dup			sys_dup
+42	common	pipe			sys_sparc_pipe
+43	common	times			sys_times			compat_sys_times
+44	32    	getuid32		sys_getuid
+45	common	umount2			sys_umount
+46	32	setgid			sys_setgid16
+46	64	setgid			sys_setgid
+47	32	getgid			sys_getgid16
+47	64	getgid			sys_getgid
+48	common	signal			sys_signal
+49	32	geteuid			sys_geteuid16
+49	64	geteuid			sys_geteuid
+50	32	getegid			sys_getegid16
+50	64	getegid			sys_getegid
+51	common	acct			sys_acct
+52	64	memory_ordering		sys_memory_ordering
+53	32	getgid32		sys_getgid
+54	common	ioctl			sys_ioctl			compat_sys_ioctl
+55	common	reboot			sys_reboot
+56	32    	mmap2			sys_mmap2			sys32_mmap2
+57	common	symlink			sys_symlink
+58	common	readlink		sys_readlink
+59	32	execve			sys_execve			sys32_execve
+59	64	execve			sys64_execve
+60	common	umask			sys_umask
+61	common	chroot			sys_chroot
+62	common	fstat			sys_newfstat			compat_sys_newfstat
+63	common	fstat64			sys_fstat64			compat_sys_fstat64
+64	common	getpagesize		sys_getpagesize
+65	common	msync			sys_msync
+66	common	vfork			sys_vfork
+67	common	pread64			sys_pread64			compat_sys_pread64
+68	common	pwrite64		sys_pwrite64			compat_sys_pwrite64
+69	32    	geteuid32		sys_geteuid
+70	32	getegid32		sys_getegid
+71	common	mmap			sys_mmap
+72	32	setreuid32		sys_setreuid
+73	32	munmap			sys_munmap
+73	64	munmap			sys_64_munmap
+74	common	mprotect		sys_mprotect
+75	common	madvise			sys_madvise
+76	common	vhangup			sys_vhangup
+77	32	truncate64		sys_truncate64			compat_sys_truncate64
+78	common	mincore			sys_mincore
+79	32	getgroups		sys_getgroups16
+79	64	getgroups		sys_getgroups
+80	32	setgroups		sys_setgroups16
+80	64	setgroups		sys_setgroups
+81	common	getpgrp			sys_getpgrp
+82	32	setgroups32		sys_setgroups
+83	common	setitimer		sys_setitimer			compat_sys_setitimer
+84	32	ftruncate64		sys_ftruncate64			compat_sys_ftruncate64
+85	common	swapon			sys_swapon
+86	common	getitimer		sys_getitimer			compat_sys_getitimer
+87	32	setuid32		sys_setuid
+88	common	sethostname		sys_sethostname
+89	32	setgid32		sys_setgid
+90	common	dup2			sys_dup2
+91	32	setfsuid32		sys_setfsuid
+92	common	fcntl			sys_fcntl			compat_sys_fcntl
+93	common	select			sys_select
+94	32	setfsgid32		sys_setfsgid
+95	common	fsync			sys_fsync
+96	common	setpriority		sys_setpriority
+97	common	socket			sys_socket
+98	common	connect			sys_connect
+99	common	accept			sys_accept
+100	common	getpriority		sys_getpriority
+101	common	rt_sigreturn		sys_rt_sigreturn		sys32_rt_sigreturn
+102	common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
+103	common	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+104	common	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
+105	32	rt_sigtimedwait		sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+105	64	rt_sigtimedwait		sys_rt_sigtimedwait
+106	common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+107	common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+108	32	setresuid32		sys_setresuid
+108	64	setresuid		sys_setresuid
+109	32	getresuid32		sys_getresuid
+109	64	getresuid		sys_getresuid
+110	32	setresgid32		sys_setresgid
+110	64	setresgid		sys_setresgid
+111	32	getresgid32		sys_getresgid
+111	64	getresgid		sys_getresgid
+112	32	setregid32		sys_setregid
+113	common	recvmsg			sys_recvmsg			compat_sys_recvmsg
+114	common	sendmsg			sys_sendmsg			compat_sys_sendmsg
+115	32	getgroups32		sys_getgroups
+116	common	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
+117	common	getrusage		sys_getrusage			compat_sys_getrusage
+118	common	getsockopt		sys_getsockopt			compat_sys_getsockopt
+119	common	getcwd			sys_getcwd
+120	common	readv			sys_readv			compat_sys_readv
+121	common	writev			sys_writev			compat_sys_writev
+122	common	settimeofday		sys_settimeofday		compat_sys_settimeofday
+123	32	fchown			sys_fchown16
+123	64	fchown			sys_fchown
+124	common	fchmod			sys_fchmod
+125	common	recvfrom		sys_recvfrom
+126	32	setreuid		sys_setreuid16
+126	64	setreuid		sys_setreuid
+127	32	setregid		sys_setregid16
+127	64	setregid		sys_setregid
+128	common	rename			sys_rename
+129	common	truncate		sys_truncate			compat_sys_truncate
+130	common	ftruncate		sys_ftruncate			compat_sys_ftruncate
+131	common	flock			sys_flock
+132	common	lstat64			sys_lstat64			compat_sys_lstat64
+133	common	sendto			sys_sendto
+134	common	shutdown		sys_shutdown
+135	common	socketpair		sys_socketpair
+136	common	mkdir			sys_mkdir
+137	common	rmdir			sys_rmdir
+138	32	utimes			sys_utimes_time32
+138	64	utimes			sys_utimes
+139	common	stat64			sys_stat64			compat_sys_stat64
+140	common	sendfile64		sys_sendfile64
+141	common	getpeername		sys_getpeername
+142	32	futex			sys_futex_time32
+142	64	futex			sys_futex
+143	common	gettid			sys_gettid
+144	common	getrlimit		sys_getrlimit			compat_sys_getrlimit
+145	common	setrlimit		sys_setrlimit			compat_sys_setrlimit
+146	common	pivot_root		sys_pivot_root
+147	common	prctl			sys_prctl
+148	common	pciconfig_read		sys_pciconfig_read
+149	common	pciconfig_write		sys_pciconfig_write
+150	common	getsockname		sys_getsockname
+151	common	inotify_init		sys_inotify_init
+152	common	inotify_add_watch	sys_inotify_add_watch
+153	common	poll			sys_poll
+154	common	getdents64		sys_getdents64
+155	32	fcntl64			sys_fcntl64			compat_sys_fcntl64
+156	common	inotify_rm_watch	sys_inotify_rm_watch
+157	common	statfs			sys_statfs			compat_sys_statfs
+158	common	fstatfs			sys_fstatfs			compat_sys_fstatfs
+159	common	umount			sys_oldumount
+160	common	sched_set_affinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
+161	common	sched_get_affinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
+162	common	getdomainname		sys_getdomainname
+163	common	setdomainname		sys_setdomainname
+164	64	utrap_install		sys_utrap_install
+165	common	quotactl		sys_quotactl
+166	common	set_tid_address		sys_set_tid_address
+167	common	mount			sys_mount			compat_sys_mount
+168	common	ustat			sys_ustat			compat_sys_ustat
+169	common	setxattr		sys_setxattr
+170	common	lsetxattr		sys_lsetxattr
+171	common	fsetxattr		sys_fsetxattr
+172	common	getxattr		sys_getxattr
+173	common	lgetxattr		sys_lgetxattr
+174	common	getdents		sys_getdents			compat_sys_getdents
+175	common	setsid			sys_setsid
+176	common	fchdir			sys_fchdir
+177	common	fgetxattr		sys_fgetxattr
+178	common	listxattr		sys_listxattr
+179	common	llistxattr		sys_llistxattr
+180	common	flistxattr		sys_flistxattr
+181	common	removexattr		sys_removexattr
+182	common	lremovexattr		sys_lremovexattr
+183	32	sigpending		sys_sigpending			compat_sys_sigpending
+183	64	sigpending		sys_nis_syscall
+184	common	query_module		sys_ni_syscall
+185	common	setpgid			sys_setpgid
+186	common	fremovexattr		sys_fremovexattr
+187	common	tkill			sys_tkill
+188	32	exit_group		sys_exit_group			sparc_exit_group
+188	64	exit_group		sparc_exit_group
+189	common	uname			sys_newuname
+190	common	init_module		sys_init_module
+191	32	personality		sys_personality			sys_sparc64_personality
+191	64	personality		sys_sparc64_personality
+192	32	remap_file_pages	sys_sparc_remap_file_pages	sys_remap_file_pages
+192	64	remap_file_pages	sys_remap_file_pages
+193	common	epoll_create		sys_epoll_create
+194	common	epoll_ctl		sys_epoll_ctl
+195	common	epoll_wait		sys_epoll_wait
+196	common	ioprio_set		sys_ioprio_set
+197	common	getppid			sys_getppid
+198	32	sigaction		sys_sparc_sigaction		compat_sys_sparc_sigaction
+198	64	sigaction		sys_nis_syscall
+199	common	sgetmask		sys_sgetmask
+200	common	ssetmask		sys_ssetmask
+201	32	sigsuspend		sys_sigsuspend
+201	64	sigsuspend		sys_nis_syscall
+202	common	oldlstat		sys_newlstat			compat_sys_newlstat
+203	common	uselib			sys_uselib
+204	32	readdir			sys_old_readdir			compat_sys_old_readdir
+204	64	readdir			sys_nis_syscall
+205	common	readahead		sys_readahead			compat_sys_readahead
+206	common	socketcall		sys_socketcall			sys32_socketcall
+207	common	syslog			sys_syslog
+208	common	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
+209	common	fadvise64		sys_fadvise64			compat_sys_fadvise64
+210	common	fadvise64_64		sys_fadvise64_64		compat_sys_fadvise64_64
+211	common	tgkill			sys_tgkill
+212	common	waitpid			sys_waitpid
+213	common	swapoff			sys_swapoff
+214	common	sysinfo			sys_sysinfo			compat_sys_sysinfo
+215	32	ipc			sys_ipc				compat_sys_ipc
+215	64	ipc			sys_sparc_ipc
+216	32	sigreturn		sys_sigreturn			sys32_sigreturn
+216	64	sigreturn		sys_nis_syscall
+217	common	clone			sys_clone
+218	common	ioprio_get		sys_ioprio_get
+219	32	adjtimex		sys_adjtimex_time32
+219	64	adjtimex		sys_sparc_adjtimex
+220	32	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
+220	64	sigprocmask		sys_nis_syscall
+221	common	create_module		sys_ni_syscall
+222	common	delete_module		sys_delete_module
+223	common	get_kernel_syms		sys_ni_syscall
+224	common	getpgid			sys_getpgid
+225	common	bdflush			sys_bdflush
+226	common	sysfs			sys_sysfs
+227	common	afs_syscall		sys_nis_syscall
+228	common	setfsuid		sys_setfsuid16
+229	common	setfsgid		sys_setfsgid16
+230	common	_newselect		sys_select			compat_sys_select
+231	32	time			sys_time32
+232	common	splice			sys_splice
+233	32	stime			sys_stime32
+233	64	stime			sys_stime
+234	common	statfs64		sys_statfs64			compat_sys_statfs64
+235	common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
+236	common	_llseek			sys_llseek
+237	common	mlock			sys_mlock
+238	common	munlock			sys_munlock
+239	common	mlockall		sys_mlockall
+240	common	munlockall		sys_munlockall
+241	common	sched_setparam		sys_sched_setparam
+242	common	sched_getparam		sys_sched_getparam
+243	common	sched_setscheduler	sys_sched_setscheduler
+244	common	sched_getscheduler	sys_sched_getscheduler
+245	common	sched_yield		sys_sched_yield
+246	common	sched_get_priority_max	sys_sched_get_priority_max
+247	common	sched_get_priority_min	sys_sched_get_priority_min
+248	32	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+248	64	sched_rr_get_interval	sys_sched_rr_get_interval
+249	32	nanosleep		sys_nanosleep_time32
+249	64	nanosleep		sys_nanosleep
+250	32	mremap			sys_mremap
+250	64	mremap			sys_64_mremap
+251	common	_sysctl			sys_sysctl			compat_sys_sysctl
+252	common	getsid			sys_getsid
+253	common	fdatasync		sys_fdatasync
+254	32	nfsservctl		sys_ni_syscall			sys_nis_syscall
+254	64	nfsservctl		sys_nis_syscall
+255	common	sync_file_range		sys_sync_file_range		compat_sys_sync_file_range
+256	32	clock_settime		sys_clock_settime32
+256	64	clock_settime		sys_clock_settime
+257	32	clock_gettime		sys_clock_gettime32
+257	64	clock_gettime		sys_clock_gettime
+258	32	clock_getres		sys_clock_getres_time32
+258	64	clock_getres		sys_clock_getres
+259	32	clock_nanosleep		sys_clock_nanosleep_time32
+259	64	clock_nanosleep		sys_clock_nanosleep
+260	common	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
+261	common	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
+262	32	timer_settime		sys_timer_settime32
+262	64	timer_settime		sys_timer_settime
+263	32	timer_gettime		sys_timer_gettime32
+263	64	timer_gettime		sys_timer_gettime
+264	common	timer_getoverrun	sys_timer_getoverrun
+265	common	timer_delete		sys_timer_delete
+266	common	timer_create		sys_timer_create		compat_sys_timer_create
+# 267 was vserver
+267	common	vserver			sys_nis_syscall
+268	common	io_setup		sys_io_setup			compat_sys_io_setup
+269	common	io_destroy		sys_io_destroy
+270	common	io_submit		sys_io_submit			compat_sys_io_submit
+271	common	io_cancel		sys_io_cancel
+272	32	io_getevents		sys_io_getevents_time32
+272	64	io_getevents		sys_io_getevents
+273	common	mq_open			sys_mq_open			compat_sys_mq_open
+274	common	mq_unlink		sys_mq_unlink
+275	32	mq_timedsend		sys_mq_timedsend_time32
+275	64	mq_timedsend		sys_mq_timedsend
+276	32	mq_timedreceive		sys_mq_timedreceive_time32
+276	64	mq_timedreceive		sys_mq_timedreceive
+277	common	mq_notify		sys_mq_notify			compat_sys_mq_notify
+278	common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
+279	common	waitid			sys_waitid			compat_sys_waitid
+280	common	tee			sys_tee
+281	common	add_key			sys_add_key
+282	common	request_key		sys_request_key
+283	common	keyctl			sys_keyctl			compat_sys_keyctl
+284	common	openat			sys_openat			compat_sys_openat
+285	common	mkdirat			sys_mkdirat
+286	common	mknodat			sys_mknodat
+287	common	fchownat		sys_fchownat
+288	32	futimesat		sys_futimesat_time32
+288	64	futimesat		sys_futimesat
+289	common	fstatat64		sys_fstatat64			compat_sys_fstatat64
+290	common	unlinkat		sys_unlinkat
+291	common	renameat		sys_renameat
+292	common	linkat			sys_linkat
+293	common	symlinkat		sys_symlinkat
+294	common	readlinkat		sys_readlinkat
+295	common	fchmodat		sys_fchmodat
+296	common	faccessat		sys_faccessat
+297	32	pselect6		sys_pselect6_time32		compat_sys_pselect6_time32
+297	64	pselect6		sys_pselect6
+298	32	ppoll			sys_ppoll_time32		compat_sys_ppoll_time32
+298	64	ppoll			sys_ppoll
+299	common	unshare			sys_unshare
+300	common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
+301	common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
+302	common	migrate_pages		sys_migrate_pages		compat_sys_migrate_pages
+303	common	mbind			sys_mbind			compat_sys_mbind
+304	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
+305	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
+306	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
+307	common	move_pages		sys_move_pages			compat_sys_move_pages
+308	common	getcpu			sys_getcpu
+309	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
+310	32	utimensat		sys_utimensat_time32
+310	64	utimensat		sys_utimensat
+311	common	signalfd		sys_signalfd			compat_sys_signalfd
+312	common	timerfd_create		sys_timerfd_create
+313	common	eventfd			sys_eventfd
+314	common	fallocate		sys_fallocate			compat_sys_fallocate
+315	32	timerfd_settime		sys_timerfd_settime32
+315	64	timerfd_settime		sys_timerfd_settime
+316	32	timerfd_gettime		sys_timerfd_gettime32
+316	64	timerfd_gettime		sys_timerfd_gettime
+317	common	signalfd4		sys_signalfd4			compat_sys_signalfd4
+318	common	eventfd2		sys_eventfd2
+319	common	epoll_create1		sys_epoll_create1
+320	common	dup3			sys_dup3
+321	common	pipe2			sys_pipe2
+322	common	inotify_init1		sys_inotify_init1
+323	common	accept4			sys_accept4
+324	common	preadv			sys_preadv			compat_sys_preadv
+325	common	pwritev			sys_pwritev			compat_sys_pwritev
+326	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+327	common	perf_event_open		sys_perf_event_open
+328	32	recvmmsg		sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+328	64	recvmmsg		sys_recvmmsg
+329	common	fanotify_init		sys_fanotify_init
+330	common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
+331	common	prlimit64		sys_prlimit64
+332	common	name_to_handle_at	sys_name_to_handle_at
+333	common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
+334	32	clock_adjtime		sys_clock_adjtime32
+334	64	clock_adjtime		sys_sparc_clock_adjtime
+335	common	syncfs			sys_syncfs
+336	common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
+337	common	setns			sys_setns
+338	common	process_vm_readv	sys_process_vm_readv		compat_sys_process_vm_readv
+339	common	process_vm_writev	sys_process_vm_writev		compat_sys_process_vm_writev
+340	32	kern_features		sys_ni_syscall			sys_kern_features
+340	64	kern_features		sys_kern_features
+341	common	kcmp			sys_kcmp
+342	common	finit_module		sys_finit_module
+343	common	sched_setattr		sys_sched_setattr
+344	common	sched_getattr		sys_sched_getattr
+345	common	renameat2		sys_renameat2
+346	common	seccomp			sys_seccomp
+347	common	getrandom		sys_getrandom
+348	common	memfd_create		sys_memfd_create
+349	common	bpf			sys_bpf
+350	32	execveat		sys_execveat			sys32_execveat
+350	64	execveat		sys64_execveat
+351	common	membarrier		sys_membarrier
+352	common	userfaultfd		sys_userfaultfd
+353	common	bind			sys_bind
+354	common	listen			sys_listen
+355	common	setsockopt		sys_setsockopt			compat_sys_setsockopt
+356	common	mlock2			sys_mlock2
+357	common	copy_file_range		sys_copy_file_range
+358	common	preadv2			sys_preadv2			compat_sys_preadv2
+359	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
+360	common	statx			sys_statx
+361	32	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
+361	64	io_pgetevents		sys_io_pgetevents
+362	common	pkey_mprotect		sys_pkey_mprotect
+363	common	pkey_alloc		sys_pkey_alloc
+364	common	pkey_free		sys_pkey_free
+365	common	rseq			sys_rseq
+# room for arch specific syscalls
+392	64	semtimedop			sys_semtimedop
+393	common	semget			sys_semget
+394	common	semctl			sys_semctl			compat_sys_semctl
+395	common	shmget			sys_shmget
+396	common	shmctl			sys_shmctl			compat_sys_shmctl
+397	common	shmat			sys_shmat			compat_sys_shmat
+398	common	shmdt			sys_shmdt
+399	common	msgget			sys_msgget
+400	common	msgsnd			sys_msgsnd			compat_sys_msgsnd
+401	common	msgrcv			sys_msgrcv			compat_sys_msgrcv
+402	common	msgctl			sys_msgctl			compat_sys_msgctl
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
+# 435 reserved for clone3
diff --git a/linux-user/sparc64/syscall_nr.h b/linux-user/sparc64/syscall_nr.h
deleted file mode 100644
index 6b088c9862bf..000000000000
--- a/linux-user/sparc64/syscall_nr.h
+++ /dev/null
@@ -1,366 +0,0 @@
-#ifndef LINUX_USER_SPARC64_SYSCALL_NR_H
-#define LINUX_USER_SPARC64_SYSCALL_NR_H
-
-#define TARGET_NR_restart_syscall      0 /* Linux Specific				   */
-#define TARGET_NR_exit                 1 /* Common                                      */
-#define TARGET_NR_fork                 2 /* Common                                      */
-#define TARGET_NR_read                 3 /* Common                                      */
-#define TARGET_NR_write                4 /* Common                                      */
-#define TARGET_NR_open                 5 /* Common                                      */
-#define TARGET_NR_close                6 /* Common                                      */
-#define TARGET_NR_wait4                7 /* Common                                      */
-#define TARGET_NR_creat                8 /* Common                                      */
-#define TARGET_NR_link                 9 /* Common                                      */
-#define TARGET_NR_unlink              10 /* Common                                      */
-#define TARGET_NR_execv               11 /* SunOS Specific                              */
-#define TARGET_NR_chdir               12 /* Common                                      */
-#define TARGET_NR_chown		 13 /* Common					   */
-#define TARGET_NR_mknod               14 /* Common                                      */
-#define TARGET_NR_chmod               15 /* Common                                      */
-#define TARGET_NR_lchown              16 /* Common                                      */
-#define TARGET_NR_brk                 17 /* Common                                      */
-#define TARGET_NR_perfctr             18 /* Performance counter operations              */
-#define TARGET_NR_lseek               19 /* Common                                      */
-#define TARGET_NR_getpid              20 /* Common                                      */
-#define TARGET_NR_capget		 21 /* Linux Specific				   */
-#define TARGET_NR_capset		 22 /* Linux Specific				   */
-#define TARGET_NR_setuid              23 /* Implemented via setreuid in SunOS           */
-#define TARGET_NR_getuid              24 /* Common                                      */
-#define TARGET_NR_vmsplice            25
-#define TARGET_NR_ptrace              26 /* Common                                      */
-#define TARGET_NR_alarm               27 /* Implemented via setitimer in SunOS          */
-#define TARGET_NR_sigaltstack	 28 /* Common					   */
-#define TARGET_NR_pause               29 /* Is sigblock(0)->sigpause() in SunOS         */
-#define TARGET_NR_utime               30 /* Implemented via utimes() under SunOS        */
-#define TARGET_NR_lchown32            31 /* Linux sparc32 specific                      */
-#define TARGET_NR_fchown32            32 /* Linux sparc32 specific                      */
-#define TARGET_NR_access              33 /* Common                                      */
-#define TARGET_NR_nice                34 /* Implemented via get/setpriority() in SunOS  */
-#define TARGET_NR_chown32             35 /*  Linux sparc32 specific                     */
-#define TARGET_NR_sync                36 /* Common                                      */
-#define TARGET_NR_kill                37 /* Common                                      */
-#define TARGET_NR_stat                38 /* Common                                      */
-#define TARGET_NR_sendfile		 39 /* Linux Specific				   */
-#define TARGET_NR_lstat               40 /* Common                                      */
-#define TARGET_NR_dup                 41 /* Common                                      */
-#define TARGET_NR_pipe                42 /* Common                                      */
-#define TARGET_NR_times               43 /* Implemented via getrusage() in SunOS        */
-#define TARGET_NR_getuid32            44 /* Linux sparc32 specific                      */
-#define TARGET_NR_umount2             45 /* Linux Specific                              */
-#define TARGET_NR_setgid              46 /* Implemented via setregid() in SunOS         */
-#define TARGET_NR_getgid              47 /* Common                                      */
-#define TARGET_NR_signal              48 /* Implemented via sigvec() in SunOS           */
-#define TARGET_NR_geteuid             49 /* SunOS calls getuid()                        */
-#define TARGET_NR_getegid             50 /* SunOS calls getgid()                        */
-#define TARGET_NR_acct                51 /* Common                                      */
-#define TARGET_NR_memory_ordering	 52 /* Linux Specific				   */
-#define TARGET_NR_getgid32            53 /* Linux sparc32 specific                      */
-#define TARGET_NR_ioctl               54 /* Common                                      */
-#define TARGET_NR_reboot              55 /* Common                                      */
-#define TARGET_NR_mmap2		      56 /* Linux sparc32 Specific                      */
-#define TARGET_NR_symlink             57 /* Common                                      */
-#define TARGET_NR_readlink            58 /* Common                                      */
-#define TARGET_NR_execve              59 /* Common                                      */
-#define TARGET_NR_umask               60 /* Common                                      */
-#define TARGET_NR_chroot              61 /* Common                                      */
-#define TARGET_NR_fstat               62 /* Common                                      */
-#define TARGET_NR_fstat64             63 /* Linux sparc32 Specific                      */
-#define TARGET_NR_getpagesize         64 /* Common                                      */
-#define TARGET_NR_msync               65 /* Common in newer 1.3.x revs...               */
-#define TARGET_NR_vfork               66 /* Common                                      */
-#define TARGET_NR_pread64             67 /* Linux Specific                              */
-#define TARGET_NR_pwrite64            68 /* Linux Specific                              */
-#define TARGET_NR_geteuid32           69 /* Linux sparc32, sbrk under SunOS             */
-#define TARGET_NR_getegid32           70 /* Linux sparc32, sstk under SunOS             */
-#define TARGET_NR_mmap                71 /* Common                                      */
-#define TARGET_NR_setreuid32          72 /* Linux sparc32, vadvise under SunOS          */
-#define TARGET_NR_munmap              73 /* Common                                      */
-#define TARGET_NR_mprotect            74 /* Common                                      */
-#define TARGET_NR_madvise             75 /* Common                                      */
-#define TARGET_NR_vhangup             76 /* Common                                      */
-#define TARGET_NR_truncate64          77 /* Linux sparc32 Specific			*/
-#define TARGET_NR_mincore             78 /* Common                                      */
-#define TARGET_NR_getgroups           79 /* Common                                      */
-#define TARGET_NR_setgroups           80 /* Common                                      */
-#define TARGET_NR_getpgrp             81 /* Common                                      */
-#define TARGET_NR_setgroups32         82 /* Linux sparc32, setpgrp under SunOS          */
-#define TARGET_NR_setitimer           83 /* Common                                      */
-#define TARGET_NR_ftruncate64         84 /* Linux sparc32 Specific                      */
-#define TARGET_NR_swapon              85 /* Common                                      */
-#define TARGET_NR_getitimer           86 /* Common                                      */
-#define TARGET_NR_setuid32            87 /* Linux sparc32, gethostname under SunOS      */
-#define TARGET_NR_sethostname         88 /* Common                                      */
-#define TARGET_NR_setgid32            89 /* Linux sparc32, getdtablesize under SunOS    */
-#define TARGET_NR_dup2                90 /* Common                                      */
-#define TARGET_NR_setfsuid32          91 /* Linux sparc32, getdopt under SunOS          */
-#define TARGET_NR_fcntl               92 /* Common                                      */
-#define TARGET_NR_select              93 /* Common                                      */
-#define TARGET_NR_setfsgid32          94 /* Linux sparc32, setdopt under SunOS          */
-#define TARGET_NR_fsync               95 /* Common                                      */
-#define TARGET_NR_setpriority         96 /* Common                                      */
-#define TARGET_NR_socket              97 /* Common                                      */
-#define TARGET_NR_connect             98 /* Common                                      */
-#define TARGET_NR_accept              99 /* Common                                      */
-#define TARGET_NR_getpriority        100 /* Common                                      */
-#define TARGET_NR_rt_sigreturn       101 /* Linux Specific                              */
-#define TARGET_NR_rt_sigaction       102 /* Linux Specific                              */
-#define TARGET_NR_rt_sigprocmask     103 /* Linux Specific                              */
-#define TARGET_NR_rt_sigpending      104 /* Linux Specific                              */
-#define TARGET_NR_rt_sigtimedwait    105 /* Linux Specific                              */
-#define TARGET_NR_rt_sigqueueinfo    106 /* Linux Specific                              */
-#define TARGET_NR_rt_sigsuspend      107 /* Linux Specific                              */
-#define TARGET_NR_setresuid          108 /* Linux Specific, sigvec under SunOS	   */
-#define TARGET_NR_getresuid          109 /* Linux Specific, sigblock under SunOS	   */
-#define TARGET_NR_setresgid          110 /* Linux Specific, sigsetmask under SunOS	   */
-#define TARGET_NR_getresgid          111 /* Linux Specific, sigpause under SunOS	   */
-/* #define TARGET_NR_setregid32          75  Linux sparc32, sigstack under SunOS         */
-#define TARGET_NR_recvmsg            113 /* Common                                      */
-#define TARGET_NR_sendmsg            114 /* Common                                      */
-#define TARGET_NR_getgroups32        115 /* Linux sparc32, vtrace under SunOS           */
-#define TARGET_NR_gettimeofday       116 /* Common                                      */
-#define TARGET_NR_getrusage          117 /* Common                                      */
-#define TARGET_NR_getsockopt         118 /* Common                                      */
-#define TARGET_NR_getcwd		119 /* Linux Specific				   */
-#define TARGET_NR_readv              120 /* Common                                      */
-#define TARGET_NR_writev             121 /* Common                                      */
-#define TARGET_NR_settimeofday       122 /* Common                                      */
-#define TARGET_NR_fchown             123 /* Common                                      */
-#define TARGET_NR_fchmod             124 /* Common                                      */
-#define TARGET_NR_recvfrom           125 /* Common                                      */
-#define TARGET_NR_setreuid           126 /* Common                                      */
-#define TARGET_NR_setregid           127 /* Common                                      */
-#define TARGET_NR_rename             128 /* Common                                      */
-#define TARGET_NR_truncate           129 /* Common                                      */
-#define TARGET_NR_ftruncate          130 /* Common                                      */
-#define TARGET_NR_flock              131 /* Common                                      */
-#define TARGET_NR_lstat64	     132 /* Linux sparc32 Specific                      */
-#define TARGET_NR_sendto             133 /* Common                                      */
-#define TARGET_NR_shutdown           134 /* Common                                      */
-#define TARGET_NR_socketpair         135 /* Common                                      */
-#define TARGET_NR_mkdir              136 /* Common                                      */
-#define TARGET_NR_rmdir              137 /* Common                                      */
-#define TARGET_NR_utimes             138 /* SunOS Specific                              */
-#define TARGET_NR_stat64	     139 /* Linux sparc32 Specific			   */
-#define TARGET_NR_sendfile64         140 /* adjtime under SunOS                         */
-#define TARGET_NR_getpeername        141 /* Common                                      */
-#define TARGET_NR_futex              142 /* gethostid under SunOS                       */
-#define TARGET_NR_gettid             143 /* ENOSYS under SunOS                          */
-#define TARGET_NR_getrlimit		144 /* Common                                      */
-#define TARGET_NR_setrlimit          145 /* Common                                      */
-#define TARGET_NR_pivot_root		146 /* Linux Specific, killpg under SunOS          */
-#define TARGET_NR_prctl		147 /* ENOSYS under SunOS                          */
-#define TARGET_NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
-#define TARGET_NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
-#define TARGET_NR_getsockname        150 /* Common                                      */
-#define TARGET_NR_inotify_init       151
-#define TARGET_NR_inotify_add_watch  152
-#define TARGET_NR_poll               153 /* Common                                      */
-#define TARGET_NR_getdents64		154 /* Linux specific				   */
-#define TARGET_NR_fcntl64            155 /* Linux sparc32 Specific                      */
-#define TARGET_NR_inotify_rm_watch   156 /* Linux specific                              */
-#define TARGET_NR_statfs             157 /* Common                                      */
-#define TARGET_NR_fstatfs            158 /* Common                                      */
-#define TARGET_NR_umount             159 /* Common                                      */
-#define TARGET_NR_sched_set_affinity 160 /* Linux specific, async_daemon under SunOS    */
-#define TARGET_NR_sched_get_affinity 161 /* Linux specific, getfh under SunOS           */
-#define TARGET_NR_getdomainname      162 /* SunOS Specific                              */
-#define TARGET_NR_setdomainname      163 /* Common                                      */
-#define TARGET_NR_utrap_install	164 /* SYSV ABI/v9 required			   */
-#define TARGET_NR_quotactl           165 /* Common                                      */
-#define TARGET_NR_set_tid_address    166 /* Linux specific, exportfs under SunOS        */
-#define TARGET_NR_mount              167 /* Common                                      */
-#define TARGET_NR_ustat              168 /* Common                                      */
-#define TARGET_NR_setxattr           169 /* SunOS: semsys                               */
-#define TARGET_NR_lsetxattr          170 /* SunOS: msgsys                               */
-#define TARGET_NR_fsetxattr          171 /* SunOS: shmsys                               */
-#define TARGET_NR_getxattr           172 /* SunOS: auditsys                             */
-#define TARGET_NR_lgetxattr          173 /* SunOS: rfssys                               */
-#define TARGET_NR_getdents           174 /* Common                                      */
-#define TARGET_NR_setsid             175 /* Common                                      */
-#define TARGET_NR_fchdir             176 /* Common                                      */
-#define TARGET_NR_fgetxattr          177 /* SunOS: fchroot                              */
-#define TARGET_NR_listxattr          178 /* SunOS: vpixsys                              */
-#define TARGET_NR_llistxattr         179 /* SunOS: aioread                              */
-#define TARGET_NR_flistxattr         180 /* SunOS: aiowrite                             */
-#define TARGET_NR_removexattr        181 /* SunOS: aiowait                              */
-#define TARGET_NR_lremovexattr       182 /* SunOS: aiocancel                            */
-#define TARGET_NR_sigpending         183 /* Common                                      */
-#define TARGET_NR_query_module	184 /* Linux Specific				   */
-#define TARGET_NR_setpgid            185 /* Common                                      */
-#define TARGET_NR_fremovexattr       186 /* SunOS: pathconf                             */
-#define TARGET_NR_tkill              187 /* SunOS: fpathconf                            */
-#define TARGET_NR_exit_group		188 /* Linux specific, sysconf undef SunOS         */
-#define TARGET_NR_uname              189 /* Linux Specific                              */
-#define TARGET_NR_init_module        190 /* Linux Specific                              */
-#define TARGET_NR_personality        191 /* Linux Specific                              */
-#define TARGET_NR_remap_file_pages   192 /* Linux Specific                              */
-#define TARGET_NR_epoll_create       193 /* Linux Specific                              */
-#define TARGET_NR_epoll_ctl          194 /* Linux Specific                              */
-#define TARGET_NR_epoll_wait         195 /* Linux Specific                              */
-#define TARGET_NR_ioprio_set         196
-#define TARGET_NR_getppid            197 /* Linux Specific                              */
-#define TARGET_NR_sigaction          198 /* Linux Specific                              */
-#define TARGET_NR_sgetmask           199 /* Linux Specific                              */
-#define TARGET_NR_ssetmask           200 /* Linux Specific                              */
-#define TARGET_NR_sigsuspend         201 /* Linux Specific                              */
-#define TARGET_NR_oldlstat           202 /* Linux Specific                              */
-#define TARGET_NR_uselib             203 /* Linux Specific                              */
-#define TARGET_NR_readdir            204 /* Linux Specific                              */
-#define TARGET_NR_readahead          205 /* Linux Specific                              */
-#define TARGET_NR_socketcall         206 /* Linux Specific                              */
-#define TARGET_NR_syslog             207 /* Linux Specific                              */
-#define TARGET_NR_lookup_dcookie     208 /* Linux Specific                              */
-#define TARGET_NR_fadvise64          209 /* Linux Specific                              */
-#define TARGET_NR_fadvise64_64       210 /* Linux Specific                              */
-#define TARGET_NR_tgkill             211 /* Linux Specific                              */
-#define TARGET_NR_waitpid            212 /* Linux Specific                              */
-#define TARGET_NR_swapoff            213 /* Linux Specific                              */
-#define TARGET_NR_sysinfo            214 /* Linux Specific                              */
-#define TARGET_NR_ipc                215 /* Linux Specific                              */
-#define TARGET_NR_sigreturn          216 /* Linux Specific                              */
-#define TARGET_NR_clone              217 /* Linux Specific                              */
-#define TARGET_NR_ioprio_get         218
-#define TARGET_NR_adjtimex           219 /* Linux Specific                              */
-#define TARGET_NR_sigprocmask        220 /* Linux Specific                              */
-#define TARGET_NR_create_module      221 /* Linux Specific                              */
-#define TARGET_NR_delete_module      222 /* Linux Specific                              */
-#define TARGET_NR_get_kernel_syms    223 /* Linux Specific                              */
-#define TARGET_NR_getpgid            224 /* Linux Specific                              */
-#define TARGET_NR_bdflush            225 /* Linux Specific                              */
-#define TARGET_NR_sysfs              226 /* Linux Specific                              */
-#define TARGET_NR_afs_syscall        227 /* Linux Specific                              */
-#define TARGET_NR_setfsuid           228 /* Linux Specific                              */
-#define TARGET_NR_setfsgid           229 /* Linux Specific                              */
-#define TARGET_NR__newselect         230 /* Linux Specific                              */
-#define TARGET_NR_time               231 /* Linux sparc32                               */
-#define TARGET_NR_splice             232
-#define TARGET_NR_stime              233 /* Linux Specific                              */
-#define TARGET_NR_statfs64           234 /* Linux Specific                              */
-#define TARGET_NR_fstatfs64          235 /* Linux Specific                              */
-#define TARGET_NR__llseek            236 /* Linux Specific                              */
-#define TARGET_NR_mlock              237
-#define TARGET_NR_munlock            238
-#define TARGET_NR_mlockall           239
-#define TARGET_NR_munlockall         240
-#define TARGET_NR_sched_setparam     241
-#define TARGET_NR_sched_getparam     242
-#define TARGET_NR_sched_setscheduler 243
-#define TARGET_NR_sched_getscheduler 244
-#define TARGET_NR_sched_yield        245
-#define TARGET_NR_sched_get_priority_max 246
-#define TARGET_NR_sched_get_priority_min 247
-#define TARGET_NR_sched_rr_get_interval  248
-#define TARGET_NR_nanosleep          249
-#define TARGET_NR_mremap             250
-#define TARGET_NR__sysctl            251
-#define TARGET_NR_getsid             252
-#define TARGET_NR_fdatasync          253
-#define TARGET_NR_nfsservctl         254
-#define TARGET_NR_sync_file_range    255
-#define TARGET_NR_clock_settime	256
-#define TARGET_NR_clock_gettime	257
-#define TARGET_NR_clock_getres	258
-#define TARGET_NR_clock_nanosleep	259
-#define TARGET_NR_sched_getaffinity	260
-#define TARGET_NR_sched_setaffinity	261
-#define TARGET_NR_timer_settime	262
-#define TARGET_NR_timer_gettime	263
-#define TARGET_NR_timer_getoverrun	264
-#define TARGET_NR_timer_delete	265
-#define TARGET_NR_timer_create	266
-/* #define TARGET_NR_vserver		267 Reserved for VSERVER */
-#define TARGET_NR_io_setup		268
-#define TARGET_NR_io_destroy		269
-#define TARGET_NR_io_submit		270
-#define TARGET_NR_io_cancel		271
-#define TARGET_NR_io_getevents	272
-#define TARGET_NR_mq_open		273
-#define TARGET_NR_mq_unlink		274
-#define TARGET_NR_mq_timedsend	275
-#define TARGET_NR_mq_timedreceive	276
-#define TARGET_NR_mq_notify		277
-#define TARGET_NR_mq_getsetattr	278
-#define TARGET_NR_waitid		279
-#define TARGET_NR_tee                   280
-#define TARGET_NR_add_key		281
-#define TARGET_NR_request_key	282
-#define TARGET_NR_keyctl		283
-#define TARGET_NR_openat		284
-#define TARGET_NR_mkdirat		285
-#define TARGET_NR_mknodat		286
-#define TARGET_NR_fchownat		287
-#define TARGET_NR_futimesat		288
-#define TARGET_NR_fstatat64		289
-#define TARGET_NR_unlinkat		290
-#define TARGET_NR_renameat		291
-#define TARGET_NR_linkat		292
-#define TARGET_NR_symlinkat		293
-#define TARGET_NR_readlinkat		294
-#define TARGET_NR_fchmodat		295
-#define TARGET_NR_faccessat		296
-#define TARGET_NR_pselect6		297
-#define TARGET_NR_ppoll		298
-#define TARGET_NR_unshare		299
-#define TARGET_NR_set_robust_list	300
-#define TARGET_NR_get_robust_list	301
-#define TARGET_NR_migrate_pages	302
-#define TARGET_NR_mbind		303
-#define TARGET_NR_get_mempolicy	304
-#define TARGET_NR_set_mempolicy	305
-#define TARGET_NR_kexec_load		306
-#define TARGET_NR_move_pages		307
-#define TARGET_NR_getcpu		308
-#define TARGET_NR_epoll_pwait	309
-#define TARGET_NR_utimensat		310
-#define TARGET_NR_signalfd		311
-#define TARGET_NR_timerfd_create        312
-#define TARGET_NR_eventfd		313
-#define TARGET_NR_fallocate		314
-#define TARGET_NR_timerfd_settime	315
-#define TARGET_NR_timerfd_gettime	316
-#define TARGET_NR_signalfd4		317
-#define TARGET_NR_eventfd2		318
-#define TARGET_NR_epoll_create1	319
-#define TARGET_NR_dup3			320
-#define TARGET_NR_pipe2		321
-#define TARGET_NR_inotify_init1	322
-#define TARGET_NR_accept4		323
-#define TARGET_NR_preadv                324
-#define TARGET_NR_pwritev               325
-#define TARGET_NR_rt_tgsigqueueinfo     326
-#define TARGET_NR_perf_event_open       327
-#define TARGET_NR_recvmmsg              328
-#define TARGET_NR_fanotify_init         329
-#define TARGET_NR_fanotify_mark         330
-#define TARGET_NR_prlimit64             331
-#define TARGET_NR_name_to_handle_at     332
-#define TARGET_NR_open_by_handle_at     333
-#define TARGET_NR_clock_adjtime         334
-#define TARGET_NR_syncfs                335
-#define TARGET_NR_sendmmsg              336
-#define TARGET_NR_setns                 337
-#define TARGET_NR_process_vm_readv      338
-#define TARGET_NR_process_vm_writev     339
-#define TARGET_NR_kern_features         340
-#define TARGET_NR_kcmp                  341
-#define TARGET_NR_finit_module          342
-#define TARGET_NR_sched_setattr         343
-#define TARGET_NR_sched_getattr         344
-#define TARGET_NR_renameat2             345
-#define TARGET_NR_seccomp               346
-#define TARGET_NR_getrandom             347
-#define TARGET_NR_memfd_create          348
-#define TARGET_NR_bpf                   349
-#define TARGET_NR_execveat              350
-#define TARGET_NR_membarrier            351
-#define TARGET_NR_userfaultfd           352
-#define TARGET_NR_bind                  353
-#define TARGET_NR_listen                354
-#define TARGET_NR_setsockopt            355
-#define TARGET_NR_mlock2                356
-#define TARGET_NR_copy_file_range       357
-#define TARGET_NR_preadv2               358
-#define TARGET_NR_pwritev2              359
-#define TARGET_NR_statx                 360
-
-#endif
diff --git a/linux-user/sparc64/syscallhdr.sh b/linux-user/sparc64/syscallhdr.sh
new file mode 100644
index 000000000000..08c7e39bb3fe
--- /dev/null
+++ b/linux-user/sparc64/syscallhdr.sh
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
+fileguard=LINUX_USER_SPARC64_`basename "$out" | sed \
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
2.24.1


