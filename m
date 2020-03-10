Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6803AC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDD32071B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDD32071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcNi-0000Vg-7C
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBcEU-0004rr-Ts
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBcEN-0000s0-6v
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:35:30 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50147)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBcE8-0000Hq-Pk; Tue, 10 Mar 2020 06:35:09 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MiaLn-1jnRLA1gjH-00fhTe; Tue, 10 Mar 2020 11:34:12 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/21] linux-user,
 alpha: add syscall table generation support
Date: Tue, 10 Mar 2020 11:33:44 +0100
Message-Id: <20200310103403.3284090-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310103403.3284090-1-laurent@vivier.eu>
References: <20200310103403.3284090-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VR+CEtnzP5j29QTa8UnsJNh1rsdS/+fsZ5eAx737Lgy2JwHv+kB
 xi9nYuOBSjKcZIXgvl1mjpHoJw6vXa/D3Glc6PnuBCorP4lHjTW4Y3bBb8ON1NYVBVAOE+H
 rKm6KMfjJ1THWVfd1vNWI6fiFxVYjxS+103qBQsDq94MRMzOZriqD5oz/g2JxONByVNXtlX
 wI62ilGx6sa3DXl1J06/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VelMNjODwGM=:UO8W2284CBCHb/8qrpWMUv
 4IKPC8qDn90nW9X9P61YCErCj6qwDc0be5ZdniuSNlpKh4fRWS9SAV6Vv1tdJjTsRktzlZK3o
 S5NQSybVU+8GSKLT6DN+F/thqOcDchAC6pZ23pL4nMcIby3QM5/yDNmI6Pk/CZecI6MXq7I1C
 vIiGJSX1wL2sbde8r95XjclnFaEmOooR39OQeBwqGcdZq0ElbuSIXLOOu3MMsIoHQc8ukON5D
 qwH2s9OJaqLb5ZYWCfdBo9wQOwRfgXrBkZs7VdOw8FV6qqLgrTLDxv+C/V3o8m/7H8UCPfAxl
 +Ygj8QihrgctD+WnpmD/9v1056S0wY4eYjDMvIeUCg/pi1HUob/5NDY6S1urkREBQmSUr4fOn
 MFIHn6yFyqL+oLCPk1/Fp/nLmZ8V810I+pVzuUv21oyLP2Zuvm/wYlHz4P3ZvJajSrVvf1ljP
 4GdnWTfQO4CcVkzz3kRpiguseXNXx9nKCl4hK1LF3lBYI3A+5CNOh+wXGEEUtjSCNl1fpCIkq
 wssfnfyWkFPTe67E0l1QqPLU1Fqqu7UFzX86AWZfj5O+BGjJ0g0hTeRX4DCJqxPIs6VqnwjQA
 gGECrUxXLZHPmREfcgI446VOhjlcqumT0zlbrENbtL0nU2MKVb68JLDIqmSiEGwhNPOPtZSWY
 +ac1dkMXM0Zo/R4T4TUPro7d4XEs7HXcS6ScNLvGqvW87NfjZxIR92GSNbHAwIeM584lFVtKY
 VQIZBLT7mlyGl2R15u4HO7wr7nHWt9FOKCiVX5gJQYBDxflPEVsXANcamNEMq+HAPYRiGoftt
 vdbSSWjy3jcHLnvGYEhyHCk/dKiYYJRgPt3VnD4GIuWI8Bjld/b6NJZOt/yMBTjSA5vMjww
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

Copy syscall.tbl and syscallhdr.sh from linux/arch/alpha/kernel/syscalls v5.5
Update syscallhdr.sh to generate QEMU syscall_nr.h

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
---
 configure                      |   3 +-
 linux-user/Makefile.objs       |   2 +
 linux-user/alpha/Makefile.objs |   5 +
 linux-user/alpha/syscall.tbl   | 479 ++++++++++++++++++++++++++++++++
 linux-user/alpha/syscall_nr.h  | 492 ---------------------------------
 linux-user/alpha/syscallhdr.sh |  32 +++
 6 files changed, 520 insertions(+), 493 deletions(-)
 create mode 100644 linux-user/alpha/Makefile.objs
 create mode 100644 linux-user/alpha/syscall.tbl
 delete mode 100644 linux-user/alpha/syscall_nr.h
 create mode 100644 linux-user/alpha/syscallhdr.sh

diff --git a/configure b/configure
index 39e55a1ecf06..5a024d249008 100755
--- a/configure
+++ b/configure
@@ -1889,7 +1889,7 @@ rm -f */config-devices.mak.d
 
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
-for arch in ; do
+for arch in alpha ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
@@ -7795,6 +7795,7 @@ case "$target_name" in
   ;;
   alpha)
     mttcg="yes"
+    TARGET_SYSTBL_ABI=common
   ;;
   arm|armeb)
     TARGET_ARCH=arm
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index d2f33beb5e52..a1afb4d21f9f 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -8,3 +8,5 @@ obj-$(TARGET_I386) += vm86.o
 obj-$(TARGET_ARM) += arm/nwfpe/
 obj-$(TARGET_ARM) += arm/semihost.o
 obj-$(TARGET_AARCH64) += arm/semihost.o
+
+obj-$(TARGET_ALPHA) += alpha/
diff --git a/linux-user/alpha/Makefile.objs b/linux-user/alpha/Makefile.objs
new file mode 100644
index 000000000000..d6397a70abb2
--- /dev/null
+++ b/linux-user/alpha/Makefile.objs
@@ -0,0 +1,5 @@
+generated-files-y += linux-user/alpha/syscall_nr.h
+
+syshdr := $(SRC_PATH)/linux-user/alpha/syscallhdr.sh
+%/syscall_nr.h: $(SRC_PATH)/linux-user/alpha/syscall.tbl $(syshdr)
+	$(call quiet-command, sh $(syshdr) $< $@ $(TARGET_SYSTBL_ABI),"GEN","$@")
diff --git a/linux-user/alpha/syscall.tbl b/linux-user/alpha/syscall.tbl
new file mode 100644
index 000000000000..36d42da7466a
--- /dev/null
+++ b/linux-user/alpha/syscall.tbl
@@ -0,0 +1,479 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for alpha
+#
+# The format is:
+# <number> <abi> <name> <entry point>
+#
+# The <abi> is always "common" for this file
+#
+0	common	osf_syscall			alpha_syscall_zero
+1	common	exit				sys_exit
+2	common	fork				alpha_fork
+3	common	read				sys_read
+4	common	write				sys_write
+5	common	osf_old_open			sys_ni_syscall
+6	common	close				sys_close
+7	common	osf_wait4			sys_osf_wait4
+8	common	osf_old_creat			sys_ni_syscall
+9	common	link				sys_link
+10	common	unlink				sys_unlink
+11	common	osf_execve			sys_ni_syscall
+12	common	chdir				sys_chdir
+13	common	fchdir				sys_fchdir
+14	common	mknod				sys_mknod
+15	common	chmod				sys_chmod
+16	common	chown				sys_chown
+17	common	brk				sys_osf_brk
+18	common	osf_getfsstat			sys_ni_syscall
+19	common	lseek				sys_lseek
+20	common	getxpid				sys_getxpid
+21	common	osf_mount			sys_osf_mount
+22	common	umount2				sys_umount
+23	common	setuid				sys_setuid
+24	common	getxuid				sys_getxuid
+25	common	exec_with_loader		sys_ni_syscall
+26	common	ptrace				sys_ptrace
+27	common	osf_nrecvmsg			sys_ni_syscall
+28	common	osf_nsendmsg			sys_ni_syscall
+29	common	osf_nrecvfrom			sys_ni_syscall
+30	common	osf_naccept			sys_ni_syscall
+31	common	osf_ngetpeername		sys_ni_syscall
+32	common	osf_ngetsockname		sys_ni_syscall
+33	common	access				sys_access
+34	common	osf_chflags			sys_ni_syscall
+35	common	osf_fchflags			sys_ni_syscall
+36	common	sync				sys_sync
+37	common	kill				sys_kill
+38	common	osf_old_stat			sys_ni_syscall
+39	common	setpgid				sys_setpgid
+40	common	osf_old_lstat			sys_ni_syscall
+41	common	dup				sys_dup
+42	common	pipe				sys_alpha_pipe
+43	common	osf_set_program_attributes	sys_osf_set_program_attributes
+44	common	osf_profil			sys_ni_syscall
+45	common	open				sys_open
+46	common	osf_old_sigaction		sys_ni_syscall
+47	common	getxgid				sys_getxgid
+48	common	osf_sigprocmask			sys_osf_sigprocmask
+49	common	osf_getlogin			sys_ni_syscall
+50	common	osf_setlogin			sys_ni_syscall
+51	common	acct				sys_acct
+52	common	sigpending			sys_sigpending
+54	common	ioctl				sys_ioctl
+55	common	osf_reboot			sys_ni_syscall
+56	common	osf_revoke			sys_ni_syscall
+57	common	symlink				sys_symlink
+58	common	readlink			sys_readlink
+59	common	execve				sys_execve
+60	common	umask				sys_umask
+61	common	chroot				sys_chroot
+62	common	osf_old_fstat			sys_ni_syscall
+63	common	getpgrp				sys_getpgrp
+64	common	getpagesize			sys_getpagesize
+65	common	osf_mremap			sys_ni_syscall
+66	common	vfork				alpha_vfork
+67	common	stat				sys_newstat
+68	common	lstat				sys_newlstat
+69	common	osf_sbrk			sys_ni_syscall
+70	common	osf_sstk			sys_ni_syscall
+71	common	mmap				sys_osf_mmap
+72	common	osf_old_vadvise			sys_ni_syscall
+73	common	munmap				sys_munmap
+74	common	mprotect			sys_mprotect
+75	common	madvise				sys_madvise
+76	common	vhangup				sys_vhangup
+77	common	osf_kmodcall			sys_ni_syscall
+78	common	osf_mincore			sys_ni_syscall
+79	common	getgroups			sys_getgroups
+80	common	setgroups			sys_setgroups
+81	common	osf_old_getpgrp			sys_ni_syscall
+82	common	setpgrp				sys_setpgid
+83	common	osf_setitimer			compat_sys_setitimer
+84	common	osf_old_wait			sys_ni_syscall
+85	common	osf_table			sys_ni_syscall
+86	common	osf_getitimer			compat_sys_getitimer
+87	common	gethostname			sys_gethostname
+88	common	sethostname			sys_sethostname
+89	common	getdtablesize			sys_getdtablesize
+90	common	dup2				sys_dup2
+91	common	fstat				sys_newfstat
+92	common	fcntl				sys_fcntl
+93	common	osf_select			sys_osf_select
+94	common	poll				sys_poll
+95	common	fsync				sys_fsync
+96	common	setpriority			sys_setpriority
+97	common	socket				sys_socket
+98	common	connect				sys_connect
+99	common	accept				sys_accept
+100	common	getpriority			sys_osf_getpriority
+101	common	send				sys_send
+102	common	recv				sys_recv
+103	common	sigreturn			sys_sigreturn
+104	common	bind				sys_bind
+105	common	setsockopt			sys_setsockopt
+106	common	listen				sys_listen
+107	common	osf_plock			sys_ni_syscall
+108	common	osf_old_sigvec			sys_ni_syscall
+109	common	osf_old_sigblock		sys_ni_syscall
+110	common	osf_old_sigsetmask		sys_ni_syscall
+111	common	sigsuspend			sys_sigsuspend
+112	common	osf_sigstack			sys_osf_sigstack
+113	common	recvmsg				sys_recvmsg
+114	common	sendmsg				sys_sendmsg
+115	common	osf_old_vtrace			sys_ni_syscall
+116	common	osf_gettimeofday		sys_osf_gettimeofday
+117	common	osf_getrusage			sys_osf_getrusage
+118	common	getsockopt			sys_getsockopt
+120	common	readv				sys_osf_readv
+121	common	writev				sys_osf_writev
+122	common	osf_settimeofday		sys_osf_settimeofday
+123	common	fchown				sys_fchown
+124	common	fchmod				sys_fchmod
+125	common	recvfrom			sys_recvfrom
+126	common	setreuid			sys_setreuid
+127	common	setregid			sys_setregid
+128	common	rename				sys_rename
+129	common	truncate			sys_truncate
+130	common	ftruncate			sys_ftruncate
+131	common	flock				sys_flock
+132	common	setgid				sys_setgid
+133	common	sendto				sys_sendto
+134	common	shutdown			sys_shutdown
+135	common	socketpair			sys_socketpair
+136	common	mkdir				sys_mkdir
+137	common	rmdir				sys_rmdir
+138	common	osf_utimes			sys_osf_utimes
+139	common	osf_old_sigreturn		sys_ni_syscall
+140	common	osf_adjtime			sys_ni_syscall
+141	common	getpeername			sys_getpeername
+142	common	osf_gethostid			sys_ni_syscall
+143	common	osf_sethostid			sys_ni_syscall
+144	common	getrlimit			sys_getrlimit
+145	common	setrlimit			sys_setrlimit
+146	common	osf_old_killpg			sys_ni_syscall
+147	common	setsid				sys_setsid
+148	common	quotactl			sys_quotactl
+149	common	osf_oldquota			sys_ni_syscall
+150	common	getsockname			sys_getsockname
+153	common	osf_pid_block			sys_ni_syscall
+154	common	osf_pid_unblock			sys_ni_syscall
+156	common	sigaction			sys_osf_sigaction
+157	common	osf_sigwaitprim			sys_ni_syscall
+158	common	osf_nfssvc			sys_ni_syscall
+159	common	osf_getdirentries		sys_osf_getdirentries
+160	common	osf_statfs			sys_osf_statfs
+161	common	osf_fstatfs			sys_osf_fstatfs
+163	common	osf_asynch_daemon		sys_ni_syscall
+164	common	osf_getfh			sys_ni_syscall
+165	common	osf_getdomainname		sys_osf_getdomainname
+166	common	setdomainname			sys_setdomainname
+169	common	osf_exportfs			sys_ni_syscall
+181	common	osf_alt_plock			sys_ni_syscall
+184	common	osf_getmnt			sys_ni_syscall
+187	common	osf_alt_sigpending		sys_ni_syscall
+188	common	osf_alt_setsid			sys_ni_syscall
+199	common	osf_swapon			sys_swapon
+200	common	msgctl				sys_old_msgctl
+201	common	msgget				sys_msgget
+202	common	msgrcv				sys_msgrcv
+203	common	msgsnd				sys_msgsnd
+204	common	semctl				sys_old_semctl
+205	common	semget				sys_semget
+206	common	semop				sys_semop
+207	common	osf_utsname			sys_osf_utsname
+208	common	lchown				sys_lchown
+209	common	shmat				sys_shmat
+210	common	shmctl				sys_old_shmctl
+211	common	shmdt				sys_shmdt
+212	common	shmget				sys_shmget
+213	common	osf_mvalid			sys_ni_syscall
+214	common	osf_getaddressconf		sys_ni_syscall
+215	common	osf_msleep			sys_ni_syscall
+216	common	osf_mwakeup			sys_ni_syscall
+217	common	msync				sys_msync
+218	common	osf_signal			sys_ni_syscall
+219	common	osf_utc_gettime			sys_ni_syscall
+220	common	osf_utc_adjtime			sys_ni_syscall
+222	common	osf_security			sys_ni_syscall
+223	common	osf_kloadcall			sys_ni_syscall
+224	common	osf_stat			sys_osf_stat
+225	common	osf_lstat			sys_osf_lstat
+226	common	osf_fstat			sys_osf_fstat
+227	common	osf_statfs64			sys_osf_statfs64
+228	common	osf_fstatfs64			sys_osf_fstatfs64
+233	common	getpgid				sys_getpgid
+234	common	getsid				sys_getsid
+235	common	sigaltstack			sys_sigaltstack
+236	common	osf_waitid			sys_ni_syscall
+237	common	osf_priocntlset			sys_ni_syscall
+238	common	osf_sigsendset			sys_ni_syscall
+239	common	osf_set_speculative		sys_ni_syscall
+240	common	osf_msfs_syscall		sys_ni_syscall
+241	common	osf_sysinfo			sys_osf_sysinfo
+242	common	osf_uadmin			sys_ni_syscall
+243	common	osf_fuser			sys_ni_syscall
+244	common	osf_proplist_syscall		sys_osf_proplist_syscall
+245	common	osf_ntp_adjtime			sys_ni_syscall
+246	common	osf_ntp_gettime			sys_ni_syscall
+247	common	osf_pathconf			sys_ni_syscall
+248	common	osf_fpathconf			sys_ni_syscall
+250	common	osf_uswitch			sys_ni_syscall
+251	common	osf_usleep_thread		sys_osf_usleep_thread
+252	common	osf_audcntl			sys_ni_syscall
+253	common	osf_audgen			sys_ni_syscall
+254	common	sysfs				sys_sysfs
+255	common	osf_subsys_info			sys_ni_syscall
+256	common	osf_getsysinfo			sys_osf_getsysinfo
+257	common	osf_setsysinfo			sys_osf_setsysinfo
+258	common	osf_afs_syscall			sys_ni_syscall
+259	common	osf_swapctl			sys_ni_syscall
+260	common	osf_memcntl			sys_ni_syscall
+261	common	osf_fdatasync			sys_ni_syscall
+300	common	bdflush				sys_bdflush
+301	common	sethae				sys_sethae
+302	common	mount				sys_mount
+303	common	old_adjtimex			sys_old_adjtimex
+304	common	swapoff				sys_swapoff
+305	common	getdents			sys_getdents
+306	common	create_module			sys_ni_syscall
+307	common	init_module			sys_init_module
+308	common	delete_module			sys_delete_module
+309	common	get_kernel_syms			sys_ni_syscall
+310	common	syslog				sys_syslog
+311	common	reboot				sys_reboot
+312	common	clone				alpha_clone
+313	common	uselib				sys_uselib
+314	common	mlock				sys_mlock
+315	common	munlock				sys_munlock
+316	common	mlockall			sys_mlockall
+317	common	munlockall			sys_munlockall
+318	common	sysinfo				sys_sysinfo
+319	common	_sysctl				sys_sysctl
+# 320 was sys_idle
+321	common	oldumount			sys_oldumount
+322	common	swapon				sys_swapon
+323	common	times				sys_times
+324	common	personality			sys_personality
+325	common	setfsuid			sys_setfsuid
+326	common	setfsgid			sys_setfsgid
+327	common	ustat				sys_ustat
+328	common	statfs				sys_statfs
+329	common	fstatfs				sys_fstatfs
+330	common	sched_setparam			sys_sched_setparam
+331	common	sched_getparam			sys_sched_getparam
+332	common	sched_setscheduler		sys_sched_setscheduler
+333	common	sched_getscheduler		sys_sched_getscheduler
+334	common	sched_yield			sys_sched_yield
+335	common	sched_get_priority_max		sys_sched_get_priority_max
+336	common	sched_get_priority_min		sys_sched_get_priority_min
+337	common	sched_rr_get_interval		sys_sched_rr_get_interval
+338	common	afs_syscall			sys_ni_syscall
+339	common	uname				sys_newuname
+340	common	nanosleep			sys_nanosleep
+341	common	mremap				sys_mremap
+342	common	nfsservctl			sys_ni_syscall
+343	common	setresuid			sys_setresuid
+344	common	getresuid			sys_getresuid
+345	common	pciconfig_read			sys_pciconfig_read
+346	common	pciconfig_write			sys_pciconfig_write
+347	common	query_module			sys_ni_syscall
+348	common	prctl				sys_prctl
+349	common	pread64				sys_pread64
+350	common	pwrite64			sys_pwrite64
+351	common	rt_sigreturn			sys_rt_sigreturn
+352	common	rt_sigaction			sys_rt_sigaction
+353	common	rt_sigprocmask			sys_rt_sigprocmask
+354	common	rt_sigpending			sys_rt_sigpending
+355	common	rt_sigtimedwait			sys_rt_sigtimedwait
+356	common	rt_sigqueueinfo			sys_rt_sigqueueinfo
+357	common	rt_sigsuspend			sys_rt_sigsuspend
+358	common	select				sys_select
+359	common	gettimeofday			sys_gettimeofday
+360	common	settimeofday			sys_settimeofday
+361	common	getitimer			sys_getitimer
+362	common	setitimer			sys_setitimer
+363	common	utimes				sys_utimes
+364	common	getrusage			sys_getrusage
+365	common	wait4				sys_wait4
+366	common	adjtimex			sys_adjtimex
+367	common	getcwd				sys_getcwd
+368	common	capget				sys_capget
+369	common	capset				sys_capset
+370	common	sendfile			sys_sendfile64
+371	common	setresgid			sys_setresgid
+372	common	getresgid			sys_getresgid
+373	common	dipc				sys_ni_syscall
+374	common	pivot_root			sys_pivot_root
+375	common	mincore				sys_mincore
+376	common	pciconfig_iobase		sys_pciconfig_iobase
+377	common	getdents64			sys_getdents64
+378	common	gettid				sys_gettid
+379	common	readahead			sys_readahead
+# 380 is unused
+381	common	tkill				sys_tkill
+382	common	setxattr			sys_setxattr
+383	common	lsetxattr			sys_lsetxattr
+384	common	fsetxattr			sys_fsetxattr
+385	common	getxattr			sys_getxattr
+386	common	lgetxattr			sys_lgetxattr
+387	common	fgetxattr			sys_fgetxattr
+388	common	listxattr			sys_listxattr
+389	common	llistxattr			sys_llistxattr
+390	common	flistxattr			sys_flistxattr
+391	common	removexattr			sys_removexattr
+392	common	lremovexattr			sys_lremovexattr
+393	common	fremovexattr			sys_fremovexattr
+394	common	futex				sys_futex
+395	common	sched_setaffinity		sys_sched_setaffinity
+396	common	sched_getaffinity		sys_sched_getaffinity
+397	common	tuxcall				sys_ni_syscall
+398	common	io_setup			sys_io_setup
+399	common	io_destroy			sys_io_destroy
+400	common	io_getevents			sys_io_getevents
+401	common	io_submit			sys_io_submit
+402	common	io_cancel			sys_io_cancel
+405	common	exit_group			sys_exit_group
+406	common	lookup_dcookie			sys_lookup_dcookie
+407	common	epoll_create			sys_epoll_create
+408	common	epoll_ctl			sys_epoll_ctl
+409	common	epoll_wait			sys_epoll_wait
+410	common	remap_file_pages		sys_remap_file_pages
+411	common	set_tid_address			sys_set_tid_address
+412	common	restart_syscall			sys_restart_syscall
+413	common	fadvise64			sys_fadvise64
+414	common	timer_create			sys_timer_create
+415	common	timer_settime			sys_timer_settime
+416	common	timer_gettime			sys_timer_gettime
+417	common	timer_getoverrun		sys_timer_getoverrun
+418	common	timer_delete			sys_timer_delete
+419	common	clock_settime			sys_clock_settime
+420	common	clock_gettime			sys_clock_gettime
+421	common	clock_getres			sys_clock_getres
+422	common	clock_nanosleep			sys_clock_nanosleep
+423	common	semtimedop			sys_semtimedop
+424	common	tgkill				sys_tgkill
+425	common	stat64				sys_stat64
+426	common	lstat64				sys_lstat64
+427	common	fstat64				sys_fstat64
+428	common	vserver				sys_ni_syscall
+429	common	mbind				sys_ni_syscall
+430	common	get_mempolicy			sys_ni_syscall
+431	common	set_mempolicy			sys_ni_syscall
+432	common	mq_open				sys_mq_open
+433	common	mq_unlink			sys_mq_unlink
+434	common	mq_timedsend			sys_mq_timedsend
+435	common	mq_timedreceive			sys_mq_timedreceive
+436	common	mq_notify			sys_mq_notify
+437	common	mq_getsetattr			sys_mq_getsetattr
+438	common	waitid				sys_waitid
+439	common	add_key				sys_add_key
+440	common	request_key			sys_request_key
+441	common	keyctl				sys_keyctl
+442	common	ioprio_set			sys_ioprio_set
+443	common	ioprio_get			sys_ioprio_get
+444	common	inotify_init			sys_inotify_init
+445	common	inotify_add_watch		sys_inotify_add_watch
+446	common	inotify_rm_watch		sys_inotify_rm_watch
+447	common	fdatasync			sys_fdatasync
+448	common	kexec_load			sys_kexec_load
+449	common	migrate_pages			sys_migrate_pages
+450	common	openat				sys_openat
+451	common	mkdirat				sys_mkdirat
+452	common	mknodat				sys_mknodat
+453	common	fchownat			sys_fchownat
+454	common	futimesat			sys_futimesat
+455	common	fstatat64			sys_fstatat64
+456	common	unlinkat			sys_unlinkat
+457	common	renameat			sys_renameat
+458	common	linkat				sys_linkat
+459	common	symlinkat			sys_symlinkat
+460	common	readlinkat			sys_readlinkat
+461	common	fchmodat			sys_fchmodat
+462	common	faccessat			sys_faccessat
+463	common	pselect6			sys_pselect6
+464	common	ppoll				sys_ppoll
+465	common	unshare				sys_unshare
+466	common	set_robust_list			sys_set_robust_list
+467	common	get_robust_list			sys_get_robust_list
+468	common	splice				sys_splice
+469	common	sync_file_range			sys_sync_file_range
+470	common	tee				sys_tee
+471	common	vmsplice			sys_vmsplice
+472	common	move_pages			sys_move_pages
+473	common	getcpu				sys_getcpu
+474	common	epoll_pwait			sys_epoll_pwait
+475	common	utimensat			sys_utimensat
+476	common	signalfd			sys_signalfd
+477	common	timerfd				sys_ni_syscall
+478	common	eventfd				sys_eventfd
+479	common	recvmmsg			sys_recvmmsg
+480	common	fallocate			sys_fallocate
+481	common	timerfd_create			sys_timerfd_create
+482	common	timerfd_settime			sys_timerfd_settime
+483	common	timerfd_gettime			sys_timerfd_gettime
+484	common	signalfd4			sys_signalfd4
+485	common	eventfd2			sys_eventfd2
+486	common	epoll_create1			sys_epoll_create1
+487	common	dup3				sys_dup3
+488	common	pipe2				sys_pipe2
+489	common	inotify_init1			sys_inotify_init1
+490	common	preadv				sys_preadv
+491	common	pwritev				sys_pwritev
+492	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo
+493	common	perf_event_open			sys_perf_event_open
+494	common	fanotify_init			sys_fanotify_init
+495	common	fanotify_mark			sys_fanotify_mark
+496	common	prlimit64			sys_prlimit64
+497	common	name_to_handle_at		sys_name_to_handle_at
+498	common	open_by_handle_at		sys_open_by_handle_at
+499	common	clock_adjtime			sys_clock_adjtime
+500	common	syncfs				sys_syncfs
+501	common	setns				sys_setns
+502	common	accept4				sys_accept4
+503	common	sendmmsg			sys_sendmmsg
+504	common	process_vm_readv		sys_process_vm_readv
+505	common	process_vm_writev		sys_process_vm_writev
+506	common	kcmp				sys_kcmp
+507	common	finit_module			sys_finit_module
+508	common	sched_setattr			sys_sched_setattr
+509	common	sched_getattr			sys_sched_getattr
+510	common	renameat2			sys_renameat2
+511	common	getrandom			sys_getrandom
+512	common	memfd_create			sys_memfd_create
+513	common	execveat			sys_execveat
+514	common	seccomp				sys_seccomp
+515	common	bpf				sys_bpf
+516	common	userfaultfd			sys_userfaultfd
+517	common	membarrier			sys_membarrier
+518	common	mlock2				sys_mlock2
+519	common	copy_file_range			sys_copy_file_range
+520	common	preadv2				sys_preadv2
+521	common	pwritev2			sys_pwritev2
+522	common	statx				sys_statx
+523	common	io_pgetevents			sys_io_pgetevents
+524	common	pkey_mprotect			sys_pkey_mprotect
+525	common	pkey_alloc			sys_pkey_alloc
+526	common	pkey_free			sys_pkey_free
+527	common	rseq				sys_rseq
+528	common	statfs64			sys_statfs64
+529	common	fstatfs64			sys_fstatfs64
+530	common	getegid				sys_getegid
+531	common	geteuid				sys_geteuid
+532	common	getppid				sys_getppid
+# all other architectures have common numbers for new syscall, alpha
+# is the exception.
+534	common	pidfd_send_signal		sys_pidfd_send_signal
+535	common	io_uring_setup			sys_io_uring_setup
+536	common	io_uring_enter			sys_io_uring_enter
+537	common	io_uring_register		sys_io_uring_register
+538	common	open_tree			sys_open_tree
+539	common	move_mount			sys_move_mount
+540	common	fsopen				sys_fsopen
+541	common	fsconfig			sys_fsconfig
+542	common	fsmount				sys_fsmount
+543	common	fspick				sys_fspick
+544	common	pidfd_open			sys_pidfd_open
+# 545 reserved for clone3
+547	common	openat2				sys_openat2
+548	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/linux-user/alpha/syscall_nr.h b/linux-user/alpha/syscall_nr.h
deleted file mode 100644
index c29fc17722c5..000000000000
--- a/linux-user/alpha/syscall_nr.h
+++ /dev/null
@@ -1,492 +0,0 @@
-#ifndef LINUX_USER_ALPHA_SYSCALL_NR_H
-#define LINUX_USER_ALPHA_SYSCALL_NR_H
-
-#define TARGET_NR_osf_syscall	  0	/* not implemented */
-#define TARGET_NR_exit		  1
-#define TARGET_NR_fork		  2
-#define TARGET_NR_read		  3
-#define TARGET_NR_write		  4
-#define TARGET_NR_osf_old_open	  5	/* not implemented */
-#define TARGET_NR_close		  6
-#define TARGET_NR_osf_wait4		  7
-#define TARGET_NR_osf_old_creat	  8	/* not implemented */
-#define TARGET_NR_link		  9
-#define TARGET_NR_unlink		 10
-#define TARGET_NR_osf_execve		 11	/* not implemented */
-#define TARGET_NR_chdir		 12
-#define TARGET_NR_fchdir		 13
-#define TARGET_NR_mknod		 14
-#define TARGET_NR_chmod		 15
-#define TARGET_NR_chown		 16
-#define TARGET_NR_brk		 17
-#define TARGET_NR_osf_getfsstat	 18	/* not implemented */
-#define TARGET_NR_lseek		 19
-#define TARGET_NR_getxpid		 20
-#define TARGET_NR_osf_mount		 21
-#define TARGET_NR_umount2		 22
-#define TARGET_NR_setuid		 23
-#define TARGET_NR_getxuid		 24
-#define TARGET_NR_exec_with_loader	 25	/* not implemented */
-#define TARGET_NR_ptrace		 26
-#define TARGET_NR_osf_nrecvmsg	 27	/* not implemented */
-#define TARGET_NR_osf_nsendmsg	 28	/* not implemented */
-#define TARGET_NR_osf_nrecvfrom	 29	/* not implemented */
-#define TARGET_NR_osf_naccept	 30	/* not implemented */
-#define TARGET_NR_osf_ngetpeername	 31	/* not implemented */
-#define TARGET_NR_osf_ngetsockname	 32	/* not implemented */
-#define TARGET_NR_access		 33
-#define TARGET_NR_osf_chflags	 34	/* not implemented */
-#define TARGET_NR_osf_fchflags	 35	/* not implemented */
-#define TARGET_NR_sync		 36
-#define TARGET_NR_kill		 37
-#define TARGET_NR_osf_old_stat	 38	/* not implemented */
-#define TARGET_NR_setpgid		 39
-#define TARGET_NR_osf_old_lstat	 40	/* not implemented */
-#define TARGET_NR_dup		 41
-#define TARGET_NR_pipe		 42
-#define TARGET_NR_osf_set_program_attributes	43
-#define TARGET_NR_osf_profil		 44	/* not implemented */
-#define TARGET_NR_open		 45
-#define TARGET_NR_osf_old_sigaction	 46	/* not implemented */
-#define TARGET_NR_getxgid		 47
-#define TARGET_NR_sigprocmask    48
-#define TARGET_NR_osf_getlogin	 49	/* not implemented */
-#define TARGET_NR_osf_setlogin	 50	/* not implemented */
-#define TARGET_NR_acct		 51
-#define TARGET_NR_sigpending		 52
-
-#define TARGET_NR_ioctl		 54
-#define TARGET_NR_osf_reboot		 55	/* not implemented */
-#define TARGET_NR_osf_revoke		 56	/* not implemented */
-#define TARGET_NR_symlink		 57
-#define TARGET_NR_readlink		 58
-#define TARGET_NR_execve		 59
-#define TARGET_NR_umask		 60
-#define TARGET_NR_chroot		 61
-#define TARGET_NR_osf_old_fstat	 62	/* not implemented */
-#define TARGET_NR_getpgrp		 63
-#define TARGET_NR_getpagesize	 64
-#define TARGET_NR_osf_mremap		 65	/* not implemented */
-#define TARGET_NR_vfork		 66
-#define TARGET_NR_stat		 67
-#define TARGET_NR_lstat		 68
-#define TARGET_NR_osf_sbrk		 69	/* not implemented */
-#define TARGET_NR_osf_sstk		 70	/* not implemented */
-#define TARGET_NR_mmap		 71	/* OSF/1 mmap is superset of Linux */
-#define TARGET_NR_osf_old_vadvise	 72	/* not implemented */
-#define TARGET_NR_munmap		 73
-#define TARGET_NR_mprotect		 74
-#define TARGET_NR_madvise		 75
-#define TARGET_NR_vhangup		 76
-#define TARGET_NR_osf_kmodcall	 77	/* not implemented */
-#define TARGET_NR_osf_mincore	 78	/* not implemented */
-#define TARGET_NR_getgroups		 79
-#define TARGET_NR_setgroups		 80
-#define TARGET_NR_osf_old_getpgrp	 81	/* not implemented */
-#define TARGET_NR_setpgrp		 82	/* BSD alias for setpgid */
-#define TARGET_NR_osf_setitimer	 83
-#define TARGET_NR_osf_old_wait	 84	/* not implemented */
-#define TARGET_NR_osf_table		 85	/* not implemented */
-#define TARGET_NR_osf_getitimer	 86
-#define TARGET_NR_gethostname	 87
-#define TARGET_NR_sethostname	 88
-#define TARGET_NR_getdtablesize	 89
-#define TARGET_NR_dup2		 90
-#define TARGET_NR_fstat		 91
-#define TARGET_NR_fcntl		 92
-#define TARGET_NR_osf_select		 93
-#define TARGET_NR_poll		 94
-#define TARGET_NR_fsync		 95
-#define TARGET_NR_setpriority	 96
-#define TARGET_NR_socket		 97
-#define TARGET_NR_connect		 98
-#define TARGET_NR_accept		 99
-#define TARGET_NR_getpriority	100
-#define TARGET_NR_send		101
-#define TARGET_NR_recv		102
-#define TARGET_NR_sigreturn		103
-#define TARGET_NR_bind		104
-#define TARGET_NR_setsockopt		105
-#define TARGET_NR_listen		106
-#define TARGET_NR_osf_plock		107	/* not implemented */
-#define TARGET_NR_osf_old_sigvec	108	/* not implemented */
-#define TARGET_NR_osf_old_sigblock	109	/* not implemented */
-#define TARGET_NR_osf_old_sigsetmask	110	/* not implemented */
-#define TARGET_NR_sigsuspend		111
-#define TARGET_NR_osf_sigstack	112
-#define TARGET_NR_recvmsg		113
-#define TARGET_NR_sendmsg		114
-#define TARGET_NR_osf_old_vtrace	115	/* not implemented */
-#define TARGET_NR_osf_gettimeofday	116
-#define TARGET_NR_osf_getrusage	117
-#define TARGET_NR_getsockopt		118
-
-#define TARGET_NR_readv		120
-#define TARGET_NR_writev		121
-#define TARGET_NR_osf_settimeofday	122
-#define TARGET_NR_fchown		123
-#define TARGET_NR_fchmod		124
-#define TARGET_NR_recvfrom		125
-#define TARGET_NR_setreuid		126
-#define TARGET_NR_setregid		127
-#define TARGET_NR_rename		128
-#define TARGET_NR_truncate		129
-#define TARGET_NR_ftruncate		130
-#define TARGET_NR_flock		131
-#define TARGET_NR_setgid		132
-#define TARGET_NR_sendto		133
-#define TARGET_NR_shutdown		134
-#define TARGET_NR_socketpair		135
-#define TARGET_NR_mkdir		136
-#define TARGET_NR_rmdir		137
-#define TARGET_NR_osf_utimes		138
-#define TARGET_NR_osf_old_sigreturn	139	/* not implemented */
-#define TARGET_NR_osf_adjtime	140	/* not implemented */
-#define TARGET_NR_getpeername	141
-#define TARGET_NR_osf_gethostid	142	/* not implemented */
-#define TARGET_NR_osf_sethostid	143	/* not implemented */
-#define TARGET_NR_getrlimit		144
-#define TARGET_NR_setrlimit		145
-#define TARGET_NR_osf_old_killpg	146	/* not implemented */
-#define TARGET_NR_setsid		147
-#define TARGET_NR_quotactl		148
-#define TARGET_NR_osf_oldquota	149	/* not implemented */
-#define TARGET_NR_getsockname	150
-
-#define TARGET_NR_osf_pid_block	153	/* not implemented */
-#define TARGET_NR_osf_pid_unblock	154	/* not implemented */
-
-#define TARGET_NR_sigaction		156
-#define TARGET_NR_osf_sigwaitprim	157	/* not implemented */
-#define TARGET_NR_osf_nfssvc		158	/* not implemented */
-#define TARGET_NR_osf_getdirentries	159
-#define TARGET_NR_osf_statfs		160
-#define TARGET_NR_osf_fstatfs	161
-
-#define TARGET_NR_osf_asynch_daemon	163	/* not implemented */
-#define TARGET_NR_osf_getfh		164	/* not implemented */
-#define TARGET_NR_osf_getdomainname	165
-#define TARGET_NR_setdomainname	166
-
-#define TARGET_NR_osf_exportfs	169	/* not implemented */
-
-#define TARGET_NR_osf_alt_plock	181	/* not implemented */
-
-#define TARGET_NR_osf_getmnt		184	/* not implemented */
-
-#define TARGET_NR_osf_alt_sigpending	187	/* not implemented */
-#define TARGET_NR_osf_alt_setsid	188	/* not implemented */
-
-#define TARGET_NR_osf_swapon		199
-#define TARGET_NR_msgctl		200
-#define TARGET_NR_msgget		201
-#define TARGET_NR_msgrcv		202
-#define TARGET_NR_msgsnd		203
-#define TARGET_NR_semctl		204
-#define TARGET_NR_semget		205
-#define TARGET_NR_semop		206
-#define TARGET_NR_osf_utsname	207
-#define TARGET_NR_lchown		208
-#define TARGET_NR_osf_shmat		209
-/* this has the usual shmat semantics so give it the name syscall.c expects
- * so that our support for it is enabled.
- */
-#define TARGET_NR_shmat TARGET_NR_osf_shmat
-#define TARGET_NR_shmctl		210
-#define TARGET_NR_shmdt		211
-#define TARGET_NR_shmget		212
-#define TARGET_NR_osf_mvalid		213	/* not implemented */
-#define TARGET_NR_osf_getaddressconf	214	/* not implemented */
-#define TARGET_NR_osf_msleep		215	/* not implemented */
-#define TARGET_NR_osf_mwakeup	216	/* not implemented */
-#define TARGET_NR_msync		217
-#define TARGET_NR_osf_signal		218	/* not implemented */
-#define TARGET_NR_osf_utc_gettime	219	/* not implemented */
-#define TARGET_NR_osf_utc_adjtime	220	/* not implemented */
-
-#define TARGET_NR_osf_security	222	/* not implemented */
-#define TARGET_NR_osf_kloadcall	223	/* not implemented */
-
-#define TARGET_NR_getpgid		233
-#define TARGET_NR_getsid		234
-#define TARGET_NR_sigaltstack	235
-#define TARGET_NR_osf_waitid		236	/* not implemented */
-#define TARGET_NR_osf_priocntlset	237	/* not implemented */
-#define TARGET_NR_osf_sigsendset	238	/* not implemented */
-#define TARGET_NR_osf_set_speculative	239	/* not implemented */
-#define TARGET_NR_osf_msfs_syscall	240	/* not implemented */
-#define TARGET_NR_osf_sysinfo	241
-#define TARGET_NR_osf_uadmin		242	/* not implemented */
-#define TARGET_NR_osf_fuser		243	/* not implemented */
-#define TARGET_NR_osf_proplist_syscall    244
-#define TARGET_NR_osf_ntp_adjtime	245	/* not implemented */
-#define TARGET_NR_osf_ntp_gettime	246	/* not implemented */
-#define TARGET_NR_osf_pathconf	247	/* not implemented */
-#define TARGET_NR_osf_fpathconf	248	/* not implemented */
-
-#define TARGET_NR_osf_uswitch	250	/* not implemented */
-#define TARGET_NR_osf_usleep_thread	251
-#define TARGET_NR_osf_audcntl	252	/* not implemented */
-#define TARGET_NR_osf_audgen		253	/* not implemented */
-#define TARGET_NR_sysfs		254
-#define TARGET_NR_osf_subsys_info	255	/* not implemented */
-#define TARGET_NR_osf_getsysinfo	256
-#define TARGET_NR_osf_setsysinfo	257
-#define TARGET_NR_osf_afs_syscall	258	/* not implemented */
-#define TARGET_NR_osf_swapctl	259	/* not implemented */
-#define TARGET_NR_osf_memcntl	260	/* not implemented */
-#define TARGET_NR_osf_fdatasync	261	/* not implemented */
-
-
-/*
- * Linux-specific system calls begin at 300
- */
-#define TARGET_NR_bdflush		300
-#define TARGET_NR_sethae		301
-#define TARGET_NR_mount		302
-#define TARGET_NR_old_adjtimex	303
-#define TARGET_NR_swapoff		304
-#define TARGET_NR_getdents		305
-#define TARGET_NR_create_module	306
-#define TARGET_NR_init_module	307
-#define TARGET_NR_delete_module	308
-#define TARGET_NR_get_kernel_syms	309
-#define TARGET_NR_syslog		310
-#define TARGET_NR_reboot		311
-#define TARGET_NR_clone		312
-#define TARGET_NR_uselib		313
-#define TARGET_NR_mlock		314
-#define TARGET_NR_munlock		315
-#define TARGET_NR_mlockall		316
-#define TARGET_NR_munlockall		317
-#define TARGET_NR_sysinfo		318
-#define TARGET_NR__sysctl		319
-/* 320 was sys_idle.  */
-#define TARGET_NR_umount		321
-#define TARGET_NR_swapon		322
-#define TARGET_NR_times		323
-#define TARGET_NR_personality	324
-#define TARGET_NR_setfsuid		325
-#define TARGET_NR_setfsgid		326
-#define TARGET_NR_ustat		327
-#define TARGET_NR_statfs		328
-#define TARGET_NR_fstatfs		329
-#define TARGET_NR_sched_setparam		330
-#define TARGET_NR_sched_getparam		331
-#define TARGET_NR_sched_setscheduler		332
-#define TARGET_NR_sched_getscheduler		333
-#define TARGET_NR_sched_yield		334
-#define TARGET_NR_sched_get_priority_max	335
-#define TARGET_NR_sched_get_priority_min	336
-#define TARGET_NR_sched_rr_get_interval	337
-#define TARGET_NR_afs_syscall		338
-#define TARGET_NR_uname			339
-#define TARGET_NR_nanosleep			340
-#define TARGET_NR_mremap			341
-#define TARGET_NR_nfsservctl			342
-#define TARGET_NR_setresuid			343
-#define TARGET_NR_getresuid			344
-#define TARGET_NR_pciconfig_read		345
-#define TARGET_NR_pciconfig_write		346
-#define TARGET_NR_query_module		347
-#define TARGET_NR_prctl			348
-#define TARGET_NR_pread64			349
-#define TARGET_NR_pwrite64			350
-#define TARGET_NR_rt_sigreturn		351
-#define TARGET_NR_rt_sigaction		352
-#define TARGET_NR_rt_sigprocmask		353
-#define TARGET_NR_rt_sigpending		354
-#define TARGET_NR_rt_sigtimedwait		355
-#define TARGET_NR_rt_sigqueueinfo		356
-#define TARGET_NR_rt_sigsuspend		357
-#define TARGET_NR_select			358
-#define TARGET_NR_gettimeofday		359
-#define TARGET_NR_settimeofday		360
-#define TARGET_NR_getitimer			361
-#define TARGET_NR_setitimer			362
-#define TARGET_NR_utimes			363
-#define TARGET_NR_getrusage			364
-#define TARGET_NR_wait4			365
-#define TARGET_NR_adjtimex			366
-#define TARGET_NR_getcwd			367
-#define TARGET_NR_capget			368
-#define TARGET_NR_capset			369
-#define TARGET_NR_sendfile			370
-#define TARGET_NR_setresgid			371
-#define TARGET_NR_getresgid			372
-#define TARGET_NR_dipc			373
-#define TARGET_NR_pivot_root			374
-#define TARGET_NR_mincore			375
-#define TARGET_NR_pciconfig_iobase		376
-#define TARGET_NR_getdents64			377
-#define TARGET_NR_gettid			378
-#define TARGET_NR_readahead			379
-/* 380 is unused */
-#define TARGET_NR_tkill			381
-#define TARGET_NR_setxattr			382
-#define TARGET_NR_lsetxattr			383
-#define TARGET_NR_fsetxattr			384
-#define TARGET_NR_getxattr			385
-#define TARGET_NR_lgetxattr			386
-#define TARGET_NR_fgetxattr			387
-#define TARGET_NR_listxattr			388
-#define TARGET_NR_llistxattr			389
-#define TARGET_NR_flistxattr			390
-#define TARGET_NR_removexattr		391
-#define TARGET_NR_lremovexattr		392
-#define TARGET_NR_fremovexattr		393
-#define TARGET_NR_futex			394
-#define TARGET_NR_sched_setaffinity		395
-#define TARGET_NR_sched_getaffinity		396
-#define TARGET_NR_tuxcall			397
-#define TARGET_NR_io_setup			398
-#define TARGET_NR_io_destroy			399
-#define TARGET_NR_io_getevents		400
-#define TARGET_NR_io_submit			401
-#define TARGET_NR_io_cancel			402
-#define TARGET_NR_exit_group			405
-#define TARGET_NR_lookup_dcookie		406
-#define TARGET_NR_epoll_create          407
-#define TARGET_NR_epoll_ctl             408
-#define TARGET_NR_epoll_wait            409
-#define TARGET_NR_remap_file_pages		410
-#define TARGET_NR_set_tid_address		411
-#define TARGET_NR_restart_syscall		412
-#define TARGET_NR_fadvise64			413
-#define TARGET_NR_timer_create		414
-#define TARGET_NR_timer_settime		415
-#define TARGET_NR_timer_gettime		416
-#define TARGET_NR_timer_getoverrun		417
-#define TARGET_NR_timer_delete		418
-#define TARGET_NR_clock_settime		419
-#define TARGET_NR_clock_gettime		420
-#define TARGET_NR_clock_getres		421
-#define TARGET_NR_clock_nanosleep		422
-#define TARGET_NR_semtimedop			423
-#define TARGET_NR_tgkill			424
-#define TARGET_NR_stat64			425
-#define TARGET_NR_lstat64			426
-#define TARGET_NR_fstat64			427
-#define TARGET_NR_vserver			428
-#define TARGET_NR_mbind			429
-#define TARGET_NR_get_mempolicy		430
-#define TARGET_NR_set_mempolicy		431
-#define TARGET_NR_mq_open			432
-#define TARGET_NR_mq_unlink			433
-#define TARGET_NR_mq_timedsend		434
-#define TARGET_NR_mq_timedreceive		435
-#define TARGET_NR_mq_notify			436
-#define TARGET_NR_mq_getsetattr		437
-#define TARGET_NR_waitid			438
-#define TARGET_NR_add_key			439
-#define TARGET_NR_request_key		440
-#define TARGET_NR_keyctl			441
-#define TARGET_NR_ioprio_set			442
-#define TARGET_NR_ioprio_get			443
-#define TARGET_NR_inotify_init		444
-#define TARGET_NR_inotify_add_watch		445
-#define TARGET_NR_inotify_rm_watch		446
-#define TARGET_NR_fdatasync			447
-#define TARGET_NR_kexec_load			448
-#define TARGET_NR_migrate_pages		449
-#define TARGET_NR_openat			450
-#define TARGET_NR_mkdirat			451
-#define TARGET_NR_mknodat			452
-#define TARGET_NR_fchownat			453
-#define TARGET_NR_futimesat			454
-#define TARGET_NR_fstatat64			455
-#define TARGET_NR_unlinkat			456
-#define TARGET_NR_renameat			457
-#define TARGET_NR_linkat			458
-#define TARGET_NR_symlinkat			459
-#define TARGET_NR_readlinkat			460
-#define TARGET_NR_fchmodat			461
-#define TARGET_NR_faccessat			462
-#define TARGET_NR_pselect6			463
-#define TARGET_NR_ppoll			464
-#define TARGET_NR_unshare			465
-#define TARGET_NR_set_robust_list		466
-#define TARGET_NR_get_robust_list		467
-#define TARGET_NR_splice			468
-#define TARGET_NR_sync_file_range		469
-#define TARGET_NR_tee			470
-#define TARGET_NR_vmsplice			471
-#define TARGET_NR_move_pages			472
-#define TARGET_NR_getcpu			473
-#define TARGET_NR_epoll_pwait		474
-#define TARGET_NR_utimensat			475
-#define TARGET_NR_signalfd			476
-#define TARGET_NR_timerfd			477
-#define TARGET_NR_eventfd			478
-#define TARGET_NR_recvmmsg                      479
-#define TARGET_NR_fallocate                     480
-#define TARGET_NR_timerfd_create                481
-#define TARGET_NR_timerfd_settime               482
-#define TARGET_NR_timerfd_gettime               483
-#define TARGET_NR_signalfd4                     484
-#define TARGET_NR_eventfd2                      485
-#define TARGET_NR_epoll_create1                 486
-#define TARGET_NR_dup3                          487
-#define TARGET_NR_pipe2                         488
-#define TARGET_NR_inotify_init1                 489
-#define TARGET_NR_preadv                        490
-#define TARGET_NR_pwritev                       491
-#define TARGET_NR_rt_tgsigqueueinfo             492
-#define TARGET_NR_perf_event_open               493
-#define TARGET_NR_fanotify_init                 494
-#define TARGET_NR_fanotify_mark                 495
-#define TARGET_NR_prlimit64                     496
-#define TARGET_NR_name_to_handle_at             497
-#define TARGET_NR_open_by_handle_at             498
-#define TARGET_NR_clock_adjtime                 499
-#define TARGET_NR_syncfs                        500
-#define TARGET_NR_setns                         501
-#define TARGET_NR_accept4                       502
-#define TARGET_NR_sendmmsg                      503
-#define TARGET_NR_process_vm_readv              504
-#define TARGET_NR_process_vm_writev             505
-#define TARGET_NR_kcmp                          506
-#define TARGET_NR_finit_module                  507
-#define TARGET_NR_sched_setattr                 508
-#define TARGET_NR_sched_getattr                 509
-#define TARGET_NR_renameat2                     510
-#define TARGET_NR_getrandom                     511
-#define TARGET_NR_memfd_create                  512
-#define TARGET_NR_execveat                      513
-#define TARGET_NR_seccomp                       514
-#define TARGET_NR_bpf                           515
-#define TARGET_NR_userfaultfd                   516
-#define TARGET_NR_membarrier                    517
-#define TARGET_NR_mlock2                        518
-#define TARGET_NR_copy_file_range               519
-#define TARGET_NR_preadv2                       520
-#define TARGET_NR_pwritev2                      521
-#define TARGET_NR_statx                         522
-#define TARGET_NR_io_pgetevents                 523
-#define TARGET_NR_pkey_mprotect                 524
-#define TARGET_NR_pkey_alloc                    525
-#define TARGET_NR_pkey_free                     526
-#define TARGET_NR_rseq                          527
-#define TARGET_NR_statfs64                      528
-#define TARGET_NR_fstatfs64                     529
-#define TARGET_NR_getegid                       530
-#define TARGET_NR_geteuid                       531
-#define TARGET_NR_getppid                       532
-/*
- * all other architectures have common numbers for new syscall, alpha
- * is the exception.
- */
-#define TARGET_NR_pidfd_send_signal             534
-#define TARGET_NR_io_uring_setup                535
-#define TARGET_NR_io_uring_enter                536
-#define TARGET_NR_io_uring_register             537
-#define TARGET_NR_open_tree                     538
-#define TARGET_NR_move_mount                    539
-#define TARGET_NR_fsopen                        540
-#define TARGET_NR_fsconfig                      541
-#define TARGET_NR_fsmount                       542
-#define TARGET_NR_fspick                        543
-#define TARGET_NR_pidfd_open                    544
-/* 545 reserved for clone3 */
-
-#endif
diff --git a/linux-user/alpha/syscallhdr.sh b/linux-user/alpha/syscallhdr.sh
new file mode 100644
index 000000000000..55cafe6abf99
--- /dev/null
+++ b/linux-user/alpha/syscallhdr.sh
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
+fileguard=LINUX_USER_ALPHA_`basename "$out" | sed \
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


