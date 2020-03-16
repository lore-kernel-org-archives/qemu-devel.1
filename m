Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7930EC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D01220409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D01220409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuK5-0007j9-9t
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsQS-0008GH-4s
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsQL-0006Gt-1J
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:12 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53699)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsQK-00067o-EU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:17:04 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N1M4p-1jJYXL3Plz-012suy; Mon, 16 Mar 2020 17:16:25 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 18/38] linux-user, xtensa: add syscall table generation support
Date: Mon, 16 Mar 2020 17:15:30 +0100
Message-Id: <20200316161550.336150-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bnRJeJAM7BKLXq29udbl1AXgEjf3DS0q3ZWLZXacWGEOOvoY4wZ
 2TusIolyNz1MRzOPvWpfqmwZxiZrRqLW0wkjpqIYByLfPprj8lDpHYsvhbge+So1P/bmJvR
 tDiJ/e73MvvfTui8qEbXltA80MHTHlIZiS6ofQqDvM53LWhDCbZVNv5wVCkqm+5JwpSlHJz
 DzVuh0wl0r8DzT96s5zfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TG0z2CXTZHg=:qP80JlHZfQv6I55BnkoMvL
 60XX4wGq3FUZdgM/Qxr7fG+WOwPiaOtWwqAN6GMyCn5hixGqi0JdK6zDuLaCDi8Qy0ClSCYNY
 vO75EVLgKQMvfaj++aHFOmabAwvQPMXdKEs8TUxNVVHIeoQ5cX8+r/zDGhggZKH+hgmBlDiCv
 AAx+hNrRAtjt8scEpFDDGLM9DHYJhG2e1bJKY4SywlHFUQNS0ykOvx7o0T2LNa/3v/Z+IoT9/
 7bychd5p3UX0BENrGZbmqvH3CwsQlnpPLLjkH2Tr4Lcwqmj7AomchurPZ8/YMSBY4dxNHre0n
 iQIjccRGeBFeLjrsabnNunIVcHNXeysu/aUvUep2Cike4MMSSpW09K24VmJ2zDQ9BzxkFt5M7
 RxRPtu/MkyhvDcocMjHFmrX/jgl8RWU+In3xT9TSnfpCsWwO9PlokuoDJBZ84V+jLHm4hH9tB
 1djdSRpmuj/+900i66aU7MinGje32HPCxp4aLdH2JOiSV9pOxJNU438VkjDxzGedanEPYgLeK
 F+1baFtgtwIbv6L+LDZ5k72YLzsEZl7bvNDZODHtzlavtJw7kVG+nz/mMPdZxnVtcYomKiPTj
 JleZtwR2mwgIf73Y3x42qUuQjtL2kUx77IJ86o8F1mkg91mmvWwwh873yLIZS/X1MN2c5CKjR
 fbA3WvQD5ve8u6nrEkPGdr/H7ibLKKhyPB6LXVVkm/wGnjquFU0GVEIkTQa/WvkNYmkAxTqoE
 SGPwrdCbWBn7gInyqXxtXBQ3jA5g9Wg1uowa4YQR0l4mObQfpp1XH7BRyudFalBoWj7XkIVxK
 bHLQ8ciwLwWh6sQZQndDgCKf2aEKbqSr8htC8hNKPJkR844fxBnDv84oL7NvUvW1qTRlQrC
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

Copy syscall.tbl and syscallhdr.sh from linux/arch/xtensa/kernel/syscalls v5.5
Update syscallhdr.sh to generate QEMU syscall_nr.h

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-6-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure                       |   3 +-
 linux-user/Makefile.objs        |   1 +
 linux-user/xtensa/Makefile.objs |   5 +
 linux-user/xtensa/syscall.tbl   | 408 +++++++++++++++++++++++++++
 linux-user/xtensa/syscall_nr.h  | 469 --------------------------------
 linux-user/xtensa/syscallhdr.sh |  32 +++
 6 files changed, 448 insertions(+), 470 deletions(-)
 create mode 100644 linux-user/xtensa/Makefile.objs
 create mode 100644 linux-user/xtensa/syscall.tbl
 delete mode 100644 linux-user/xtensa/syscall_nr.h
 create mode 100644 linux-user/xtensa/syscallhdr.sh

diff --git a/configure b/configure
index 480e1d9af5f1..3e72343b2aa9 100755
--- a/configure
+++ b/configure
@@ -1889,7 +1889,7 @@ rm -f */config-devices.mak.d
 
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
-for arch in alpha hppa m68k ; do
+for arch in alpha hppa m68k xtensa ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
@@ -7916,6 +7916,7 @@ case "$target_name" in
   ;;
   xtensa|xtensaeb)
     TARGET_ARCH=xtensa
+    TARGET_SYSTBL_ABI=common
     bflt="yes"
     mttcg="yes"
   ;;
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index ac74b23683cf..13b821baf752 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -12,3 +12,4 @@ obj-$(TARGET_AARCH64) += arm/semihost.o
 obj-$(TARGET_ALPHA) += alpha/
 obj-$(TARGET_HPPA) += hppa/
 obj-$(TARGET_M68K) += m68k/
+obj-$(TARGET_XTENSA) += xtensa/
diff --git a/linux-user/xtensa/Makefile.objs b/linux-user/xtensa/Makefile.objs
new file mode 100644
index 000000000000..d4be1b745544
--- /dev/null
+++ b/linux-user/xtensa/Makefile.objs
@@ -0,0 +1,5 @@
+generated-files-y += linux-user/xtensa/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/xtensa/syscallhdr.sh
+%/syscall_nr.h: $(SRC_PATH)/linux-user/xtensa/syscall.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/xtensa/syscall.tbl b/linux-user/xtensa/syscall.tbl
new file mode 100644
index 000000000000..25f4de729a6d
--- /dev/null
+++ b/linux-user/xtensa/syscall.tbl
@@ -0,0 +1,408 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for xtensa
+#
+# The format is:
+# <number> <abi> <name> <entry point>
+#
+# The <abi> is always "common" for this file
+#
+0	common	spill				sys_ni_syscall
+1	common	xtensa				sys_ni_syscall
+2	common	available4			sys_ni_syscall
+3	common	available5			sys_ni_syscall
+4	common	available6			sys_ni_syscall
+5	common	available7			sys_ni_syscall
+6	common	available8			sys_ni_syscall
+7	common	available9			sys_ni_syscall
+# File Operations
+8	common	open				sys_open
+9	common	close				sys_close
+10	common	dup				sys_dup
+11	common	dup2				sys_dup2
+12	common	read				sys_read
+13	common	write				sys_write
+14	common	select				sys_select
+15	common	lseek				sys_lseek
+16	common	poll				sys_poll
+17	common	_llseek				sys_llseek
+18	common	epoll_wait			sys_epoll_wait
+19	common	epoll_ctl			sys_epoll_ctl
+20	common	epoll_create			sys_epoll_create
+21	common	creat				sys_creat
+22	common	truncate			sys_truncate
+23	common	ftruncate			sys_ftruncate
+24	common	readv				sys_readv
+25	common	writev				sys_writev
+26	common	fsync				sys_fsync
+27	common	fdatasync			sys_fdatasync
+28	common	truncate64			sys_truncate64
+29	common	ftruncate64			sys_ftruncate64
+30	common	pread64				sys_pread64
+31	common	pwrite64			sys_pwrite64
+32	common	link				sys_link
+33	common	rename				sys_rename
+34	common	symlink				sys_symlink
+35	common	readlink			sys_readlink
+36	common	mknod				sys_mknod
+37	common	pipe				sys_pipe
+38	common	unlink				sys_unlink
+39	common	rmdir				sys_rmdir
+40	common	mkdir				sys_mkdir
+41	common	chdir				sys_chdir
+42	common	fchdir				sys_fchdir
+43	common	getcwd				sys_getcwd
+44	common	chmod				sys_chmod
+45	common	chown				sys_chown
+46	common	stat				sys_newstat
+47	common	stat64				sys_stat64
+48	common	lchown				sys_lchown
+49	common	lstat				sys_newlstat
+50	common	lstat64				sys_lstat64
+51	common	available51			sys_ni_syscall
+52	common	fchmod				sys_fchmod
+53	common	fchown				sys_fchown
+54	common	fstat				sys_newfstat
+55	common	fstat64				sys_fstat64
+56	common	flock				sys_flock
+57	common	access				sys_access
+58	common	umask				sys_umask
+59	common	getdents			sys_getdents
+60	common	getdents64			sys_getdents64
+61	common	fcntl64				sys_fcntl64
+62	common	fallocate			sys_fallocate
+63	common	fadvise64_64			xtensa_fadvise64_64
+64	common	utime				sys_utime32
+65	common	utimes				sys_utimes_time32
+66	common	ioctl				sys_ioctl
+67	common	fcntl				sys_fcntl
+68	common	setxattr			sys_setxattr
+69	common	getxattr			sys_getxattr
+70	common	listxattr			sys_listxattr
+71	common	removexattr			sys_removexattr
+72	common	lsetxattr			sys_lsetxattr
+73	common	lgetxattr			sys_lgetxattr
+74	common	llistxattr			sys_llistxattr
+75	common	lremovexattr			sys_lremovexattr
+76	common	fsetxattr			sys_fsetxattr
+77	common	fgetxattr			sys_fgetxattr
+78	common	flistxattr			sys_flistxattr
+79	common	fremovexattr			sys_fremovexattr
+# File Map / Shared Memory Operations
+80	common	mmap2				sys_mmap_pgoff
+81	common	munmap				sys_munmap
+82	common	mprotect			sys_mprotect
+83	common	brk				sys_brk
+84	common	mlock				sys_mlock
+85	common	munlock				sys_munlock
+86	common	mlockall			sys_mlockall
+87	common	munlockall			sys_munlockall
+88	common	mremap				sys_mremap
+89	common	msync				sys_msync
+90	common	mincore				sys_mincore
+91	common	madvise				sys_madvise
+92	common	shmget				sys_shmget
+93	common	shmat				xtensa_shmat
+94	common	shmctl				sys_old_shmctl
+95	common	shmdt				sys_shmdt
+# Socket Operations
+96	common	socket				sys_socket
+97	common	setsockopt			sys_setsockopt
+98	common	getsockopt			sys_getsockopt
+99	common	shutdown			sys_shutdown
+100	common	bind				sys_bind
+101	common	connect				sys_connect
+102	common	listen				sys_listen
+103	common	accept				sys_accept
+104	common	getsockname			sys_getsockname
+105	common	getpeername			sys_getpeername
+106	common	sendmsg				sys_sendmsg
+107	common	recvmsg				sys_recvmsg
+108	common	send				sys_send
+109	common	recv				sys_recv
+110	common	sendto				sys_sendto
+111	common	recvfrom			sys_recvfrom
+112	common	socketpair			sys_socketpair
+113	common	sendfile			sys_sendfile
+114	common	sendfile64			sys_sendfile64
+115	common	sendmmsg			sys_sendmmsg
+# Process Operations
+116	common	clone				sys_clone
+117	common	execve				sys_execve
+118	common	exit				sys_exit
+119	common	exit_group			sys_exit_group
+120	common	getpid				sys_getpid
+121	common	wait4				sys_wait4
+122	common	waitid				sys_waitid
+123	common	kill				sys_kill
+124	common	tkill				sys_tkill
+125	common	tgkill				sys_tgkill
+126	common	set_tid_address			sys_set_tid_address
+127	common	gettid				sys_gettid
+128	common	setsid				sys_setsid
+129	common	getsid				sys_getsid
+130	common	prctl				sys_prctl
+131	common	personality			sys_personality
+132	common	getpriority			sys_getpriority
+133	common	setpriority			sys_setpriority
+134	common	setitimer			sys_setitimer
+135	common	getitimer			sys_getitimer
+136	common	setuid				sys_setuid
+137	common	getuid				sys_getuid
+138	common	setgid				sys_setgid
+139	common	getgid				sys_getgid
+140	common	geteuid				sys_geteuid
+141	common	getegid				sys_getegid
+142	common	setreuid			sys_setreuid
+143	common	setregid			sys_setregid
+144	common	setresuid			sys_setresuid
+145	common	getresuid			sys_getresuid
+146	common	setresgid			sys_setresgid
+147	common	getresgid			sys_getresgid
+148	common	setpgid				sys_setpgid
+149	common	getpgid				sys_getpgid
+150	common	getppid				sys_getppid
+151	common	getpgrp				sys_getpgrp
+# 152 was set_thread_area
+152	common	reserved152			sys_ni_syscall
+# 153 was get_thread_area
+153	common	reserved153			sys_ni_syscall
+154	common	times				sys_times
+155	common	acct				sys_acct
+156	common	sched_setaffinity		sys_sched_setaffinity
+157	common	sched_getaffinity		sys_sched_getaffinity
+158	common	capget				sys_capget
+159	common	capset				sys_capset
+160	common	ptrace				sys_ptrace
+161	common	semtimedop			sys_semtimedop_time32
+162	common	semget				sys_semget
+163	common	semop				sys_semop
+164	common	semctl				sys_old_semctl
+165	common	available165			sys_ni_syscall
+166	common	msgget				sys_msgget
+167	common	msgsnd				sys_msgsnd
+168	common	msgrcv				sys_msgrcv
+169	common	msgctl				sys_old_msgctl
+170	common	available170			sys_ni_syscall
+# File System
+171	common	umount2				sys_umount
+172	common	mount				sys_mount
+173	common	swapon				sys_swapon
+174	common	chroot				sys_chroot
+175	common	pivot_root			sys_pivot_root
+176	common	umount				sys_oldumount
+177	common	swapoff				sys_swapoff
+178	common	sync				sys_sync
+179	common	syncfs				sys_syncfs
+180	common	setfsuid			sys_setfsuid
+181	common	setfsgid			sys_setfsgid
+182	common	sysfs				sys_sysfs
+183	common	ustat				sys_ustat
+184	common	statfs				sys_statfs
+185	common	fstatfs				sys_fstatfs
+186	common	statfs64			sys_statfs64
+187	common	fstatfs64			sys_fstatfs64
+# System
+188	common	setrlimit			sys_setrlimit
+189	common	getrlimit			sys_getrlimit
+190	common	getrusage			sys_getrusage
+191	common	futex				sys_futex_time32
+192	common	gettimeofday			sys_gettimeofday
+193	common	settimeofday			sys_settimeofday
+194	common	adjtimex			sys_adjtimex_time32
+195	common	nanosleep			sys_nanosleep_time32
+196	common	getgroups			sys_getgroups
+197	common	setgroups			sys_setgroups
+198	common	sethostname			sys_sethostname
+199	common	setdomainname			sys_setdomainname
+200	common	syslog				sys_syslog
+201	common	vhangup				sys_vhangup
+202	common	uselib				sys_uselib
+203	common	reboot				sys_reboot
+204	common	quotactl			sys_quotactl
+# 205 was old nfsservctl
+205	common	nfsservctl			sys_ni_syscall
+206	common	_sysctl				sys_sysctl
+207	common	bdflush				sys_bdflush
+208	common	uname				sys_newuname
+209	common	sysinfo				sys_sysinfo
+210	common	init_module			sys_init_module
+211	common	delete_module			sys_delete_module
+212	common	sched_setparam			sys_sched_setparam
+213	common	sched_getparam			sys_sched_getparam
+214	common	sched_setscheduler		sys_sched_setscheduler
+215	common	sched_getscheduler		sys_sched_getscheduler
+216	common	sched_get_priority_max		sys_sched_get_priority_max
+217	common	sched_get_priority_min		sys_sched_get_priority_min
+218	common	sched_rr_get_interval		sys_sched_rr_get_interval_time32
+219	common	sched_yield			sys_sched_yield
+222	common	available222			sys_ni_syscall
+# Signal Handling
+223	common	restart_syscall			sys_restart_syscall
+224	common	sigaltstack			sys_sigaltstack
+225	common	rt_sigreturn			xtensa_rt_sigreturn
+226	common	rt_sigaction			sys_rt_sigaction
+227	common	rt_sigprocmask			sys_rt_sigprocmask
+228	common	rt_sigpending			sys_rt_sigpending
+229	common	rt_sigtimedwait			sys_rt_sigtimedwait_time32
+230	common	rt_sigqueueinfo			sys_rt_sigqueueinfo
+231	common	rt_sigsuspend			sys_rt_sigsuspend
+# Message
+232	common	mq_open				sys_mq_open
+233	common	mq_unlink			sys_mq_unlink
+234	common	mq_timedsend			sys_mq_timedsend_time32
+235	common	mq_timedreceive			sys_mq_timedreceive_time32
+236	common	mq_notify			sys_mq_notify
+237	common	mq_getsetattr			sys_mq_getsetattr
+238	common	available238			sys_ni_syscall
+239	common	io_setup			sys_io_setup
+# IO
+240	common	io_destroy			sys_io_destroy
+241	common	io_submit			sys_io_submit
+242	common	io_getevents			sys_io_getevents_time32
+243	common	io_cancel			sys_io_cancel
+244	common	clock_settime			sys_clock_settime32
+245	common	clock_gettime			sys_clock_gettime32
+246	common	clock_getres			sys_clock_getres_time32
+247	common	clock_nanosleep			sys_clock_nanosleep_time32
+# Timer
+248	common	timer_create			sys_timer_create
+249	common	timer_delete			sys_timer_delete
+250	common	timer_settime			sys_timer_settime32
+251	common	timer_gettime			sys_timer_gettime32
+252	common	timer_getoverrun		sys_timer_getoverrun
+# System
+253	common	reserved253			sys_ni_syscall
+254	common	lookup_dcookie			sys_lookup_dcookie
+255	common	available255			sys_ni_syscall
+256	common	add_key				sys_add_key
+257	common	request_key			sys_request_key
+258	common	keyctl				sys_keyctl
+259	common	available259			sys_ni_syscall
+260	common	readahead			sys_readahead
+261	common	remap_file_pages		sys_remap_file_pages
+262	common	migrate_pages			sys_migrate_pages
+263	common	mbind				sys_mbind
+264	common	get_mempolicy			sys_get_mempolicy
+265	common	set_mempolicy			sys_set_mempolicy
+266	common	unshare				sys_unshare
+267	common	move_pages			sys_move_pages
+268	common	splice				sys_splice
+269	common	tee				sys_tee
+270	common	vmsplice			sys_vmsplice
+271	common	available271			sys_ni_syscall
+272	common	pselect6			sys_pselect6_time32
+273	common	ppoll				sys_ppoll_time32
+274	common	epoll_pwait			sys_epoll_pwait
+275	common	epoll_create1			sys_epoll_create1
+276	common	inotify_init			sys_inotify_init
+277	common	inotify_add_watch		sys_inotify_add_watch
+278	common	inotify_rm_watch		sys_inotify_rm_watch
+279	common	inotify_init1			sys_inotify_init1
+280	common	getcpu				sys_getcpu
+281	common	kexec_load			sys_ni_syscall
+282	common	ioprio_set			sys_ioprio_set
+283	common	ioprio_get			sys_ioprio_get
+284	common	set_robust_list			sys_set_robust_list
+285	common	get_robust_list			sys_get_robust_list
+286	common	available286			sys_ni_syscall
+287	common	available287			sys_ni_syscall
+# Relative File Operations
+288	common	openat				sys_openat
+289	common	mkdirat				sys_mkdirat
+290	common	mknodat				sys_mknodat
+291	common	unlinkat			sys_unlinkat
+292	common	renameat			sys_renameat
+293	common	linkat				sys_linkat
+294	common	symlinkat			sys_symlinkat
+295	common	readlinkat			sys_readlinkat
+296	common	utimensat			sys_utimensat_time32
+297	common	fchownat			sys_fchownat
+298	common	futimesat			sys_futimesat_time32
+299	common	fstatat64			sys_fstatat64
+300	common	fchmodat			sys_fchmodat
+301	common	faccessat			sys_faccessat
+302	common	available302			sys_ni_syscall
+303	common	available303			sys_ni_syscall
+304	common	signalfd			sys_signalfd
+# 305 was timerfd
+306	common	eventfd				sys_eventfd
+307	common	recvmmsg			sys_recvmmsg_time32
+308	common	setns				sys_setns
+309	common	signalfd4			sys_signalfd4
+310	common	dup3				sys_dup3
+311	common	pipe2				sys_pipe2
+312	common	timerfd_create			sys_timerfd_create
+313	common	timerfd_settime			sys_timerfd_settime32
+314	common	timerfd_gettime			sys_timerfd_gettime32
+315	common	available315			sys_ni_syscall
+316	common	eventfd2			sys_eventfd2
+317	common	preadv				sys_preadv
+318	common	pwritev				sys_pwritev
+319	common	available319			sys_ni_syscall
+320	common	fanotify_init			sys_fanotify_init
+321	common	fanotify_mark			sys_fanotify_mark
+322	common	process_vm_readv		sys_process_vm_readv
+323	common	process_vm_writev		sys_process_vm_writev
+324	common	name_to_handle_at		sys_name_to_handle_at
+325	common	open_by_handle_at		sys_open_by_handle_at
+326	common	sync_file_range2		sys_sync_file_range2
+327	common	perf_event_open			sys_perf_event_open
+328	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
+329	common	clock_adjtime			sys_clock_adjtime32
+330	common	prlimit64			sys_prlimit64
+331	common	kcmp				sys_kcmp
+332	common	finit_module			sys_finit_module
+333	common	accept4				sys_accept4
+334	common	sched_setattr			sys_sched_setattr
+335	common	sched_getattr			sys_sched_getattr
+336	common	renameat2			sys_renameat2
+337	common	seccomp				sys_seccomp
+338	common	getrandom			sys_getrandom
+339	common	memfd_create			sys_memfd_create
+340	common	bpf				sys_bpf
+341	common	execveat			sys_execveat
+342	common	userfaultfd			sys_userfaultfd
+343	common	membarrier			sys_membarrier
+344	common	mlock2				sys_mlock2
+345	common	copy_file_range			sys_copy_file_range
+346	common	preadv2				sys_preadv2
+347	common	pwritev2			sys_pwritev2
+348	common	pkey_mprotect			sys_pkey_mprotect
+349	common	pkey_alloc			sys_pkey_alloc
+350	common	pkey_free			sys_pkey_free
+351	common	statx				sys_statx
+352	common	rseq				sys_rseq
+# 353 through 402 are unassigned to sync up with generic numbers
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
diff --git a/linux-user/xtensa/syscall_nr.h b/linux-user/xtensa/syscall_nr.h
deleted file mode 100644
index 39bff65dca08..000000000000
--- a/linux-user/xtensa/syscall_nr.h
+++ /dev/null
@@ -1,469 +0,0 @@
-/*
- * include/asm-xtensa/unistd.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2001 - 2009 Tensilica Inc.
- */
-
-#ifndef XTENSA_SYSCALL_NR_H
-#define XTENSA_SYSCALL_NR_H
-
-#define TARGET_NR_spill                                0
-#define TARGET_NR_xtensa                               1
-#define TARGET_NR_available4                           2
-#define TARGET_NR_available5                           3
-#define TARGET_NR_available6                           4
-#define TARGET_NR_available7                           5
-#define TARGET_NR_available8                           6
-#define TARGET_NR_available9                           7
-
-/* File Operations */
-
-#define TARGET_NR_open                                 8
-#define TARGET_NR_close                                9
-#define TARGET_NR_dup                                 10
-#define TARGET_NR_dup2                                11
-#define TARGET_NR_read                                12
-#define TARGET_NR_write                               13
-#define TARGET_NR_select                              14
-#define TARGET_NR_lseek                               15
-#define TARGET_NR_poll                                16
-#define TARGET_NR__llseek                             17
-#define TARGET_NR_epoll_wait                          18
-#define TARGET_NR_epoll_ctl                           19
-#define TARGET_NR_epoll_create                        20
-#define TARGET_NR_creat                               21
-#define TARGET_NR_truncate                            22
-#define TARGET_NR_ftruncate                           23
-#define TARGET_NR_readv                               24
-#define TARGET_NR_writev                              25
-#define TARGET_NR_fsync                               26
-#define TARGET_NR_fdatasync                           27
-#define TARGET_NR_truncate64                          28
-#define TARGET_NR_ftruncate64                         29
-#define TARGET_NR_pread64                             30
-#define TARGET_NR_pwrite64                            31
-
-#define TARGET_NR_link                                32
-#define TARGET_NR_rename                              33
-#define TARGET_NR_symlink                             34
-#define TARGET_NR_readlink                            35
-#define TARGET_NR_mknod                               36
-#define TARGET_NR_pipe                                37
-#define TARGET_NR_unlink                              38
-#define TARGET_NR_rmdir                               39
-
-#define TARGET_NR_mkdir                               40
-#define TARGET_NR_chdir                               41
-#define TARGET_NR_fchdir                              42
-#define TARGET_NR_getcwd                              43
-
-#define TARGET_NR_chmod                               44
-#define TARGET_NR_chown                               45
-#define TARGET_NR_stat                                46
-#define TARGET_NR_stat64                              47
-
-#define TARGET_NR_lchown                              48
-#define TARGET_NR_lstat                               49
-#define TARGET_NR_lstat64                             50
-#define TARGET_NR_available51                         51
-
-#define TARGET_NR_fchmod                              52
-#define TARGET_NR_fchown                              53
-#define TARGET_NR_fstat                               54
-#define TARGET_NR_fstat64                             55
-
-#define TARGET_NR_flock                               56
-#define TARGET_NR_access                              57
-#define TARGET_NR_umask                               58
-#define TARGET_NR_getdents                            59
-#define TARGET_NR_getdents64                          60
-#define TARGET_NR_fcntl64                             61
-#define TARGET_NR_fallocate                           62
-#define TARGET_NR_fadvise64_64                        63
-#define TARGET_NR_utime                               64     /* glibc 2.3.3 ?? */
-#define TARGET_NR_utimes                              65
-#define TARGET_NR_ioctl                               66
-#define TARGET_NR_fcntl                               67
-
-#define TARGET_NR_setxattr                            68
-#define TARGET_NR_getxattr                            69
-#define TARGET_NR_listxattr                           70
-#define TARGET_NR_removexattr                         71
-#define TARGET_NR_lsetxattr                           72
-#define TARGET_NR_lgetxattr                           73
-#define TARGET_NR_llistxattr                          74
-#define TARGET_NR_lremovexattr                        75
-#define TARGET_NR_fsetxattr                           76
-#define TARGET_NR_fgetxattr                           77
-#define TARGET_NR_flistxattr                          78
-#define TARGET_NR_fremovexattr                        79
-
-/* File Map / Shared Memory Operations */
-
-#define TARGET_NR_mmap2                               80
-#define TARGET_NR_munmap                              81
-#define TARGET_NR_mprotect                            82
-#define TARGET_NR_brk                                 83
-#define TARGET_NR_mlock                               84
-#define TARGET_NR_munlock                             85
-#define TARGET_NR_mlockall                            86
-#define TARGET_NR_munlockall                          87
-#define TARGET_NR_mremap                              88
-#define TARGET_NR_msync                               89
-#define TARGET_NR_mincore                             90
-#define TARGET_NR_madvise                             91
-#define TARGET_NR_shmget                              92
-#define TARGET_NR_shmat                               93
-#define TARGET_NR_shmctl                              94
-#define TARGET_NR_shmdt                               95
-
-/* Socket Operations */
-
-#define TARGET_NR_socket                              96
-#define TARGET_NR_setsockopt                          97
-#define TARGET_NR_getsockopt                          98
-#define TARGET_NR_shutdown                            99
-
-#define TARGET_NR_bind                               100
-#define TARGET_NR_connect                            101
-#define TARGET_NR_listen                             102
-#define TARGET_NR_accept                             103
-
-#define TARGET_NR_getsockname                        104
-#define TARGET_NR_getpeername                        105
-#define TARGET_NR_sendmsg                            106
-#define TARGET_NR_recvmsg                            107
-#define TARGET_NR_send                               108
-#define TARGET_NR_recv                               109
-#define TARGET_NR_sendto                             110
-#define TARGET_NR_recvfrom                           111
-
-#define TARGET_NR_socketpair                         112
-#define TARGET_NR_sendfile                           113
-#define TARGET_NR_sendfile64                         114
-#define TARGET_NR_sendmmsg                           115
-
-/* Process Operations */
-
-#define TARGET_NR_clone                              116
-#define TARGET_NR_execve                             117
-#define TARGET_NR_exit                               118
-#define TARGET_NR_exit_group                         119
-#define TARGET_NR_getpid                             120
-#define TARGET_NR_wait4                              121
-#define TARGET_NR_waitid                             122
-#define TARGET_NR_kill                               123
-#define TARGET_NR_tkill                              124
-#define TARGET_NR_tgkill                             125
-#define TARGET_NR_set_tid_address                    126
-#define TARGET_NR_gettid                             127
-#define TARGET_NR_setsid                             128
-#define TARGET_NR_getsid                             129
-#define TARGET_NR_prctl                              130
-#define TARGET_NR_personality                        131
-#define TARGET_NR_getpriority                        132
-#define TARGET_NR_setpriority                        133
-#define TARGET_NR_setitimer                          134
-#define TARGET_NR_getitimer                          135
-#define TARGET_NR_setuid                             136
-#define TARGET_NR_getuid                             137
-#define TARGET_NR_setgid                             138
-#define TARGET_NR_getgid                             139
-#define TARGET_NR_geteuid                            140
-#define TARGET_NR_getegid                            141
-#define TARGET_NR_setreuid                           142
-#define TARGET_NR_setregid                           143
-#define TARGET_NR_setresuid                          144
-#define TARGET_NR_getresuid                          145
-#define TARGET_NR_setresgid                          146
-#define TARGET_NR_getresgid                          147
-#define TARGET_NR_setpgid                            148
-#define TARGET_NR_getpgid                            149
-#define TARGET_NR_getppid                            150
-#define TARGET_NR_getpgrp                            151
-
-#define TARGET_NR_reserved152                        152     /* set_thread_area */
-#define TARGET_NR_reserved153                        153     /* get_thread_area */
-#define TARGET_NR_times                              154
-#define TARGET_NR_acct                               155
-#define TARGET_NR_sched_setaffinity                  156
-#define TARGET_NR_sched_getaffinity                  157
-#define TARGET_NR_capget                             158
-#define TARGET_NR_capset                             159
-#define TARGET_NR_ptrace                             160
-#define TARGET_NR_semtimedop                         161
-#define TARGET_NR_semget                             162
-#define TARGET_NR_semop                              163
-#define TARGET_NR_semctl                             164
-#define TARGET_NR_available165                       165
-#define TARGET_NR_msgget                             166
-#define TARGET_NR_msgsnd                             167
-#define TARGET_NR_msgrcv                             168
-#define TARGET_NR_msgctl                             169
-#define TARGET_NR_available170                       170
-
-/* File System */
-
-#define TARGET_NR_umount2                            171
-#define TARGET_NR_mount                              172
-#define TARGET_NR_swapon                             173
-#define TARGET_NR_chroot                             174
-#define TARGET_NR_pivot_root                         175
-#define TARGET_NR_umount                             176
-#define TARGET_NR_swapoff                            177
-#define TARGET_NR_sync                               178
-#define TARGET_NR_syncfs                             179
-#define TARGET_NR_setfsuid                           180
-#define TARGET_NR_setfsgid                           181
-#define TARGET_NR_sysfs                              182
-#define TARGET_NR_ustat                              183
-#define TARGET_NR_statfs                             184
-#define TARGET_NR_fstatfs                            185
-#define TARGET_NR_statfs64                           186
-#define TARGET_NR_fstatfs64                          187
-
-/* System */
-
-#define TARGET_NR_setrlimit                          188
-#define TARGET_NR_getrlimit                          189
-#define TARGET_NR_getrusage                          190
-#define TARGET_NR_futex                              191
-#define TARGET_NR_gettimeofday                       192
-#define TARGET_NR_settimeofday                       193
-#define TARGET_NR_adjtimex                           194
-#define TARGET_NR_nanosleep                          195
-#define TARGET_NR_getgroups                          196
-#define TARGET_NR_setgroups                          197
-#define TARGET_NR_sethostname                        198
-#define TARGET_NR_setdomainname                      199
-#define TARGET_NR_syslog                             200
-#define TARGET_NR_vhangup                            201
-#define TARGET_NR_uselib                             202
-#define TARGET_NR_reboot                             203
-#define TARGET_NR_quotactl                           204
-#define TARGET_NR_nfsservctl                         205
-#define TARGET_NR__sysctl                            206
-#define TARGET_NR_bdflush                            207
-#define TARGET_NR_uname                              208
-#define TARGET_NR_sysinfo                            209
-#define TARGET_NR_init_module                        210
-#define TARGET_NR_delete_module                      211
-
-#define TARGET_NR_sched_setparam                     212
-#define TARGET_NR_sched_getparam                     213
-#define TARGET_NR_sched_setscheduler                 214
-#define TARGET_NR_sched_getscheduler                 215
-#define TARGET_NR_sched_get_priority_max             216
-#define TARGET_NR_sched_get_priority_min             217
-#define TARGET_NR_sched_rr_get_interval              218
-#define TARGET_NR_sched_yield                        219
-#define TARGET_NR_available222                       222
-
-/* Signal Handling */
-
-#define TARGET_NR_restart_syscall                    223
-#define TARGET_NR_sigaltstack                        224
-#define TARGET_NR_rt_sigreturn                       225
-#define TARGET_NR_rt_sigaction                       226
-#define TARGET_NR_rt_sigprocmask                     227
-#define TARGET_NR_rt_sigpending                      228
-#define TARGET_NR_rt_sigtimedwait                    229
-#define TARGET_NR_rt_sigqueueinfo                    230
-#define TARGET_NR_rt_sigsuspend                      231
-
-/* Message */
-
-#define TARGET_NR_mq_open                            232
-#define TARGET_NR_mq_unlink                          233
-#define TARGET_NR_mq_timedsend                       234
-#define TARGET_NR_mq_timedreceive                    235
-#define TARGET_NR_mq_notify                          236
-#define TARGET_NR_mq_getsetattr                      237
-#define TARGET_NR_available238                       238
-
-/* IO */
-
-#define TARGET_NR_io_setup                           239
-#define TARGET_NR_io_destroy                         240
-#define TARGET_NR_io_submit                          241
-#define TARGET_NR_io_getevents                       242
-#define TARGET_NR_io_cancel                          243
-#define TARGET_NR_clock_settime                      244
-#define TARGET_NR_clock_gettime                      245
-#define TARGET_NR_clock_getres                       246
-#define TARGET_NR_clock_nanosleep                    247
-
-/* Timer */
-
-#define TARGET_NR_timer_create                       248
-#define TARGET_NR_timer_delete                       249
-#define TARGET_NR_timer_settime                      250
-#define TARGET_NR_timer_gettime                      251
-#define TARGET_NR_timer_getoverrun                   252
-
-/* System */
-
-#define TARGET_NR_reserved253                        253
-#define TARGET_NR_lookup_dcookie                     254
-#define TARGET_NR_available255                       255
-#define TARGET_NR_add_key                            256
-#define TARGET_NR_request_key                        257
-#define TARGET_NR_keyctl                             258
-#define TARGET_NR_available259                       259
-
-
-#define TARGET_NR_readahead                          260
-#define TARGET_NR_remap_file_pages                   261
-#define TARGET_NR_migrate_pages                      262
-#define TARGET_NR_mbind                              263
-#define TARGET_NR_get_mempolicy                      264
-#define TARGET_NR_set_mempolicy                      265
-#define TARGET_NR_unshare                            266
-#define TARGET_NR_move_pages                         267
-#define TARGET_NR_splice                             268
-#define TARGET_NR_tee                                269
-#define TARGET_NR_vmsplice                           270
-#define TARGET_NR_available271                       271
-
-#define TARGET_NR_pselect6                           272
-#define TARGET_NR_ppoll                              273
-#define TARGET_NR_epoll_pwait                        274
-#define TARGET_NR_epoll_create1                      275
-
-#define TARGET_NR_inotify_init                       276
-#define TARGET_NR_inotify_add_watch                  277
-#define TARGET_NR_inotify_rm_watch                   278
-#define TARGET_NR_inotify_init1                      279
-
-#define TARGET_NR_getcpu                             280
-#define TARGET_NR_kexec_load                         281
-
-#define TARGET_NR_ioprio_set                         282
-#define TARGET_NR_ioprio_get                         283
-
-#define TARGET_NR_set_robust_list                    284
-#define TARGET_NR_get_robust_list                    285
-#define TARGET_NR_available286                       286
-#define TARGET_NR_available287                       287
-
-/* Relative File Operations */
-
-#define TARGET_NR_openat                             288
-#define TARGET_NR_mkdirat                            289
-#define TARGET_NR_mknodat                            290
-#define TARGET_NR_unlinkat                           291
-#define TARGET_NR_renameat                           292
-#define TARGET_NR_linkat                             293
-#define TARGET_NR_symlinkat                          294
-#define TARGET_NR_readlinkat                         295
-#define TARGET_NR_utimensat                          296
-#define TARGET_NR_fchownat                           297
-#define TARGET_NR_futimesat                          298
-#define TARGET_NR_fstatat64                          299
-#define TARGET_NR_fchmodat                           300
-#define TARGET_NR_faccessat                          301
-#define TARGET_NR_available302                       302
-#define TARGET_NR_available303                       303
-
-#define TARGET_NR_signalfd                           304
-/*  305 was TARGET_NR_timerfd  */
-#define TARGET_NR_eventfd                            306
-#define TARGET_NR_recvmmsg                           307
-
-#define TARGET_NR_setns                              308
-#define TARGET_NR_signalfd4                          309
-#define TARGET_NR_dup3                               310
-#define TARGET_NR_pipe2                              311
-
-#define TARGET_NR_timerfd_create                     312
-#define TARGET_NR_timerfd_settime                    313
-#define TARGET_NR_timerfd_gettime                    314
-#define TARGET_NR_available315                       315
-
-#define TARGET_NR_eventfd2                           316
-#define TARGET_NR_preadv                             317
-#define TARGET_NR_pwritev                            318
-#define TARGET_NR_available319                       319
-
-#define TARGET_NR_fanotify_init                      320
-#define TARGET_NR_fanotify_mark                      321
-#define TARGET_NR_process_vm_readv                   322
-#define TARGET_NR_process_vm_writev                  323
-
-#define TARGET_NR_name_to_handle_at                  324
-#define TARGET_NR_open_by_handle_at                  325
-#define TARGET_NR_sync_file_range2                   326
-#define TARGET_NR_perf_event_open                    327
-
-#define TARGET_NR_rt_tgsigqueueinfo                  328
-#define TARGET_NR_clock_adjtime                      329
-#define TARGET_NR_prlimit64                          330
-#define TARGET_NR_kcmp                               331
-
-#define TARGET_NR_finit_module                       332
-
-#define TARGET_NR_accept4                            333
-
-#define TARGET_NR_sched_setattr                      334
-#define TARGET_NR_sched_getattr                      335
-
-#define TARGET_NR_renameat2                          336
-
-#define TARGET_NR_seccomp                            337
-#define TARGET_NR_getrandom                          338
-#define TARGET_NR_memfd_create                       339
-#define TARGET_NR_bpf                                340
-#define TARGET_NR_execveat                           341
-
-#define TARGET_NR_userfaultfd                        342
-#define TARGET_NR_membarrier                         343
-#define TARGET_NR_mlock2                             344
-#define TARGET_NR_copy_file_range                    345
-#define TARGET_NR_preadv2                            346
-#define TARGET_NR_pwritev2                           347
-
-#define TARGET_NR_pkey_mprotect                      348
-#define TARGET_NR_pkey_alloc                         349
-#define TARGET_NR_pkey_free                          350
-
-#define TARGET_NR_statx                              351
-#define TARGET_NR_rseq                               352
-/* 353 through 402 are unassigned to sync up with generic numbers */
-#define TARGET_NR_clock_gettime64                    403
-#define TARGET_NR_clock_settime64                    404
-#define TARGET_NR_clock_adjtime64                    405
-#define TARGET_NR_clock_getres_time64                406
-#define TARGET_NR_clock_nanosleep_time64             407
-#define TARGET_NR_timer_gettime64                    408
-#define TARGET_NR_timer_settime64                    409
-#define TARGET_NR_timerfd_gettime64                  410
-#define TARGET_NR_timerfd_settime64                  411
-#define TARGET_NR_utimensat_time64                   412
-#define TARGET_NR_pselect6_time64                    413
-#define TARGET_NR_ppoll_time64                       414
-#define TARGET_NR_io_pgetevents_time64               416
-#define TARGET_NR_recvmmsg_time64                    417
-#define TARGET_NR_mq_timedsend_time64                418
-#define TARGET_NR_mq_timedreceive_time64             419
-#define TARGET_NR_semtimedop_time64                  420
-#define TARGET_NR_rt_sigtimedwait_time64             421
-#define TARGET_NR_futex_time64                       422
-#define TARGET_NR_sched_rr_get_interval_time64       423
-#define TARGET_NR_pidfd_send_signal                  424
-#define TARGET_NR_io_uring_setup                     425
-#define TARGET_NR_io_uring_enter                     426
-#define TARGET_NR_io_uring_register                  427
-#define TARGET_NR_open_tree                          428
-#define TARGET_NR_move_mount                         429
-#define TARGET_NR_fsopen                             430
-#define TARGET_NR_fsconfig                           431
-#define TARGET_NR_fsmount                            432
-#define TARGET_NR_fspick                             433
-#define TARGET_NR_pidfd_open                         434
-#define TARGET_NR_clone3                             435
-
-#endif /* XTENSA_SYSCALL_NR_H */
diff --git a/linux-user/xtensa/syscallhdr.sh b/linux-user/xtensa/syscallhdr.sh
new file mode 100644
index 000000000000..eef0644c9431
--- /dev/null
+++ b/linux-user/xtensa/syscallhdr.sh
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
+fileguard=LINUX_USER_XTENSA_`basename "$out" | sed \
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


