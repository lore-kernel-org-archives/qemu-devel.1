Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8338EC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3660120674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3660120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtyk-00059Z-AB
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsPw-0007zQ-MM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsPr-0002Kg-VM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:40 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34391)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsPr-00027u-E8
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:35 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MMp08-1ivF4I2sUu-00InFr; Mon, 16 Mar 2020 17:16:27 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 20/38] linux-user,
 microblaze: add syscall table generation support
Date: Mon, 16 Mar 2020 17:15:32 +0100
Message-Id: <20200316161550.336150-21-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nAmzUaZY1Su05hFak/rWKI29ANgcxLdDyQiOpTejDLt7m30fmsV
 U94PBixfvdH3Ozuz13e405OzmszLtPWZeoYW7wWFgAdSfr9HXX98WYVeV7eWluZ5PVWDt9J
 iCR8R6fVLhvN2kdoQyHa+++bXcHvP3Ss0nAdeaRmm1wlnyp/YW3J9HD7C9eaBUqH63Y1U5q
 zFbul8jY8d+PgymtQRKnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:huT3VDhcIKg=:nUWxYFsAivf/azjOw8q5tw
 8pf3LxyZgjS4Wa32IAJ6R5eQfnYD0piv09/yOMSyH4xO6ikoPFgcYF+NzLzJ9gJy0ya8cL3ZY
 7uBLJwIg1tU9JHo6Kk2W46OeBjdPiCR1y1Dc7AFk2VTVjbd6P0MgqvAE4HX4CKfXAZxnHWSLK
 Zw9sa6mWfrrLuguGg+4j4rtmV7sK4achQJR+T7VVk6ujbY9mlt0EF1apwJ7/WEyn9cU2GC/DK
 VL+S1m+WVB8s2ug/1wWM+/br0L1UFD511ljSV2cXD0+JPscaBUECwwfsJSr0RvqTZrMHcUkwg
 GJrqFUkF/T5uldbLY9qYmRL+QAsMU1oWs2BFbisgWPnQoV0VYBi7voWe/aIHUOgNwYn8BW47h
 6lVnGcPIaURQNJxvNk2bk+NBQaPsCsoK9lZ3wlMK6x+azMq6c0zkG7loesAd00GKBhPKgUGkW
 +wUYPIubFUqRl3bX98U76NFrPl0W8w/SDiJ1XyujMrFoUnZhyjdxactIxpNLeeZ3V9LBezvRl
 oIMzchkTbB4sohJkEBSfpZVB/sTfgxcEkcrVRahoMCxkIYHvGUB0LBxNfWW/Fj13Gxt1Oza80
 dkS7cQgcgytrulGMzCFfozKx6uQhvGIad4x5D60cBY4bxT6sxLjipej6kBMuUoi2+AikLwZnp
 p3C9GFl5hPTl4861hBenFCTFivC9CFa1pB2VBEtdMEM0y00vIGDUn7IQ/lISLioVZ1YHQyJgJ
 t9NQiaPtVzPbh5mecWrlThxVsP56KLeTErtl0UmPU+lGPXijZVqlql23IDrJfbBZhZ3+WDsE9
 REtmTo8Kh+R2z+Y8aAEPbn4dNRC4pe8AIKfd8SyslGjFA/bBXuwtznVDKwZsf3reSefU/J+
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Copy syscall.tbl and syscallhdr.sh from linux/arch/microblaze/kernel/syscalls v5.5
Update syscallhdr.sh to generate QEMU syscall_nr.h

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-8-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                           |   3 +-
 linux-user/Makefile.objs            |   1 +
 linux-user/microblaze/Makefile.objs |   5 +
 linux-user/microblaze/syscall.tbl   | 443 ++++++++++++++++++++++++++++
 linux-user/microblaze/syscall_nr.h  | 442 ---------------------------
 linux-user/microblaze/syscallhdr.sh |  32 ++
 6 files changed, 483 insertions(+), 443 deletions(-)
 create mode 100644 linux-user/microblaze/Makefile.objs
 create mode 100644 linux-user/microblaze/syscall.tbl
 delete mode 100644 linux-user/microblaze/syscall_nr.h
 create mode 100644 linux-user/microblaze/syscallhdr.sh

diff --git a/configure b/configure
index 62f5bb601b75..720bb5a96c62 100755
--- a/configure
+++ b/configure
@@ -1889,7 +1889,7 @@ rm -f */config-devices.mak.d
 
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
-for arch in alpha hppa m68k xtensa sh4 ; do
+for arch in alpha hppa m68k xtensa sh4 microblaze ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
@@ -7825,6 +7825,7 @@ case "$target_name" in
   ;;
   microblaze|microblazeel)
     TARGET_ARCH=microblaze
+    TARGET_SYSTBL_ABI=common
     bflt="yes"
     echo "TARGET_ABI32=y" >> $config_target_mak
   ;;
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index d31f30d75851..5a26281e8867 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -12,5 +12,6 @@ obj-$(TARGET_AARCH64) += arm/semihost.o
 obj-$(TARGET_ALPHA) += alpha/
 obj-$(TARGET_HPPA) += hppa/
 obj-$(TARGET_M68K) += m68k/
+obj-$(TARGET_MICROBLAZE) += microblaze/
 obj-$(TARGET_SH4) += sh4/
 obj-$(TARGET_XTENSA) += xtensa/
diff --git a/linux-user/microblaze/Makefile.objs b/linux-user/microblaze/Makefile.objs
new file mode 100644
index 000000000000..bb8b318dda7f
--- /dev/null
+++ b/linux-user/microblaze/Makefile.objs
@@ -0,0 +1,5 @@
+generated-files-y += linux-user/microblaze/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/microblaze/syscallhdr.sh
+%/syscall_nr.h: $(SRC_PATH)/linux-user/microblaze/syscall.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/microblaze/syscall.tbl b/linux-user/microblaze/syscall.tbl
new file mode 100644
index 000000000000..09b0cd7dab0a
--- /dev/null
+++ b/linux-user/microblaze/syscall.tbl
@@ -0,0 +1,443 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for microblaze
+#
+# The format is:
+# <number> <abi> <name> <entry point>
+#
+# The <abi> is always "common" for this file
+#
+0	common	restart_syscall			sys_restart_syscall
+1	common	exit				sys_exit
+2	common	fork				sys_fork
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
+16	common	lchown				sys_lchown
+17	common	break				sys_ni_syscall
+18	common	oldstat				sys_ni_syscall
+19	common	lseek				sys_lseek
+20	common	getpid				sys_getpid
+21	common	mount				sys_mount
+22	common	umount				sys_oldumount
+23	common	setuid				sys_setuid
+24	common	getuid				sys_getuid
+25	common	stime				sys_stime32
+26	common	ptrace				sys_ptrace
+27	common	alarm				sys_alarm
+28	common	oldfstat			sys_ni_syscall
+29	common	pause				sys_pause
+30	common	utime				sys_utime32
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
+43	common	times				sys_times
+44	common	prof				sys_ni_syscall
+45	common	brk				sys_brk
+46	common	setgid				sys_setgid
+47	common	getgid				sys_getgid
+48	common	signal				sys_signal
+49	common	geteuid				sys_geteuid
+50	common	getegid				sys_getegid
+51	common	acct				sys_acct
+52	common	umount2				sys_umount
+53	common	lock				sys_ni_syscall
+54	common	ioctl				sys_ioctl
+55	common	fcntl				sys_fcntl
+56	common	mpx				sys_ni_syscall
+57	common	setpgid				sys_setpgid
+58	common	ulimit				sys_ni_syscall
+59	common	oldolduname			sys_ni_syscall
+60	common	umask				sys_umask
+61	common	chroot				sys_chroot
+62	common	ustat				sys_ustat
+63	common	dup2				sys_dup2
+64	common	getppid				sys_getppid
+65	common	getpgrp				sys_getpgrp
+66	common	setsid				sys_setsid
+67	common	sigaction			sys_ni_syscall
+68	common	sgetmask			sys_sgetmask
+69	common	ssetmask			sys_ssetmask
+70	common	setreuid			sys_setreuid
+71	common	setregid			sys_setregid
+72	common	sigsuspend			sys_ni_syscall
+73	common	sigpending			sys_sigpending
+74	common	sethostname			sys_sethostname
+75	common	setrlimit			sys_setrlimit
+76	common	getrlimit			sys_ni_syscall
+77	common	getrusage			sys_getrusage
+78	common	gettimeofday			sys_gettimeofday
+79	common	settimeofday			sys_settimeofday
+80	common	getgroups			sys_getgroups
+81	common	setgroups			sys_setgroups
+82	common	select				sys_ni_syscall
+83	common	symlink				sys_symlink
+84	common	oldlstat			sys_ni_syscall
+85	common	readlink			sys_readlink
+86	common	uselib				sys_uselib
+87	common	swapon				sys_swapon
+88	common	reboot				sys_reboot
+89	common	readdir				sys_ni_syscall
+90	common	mmap				sys_mmap
+91	common	munmap				sys_munmap
+92	common	truncate			sys_truncate
+93	common	ftruncate			sys_ftruncate
+94	common	fchmod				sys_fchmod
+95	common	fchown				sys_fchown
+96	common	getpriority			sys_getpriority
+97	common	setpriority			sys_setpriority
+98	common	profil				sys_ni_syscall
+99	common	statfs				sys_statfs
+100	common	fstatfs				sys_fstatfs
+101	common	ioperm				sys_ni_syscall
+102	common	socketcall			sys_socketcall
+103	common	syslog				sys_syslog
+104	common	setitimer			sys_setitimer
+105	common	getitimer			sys_getitimer
+106	common	stat				sys_newstat
+107	common	lstat				sys_newlstat
+108	common	fstat				sys_newfstat
+109	common	olduname			sys_ni_syscall
+110	common	iopl				sys_ni_syscall
+111	common	vhangup				sys_vhangup
+112	common	idle				sys_ni_syscall
+113	common	vm86old				sys_ni_syscall
+114	common	wait4				sys_wait4
+115	common	swapoff				sys_swapoff
+116	common	sysinfo				sys_sysinfo
+117	common	ipc				sys_ni_syscall
+118	common	fsync				sys_fsync
+119	common	sigreturn			sys_ni_syscall
+120	common	clone				sys_clone
+121	common	setdomainname			sys_setdomainname
+122	common	uname				sys_newuname
+123	common	modify_ldt			sys_ni_syscall
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
+137	common	afs_syscall			sys_ni_syscall
+138	common	setfsuid			sys_setfsuid
+139	common	setfsgid			sys_setfsgid
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
+164	common	setresuid			sys_setresuid
+165	common	getresuid			sys_getresuid
+166	common	vm86				sys_ni_syscall
+167	common	query_module			sys_ni_syscall
+168	common	poll				sys_poll
+169	common	nfsservctl			sys_ni_syscall
+170	common	setresgid			sys_setresgid
+171	common	getresgid			sys_getresgid
+172	common	prctl				sys_prctl
+173	common	rt_sigreturn			sys_rt_sigreturn_wrapper
+174	common	rt_sigaction			sys_rt_sigaction
+175	common	rt_sigprocmask			sys_rt_sigprocmask
+176	common	rt_sigpending			sys_rt_sigpending
+177	common	rt_sigtimedwait			sys_rt_sigtimedwait_time32
+178	common	rt_sigqueueinfo			sys_rt_sigqueueinfo
+179	common	rt_sigsuspend			sys_rt_sigsuspend
+180	common	pread64				sys_pread64
+181	common	pwrite64			sys_pwrite64
+182	common	chown				sys_chown
+183	common	getcwd				sys_getcwd
+184	common	capget				sys_capget
+185	common	capset				sys_capset
+186	common	sigaltstack			sys_ni_syscall
+187	common	sendfile			sys_sendfile
+188	common	getpmsg				sys_ni_syscall
+189	common	putpmsg				sys_ni_syscall
+190	common	vfork				sys_vfork
+191	common	ugetrlimit			sys_getrlimit
+192	common	mmap2				sys_mmap2
+193	common	truncate64			sys_truncate64
+194	common	ftruncate64			sys_ftruncate64
+195	common	stat64				sys_stat64
+196	common	lstat64				sys_lstat64
+197	common	fstat64				sys_fstat64
+198	common	lchown32			sys_lchown
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
+212	common	chown32				sys_chown
+213	common	setuid32			sys_setuid
+214	common	setgid32			sys_setgid
+215	common	setfsuid32			sys_setfsuid
+216	common	setfsgid32			sys_setfsgid
+217	common	pivot_root			sys_pivot_root
+218	common	mincore				sys_mincore
+219	common	madvise				sys_madvise
+220	common	getdents64			sys_getdents64
+221	common	fcntl64				sys_fcntl64
+# 222 is reserved for TUX
+# 223 is unused
+224	common	gettid				sys_gettid
+225	common	readahead			sys_readahead
+226	common	setxattr			sys_setxattr
+227	common	lsetxattr			sys_lsetxattr
+228	common	fsetxattr			sys_fsetxattr
+229	common	getxattr			sys_getxattr
+230	common	lgetxattr			sys_lgetxattr
+231	common	fgetxattr			sys_fgetxattr
+232	common	listxattr			sys_listxattr
+233	common	llistxattr			sys_llistxattr
+234	common	flistxattr			sys_flistxattr
+235	common	removexattr			sys_removexattr
+236	common	lremovexattr			sys_lremovexattr
+237	common	fremovexattr			sys_fremovexattr
+238	common	tkill				sys_tkill
+239	common	sendfile64			sys_sendfile64
+240	common	futex				sys_futex_time32
+241	common	sched_setaffinity		sys_sched_setaffinity
+242	common	sched_getaffinity		sys_sched_getaffinity
+243	common	set_thread_area			sys_ni_syscall
+244	common	get_thread_area			sys_ni_syscall
+245	common	io_setup			sys_io_setup
+246	common	io_destroy			sys_io_destroy
+247	common	io_getevents			sys_io_getevents_time32
+248	common	io_submit			sys_io_submit
+249	common	io_cancel			sys_io_cancel
+250	common	fadvise64			sys_fadvise64
+# 251 is available for reuse (was briefly sys_set_zone_reclaim)
+252	common	exit_group			sys_exit_group
+253	common	lookup_dcookie			sys_lookup_dcookie
+254	common	epoll_create			sys_epoll_create
+255	common	epoll_ctl			sys_epoll_ctl
+256	common	epoll_wait			sys_epoll_wait
+257	common	remap_file_pages		sys_remap_file_pages
+258	common	set_tid_address			sys_set_tid_address
+259	common	timer_create			sys_timer_create
+260	common	timer_settime			sys_timer_settime32
+261	common	timer_gettime			sys_timer_gettime32
+262	common	timer_getoverrun		sys_timer_getoverrun
+263	common	timer_delete			sys_timer_delete
+264	common	clock_settime			sys_clock_settime32
+265	common	clock_gettime			sys_clock_gettime32
+266	common	clock_getres			sys_clock_getres_time32
+267	common	clock_nanosleep			sys_clock_nanosleep_time32
+268	common	statfs64			sys_statfs64
+269	common	fstatfs64			sys_fstatfs64
+270	common	tgkill				sys_tgkill
+271	common	utimes				sys_utimes_time32
+272	common	fadvise64_64			sys_fadvise64_64
+273	common	vserver				sys_ni_syscall
+274	common	mbind				sys_mbind
+275	common	get_mempolicy			sys_get_mempolicy
+276	common	set_mempolicy			sys_set_mempolicy
+277	common	mq_open				sys_mq_open
+278	common	mq_unlink			sys_mq_unlink
+279	common	mq_timedsend			sys_mq_timedsend_time32
+280	common	mq_timedreceive			sys_mq_timedreceive_time32
+281	common	mq_notify			sys_mq_notify
+282	common	mq_getsetattr			sys_mq_getsetattr
+283	common	kexec_load			sys_kexec_load
+284	common	waitid				sys_waitid
+# 285 was setaltroot
+286	common	add_key				sys_add_key
+287	common	request_key			sys_request_key
+288	common	keyctl				sys_keyctl
+289	common	ioprio_set			sys_ioprio_set
+290	common	ioprio_get			sys_ioprio_get
+291	common	inotify_init			sys_inotify_init
+292	common	inotify_add_watch		sys_inotify_add_watch
+293	common	inotify_rm_watch		sys_inotify_rm_watch
+294	common	migrate_pages			sys_ni_syscall
+295	common	openat				sys_openat
+296	common	mkdirat				sys_mkdirat
+297	common	mknodat				sys_mknodat
+298	common	fchownat			sys_fchownat
+299	common	futimesat			sys_futimesat_time32
+300	common	fstatat64			sys_fstatat64
+301	common	unlinkat			sys_unlinkat
+302	common	renameat			sys_renameat
+303	common	linkat				sys_linkat
+304	common	symlinkat			sys_symlinkat
+305	common	readlinkat			sys_readlinkat
+306	common	fchmodat			sys_fchmodat
+307	common	faccessat			sys_faccessat
+308	common	pselect6			sys_pselect6_time32
+309	common	ppoll				sys_ppoll_time32
+310	common	unshare				sys_unshare
+311	common	set_robust_list			sys_set_robust_list
+312	common	get_robust_list			sys_get_robust_list
+313	common	splice				sys_splice
+314	common	sync_file_range			sys_sync_file_range
+315	common	tee				sys_tee
+316	common	vmsplice			sys_vmsplice
+317	common	move_pages			sys_move_pages
+318	common	getcpu				sys_getcpu
+319	common	epoll_pwait			sys_epoll_pwait
+320	common	utimensat			sys_utimensat_time32
+321	common	signalfd			sys_signalfd
+322	common	timerfd_create			sys_timerfd_create
+323	common	eventfd				sys_eventfd
+324	common	fallocate			sys_fallocate
+325	common	semtimedop			sys_semtimedop_time32
+326	common	timerfd_settime			sys_timerfd_settime32
+327	common	timerfd_gettime			sys_timerfd_gettime32
+328	common	semctl				sys_old_semctl
+329	common	semget				sys_semget
+330	common	semop				sys_semop
+331	common	msgctl				sys_old_msgctl
+332	common	msgget				sys_msgget
+333	common	msgrcv				sys_msgrcv
+334	common	msgsnd				sys_msgsnd
+335	common	shmat				sys_shmat
+336	common	shmctl				sys_old_shmctl
+337	common	shmdt				sys_shmdt
+338	common	shmget				sys_shmget
+339	common	signalfd4			sys_signalfd4
+340	common	eventfd2			sys_eventfd2
+341	common	epoll_create1			sys_epoll_create1
+342	common	dup3				sys_dup3
+343	common	pipe2				sys_pipe2
+344	common	inotify_init1			sys_inotify_init1
+345	common	socket				sys_socket
+346	common	socketpair			sys_socketpair
+347	common	bind				sys_bind
+348	common	listen				sys_listen
+349	common	accept				sys_accept
+350	common	connect				sys_connect
+351	common	getsockname			sys_getsockname
+352	common	getpeername			sys_getpeername
+353	common	sendto				sys_sendto
+354	common	send				sys_send
+355	common	recvfrom			sys_recvfrom
+356	common	recv				sys_recv
+357	common	setsockopt			sys_setsockopt
+358	common	getsockopt			sys_getsockopt
+359	common	shutdown			sys_shutdown
+360	common	sendmsg				sys_sendmsg
+361	common	recvmsg				sys_recvmsg
+362	common	accept4				sys_accept4
+363	common	preadv				sys_preadv
+364	common	pwritev				sys_pwritev
+365	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
+366	common	perf_event_open			sys_perf_event_open
+367	common	recvmmsg			sys_recvmmsg_time32
+368	common	fanotify_init			sys_fanotify_init
+369	common	fanotify_mark			sys_fanotify_mark
+370	common	prlimit64			sys_prlimit64
+371	common	name_to_handle_at		sys_name_to_handle_at
+372	common	open_by_handle_at		sys_open_by_handle_at
+373	common	clock_adjtime			sys_clock_adjtime32
+374	common	syncfs				sys_syncfs
+375	common	setns				sys_setns
+376	common	sendmmsg			sys_sendmmsg
+377	common	process_vm_readv		sys_process_vm_readv
+378	common	process_vm_writev		sys_process_vm_writev
+379	common	kcmp				sys_kcmp
+380	common	finit_module			sys_finit_module
+381	common	sched_setattr			sys_sched_setattr
+382	common	sched_getattr			sys_sched_getattr
+383	common	renameat2			sys_renameat2
+384	common	seccomp				sys_seccomp
+385	common	getrandom			sys_getrandom
+386	common	memfd_create			sys_memfd_create
+387	common	bpf				sys_bpf
+388	common	execveat			sys_execveat
+389	common	userfaultfd			sys_userfaultfd
+390	common	membarrier			sys_membarrier
+391	common	mlock2				sys_mlock2
+392	common	copy_file_range			sys_copy_file_range
+393	common	preadv2				sys_preadv2
+394	common	pwritev2			sys_pwritev2
+395	common	pkey_mprotect			sys_pkey_mprotect
+396	common	pkey_alloc			sys_pkey_alloc
+397	common	pkey_free			sys_pkey_free
+398	common	statx				sys_statx
+399	common	io_pgetevents			sys_io_pgetevents_time32
+400	common	rseq				sys_rseq
+# 401 and 402 are unused
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
+435	common	clone3				sys_clone3
diff --git a/linux-user/microblaze/syscall_nr.h b/linux-user/microblaze/syscall_nr.h
deleted file mode 100644
index ec1758e37434..000000000000
--- a/linux-user/microblaze/syscall_nr.h
+++ /dev/null
@@ -1,442 +0,0 @@
-#ifndef LINUX_USER_MICROBLAZE_SYSCALL_NR_H
-#define LINUX_USER_MICROBLAZE_SYSCALL_NR_H
-
-#define TARGET_NR_restart_syscall	0 /* ok */
-#define TARGET_NR_exit		1 /* ok */
-#define TARGET_NR_fork		2 /* not for no MMU - weird */
-#define TARGET_NR_read		3 /* ok */
-#define TARGET_NR_write		4 /* ok */
-#define TARGET_NR_open		5 /* openat */
-#define TARGET_NR_close		6 /* ok */
-#define TARGET_NR_waitpid		7 /* waitid */
-#define TARGET_NR_creat		8 /* openat */
-#define TARGET_NR_link		9 /* linkat */
-#define TARGET_NR_unlink		10 /* unlinkat */
-#define TARGET_NR_execve		11 /* ok */
-#define TARGET_NR_chdir		12 /* ok */
-#define TARGET_NR_time		13 /* obsolete -> sys_gettimeofday */
-#define TARGET_NR_mknod		14 /* mknodat */
-#define TARGET_NR_chmod		15 /* fchmodat */
-#define TARGET_NR_lchown		16 /* ok */
-#define TARGET_NR_break		17 /* don't know */
-#define TARGET_NR_oldstat		18 /* remove */
-#define TARGET_NR_lseek		19 /* ok */
-#define TARGET_NR_getpid		20 /* ok */
-#define TARGET_NR_mount		21 /* ok */
-#define TARGET_NR_umount		22 /* ok */  /* use only umount2 */
-#define TARGET_NR_setuid		23 /* ok */
-#define TARGET_NR_getuid		24 /* ok */
-#define TARGET_NR_stime		25 /* obsolete -> sys_settimeofday */
-#define TARGET_NR_ptrace		26 /* ok */
-#define TARGET_NR_alarm		27 /* obsolete -> sys_setitimer */
-#define TARGET_NR_oldfstat		28 /* remove */
-#define TARGET_NR_pause		29 /* obsolete -> sys_rt_sigtimedwait */
-#define TARGET_NR_utime		30 /* obsolete -> sys_utimesat */
-#define TARGET_NR_stty		31 /* remove */
-#define TARGET_NR_gtty		32 /* remove */
-#define TARGET_NR_access		33 /* faccessat */
-#define TARGET_NR_nice		34 /* can be implemented by sys_setpriority */
-#define TARGET_NR_ftime		35 /* remove */
-#define TARGET_NR_sync		36 /* ok */
-#define TARGET_NR_kill		37 /* ok */
-#define TARGET_NR_rename		38 /* renameat */
-#define TARGET_NR_mkdir		39 /* mkdirat */
-#define TARGET_NR_rmdir		40 /* unlinkat */
-#define TARGET_NR_dup		41 /* ok */
-#define TARGET_NR_pipe		42 /* ok */
-#define TARGET_NR_times		43 /* ok */
-#define TARGET_NR_prof		44 /* remove */
-#define TARGET_NR_brk		45 /* ok -mmu, nommu specific */
-#define TARGET_NR_setgid		46 /* ok */
-#define TARGET_NR_getgid		47 /* ok */
-#define TARGET_NR_signal		48 /* obsolete -> sys_rt_sigaction */
-#define TARGET_NR_geteuid		49 /* ok */
-#define TARGET_NR_getegid		50 /* ok */
-#define TARGET_NR_acct		51 /* add it and then I can disable it */
-#define TARGET_NR_umount2		52 /* remove */
-#define TARGET_NR_lock		53 /* remove */
-#define TARGET_NR_ioctl		54 /* ok */
-#define TARGET_NR_fcntl		55 /* ok -> 64bit version*/
-#define TARGET_NR_mpx		56 /* remove */
-#define TARGET_NR_setpgid		57 /* ok */
-#define TARGET_NR_ulimit		58 /* remove */
-#define TARGET_NR_oldolduname	59 /* remove */
-#define TARGET_NR_umask		60 /* ok */
-#define TARGET_NR_chroot		61 /* ok */
-#define TARGET_NR_ustat		62 /* obsolete -> statfs64 */
-#define TARGET_NR_dup2		63 /* ok */
-#define TARGET_NR_getppid		64 /* ok */
-#define TARGET_NR_getpgrp		65 /* obsolete -> sys_getpgid */
-#define TARGET_NR_setsid		66 /* ok */
-#define TARGET_NR_sigaction		67 /* obsolete -> rt_sigaction */
-#define TARGET_NR_sgetmask		68 /* obsolete -> sys_rt_sigprocmask */
-#define TARGET_NR_ssetmask		69 /* obsolete ->sys_rt_sigprocmask */
-#define TARGET_NR_setreuid		70 /* ok */
-#define TARGET_NR_setregid		71 /* ok */
-#define TARGET_NR_sigsuspend		72 /* obsolete -> rt_sigsuspend */
-#define TARGET_NR_sigpending		73 /* obsolete -> sys_rt_sigpending */
-#define TARGET_NR_sethostname	74 /* ok */
-#define TARGET_NR_setrlimit		75 /* ok */
-#define TARGET_NR_getrlimit		76 /* ok Back compatible 2Gig limited rlimit */
-#define TARGET_NR_getrusage		77 /* ok */
-#define TARGET_NR_gettimeofday	78 /* ok */
-#define TARGET_NR_settimeofday	79 /* ok */
-#define TARGET_NR_getgroups		80 /* ok */
-#define TARGET_NR_setgroups		81 /* ok */
-#define TARGET_NR_select		82 /* obsolete -> sys_pselect7 */
-#define TARGET_NR_symlink		83 /* symlinkat */
-#define TARGET_NR_oldlstat		84 /* remove */
-#define TARGET_NR_readlink		85 /* obsolete -> sys_readlinkat */
-#define TARGET_NR_uselib		86 /* remove */
-#define TARGET_NR_swapon		87 /* ok */
-#define TARGET_NR_reboot		88 /* ok */
-#define TARGET_NR_readdir		89 /* remove ? */
-#define TARGET_NR_mmap		90 /* obsolete -> sys_mmap2 */
-#define TARGET_NR_munmap		91 /* ok - mmu and nommu */
-#define TARGET_NR_truncate		92 /* ok or truncate64 */
-#define TARGET_NR_ftruncate		93 /* ok or ftruncate64 */
-#define TARGET_NR_fchmod		94 /* ok */
-#define TARGET_NR_fchown		95 /* ok */
-#define TARGET_NR_getpriority	96 /* ok */
-#define TARGET_NR_setpriority	97 /* ok */
-#define TARGET_NR_profil		98 /* remove */
-#define TARGET_NR_statfs		99 /* ok or statfs64 */
-#define TARGET_NR_fstatfs		100  /* ok or fstatfs64 */
-#define TARGET_NR_ioperm		101 /* remove */
-#define TARGET_NR_socketcall		102 /* remove */
-#define TARGET_NR_syslog		103 /* ok */
-#define TARGET_NR_setitimer		104 /* ok */
-#define TARGET_NR_getitimer		105 /* ok */
-#define TARGET_NR_stat		106 /* remove */
-#define TARGET_NR_lstat		107 /* remove */
-#define TARGET_NR_fstat		108 /* remove */
-#define TARGET_NR_olduname		109 /* remove */
-#define TARGET_NR_iopl		110 /* remove */
-#define TARGET_NR_vhangup		111 /* ok */
-#define TARGET_NR_idle		112 /* remove */
-#define TARGET_NR_vm86old		113 /* remove */
-#define TARGET_NR_wait4		114 /* obsolete -> waitid */
-#define TARGET_NR_swapoff		115 /* ok */
-#define TARGET_NR_sysinfo		116 /* ok */
-#define TARGET_NR_ipc		117 /* remove - direct call */
-#define TARGET_NR_fsync		118 /* ok */
-#define TARGET_NR_sigreturn		119 /* obsolete -> sys_rt_sigreturn */
-#define TARGET_NR_clone		120 /* ok */
-#define TARGET_NR_setdomainname	121 /* ok */
-#define TARGET_NR_uname		122 /* remove */
-#define TARGET_NR_modify_ldt		123 /* remove */
-#define TARGET_NR_adjtimex		124 /* ok */
-#define TARGET_NR_mprotect		125 /* remove */
-#define TARGET_NR_sigprocmask	126 /* obsolete -> sys_rt_sigprocmask */
-#define TARGET_NR_create_module	127 /* remove */
-#define TARGET_NR_init_module	128 /* ok */
-#define TARGET_NR_delete_module	129 /* ok */
-#define TARGET_NR_get_kernel_syms	130 /* remove */
-#define TARGET_NR_quotactl		131 /* ok */
-#define TARGET_NR_getpgid		132 /* ok */
-#define TARGET_NR_fchdir		133 /* ok */
-#define TARGET_NR_bdflush		134 /* remove */
-#define TARGET_NR_sysfs		135 /* needed for busybox */
-#define TARGET_NR_personality	136 /* ok */
-#define TARGET_NR_afs_syscall	137 /* Syscall for Andrew File System */
-#define TARGET_NR_setfsuid		138 /* ok */
-#define TARGET_NR_setfsgid		139 /* ok */
-#define TARGET_NR__llseek		140 /* remove only lseek */
-#define TARGET_NR_getdents		141 /* ok or getdents64 */
-#define TARGET_NR__newselect		142 /* remove */
-#define TARGET_NR_flock		143 /* ok */
-#define TARGET_NR_msync		144 /* remove */
-#define TARGET_NR_readv		145 /* ok */
-#define TARGET_NR_writev		146 /* ok */
-#define TARGET_NR_getsid		147 /* ok */
-#define TARGET_NR_fdatasync		148 /* ok */
-#define TARGET_NR__sysctl		149 /* remove */
-#define TARGET_NR_mlock		150 /* ok - nommu or mmu */
-#define TARGET_NR_munlock		151 /* ok - nommu or mmu */
-#define TARGET_NR_mlockall		152 /* ok - nommu or mmu */
-#define TARGET_NR_munlockall		153 /* ok - nommu or mmu */
-#define TARGET_NR_sched_setparam		154 /* ok */
-#define TARGET_NR_sched_getparam		155 /* ok */
-#define TARGET_NR_sched_setscheduler		156 /* ok */
-#define TARGET_NR_sched_getscheduler		157 /* ok */
-#define TARGET_NR_sched_yield		158 /* ok */
-#define TARGET_NR_sched_get_priority_max	159 /* ok */
-#define TARGET_NR_sched_get_priority_min	160 /* ok */
-#define TARGET_NR_sched_rr_get_interval	161 /* ok */
-#define TARGET_NR_nanosleep		162 /* ok */
-#define TARGET_NR_mremap		163 /* ok - nommu or mmu */
-#define TARGET_NR_setresuid		164 /* ok */
-#define TARGET_NR_getresuid		165 /* ok */
-#define TARGET_NR_vm86		166 /* remove */
-#define TARGET_NR_query_module	167 /* ok */
-#define TARGET_NR_poll		168 /* obsolete -> sys_ppoll */
-#define TARGET_NR_nfsservctl		169 /* ok */
-#define TARGET_NR_setresgid		170 /* ok */
-#define TARGET_NR_getresgid		171 /* ok */
-#define TARGET_NR_prctl		172 /* ok */
-#define TARGET_NR_rt_sigreturn	173 /* ok */
-#define TARGET_NR_rt_sigaction	174 /* ok */
-#define TARGET_NR_rt_sigprocmask	175 /* ok */
-#define TARGET_NR_rt_sigpending	176 /* ok */
-#define TARGET_NR_rt_sigtimedwait	177 /* ok */
-#define TARGET_NR_rt_sigqueueinfo	178 /* ok */
-#define TARGET_NR_rt_sigsuspend	179 /* ok */
-#define TARGET_NR_pread64		180 /* ok */
-#define TARGET_NR_pwrite64		181 /* ok */
-#define TARGET_NR_chown		182 /* obsolete -> fchownat */
-#define TARGET_NR_getcwd		183 /* ok */
-#define TARGET_NR_capget		184 /* ok */
-#define TARGET_NR_capset		185 /* ok */
-#define TARGET_NR_sigaltstack	186 /* remove */
-#define TARGET_NR_sendfile		187 /* ok -> exist 64bit version*/
-#define TARGET_NR_getpmsg		188 /* remove - some people actually want streams */
-#define TARGET_NR_putpmsg		189 /* remove - some people actually want streams */
-#define TARGET_NR_vfork		190 /* for noMMU - group with clone -> maybe remove */
-#define TARGET_NR_ugetrlimit		191 /* remove - SuS compliant getrlimit */
-#define TARGET_NR_mmap2		192 /* ok */
-#define TARGET_NR_truncate64		193 /* ok */
-#define TARGET_NR_ftruncate64	194 /* ok */
-#define TARGET_NR_stat64		195 /* remove _ARCH_WANT_STAT64 */
-#define TARGET_NR_lstat64		196 /* remove _ARCH_WANT_STAT64 */
-#define TARGET_NR_fstat64		197 /* remove _ARCH_WANT_STAT64 */
-#define TARGET_NR_lchown32		198 /* ok - without 32 */
-#define TARGET_NR_getuid32		199 /* ok - without 32 */
-#define TARGET_NR_getgid32		200 /* ok - without 32 */
-#define TARGET_NR_geteuid32		201 /* ok - without 32 */
-#define TARGET_NR_getegid32		202 /* ok - without 32 */
-#define TARGET_NR_setreuid32		203 /* ok - without 32 */
-#define TARGET_NR_setregid32		204 /* ok - without 32 */
-#define TARGET_NR_getgroups32	205 /* ok - without 32 */
-#define TARGET_NR_setgroups32	206 /* ok - without 32 */
-#define TARGET_NR_fchown32		207 /* ok - without 32 */
-#define TARGET_NR_setresuid32	208 /* ok - without 32 */
-#define TARGET_NR_getresuid32	209 /* ok - without 32 */
-#define TARGET_NR_setresgid32	210 /* ok - without 32 */
-#define TARGET_NR_getresgid32	211 /* ok - without 32 */
-#define TARGET_NR_chown32		212 /* ok - without 32 -obsolete -> fchownat */
-#define TARGET_NR_setuid32		213 /* ok - without 32 */
-#define TARGET_NR_setgid32		214 /* ok - without 32 */
-#define TARGET_NR_setfsuid32		215 /* ok - without 32 */
-#define TARGET_NR_setfsgid32		216 /* ok - without 32 */
-#define TARGET_NR_pivot_root		217 /* ok */
-#define TARGET_NR_mincore		218 /* ok */
-#define TARGET_NR_madvise		219 /* ok */
-//#define TARGET_NR_madvise1		219 /* remove delete when C lib stub is removed */
-#define TARGET_NR_getdents64		220 /* ok */
-#define TARGET_NR_fcntl64		221 /* ok */
-/* 223 is unused */
-#define TARGET_NR_gettid		224 /* ok */
-#define TARGET_NR_readahead		225 /* ok */
-#define TARGET_NR_setxattr		226 /* ok */
-#define TARGET_NR_lsetxattr		227 /* ok */
-#define TARGET_NR_fsetxattr		228 /* ok */
-#define TARGET_NR_getxattr		229 /* ok */
-#define TARGET_NR_lgetxattr		230 /* ok */
-#define TARGET_NR_fgetxattr		231 /* ok */
-#define TARGET_NR_listxattr		232 /* ok */
-#define TARGET_NR_llistxattr		233 /* ok */
-#define TARGET_NR_flistxattr		234 /* ok */
-#define TARGET_NR_removexattr	235 /* ok */
-#define TARGET_NR_lremovexattr	236 /* ok */
-#define TARGET_NR_fremovexattr	237 /* ok */
-#define TARGET_NR_tkill		238 /* ok */
-#define TARGET_NR_sendfile64		239 /* ok */
-#define TARGET_NR_futex		240 /* ok */
-#define TARGET_NR_sched_setaffinity	241 /* ok */
-#define TARGET_NR_sched_getaffinity	242 /* ok */
-#define TARGET_NR_set_thread_area	243 /* remove */
-#define TARGET_NR_get_thread_area	244 /* remove */
-#define TARGET_NR_io_setup		245 /* ok */
-#define TARGET_NR_io_destroy		246 /* ok */
-#define TARGET_NR_io_getevents	247 /* ok */
-#define TARGET_NR_io_submit		248 /* ok */
-#define TARGET_NR_io_cancel		249 /* ok */
-#define TARGET_NR_fadvise64		250 /* remove -> sys_fadvise64_64 */
-/* 251 is available for reuse (was briefly sys_set_zone_reclaim) */
-#define TARGET_NR_exit_group		252 /* ok */
-#define TARGET_NR_lookup_dcookie	253 /* ok */
-#define TARGET_NR_epoll_create	254 /* ok */
-#define TARGET_NR_epoll_ctl		255 /* ok */
-#define TARGET_NR_epoll_wait		256 /* obsolete -> sys_epoll_pwait */
-#define TARGET_NR_remap_file_pages	257 /* only for mmu */
-#define TARGET_NR_set_tid_address	258 /* ok */
-#define TARGET_NR_timer_create	259 /* ok */
-#define TARGET_NR_timer_settime	(TARGET_NR_timer_create+1) /* 260 */ /* ok */
-#define TARGET_NR_timer_gettime	(TARGET_NR_timer_create+2) /* 261 */ /* ok */
-#define TARGET_NR_timer_getoverrun	(TARGET_NR_timer_create+3) /* 262 */ /* ok */
-#define TARGET_NR_timer_delete	(TARGET_NR_timer_create+4) /* 263 */ /* ok */
-#define TARGET_NR_clock_settime	(TARGET_NR_timer_create+5) /* 264 */ /* ok */
-#define TARGET_NR_clock_gettime	(TARGET_NR_timer_create+6) /* 265 */ /* ok */
-#define TARGET_NR_clock_getres	(TARGET_NR_timer_create+7) /* 266 */ /* ok */
-#define TARGET_NR_clock_nanosleep	(TARGET_NR_timer_create+8) /* 267 */ /* ok */
-#define TARGET_NR_statfs64		268 /* ok */
-#define TARGET_NR_fstatfs64		269 /* ok */
-#define TARGET_NR_tgkill		270 /* ok */
-#define TARGET_NR_utimes		271 /* obsolete -> sys_futimesat */
-#define TARGET_NR_fadvise64_64	272 /* ok */
-#define TARGET_NR_vserver		273 /* ok */
-#define TARGET_NR_mbind		274 /* only for mmu */
-#define TARGET_NR_get_mempolicy	275 /* only for mmu */
-#define TARGET_NR_set_mempolicy	276 /* only for mmu */
-#define TARGET_NR_mq_open		277 /* ok */
-#define TARGET_NR_mq_unlink		(TARGET_NR_mq_open+1) /* 278 */ /* ok */
-#define TARGET_NR_mq_timedsend	(TARGET_NR_mq_open+2) /* 279 */ /* ok */
-#define TARGET_NR_mq_timedreceive	(TARGET_NR_mq_open+3) /* 280 */ /* ok */
-#define TARGET_NR_mq_notify		(TARGET_NR_mq_open+4) /* 281 */ /* ok */
-#define TARGET_NR_mq_getsetattr	(TARGET_NR_mq_open+5) /* 282 */ /* ok */
-#define TARGET_NR_kexec_load		283 /* ok */
-#define TARGET_NR_waitid		284 /* ok */
-/* #define TARGET_NR_sys_setaltroot	285 */
-#define TARGET_NR_add_key		286 /* ok */
-#define TARGET_NR_request_key	287 /* ok */
-#define TARGET_NR_keyctl		288 /* ok */
-#define TARGET_NR_ioprio_set		289 /* ok */
-#define TARGET_NR_ioprio_get		290 /* ok */
-#define TARGET_NR_inotify_init	291 /* ok */
-#define TARGET_NR_inotify_add_watch	292 /* ok */
-#define TARGET_NR_inotify_rm_watch	293 /* ok */
-#define TARGET_NR_migrate_pages	294 /* mmu */
-#define TARGET_NR_openat		295 /* ok */
-#define TARGET_NR_mkdirat		296 /* ok */
-#define TARGET_NR_mknodat		297 /* ok */
-#define TARGET_NR_fchownat		298 /* ok */
-#define TARGET_NR_futimesat		299 /* obsolete -> sys_utimesat */
-#define TARGET_NR_fstatat64		300 /* stat64 */
-#define TARGET_NR_unlinkat		301 /* ok */
-#define TARGET_NR_renameat		302 /* ok */
-#define TARGET_NR_linkat		303 /* ok */
-#define TARGET_NR_symlinkat		304 /* ok */
-#define TARGET_NR_readlinkat		305 /* ok */
-#define TARGET_NR_fchmodat		306 /* ok */
-#define TARGET_NR_faccessat		307 /* ok */
-#define TARGET_NR_pselect6		308 /* obsolete -> sys_pselect7 */
-#define TARGET_NR_ppoll		309 /* ok */
-#define TARGET_NR_unshare		310 /* ok */
-#define TARGET_NR_set_robust_list	311 /* ok */
-#define TARGET_NR_get_robust_list	312 /* ok */
-#define TARGET_NR_splice		313 /* ok */
-#define TARGET_NR_sync_file_range	314 /* ok */
-#define TARGET_NR_tee		315 /* ok */
-#define TARGET_NR_vmsplice		316 /* ok */
-#define TARGET_NR_move_pages		317 /* mmu */
-#define TARGET_NR_getcpu		318 /* ok */
-#define TARGET_NR_epoll_pwait	319 /* ok */
-#define TARGET_NR_utimensat		320 /* ok */
-#define TARGET_NR_signalfd		321 /* ok */
-#define TARGET_NR_timerfd_create	322 /* ok */
-#define TARGET_NR_eventfd		323 /* ok */
-#define TARGET_NR_fallocate		324 /* ok */
-#define TARGET_NR_semtimedop		325 /* ok - semaphore group */
-#define TARGET_NR_timerfd_settime	326 /* ok */
-#define TARGET_NR_timerfd_gettime	327 /* ok */
-/* sysv ipc syscalls */
-#define TARGET_NR_semctl		328 /* ok */
-#define TARGET_NR_semget		329 /* ok */
-#define TARGET_NR_semop		330 /* ok */
-#define TARGET_NR_msgctl		331 /* ok */
-#define TARGET_NR_msgget		332 /* ok */
-#define TARGET_NR_msgrcv		333 /* ok */
-#define TARGET_NR_msgsnd		334 /* ok */
-#define TARGET_NR_shmat		335 /* ok */
-#define TARGET_NR_shmctl		336 /* ok */
-#define TARGET_NR_shmdt		337 /* ok */
-#define TARGET_NR_shmget		338 /* ok */
-
-
-#define TARGET_NR_signalfd4		339 /* new */
-#define TARGET_NR_eventfd2		340 /* new */
-#define TARGET_NR_epoll_create1	341 /* new */
-#define TARGET_NR_dup3		342 /* new */
-#define TARGET_NR_pipe2		343 /* new */
-#define TARGET_NR_inotify_init1	344 /* new */
-#define TARGET_NR_socket		345 /* new */
-#define TARGET_NR_socketpair		346 /* new */
-#define TARGET_NR_bind		347 /* new */
-#define TARGET_NR_listen		348 /* new */
-#define TARGET_NR_accept		349 /* new */
-#define TARGET_NR_connect		350 /* new */
-#define TARGET_NR_getsockname	351 /* new */
-#define TARGET_NR_getpeername	352 /* new */
-#define TARGET_NR_sendto		353 /* new */
-#define TARGET_NR_send		354 /* new */
-#define TARGET_NR_recvfrom		355 /* new */
-#define TARGET_NR_recv		356 /* new */
-#define TARGET_NR_setsockopt		357 /* new */
-#define TARGET_NR_getsockopt		358 /* new */
-#define TARGET_NR_shutdown		359 /* new */
-#define TARGET_NR_sendmsg		360 /* new */
-#define TARGET_NR_recvmsg		361 /* new */
-#define TARGET_NR_accept4               362 /* new */
-#define TARGET_NR_preadv                363 /* new */
-#define TARGET_NR_pwritev               364 /* new */
-#define TARGET_NR_rt_tgsigqueueinfo     365 /* new */
-#define TARGET_NR_perf_event_open       366 /* new */
-#define TARGET_NR_recvmmsg              367 /* new */
-#define TARGET_NR_fanotify_init         368
-#define TARGET_NR_fanotify_mark         369
-#define TARGET_NR_prlimit64             370
-#define TARGET_NR_name_to_handle_at     371
-#define TARGET_NR_open_by_handle_at     372
-#define TARGET_NR_clock_adjtime         373
-#define TARGET_NR_syncfs                374
-#define TARGET_NR_setns                 375
-#define TARGET_NR_sendmmsg              376
-#define TARGET_NR_process_vm_readv      377
-#define TARGET_NR_process_vm_writev     378
-#define TARGET_NR_kcmp                  379
-#define TARGET_NR_finit_module          380
-#define TARGET_NR_sched_setattr         381
-#define TARGET_NR_sched_getattr         382
-#define TARGET_NR_renameat2             383
-#define TARGET_NR_seccomp               384
-#define TARGET_NR_getrandom             385
-#define TARGET_NR_memfd_create          386
-#define TARGET_NR_bpf                   387
-#define TARGET_NR_execveat              388
-#define TARGET_NR_userfaultfd           389
-#define TARGET_NR_membarrier            390
-#define TARGET_NR_mlock2                391
-#define TARGET_NR_copy_file_range       392
-#define TARGET_NR_preadv2               393
-#define TARGET_NR_pwritev2              394
-#define TARGET_NR_pkey_mprotect         395
-#define TARGET_NR_pkey_alloc            396
-#define TARGET_NR_pkey_free             397
-#define TARGET_NR_statx                 398
-#define TARGET_NR_io_pgetevents         399
-#define TARGET_NR_rseq                  400
-/* 401 and 402 are unused */
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
-#define TARGET_NR_clone3                435
-
-#endif
diff --git a/linux-user/microblaze/syscallhdr.sh b/linux-user/microblaze/syscallhdr.sh
new file mode 100644
index 000000000000..f55dce8a6248
--- /dev/null
+++ b/linux-user/microblaze/syscallhdr.sh
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
+fileguard=LINUX_USER_MICROBLAZE_`basename "$out" | sed \
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
+    printf "#endif /* %s */" "${fileguard}"
+) > "$out"
-- 
2.24.1


