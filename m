Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D24C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9C220767
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9C220767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErUU-0002Ju-PX
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jErRy-0005RH-FW
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jErRv-0004E0-UD
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:50 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:49255)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jErRv-0004DL-KE
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:47 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mbkac-1jqwI82yFC-00dCvP; Thu, 19 Mar 2020 10:26:43 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 16/16] linux-user,
 openrisc: sync syscall numbers with kernel v5.5
Date: Thu, 19 Mar 2020 10:26:27 +0100
Message-Id: <20200319092627.51487-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319092627.51487-1-laurent@vivier.eu>
References: <20200319092627.51487-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ow+e9N9X8+UvS0Q2UX7O6n918njvFOExkWRU2V0jADEyW/ph56v
 uojN/hRMzyna+3KzpjlXqiCu2bOTthfZA/sp5hgzNJG5avdOvwoxqSJ+bFYI+CMjAyjK6km
 kUhaZr8Nml4CHog23mwd3enUFKFl/0WyuRZ8TcB9jw0pl7d1H7zU8G4wW16OS2lFS9+2f5G
 QHsaZOJKkhhx42oLQKT+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lJurAFmQqzc=:HDzvFe17p/vKpl9y6hxMc0
 1BBVe2zQiZM38YRbMY5JdAHHvnusZ5iXJg9zv5qJqats/9xoxYCbRhXPqv0Ch6eEOrsTFYXsa
 0nFjoSMto8qGIXKwb/6aeOl2IIT+OxJte6LNzsMaNOPsdnE0LBZYJ2gr6Hg/4K/7WoNZ9NHgB
 VOYPJMMP5F/vOa8aMcCMvG2DL6RhQcxI+99LDUjnWSMAOn6ls5DtDXq0ElwAtha0kSv1Yls04
 i6rgcHvqZoNu90FQzWpULwb0SNQoxi47yEiQVRZH/ZsLOo6UYUGF+smWQvP0+6arUo5xEMqFs
 muyf09BldkZphbd6TSRx1Uvip66SzYXAH4dGf8upQ+OlNPT4TP8mCo5ZBBCml8YsACLpLdTcw
 je6L+BZcV6Ywi6fl7PnFmLE7tUBD96xLgSbonzSRZFbdhWVHy1oRteOz8BYBPsR0bJjeXxcHC
 bFOGnOp8MUBwGCK6CX1PKR43pVw6LeZg5ywAmP3ymoetPqgsuIu6B7E8Bytw9rWZ4pV/Zp1AA
 uxpn8CBxPNU7NaZ7+K8fPouOORPJhMaOZvAxEwlMjorhFVy1XgwD0R0nC/8IhQfmnA1eFvBHL
 vzk0By1doaZidSYAJwuiYvxiDuFjqpRlDdJTV3gIG5wpP+q6AhoiX2oOJmWSIsyzukS/H0j8n
 YZNW0ItgX8oi8KAzNbjpVeaRRRnvR772ChKBoUBaNc9Mbto4VA9JwCzOyeWSEgygQNEGTi8BJ
 3XYC0/+15GYkT10Mi199beB2H8pLmtGrKXz9oxCIMtTDgRicksuKryDi4YkQoGe9Qv7GNXcCE
 9pqJ/2yVPJaH5Mc0CbU0jvVjVubP0KyZY0RFH0jSOzOy5T+Z8xaCCT1xL0g3jIodUhlmzVo
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use helper script scripts/gensyscalls.sh to generate the file.

Add TARGET_NR_or1k_atomic
Remove useless comments and blank lines.
Define diretly the __NR_XXX64 syscalls rather than using the
intermediate __NR3264 definition.

Remove wrong cut'n'paste (like "#ifdef __ARCH_WANT_SYNC_FILE_RANGE2")

Add new syscalls from 286 (preadv) to 434 (pidfd_open).

Remove obsolete syscalls 1204 (open) to 1079 (fork).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200316085620.309769-5-laurent@vivier.eu>
---
 linux-user/openrisc/syscall_nr.h | 309 +++++++------------------------
 1 file changed, 62 insertions(+), 247 deletions(-)

diff --git a/linux-user/openrisc/syscall_nr.h b/linux-user/openrisc/syscall_nr.h
index 7763dbcfd8b3..340383beb2c6 100644
--- a/linux-user/openrisc/syscall_nr.h
+++ b/linux-user/openrisc/syscall_nr.h
@@ -1,13 +1,17 @@
+/*
+ * This file contains the system call numbers.
+ * Do not modify.
+ * This file is generated by scripts/gensyscalls.sh
+ */
 #ifndef LINUX_USER_OPENRISC_SYSCALL_NR_H
 #define LINUX_USER_OPENRISC_SYSCALL_NR_H
 
 #define TARGET_NR_io_setup 0
+#define TARGET_NR_or1k_atomic TARGET_NR_arch_specific_syscall
 #define TARGET_NR_io_destroy 1
 #define TARGET_NR_io_submit 2
 #define TARGET_NR_io_cancel 3
 #define TARGET_NR_io_getevents 4
-
-/* fs/xattr.c */
 #define TARGET_NR_setxattr 5
 #define TARGET_NR_lsetxattr 6
 #define TARGET_NR_fsetxattr 7
@@ -20,63 +24,36 @@
 #define TARGET_NR_removexattr 14
 #define TARGET_NR_lremovexattr 15
 #define TARGET_NR_fremovexattr 16
-
-/* fs/dcache.c */
 #define TARGET_NR_getcwd 17
-
-/* fs/cookies.c */
 #define TARGET_NR_lookup_dcookie 18
-
-/* fs/eventfd.c */
 #define TARGET_NR_eventfd2 19
-
-/* fs/eventpoll.c */
 #define TARGET_NR_epoll_create1 20
 #define TARGET_NR_epoll_ctl 21
 #define TARGET_NR_epoll_pwait 22
-
-/* fs/fcntl.c */
 #define TARGET_NR_dup 23
 #define TARGET_NR_dup3 24
-#define TARGET_NR_3264_fcntl 25
-
-/* fs/inotify_user.c */
+#define TARGET_NR_fcntl64 25
 #define TARGET_NR_inotify_init1 26
 #define TARGET_NR_inotify_add_watch 27
 #define TARGET_NR_inotify_rm_watch 28
-
-/* fs/ioctl.c */
 #define TARGET_NR_ioctl 29
-
-/* fs/ioprio.c */
 #define TARGET_NR_ioprio_set 30
 #define TARGET_NR_ioprio_get 31
-
-/* fs/locks.c */
 #define TARGET_NR_flock 32
-
-/* fs/namei.c */
 #define TARGET_NR_mknodat 33
 #define TARGET_NR_mkdirat 34
 #define TARGET_NR_unlinkat 35
 #define TARGET_NR_symlinkat 36
 #define TARGET_NR_linkat 37
 #define TARGET_NR_renameat 38
-
-/* fs/namespace.c */
 #define TARGET_NR_umount2 39
 #define TARGET_NR_mount 40
 #define TARGET_NR_pivot_root 41
-
-/* fs/nfsctl.c */
 #define TARGET_NR_nfsservctl 42
-
-/* fs/open.c */
-#define TARGET_NR_3264_statfs 43
-#define TARGET_NR_3264_fstatfs 44
-#define TARGET_NR_3264_truncate 45
-#define TARGET_NR_3264_ftruncate 46
-
+#define TARGET_NR_statfs64 43
+#define TARGET_NR_fstatfs64 44
+#define TARGET_NR_truncate64 45
+#define TARGET_NR_ftruncate64 46
 #define TARGET_NR_fallocate 47
 #define TARGET_NR_faccessat 48
 #define TARGET_NR_chdir 49
@@ -89,18 +66,10 @@
 #define TARGET_NR_openat 56
 #define TARGET_NR_close 57
 #define TARGET_NR_vhangup 58
-
-/* fs/pipe.c */
 #define TARGET_NR_pipe2 59
-
-/* fs/quota.c */
 #define TARGET_NR_quotactl 60
-
-/* fs/readdir.c */
 #define TARGET_NR_getdents64 61
-
-/* fs/read_write.c */
-#define TARGET_NR_3264_lseek 62
+#define TARGET_NR_llseek 62
 #define TARGET_NR_read 63
 #define TARGET_NR_write 64
 #define TARGET_NR_readv 65
@@ -109,85 +78,42 @@
 #define TARGET_NR_pwrite64 68
 #define TARGET_NR_preadv 69
 #define TARGET_NR_pwritev 70
-
-/* fs/sendfile.c */
-#define TARGET_NR_3264_sendfile 71
-
-/* fs/select.c */
+#define TARGET_NR_sendfile64 71
 #define TARGET_NR_pselect6 72
 #define TARGET_NR_ppoll 73
-
-/* fs/signalfd.c */
 #define TARGET_NR_signalfd4 74
-
-/* fs/splice.c */
 #define TARGET_NR_vmsplice 75
 #define TARGET_NR_splice 76
 #define TARGET_NR_tee 77
-
-/* fs/stat.c */
 #define TARGET_NR_readlinkat 78
-#define TARGET_NR_3264_fstatat 79
-#define TARGET_NR_3264_fstat 80
-
-/* fs/sync.c */
+#define TARGET_NR_fstatat64 79
+#define TARGET_NR_fstat64 80
 #define TARGET_NR_sync 81
 #define TARGET_NR_fsync 82
 #define TARGET_NR_fdatasync 83
-
-#ifdef __ARCH_WANT_SYNC_FILE_RANGE2
-#define TARGET_NR_sync_file_range2 84
-#else
 #define TARGET_NR_sync_file_range 84
-#endif
-
-/* fs/timerfd.c */
 #define TARGET_NR_timerfd_create 85
 #define TARGET_NR_timerfd_settime 86
 #define TARGET_NR_timerfd_gettime 87
-
-/* fs/utimes.c */
 #define TARGET_NR_utimensat 88
-
-/* kernel/acct.c */
 #define TARGET_NR_acct 89
-
-/* kernel/capability.c */
 #define TARGET_NR_capget 90
 #define TARGET_NR_capset 91
-
-/* kernel/exec_domain.c */
 #define TARGET_NR_personality 92
-
-/* kernel/exit.c */
 #define TARGET_NR_exit 93
 #define TARGET_NR_exit_group 94
 #define TARGET_NR_waitid 95
-
-/* kernel/fork.c */
 #define TARGET_NR_set_tid_address 96
 #define TARGET_NR_unshare 97
-
-/* kernel/futex.c */
 #define TARGET_NR_futex 98
 #define TARGET_NR_set_robust_list 99
 #define TARGET_NR_get_robust_list 100
-
-/* kernel/hrtimer.c */
 #define TARGET_NR_nanosleep 101
-
-/* kernel/itimer.c */
 #define TARGET_NR_getitimer 102
 #define TARGET_NR_setitimer 103
-
-/* kernel/kexec.c */
 #define TARGET_NR_kexec_load 104
-
-/* kernel/module.c */
 #define TARGET_NR_init_module 105
 #define TARGET_NR_delete_module 106
-
-/* kernel/posix-timers.c */
 #define TARGET_NR_timer_create 107
 #define TARGET_NR_timer_gettime 108
 #define TARGET_NR_timer_getoverrun 109
@@ -197,14 +123,8 @@
 #define TARGET_NR_clock_gettime 113
 #define TARGET_NR_clock_getres 114
 #define TARGET_NR_clock_nanosleep 115
-
-/* kernel/printk.c */
 #define TARGET_NR_syslog 116
-
-/* kernel/ptrace.c */
 #define TARGET_NR_ptrace 117
-
-/* kernel/sched.c */
 #define TARGET_NR_sched_setparam 118
 #define TARGET_NR_sched_setscheduler 119
 #define TARGET_NR_sched_getscheduler 120
@@ -215,8 +135,6 @@
 #define TARGET_NR_sched_get_priority_max 125
 #define TARGET_NR_sched_get_priority_min 126
 #define TARGET_NR_sched_rr_get_interval 127
-
-/* kernel/signal.c */
 #define TARGET_NR_restart_syscall 128
 #define TARGET_NR_kill 129
 #define TARGET_NR_tkill 130
@@ -229,8 +147,6 @@
 #define TARGET_NR_rt_sigtimedwait 137
 #define TARGET_NR_rt_sigqueueinfo 138
 #define TARGET_NR_rt_sigreturn 139
-
-/* kernel/sys.c */
 #define TARGET_NR_setpriority 140
 #define TARGET_NR_getpriority 141
 #define TARGET_NR_reboot 142
@@ -260,13 +176,9 @@
 #define TARGET_NR_umask 166
 #define TARGET_NR_prctl 167
 #define TARGET_NR_getcpu 168
-
-/* kernel/time.c */
 #define TARGET_NR_gettimeofday 169
 #define TARGET_NR_settimeofday 170
 #define TARGET_NR_adjtimex 171
-
-/* kernel/timer.c */
 #define TARGET_NR_getpid 172
 #define TARGET_NR_getppid 173
 #define TARGET_NR_getuid 174
@@ -275,34 +187,24 @@
 #define TARGET_NR_getegid 177
 #define TARGET_NR_gettid 178
 #define TARGET_NR_sysinfo 179
-
-/* ipc/mqueue.c */
 #define TARGET_NR_mq_open 180
 #define TARGET_NR_mq_unlink 181
 #define TARGET_NR_mq_timedsend 182
 #define TARGET_NR_mq_timedreceive 183
 #define TARGET_NR_mq_notify 184
 #define TARGET_NR_mq_getsetattr 185
-
-/* ipc/msg.c */
 #define TARGET_NR_msgget 186
 #define TARGET_NR_msgctl 187
 #define TARGET_NR_msgrcv 188
 #define TARGET_NR_msgsnd 189
-
-/* ipc/sem.c */
 #define TARGET_NR_semget 190
 #define TARGET_NR_semctl 191
 #define TARGET_NR_semtimedop 192
 #define TARGET_NR_semop 193
-
-/* ipc/shm.c */
 #define TARGET_NR_shmget 194
 #define TARGET_NR_shmctl 195
 #define TARGET_NR_shmat 196
 #define TARGET_NR_shmdt 197
-
-/* net/socket.c */
 #define TARGET_NR_socket 198
 #define TARGET_NR_socketpair 199
 #define TARGET_NR_bind 200
@@ -318,30 +220,17 @@
 #define TARGET_NR_shutdown 210
 #define TARGET_NR_sendmsg 211
 #define TARGET_NR_recvmsg 212
-
-/* mm/filemap.c */
 #define TARGET_NR_readahead 213
-
-/* mm/nommu.c, also with MMU */
 #define TARGET_NR_brk 214
 #define TARGET_NR_munmap 215
 #define TARGET_NR_mremap 216
-
-/* security/keys/keyctl.c */
 #define TARGET_NR_add_key 217
 #define TARGET_NR_request_key 218
 #define TARGET_NR_keyctl 219
-
-/* arch/example/kernel/sys_example.c */
 #define TARGET_NR_clone 220
 #define TARGET_NR_execve 221
-
-#define TARGET_NR_3264_mmap 222
-/* mm/fadvise.c */
-#define TARGET_NR_3264_fadvise64 223
-
-/* mm/, CONFIG_MMU only */
-#ifndef __ARCH_NOMMU
+#define TARGET_NR_mmap2 222
+#define TARGET_NR_fadvise64_64 223
 #define TARGET_NR_swapon 224
 #define TARGET_NR_swapoff 225
 #define TARGET_NR_mprotect 226
@@ -358,25 +247,17 @@
 #define TARGET_NR_set_mempolicy 237
 #define TARGET_NR_migrate_pages 238
 #define TARGET_NR_move_pages 239
-#endif
-
 #define TARGET_NR_rt_tgsigqueueinfo 240
 #define TARGET_NR_perf_event_open 241
 #define TARGET_NR_accept4 242
 #define TARGET_NR_recvmmsg 243
-
-/*
- * Architectures may provide up to 16 syscalls of their own
- * starting with this value.
- */
 #define TARGET_NR_arch_specific_syscall 244
-
 #define TARGET_NR_wait4 260
 #define TARGET_NR_prlimit64 261
 #define TARGET_NR_fanotify_init 262
 #define TARGET_NR_fanotify_mark 263
-#define TARGET_NR_name_to_handle_at         264
-#define TARGET_NR_open_by_handle_at         265
+#define TARGET_NR_name_to_handle_at 264
+#define TARGET_NR_open_by_handle_at 265
 #define TARGET_NR_clock_adjtime 266
 #define TARGET_NR_syncfs 267
 #define TARGET_NR_setns 268
@@ -397,113 +278,47 @@
 #define TARGET_NR_membarrier 283
 #define TARGET_NR_mlock2 284
 #define TARGET_NR_copy_file_range 285
+#define TARGET_NR_preadv2 286
+#define TARGET_NR_pwritev2 287
+#define TARGET_NR_pkey_mprotect 288
+#define TARGET_NR_pkey_alloc 289
+#define TARGET_NR_pkey_free 290
+#define TARGET_NR_statx 291
+#define TARGET_NR_io_pgetevents 292
+#define TARGET_NR_rseq 293
+#define TARGET_NR_kexec_file_load 294
+#define TARGET_NR_clock_gettime64 403
+#define TARGET_NR_clock_settime64 404
+#define TARGET_NR_clock_adjtime64 405
+#define TARGET_NR_clock_getres_time64 406
+#define TARGET_NR_clock_nanosleep_time64 407
+#define TARGET_NR_timer_gettime64 408
+#define TARGET_NR_timer_settime64 409
+#define TARGET_NR_timerfd_gettime64 410
+#define TARGET_NR_timerfd_settime64 411
+#define TARGET_NR_utimensat_time64 412
+#define TARGET_NR_pselect6_time64 413
+#define TARGET_NR_ppoll_time64 414
+#define TARGET_NR_io_pgetevents_time64 416
+#define TARGET_NR_recvmmsg_time64 417
+#define TARGET_NR_mq_timedsend_time64 418
+#define TARGET_NR_mq_timedreceive_time64 419
+#define TARGET_NR_semtimedop_time64 420
+#define TARGET_NR_rt_sigtimedwait_time64 421
+#define TARGET_NR_futex_time64 422
+#define TARGET_NR_sched_rr_get_interval_time64 423
+#define TARGET_NR_pidfd_send_signal 424
+#define TARGET_NR_io_uring_setup 425
+#define TARGET_NR_io_uring_enter 426
+#define TARGET_NR_io_uring_register 427
+#define TARGET_NR_open_tree 428
+#define TARGET_NR_move_mount 429
+#define TARGET_NR_fsopen 430
+#define TARGET_NR_fsconfig 431
+#define TARGET_NR_fsmount 432
+#define TARGET_NR_fspick 433
+#define TARGET_NR_pidfd_open 434
+#define TARGET_NR_syscalls 436
+
+#endif /* LINUX_USER_OPENRISC_SYSCALL_NR_H */
 
-/*
- * All syscalls below here should go away really,
- * these are provided for both review and as a porting
- * help for the C library version.
-*
- * Last chance: are any of these important enough to
- * enable by default?
- */
-#define TARGET_NR_open 1024
-#define TARGET_NR_link 1025
-#define TARGET_NR_unlink 1026
-#define TARGET_NR_mknod 1027
-#define TARGET_NR_chmod 1028
-#define TARGET_NR_chown 1029
-#define TARGET_NR_mkdir 1030
-#define TARGET_NR_rmdir 1031
-#define TARGET_NR_lchown 1032
-#define TARGET_NR_access 1033
-#define TARGET_NR_rename 1034
-#define TARGET_NR_readlink 1035
-#define TARGET_NR_symlink 1036
-#define TARGET_NR_utimes 1037
-#define TARGET_NR_3264_stat 1038
-#define TARGET_NR_3264_lstat 1039
-
-#define TARGET_NR_pipe 1040
-#define TARGET_NR_dup2 1041
-#define TARGET_NR_epoll_create 1042
-#define TARGET_NR_inotify_init 1043
-#define TARGET_NR_eventfd 1044
-#define TARGET_NR_signalfd 1045
-
-#define TARGET_NR_sendfile 1046
-#define TARGET_NR_ftruncate 1047
-#define TARGET_NR_truncate 1048
-#define TARGET_NR_stat 1049
-#define TARGET_NR_lstat 1050
-#define TARGET_NR_fstat 1051
-#define TARGET_NR_fcntl 1052
-#define TARGET_NR_fadvise64 1053
-#define __ARCH_WANT_SYS_FADVISE64
-#define TARGET_NR_newfstatat 1054
-#define __ARCH_WANT_SYS_NEWFSTATAT
-#define TARGET_NR_fstatfs 1055
-#define TARGET_NR_statfs 1056
-#define TARGET_NR_lseek 1057
-#define TARGET_NR_mmap 1058
-
-#define TARGET_NR_alarm 1059
-#define __ARCH_WANT_SYS_ALARM
-#define TARGET_NR_getpgrp 1060
-#define __ARCH_WANT_SYS_GETPGRP
-#define TARGET_NR_pause 1061
-#define __ARCH_WANT_SYS_PAUSE
-#define TARGET_NR_time 1062
-#define __ARCH_WANT_SYS_TIME
-#define __ARCH_WANT_COMPAT_SYS_TIME
-#define TARGET_NR_utime 1063
-#define __ARCH_WANT_SYS_UTIME
-
-#define TARGET_NR_creat 1064
-#define TARGET_NR_getdents 1065
-#define __ARCH_WANT_SYS_GETDENTS
-#define TARGET_NR_futimesat 1066
-#define TARGET_NR_poll 1068
-#define TARGET_NR_epoll_wait 1069
-#define TARGET_NR_ustat 1070
-#define TARGET_NR_vfork 1071
-#define TARGET_NR_oldwait4 1072
-#define TARGET_NR_recv 1073
-#define TARGET_NR_send 1074
-#define TARGET_NR_bdflush 1075
-#define TARGET_NR_umount 1076
-#define __ARCH_WANT_SYS_OLDUMOUNT
-#define TARGET_NR_uselib 1077
-#define TARGET_NR__sysctl 1078
-
-#define TARGET_NR_fork 1079
-
-
-/*
- * 32 bit systems traditionally used different
- * syscalls for off_t and loff_t arguments, while
- * 64 bit systems only need the off_t version.
- * For new 32 bit platforms, there is no need to
- * implement the old 32 bit off_t syscalls, so
- * they take different names.
- * Here we map the numbers so that both versions
- * use the same syscall table layout.
- */
-
-#define TARGET_NR_fcntl64 TARGET_NR_3264_fcntl
-#define TARGET_NR_statfs64 TARGET_NR_3264_statfs
-#define TARGET_NR_fstatfs64 TARGET_NR_3264_fstatfs
-#define TARGET_NR_truncate64 TARGET_NR_3264_truncate
-#define TARGET_NR_ftruncate64 TARGET_NR_3264_ftruncate
-#define TARGET_NR_llseek TARGET_NR_3264_lseek
-#define TARGET_NR_sendfile64 TARGET_NR_3264_sendfile
-#define TARGET_NR_fstatat64 TARGET_NR_3264_fstatat
-#define TARGET_NR_fstat64 TARGET_NR_3264_fstat
-#define TARGET_NR_mmap2 TARGET_NR_3264_mmap
-#define TARGET_NR_fadvise64_64 TARGET_NR_3264_fadvise64
-
-#ifdef TARGET_NR_3264_stat
-#define TARGET_NR_stat64 TARGET_NR_3264_stat
-#define TARGET_NR_lstat64 TARGET_NR_3264_lstat
-#endif
-
-#endif
-- 
2.25.1


