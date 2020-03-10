Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3A6C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A5B24680
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A5B24680
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcJS-0003d1-Ls
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBcE7-0004GQ-0U
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBcE2-00005y-QL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:35:06 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58575)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBcDs-0008Ia-GN; Tue, 10 Mar 2020 06:34:52 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlfGs-1jbZMS1fGc-00ihkt; Tue, 10 Mar 2020 11:34:15 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/21] linux-user,
 m68k: add syscall table generation support
Date: Tue, 10 Mar 2020 11:33:46 +0100
Message-Id: <20200310103403.3284090-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310103403.3284090-1-laurent@vivier.eu>
References: <20200310103403.3284090-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Xx97jgj2CbdZsxCfsJnzgHV/DmFZLxMC3S+E3MYFsbQOkYo/EyK
 P6o65jijAetW1CPSdVhGVq6ZlaFzHijw1x6YVKBW5quYXXq+a2F/KEehHwiZSLFHyWCWqDn
 dfdERV7G+iSHnGr4DEvmua3Xh7P+7uXtk5CZ8FtnDaORrU+hO9ZRngjO7jCAkgwl4d/OIJR
 UPayw7iEF2NJi5tzyeELw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6Ajdo7uUy44=:ylZHWR27qcyxuNAn+/UoxY
 PslqvPx7ySd5qpfiFbvk432aMt03K3FVHw7s2UYt4HGMXJx69Q7eJ7i32f6DDFetibXhzKjsD
 ML9TGOLnwpU6a1M5fwd22tu7OcO9RYWNENVzCzVoXy0x9CwJt9jpZCR/qhoM4I8XpgGzJov21
 nuUT8CId40kQGjFTYrPKeQzOcBpkfZ3/4d1T/38bMuYWBv1EwSQDq54u3CDCw2oW/VnrxTRRy
 ggPKVvBwHpVpBdDBfAP/4TN+0Q5MjsBEina4PiPsPiKZ/exU3FdN3ZDmBtxGQoYMMU4ewwci/
 GSFGitYVgkMHP2KEWFmAe+5a7LKYIUZzgoFFVZvXK9aiAM9SUyO3pRrMQiM/h8OGGfIxrqW0F
 Ywqam67YajEOsDbQ5G13R1TUhgIjES248E7vF1axngP8N5jcw4UnjEgWO2aUdZ+zdV0LPv8qR
 eB4ImbgtyiIvIzHBaeutm1ayqDNhzono7dyI0FPSrTXmvwUc87U4X/nG1w5qo4aFyezJFnRMm
 W3AErKsRY9tSwTZFnNXqWKJIY9QT+0XrmYs8PwQTHRqMCyukpxk6FJM2u3NMMu1MzOdKQoPRz
 LmwsaLLC47PycZTYi+jioqYqFxk9hJ6Nzqka5E9/3jOqGIdsFBKZ5opAsr/uCXhCJ6x1DI0HX
 3yofFZQwln0Rifes8GKNxT+ezPOMc+HDiG0IznT/lQTzOw2XoevpVogw4k+IeaC96zvD+inoH
 A3o6sRREoMu1xxEloR4oBi48aQ+96O4sncnQXEQxMvWQx9VjQrYzy8E2qxFi9MEzpqhuNfKl+
 /yPLP1pyqRxyPydW/M04yqOh2nHlsJCJ0tVaAJrV1aMyntl+rodQzJRByHlnWbhKe47BaU0ya
 Fjs7Mo5R7PPoIMljHXIyjG1+DBmhf/u0BJF6fZS1sk7ycSLE+HKuJWD71HCK83nM5dudYimxl
 VnhL6PoYICA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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

Copy syscall.tbl and syscallhdr.sh from linux/arch/m68k/kernel/syscalls v5.5
Update syscallhdr.sh to generate QEMU syscall_nr.h

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
---
 configure                     |   3 +-
 linux-user/Makefile.objs      |   1 +
 linux-user/m68k/Makefile.objs |   5 +
 linux-user/m68k/syscall.tbl   | 437 ++++++++++++++++++++++++++++++++++
 linux-user/m68k/syscall_nr.h  | 434 ---------------------------------
 linux-user/m68k/syscallhdr.sh |  32 +++
 6 files changed, 477 insertions(+), 435 deletions(-)
 create mode 100644 linux-user/m68k/Makefile.objs
 create mode 100644 linux-user/m68k/syscall.tbl
 delete mode 100644 linux-user/m68k/syscall_nr.h
 create mode 100644 linux-user/m68k/syscallhdr.sh

diff --git a/configure b/configure
index d96b767947af..480e1d9af5f1 100755
--- a/configure
+++ b/configure
@@ -1889,7 +1889,7 @@ rm -f */config-devices.mak.d
 
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
-for arch in alpha hppa ; do
+for arch in alpha hppa m68k ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
@@ -7821,6 +7821,7 @@ case "$target_name" in
   m68k)
     bflt="yes"
     gdb_xml_files="cf-core.xml cf-fp.xml m68k-fp.xml"
+    TARGET_SYSTBL_ABI=common
   ;;
   microblaze|microblazeel)
     TARGET_ARCH=microblaze
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 9f8e001241d5..ac74b23683cf 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -11,3 +11,4 @@ obj-$(TARGET_AARCH64) += arm/semihost.o
 
 obj-$(TARGET_ALPHA) += alpha/
 obj-$(TARGET_HPPA) += hppa/
+obj-$(TARGET_M68K) += m68k/
diff --git a/linux-user/m68k/Makefile.objs b/linux-user/m68k/Makefile.objs
new file mode 100644
index 000000000000..961bd05c237f
--- /dev/null
+++ b/linux-user/m68k/Makefile.objs
@@ -0,0 +1,5 @@
+generated-files-y += linux-user/m68k/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/m68k/syscallhdr.sh
+%/syscall_nr.h: $(SRC_PATH)/linux-user/m68k/syscall.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/m68k/syscall.tbl b/linux-user/m68k/syscall.tbl
new file mode 100644
index 000000000000..a88a285a0e5f
--- /dev/null
+++ b/linux-user/m68k/syscall.tbl
@@ -0,0 +1,437 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for m68k
+#
+# The format is:
+# <number> <abi> <name> <entry point>
+#
+# The <abi> is always "common" for this file
+#
+0	common	restart_syscall			sys_restart_syscall
+1	common	exit				sys_exit
+2	common	fork				__sys_fork
+3	common	read				sys_read
+4	common	write				sys_write
+5	common	open				sys_open
+6	common	close				sys_close
+7	common	waitpid				sys_waitpid
+8	common	creat				sys_creat
+9	common	link				sys_link
+10	common	unlink				sys_unlink
+11	common	execve				sys_execve
+12	common	chdir				sys_chdir
+13	common	time				sys_time32
+14	common	mknod				sys_mknod
+15	common	chmod				sys_chmod
+16	common	chown				sys_chown16
+# 17 was break
+18	common	oldstat				sys_stat
+19	common	lseek				sys_lseek
+20	common	getpid				sys_getpid
+21	common	mount				sys_mount
+22	common	umount				sys_oldumount
+23	common	setuid				sys_setuid16
+24	common	getuid				sys_getuid16
+25	common	stime				sys_stime32
+26	common	ptrace				sys_ptrace
+27	common	alarm				sys_alarm
+28	common	oldfstat			sys_fstat
+29	common	pause				sys_pause
+30	common	utime				sys_utime32
+# 31 was stty
+# 32 was gtty
+33	common	access				sys_access
+34	common	nice				sys_nice
+# 35 was ftime
+36	common	sync				sys_sync
+37	common	kill				sys_kill
+38	common	rename				sys_rename
+39	common	mkdir				sys_mkdir
+40	common	rmdir				sys_rmdir
+41	common	dup				sys_dup
+42	common	pipe				sys_pipe
+43	common	times				sys_times
+# 44 was prof
+45	common	brk				sys_brk
+46	common	setgid				sys_setgid16
+47	common	getgid				sys_getgid16
+48	common	signal				sys_signal
+49	common	geteuid				sys_geteuid16
+50	common	getegid				sys_getegid16
+51	common	acct				sys_acct
+52	common	umount2				sys_umount
+# 53 was lock
+54	common	ioctl				sys_ioctl
+55	common	fcntl				sys_fcntl
+# 56 was mpx
+57	common	setpgid				sys_setpgid
+# 58 was ulimit
+# 59 was oldolduname
+60	common	umask				sys_umask
+61	common	chroot				sys_chroot
+62	common	ustat				sys_ustat
+63	common	dup2				sys_dup2
+64	common	getppid				sys_getppid
+65	common	getpgrp				sys_getpgrp
+66	common	setsid				sys_setsid
+67	common	sigaction			sys_sigaction
+68	common	sgetmask			sys_sgetmask
+69	common	ssetmask			sys_ssetmask
+70	common	setreuid			sys_setreuid16
+71	common	setregid			sys_setregid16
+72	common	sigsuspend			sys_sigsuspend
+73	common	sigpending			sys_sigpending
+74	common	sethostname			sys_sethostname
+75	common	setrlimit			sys_setrlimit
+76	common	getrlimit			sys_old_getrlimit
+77	common	getrusage			sys_getrusage
+78	common	gettimeofday			sys_gettimeofday
+79	common	settimeofday			sys_settimeofday
+80	common	getgroups			sys_getgroups16
+81	common	setgroups			sys_setgroups16
+82	common	select				sys_old_select
+83	common	symlink				sys_symlink
+84	common	oldlstat			sys_lstat
+85	common	readlink			sys_readlink
+86	common	uselib				sys_uselib
+87	common	swapon				sys_swapon
+88	common	reboot				sys_reboot
+89	common	readdir				sys_old_readdir
+90	common	mmap				sys_old_mmap
+91	common	munmap				sys_munmap
+92	common	truncate			sys_truncate
+93	common	ftruncate			sys_ftruncate
+94	common	fchmod				sys_fchmod
+95	common	fchown				sys_fchown16
+96	common	getpriority			sys_getpriority
+97	common	setpriority			sys_setpriority
+# 98 was profil
+99	common	statfs				sys_statfs
+100	common	fstatfs				sys_fstatfs
+# 101 was ioperm
+102	common	socketcall			sys_socketcall
+103	common	syslog				sys_syslog
+104	common	setitimer			sys_setitimer
+105	common	getitimer			sys_getitimer
+106	common	stat				sys_newstat
+107	common	lstat				sys_newlstat
+108	common	fstat				sys_newfstat
+# 109 was olduname
+# 110 was iopl
+111	common	vhangup				sys_vhangup
+# 112 was idle
+# 113 was vm86
+114	common	wait4				sys_wait4
+115	common	swapoff				sys_swapoff
+116	common	sysinfo				sys_sysinfo
+117	common	ipc				sys_ipc
+118	common	fsync				sys_fsync
+119	common	sigreturn			sys_sigreturn
+120	common	clone				__sys_clone
+121	common	setdomainname			sys_setdomainname
+122	common	uname				sys_newuname
+123	common	cacheflush			sys_cacheflush
+124	common	adjtimex			sys_adjtimex_time32
+125	common	mprotect			sys_mprotect
+126	common	sigprocmask			sys_sigprocmask
+127	common	create_module			sys_ni_syscall
+128	common	init_module			sys_init_module
+129	common	delete_module			sys_delete_module
+130	common	get_kernel_syms			sys_ni_syscall
+131	common	quotactl			sys_quotactl
+132	common	getpgid				sys_getpgid
+133	common	fchdir				sys_fchdir
+134	common	bdflush				sys_bdflush
+135	common	sysfs				sys_sysfs
+136	common	personality			sys_personality
+# 137 was afs_syscall
+138	common	setfsuid			sys_setfsuid16
+139	common	setfsgid			sys_setfsgid16
+140	common	_llseek				sys_llseek
+141	common	getdents			sys_getdents
+142	common	_newselect			sys_select
+143	common	flock				sys_flock
+144	common	msync				sys_msync
+145	common	readv				sys_readv
+146	common	writev				sys_writev
+147	common	getsid				sys_getsid
+148	common	fdatasync			sys_fdatasync
+149	common	_sysctl				sys_sysctl
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
+161	common	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+162	common	nanosleep			sys_nanosleep_time32
+163	common	mremap				sys_mremap
+164	common	setresuid			sys_setresuid16
+165	common	getresuid			sys_getresuid16
+166	common	getpagesize			sys_getpagesize
+167	common	query_module			sys_ni_syscall
+168	common	poll				sys_poll
+169	common	nfsservctl			sys_ni_syscall
+170	common	setresgid			sys_setresgid16
+171	common	getresgid			sys_getresgid16
+172	common	prctl				sys_prctl
+173	common	rt_sigreturn			sys_rt_sigreturn
+174	common	rt_sigaction			sys_rt_sigaction
+175	common	rt_sigprocmask			sys_rt_sigprocmask
+176	common	rt_sigpending			sys_rt_sigpending
+177	common	rt_sigtimedwait			sys_rt_sigtimedwait_time32
+178	common	rt_sigqueueinfo			sys_rt_sigqueueinfo
+179	common	rt_sigsuspend			sys_rt_sigsuspend
+180	common	pread64				sys_pread64
+181	common	pwrite64			sys_pwrite64
+182	common	lchown				sys_lchown16
+183	common	getcwd				sys_getcwd
+184	common	capget				sys_capget
+185	common	capset				sys_capset
+186	common	sigaltstack			sys_sigaltstack
+187	common	sendfile			sys_sendfile
+188	common	getpmsg				sys_ni_syscall
+189	common	putpmsg				sys_ni_syscall
+190	common	vfork				__sys_vfork
+191	common	ugetrlimit			sys_getrlimit
+192	common	mmap2				sys_mmap2
+193	common	truncate64			sys_truncate64
+194	common	ftruncate64			sys_ftruncate64
+195	common	stat64				sys_stat64
+196	common	lstat64				sys_lstat64
+197	common	fstat64				sys_fstat64
+198	common	chown32				sys_chown
+199	common	getuid32			sys_getuid
+200	common	getgid32			sys_getgid
+201	common	geteuid32			sys_geteuid
+202	common	getegid32			sys_getegid
+203	common	setreuid32			sys_setreuid
+204	common	setregid32			sys_setregid
+205	common	getgroups32			sys_getgroups
+206	common	setgroups32			sys_setgroups
+207	common	fchown32			sys_fchown
+208	common	setresuid32			sys_setresuid
+209	common	getresuid32			sys_getresuid
+210	common	setresgid32			sys_setresgid
+211	common	getresgid32			sys_getresgid
+212	common	lchown32			sys_lchown
+213	common	setuid32			sys_setuid
+214	common	setgid32			sys_setgid
+215	common	setfsuid32			sys_setfsuid
+216	common	setfsgid32			sys_setfsgid
+217	common	pivot_root			sys_pivot_root
+# 218 is reserved
+# 219 is reserved
+220	common	getdents64			sys_getdents64
+221	common	gettid				sys_gettid
+222	common	tkill				sys_tkill
+223	common	setxattr			sys_setxattr
+224	common	lsetxattr			sys_lsetxattr
+225	common	fsetxattr			sys_fsetxattr
+226	common	getxattr			sys_getxattr
+227	common	lgetxattr			sys_lgetxattr
+228	common	fgetxattr			sys_fgetxattr
+229	common	listxattr			sys_listxattr
+230	common	llistxattr			sys_llistxattr
+231	common	flistxattr			sys_flistxattr
+232	common	removexattr			sys_removexattr
+233	common	lremovexattr			sys_lremovexattr
+234	common	fremovexattr			sys_fremovexattr
+235	common	futex				sys_futex_time32
+236	common	sendfile64			sys_sendfile64
+237	common	mincore				sys_mincore
+238	common	madvise				sys_madvise
+239	common	fcntl64				sys_fcntl64
+240	common	readahead			sys_readahead
+241	common	io_setup			sys_io_setup
+242	common	io_destroy			sys_io_destroy
+243	common	io_getevents			sys_io_getevents_time32
+244	common	io_submit			sys_io_submit
+245	common	io_cancel			sys_io_cancel
+246	common	fadvise64			sys_fadvise64
+247	common	exit_group			sys_exit_group
+248	common	lookup_dcookie			sys_lookup_dcookie
+249	common	epoll_create			sys_epoll_create
+250	common	epoll_ctl			sys_epoll_ctl
+251	common	epoll_wait			sys_epoll_wait
+252	common	remap_file_pages		sys_remap_file_pages
+253	common	set_tid_address			sys_set_tid_address
+254	common	timer_create			sys_timer_create
+255	common	timer_settime			sys_timer_settime32
+256	common	timer_gettime			sys_timer_gettime32
+257	common	timer_getoverrun		sys_timer_getoverrun
+258	common	timer_delete			sys_timer_delete
+259	common	clock_settime			sys_clock_settime32
+260	common	clock_gettime			sys_clock_gettime32
+261	common	clock_getres			sys_clock_getres_time32
+262	common	clock_nanosleep			sys_clock_nanosleep_time32
+263	common	statfs64			sys_statfs64
+264	common	fstatfs64			sys_fstatfs64
+265	common	tgkill				sys_tgkill
+266	common	utimes				sys_utimes_time32
+267	common	fadvise64_64			sys_fadvise64_64
+268	common	mbind				sys_mbind
+269	common	get_mempolicy			sys_get_mempolicy
+270	common	set_mempolicy			sys_set_mempolicy
+271	common	mq_open				sys_mq_open
+272	common	mq_unlink			sys_mq_unlink
+273	common	mq_timedsend			sys_mq_timedsend_time32
+274	common	mq_timedreceive			sys_mq_timedreceive_time32
+275	common	mq_notify			sys_mq_notify
+276	common	mq_getsetattr			sys_mq_getsetattr
+277	common	waitid				sys_waitid
+# 278 was vserver
+279	common	add_key				sys_add_key
+280	common	request_key			sys_request_key
+281	common	keyctl				sys_keyctl
+282	common	ioprio_set			sys_ioprio_set
+283	common	ioprio_get			sys_ioprio_get
+284	common	inotify_init			sys_inotify_init
+285	common	inotify_add_watch		sys_inotify_add_watch
+286	common	inotify_rm_watch		sys_inotify_rm_watch
+287	common	migrate_pages			sys_migrate_pages
+288	common	openat				sys_openat
+289	common	mkdirat				sys_mkdirat
+290	common	mknodat				sys_mknodat
+291	common	fchownat			sys_fchownat
+292	common	futimesat			sys_futimesat_time32
+293	common	fstatat64			sys_fstatat64
+294	common	unlinkat			sys_unlinkat
+295	common	renameat			sys_renameat
+296	common	linkat				sys_linkat
+297	common	symlinkat			sys_symlinkat
+298	common	readlinkat			sys_readlinkat
+299	common	fchmodat			sys_fchmodat
+300	common	faccessat			sys_faccessat
+301	common	pselect6			sys_pselect6_time32
+302	common	ppoll				sys_ppoll_time32
+303	common	unshare				sys_unshare
+304	common	set_robust_list			sys_set_robust_list
+305	common	get_robust_list			sys_get_robust_list
+306	common	splice				sys_splice
+307	common	sync_file_range			sys_sync_file_range
+308	common	tee				sys_tee
+309	common	vmsplice			sys_vmsplice
+310	common	move_pages			sys_move_pages
+311	common	sched_setaffinity		sys_sched_setaffinity
+312	common	sched_getaffinity		sys_sched_getaffinity
+313	common	kexec_load			sys_kexec_load
+314	common	getcpu				sys_getcpu
+315	common	epoll_pwait			sys_epoll_pwait
+316	common	utimensat			sys_utimensat_time32
+317	common	signalfd			sys_signalfd
+318	common	timerfd_create			sys_timerfd_create
+319	common	eventfd				sys_eventfd
+320	common	fallocate			sys_fallocate
+321	common	timerfd_settime			sys_timerfd_settime32
+322	common	timerfd_gettime			sys_timerfd_gettime32
+323	common	signalfd4			sys_signalfd4
+324	common	eventfd2			sys_eventfd2
+325	common	epoll_create1			sys_epoll_create1
+326	common	dup3				sys_dup3
+327	common	pipe2				sys_pipe2
+328	common	inotify_init1			sys_inotify_init1
+329	common	preadv				sys_preadv
+330	common	pwritev				sys_pwritev
+331	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
+332	common	perf_event_open			sys_perf_event_open
+333	common	get_thread_area			sys_get_thread_area
+334	common	set_thread_area			sys_set_thread_area
+335	common	atomic_cmpxchg_32		sys_atomic_cmpxchg_32
+336	common	atomic_barrier			sys_atomic_barrier
+337	common	fanotify_init			sys_fanotify_init
+338	common	fanotify_mark			sys_fanotify_mark
+339	common	prlimit64			sys_prlimit64
+340	common	name_to_handle_at		sys_name_to_handle_at
+341	common	open_by_handle_at		sys_open_by_handle_at
+342	common	clock_adjtime			sys_clock_adjtime32
+343	common	syncfs				sys_syncfs
+344	common	setns				sys_setns
+345	common	process_vm_readv		sys_process_vm_readv
+346	common	process_vm_writev		sys_process_vm_writev
+347	common	kcmp				sys_kcmp
+348	common	finit_module			sys_finit_module
+349	common	sched_setattr			sys_sched_setattr
+350	common	sched_getattr			sys_sched_getattr
+351	common	renameat2			sys_renameat2
+352	common	getrandom			sys_getrandom
+353	common	memfd_create			sys_memfd_create
+354	common	bpf				sys_bpf
+355	common	execveat			sys_execveat
+356	common	socket				sys_socket
+357	common	socketpair			sys_socketpair
+358	common	bind				sys_bind
+359	common	connect				sys_connect
+360	common	listen				sys_listen
+361	common	accept4				sys_accept4
+362	common	getsockopt			sys_getsockopt
+363	common	setsockopt			sys_setsockopt
+364	common	getsockname			sys_getsockname
+365	common	getpeername			sys_getpeername
+366	common	sendto				sys_sendto
+367	common	sendmsg				sys_sendmsg
+368	common	recvfrom			sys_recvfrom
+369	common	recvmsg				sys_recvmsg
+370	common	shutdown			sys_shutdown
+371	common	recvmmsg			sys_recvmmsg_time32
+372	common	sendmmsg			sys_sendmmsg
+373	common	userfaultfd			sys_userfaultfd
+374	common	membarrier			sys_membarrier
+375	common	mlock2				sys_mlock2
+376	common	copy_file_range			sys_copy_file_range
+377	common	preadv2				sys_preadv2
+378	common	pwritev2			sys_pwritev2
+379	common	statx				sys_statx
+380	common	seccomp				sys_seccomp
+381	common	pkey_mprotect			sys_pkey_mprotect
+382	common	pkey_alloc			sys_pkey_alloc
+383	common	pkey_free			sys_pkey_free
+384	common	rseq				sys_rseq
+# room for arch specific calls
+393	common	semget				sys_semget
+394	common	semctl				sys_semctl
+395	common	shmget				sys_shmget
+396	common	shmctl				sys_shmctl
+397	common	shmat				sys_shmat
+398	common	shmdt				sys_shmdt
+399	common	msgget				sys_msgget
+400	common	msgsnd				sys_msgsnd
+401	common	msgrcv				sys_msgrcv
+402	common	msgctl				sys_msgctl
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceive_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
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
diff --git a/linux-user/m68k/syscall_nr.h b/linux-user/m68k/syscall_nr.h
deleted file mode 100644
index 01aee343a9b2..000000000000
--- a/linux-user/m68k/syscall_nr.h
+++ /dev/null
@@ -1,434 +0,0 @@
-/*
- * This file contains the system call numbers.
- */
-
-#ifndef LINUX_USER_M68K_SYSCALL_NR_H
-#define LINUX_USER_M68K_SYSCALL_NR_H
-
-#define TARGET_NR_exit                 1
-#define TARGET_NR_fork                 2
-#define TARGET_NR_read                 3
-#define TARGET_NR_write                4
-#define TARGET_NR_open                 5
-#define TARGET_NR_close                6
-#define TARGET_NR_waitpid              7
-#define TARGET_NR_creat                8
-#define TARGET_NR_link                 9
-#define TARGET_NR_unlink              10
-#define TARGET_NR_execve              11
-#define TARGET_NR_chdir               12
-#define TARGET_NR_time                13
-#define TARGET_NR_mknod               14
-#define TARGET_NR_chmod               15
-#define TARGET_NR_chown               16
-#define TARGET_NR_break               17
-#define TARGET_NR_oldstat             18
-#define TARGET_NR_lseek               19
-#define TARGET_NR_getpid              20
-#define TARGET_NR_mount               21
-#define TARGET_NR_umount              22
-#define TARGET_NR_setuid              23
-#define TARGET_NR_getuid              24
-#define TARGET_NR_stime               25
-#define TARGET_NR_ptrace              26
-#define TARGET_NR_alarm               27
-#define TARGET_NR_oldfstat            28
-#define TARGET_NR_pause               29
-#define TARGET_NR_utime               30
-#define TARGET_NR_stty                31
-#define TARGET_NR_gtty                32
-#define TARGET_NR_access              33
-#define TARGET_NR_nice                34
-#define TARGET_NR_ftime               35
-#define TARGET_NR_sync                36
-#define TARGET_NR_kill                37
-#define TARGET_NR_rename              38
-#define TARGET_NR_mkdir               39
-#define TARGET_NR_rmdir               40
-#define TARGET_NR_dup                 41
-#define TARGET_NR_pipe                42
-#define TARGET_NR_times               43
-#define TARGET_NR_prof                44
-#define TARGET_NR_brk                 45
-#define TARGET_NR_setgid              46
-#define TARGET_NR_getgid              47
-#define TARGET_NR_signal              48
-#define TARGET_NR_geteuid             49
-#define TARGET_NR_getegid             50
-#define TARGET_NR_acct                51
-#define TARGET_NR_umount2             52
-#define TARGET_NR_lock                53
-#define TARGET_NR_ioctl               54
-#define TARGET_NR_fcntl               55
-#define TARGET_NR_mpx                 56
-#define TARGET_NR_setpgid             57
-#define TARGET_NR_ulimit              58
-#define TARGET_NR_oldolduname         59
-#define TARGET_NR_umask               60
-#define TARGET_NR_chroot              61
-#define TARGET_NR_ustat               62
-#define TARGET_NR_dup2                63
-#define TARGET_NR_getppid             64
-#define TARGET_NR_getpgrp             65
-#define TARGET_NR_setsid              66
-#define TARGET_NR_sigaction           67
-#define TARGET_NR_sgetmask            68
-#define TARGET_NR_ssetmask            69
-#define TARGET_NR_setreuid            70
-#define TARGET_NR_setregid            71
-#define TARGET_NR_sigsuspend          72
-#define TARGET_NR_sigpending          73
-#define TARGET_NR_sethostname         74
-#define TARGET_NR_setrlimit           75
-#define TARGET_NR_getrlimit           76
-#define TARGET_NR_getrusage           77
-#define TARGET_NR_gettimeofday        78
-#define TARGET_NR_settimeofday        79
-#define TARGET_NR_getgroups           80
-#define TARGET_NR_setgroups           81
-#define TARGET_NR_select              82
-#define TARGET_NR_symlink             83
-#define TARGET_NR_oldlstat            84
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
-#define TARGET_NR_fchown              95
-#define TARGET_NR_getpriority         96
-#define TARGET_NR_setpriority         97
-#define TARGET_NR_profil              98
-#define TARGET_NR_statfs              99
-#define TARGET_NR_fstatfs            100
-#define TARGET_NR_ioperm             101
-#define TARGET_NR_socketcall         102
-#define TARGET_NR_syslog             103
-#define TARGET_NR_setitimer          104
-#define TARGET_NR_getitimer          105
-#define TARGET_NR_stat               106
-#define TARGET_NR_lstat              107
-#define TARGET_NR_fstat              108
-#define TARGET_NR_olduname           109
-//#define TARGET_NR_iopl               /* 110 */ not supported
-#define TARGET_NR_vhangup            111
-//#define TARGET_NR_idle               /* 112 */ Obsolete
-//#define TARGET_NR_vm86               /* 113 */ not supported
-#define TARGET_NR_wait4              114
-#define TARGET_NR_swapoff            115
-#define TARGET_NR_sysinfo            116
-#define TARGET_NR_ipc                117
-#define TARGET_NR_fsync              118
-#define TARGET_NR_sigreturn          119
-#define TARGET_NR_clone              120
-#define TARGET_NR_setdomainname      121
-#define TARGET_NR_uname              122
-#define TARGET_NR_cacheflush         123
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
-#define TARGET_NR_setfsuid           138
-#define TARGET_NR_setfsgid           139
-#define TARGET_NR__llseek            140
-#define TARGET_NR_getdents           141
-#define TARGET_NR__newselect         142
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
-#define TARGET_NR_setresuid          164
-#define TARGET_NR_getresuid          165
-#define TARGET_NR_getpagesize        166
-#define TARGET_NR_query_module       167
-#define TARGET_NR_poll               168
-#define TARGET_NR_nfsservctl         169
-#define TARGET_NR_setresgid          170
-#define TARGET_NR_getresgid          171
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
-#define TARGET_NR_lchown             182
-#define TARGET_NR_getcwd             183
-#define TARGET_NR_capget             184
-#define TARGET_NR_capset             185
-#define TARGET_NR_sigaltstack        186
-#define TARGET_NR_sendfile           187
-#define TARGET_NR_getpmsg            188     /* some people actually want streams */
-#define TARGET_NR_putpmsg            189     /* some people actually want streams */
-#define TARGET_NR_vfork              190
-#define TARGET_NR_ugetrlimit         191
-#define TARGET_NR_mmap2              192
-#define TARGET_NR_truncate64         193
-#define TARGET_NR_ftruncate64        194
-#define TARGET_NR_stat64             195
-#define TARGET_NR_lstat64            196
-#define TARGET_NR_fstat64            197
-#define TARGET_NR_chown32            198
-#define TARGET_NR_getuid32           199
-#define TARGET_NR_getgid32           200
-#define TARGET_NR_geteuid32          201
-#define TARGET_NR_getegid32          202
-#define TARGET_NR_setreuid32         203
-#define TARGET_NR_setregid32         204
-#define TARGET_NR_getgroups32        205
-#define TARGET_NR_setgroups32        206
-#define TARGET_NR_fchown32           207
-#define TARGET_NR_setresuid32        208
-#define TARGET_NR_getresuid32        209
-#define TARGET_NR_setresgid32        210
-#define TARGET_NR_getresgid32        211
-#define TARGET_NR_lchown32           212
-#define TARGET_NR_setuid32           213
-#define TARGET_NR_setgid32           214
-#define TARGET_NR_setfsuid32         215
-#define TARGET_NR_setfsgid32         216
-#define TARGET_NR_pivot_root         217
-#define TARGET_NR_getdents64         220
-#define TARGET_NR_gettid             221
-#define TARGET_NR_tkill              222
-#define TARGET_NR_setxattr           223
-#define TARGET_NR_lsetxattr          224
-#define TARGET_NR_fsetxattr          225
-#define TARGET_NR_getxattr           226
-#define TARGET_NR_lgetxattr          227
-#define TARGET_NR_fgetxattr          228
-#define TARGET_NR_listxattr          229
-#define TARGET_NR_llistxattr         230
-#define TARGET_NR_flistxattr         231
-#define TARGET_NR_removexattr        232
-#define TARGET_NR_lremovexattr       233
-#define TARGET_NR_fremovexattr       234
-#define TARGET_NR_futex              235
-#define TARGET_NR_sendfile64         236
-#define TARGET_NR_mincore            237
-#define TARGET_NR_madvise            238
-#define TARGET_NR_fcntl64            239
-#define TARGET_NR_readahead          240
-#define TARGET_NR_io_setup           241
-#define TARGET_NR_io_destroy         242
-#define TARGET_NR_io_getevents       243
-#define TARGET_NR_io_submit          244
-#define TARGET_NR_io_cancel          245
-#define TARGET_NR_fadvise64          246
-#define TARGET_NR_exit_group         247
-#define TARGET_NR_lookup_dcookie     248
-#define TARGET_NR_epoll_create       249
-#define TARGET_NR_epoll_ctl          250
-#define TARGET_NR_epoll_wait         251
-#define TARGET_NR_remap_file_pages   252
-#define TARGET_NR_set_tid_address    253
-#define TARGET_NR_timer_create       254
-#define TARGET_NR_timer_settime      255
-#define TARGET_NR_timer_gettime      256
-#define TARGET_NR_timer_getoverrun   257
-#define TARGET_NR_timer_delete       258
-#define TARGET_NR_clock_settime      259
-#define TARGET_NR_clock_gettime      260
-#define TARGET_NR_clock_getres       261
-#define TARGET_NR_clock_nanosleep    262
-#define TARGET_NR_statfs64           263
-#define TARGET_NR_fstatfs64          264
-#define TARGET_NR_tgkill             265
-#define TARGET_NR_utimes             266
-#define TARGET_NR_fadvise64_64       267
-#define TARGET_NR_mbind              268
-#define TARGET_NR_get_mempolicy      269
-#define TARGET_NR_set_mempolicy      270
-#define TARGET_NR_mq_open            271
-#define TARGET_NR_mq_unlink          272
-#define TARGET_NR_mq_timedsend       273
-#define TARGET_NR_mq_timedreceive    274
-#define TARGET_NR_mq_notify          275
-#define TARGET_NR_mq_getsetattr      276
-#define TARGET_NR_waitid             277
-#define TARGET_NR_vserver            278
-#define TARGET_NR_add_key            279
-#define TARGET_NR_request_key        280
-#define TARGET_NR_keyctl             281
-#define TARGET_NR_ioprio_set		282
-#define TARGET_NR_ioprio_get		283
-#define TARGET_NR_inotify_init	284
-#define TARGET_NR_inotify_add_watch	285
-#define TARGET_NR_inotify_rm_watch	286
-#define TARGET_NR_migrate_pages	287
-#define TARGET_NR_openat		288
-#define TARGET_NR_mkdirat		289
-#define TARGET_NR_mknodat		290
-#define TARGET_NR_fchownat		291
-#define TARGET_NR_futimesat		292
-#define TARGET_NR_fstatat64		293
-#define TARGET_NR_unlinkat		294
-#define TARGET_NR_renameat		295
-#define TARGET_NR_linkat		296
-#define TARGET_NR_symlinkat		297
-#define TARGET_NR_readlinkat		298
-#define TARGET_NR_fchmodat		299
-#define TARGET_NR_faccessat		300
-#define TARGET_NR_pselect6		301
-#define TARGET_NR_ppoll		302
-#define TARGET_NR_unshare		303
-#define TARGET_NR_set_robust_list	304
-#define TARGET_NR_get_robust_list	305
-#define TARGET_NR_splice		306
-#define TARGET_NR_sync_file_range	307
-#define TARGET_NR_tee		308
-#define TARGET_NR_vmsplice		309
-#define TARGET_NR_move_pages		310
-#define TARGET_NR_sched_setaffinity	311
-#define TARGET_NR_sched_getaffinity	312
-#define TARGET_NR_kexec_load		313
-#define TARGET_NR_getcpu		314
-#define TARGET_NR_epoll_pwait	315
-#define TARGET_NR_utimensat		316
-#define TARGET_NR_signalfd		317
-#define TARGET_NR_timerfd_create	318
-#define TARGET_NR_eventfd		319
-#define TARGET_NR_fallocate		320
-#define TARGET_NR_timerfd_settime	321
-#define TARGET_NR_timerfd_gettime	322
-#define TARGET_NR_signalfd4		323
-#define TARGET_NR_eventfd2		324
-#define TARGET_NR_epoll_create1	325
-#define TARGET_NR_dup3			326
-#define TARGET_NR_pipe2		327
-#define TARGET_NR_inotify_init1	328
-#define TARGET_NR_inotify_init1         328
-#define TARGET_NR_preadv                329
-#define TARGET_NR_pwritev               330
-#define TARGET_NR_rt_tgsigqueueinfo     331
-#define TARGET_NR_perf_event_open       332
-#define TARGET_NR_get_thread_area       333
-#define TARGET_NR_set_thread_area       334
-#define TARGET_NR_atomic_cmpxchg_32     335
-#define TARGET_NR_atomic_barrier        336
-#define TARGET_NR_fanotify_init         337
-#define TARGET_NR_fanotify_mark         338
-#define TARGET_NR_prlimit64             339
-#define TARGET_NR_name_to_handle_at     340
-#define TARGET_NR_open_by_handle_at     341
-#define TARGET_NR_clock_adjtime         342
-#define TARGET_NR_syncfs                343
-#define TARGET_NR_setns                 344
-#define TARGET_NR_process_vm_readv      345
-#define TARGET_NR_process_vm_writev     346
-#define TARGET_NR_kcmp                  347
-#define TARGET_NR_finit_module          348
-#define TARGET_NR_sched_setattr         349
-#define TARGET_NR_sched_getattr         350
-#define TARGET_NR_renameat2             351
-#define TARGET_NR_getrandom             352
-#define TARGET_NR_memfd_create          353
-#define TARGET_NR_bpf                   354
-#define TARGET_NR_execveat              355
-#define TARGET_NR_socket                356
-#define TARGET_NR_socketpair            357
-#define TARGET_NR_bind                  358
-#define TARGET_NR_connect               359
-#define TARGET_NR_listen                360
-#define TARGET_NR_accept4               361
-#define TARGET_NR_getsockopt            362
-#define TARGET_NR_setsockopt            363
-#define TARGET_NR_getsockname           364
-#define TARGET_NR_getpeername           365
-#define TARGET_NR_sendto                366
-#define TARGET_NR_sendmsg               367
-#define TARGET_NR_recvfrom              368
-#define TARGET_NR_recvmsg               369
-#define TARGET_NR_shutdown              370
-#define TARGET_NR_recvmmsg              371
-#define TARGET_NR_sendmmsg              372
-#define TARGET_NR_userfaultfd           373
-#define TARGET_NR_membarrier            374
-#define TARGET_NR_mlock2                375
-#define TARGET_NR_copy_file_range       376
-#define TARGET_NR_preadv2               377
-#define TARGET_NR_pwritev2              378
-#define TARGET_NR_statx                 379
-#define TARGET_NR_seccomp               380
-#define TARGET_NR_pkey_mprotect         381
-#define TARGET_NR_pkey_alloc            382
-#define TARGET_NR_pkey_free             383
-#define TARGET_NR_rseq                  384
-/* room for arch specific calls */
-#define TARGET_NR_semget                393
-#define TARGET_NR_semctl                394
-#define TARGET_NR_shmget                395
-#define TARGET_NR_shmctl                396
-#define TARGET_NR_shmat                 397
-#define TARGET_NR_shmdt                 398
-#define TARGET_NR_msgget                399
-#define TARGET_NR_msgsnd                400
-#define TARGET_NR_msgrcv                401
-#define TARGET_NR_msgctl                402
-#define TARGET_NR_clock_gettime64       403
-#define TARGET_NR_clock_settime64       404
-#define TARGET_NR_clock_adjtime64       405
-#define TARGET_NR_clock_getres_time64   406
-#define TARGET_NR_clock_nanosleep_time64 407
-#define TARGET_NR_timer_gettime64       408
-#define TARGET_NR_timer_settime64       409
-#define TARGET_NR_timerfd_gettime64     410
-#define TARGET_NR_timerfd_settime64     411
-#define TARGET_NR_utimensat_time64      412
-#define TARGET_NR_pselect6_time64       413
-#define TARGET_NR_ppoll_time64          414
-#define TARGET_NR_io_pgetevents_time64  416
-#define TARGET_NR_recvmmsg_time64       417
-#define TARGET_NR_mq_timedsend_time64   418
-#define TARGET_NR_mq_timedreceive_time64 419
-#define TARGET_NR_semtimedop_time64     420
-#define TARGET_NR_rt_sigtimedwait_time64 421
-#define TARGET_NR_futex_time64          422
-#define TARGET_NR_sched_rr_get_interval_time64 423
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
-/* 435 reserved for clone3 */
-#endif
diff --git a/linux-user/m68k/syscallhdr.sh b/linux-user/m68k/syscallhdr.sh
new file mode 100644
index 000000000000..eeb4d01d34d3
--- /dev/null
+++ b/linux-user/m68k/syscallhdr.sh
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
+fileguard=LINUX_USER_M68K_`basename "$out" | sed \
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


