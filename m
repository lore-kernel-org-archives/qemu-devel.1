Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE45C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6A920674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6A920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDu97-0005m2-Pw
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsQQ-0008G1-Fn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsQE-0005ep-As
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33925)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsQD-0005XM-Oy
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:58 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7NaW-1jEzwr30Pc-007hSN; Mon, 16 Mar 2020 17:16:42 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 30/38] linux-user, mips64: add syscall table generation support
Date: Mon, 16 Mar 2020 17:15:42 +0100
Message-Id: <20200316161550.336150-31-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tF5kE1yxb6l1TyrXwiCqA7+lE4NvMmQ2pbuqNXdPcAnQKbcJgA8
 wCimBLWMxghxuR1NWK1IvfgP2mc/XAY43tepZD5/0uPqxel1d0rb800NCoZvIhEuvX1XJhI
 I5ollD/uWNg3oHhCPysKLbHvDcWyBV5KTQ67xKaDCB3xunUVYPA/dq9aeYxQTZKziwWFNwu
 ZdgZ5A57B61UqoW9lIcig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NFwGr20dh4M=:ZqG0Rxz3RhHOZZGb09Kk/d
 NGaqqvw7wf75zVL6lwb6daT7WiUgEodlliFbsERukJiKeRWSgn7BqQY5hmyEBsOTTx4HSHJcO
 O5pxUvJ1dctmA7LSN/75/tVdrHNWOGtVYY/mnm3IAfh1AWiWeRaI9CQXypzO7ZubRPe0uf30w
 +nif6acdFLjEQpzQP032kST67MvNZ+CTDYZZv4iQ/VLLU/KyS7P2WHDdCrhSaTxcN08Sfkukj
 BkcKxvEOvq5Kf5/3t1ka4qYhicYmrxwD7JYWJ/kilD60eZzu5Z+1S7oNTOH0PF/WBUBQM5MTc
 9c3Rvie6h+gOddxA7r4EJZd278Et495QMVKjnyUIhARFJCyazmNDSYQQj5LBepA5PPTkajb7p
 P4uFvKTccgnwAu4Ck60p65jjKGxrId5O+HprIc6crJrsFi1cc9YAhTr0YRxOxFGKvunaj8Jid
 Vl0FhyA0xTuKoYNShn2KAcv79qiTX292ASLJB+P2oy3Osz7DL8zR4+fTqIznboFCNCgVm8r2h
 LhYRAgXiv/z5TLpzdiqMLTLjkDQMLgELVy09D5tgM8EAdVGu24FUdHJtvKnDdBoSsjxyrXgI6
 2FOc7DGRb4QydknStpvjD/ppS720EUJuXgDCY2xQ5r6Fb4vvAcbgL42GxbCGQ0+g/EkxG0mNG
 EEvetgIJiOBkGZbp8o7Nx8ie0PfvOj9qwz6ycTRIDLiBed/w+x1OZJ0MfLtw+MVOdIarTA3Ai
 KUtHjZD+Ee2d7ZT+QV5sgBtQfAemvyiF3EI7NP2IYH3jBlZxYlmMIdxqoLKSqIqCL33Mjmezs
 xQQ92JQNwBMS6PvmNdyyhvuHv3lh7lJJPbrbu9JkHLwgxYn5G26LMUPIXRGCXAmWiN+FO1G
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Copy syscall_n32.tbl, syscall_n64.tbl and syscallhdr.sh from
linux/arch/parisc/kernel/syscalls v5.5
Update syscallhdr.sh to generate QEMU syscall_nr.h

Move the offsets (6000 for n32 and 5000 for n64) from the file to
the Makefile.objs to be passed to syscallhdr.sh

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-18-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                         |   4 +-
 linux-user/Makefile.objs          |   1 +
 linux-user/mips64/Makefile.objs   |  12 +
 linux-user/mips64/syscall_n32.tbl | 376 ++++++++++++++++
 linux-user/mips64/syscall_n64.tbl | 352 +++++++++++++++
 linux-user/mips64/syscall_nr.h    | 725 ------------------------------
 linux-user/mips64/syscallhdr.sh   |  33 ++
 7 files changed, 777 insertions(+), 726 deletions(-)
 create mode 100644 linux-user/mips64/Makefile.objs
 create mode 100644 linux-user/mips64/syscall_n32.tbl
 create mode 100644 linux-user/mips64/syscall_n64.tbl
 delete mode 100644 linux-user/mips64/syscall_nr.h
 create mode 100644 linux-user/mips64/syscallhdr.sh

diff --git a/configure b/configure
index 7432f955b8f5..a60292db63b3 100755
--- a/configure
+++ b/configure
@@ -1890,7 +1890,7 @@ rm -f */config-devices.mak.d
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
 for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc s390x sparc sparc64 \
-    i386 x86_64 mips ; do
+    i386 x86_64 mips mips64 ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
@@ -7845,12 +7845,14 @@ case "$target_name" in
     TARGET_BASE_ARCH=mips
     echo "TARGET_ABI_MIPSN32=y" >> $config_target_mak
     echo "TARGET_ABI32=y" >> $config_target_mak
+    TARGET_SYSTBL_ABI=n32
   ;;
   mips64|mips64el)
     mttcg="yes"
     TARGET_ARCH=mips64
     TARGET_BASE_ARCH=mips
     echo "TARGET_ABI_MIPSN64=y" >> $config_target_mak
+    TARGET_SYSTBL_ABI=n64
   ;;
   moxie)
   ;;
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 0a0715e9e192..1940910a7321 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -14,6 +14,7 @@ obj-$(TARGET_I386) += i386/
 obj-$(TARGET_M68K) += m68k/
 obj-$(TARGET_MICROBLAZE) += microblaze/
 obj-$(TARGET_MIPS) += mips/
+obj-$(TARGET_MIPS64) += mips64/
 obj-$(TARGET_PPC) += ppc/
 obj-$(TARGET_PPC64) += ppc/
 obj-$(TARGET_S390X) += s390x/
diff --git a/linux-user/mips64/Makefile.objs b/linux-user/mips64/Makefile.objs
new file mode 100644
index 000000000000..573448f9568a
--- /dev/null
+++ b/linux-user/mips64/Makefile.objs
@@ -0,0 +1,12 @@
+generated-files-y += linux-user/$(TARGET_ABI_DIR)/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/$(TARGET_ABI_DIR)/syscallhdr.sh
+
+ifeq ($(TARGET_SYSTBL_ABI),n32)
+%/syscall_nr.h: $(SRC_PATH)/linux-user/$(TARGET_ABI_DIR)/syscall_n32.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ n32 "" 6000,"GEN","$@")
+endif
+ifeq ($(TARGET_SYSTBL_ABI),n64)
+%/syscall_nr.h: $(SRC_PATH)/linux-user/$(TARGET_ABI_DIR)/syscall_n64.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ n64 "" 5000,"GEN","$@")
+endif
diff --git a/linux-user/mips64/syscall_n32.tbl b/linux-user/mips64/syscall_n32.tbl
new file mode 100644
index 000000000000..e7c5ab38e403
--- /dev/null
+++ b/linux-user/mips64/syscall_n32.tbl
@@ -0,0 +1,376 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for mips
+#
+# The format is:
+# <number> <abi> <name> <entry point> <compat entry point>
+#
+# The <abi> is always "n32" for this file.
+#
+0	n32	read				sys_read
+1	n32	write				sys_write
+2	n32	open				sys_open
+3	n32	close				sys_close
+4	n32	stat				sys_newstat
+5	n32	fstat				sys_newfstat
+6	n32	lstat				sys_newlstat
+7	n32	poll				sys_poll
+8	n32	lseek				sys_lseek
+9	n32	mmap				sys_mips_mmap
+10	n32	mprotect			sys_mprotect
+11	n32	munmap				sys_munmap
+12	n32	brk				sys_brk
+13	n32	rt_sigaction			compat_sys_rt_sigaction
+14	n32	rt_sigprocmask			compat_sys_rt_sigprocmask
+15	n32	ioctl				compat_sys_ioctl
+16	n32	pread64				sys_pread64
+17	n32	pwrite64			sys_pwrite64
+18	n32	readv				compat_sys_readv
+19	n32	writev				compat_sys_writev
+20	n32	access				sys_access
+21	n32	pipe				sysm_pipe
+22	n32	_newselect			compat_sys_select
+23	n32	sched_yield			sys_sched_yield
+24	n32	mremap				sys_mremap
+25	n32	msync				sys_msync
+26	n32	mincore				sys_mincore
+27	n32	madvise				sys_madvise
+28	n32	shmget				sys_shmget
+29	n32	shmat				sys_shmat
+30	n32	shmctl				compat_sys_old_shmctl
+31	n32	dup				sys_dup
+32	n32	dup2				sys_dup2
+33	n32	pause				sys_pause
+34	n32	nanosleep			sys_nanosleep_time32
+35	n32	getitimer			compat_sys_getitimer
+36	n32	setitimer			compat_sys_setitimer
+37	n32	alarm				sys_alarm
+38	n32	getpid				sys_getpid
+39	n32	sendfile			compat_sys_sendfile
+40	n32	socket				sys_socket
+41	n32	connect				sys_connect
+42	n32	accept				sys_accept
+43	n32	sendto				sys_sendto
+44	n32	recvfrom			compat_sys_recvfrom
+45	n32	sendmsg				compat_sys_sendmsg
+46	n32	recvmsg				compat_sys_recvmsg
+47	n32	shutdown			sys_shutdown
+48	n32	bind				sys_bind
+49	n32	listen				sys_listen
+50	n32	getsockname			sys_getsockname
+51	n32	getpeername			sys_getpeername
+52	n32	socketpair			sys_socketpair
+53	n32	setsockopt			compat_sys_setsockopt
+54	n32	getsockopt			compat_sys_getsockopt
+55	n32	clone				__sys_clone
+56	n32	fork				__sys_fork
+57	n32	execve				compat_sys_execve
+58	n32	exit				sys_exit
+59	n32	wait4				compat_sys_wait4
+60	n32	kill				sys_kill
+61	n32	uname				sys_newuname
+62	n32	semget				sys_semget
+63	n32	semop				sys_semop
+64	n32	semctl				compat_sys_old_semctl
+65	n32	shmdt				sys_shmdt
+66	n32	msgget				sys_msgget
+67	n32	msgsnd				compat_sys_msgsnd
+68	n32	msgrcv				compat_sys_msgrcv
+69	n32	msgctl				compat_sys_old_msgctl
+70	n32	fcntl				compat_sys_fcntl
+71	n32	flock				sys_flock
+72	n32	fsync				sys_fsync
+73	n32	fdatasync			sys_fdatasync
+74	n32	truncate			sys_truncate
+75	n32	ftruncate			sys_ftruncate
+76	n32	getdents			compat_sys_getdents
+77	n32	getcwd				sys_getcwd
+78	n32	chdir				sys_chdir
+79	n32	fchdir				sys_fchdir
+80	n32	rename				sys_rename
+81	n32	mkdir				sys_mkdir
+82	n32	rmdir				sys_rmdir
+83	n32	creat				sys_creat
+84	n32	link				sys_link
+85	n32	unlink				sys_unlink
+86	n32	symlink				sys_symlink
+87	n32	readlink			sys_readlink
+88	n32	chmod				sys_chmod
+89	n32	fchmod				sys_fchmod
+90	n32	chown				sys_chown
+91	n32	fchown				sys_fchown
+92	n32	lchown				sys_lchown
+93	n32	umask				sys_umask
+94	n32	gettimeofday			compat_sys_gettimeofday
+95	n32	getrlimit			compat_sys_getrlimit
+96	n32	getrusage			compat_sys_getrusage
+97	n32	sysinfo				compat_sys_sysinfo
+98	n32	times				compat_sys_times
+99	n32	ptrace				compat_sys_ptrace
+100	n32	getuid				sys_getuid
+101	n32	syslog				sys_syslog
+102	n32	getgid				sys_getgid
+103	n32	setuid				sys_setuid
+104	n32	setgid				sys_setgid
+105	n32	geteuid				sys_geteuid
+106	n32	getegid				sys_getegid
+107	n32	setpgid				sys_setpgid
+108	n32	getppid				sys_getppid
+109	n32	getpgrp				sys_getpgrp
+110	n32	setsid				sys_setsid
+111	n32	setreuid			sys_setreuid
+112	n32	setregid			sys_setregid
+113	n32	getgroups			sys_getgroups
+114	n32	setgroups			sys_setgroups
+115	n32	setresuid			sys_setresuid
+116	n32	getresuid			sys_getresuid
+117	n32	setresgid			sys_setresgid
+118	n32	getresgid			sys_getresgid
+119	n32	getpgid				sys_getpgid
+120	n32	setfsuid			sys_setfsuid
+121	n32	setfsgid			sys_setfsgid
+122	n32	getsid				sys_getsid
+123	n32	capget				sys_capget
+124	n32	capset				sys_capset
+125	n32	rt_sigpending			compat_sys_rt_sigpending
+126	n32	rt_sigtimedwait			compat_sys_rt_sigtimedwait_time32
+127	n32	rt_sigqueueinfo			compat_sys_rt_sigqueueinfo
+128	n32	rt_sigsuspend			compat_sys_rt_sigsuspend
+129	n32	sigaltstack			compat_sys_sigaltstack
+130	n32	utime				sys_utime32
+131	n32	mknod				sys_mknod
+132	n32	personality			sys_32_personality
+133	n32	ustat				compat_sys_ustat
+134	n32	statfs				compat_sys_statfs
+135	n32	fstatfs				compat_sys_fstatfs
+136	n32	sysfs				sys_sysfs
+137	n32	getpriority			sys_getpriority
+138	n32	setpriority			sys_setpriority
+139	n32	sched_setparam			sys_sched_setparam
+140	n32	sched_getparam			sys_sched_getparam
+141	n32	sched_setscheduler		sys_sched_setscheduler
+142	n32	sched_getscheduler		sys_sched_getscheduler
+143	n32	sched_get_priority_max		sys_sched_get_priority_max
+144	n32	sched_get_priority_min		sys_sched_get_priority_min
+145	n32	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+146	n32	mlock				sys_mlock
+147	n32	munlock				sys_munlock
+148	n32	mlockall			sys_mlockall
+149	n32	munlockall			sys_munlockall
+150	n32	vhangup				sys_vhangup
+151	n32	pivot_root			sys_pivot_root
+152	n32	_sysctl				compat_sys_sysctl
+153	n32	prctl				sys_prctl
+154	n32	adjtimex			sys_adjtimex_time32
+155	n32	setrlimit			compat_sys_setrlimit
+156	n32	chroot				sys_chroot
+157	n32	sync				sys_sync
+158	n32	acct				sys_acct
+159	n32	settimeofday			compat_sys_settimeofday
+160	n32	mount				compat_sys_mount
+161	n32	umount2				sys_umount
+162	n32	swapon				sys_swapon
+163	n32	swapoff				sys_swapoff
+164	n32	reboot				sys_reboot
+165	n32	sethostname			sys_sethostname
+166	n32	setdomainname			sys_setdomainname
+167	n32	create_module			sys_ni_syscall
+168	n32	init_module			sys_init_module
+169	n32	delete_module			sys_delete_module
+170	n32	get_kernel_syms			sys_ni_syscall
+171	n32	query_module			sys_ni_syscall
+172	n32	quotactl			sys_quotactl
+173	n32	nfsservctl			sys_ni_syscall
+174	n32	getpmsg				sys_ni_syscall
+175	n32	putpmsg				sys_ni_syscall
+176	n32	afs_syscall			sys_ni_syscall
+# 177 reserved for security
+177	n32	reserved177			sys_ni_syscall
+178	n32	gettid				sys_gettid
+179	n32	readahead			sys_readahead
+180	n32	setxattr			sys_setxattr
+181	n32	lsetxattr			sys_lsetxattr
+182	n32	fsetxattr			sys_fsetxattr
+183	n32	getxattr			sys_getxattr
+184	n32	lgetxattr			sys_lgetxattr
+185	n32	fgetxattr			sys_fgetxattr
+186	n32	listxattr			sys_listxattr
+187	n32	llistxattr			sys_llistxattr
+188	n32	flistxattr			sys_flistxattr
+189	n32	removexattr			sys_removexattr
+190	n32	lremovexattr			sys_lremovexattr
+191	n32	fremovexattr			sys_fremovexattr
+192	n32	tkill				sys_tkill
+193	n32	reserved193			sys_ni_syscall
+194	n32	futex				sys_futex_time32
+195	n32	sched_setaffinity		compat_sys_sched_setaffinity
+196	n32	sched_getaffinity		compat_sys_sched_getaffinity
+197	n32	cacheflush			sys_cacheflush
+198	n32	cachectl			sys_cachectl
+199	n32	sysmips				__sys_sysmips
+200	n32	io_setup			compat_sys_io_setup
+201	n32	io_destroy			sys_io_destroy
+202	n32	io_getevents			sys_io_getevents_time32
+203	n32	io_submit			compat_sys_io_submit
+204	n32	io_cancel			sys_io_cancel
+205	n32	exit_group			sys_exit_group
+206	n32	lookup_dcookie			sys_lookup_dcookie
+207	n32	epoll_create			sys_epoll_create
+208	n32	epoll_ctl			sys_epoll_ctl
+209	n32	epoll_wait			sys_epoll_wait
+210	n32	remap_file_pages		sys_remap_file_pages
+211	n32	rt_sigreturn			sysn32_rt_sigreturn
+212	n32	fcntl64				compat_sys_fcntl64
+213	n32	set_tid_address			sys_set_tid_address
+214	n32	restart_syscall			sys_restart_syscall
+215	n32	semtimedop			sys_semtimedop_time32
+216	n32	fadvise64			sys_fadvise64_64
+217	n32	statfs64			compat_sys_statfs64
+218	n32	fstatfs64			compat_sys_fstatfs64
+219	n32	sendfile64			sys_sendfile64
+220	n32	timer_create			compat_sys_timer_create
+221	n32	timer_settime			sys_timer_settime32
+222	n32	timer_gettime			sys_timer_gettime32
+223	n32	timer_getoverrun		sys_timer_getoverrun
+224	n32	timer_delete			sys_timer_delete
+225	n32	clock_settime			sys_clock_settime32
+226	n32	clock_gettime			sys_clock_gettime32
+227	n32	clock_getres			sys_clock_getres_time32
+228	n32	clock_nanosleep			sys_clock_nanosleep_time32
+229	n32	tgkill				sys_tgkill
+230	n32	utimes				sys_utimes_time32
+231	n32	mbind				compat_sys_mbind
+232	n32	get_mempolicy			compat_sys_get_mempolicy
+233	n32	set_mempolicy			compat_sys_set_mempolicy
+234	n32	mq_open				compat_sys_mq_open
+235	n32	mq_unlink			sys_mq_unlink
+236	n32	mq_timedsend			sys_mq_timedsend_time32
+237	n32	mq_timedreceive			sys_mq_timedreceive_time32
+238	n32	mq_notify			compat_sys_mq_notify
+239	n32	mq_getsetattr			compat_sys_mq_getsetattr
+240	n32	vserver				sys_ni_syscall
+241	n32	waitid				compat_sys_waitid
+# 242 was sys_setaltroot
+243	n32	add_key				sys_add_key
+244	n32	request_key			sys_request_key
+245	n32	keyctl				compat_sys_keyctl
+246	n32	set_thread_area			sys_set_thread_area
+247	n32	inotify_init			sys_inotify_init
+248	n32	inotify_add_watch		sys_inotify_add_watch
+249	n32	inotify_rm_watch		sys_inotify_rm_watch
+250	n32	migrate_pages			compat_sys_migrate_pages
+251	n32	openat				sys_openat
+252	n32	mkdirat				sys_mkdirat
+253	n32	mknodat				sys_mknodat
+254	n32	fchownat			sys_fchownat
+255	n32	futimesat			sys_futimesat_time32
+256	n32	newfstatat			sys_newfstatat
+257	n32	unlinkat			sys_unlinkat
+258	n32	renameat			sys_renameat
+259	n32	linkat				sys_linkat
+260	n32	symlinkat			sys_symlinkat
+261	n32	readlinkat			sys_readlinkat
+262	n32	fchmodat			sys_fchmodat
+263	n32	faccessat			sys_faccessat
+264	n32	pselect6			compat_sys_pselect6_time32
+265	n32	ppoll				compat_sys_ppoll_time32
+266	n32	unshare				sys_unshare
+267	n32	splice				sys_splice
+268	n32	sync_file_range			sys_sync_file_range
+269	n32	tee				sys_tee
+270	n32	vmsplice			compat_sys_vmsplice
+271	n32	move_pages			compat_sys_move_pages
+272	n32	set_robust_list			compat_sys_set_robust_list
+273	n32	get_robust_list			compat_sys_get_robust_list
+274	n32	kexec_load			compat_sys_kexec_load
+275	n32	getcpu				sys_getcpu
+276	n32	epoll_pwait			compat_sys_epoll_pwait
+277	n32	ioprio_set			sys_ioprio_set
+278	n32	ioprio_get			sys_ioprio_get
+279	n32	utimensat			sys_utimensat_time32
+280	n32	signalfd			compat_sys_signalfd
+281	n32	timerfd				sys_ni_syscall
+282	n32	eventfd				sys_eventfd
+283	n32	fallocate			sys_fallocate
+284	n32	timerfd_create			sys_timerfd_create
+285	n32	timerfd_gettime			sys_timerfd_gettime32
+286	n32	timerfd_settime			sys_timerfd_settime32
+287	n32	signalfd4			compat_sys_signalfd4
+288	n32	eventfd2			sys_eventfd2
+289	n32	epoll_create1			sys_epoll_create1
+290	n32	dup3				sys_dup3
+291	n32	pipe2				sys_pipe2
+292	n32	inotify_init1			sys_inotify_init1
+293	n32	preadv				compat_sys_preadv
+294	n32	pwritev				compat_sys_pwritev
+295	n32	rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+296	n32	perf_event_open			sys_perf_event_open
+297	n32	accept4				sys_accept4
+298	n32	recvmmsg			compat_sys_recvmmsg_time32
+299	n32	getdents64			sys_getdents64
+300	n32	fanotify_init			sys_fanotify_init
+301	n32	fanotify_mark			sys_fanotify_mark
+302	n32	prlimit64			sys_prlimit64
+303	n32	name_to_handle_at		sys_name_to_handle_at
+304	n32	open_by_handle_at		sys_open_by_handle_at
+305	n32	clock_adjtime			sys_clock_adjtime32
+306	n32	syncfs				sys_syncfs
+307	n32	sendmmsg			compat_sys_sendmmsg
+308	n32	setns				sys_setns
+309	n32	process_vm_readv		compat_sys_process_vm_readv
+310	n32	process_vm_writev		compat_sys_process_vm_writev
+311	n32	kcmp				sys_kcmp
+312	n32	finit_module			sys_finit_module
+313	n32	sched_setattr			sys_sched_setattr
+314	n32	sched_getattr			sys_sched_getattr
+315	n32	renameat2			sys_renameat2
+316	n32	seccomp				sys_seccomp
+317	n32	getrandom			sys_getrandom
+318	n32	memfd_create			sys_memfd_create
+319	n32	bpf				sys_bpf
+320	n32	execveat			compat_sys_execveat
+321	n32	userfaultfd			sys_userfaultfd
+322	n32	membarrier			sys_membarrier
+323	n32	mlock2				sys_mlock2
+324	n32	copy_file_range			sys_copy_file_range
+325	n32	preadv2				compat_sys_preadv2
+326	n32	pwritev2			compat_sys_pwritev2
+327	n32	pkey_mprotect			sys_pkey_mprotect
+328	n32	pkey_alloc			sys_pkey_alloc
+329	n32	pkey_free			sys_pkey_free
+330	n32	statx				sys_statx
+331	n32	rseq				sys_rseq
+332	n32	io_pgetevents			compat_sys_io_pgetevents
+# 333 through 402 are unassigned to sync up with generic numbers
+403	n32	clock_gettime64			sys_clock_gettime
+404	n32	clock_settime64			sys_clock_settime
+405	n32	clock_adjtime64			sys_clock_adjtime
+406	n32	clock_getres_time64		sys_clock_getres
+407	n32	clock_nanosleep_time64		sys_clock_nanosleep
+408	n32	timer_gettime64			sys_timer_gettime
+409	n32	timer_settime64			sys_timer_settime
+410	n32	timerfd_gettime64		sys_timerfd_gettime
+411	n32	timerfd_settime64		sys_timerfd_settime
+412	n32	utimensat_time64		sys_utimensat
+413	n32	pselect6_time64			compat_sys_pselect6_time64
+414	n32	ppoll_time64			compat_sys_ppoll_time64
+416	n32	io_pgetevents_time64		sys_io_pgetevents
+417	n32	recvmmsg_time64			compat_sys_recvmmsg_time64
+418	n32	mq_timedsend_time64		sys_mq_timedsend
+419	n32	mq_timedreceive_time64		sys_mq_timedreceive
+420	n32	semtimedop_time64		sys_semtimedop
+421	n32	rt_sigtimedwait_time64		compat_sys_rt_sigtimedwait_time64
+422	n32	futex_time64			sys_futex
+423	n32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	n32	pidfd_send_signal		sys_pidfd_send_signal
+425	n32	io_uring_setup			sys_io_uring_setup
+426	n32	io_uring_enter			sys_io_uring_enter
+427	n32	io_uring_register		sys_io_uring_register
+428	n32	open_tree			sys_open_tree
+429	n32	move_mount			sys_move_mount
+430	n32	fsopen				sys_fsopen
+431	n32	fsconfig			sys_fsconfig
+432	n32	fsmount				sys_fsmount
+433	n32	fspick				sys_fspick
+434	n32	pidfd_open			sys_pidfd_open
+435	n32	clone3				__sys_clone3
diff --git a/linux-user/mips64/syscall_n64.tbl b/linux-user/mips64/syscall_n64.tbl
new file mode 100644
index 000000000000..13cd66581f3b
--- /dev/null
+++ b/linux-user/mips64/syscall_n64.tbl
@@ -0,0 +1,352 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for mips
+#
+# The format is:
+# <number> <abi> <name> <entry point>
+#
+# The <abi> is always "n64" for this file.
+#
+0	n64	read				sys_read
+1	n64	write				sys_write
+2	n64	open				sys_open
+3	n64	close				sys_close
+4	n64	stat				sys_newstat
+5	n64	fstat				sys_newfstat
+6	n64	lstat				sys_newlstat
+7	n64	poll				sys_poll
+8	n64	lseek				sys_lseek
+9	n64	mmap				sys_mips_mmap
+10	n64	mprotect			sys_mprotect
+11	n64	munmap				sys_munmap
+12	n64	brk				sys_brk
+13	n64	rt_sigaction			sys_rt_sigaction
+14	n64	rt_sigprocmask			sys_rt_sigprocmask
+15	n64	ioctl				sys_ioctl
+16	n64	pread64				sys_pread64
+17	n64	pwrite64			sys_pwrite64
+18	n64	readv				sys_readv
+19	n64	writev				sys_writev
+20	n64	access				sys_access
+21	n64	pipe				sysm_pipe
+22	n64	_newselect			sys_select
+23	n64	sched_yield			sys_sched_yield
+24	n64	mremap				sys_mremap
+25	n64	msync				sys_msync
+26	n64	mincore				sys_mincore
+27	n64	madvise				sys_madvise
+28	n64	shmget				sys_shmget
+29	n64	shmat				sys_shmat
+30	n64	shmctl				sys_old_shmctl
+31	n64	dup				sys_dup
+32	n64	dup2				sys_dup2
+33	n64	pause				sys_pause
+34	n64	nanosleep			sys_nanosleep
+35	n64	getitimer			sys_getitimer
+36	n64	setitimer			sys_setitimer
+37	n64	alarm				sys_alarm
+38	n64	getpid				sys_getpid
+39	n64	sendfile			sys_sendfile64
+40	n64	socket				sys_socket
+41	n64	connect				sys_connect
+42	n64	accept				sys_accept
+43	n64	sendto				sys_sendto
+44	n64	recvfrom			sys_recvfrom
+45	n64	sendmsg				sys_sendmsg
+46	n64	recvmsg				sys_recvmsg
+47	n64	shutdown			sys_shutdown
+48	n64	bind				sys_bind
+49	n64	listen				sys_listen
+50	n64	getsockname			sys_getsockname
+51	n64	getpeername			sys_getpeername
+52	n64	socketpair			sys_socketpair
+53	n64	setsockopt			sys_setsockopt
+54	n64	getsockopt			sys_getsockopt
+55	n64	clone				__sys_clone
+56	n64	fork				__sys_fork
+57	n64	execve				sys_execve
+58	n64	exit				sys_exit
+59	n64	wait4				sys_wait4
+60	n64	kill				sys_kill
+61	n64	uname				sys_newuname
+62	n64	semget				sys_semget
+63	n64	semop				sys_semop
+64	n64	semctl				sys_old_semctl
+65	n64	shmdt				sys_shmdt
+66	n64	msgget				sys_msgget
+67	n64	msgsnd				sys_msgsnd
+68	n64	msgrcv				sys_msgrcv
+69	n64	msgctl				sys_old_msgctl
+70	n64	fcntl				sys_fcntl
+71	n64	flock				sys_flock
+72	n64	fsync				sys_fsync
+73	n64	fdatasync			sys_fdatasync
+74	n64	truncate			sys_truncate
+75	n64	ftruncate			sys_ftruncate
+76	n64	getdents			sys_getdents
+77	n64	getcwd				sys_getcwd
+78	n64	chdir				sys_chdir
+79	n64	fchdir				sys_fchdir
+80	n64	rename				sys_rename
+81	n64	mkdir				sys_mkdir
+82	n64	rmdir				sys_rmdir
+83	n64	creat				sys_creat
+84	n64	link				sys_link
+85	n64	unlink				sys_unlink
+86	n64	symlink				sys_symlink
+87	n64	readlink			sys_readlink
+88	n64	chmod				sys_chmod
+89	n64	fchmod				sys_fchmod
+90	n64	chown				sys_chown
+91	n64	fchown				sys_fchown
+92	n64	lchown				sys_lchown
+93	n64	umask				sys_umask
+94	n64	gettimeofday			sys_gettimeofday
+95	n64	getrlimit			sys_getrlimit
+96	n64	getrusage			sys_getrusage
+97	n64	sysinfo				sys_sysinfo
+98	n64	times				sys_times
+99	n64	ptrace				sys_ptrace
+100	n64	getuid				sys_getuid
+101	n64	syslog				sys_syslog
+102	n64	getgid				sys_getgid
+103	n64	setuid				sys_setuid
+104	n64	setgid				sys_setgid
+105	n64	geteuid				sys_geteuid
+106	n64	getegid				sys_getegid
+107	n64	setpgid				sys_setpgid
+108	n64	getppid				sys_getppid
+109	n64	getpgrp				sys_getpgrp
+110	n64	setsid				sys_setsid
+111	n64	setreuid			sys_setreuid
+112	n64	setregid			sys_setregid
+113	n64	getgroups			sys_getgroups
+114	n64	setgroups			sys_setgroups
+115	n64	setresuid			sys_setresuid
+116	n64	getresuid			sys_getresuid
+117	n64	setresgid			sys_setresgid
+118	n64	getresgid			sys_getresgid
+119	n64	getpgid				sys_getpgid
+120	n64	setfsuid			sys_setfsuid
+121	n64	setfsgid			sys_setfsgid
+122	n64	getsid				sys_getsid
+123	n64	capget				sys_capget
+124	n64	capset				sys_capset
+125	n64	rt_sigpending			sys_rt_sigpending
+126	n64	rt_sigtimedwait			sys_rt_sigtimedwait
+127	n64	rt_sigqueueinfo			sys_rt_sigqueueinfo
+128	n64	rt_sigsuspend			sys_rt_sigsuspend
+129	n64	sigaltstack			sys_sigaltstack
+130	n64	utime				sys_utime
+131	n64	mknod				sys_mknod
+132	n64	personality			sys_personality
+133	n64	ustat				sys_ustat
+134	n64	statfs				sys_statfs
+135	n64	fstatfs				sys_fstatfs
+136	n64	sysfs				sys_sysfs
+137	n64	getpriority			sys_getpriority
+138	n64	setpriority			sys_setpriority
+139	n64	sched_setparam			sys_sched_setparam
+140	n64	sched_getparam			sys_sched_getparam
+141	n64	sched_setscheduler		sys_sched_setscheduler
+142	n64	sched_getscheduler		sys_sched_getscheduler
+143	n64	sched_get_priority_max		sys_sched_get_priority_max
+144	n64	sched_get_priority_min		sys_sched_get_priority_min
+145	n64	sched_rr_get_interval		sys_sched_rr_get_interval
+146	n64	mlock				sys_mlock
+147	n64	munlock				sys_munlock
+148	n64	mlockall			sys_mlockall
+149	n64	munlockall			sys_munlockall
+150	n64	vhangup				sys_vhangup
+151	n64	pivot_root			sys_pivot_root
+152	n64	_sysctl				sys_sysctl
+153	n64	prctl				sys_prctl
+154	n64	adjtimex			sys_adjtimex
+155	n64	setrlimit			sys_setrlimit
+156	n64	chroot				sys_chroot
+157	n64	sync				sys_sync
+158	n64	acct				sys_acct
+159	n64	settimeofday			sys_settimeofday
+160	n64	mount				sys_mount
+161	n64	umount2				sys_umount
+162	n64	swapon				sys_swapon
+163	n64	swapoff				sys_swapoff
+164	n64	reboot				sys_reboot
+165	n64	sethostname			sys_sethostname
+166	n64	setdomainname			sys_setdomainname
+167	n64	create_module			sys_ni_syscall
+168	n64	init_module			sys_init_module
+169	n64	delete_module			sys_delete_module
+170	n64	get_kernel_syms			sys_ni_syscall
+171	n64	query_module			sys_ni_syscall
+172	n64	quotactl			sys_quotactl
+173	n64	nfsservctl			sys_ni_syscall
+174	n64	getpmsg				sys_ni_syscall
+175	n64	putpmsg				sys_ni_syscall
+176	n64	afs_syscall			sys_ni_syscall
+# 177 reserved for security
+177	n64	reserved177			sys_ni_syscall
+178	n64	gettid				sys_gettid
+179	n64	readahead			sys_readahead
+180	n64	setxattr			sys_setxattr
+181	n64	lsetxattr			sys_lsetxattr
+182	n64	fsetxattr			sys_fsetxattr
+183	n64	getxattr			sys_getxattr
+184	n64	lgetxattr			sys_lgetxattr
+185	n64	fgetxattr			sys_fgetxattr
+186	n64	listxattr			sys_listxattr
+187	n64	llistxattr			sys_llistxattr
+188	n64	flistxattr			sys_flistxattr
+189	n64	removexattr			sys_removexattr
+190	n64	lremovexattr			sys_lremovexattr
+191	n64	fremovexattr			sys_fremovexattr
+192	n64	tkill				sys_tkill
+193	n64	reserved193			sys_ni_syscall
+194	n64	futex				sys_futex
+195	n64	sched_setaffinity		sys_sched_setaffinity
+196	n64	sched_getaffinity		sys_sched_getaffinity
+197	n64	cacheflush			sys_cacheflush
+198	n64	cachectl			sys_cachectl
+199	n64	sysmips				__sys_sysmips
+200	n64	io_setup			sys_io_setup
+201	n64	io_destroy			sys_io_destroy
+202	n64	io_getevents			sys_io_getevents
+203	n64	io_submit			sys_io_submit
+204	n64	io_cancel			sys_io_cancel
+205	n64	exit_group			sys_exit_group
+206	n64	lookup_dcookie			sys_lookup_dcookie
+207	n64	epoll_create			sys_epoll_create
+208	n64	epoll_ctl			sys_epoll_ctl
+209	n64	epoll_wait			sys_epoll_wait
+210	n64	remap_file_pages		sys_remap_file_pages
+211	n64	rt_sigreturn			sys_rt_sigreturn
+212	n64	set_tid_address			sys_set_tid_address
+213	n64	restart_syscall			sys_restart_syscall
+214	n64	semtimedop			sys_semtimedop
+215	n64	fadvise64			sys_fadvise64_64
+216	n64	timer_create			sys_timer_create
+217	n64	timer_settime			sys_timer_settime
+218	n64	timer_gettime			sys_timer_gettime
+219	n64	timer_getoverrun		sys_timer_getoverrun
+220	n64	timer_delete			sys_timer_delete
+221	n64	clock_settime			sys_clock_settime
+222	n64	clock_gettime			sys_clock_gettime
+223	n64	clock_getres			sys_clock_getres
+224	n64	clock_nanosleep			sys_clock_nanosleep
+225	n64	tgkill				sys_tgkill
+226	n64	utimes				sys_utimes
+227	n64	mbind				sys_mbind
+228	n64	get_mempolicy			sys_get_mempolicy
+229	n64	set_mempolicy			sys_set_mempolicy
+230	n64	mq_open				sys_mq_open
+231	n64	mq_unlink			sys_mq_unlink
+232	n64	mq_timedsend			sys_mq_timedsend
+233	n64	mq_timedreceive			sys_mq_timedreceive
+234	n64	mq_notify			sys_mq_notify
+235	n64	mq_getsetattr			sys_mq_getsetattr
+236	n64	vserver				sys_ni_syscall
+237	n64	waitid				sys_waitid
+# 238 was sys_setaltroot
+239	n64	add_key				sys_add_key
+240	n64	request_key			sys_request_key
+241	n64	keyctl				sys_keyctl
+242	n64	set_thread_area			sys_set_thread_area
+243	n64	inotify_init			sys_inotify_init
+244	n64	inotify_add_watch		sys_inotify_add_watch
+245	n64	inotify_rm_watch		sys_inotify_rm_watch
+246	n64	migrate_pages			sys_migrate_pages
+247	n64	openat				sys_openat
+248	n64	mkdirat				sys_mkdirat
+249	n64	mknodat				sys_mknodat
+250	n64	fchownat			sys_fchownat
+251	n64	futimesat			sys_futimesat
+252	n64	newfstatat			sys_newfstatat
+253	n64	unlinkat			sys_unlinkat
+254	n64	renameat			sys_renameat
+255	n64	linkat				sys_linkat
+256	n64	symlinkat			sys_symlinkat
+257	n64	readlinkat			sys_readlinkat
+258	n64	fchmodat			sys_fchmodat
+259	n64	faccessat			sys_faccessat
+260	n64	pselect6			sys_pselect6
+261	n64	ppoll				sys_ppoll
+262	n64	unshare				sys_unshare
+263	n64	splice				sys_splice
+264	n64	sync_file_range			sys_sync_file_range
+265	n64	tee				sys_tee
+266	n64	vmsplice			sys_vmsplice
+267	n64	move_pages			sys_move_pages
+268	n64	set_robust_list			sys_set_robust_list
+269	n64	get_robust_list			sys_get_robust_list
+270	n64	kexec_load			sys_kexec_load
+271	n64	getcpu				sys_getcpu
+272	n64	epoll_pwait			sys_epoll_pwait
+273	n64	ioprio_set			sys_ioprio_set
+274	n64	ioprio_get			sys_ioprio_get
+275	n64	utimensat			sys_utimensat
+276	n64	signalfd			sys_signalfd
+277	n64	timerfd				sys_ni_syscall
+278	n64	eventfd				sys_eventfd
+279	n64	fallocate			sys_fallocate
+280	n64	timerfd_create			sys_timerfd_create
+281	n64	timerfd_gettime			sys_timerfd_gettime
+282	n64	timerfd_settime			sys_timerfd_settime
+283	n64	signalfd4			sys_signalfd4
+284	n64	eventfd2			sys_eventfd2
+285	n64	epoll_create1			sys_epoll_create1
+286	n64	dup3				sys_dup3
+287	n64	pipe2				sys_pipe2
+288	n64	inotify_init1			sys_inotify_init1
+289	n64	preadv				sys_preadv
+290	n64	pwritev				sys_pwritev
+291	n64	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
+292	n64	perf_event_open			sys_perf_event_open
+293	n64	accept4				sys_accept4
+294	n64	recvmmsg			sys_recvmmsg
+295	n64	fanotify_init			sys_fanotify_init
+296	n64	fanotify_mark			sys_fanotify_mark
+297	n64	prlimit64			sys_prlimit64
+298	n64	name_to_handle_at		sys_name_to_handle_at
+299	n64	open_by_handle_at		sys_open_by_handle_at
+300	n64	clock_adjtime			sys_clock_adjtime
+301	n64	syncfs				sys_syncfs
+302	n64	sendmmsg			sys_sendmmsg
+303	n64	setns				sys_setns
+304	n64	process_vm_readv		sys_process_vm_readv
+305	n64	process_vm_writev		sys_process_vm_writev
+306	n64	kcmp				sys_kcmp
+307	n64	finit_module			sys_finit_module
+308	n64	getdents64			sys_getdents64
+309	n64	sched_setattr			sys_sched_setattr
+310	n64	sched_getattr			sys_sched_getattr
+311	n64	renameat2			sys_renameat2
+312	n64	seccomp				sys_seccomp
+313	n64	getrandom			sys_getrandom
+314	n64	memfd_create			sys_memfd_create
+315	n64	bpf				sys_bpf
+316	n64	execveat			sys_execveat
+317	n64	userfaultfd			sys_userfaultfd
+318	n64	membarrier			sys_membarrier
+319	n64	mlock2				sys_mlock2
+320	n64	copy_file_range			sys_copy_file_range
+321	n64	preadv2				sys_preadv2
+322	n64	pwritev2			sys_pwritev2
+323	n64	pkey_mprotect			sys_pkey_mprotect
+324	n64	pkey_alloc			sys_pkey_alloc
+325	n64	pkey_free			sys_pkey_free
+326	n64	statx				sys_statx
+327	n64	rseq				sys_rseq
+328	n64	io_pgetevents			sys_io_pgetevents
+# 329 through 423 are reserved to sync up with other architectures
+424	n64	pidfd_send_signal		sys_pidfd_send_signal
+425	n64	io_uring_setup			sys_io_uring_setup
+426	n64	io_uring_enter			sys_io_uring_enter
+427	n64	io_uring_register		sys_io_uring_register
+428	n64	open_tree			sys_open_tree
+429	n64	move_mount			sys_move_mount
+430	n64	fsopen				sys_fsopen
+431	n64	fsconfig			sys_fsconfig
+432	n64	fsmount				sys_fsmount
+433	n64	fspick				sys_fspick
+434	n64	pidfd_open			sys_pidfd_open
+435	n64	clone3				__sys_clone3
diff --git a/linux-user/mips64/syscall_nr.h b/linux-user/mips64/syscall_nr.h
deleted file mode 100644
index 6e23e9fcdb0c..000000000000
--- a/linux-user/mips64/syscall_nr.h
+++ /dev/null
@@ -1,725 +0,0 @@
-#ifndef LINUX_USER_MIPS64_SYSCALL_NR_H
-#define LINUX_USER_MIPS64_SYSCALL_NR_H
-
-#ifdef TARGET_ABI32
-/*
- * Linux N32 syscalls are in the range from 6000 to 6999.
- */
-#define TARGET_NR_Linux                 6000
-#define TARGET_NR_read                  (TARGET_NR_Linux +   0)
-#define TARGET_NR_write                 (TARGET_NR_Linux +   1)
-#define TARGET_NR_open                  (TARGET_NR_Linux +   2)
-#define TARGET_NR_close                 (TARGET_NR_Linux +   3)
-#define TARGET_NR_stat                  (TARGET_NR_Linux +   4)
-#define TARGET_NR_fstat                 (TARGET_NR_Linux +   5)
-#define TARGET_NR_lstat                 (TARGET_NR_Linux +   6)
-#define TARGET_NR_poll                  (TARGET_NR_Linux +   7)
-#define TARGET_NR_lseek                 (TARGET_NR_Linux +   8)
-#define TARGET_NR_mmap                  (TARGET_NR_Linux +   9)
-#define TARGET_NR_mprotect              (TARGET_NR_Linux +  10)
-#define TARGET_NR_munmap                (TARGET_NR_Linux +  11)
-#define TARGET_NR_brk                   (TARGET_NR_Linux +  12)
-#define TARGET_NR_rt_sigaction          (TARGET_NR_Linux +  13)
-#define TARGET_NR_rt_sigprocmask        (TARGET_NR_Linux +  14)
-#define TARGET_NR_ioctl                 (TARGET_NR_Linux +  15)
-#define TARGET_NR_pread64               (TARGET_NR_Linux +  16)
-#define TARGET_NR_pwrite64              (TARGET_NR_Linux +  17)
-#define TARGET_NR_readv                 (TARGET_NR_Linux +  18)
-#define TARGET_NR_writev                (TARGET_NR_Linux +  19)
-#define TARGET_NR_access                (TARGET_NR_Linux +  20)
-#define TARGET_NR_pipe                  (TARGET_NR_Linux +  21)
-#define TARGET_NR__newselect            (TARGET_NR_Linux +  22)
-#define TARGET_NR_sched_yield           (TARGET_NR_Linux +  23)
-#define TARGET_NR_mremap                (TARGET_NR_Linux +  24)
-#define TARGET_NR_msync                 (TARGET_NR_Linux +  25)
-#define TARGET_NR_mincore               (TARGET_NR_Linux +  26)
-#define TARGET_NR_madvise               (TARGET_NR_Linux +  27)
-#define TARGET_NR_shmget                (TARGET_NR_Linux +  28)
-#define TARGET_NR_shmat                 (TARGET_NR_Linux +  29)
-#define TARGET_NR_shmctl                (TARGET_NR_Linux +  30)
-#define TARGET_NR_dup                   (TARGET_NR_Linux +  31)
-#define TARGET_NR_dup2                  (TARGET_NR_Linux +  32)
-#define TARGET_NR_pause                 (TARGET_NR_Linux +  33)
-#define TARGET_NR_nanosleep             (TARGET_NR_Linux +  34)
-#define TARGET_NR_getitimer             (TARGET_NR_Linux +  35)
-#define TARGET_NR_setitimer             (TARGET_NR_Linux +  36)
-#define TARGET_NR_alarm                 (TARGET_NR_Linux +  37)
-#define TARGET_NR_getpid                (TARGET_NR_Linux +  38)
-#define TARGET_NR_sendfile              (TARGET_NR_Linux +  39)
-#define TARGET_NR_socket                (TARGET_NR_Linux +  40)
-#define TARGET_NR_connect               (TARGET_NR_Linux +  41)
-#define TARGET_NR_accept                (TARGET_NR_Linux +  42)
-#define TARGET_NR_sendto                (TARGET_NR_Linux +  43)
-#define TARGET_NR_recvfrom              (TARGET_NR_Linux +  44)
-#define TARGET_NR_sendmsg               (TARGET_NR_Linux +  45)
-#define TARGET_NR_recvmsg               (TARGET_NR_Linux +  46)
-#define TARGET_NR_shutdown              (TARGET_NR_Linux +  47)
-#define TARGET_NR_bind                  (TARGET_NR_Linux +  48)
-#define TARGET_NR_listen                (TARGET_NR_Linux +  49)
-#define TARGET_NR_getsockname           (TARGET_NR_Linux +  50)
-#define TARGET_NR_getpeername           (TARGET_NR_Linux +  51)
-#define TARGET_NR_socketpair            (TARGET_NR_Linux +  52)
-#define TARGET_NR_setsockopt            (TARGET_NR_Linux +  53)
-#define TARGET_NR_getsockopt            (TARGET_NR_Linux +  54)
-#define TARGET_NR_clone                 (TARGET_NR_Linux +  55)
-#define TARGET_NR_fork                  (TARGET_NR_Linux +  56)
-#define TARGET_NR_execve                (TARGET_NR_Linux +  57)
-#define TARGET_NR_exit                  (TARGET_NR_Linux +  58)
-#define TARGET_NR_wait4                 (TARGET_NR_Linux +  59)
-#define TARGET_NR_kill                  (TARGET_NR_Linux +  60)
-#define TARGET_NR_uname                 (TARGET_NR_Linux +  61)
-#define TARGET_NR_semget                (TARGET_NR_Linux +  62)
-#define TARGET_NR_semop                 (TARGET_NR_Linux +  63)
-#define TARGET_NR_semctl                (TARGET_NR_Linux +  64)
-#define TARGET_NR_shmdt                 (TARGET_NR_Linux +  65)
-#define TARGET_NR_msgget                (TARGET_NR_Linux +  66)
-#define TARGET_NR_msgsnd                (TARGET_NR_Linux +  67)
-#define TARGET_NR_msgrcv                (TARGET_NR_Linux +  68)
-#define TARGET_NR_msgctl                (TARGET_NR_Linux +  69)
-#define TARGET_NR_fcntl                 (TARGET_NR_Linux +  70)
-#define TARGET_NR_flock                 (TARGET_NR_Linux +  71)
-#define TARGET_NR_fsync                 (TARGET_NR_Linux +  72)
-#define TARGET_NR_fdatasync             (TARGET_NR_Linux +  73)
-#define TARGET_NR_truncate              (TARGET_NR_Linux +  74)
-#define TARGET_NR_ftruncate             (TARGET_NR_Linux +  75)
-#define TARGET_NR_getdents              (TARGET_NR_Linux +  76)
-#define TARGET_NR_getcwd                (TARGET_NR_Linux +  77)
-#define TARGET_NR_chdir                 (TARGET_NR_Linux +  78)
-#define TARGET_NR_fchdir                (TARGET_NR_Linux +  79)
-#define TARGET_NR_rename                (TARGET_NR_Linux +  80)
-#define TARGET_NR_mkdir                 (TARGET_NR_Linux +  81)
-#define TARGET_NR_rmdir                 (TARGET_NR_Linux +  82)
-#define TARGET_NR_creat                 (TARGET_NR_Linux +  83)
-#define TARGET_NR_link                  (TARGET_NR_Linux +  84)
-#define TARGET_NR_unlink                (TARGET_NR_Linux +  85)
-#define TARGET_NR_symlink               (TARGET_NR_Linux +  86)
-#define TARGET_NR_readlink              (TARGET_NR_Linux +  87)
-#define TARGET_NR_chmod                 (TARGET_NR_Linux +  88)
-#define TARGET_NR_fchmod                (TARGET_NR_Linux +  89)
-#define TARGET_NR_chown                 (TARGET_NR_Linux +  90)
-#define TARGET_NR_fchown                (TARGET_NR_Linux +  91)
-#define TARGET_NR_lchown                (TARGET_NR_Linux +  92)
-#define TARGET_NR_umask                 (TARGET_NR_Linux +  93)
-#define TARGET_NR_gettimeofday          (TARGET_NR_Linux +  94)
-#define TARGET_NR_getrlimit             (TARGET_NR_Linux +  95)
-#define TARGET_NR_getrusage             (TARGET_NR_Linux +  96)
-#define TARGET_NR_sysinfo               (TARGET_NR_Linux +  97)
-#define TARGET_NR_times                 (TARGET_NR_Linux +  98)
-#define TARGET_NR_ptrace                (TARGET_NR_Linux +  99)
-#define TARGET_NR_getuid                (TARGET_NR_Linux + 100)
-#define TARGET_NR_syslog                (TARGET_NR_Linux + 101)
-#define TARGET_NR_getgid                (TARGET_NR_Linux + 102)
-#define TARGET_NR_setuid                (TARGET_NR_Linux + 103)
-#define TARGET_NR_setgid                (TARGET_NR_Linux + 104)
-#define TARGET_NR_geteuid               (TARGET_NR_Linux + 105)
-#define TARGET_NR_getegid               (TARGET_NR_Linux + 106)
-#define TARGET_NR_setpgid               (TARGET_NR_Linux + 107)
-#define TARGET_NR_getppid               (TARGET_NR_Linux + 108)
-#define TARGET_NR_getpgrp               (TARGET_NR_Linux + 109)
-#define TARGET_NR_setsid                (TARGET_NR_Linux + 110)
-#define TARGET_NR_setreuid              (TARGET_NR_Linux + 111)
-#define TARGET_NR_setregid              (TARGET_NR_Linux + 112)
-#define TARGET_NR_getgroups             (TARGET_NR_Linux + 113)
-#define TARGET_NR_setgroups             (TARGET_NR_Linux + 114)
-#define TARGET_NR_setresuid             (TARGET_NR_Linux + 115)
-#define TARGET_NR_getresuid             (TARGET_NR_Linux + 116)
-#define TARGET_NR_setresgid             (TARGET_NR_Linux + 117)
-#define TARGET_NR_getresgid             (TARGET_NR_Linux + 118)
-#define TARGET_NR_getpgid               (TARGET_NR_Linux + 119)
-#define TARGET_NR_setfsuid              (TARGET_NR_Linux + 120)
-#define TARGET_NR_setfsgid              (TARGET_NR_Linux + 121)
-#define TARGET_NR_getsid                (TARGET_NR_Linux + 122)
-#define TARGET_NR_capget                (TARGET_NR_Linux + 123)
-#define TARGET_NR_capset                (TARGET_NR_Linux + 124)
-#define TARGET_NR_rt_sigpending         (TARGET_NR_Linux + 125)
-#define TARGET_NR_rt_sigtimedwait       (TARGET_NR_Linux + 126)
-#define TARGET_NR_rt_sigqueueinfo       (TARGET_NR_Linux + 127)
-#define TARGET_NR_rt_sigsuspend         (TARGET_NR_Linux + 128)
-#define TARGET_NR_sigaltstack           (TARGET_NR_Linux + 129)
-#define TARGET_NR_utime                 (TARGET_NR_Linux + 130)
-#define TARGET_NR_mknod                 (TARGET_NR_Linux + 131)
-#define TARGET_NR_personality           (TARGET_NR_Linux + 132)
-#define TARGET_NR_ustat                 (TARGET_NR_Linux + 133)
-#define TARGET_NR_statfs                (TARGET_NR_Linux + 134)
-#define TARGET_NR_fstatfs               (TARGET_NR_Linux + 135)
-#define TARGET_NR_sysfs                 (TARGET_NR_Linux + 136)
-#define TARGET_NR_getpriority           (TARGET_NR_Linux + 137)
-#define TARGET_NR_setpriority           (TARGET_NR_Linux + 138)
-#define TARGET_NR_sched_setparam        (TARGET_NR_Linux + 139)
-#define TARGET_NR_sched_getparam        (TARGET_NR_Linux + 140)
-#define TARGET_NR_sched_setscheduler    (TARGET_NR_Linux + 141)
-#define TARGET_NR_sched_getscheduler    (TARGET_NR_Linux + 142)
-#define TARGET_NR_sched_get_priority_max        (TARGET_NR_Linux + 143)
-#define TARGET_NR_sched_get_priority_min        (TARGET_NR_Linux + 144)
-#define TARGET_NR_sched_rr_get_interval (TARGET_NR_Linux + 145)
-#define TARGET_NR_mlock                 (TARGET_NR_Linux + 146)
-#define TARGET_NR_munlock               (TARGET_NR_Linux + 147)
-#define TARGET_NR_mlockall              (TARGET_NR_Linux + 148)
-#define TARGET_NR_munlockall            (TARGET_NR_Linux + 149)
-#define TARGET_NR_vhangup               (TARGET_NR_Linux + 150)
-#define TARGET_NR_pivot_root            (TARGET_NR_Linux + 151)
-#define TARGET_NR__sysctl               (TARGET_NR_Linux + 152)
-#define TARGET_NR_prctl                 (TARGET_NR_Linux + 153)
-#define TARGET_NR_adjtimex              (TARGET_NR_Linux + 154)
-#define TARGET_NR_setrlimit             (TARGET_NR_Linux + 155)
-#define TARGET_NR_chroot                (TARGET_NR_Linux + 156)
-#define TARGET_NR_sync                  (TARGET_NR_Linux + 157)
-#define TARGET_NR_acct                  (TARGET_NR_Linux + 158)
-#define TARGET_NR_settimeofday          (TARGET_NR_Linux + 159)
-#define TARGET_NR_mount                 (TARGET_NR_Linux + 160)
-#define TARGET_NR_umount2               (TARGET_NR_Linux + 161)
-#define TARGET_NR_swapon                (TARGET_NR_Linux + 162)
-#define TARGET_NR_swapoff               (TARGET_NR_Linux + 163)
-#define TARGET_NR_reboot                (TARGET_NR_Linux + 164)
-#define TARGET_NR_sethostname           (TARGET_NR_Linux + 165)
-#define TARGET_NR_setdomainname         (TARGET_NR_Linux + 166)
-#define TARGET_NR_create_module         (TARGET_NR_Linux + 167)
-#define TARGET_NR_init_module           (TARGET_NR_Linux + 168)
-#define TARGET_NR_delete_module         (TARGET_NR_Linux + 169)
-#define TARGET_NR_get_kernel_syms       (TARGET_NR_Linux + 170)
-#define TARGET_NR_query_module          (TARGET_NR_Linux + 171)
-#define TARGET_NR_quotactl              (TARGET_NR_Linux + 172)
-#define TARGET_NR_nfsservctl            (TARGET_NR_Linux + 173)
-#define TARGET_NR_getpmsg               (TARGET_NR_Linux + 174)
-#define TARGET_NR_putpmsg               (TARGET_NR_Linux + 175)
-#define TARGET_NR_afs_syscall           (TARGET_NR_Linux + 176)
-#define TARGET_NR_reserved177           (TARGET_NR_Linux + 177)
-#define TARGET_NR_gettid                (TARGET_NR_Linux + 178)
-#define TARGET_NR_readahead             (TARGET_NR_Linux + 179)
-#define TARGET_NR_setxattr              (TARGET_NR_Linux + 180)
-#define TARGET_NR_lsetxattr             (TARGET_NR_Linux + 181)
-#define TARGET_NR_fsetxattr             (TARGET_NR_Linux + 182)
-#define TARGET_NR_getxattr              (TARGET_NR_Linux + 183)
-#define TARGET_NR_lgetxattr             (TARGET_NR_Linux + 184)
-#define TARGET_NR_fgetxattr             (TARGET_NR_Linux + 185)
-#define TARGET_NR_listxattr             (TARGET_NR_Linux + 186)
-#define TARGET_NR_llistxattr            (TARGET_NR_Linux + 187)
-#define TARGET_NR_flistxattr            (TARGET_NR_Linux + 188)
-#define TARGET_NR_removexattr           (TARGET_NR_Linux + 189)
-#define TARGET_NR_lremovexattr          (TARGET_NR_Linux + 190)
-#define TARGET_NR_fremovexattr          (TARGET_NR_Linux + 191)
-#define TARGET_NR_tkill                 (TARGET_NR_Linux + 192)
-#define TARGET_NR_reserved193           (TARGET_NR_Linux + 193)
-#define TARGET_NR_futex                 (TARGET_NR_Linux + 194)
-#define TARGET_NR_sched_setaffinity     (TARGET_NR_Linux + 195)
-#define TARGET_NR_sched_getaffinity     (TARGET_NR_Linux + 196)
-#define TARGET_NR_cacheflush            (TARGET_NR_Linux + 197)
-#define TARGET_NR_cachectl              (TARGET_NR_Linux + 198)
-#define TARGET_NR_sysmips               (TARGET_NR_Linux + 199)
-#define TARGET_NR_io_setup              (TARGET_NR_Linux + 200)
-#define TARGET_NR_io_destroy            (TARGET_NR_Linux + 201)
-#define TARGET_NR_io_getevents          (TARGET_NR_Linux + 202)
-#define TARGET_NR_io_submit             (TARGET_NR_Linux + 203)
-#define TARGET_NR_io_cancel             (TARGET_NR_Linux + 204)
-#define TARGET_NR_exit_group            (TARGET_NR_Linux + 205)
-#define TARGET_NR_lookup_dcookie        (TARGET_NR_Linux + 206)
-#define TARGET_NR_epoll_create          (TARGET_NR_Linux + 207)
-#define TARGET_NR_epoll_ctl             (TARGET_NR_Linux + 208)
-#define TARGET_NR_epoll_wait            (TARGET_NR_Linux + 209)
-#define TARGET_NR_remap_file_pages      (TARGET_NR_Linux + 210)
-#define TARGET_NR_rt_sigreturn          (TARGET_NR_Linux + 211)
-#define TARGET_NR_fcntl64               (TARGET_NR_Linux + 212)
-#define TARGET_NR_set_tid_address       (TARGET_NR_Linux + 213)
-#define TARGET_NR_restart_syscall       (TARGET_NR_Linux + 214)
-#define TARGET_NR_semtimedop            (TARGET_NR_Linux + 215)
-#define TARGET_NR_fadvise64             (TARGET_NR_Linux + 216)
-#define TARGET_NR_statfs64              (TARGET_NR_Linux + 217)
-#define TARGET_NR_fstatfs64             (TARGET_NR_Linux + 218)
-#define TARGET_NR_sendfile64            (TARGET_NR_Linux + 219)
-#define TARGET_NR_timer_create          (TARGET_NR_Linux + 220)
-#define TARGET_NR_timer_settime         (TARGET_NR_Linux + 221)
-#define TARGET_NR_timer_gettime         (TARGET_NR_Linux + 222)
-#define TARGET_NR_timer_getoverrun      (TARGET_NR_Linux + 223)
-#define TARGET_NR_timer_delete          (TARGET_NR_Linux + 224)
-#define TARGET_NR_clock_settime         (TARGET_NR_Linux + 225)
-#define TARGET_NR_clock_gettime         (TARGET_NR_Linux + 226)
-#define TARGET_NR_clock_getres          (TARGET_NR_Linux + 227)
-#define TARGET_NR_clock_nanosleep       (TARGET_NR_Linux + 228)
-#define TARGET_NR_tgkill                (TARGET_NR_Linux + 229)
-#define TARGET_NR_utimes                (TARGET_NR_Linux + 230)
-#define TARGET_NR_mbind                 (TARGET_NR_Linux + 231)
-#define TARGET_NR_get_mempolicy         (TARGET_NR_Linux + 232)
-#define TARGET_NR_set_mempolicy         (TARGET_NR_Linux + 233)
-#define TARGET_NR_mq_open               (TARGET_NR_Linux + 234)
-#define TARGET_NR_mq_unlink             (TARGET_NR_Linux + 235)
-#define TARGET_NR_mq_timedsend          (TARGET_NR_Linux + 236)
-#define TARGET_NR_mq_timedreceive       (TARGET_NR_Linux + 237)
-#define TARGET_NR_mq_notify             (TARGET_NR_Linux + 238)
-#define TARGET_NR_mq_getsetattr         (TARGET_NR_Linux + 239)
-#define TARGET_NR_vserver               (TARGET_NR_Linux + 240)
-#define TARGET_NR_waitid                (TARGET_NR_Linux + 241)
-/* #define TARGET_NR_sys_setaltroot     (TARGET_NR_Linux + 242) */
-#define TARGET_NR_add_key               (TARGET_NR_Linux + 243)
-#define TARGET_NR_request_key           (TARGET_NR_Linux + 244)
-#define TARGET_NR_keyctl                (TARGET_NR_Linux + 245)
-#define TARGET_NR_set_thread_area       (TARGET_NR_Linux + 246)
-#define TARGET_NR_inotify_init          (TARGET_NR_Linux + 247)
-#define TARGET_NR_inotify_add_watch     (TARGET_NR_Linux + 248)
-#define TARGET_NR_inotify_rm_watch      (TARGET_NR_Linux + 249)
-#define TARGET_NR_migrate_pages         (TARGET_NR_Linux + 250)
-#define TARGET_NR_openat                (TARGET_NR_Linux + 251)
-#define TARGET_NR_mkdirat               (TARGET_NR_Linux + 252)
-#define TARGET_NR_mknodat               (TARGET_NR_Linux + 253)
-#define TARGET_NR_fchownat              (TARGET_NR_Linux + 254)
-#define TARGET_NR_futimesat             (TARGET_NR_Linux + 255)
-#define TARGET_NR_newfstatat            (TARGET_NR_Linux + 256)
-#define TARGET_NR_unlinkat              (TARGET_NR_Linux + 257)
-#define TARGET_NR_renameat              (TARGET_NR_Linux + 258)
-#define TARGET_NR_linkat                (TARGET_NR_Linux + 259)
-#define TARGET_NR_symlinkat             (TARGET_NR_Linux + 260)
-#define TARGET_NR_readlinkat            (TARGET_NR_Linux + 261)
-#define TARGET_NR_fchmodat              (TARGET_NR_Linux + 262)
-#define TARGET_NR_faccessat             (TARGET_NR_Linux + 263)
-#define TARGET_NR_pselect6              (TARGET_NR_Linux + 264)
-#define TARGET_NR_ppoll                 (TARGET_NR_Linux + 265)
-#define TARGET_NR_unshare               (TARGET_NR_Linux + 266)
-#define TARGET_NR_splice                (TARGET_NR_Linux + 267)
-#define TARGET_NR_sync_file_range       (TARGET_NR_Linux + 268)
-#define TARGET_NR_tee                   (TARGET_NR_Linux + 269)
-#define TARGET_NR_vmsplice              (TARGET_NR_Linux + 270)
-#define TARGET_NR_move_pages            (TARGET_NR_Linux + 271)
-#define TARGET_NR_set_robust_list       (TARGET_NR_Linux + 272)
-#define TARGET_NR_get_robust_list       (TARGET_NR_Linux + 273)
-#define TARGET_NR_kexec_load            (TARGET_NR_Linux + 274)
-#define TARGET_NR_getcpu                (TARGET_NR_Linux + 275)
-#define TARGET_NR_epoll_pwait           (TARGET_NR_Linux + 276)
-#define TARGET_NR_ioprio_set            (TARGET_NR_Linux + 277)
-#define TARGET_NR_ioprio_get            (TARGET_NR_Linux + 278)
-#define TARGET_NR_utimensat             (TARGET_NR_Linux + 279)
-#define TARGET_NR_signalfd              (TARGET_NR_Linux + 280)
-#define TARGET_NR_timerfd               (TARGET_NR_Linux + 281)
-#define TARGET_NR_eventfd               (TARGET_NR_Linux + 282)
-#define TARGET_NR_fallocate             (TARGET_NR_Linux + 283)
-#define TARGET_NR_timerfd_create        (TARGET_NR_Linux + 284)
-#define TARGET_NR_timerfd_gettime       (TARGET_NR_Linux + 285)
-#define TARGET_NR_timerfd_settime       (TARGET_NR_Linux + 286)
-#define TARGET_NR_signalfd4             (TARGET_NR_Linux + 287)
-#define TARGET_NR_eventfd2              (TARGET_NR_Linux + 288)
-#define TARGET_NR_epoll_create1         (TARGET_NR_Linux + 289)
-#define TARGET_NR_dup3                  (TARGET_NR_Linux + 290)
-#define TARGET_NR_pipe2                 (TARGET_NR_Linux + 291)
-#define TARGET_NR_inotify_init1         (TARGET_NR_Linux + 292)
-#define TARGET_NR_preadv                (TARGET_NR_Linux + 293)
-#define TARGET_NR_pwritev               (TARGET_NR_Linux + 294)
-#define TARGET_NR_rt_tgsigqueueinfo     (TARGET_NR_Linux + 295)
-#define TARGET_NR_perf_event_open       (TARGET_NR_Linux + 296)
-#define TARGET_NR_accept4               (TARGET_NR_Linux + 297)
-#define TARGET_NR_recvmmsg              (TARGET_NR_Linux + 298)
-#define TARGET_NR_getdents64            (TARGET_NR_Linux + 299)
-#define TARGET_NR_fanotify_init         (TARGET_NR_Linux + 300)
-#define TARGET_NR_fanotify_mark         (TARGET_NR_Linux + 301)
-#define TARGET_NR_prlimit64             (TARGET_NR_Linux + 302)
-#define TARGET_NR_name_to_handle_at     (TARGET_NR_Linux + 303)
-#define TARGET_NR_open_by_handle_at     (TARGET_NR_Linux + 304)
-#define TARGET_NR_clock_adjtime         (TARGET_NR_Linux + 305)
-#define TARGET_NR_syncfs                (TARGET_NR_Linux + 306)
-#define TARGET_NR_sendmmsg              (TARGET_NR_Linux + 307)
-#define TARGET_NR_setns                 (TARGET_NR_Linux + 308)
-#define TARGET_NR_process_vm_readv      (TARGET_NR_Linux + 309)
-#define TARGET_NR_process_vm_writev     (TARGET_NR_Linux + 310)
-#define TARGET_NR_kcmp                  (TARGET_NR_Linux + 311)
-#define TARGET_NR_finit_module          (TARGET_NR_Linux + 312)
-#define TARGET_NR_sched_setattr         (TARGET_NR_Linux + 313)
-#define TARGET_NR_sched_getattr         (TARGET_NR_Linux + 314)
-#define TARGET_NR_renameat2             (TARGET_NR_Linux + 315)
-#define TARGET_NR_seccomp               (TARGET_NR_Linux + 316)
-#define TARGET_NR_getrandom             (TARGET_NR_Linux + 317)
-#define TARGET_NR_memfd_create          (TARGET_NR_Linux + 318)
-#define TARGET_NR_bpf                   (TARGET_NR_Linux + 319)
-#define TARGET_NR_execveat              (TARGET_NR_Linux + 320)
-#define TARGET_NR_userfaultfd           (TARGET_NR_Linux + 321)
-#define TARGET_NR_membarrier            (TARGET_NR_Linux + 322)
-#define TARGET_NR_mlock2                (TARGET_NR_Linux + 323)
-#define TARGET_NR_copy_file_range       (TARGET_NR_Linux + 324)
-#define TARGET_NR_preadv2               (TARGET_NR_Linux + 325)
-#define TARGET_NR_pwritev2              (TARGET_NR_Linux + 326)
-#define TARGET_NR_pkey_mprotect         (TARGET_NR_Linux + 327)
-#define TARGET_NR_pkey_alloc            (TARGET_NR_Linux + 328)
-#define TARGET_NR_pkey_free             (TARGET_NR_Linux + 329)
-#define TARGET_NR_statx                 (TARGET_NR_Linux + 330)
-#define TARGET_NR_rseq                  (TARGET_NR_Linux + 331)
-#define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 332)
-/* 333 through 402 are unassigned to sync up with generic numbers */
-#define TARGET_NR_clock_gettime64       (TARGET_NR_Linux + 403)
-#define TARGET_NR_clock_settime64       (TARGET_NR_Linux + 404)
-#define TARGET_NR_clock_adjtime64       (TARGET_NR_Linux + 405)
-#define TARGET_NR_clock_getres_time64   (TARGET_NR_Linux + 406)
-#define TARGET_NR_clock_nanosleep_time64 (TARGET_NR_Linux + 407)
-#define TARGET_NR_timer_gettime64       (TARGET_NR_Linux + 408)
-#define TARGET_NR_timer_settime64       (TARGET_NR_Linux + 409)
-#define TARGET_NR_timerfd_gettime64     (TARGET_NR_Linux + 410)
-#define TARGET_NR_timerfd_settime64     (TARGET_NR_Linux + 411)
-#define TARGET_NR_utimensat_time64      (TARGET_NR_Linux + 412)
-#define TARGET_NR_pselect6_time64       (TARGET_NR_Linux + 413)
-#define TARGET_NR_ppoll_time64          (TARGET_NR_Linux + 414)
-#define TARGET_NR_io_pgetevents_time64  (TARGET_NR_Linux + 416)
-#define TARGET_NR_recvmmsg_time64       (TARGET_NR_Linux + 417)
-#define TARGET_NR_mq_timedsend_time64   (TARGET_NR_Linux + 418)
-#define TARGET_NR_mq_timedreceive_time64 (TARGET_NR_Linux + 419)
-#define TARGET_NR_semtimedop_time64     (TARGET_NR_Linux + 420)
-#define TARGET_NR_rt_sigtimedwait_time64 (TARGET_NR_Linux + 421)
-#define TARGET_NR_futex_time64          (TARGET_NR_Linux + 422)
-#define TARGET_NR_sched_rr_get_interval_time64 (TARGET_NR_Linux + 423)
-#define TARGET_NR_pidfd_send_signal     (TARGET_NR_Linux + 424)
-#define TARGET_NR_io_uring_setup        (TARGET_NR_Linux + 425)
-#define TARGET_NR_io_uring_enter        (TARGET_NR_Linux + 426)
-#define TARGET_NR_io_uring_register     (TARGET_NR_Linux + 427)
-#define TARGET_NR_open_tree             (TARGET_NR_Linux + 428)
-#define TARGET_NR_move_mount            (TARGET_NR_Linux + 429)
-#define TARGET_NR_fsopen                (TARGET_NR_Linux + 430)
-#define TARGET_NR_fsconfig              (TARGET_NR_Linux + 431)
-#define TARGET_NR_fsmount               (TARGET_NR_Linux + 432)
-#define TARGET_NR_fspick                (TARGET_NR_Linux + 433)
-#define TARGET_NR_pidfd_open            (TARGET_NR_Linux + 434)
-#define TARGET_NR_clone3                (TARGET_NR_Linux + 435)
-
-#else
-/*
- * Linux 64-bit syscalls are in the range from 5000 to 5999.
- */
-#define TARGET_NR_Linux                 5000
-#define TARGET_NR_read                  (TARGET_NR_Linux +   0)
-#define TARGET_NR_write                 (TARGET_NR_Linux +   1)
-#define TARGET_NR_open                  (TARGET_NR_Linux +   2)
-#define TARGET_NR_close                 (TARGET_NR_Linux +   3)
-#define TARGET_NR_stat                  (TARGET_NR_Linux +   4)
-#define TARGET_NR_fstat                 (TARGET_NR_Linux +   5)
-#define TARGET_NR_lstat                 (TARGET_NR_Linux +   6)
-#define TARGET_NR_poll                  (TARGET_NR_Linux +   7)
-#define TARGET_NR_lseek                 (TARGET_NR_Linux +   8)
-#define TARGET_NR_mmap                  (TARGET_NR_Linux +   9)
-#define TARGET_NR_mprotect              (TARGET_NR_Linux +  10)
-#define TARGET_NR_munmap                (TARGET_NR_Linux +  11)
-#define TARGET_NR_brk                   (TARGET_NR_Linux +  12)
-#define TARGET_NR_rt_sigaction          (TARGET_NR_Linux +  13)
-#define TARGET_NR_rt_sigprocmask        (TARGET_NR_Linux +  14)
-#define TARGET_NR_ioctl                 (TARGET_NR_Linux +  15)
-#define TARGET_NR_pread64               (TARGET_NR_Linux +  16)
-#define TARGET_NR_pwrite64              (TARGET_NR_Linux +  17)
-#define TARGET_NR_readv                 (TARGET_NR_Linux +  18)
-#define TARGET_NR_writev                (TARGET_NR_Linux +  19)
-#define TARGET_NR_access                (TARGET_NR_Linux +  20)
-#define TARGET_NR_pipe                  (TARGET_NR_Linux +  21)
-#define TARGET_NR__newselect            (TARGET_NR_Linux +  22)
-#define TARGET_NR_sched_yield           (TARGET_NR_Linux +  23)
-#define TARGET_NR_mremap                (TARGET_NR_Linux +  24)
-#define TARGET_NR_msync                 (TARGET_NR_Linux +  25)
-#define TARGET_NR_mincore               (TARGET_NR_Linux +  26)
-#define TARGET_NR_madvise               (TARGET_NR_Linux +  27)
-#define TARGET_NR_shmget                (TARGET_NR_Linux +  28)
-#define TARGET_NR_shmat                 (TARGET_NR_Linux +  29)
-#define TARGET_NR_shmctl                (TARGET_NR_Linux +  30)
-#define TARGET_NR_dup                   (TARGET_NR_Linux +  31)
-#define TARGET_NR_dup2                  (TARGET_NR_Linux +  32)
-#define TARGET_NR_pause                 (TARGET_NR_Linux +  33)
-#define TARGET_NR_nanosleep             (TARGET_NR_Linux +  34)
-#define TARGET_NR_getitimer             (TARGET_NR_Linux +  35)
-#define TARGET_NR_setitimer             (TARGET_NR_Linux +  36)
-#define TARGET_NR_alarm                 (TARGET_NR_Linux +  37)
-#define TARGET_NR_getpid                (TARGET_NR_Linux +  38)
-#define TARGET_NR_sendfile              (TARGET_NR_Linux +  39)
-#define TARGET_NR_socket                (TARGET_NR_Linux +  40)
-#define TARGET_NR_connect               (TARGET_NR_Linux +  41)
-#define TARGET_NR_accept                (TARGET_NR_Linux +  42)
-#define TARGET_NR_sendto                (TARGET_NR_Linux +  43)
-#define TARGET_NR_recvfrom              (TARGET_NR_Linux +  44)
-#define TARGET_NR_sendmsg               (TARGET_NR_Linux +  45)
-#define TARGET_NR_recvmsg               (TARGET_NR_Linux +  46)
-#define TARGET_NR_shutdown              (TARGET_NR_Linux +  47)
-#define TARGET_NR_bind                  (TARGET_NR_Linux +  48)
-#define TARGET_NR_listen                (TARGET_NR_Linux +  49)
-#define TARGET_NR_getsockname           (TARGET_NR_Linux +  50)
-#define TARGET_NR_getpeername           (TARGET_NR_Linux +  51)
-#define TARGET_NR_socketpair            (TARGET_NR_Linux +  52)
-#define TARGET_NR_setsockopt            (TARGET_NR_Linux +  53)
-#define TARGET_NR_getsockopt            (TARGET_NR_Linux +  54)
-#define TARGET_NR_clone                 (TARGET_NR_Linux +  55)
-#define TARGET_NR_fork                  (TARGET_NR_Linux +  56)
-#define TARGET_NR_execve                (TARGET_NR_Linux +  57)
-#define TARGET_NR_exit                  (TARGET_NR_Linux +  58)
-#define TARGET_NR_wait4                 (TARGET_NR_Linux +  59)
-#define TARGET_NR_kill                  (TARGET_NR_Linux +  60)
-#define TARGET_NR_uname                 (TARGET_NR_Linux +  61)
-#define TARGET_NR_semget                (TARGET_NR_Linux +  62)
-#define TARGET_NR_semop                 (TARGET_NR_Linux +  63)
-#define TARGET_NR_semctl                (TARGET_NR_Linux +  64)
-#define TARGET_NR_shmdt                 (TARGET_NR_Linux +  65)
-#define TARGET_NR_msgget                (TARGET_NR_Linux +  66)
-#define TARGET_NR_msgsnd                (TARGET_NR_Linux +  67)
-#define TARGET_NR_msgrcv                (TARGET_NR_Linux +  68)
-#define TARGET_NR_msgctl                (TARGET_NR_Linux +  69)
-#define TARGET_NR_fcntl                 (TARGET_NR_Linux +  70)
-#define TARGET_NR_flock                 (TARGET_NR_Linux +  71)
-#define TARGET_NR_fsync                 (TARGET_NR_Linux +  72)
-#define TARGET_NR_fdatasync             (TARGET_NR_Linux +  73)
-#define TARGET_NR_truncate              (TARGET_NR_Linux +  74)
-#define TARGET_NR_ftruncate             (TARGET_NR_Linux +  75)
-#define TARGET_NR_getdents              (TARGET_NR_Linux +  76)
-#define TARGET_NR_getcwd                (TARGET_NR_Linux +  77)
-#define TARGET_NR_chdir                 (TARGET_NR_Linux +  78)
-#define TARGET_NR_fchdir                (TARGET_NR_Linux +  79)
-#define TARGET_NR_rename                (TARGET_NR_Linux +  80)
-#define TARGET_NR_mkdir                 (TARGET_NR_Linux +  81)
-#define TARGET_NR_rmdir                 (TARGET_NR_Linux +  82)
-#define TARGET_NR_creat                 (TARGET_NR_Linux +  83)
-#define TARGET_NR_link                  (TARGET_NR_Linux +  84)
-#define TARGET_NR_unlink                (TARGET_NR_Linux +  85)
-#define TARGET_NR_symlink               (TARGET_NR_Linux +  86)
-#define TARGET_NR_readlink              (TARGET_NR_Linux +  87)
-#define TARGET_NR_chmod                 (TARGET_NR_Linux +  88)
-#define TARGET_NR_fchmod                (TARGET_NR_Linux +  89)
-#define TARGET_NR_chown                 (TARGET_NR_Linux +  90)
-#define TARGET_NR_fchown                (TARGET_NR_Linux +  91)
-#define TARGET_NR_lchown                (TARGET_NR_Linux +  92)
-#define TARGET_NR_umask                 (TARGET_NR_Linux +  93)
-#define TARGET_NR_gettimeofday          (TARGET_NR_Linux +  94)
-#define TARGET_NR_getrlimit             (TARGET_NR_Linux +  95)
-#define TARGET_NR_getrusage             (TARGET_NR_Linux +  96)
-#define TARGET_NR_sysinfo               (TARGET_NR_Linux +  97)
-#define TARGET_NR_times                 (TARGET_NR_Linux +  98)
-#define TARGET_NR_ptrace                (TARGET_NR_Linux +  99)
-#define TARGET_NR_getuid                (TARGET_NR_Linux + 100)
-#define TARGET_NR_syslog                (TARGET_NR_Linux + 101)
-#define TARGET_NR_getgid                (TARGET_NR_Linux + 102)
-#define TARGET_NR_setuid                (TARGET_NR_Linux + 103)
-#define TARGET_NR_setgid                (TARGET_NR_Linux + 104)
-#define TARGET_NR_geteuid               (TARGET_NR_Linux + 105)
-#define TARGET_NR_getegid               (TARGET_NR_Linux + 106)
-#define TARGET_NR_setpgid               (TARGET_NR_Linux + 107)
-#define TARGET_NR_getppid               (TARGET_NR_Linux + 108)
-#define TARGET_NR_getpgrp               (TARGET_NR_Linux + 109)
-#define TARGET_NR_setsid                (TARGET_NR_Linux + 110)
-#define TARGET_NR_setreuid              (TARGET_NR_Linux + 111)
-#define TARGET_NR_setregid              (TARGET_NR_Linux + 112)
-#define TARGET_NR_getgroups             (TARGET_NR_Linux + 113)
-#define TARGET_NR_setgroups             (TARGET_NR_Linux + 114)
-#define TARGET_NR_setresuid             (TARGET_NR_Linux + 115)
-#define TARGET_NR_getresuid             (TARGET_NR_Linux + 116)
-#define TARGET_NR_setresgid             (TARGET_NR_Linux + 117)
-#define TARGET_NR_getresgid             (TARGET_NR_Linux + 118)
-#define TARGET_NR_getpgid               (TARGET_NR_Linux + 119)
-#define TARGET_NR_setfsuid              (TARGET_NR_Linux + 120)
-#define TARGET_NR_setfsgid              (TARGET_NR_Linux + 121)
-#define TARGET_NR_getsid                (TARGET_NR_Linux + 122)
-#define TARGET_NR_capget                (TARGET_NR_Linux + 123)
-#define TARGET_NR_capset                (TARGET_NR_Linux + 124)
-#define TARGET_NR_rt_sigpending         (TARGET_NR_Linux + 125)
-#define TARGET_NR_rt_sigtimedwait       (TARGET_NR_Linux + 126)
-#define TARGET_NR_rt_sigqueueinfo       (TARGET_NR_Linux + 127)
-#define TARGET_NR_rt_sigsuspend         (TARGET_NR_Linux + 128)
-#define TARGET_NR_sigaltstack           (TARGET_NR_Linux + 129)
-#define TARGET_NR_utime                 (TARGET_NR_Linux + 130)
-#define TARGET_NR_mknod                 (TARGET_NR_Linux + 131)
-#define TARGET_NR_personality           (TARGET_NR_Linux + 132)
-#define TARGET_NR_ustat                 (TARGET_NR_Linux + 133)
-#define TARGET_NR_statfs                (TARGET_NR_Linux + 134)
-#define TARGET_NR_fstatfs               (TARGET_NR_Linux + 135)
-#define TARGET_NR_sysfs                 (TARGET_NR_Linux + 136)
-#define TARGET_NR_getpriority           (TARGET_NR_Linux + 137)
-#define TARGET_NR_setpriority           (TARGET_NR_Linux + 138)
-#define TARGET_NR_sched_setparam        (TARGET_NR_Linux + 139)
-#define TARGET_NR_sched_getparam        (TARGET_NR_Linux + 140)
-#define TARGET_NR_sched_setscheduler    (TARGET_NR_Linux + 141)
-#define TARGET_NR_sched_getscheduler    (TARGET_NR_Linux + 142)
-#define TARGET_NR_sched_get_priority_max (TARGET_NR_Linux + 143)
-#define TARGET_NR_sched_get_priority_min (TARGET_NR_Linux + 144)
-#define TARGET_NR_sched_rr_get_interval (TARGET_NR_Linux + 145)
-#define TARGET_NR_mlock                 (TARGET_NR_Linux + 146)
-#define TARGET_NR_munlock               (TARGET_NR_Linux + 147)
-#define TARGET_NR_mlockall              (TARGET_NR_Linux + 148)
-#define TARGET_NR_munlockall            (TARGET_NR_Linux + 149)
-#define TARGET_NR_vhangup               (TARGET_NR_Linux + 150)
-#define TARGET_NR_pivot_root            (TARGET_NR_Linux + 151)
-#define TARGET_NR__sysctl               (TARGET_NR_Linux + 152)
-#define TARGET_NR_prctl                 (TARGET_NR_Linux + 153)
-#define TARGET_NR_adjtimex              (TARGET_NR_Linux + 154)
-#define TARGET_NR_setrlimit             (TARGET_NR_Linux + 155)
-#define TARGET_NR_chroot                (TARGET_NR_Linux + 156)
-#define TARGET_NR_sync                  (TARGET_NR_Linux + 157)
-#define TARGET_NR_acct                  (TARGET_NR_Linux + 158)
-#define TARGET_NR_settimeofday          (TARGET_NR_Linux + 159)
-#define TARGET_NR_mount                 (TARGET_NR_Linux + 160)
-#define TARGET_NR_umount2               (TARGET_NR_Linux + 161)
-#define TARGET_NR_swapon                (TARGET_NR_Linux + 162)
-#define TARGET_NR_swapoff               (TARGET_NR_Linux + 163)
-#define TARGET_NR_reboot                (TARGET_NR_Linux + 164)
-#define TARGET_NR_sethostname           (TARGET_NR_Linux + 165)
-#define TARGET_NR_setdomainname         (TARGET_NR_Linux + 166)
-#define TARGET_NR_create_module         (TARGET_NR_Linux + 167)
-#define TARGET_NR_init_module           (TARGET_NR_Linux + 168)
-#define TARGET_NR_delete_module         (TARGET_NR_Linux + 169)
-#define TARGET_NR_get_kernel_syms       (TARGET_NR_Linux + 170)
-#define TARGET_NR_query_module          (TARGET_NR_Linux + 171)
-#define TARGET_NR_quotactl              (TARGET_NR_Linux + 172)
-#define TARGET_NR_nfsservctl            (TARGET_NR_Linux + 173)
-#define TARGET_NR_getpmsg               (TARGET_NR_Linux + 174)
-#define TARGET_NR_putpmsg               (TARGET_NR_Linux + 175)
-#define TARGET_NR_afs_syscall           (TARGET_NR_Linux + 176)
-#define TARGET_NR_reserved177           (TARGET_NR_Linux + 177)
-#define TARGET_NR_gettid                (TARGET_NR_Linux + 178)
-#define TARGET_NR_readahead             (TARGET_NR_Linux + 179)
-#define TARGET_NR_setxattr              (TARGET_NR_Linux + 180)
-#define TARGET_NR_lsetxattr             (TARGET_NR_Linux + 181)
-#define TARGET_NR_fsetxattr             (TARGET_NR_Linux + 182)
-#define TARGET_NR_getxattr              (TARGET_NR_Linux + 183)
-#define TARGET_NR_lgetxattr             (TARGET_NR_Linux + 184)
-#define TARGET_NR_fgetxattr             (TARGET_NR_Linux + 185)
-#define TARGET_NR_listxattr             (TARGET_NR_Linux + 186)
-#define TARGET_NR_llistxattr            (TARGET_NR_Linux + 187)
-#define TARGET_NR_flistxattr            (TARGET_NR_Linux + 188)
-#define TARGET_NR_removexattr           (TARGET_NR_Linux + 189)
-#define TARGET_NR_lremovexattr          (TARGET_NR_Linux + 190)
-#define TARGET_NR_fremovexattr          (TARGET_NR_Linux + 191)
-#define TARGET_NR_tkill                 (TARGET_NR_Linux + 192)
-#define TARGET_NR_reserved193           (TARGET_NR_Linux + 193)
-#define TARGET_NR_futex                 (TARGET_NR_Linux + 194)
-#define TARGET_NR_sched_setaffinity     (TARGET_NR_Linux + 195)
-#define TARGET_NR_sched_getaffinity     (TARGET_NR_Linux + 196)
-#define TARGET_NR_cacheflush            (TARGET_NR_Linux + 197)
-#define TARGET_NR_cachectl              (TARGET_NR_Linux + 198)
-#define TARGET_NR_sysmips               (TARGET_NR_Linux + 199)
-#define TARGET_NR_io_setup              (TARGET_NR_Linux + 200)
-#define TARGET_NR_io_destroy            (TARGET_NR_Linux + 201)
-#define TARGET_NR_io_getevents          (TARGET_NR_Linux + 202)
-#define TARGET_NR_io_submit             (TARGET_NR_Linux + 203)
-#define TARGET_NR_io_cancel             (TARGET_NR_Linux + 204)
-#define TARGET_NR_exit_group            (TARGET_NR_Linux + 205)
-#define TARGET_NR_lookup_dcookie        (TARGET_NR_Linux + 206)
-#define TARGET_NR_epoll_create          (TARGET_NR_Linux + 207)
-#define TARGET_NR_epoll_ctl             (TARGET_NR_Linux + 208)
-#define TARGET_NR_epoll_wait            (TARGET_NR_Linux + 209)
-#define TARGET_NR_remap_file_pages      (TARGET_NR_Linux + 210)
-#define TARGET_NR_rt_sigreturn          (TARGET_NR_Linux + 211)
-#define TARGET_NR_set_tid_address       (TARGET_NR_Linux + 212)
-#define TARGET_NR_restart_syscall       (TARGET_NR_Linux + 213)
-#define TARGET_NR_semtimedop            (TARGET_NR_Linux + 214)
-#define TARGET_NR_fadvise64             (TARGET_NR_Linux + 215)
-#define TARGET_NR_timer_create          (TARGET_NR_Linux + 216)
-#define TARGET_NR_timer_settime         (TARGET_NR_Linux + 217)
-#define TARGET_NR_timer_gettime         (TARGET_NR_Linux + 218)
-#define TARGET_NR_timer_getoverrun      (TARGET_NR_Linux + 219)
-#define TARGET_NR_timer_delete          (TARGET_NR_Linux + 220)
-#define TARGET_NR_clock_settime         (TARGET_NR_Linux + 221)
-#define TARGET_NR_clock_gettime         (TARGET_NR_Linux + 222)
-#define TARGET_NR_clock_getres          (TARGET_NR_Linux + 223)
-#define TARGET_NR_clock_nanosleep       (TARGET_NR_Linux + 224)
-#define TARGET_NR_tgkill                (TARGET_NR_Linux + 225)
-#define TARGET_NR_utimes                (TARGET_NR_Linux + 226)
-#define TARGET_NR_mbind                 (TARGET_NR_Linux + 227)
-#define TARGET_NR_get_mempolicy         (TARGET_NR_Linux + 228)
-#define TARGET_NR_set_mempolicy         (TARGET_NR_Linux + 229)
-#define TARGET_NR_mq_open               (TARGET_NR_Linux + 230)
-#define TARGET_NR_mq_unlink             (TARGET_NR_Linux + 231)
-#define TARGET_NR_mq_timedsend          (TARGET_NR_Linux + 232)
-#define TARGET_NR_mq_timedreceive       (TARGET_NR_Linux + 233)
-#define TARGET_NR_mq_notify             (TARGET_NR_Linux + 234)
-#define TARGET_NR_mq_getsetattr         (TARGET_NR_Linux + 235)
-#define TARGET_NR_vserver               (TARGET_NR_Linux + 236)
-#define TARGET_NR_waitid                (TARGET_NR_Linux + 237)
-/* #define TARGET_NR_sys_setaltroot     (TARGET_NR_Linux + 238) */
-#define TARGET_NR_add_key               (TARGET_NR_Linux + 239)
-#define TARGET_NR_request_key           (TARGET_NR_Linux + 240)
-#define TARGET_NR_keyctl                (TARGET_NR_Linux + 241)
-#define TARGET_NR_set_thread_area       (TARGET_NR_Linux + 242)
-#define TARGET_NR_inotify_init          (TARGET_NR_Linux + 243)
-#define TARGET_NR_inotify_add_watch     (TARGET_NR_Linux + 244)
-#define TARGET_NR_inotify_rm_watch      (TARGET_NR_Linux + 245)
-#define TARGET_NR_migrate_pages         (TARGET_NR_Linux + 246)
-#define TARGET_NR_openat                (TARGET_NR_Linux + 247)
-#define TARGET_NR_mkdirat               (TARGET_NR_Linux + 248)
-#define TARGET_NR_mknodat               (TARGET_NR_Linux + 249)
-#define TARGET_NR_fchownat              (TARGET_NR_Linux + 250)
-#define TARGET_NR_futimesat             (TARGET_NR_Linux + 251)
-#define TARGET_NR_newfstatat            (TARGET_NR_Linux + 252)
-#define TARGET_NR_unlinkat              (TARGET_NR_Linux + 253)
-#define TARGET_NR_renameat              (TARGET_NR_Linux + 254)
-#define TARGET_NR_linkat                (TARGET_NR_Linux + 255)
-#define TARGET_NR_symlinkat             (TARGET_NR_Linux + 256)
-#define TARGET_NR_readlinkat            (TARGET_NR_Linux + 257)
-#define TARGET_NR_fchmodat              (TARGET_NR_Linux + 258)
-#define TARGET_NR_faccessat             (TARGET_NR_Linux + 259)
-#define TARGET_NR_pselect6              (TARGET_NR_Linux + 260)
-#define TARGET_NR_ppoll                 (TARGET_NR_Linux + 261)
-#define TARGET_NR_unshare               (TARGET_NR_Linux + 262)
-#define TARGET_NR_splice                (TARGET_NR_Linux + 263)
-#define TARGET_NR_sync_file_range       (TARGET_NR_Linux + 264)
-#define TARGET_NR_tee                   (TARGET_NR_Linux + 265)
-#define TARGET_NR_vmsplice              (TARGET_NR_Linux + 266)
-#define TARGET_NR_move_pages            (TARGET_NR_Linux + 267)
-#define TARGET_NR_set_robust_list       (TARGET_NR_Linux + 268)
-#define TARGET_NR_get_robust_list       (TARGET_NR_Linux + 269)
-#define TARGET_NR_kexec_load            (TARGET_NR_Linux + 270)
-#define TARGET_NR_getcpu                (TARGET_NR_Linux + 271)
-#define TARGET_NR_epoll_pwait           (TARGET_NR_Linux + 272)
-#define TARGET_NR_ioprio_set            (TARGET_NR_Linux + 273)
-#define TARGET_NR_ioprio_get            (TARGET_NR_Linux + 274)
-#define TARGET_NR_utimensat             (TARGET_NR_Linux + 275)
-#define TARGET_NR_signalfd              (TARGET_NR_Linux + 276)
-#define TARGET_NR_timerfd               (TARGET_NR_Linux + 277)
-#define TARGET_NR_eventfd               (TARGET_NR_Linux + 278)
-#define TARGET_NR_fallocate             (TARGET_NR_Linux + 279)
-#define TARGET_NR_timerfd_create        (TARGET_NR_Linux + 280)
-#define TARGET_NR_timerfd_gettime       (TARGET_NR_Linux + 281)
-#define TARGET_NR_timerfd_settime       (TARGET_NR_Linux + 282)
-#define TARGET_NR_signalfd4             (TARGET_NR_Linux + 283)
-#define TARGET_NR_eventfd2              (TARGET_NR_Linux + 284)
-#define TARGET_NR_epoll_create1         (TARGET_NR_Linux + 285)
-#define TARGET_NR_dup3                  (TARGET_NR_Linux + 286)
-#define TARGET_NR_pipe2                 (TARGET_NR_Linux + 287)
-#define TARGET_NR_inotify_init1         (TARGET_NR_Linux + 288)
-#define TARGET_NR_preadv                (TARGET_NR_Linux + 289)
-#define TARGET_NR_pwritev               (TARGET_NR_Linux + 290)
-#define TARGET_NR_rt_tgsigqueueinfo     (TARGET_NR_Linux + 291)
-#define TARGET_NR_perf_event_open       (TARGET_NR_Linux + 292)
-#define TARGET_NR_accept4               (TARGET_NR_Linux + 293)
-#define TARGET_NR_recvmmsg              (TARGET_NR_Linux + 294)
-#define TARGET_NR_fanotify_init         (TARGET_NR_Linux + 295)
-#define TARGET_NR_fanotify_mark         (TARGET_NR_Linux + 296)
-#define TARGET_NR_prlimit64             (TARGET_NR_Linux + 297)
-#define TARGET_NR_name_to_handle_at     (TARGET_NR_Linux + 298)
-#define TARGET_NR_open_by_handle_at     (TARGET_NR_Linux + 299)
-#define TARGET_NR_clock_adjtime         (TARGET_NR_Linux + 300)
-#define TARGET_NR_syncfs                (TARGET_NR_Linux + 301)
-#define TARGET_NR_sendmmsg              (TARGET_NR_Linux + 302)
-#define TARGET_NR_setns                 (TARGET_NR_Linux + 303)
-#define TARGET_NR_process_vm_readv      (TARGET_NR_Linux + 304)
-#define TARGET_NR_process_vm_writev     (TARGET_NR_Linux + 305)
-#define TARGET_NR_kcmp                  (TARGET_NR_Linux + 306)
-#define TARGET_NR_finit_module          (TARGET_NR_Linux + 307)
-#define TARGET_NR_getdents64            (TARGET_NR_Linux + 308)
-#define TARGET_NR_sched_setattr         (TARGET_NR_Linux + 309)
-#define TARGET_NR_sched_getattr         (TARGET_NR_Linux + 310)
-#define TARGET_NR_renameat2             (TARGET_NR_Linux + 311)
-#define TARGET_NR_seccomp               (TARGET_NR_Linux + 312)
-#define TARGET_NR_getrandom             (TARGET_NR_Linux + 313)
-#define TARGET_NR_memfd_create          (TARGET_NR_Linux + 314)
-#define TARGET_NR_bpf                   (TARGET_NR_Linux + 315)
-#define TARGET_NR_execveat              (TARGET_NR_Linux + 316)
-#define TARGET_NR_userfaultfd           (TARGET_NR_Linux + 317)
-#define TARGET_NR_membarrier            (TARGET_NR_Linux + 318)
-#define TARGET_NR_mlock2                (TARGET_NR_Linux + 319)
-#define TARGET_NR_copy_file_range       (TARGET_NR_Linux + 320)
-#define TARGET_NR_preadv2               (TARGET_NR_Linux + 321)
-#define TARGET_NR_pwritev2              (TARGET_NR_Linux + 322)
-#define TARGET_NR_pkey_mprotect         (TARGET_NR_Linux + 323)
-#define TARGET_NR_pkey_alloc            (TARGET_NR_Linux + 324)
-#define TARGET_NR_pkey_free             (TARGET_NR_Linux + 325)
-#define TARGET_NR_statx                 (TARGET_NR_Linux + 326)
-#define TARGET_NR_rseq                  (TARGET_NR_Linux + 327)
-#define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 328)
-/* 329 through 423 are reserved to sync up with other architectures */
-#define TARGET_NR_pidfd_send_signal     (TARGET_NR_Linux + 424)
-#define TARGET_NR_io_uring_setup        (TARGET_NR_Linux + 425)
-#define TARGET_NR_io_uring_enter        (TARGET_NR_Linux + 426)
-#define TARGET_NR_io_uring_register     (TARGET_NR_Linux + 427)
-#define TARGET_NR_open_tree             (TARGET_NR_Linux + 428)
-#define TARGET_NR_move_mount            (TARGET_NR_Linux + 429)
-#define TARGET_NR_fsopen                (TARGET_NR_Linux + 430)
-#define TARGET_NR_fsconfig              (TARGET_NR_Linux + 431)
-#define TARGET_NR_fsmount               (TARGET_NR_Linux + 432)
-#define TARGET_NR_fspick                (TARGET_NR_Linux + 433)
-#define TARGET_NR_pidfd_open            (TARGET_NR_Linux + 434)
-#define TARGET_NR_clone3                (TARGET_NR_Linux + 435)
-#endif
-
-#endif
diff --git a/linux-user/mips64/syscallhdr.sh b/linux-user/mips64/syscallhdr.sh
new file mode 100644
index 000000000000..ed5a45165a40
--- /dev/null
+++ b/linux-user/mips64/syscallhdr.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+in="$1"
+out="$2"
+my_abis=`echo "($3)" | tr ',' '|'`
+prefix="$4"
+offset="$5"
+
+fileguard=LINUX_USER_MIPS64_`basename "$out" | sed \
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
+    printf "\n"
+) > "$out"
-- 
2.24.1


