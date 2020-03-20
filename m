Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0342C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5EA20752
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5EA20752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJjb-00043U-FC
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJW0-00069B-Th
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJVv-0007xJ-IR
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJVv-0007v1-3h
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:47 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mof1D-1jddtR1w3V-00p4R1; Fri, 20 Mar 2020 16:24:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 16/32] linux-user, ppc: add syscall table generation support
Date: Fri, 20 Mar 2020 16:23:52 +0100
Message-Id: <20200320152408.182899-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:n2ZYqdD/ndavy8dnO/fmotKserkwGDOjQ3I1c6InAx1BkieuWcI
 XPueR33RMnkIDC/10gg5DSTz5+lrvSL1nhIMyBoOOeTmHKlkjTLS+oyXAfkkrBTpbR5HxKc
 772XDKzNU+bnKDMx5+sApd1vjjItuCaVGGJo080MKYZOW5xgjTpZNs+jZIxsG2IEx85Ae6U
 9cEyo+7AMHu+XhRUkhliw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mdw+Ve5aUXg=:gXUv25a90jPF6k9J8nzBgc
 ZcQ8mRe2EbiCHoklGKJLTQQNXvcT/6U4affs0aq1++8Tzgl+RVwBj7lOV2sPYthNIn+RDF0/h
 B3Qdt1XetqkvxuoHxYM+aQsqUV19A+hrOUpf5WXWXJFJ6cgPT3wRCIiqDN+r/wEs/FKlN15dj
 5m4mf47rXTCkllgbLSR66TFh6tVEYDLrfbfv4zfT4b1uLFOtoXwNRMLkel5R7tBEUzAXhnxvG
 fbAJAETz4JQ8fSEOaq/GlhgVEpVbzo2wZ14i5lHYSQfwM7SV6ulm2Yrh1K2OjAyKfmIrCxikK
 cVqVtE1cOgGugvSLFPqPPalH+n2eDV/pqPG0xJ3sk0p3p8IoU2MRvIfoRxllGt/MKgelGPQTq
 OU29AMfF0NGfFaz/ilSO07AJ5jJWKGkLAVfs8mMCQTJaCpgxSp+TL3uq0fymW30bnZI+jm4ru
 9XJ39Uy+8b2/ChbjZEf+kUGSf1t59MMjsOs13AXmVEXCfuZF3VFUqDQ2LnwSnzzSOez97mf8w
 rPSB21WoqBYOfqcy/Qw2eEQ8+nIGiyeuduUNfyjyoK5Ar4dQCbmJ7WE4tIxkhpTMjWXreMvDL
 iOmBXQrqZtCV+FWfq/fEHwRqymlPVXhTTigzvQ060nPc2BXGiooclE/5B6OnmQKjnG/hKCNN0
 Ef7duNNgMjNzladHgcc0x/P6x9bthqH1cl3FWXT+MWqrFSJ0na7hM5P9ZTy/L1/IkVyna3a9p
 epA65Mp0+0Xop9QPw8M7mUHgZIGXLp2NsRU5WV78tm267IJ+abvNYxnTcWPZeXKZh0+0UM61e
 zjIJkn19Dly5SUUNyPYkAOMHLdfNks29Nd6xGAWdDx+t1Qdy91GjXYmXz9CKQUZyIpUuKz9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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

Copy syscall.tbl and syscallhdr.sh from linux/arch/ppc/kernel/syscalls v5.5
Update syscallhdr.sh to generate QEMU syscall_nr.h
and to not generate the entry if entry point is sys_ni_syscall.

Fix ppc/signal.c to define do_sigreturn() for TARGET_ABI32.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-10-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                    |   6 +-
 linux-user/Makefile.objs     |   2 +
 linux-user/ppc/Makefile.objs |   6 +
 linux-user/ppc/signal.c      |   2 +-
 linux-user/ppc/syscall.tbl   | 519 +++++++++++++++++++++++++++++++++++
 linux-user/ppc/syscall_nr.h  | 402 ---------------------------
 linux-user/ppc/syscallhdr.sh |  34 +++
 7 files changed, 567 insertions(+), 404 deletions(-)
 create mode 100644 linux-user/ppc/Makefile.objs
 create mode 100644 linux-user/ppc/syscall.tbl
 delete mode 100644 linux-user/ppc/syscall_nr.h
 create mode 100644 linux-user/ppc/syscallhdr.sh

diff --git a/configure b/configure
index 5ed5e37df897..f2500823ba52 100755
--- a/configure
+++ b/configure
@@ -1889,7 +1889,7 @@ rm -f */config-devices.mak.d
 
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
-for arch in alpha hppa m68k xtensa sh4 microblaze arm ; do
+for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
@@ -7858,10 +7858,12 @@ case "$target_name" in
   ;;
   ppc)
     gdb_xml_files="power-core.xml power-fpu.xml power-altivec.xml power-spe.xml"
+    TARGET_SYSTBL_ABI=common,nospu,32
   ;;
   ppc64)
     TARGET_BASE_ARCH=ppc
     TARGET_ABI_DIR=ppc
+    TARGET_SYSTBL_ABI=common,nospu,64
     mttcg=yes
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
   ;;
@@ -7869,6 +7871,7 @@ case "$target_name" in
     TARGET_ARCH=ppc64
     TARGET_BASE_ARCH=ppc
     TARGET_ABI_DIR=ppc
+    TARGET_SYSTBL_ABI=common,nospu,64
     mttcg=yes
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
   ;;
@@ -7876,6 +7879,7 @@ case "$target_name" in
     TARGET_ARCH=ppc64
     TARGET_BASE_ARCH=ppc
     TARGET_ABI_DIR=ppc
+    TARGET_SYSTBL_ABI=common,nospu,32
     echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
   ;;
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index bc12e38291bc..8b00dad687b2 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -12,5 +12,7 @@ obj-$(TARGET_ARM) += arm/
 obj-$(TARGET_HPPA) += hppa/
 obj-$(TARGET_M68K) += m68k/
 obj-$(TARGET_MICROBLAZE) += microblaze/
+obj-$(TARGET_PPC) += ppc/
+obj-$(TARGET_PPC64) += ppc/
 obj-$(TARGET_SH4) += sh4/
 obj-$(TARGET_XTENSA) += xtensa/
diff --git a/linux-user/ppc/Makefile.objs b/linux-user/ppc/Makefile.objs
new file mode 100644
index 000000000000..be92e67eb160
--- /dev/null
+++ b/linux-user/ppc/Makefile.objs
@@ -0,0 +1,6 @@
+generated-files-y += linux-user/$(TARGET_ABI_DIR)/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/$(TARGET_ABI_DIR)/syscallhdr.sh
+
+%/syscall_nr.h: $(SRC_PATH)/linux-user/$(TARGET_ABI_DIR)/syscall.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 5b82af6cb623..0c4e7ba54caf 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -588,7 +588,7 @@ sigsegv:
 
 }
 
-#if !defined(TARGET_PPC64)
+#if !defined(TARGET_PPC64) || defined(TARGET_ABI32)
 long do_sigreturn(CPUPPCState *env)
 {
     struct target_sigcontext *sc = NULL;
diff --git a/linux-user/ppc/syscall.tbl b/linux-user/ppc/syscall.tbl
new file mode 100644
index 000000000000..43f736ed47f2
--- /dev/null
+++ b/linux-user/ppc/syscall.tbl
@@ -0,0 +1,519 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for powerpc
+#
+# The format is:
+# <number> <abi> <name> <entry point> <compat entry point>
+#
+# The <abi> can be common, spu, nospu, 64, or 32 for this file.
+#
+0	nospu	restart_syscall			sys_restart_syscall
+1	nospu	exit				sys_exit
+2	nospu	fork				ppc_fork
+3	common	read				sys_read
+4	common	write				sys_write
+5	common	open				sys_open			compat_sys_open
+6	common	close				sys_close
+7	common	waitpid				sys_waitpid
+8	common	creat				sys_creat
+9	common	link				sys_link
+10	common	unlink				sys_unlink
+11	nospu	execve				sys_execve			compat_sys_execve
+12	common	chdir				sys_chdir
+13	32	time				sys_time32
+13	64	time				sys_time
+13	spu	time				sys_time
+14	common	mknod				sys_mknod
+15	common	chmod				sys_chmod
+16	common	lchown				sys_lchown
+17	common	break				sys_ni_syscall
+18	32	oldstat				sys_stat			sys_ni_syscall
+18	64	oldstat				sys_ni_syscall
+18	spu	oldstat				sys_ni_syscall
+19	common	lseek				sys_lseek			compat_sys_lseek
+20	common	getpid				sys_getpid
+21	nospu	mount				sys_mount			compat_sys_mount
+22	32	umount				sys_oldumount
+22	64	umount				sys_ni_syscall
+22	spu	umount				sys_ni_syscall
+23	common	setuid				sys_setuid
+24	common	getuid				sys_getuid
+25	32	stime				sys_stime32
+25	64	stime				sys_stime
+25	spu	stime				sys_stime
+26	nospu	ptrace				sys_ptrace			compat_sys_ptrace
+27	common	alarm				sys_alarm
+28	32	oldfstat			sys_fstat			sys_ni_syscall
+28	64	oldfstat			sys_ni_syscall
+28	spu	oldfstat			sys_ni_syscall
+29	nospu	pause				sys_pause
+30	32	utime				sys_utime32
+30	64	utime				sys_utime
+31	common	stty				sys_ni_syscall
+32	common	gtty				sys_ni_syscall
+33	common	access				sys_access
+34	common	nice				sys_nice
+35	common	ftime				sys_ni_syscall
+36	common	sync				sys_sync
+37	common	kill				sys_kill
+38	common	rename				sys_rename
+39	common	mkdir				sys_mkdir
+40	common	rmdir				sys_rmdir
+41	common	dup				sys_dup
+42	common	pipe				sys_pipe
+43	common	times				sys_times			compat_sys_times
+44	common	prof				sys_ni_syscall
+45	common	brk				sys_brk
+46	common	setgid				sys_setgid
+47	common	getgid				sys_getgid
+48	nospu	signal				sys_signal
+49	common	geteuid				sys_geteuid
+50	common	getegid				sys_getegid
+51	nospu	acct				sys_acct
+52	nospu	umount2				sys_umount
+53	common	lock				sys_ni_syscall
+54	common	ioctl				sys_ioctl			compat_sys_ioctl
+55	common	fcntl				sys_fcntl			compat_sys_fcntl
+56	common	mpx				sys_ni_syscall
+57	common	setpgid				sys_setpgid
+58	common	ulimit				sys_ni_syscall
+59	32	oldolduname			sys_olduname
+59	64	oldolduname			sys_ni_syscall
+59	spu	oldolduname			sys_ni_syscall
+60	common	umask				sys_umask
+61	common	chroot				sys_chroot
+62	nospu	ustat				sys_ustat			compat_sys_ustat
+63	common	dup2				sys_dup2
+64	common	getppid				sys_getppid
+65	common	getpgrp				sys_getpgrp
+66	common	setsid				sys_setsid
+67	32	sigaction			sys_sigaction			compat_sys_sigaction
+67	64	sigaction			sys_ni_syscall
+67	spu	sigaction			sys_ni_syscall
+68	common	sgetmask			sys_sgetmask
+69	common	ssetmask			sys_ssetmask
+70	common	setreuid			sys_setreuid
+71	common	setregid			sys_setregid
+72	32	sigsuspend			sys_sigsuspend
+72	64	sigsuspend			sys_ni_syscall
+72	spu	sigsuspend			sys_ni_syscall
+73	32	sigpending			sys_sigpending			compat_sys_sigpending
+73	64	sigpending			sys_ni_syscall
+73	spu	sigpending			sys_ni_syscall
+74	common	sethostname			sys_sethostname
+75	common	setrlimit			sys_setrlimit			compat_sys_setrlimit
+76	32	getrlimit			sys_old_getrlimit		compat_sys_old_getrlimit
+76	64	getrlimit			sys_ni_syscall
+76	spu	getrlimit			sys_ni_syscall
+77	common	getrusage			sys_getrusage			compat_sys_getrusage
+78	common	gettimeofday			sys_gettimeofday		compat_sys_gettimeofday
+79	common	settimeofday			sys_settimeofday		compat_sys_settimeofday
+80	common	getgroups			sys_getgroups
+81	common	setgroups			sys_setgroups
+82	32	select				ppc_select			sys_ni_syscall
+82	64	select				sys_ni_syscall
+82	spu	select				sys_ni_syscall
+83	common	symlink				sys_symlink
+84	32	oldlstat			sys_lstat			sys_ni_syscall
+84	64	oldlstat			sys_ni_syscall
+84	spu	oldlstat			sys_ni_syscall
+85	common	readlink			sys_readlink
+86	nospu	uselib				sys_uselib
+87	nospu	swapon				sys_swapon
+88	nospu	reboot				sys_reboot
+89	32	readdir				sys_old_readdir			compat_sys_old_readdir
+89	64	readdir				sys_ni_syscall
+89	spu	readdir				sys_ni_syscall
+90	common	mmap				sys_mmap
+91	common	munmap				sys_munmap
+92	common	truncate			sys_truncate			compat_sys_truncate
+93	common	ftruncate			sys_ftruncate			compat_sys_ftruncate
+94	common	fchmod				sys_fchmod
+95	common	fchown				sys_fchown
+96	common	getpriority			sys_getpriority
+97	common	setpriority			sys_setpriority
+98	common	profil				sys_ni_syscall
+99	nospu	statfs				sys_statfs			compat_sys_statfs
+100	nospu	fstatfs				sys_fstatfs			compat_sys_fstatfs
+101	common	ioperm				sys_ni_syscall
+102	common	socketcall			sys_socketcall			compat_sys_socketcall
+103	common	syslog				sys_syslog
+104	common	setitimer			sys_setitimer			compat_sys_setitimer
+105	common	getitimer			sys_getitimer			compat_sys_getitimer
+106	common	stat				sys_newstat			compat_sys_newstat
+107	common	lstat				sys_newlstat			compat_sys_newlstat
+108	common	fstat				sys_newfstat			compat_sys_newfstat
+109	32	olduname			sys_uname
+109	64	olduname			sys_ni_syscall
+109	spu	olduname			sys_ni_syscall
+110	common	iopl				sys_ni_syscall
+111	common	vhangup				sys_vhangup
+112	common	idle				sys_ni_syscall
+113	common	vm86				sys_ni_syscall
+114	common	wait4				sys_wait4			compat_sys_wait4
+115	nospu	swapoff				sys_swapoff
+116	common	sysinfo				sys_sysinfo			compat_sys_sysinfo
+117	nospu	ipc				sys_ipc				compat_sys_ipc
+118	common	fsync				sys_fsync
+119	32	sigreturn			sys_sigreturn			compat_sys_sigreturn
+119	64	sigreturn			sys_ni_syscall
+119	spu	sigreturn			sys_ni_syscall
+120	nospu	clone				ppc_clone
+121	common	setdomainname			sys_setdomainname
+122	common	uname				sys_newuname
+123	common	modify_ldt			sys_ni_syscall
+124	32	adjtimex			sys_adjtimex_time32
+124	64	adjtimex			sys_adjtimex
+124	spu	adjtimex			sys_adjtimex
+125	common	mprotect			sys_mprotect
+126	32	sigprocmask			sys_sigprocmask			compat_sys_sigprocmask
+126	64	sigprocmask			sys_ni_syscall
+126	spu	sigprocmask			sys_ni_syscall
+127	common	create_module			sys_ni_syscall
+128	nospu	init_module			sys_init_module
+129	nospu	delete_module			sys_delete_module
+130	common	get_kernel_syms			sys_ni_syscall
+131	nospu	quotactl			sys_quotactl
+132	common	getpgid				sys_getpgid
+133	common	fchdir				sys_fchdir
+134	common	bdflush				sys_bdflush
+135	common	sysfs				sys_sysfs
+136	32	personality			sys_personality			ppc64_personality
+136	64	personality			ppc64_personality
+136	spu	personality			ppc64_personality
+137	common	afs_syscall			sys_ni_syscall
+138	common	setfsuid			sys_setfsuid
+139	common	setfsgid			sys_setfsgid
+140	common	_llseek				sys_llseek
+141	common	getdents			sys_getdents			compat_sys_getdents
+142	common	_newselect			sys_select			compat_sys_select
+143	common	flock				sys_flock
+144	common	msync				sys_msync
+145	common	readv				sys_readv			compat_sys_readv
+146	common	writev				sys_writev			compat_sys_writev
+147	common	getsid				sys_getsid
+148	common	fdatasync			sys_fdatasync
+149	nospu	_sysctl				sys_sysctl			compat_sys_sysctl
+150	common	mlock				sys_mlock
+151	common	munlock				sys_munlock
+152	common	mlockall			sys_mlockall
+153	common	munlockall			sys_munlockall
+154	common	sched_setparam			sys_sched_setparam
+155	common	sched_getparam			sys_sched_getparam
+156	common	sched_setscheduler		sys_sched_setscheduler
+157	common	sched_getscheduler		sys_sched_getscheduler
+158	common	sched_yield			sys_sched_yield
+159	common	sched_get_priority_max		sys_sched_get_priority_max
+160	common	sched_get_priority_min		sys_sched_get_priority_min
+161	32	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+161	64	sched_rr_get_interval		sys_sched_rr_get_interval
+161	spu	sched_rr_get_interval		sys_sched_rr_get_interval
+162	32	nanosleep			sys_nanosleep_time32
+162	64	nanosleep			sys_nanosleep
+162	spu	nanosleep			sys_nanosleep
+163	common	mremap				sys_mremap
+164	common	setresuid			sys_setresuid
+165	common	getresuid			sys_getresuid
+166	common	query_module			sys_ni_syscall
+167	common	poll				sys_poll
+168	common	nfsservctl			sys_ni_syscall
+169	common	setresgid			sys_setresgid
+170	common	getresgid			sys_getresgid
+171	common	prctl				sys_prctl
+172	nospu	rt_sigreturn			sys_rt_sigreturn		compat_sys_rt_sigreturn
+173	nospu	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
+174	nospu	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+175	nospu	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
+176	32	rt_sigtimedwait			sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+176	64	rt_sigtimedwait			sys_rt_sigtimedwait
+177	nospu 	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+178	nospu 	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+179	common	pread64				sys_pread64			compat_sys_pread64
+180	common	pwrite64			sys_pwrite64			compat_sys_pwrite64
+181	common	chown				sys_chown
+182	common	getcwd				sys_getcwd
+183	common	capget				sys_capget
+184	common	capset				sys_capset
+185	nospu	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
+186	32	sendfile			sys_sendfile			compat_sys_sendfile
+186	64	sendfile			sys_sendfile64
+186	spu	sendfile			sys_sendfile64
+187	common	getpmsg				sys_ni_syscall
+188	common 	putpmsg				sys_ni_syscall
+189	nospu	vfork				ppc_vfork
+190	common	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
+191	common	readahead			sys_readahead			compat_sys_readahead
+192	32	mmap2				sys_mmap2			compat_sys_mmap2
+193	32	truncate64			sys_truncate64			compat_sys_truncate64
+194	32	ftruncate64			sys_ftruncate64			compat_sys_ftruncate64
+195	32	stat64				sys_stat64
+196	32	lstat64				sys_lstat64
+197	32	fstat64				sys_fstat64
+198	nospu 	pciconfig_read			sys_pciconfig_read
+199	nospu 	pciconfig_write			sys_pciconfig_write
+200	nospu 	pciconfig_iobase		sys_pciconfig_iobase
+201	common 	multiplexer			sys_ni_syscall
+202	common	getdents64			sys_getdents64
+203	common	pivot_root			sys_pivot_root
+204	32	fcntl64				sys_fcntl64			compat_sys_fcntl64
+205	common	madvise				sys_madvise
+206	common	mincore				sys_mincore
+207	common	gettid				sys_gettid
+208	common	tkill				sys_tkill
+209	common	setxattr			sys_setxattr
+210	common	lsetxattr			sys_lsetxattr
+211	common	fsetxattr			sys_fsetxattr
+212	common	getxattr			sys_getxattr
+213	common	lgetxattr			sys_lgetxattr
+214	common	fgetxattr			sys_fgetxattr
+215	common	listxattr			sys_listxattr
+216	common	llistxattr			sys_llistxattr
+217	common	flistxattr			sys_flistxattr
+218	common	removexattr			sys_removexattr
+219	common	lremovexattr			sys_lremovexattr
+220	common	fremovexattr			sys_fremovexattr
+221	32	futex				sys_futex_time32
+221	64	futex				sys_futex
+221	spu	futex				sys_futex
+222	common	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
+223	common	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
+# 224 unused
+225	common	tuxcall				sys_ni_syscall
+226	32	sendfile64			sys_sendfile64			compat_sys_sendfile64
+227	common	io_setup			sys_io_setup			compat_sys_io_setup
+228	common	io_destroy			sys_io_destroy
+229	32	io_getevents			sys_io_getevents_time32
+229	64	io_getevents			sys_io_getevents
+229	spu	io_getevents			sys_io_getevents
+230	common	io_submit			sys_io_submit			compat_sys_io_submit
+231	common	io_cancel			sys_io_cancel
+232	nospu	set_tid_address			sys_set_tid_address
+233	common	fadvise64			sys_fadvise64			ppc32_fadvise64
+234	nospu	exit_group			sys_exit_group
+235	nospu	lookup_dcookie			sys_lookup_dcookie		compat_sys_lookup_dcookie
+236	common	epoll_create			sys_epoll_create
+237	common	epoll_ctl			sys_epoll_ctl
+238	common	epoll_wait			sys_epoll_wait
+239	common	remap_file_pages		sys_remap_file_pages
+240	common	timer_create			sys_timer_create		compat_sys_timer_create
+241	32	timer_settime			sys_timer_settime32
+241	64	timer_settime			sys_timer_settime
+241	spu	timer_settime			sys_timer_settime
+242	32	timer_gettime			sys_timer_gettime32
+242	64	timer_gettime			sys_timer_gettime
+242	spu	timer_gettime			sys_timer_gettime
+243	common	timer_getoverrun		sys_timer_getoverrun
+244	common	timer_delete			sys_timer_delete
+245	32	clock_settime			sys_clock_settime32
+245	64	clock_settime			sys_clock_settime
+245	spu	clock_settime			sys_clock_settime
+246	32	clock_gettime			sys_clock_gettime32
+246	64	clock_gettime			sys_clock_gettime
+246	spu	clock_gettime			sys_clock_gettime
+247	32	clock_getres			sys_clock_getres_time32
+247	64	clock_getres			sys_clock_getres
+247	spu	clock_getres			sys_clock_getres
+248	32	clock_nanosleep			sys_clock_nanosleep_time32
+248	64	clock_nanosleep			sys_clock_nanosleep
+248	spu	clock_nanosleep			sys_clock_nanosleep
+249	32	swapcontext			ppc_swapcontext			ppc32_swapcontext
+249	64	swapcontext			ppc64_swapcontext
+249	spu	swapcontext			sys_ni_syscall
+250	common	tgkill				sys_tgkill
+251	32	utimes				sys_utimes_time32
+251	64	utimes				sys_utimes
+251	spu	utimes				sys_utimes
+252	common	statfs64			sys_statfs64			compat_sys_statfs64
+253	common	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
+254	32	fadvise64_64			ppc_fadvise64_64
+254	spu	fadvise64_64			sys_ni_syscall
+255	common	rtas				sys_rtas
+256	32	sys_debug_setcontext		sys_debug_setcontext		sys_ni_syscall
+256	64	sys_debug_setcontext		sys_ni_syscall
+256	spu	sys_debug_setcontext		sys_ni_syscall
+# 257 reserved for vserver
+258	nospu	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
+259	nospu	mbind				sys_mbind			compat_sys_mbind
+260	nospu	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
+261	nospu	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
+262	nospu	mq_open				sys_mq_open			compat_sys_mq_open
+263	nospu	mq_unlink			sys_mq_unlink
+264	32	mq_timedsend			sys_mq_timedsend_time32
+264	64	mq_timedsend			sys_mq_timedsend
+265	32	mq_timedreceive			sys_mq_timedreceive_time32
+265	64	mq_timedreceive			sys_mq_timedreceive
+266	nospu	mq_notify			sys_mq_notify			compat_sys_mq_notify
+267	nospu	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
+268	nospu	kexec_load			sys_kexec_load			compat_sys_kexec_load
+269	nospu	add_key				sys_add_key
+270	nospu	request_key			sys_request_key
+271	nospu	keyctl				sys_keyctl			compat_sys_keyctl
+272	nospu	waitid				sys_waitid			compat_sys_waitid
+273	nospu	ioprio_set			sys_ioprio_set
+274	nospu	ioprio_get			sys_ioprio_get
+275	nospu	inotify_init			sys_inotify_init
+276	nospu	inotify_add_watch		sys_inotify_add_watch
+277	nospu	inotify_rm_watch		sys_inotify_rm_watch
+278	nospu	spu_run				sys_spu_run
+279	nospu	spu_create			sys_spu_create
+280	32	pselect6			sys_pselect6_time32		compat_sys_pselect6_time32
+280	64	pselect6			sys_pselect6
+281	32	ppoll				sys_ppoll_time32		compat_sys_ppoll_time32
+281	64	ppoll				sys_ppoll
+282	common	unshare				sys_unshare
+283	common	splice				sys_splice
+284	common	tee				sys_tee
+285	common	vmsplice			sys_vmsplice			compat_sys_vmsplice
+286	common	openat				sys_openat			compat_sys_openat
+287	common	mkdirat				sys_mkdirat
+288	common	mknodat				sys_mknodat
+289	common	fchownat			sys_fchownat
+290	32	futimesat			sys_futimesat_time32
+290	64	futimesat			sys_futimesat
+290	spu	utimesat			sys_futimesat
+291	32	fstatat64			sys_fstatat64
+291	64	newfstatat			sys_newfstatat
+291	spu	newfstatat			sys_newfstatat
+292	common	unlinkat			sys_unlinkat
+293	common	renameat			sys_renameat
+294	common	linkat				sys_linkat
+295	common	symlinkat			sys_symlinkat
+296	common	readlinkat			sys_readlinkat
+297	common	fchmodat			sys_fchmodat
+298	common	faccessat			sys_faccessat
+299	common	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
+300	common	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
+301	common	move_pages			sys_move_pages			compat_sys_move_pages
+302	common	getcpu				sys_getcpu
+303	nospu	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
+304	32	utimensat			sys_utimensat_time32
+304	64	utimensat			sys_utimensat
+304	spu	utimensat			sys_utimensat
+305	common	signalfd			sys_signalfd			compat_sys_signalfd
+306	common	timerfd_create			sys_timerfd_create
+307	common	eventfd				sys_eventfd
+308	common	sync_file_range2		sys_sync_file_range2		compat_sys_sync_file_range2
+309	nospu	fallocate			sys_fallocate			compat_sys_fallocate
+310	nospu	subpage_prot			sys_subpage_prot
+311	32	timerfd_settime			sys_timerfd_settime32
+311	64	timerfd_settime			sys_timerfd_settime
+311	spu	timerfd_settime			sys_timerfd_settime
+312	32	timerfd_gettime			sys_timerfd_gettime32
+312	64	timerfd_gettime			sys_timerfd_gettime
+312	spu	timerfd_gettime			sys_timerfd_gettime
+313	common	signalfd4			sys_signalfd4			compat_sys_signalfd4
+314	common	eventfd2			sys_eventfd2
+315	common	epoll_create1			sys_epoll_create1
+316	common	dup3				sys_dup3
+317	common	pipe2				sys_pipe2
+318	nospu	inotify_init1			sys_inotify_init1
+319	common	perf_event_open			sys_perf_event_open
+320	common	preadv				sys_preadv			compat_sys_preadv
+321	common	pwritev				sys_pwritev			compat_sys_pwritev
+322	nospu	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+323	nospu	fanotify_init			sys_fanotify_init
+324	nospu	fanotify_mark			sys_fanotify_mark		compat_sys_fanotify_mark
+325	common	prlimit64			sys_prlimit64
+326	common	socket				sys_socket
+327	common	bind				sys_bind
+328	common	connect				sys_connect
+329	common	listen				sys_listen
+330	common	accept				sys_accept
+331	common	getsockname			sys_getsockname
+332	common	getpeername			sys_getpeername
+333	common	socketpair			sys_socketpair
+334	common	send				sys_send
+335	common	sendto				sys_sendto
+336	common	recv				sys_recv			compat_sys_recv
+337	common	recvfrom			sys_recvfrom			compat_sys_recvfrom
+338	common	shutdown			sys_shutdown
+339	common	setsockopt			sys_setsockopt			compat_sys_setsockopt
+340	common	getsockopt			sys_getsockopt			compat_sys_getsockopt
+341	common	sendmsg				sys_sendmsg			compat_sys_sendmsg
+342	common	recvmsg				sys_recvmsg			compat_sys_recvmsg
+343	32	recvmmsg			sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+343	64	recvmmsg			sys_recvmmsg
+343	spu	recvmmsg			sys_recvmmsg
+344	common	accept4				sys_accept4
+345	common	name_to_handle_at		sys_name_to_handle_at
+346	common	open_by_handle_at		sys_open_by_handle_at		compat_sys_open_by_handle_at
+347	32	clock_adjtime			sys_clock_adjtime32
+347	64	clock_adjtime			sys_clock_adjtime
+347	spu	clock_adjtime			sys_clock_adjtime
+348	common	syncfs				sys_syncfs
+349	common	sendmmsg			sys_sendmmsg			compat_sys_sendmmsg
+350	common	setns				sys_setns
+351	nospu	process_vm_readv		sys_process_vm_readv		compat_sys_process_vm_readv
+352	nospu	process_vm_writev		sys_process_vm_writev		compat_sys_process_vm_writev
+353	nospu	finit_module			sys_finit_module
+354	nospu	kcmp				sys_kcmp
+355	common	sched_setattr			sys_sched_setattr
+356	common	sched_getattr			sys_sched_getattr
+357	common	renameat2			sys_renameat2
+358	common	seccomp				sys_seccomp
+359	common	getrandom			sys_getrandom
+360	common	memfd_create			sys_memfd_create
+361	common	bpf				sys_bpf
+362	nospu	execveat			sys_execveat			compat_sys_execveat
+363	32	switch_endian			sys_ni_syscall
+363	64	switch_endian			ppc_switch_endian
+363	spu	switch_endian			sys_ni_syscall
+364	common	userfaultfd			sys_userfaultfd
+365	common	membarrier			sys_membarrier
+# 366-377 originally left for IPC, now unused
+378	nospu	mlock2				sys_mlock2
+379	nospu	copy_file_range			sys_copy_file_range
+380	common	preadv2				sys_preadv2			compat_sys_preadv2
+381	common	pwritev2			sys_pwritev2			compat_sys_pwritev2
+382	nospu	kexec_file_load			sys_kexec_file_load
+383	nospu	statx				sys_statx
+384	nospu	pkey_alloc			sys_pkey_alloc
+385	nospu	pkey_free			sys_pkey_free
+386	nospu	pkey_mprotect			sys_pkey_mprotect
+387	nospu	rseq				sys_rseq
+388	32	io_pgetevents			sys_io_pgetevents_time32	compat_sys_io_pgetevents
+388	64	io_pgetevents			sys_io_pgetevents
+# room for arch specific syscalls
+392	64	semtimedop			sys_semtimedop
+393	common	semget				sys_semget
+394	common	semctl				sys_semctl			compat_sys_semctl
+395	common	shmget				sys_shmget
+396	common	shmctl				sys_shmctl			compat_sys_shmctl
+397	common	shmat				sys_shmat			compat_sys_shmat
+398	common	shmdt				sys_shmdt
+399	common	msgget				sys_msgget
+400	common	msgsnd				sys_msgsnd			compat_sys_msgsnd
+401	common	msgrcv				sys_msgrcv			compat_sys_msgrcv
+402	common	msgctl				sys_msgctl			compat_sys_msgctl
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
+435	nospu	clone3				ppc_clone3
diff --git a/linux-user/ppc/syscall_nr.h b/linux-user/ppc/syscall_nr.h
deleted file mode 100644
index b57a07b931af..000000000000
--- a/linux-user/ppc/syscall_nr.h
+++ /dev/null
@@ -1,402 +0,0 @@
-/*
- * This file contains the system call numbers.
- */
-
-#ifndef LINUX_USER_PPC_SYSCALL_NR_H
-#define LINUX_USER_PPC_SYSCALL_NR_H
-
-#define TARGET_NR_restart_syscall          0
-#define TARGET_NR_exit                     1
-#define TARGET_NR_fork                     2
-#define TARGET_NR_read                     3
-#define TARGET_NR_write                    4
-#define TARGET_NR_open                     5
-#define TARGET_NR_close                    6
-#define TARGET_NR_waitpid                  7
-#define TARGET_NR_creat                    8
-#define TARGET_NR_link                     9
-#define TARGET_NR_unlink                  10
-#define TARGET_NR_execve                  11
-#define TARGET_NR_chdir                   12
-#define TARGET_NR_time                    13
-#define TARGET_NR_mknod                   14
-#define TARGET_NR_chmod                   15
-#define TARGET_NR_lchown                  16
-#define TARGET_NR_break                   17
-#define TARGET_NR_oldstat                 18
-#define TARGET_NR_lseek                   19
-#define TARGET_NR_getpid                  20
-#define TARGET_NR_mount                   21
-#define TARGET_NR_umount                  22
-#define TARGET_NR_setuid                  23
-#define TARGET_NR_getuid                  24
-#define TARGET_NR_stime                   25
-#define TARGET_NR_ptrace                  26
-#define TARGET_NR_alarm                   27
-#define TARGET_NR_oldfstat                28
-#define TARGET_NR_pause                   29
-#define TARGET_NR_utime                   30
-#define TARGET_NR_stty                    31
-#define TARGET_NR_gtty                    32
-#define TARGET_NR_access                  33
-#define TARGET_NR_nice                    34
-#define TARGET_NR_ftime                   35
-#define TARGET_NR_sync                    36
-#define TARGET_NR_kill                    37
-#define TARGET_NR_rename                  38
-#define TARGET_NR_mkdir                   39
-#define TARGET_NR_rmdir                   40
-#define TARGET_NR_dup                     41
-#define TARGET_NR_pipe                    42
-#define TARGET_NR_times                   43
-#define TARGET_NR_prof                    44
-#define TARGET_NR_brk                     45
-#define TARGET_NR_setgid                  46
-#define TARGET_NR_getgid                  47
-#define TARGET_NR_signal                  48
-#define TARGET_NR_geteuid                 49
-#define TARGET_NR_getegid                 50
-#define TARGET_NR_acct                    51
-#define TARGET_NR_umount2                 52
-#define TARGET_NR_lock                    53
-#define TARGET_NR_ioctl                   54
-#define TARGET_NR_fcntl                   55
-#define TARGET_NR_mpx                     56
-#define TARGET_NR_setpgid                 57
-#define TARGET_NR_ulimit                  58
-#define TARGET_NR_oldolduname             59
-#define TARGET_NR_umask                   60
-#define TARGET_NR_chroot                  61
-#define TARGET_NR_ustat                   62
-#define TARGET_NR_dup2                    63
-#define TARGET_NR_getppid                 64
-#define TARGET_NR_getpgrp                 65
-#define TARGET_NR_setsid                  66
-#define TARGET_NR_sigaction               67
-#define TARGET_NR_sgetmask                68
-#define TARGET_NR_ssetmask                69
-#define TARGET_NR_setreuid                70
-#define TARGET_NR_setregid                71
-#define TARGET_NR_sigsuspend              72
-#define TARGET_NR_sigpending              73
-#define TARGET_NR_sethostname             74
-#define TARGET_NR_setrlimit               75
-#define TARGET_NR_getrlimit               76
-#define TARGET_NR_getrusage               77
-#define TARGET_NR_gettimeofday            78
-#define TARGET_NR_settimeofday            79
-#define TARGET_NR_getgroups               80
-#define TARGET_NR_setgroups               81
-#define TARGET_NR_select                  82
-#define TARGET_NR_symlink                 83
-#define TARGET_NR_oldlstat                84
-#define TARGET_NR_readlink                85
-#define TARGET_NR_uselib                  86
-#define TARGET_NR_swapon                  87
-#define TARGET_NR_reboot                  88
-#define TARGET_NR_readdir                 89
-#define TARGET_NR_mmap                    90
-#define TARGET_NR_munmap                  91
-#define TARGET_NR_truncate                92
-#define TARGET_NR_ftruncate               93
-#define TARGET_NR_fchmod                  94
-#define TARGET_NR_fchown                  95
-#define TARGET_NR_getpriority             96
-#define TARGET_NR_setpriority             97
-#define TARGET_NR_profil                  98
-#define TARGET_NR_statfs                  99
-#define TARGET_NR_fstatfs                100
-#define TARGET_NR_ioperm                 101
-#define TARGET_NR_socketcall             102
-#define TARGET_NR_syslog                 103
-#define TARGET_NR_setitimer              104
-#define TARGET_NR_getitimer              105
-#define TARGET_NR_stat                   106
-#define TARGET_NR_lstat                  107
-#define TARGET_NR_fstat                  108
-#define TARGET_NR_olduname               109
-#define TARGET_NR_iopl                   110
-#define TARGET_NR_vhangup                111
-#define TARGET_NR_idle                   112
-#define TARGET_NR_vm86                   113
-#define TARGET_NR_wait4                  114
-#define TARGET_NR_swapoff                115
-#define TARGET_NR_sysinfo                116
-#define TARGET_NR_ipc                    117
-#define TARGET_NR_fsync                  118
-#if !defined(TARGET_PPC64)
-#define TARGET_NR_sigreturn              119
-#endif
-#define TARGET_NR_clone                  120
-#define TARGET_NR_setdomainname          121
-#define TARGET_NR_uname                  122
-#define TARGET_NR_modify_ldt             123
-#define TARGET_NR_adjtimex               124
-#define TARGET_NR_mprotect               125
-#define TARGET_NR_sigprocmask            126
-#define TARGET_NR_create_module          127
-#define TARGET_NR_init_module            128
-#define TARGET_NR_delete_module          129
-#define TARGET_NR_get_kernel_syms        130
-#define TARGET_NR_quotactl               131
-#define TARGET_NR_getpgid                132
-#define TARGET_NR_fchdir                 133
-#define TARGET_NR_bdflush                134
-#define TARGET_NR_sysfs                  135
-#define TARGET_NR_personality            136
-#define TARGET_NR_afs_syscall            137 /* Syscall for Andrew File System */
-#define TARGET_NR_setfsuid               138
-#define TARGET_NR_setfsgid               139
-#define TARGET_NR__llseek                140
-#define TARGET_NR_getdents               141
-#define TARGET_NR__newselect             142
-#define TARGET_NR_flock                  143
-#define TARGET_NR_msync                  144
-#define TARGET_NR_readv                  145
-#define TARGET_NR_writev                 146
-#define TARGET_NR_getsid                 147
-#define TARGET_NR_fdatasync              148
-#define TARGET_NR__sysctl                149
-#define TARGET_NR_mlock                  150
-#define TARGET_NR_munlock                151
-#define TARGET_NR_mlockall               152
-#define TARGET_NR_munlockall             153
-#define TARGET_NR_sched_setparam         154
-#define TARGET_NR_sched_getparam         155
-#define TARGET_NR_sched_setscheduler     156
-#define TARGET_NR_sched_getscheduler     157
-#define TARGET_NR_sched_yield            158
-#define TARGET_NR_sched_get_priority_max 159
-#define TARGET_NR_sched_get_priority_min 160
-#define TARGET_NR_sched_rr_get_interval  161
-#define TARGET_NR_nanosleep              162
-#define TARGET_NR_mremap                 163
-#define TARGET_NR_setresuid32            164
-#define TARGET_NR_getresuid32            165
-#define TARGET_NR_query_module           166
-#define TARGET_NR_poll                   167
-#define TARGET_NR_nfsservctl             168
-#define TARGET_NR_setresgid32            169
-#define TARGET_NR_getresgid32            170
-#define TARGET_NR_prctl                  171
-#define TARGET_NR_rt_sigreturn           172
-#define TARGET_NR_rt_sigaction           173
-#define TARGET_NR_rt_sigprocmask         174
-#define TARGET_NR_rt_sigpending          175
-#define TARGET_NR_rt_sigtimedwait        176
-#define TARGET_NR_rt_sigqueueinfo        177
-#define TARGET_NR_rt_sigsuspend          178
-#define TARGET_NR_pread64                179
-#define TARGET_NR_pwrite64               180
-#define TARGET_NR_chown                  181
-#define TARGET_NR_getcwd                 182
-#define TARGET_NR_capget                 183
-#define TARGET_NR_capset                 184
-#define TARGET_NR_sigaltstack            185
-#define TARGET_NR_sendfile               186
-#define TARGET_NR_getpmsg                187     /* some people actually want streams */
-#define TARGET_NR_putpmsg                188     /* some people actually want streams */
-#define TARGET_NR_vfork                  189
-#define TARGET_NR_ugetrlimit             190     /* SuS compliant getrlimit */
-#define TARGET_NR_readahead              191
-#if !defined(TARGET_PPC64) || defined(TARGET_ABI32)
-#define TARGET_NR_mmap2                  192
-#define TARGET_NR_truncate64             193
-#define TARGET_NR_ftruncate64            194
-#define TARGET_NR_stat64                 195
-#define TARGET_NR_lstat64                196
-#define TARGET_NR_fstat64                197
-#endif
-#define TARGET_NR_pciconfig_read         198
-#define TARGET_NR_pciconfig_write        199
-#define TARGET_NR_pciconfig_iobase       200
-#define TARGET_NR_multiplexer            201
-#define TARGET_NR_getdents64             202
-#define TARGET_NR_pivot_root             203
-#if !defined(TARGET_PPC64) || defined(TARGET_ABI32)
-#define TARGET_NR_fcntl64                204
-#endif
-#define TARGET_NR_madvise                205
-#define TARGET_NR_mincore                206
-#define TARGET_NR_gettid                 207
-#define TARGET_NR_tkill                  208
-#define TARGET_NR_setxattr               209
-#define TARGET_NR_lsetxattr              210
-#define TARGET_NR_fsetxattr              211
-#define TARGET_NR_getxattr               212
-#define TARGET_NR_lgetxattr              213
-#define TARGET_NR_fgetxattr              214
-#define TARGET_NR_listxattr              215
-#define TARGET_NR_llistxattr             216
-#define TARGET_NR_flistxattr             217
-#define TARGET_NR_removexattr            218
-#define TARGET_NR_lremovexattr           219
-#define TARGET_NR_fremovexattr           220
-#define TARGET_NR_futex                  221
-#define TARGET_NR_sched_setaffinity      222
-#define TARGET_NR_sched_getaffinity      223
-/* 224 currently unused */
-#define TARGET_NR_tuxcall                225
-#if !defined(TARGET_PPC64) || defined(TARGET_ABI32)
-#define TARGET_NR_sendfile64             226
-#endif
-#define TARGET_NR_io_setup               227
-#define TARGET_NR_io_destroy             228
-#define TARGET_NR_io_getevents           229
-#define TARGET_NR_io_submit              230
-#define TARGET_NR_io_cancel              231
-#define TARGET_NR_set_tid_address        232
-#define TARGET_NR_fadvise64              233
-#define TARGET_NR_exit_group             234
-#define TARGET_NR_lookup_dcookie         235
-#define TARGET_NR_epoll_create           236
-#define TARGET_NR_epoll_ctl              237
-#define TARGET_NR_epoll_wait             238
-#define TARGET_NR_remap_file_pages       239
-#define TARGET_NR_timer_create           240
-#define TARGET_NR_timer_settime          241
-#define TARGET_NR_timer_gettime          242
-#define TARGET_NR_timer_getoverrun       243
-#define TARGET_NR_timer_delete           244
-#define TARGET_NR_clock_settime          245
-#define TARGET_NR_clock_gettime          246
-#define TARGET_NR_clock_getres           247
-#define TARGET_NR_clock_nanosleep        248
-#define TARGET_NR_swapcontext            249
-#define TARGET_NR_tgkill                 250
-#define TARGET_NR_utimes                 251
-#define TARGET_NR_statfs64               252
-#define TARGET_NR_fstatfs64              253
-#if !defined(TARGET_PPC64) || defined(TARGET_ABI32)
-#define TARGET_NR_fadvise64_64           254
-#endif
-#define TARGET_NR_rtas		255
-#define TARGET_NR_sys_debug_setcontext 256
-/* Number 257 is reserved for vserver */
-#define TARGET_NR_migrate_pages	258
-#define TARGET_NR_mbind		259
-#define TARGET_NR_get_mempolicy	260
-#define TARGET_NR_set_mempolicy	261
-#define TARGET_NR_mq_open		262
-#define TARGET_NR_mq_unlink		263
-#define TARGET_NR_mq_timedsend	264
-#define TARGET_NR_mq_timedreceive	265
-#define TARGET_NR_mq_notify		266
-#define TARGET_NR_mq_getsetattr	267
-#define TARGET_NR_kexec_load		268
-#define TARGET_NR_add_key		269
-#define TARGET_NR_request_key	270
-#define TARGET_NR_keyctl		271
-#define TARGET_NR_waitid		272
-#define TARGET_NR_ioprio_set		273
-#define TARGET_NR_ioprio_get		274
-#define TARGET_NR_inotify_init	275
-#define TARGET_NR_inotify_add_watch	276
-#define TARGET_NR_inotify_rm_watch	277
-#define TARGET_NR_spu_run		278
-#define TARGET_NR_spu_create		279
-#define TARGET_NR_pselect6		280
-#define TARGET_NR_ppoll		281
-#define TARGET_NR_unshare		282
-#define TARGET_NR_splice		283
-#define TARGET_NR_tee		284
-#define TARGET_NR_vmsplice		285
-#define TARGET_NR_openat		286
-#define TARGET_NR_mkdirat		287
-#define TARGET_NR_mknodat		288
-#define TARGET_NR_fchownat		289
-#define TARGET_NR_futimesat		290
-#if defined(TARGET_PPC64) && !defined(TARGET_ABI32)
-#define TARGET_NR_newfstatat		291
-#else
-#define TARGET_NR_fstatat64		291
-#endif
-#define TARGET_NR_unlinkat		292
-#define TARGET_NR_renameat		293
-#define TARGET_NR_linkat		294
-#define TARGET_NR_symlinkat		295
-#define TARGET_NR_readlinkat		296
-#define TARGET_NR_fchmodat		297
-#define TARGET_NR_faccessat		298
-#define TARGET_NR_get_robust_list	299
-#define TARGET_NR_set_robust_list	300
-#define TARGET_NR_move_pages		301
-#define TARGET_NR_getcpu		302
-#define TARGET_NR_epoll_pwait	303
-#define TARGET_NR_utimensat		304
-#define TARGET_NR_signalfd		305
-#define TARGET_NR_timerfd_create	306
-#define TARGET_NR_eventfd		307
-#define TARGET_NR_sync_file_range2	308
-#define TARGET_NR_fallocate		309
-#define TARGET_NR_subpage_prot		310
-#define TARGET_NR_timerfd_settime	311
-#define TARGET_NR_timerfd_gettime	312
-#define TARGET_NR_signalfd4		313
-#define TARGET_NR_eventfd2		314
-#define TARGET_NR_epoll_create1	315
-#define TARGET_NR_dup3			316
-#define TARGET_NR_pipe2		317
-#define TARGET_NR_inotify_init1	318
-#define TARGET_NR_perf_event_open       319
-#define TARGET_NR_preadv                320
-#define TARGET_NR_pwritev               321
-#define TARGET_NR_rt_tgsigqueueinfo     322
-#define TARGET_NR_fanotify_init         323
-#define TARGET_NR_fanotify_mark         324
-#define TARGET_NR_prlimit64             325
-#define TARGET_NR_socket                326
-#define TARGET_NR_bind                  327
-#define TARGET_NR_connect               328
-#define TARGET_NR_listen                329
-#define TARGET_NR_accept                330
-#define TARGET_NR_getsockname           331
-#define TARGET_NR_getpeername           332
-#define TARGET_NR_socketpair            333
-#define TARGET_NR_send                  334
-#define TARGET_NR_sendto                335
-#define TARGET_NR_recv                  336
-#define TARGET_NR_recvfrom              337
-#define TARGET_NR_shutdown              338
-#define TARGET_NR_setsockopt            339
-#define TARGET_NR_getsockopt            340
-#define TARGET_NR_sendmsg               341
-#define TARGET_NR_recvmsg               342
-#define TARGET_NR_recvmmsg              343
-#define TARGET_NR_accept4               344
-#define TARGET_NR_name_to_handle_at     345
-#define TARGET_NR_open_by_handle_at     346
-#define TARGET_NR_clock_adjtime         347
-#define TARGET_NR_syncfs                348
-#define TARGET_NR_sendmmsg              349
-#define TARGET_NR_setns                 350
-#define TARGET_NR_process_vm_readv      351
-#define TARGET_NR_process_vm_writev     352
-#define TARGET_NR_finit_module          353
-#define TARGET_NR_kcmp                  354
-#define TARGET_NR_sched_setattr         355
-#define TARGET_NR_sched_getattr         356
-#define TARGET_NR_renameat2             357
-#define TARGET_NR_seccomp               358
-#define TARGET_NR_getrandom             359
-#define TARGET_NR_memfd_create          360
-#define TARGET_NR_bpf                   361
-#define TARGET_NR_execveat              362
-#define TARGET_NR_switch_endian         363
-#define TARGET_NR_userfaultfd           364
-#define TARGET_NR_membarrier            365
-#define TARGET_NR_semop                 366
-#define TARGET_NR_semget                367
-#define TARGET_NR_semctl                368
-#define TARGET_NR_semtimedop            369
-#define TARGET_NR_msgsnd                370
-#define TARGET_NR_msgrcv                371
-#define TARGET_NR_msgget                372
-#define TARGET_NR_msgctl                373
-#define TARGET_NR_shmat                 374
-#define TARGET_NR_shmdt                 375
-#define TARGET_NR_shmget                376
-#define TARGET_NR_shmctl                377
-#define TARGET_NR_mlock2                378
-
-#endif
diff --git a/linux-user/ppc/syscallhdr.sh b/linux-user/ppc/syscallhdr.sh
new file mode 100644
index 000000000000..6c44e0eaad20
--- /dev/null
+++ b/linux-user/ppc/syscallhdr.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+prefix="$4"
+offset="$5"
+
+fileguard=LINUX_USER_PPC_`basename "$out" | sed \
+    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
+    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
+grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
+    printf "#ifndef %s\n" "${fileguard}"
+    printf "#define %s\n" "${fileguard}"
+    printf "\n"
+
+    while read nr abi name entry compat ; do
+        if [ "$entry" = "sys_ni_syscall" ] ; then
+            continue
+        fi
+        if [ -z "$offset" ]; then
+            printf "#define TARGET_NR_%s%s\t%s\n" \
+                "${prefix}" "${name}" "${nr}"
+        else
+            printf "#define TARGET_NR_%s%s\t(%s + %s)\n" \
+                "${prefix}" "${name}" "${offset}" "${nr}"
+        fi
+    done
+
+    printf "\n"
+    printf "#endif /* %s */" "${fileguard}"
+    printf "\n"
+) > "$out"
-- 
2.25.1


