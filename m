Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E34C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 22:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE3320718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 22:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE3320718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3p4k-00067J-M4
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 17:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3p12-0007tR-UB
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3p0x-0000fu-4h
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:37:24 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:42857)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j3p0m-0000ak-Kq; Mon, 17 Feb 2020 17:37:09 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MfI21-1jeWaU1SDD-00gnG2; Mon, 17 Feb 2020 23:36:14 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/22] linux-user,ppc: split syscall_nr.h
Date: Mon, 17 Feb 2020 23:35:45 +0100
Message-Id: <20200217223558.863199-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217223558.863199-1-laurent@vivier.eu>
References: <20200217223558.863199-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:H7BsdqUxKXEEYgeUPFlEMFDU9pymxPP+mroXLoX4iJSfTffv47k
 Yw7m82/cmkSzqNZiDeaiNYUNlX2xxXp8jWg8ggR5YdTreM3wMavwzDrRFTeI0CbhaAdKYJj
 nwW9i9ODdgbyHdMIFm9n1OwVaSHYN/kx6utXBSTWdlkWcXu9CGjBUwfsqsor7lVXp//iE4w
 872Hx/819pvMNb5nyeBXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gc483zj0LzA=:s7zPlP644Lto92LdGZwK+g
 Js6w71vKVl9y1uqpNl6Nc2RYSi5/mvz0WS/10/mUA2E4Wqbuje+H3Dxk9PiiGqIP6UxmWZ+ZA
 ljvNlokslEnvc/AsdAB8rNFvU0vPd+bp5w1cMpt71ZONidQ9/gR1e/9fg5aoRkUi5UgaSjgrg
 2EzhUpQiLV3QSyqM/YFOLCIMIeH5j1dodQwAbju4/DJfx2oCXvMqWyP0ELRaEXaCxswqSXM4W
 LCq9QYmXNSXoTll5DwN+9VSzmKKDAIs2isSw87NJrdDZkm+ZtSFDyEGz4tvuiZOQUaJwZEkTk
 BWU8RZSyLVozUzoIstOIKcVsz0BROrTzvLPg4104Crthw6jvy0CV7vT77DiSE7xkn59B7aHGR
 ZATlGPwzLFKr37xitSnQ2VZX8tDY+Z1VSXz9UdLKtuVHH/5cp21Rs0T+vcmK4mUhLyvgcSFH5
 ztAMSuqN9Bx96+Kt6/F0d42FryPI7L9/yquMQ10WeJwlaWXNPwg1Yr8EyCffvVVy15rVD+4yp
 opuOqni8QQ2Sj0BoMAzjDtrD8CGXaYzAWWGLRwaQBNeAdmhZXg/MCuO1vbsnvRTSWF3z5YOql
 LNqPVQth/xCsvz+W1+ryXzfJ2d83WZUZJPTTNRF9/PqfGRgpSYbRZUTIS+vQ7VY+gOuaObiZv
 J7LHXd9oCY3D9YRHUM2rvQmxie9LfgQDaDMfWOB8wMhWgTNZsQ7YV2m0mMOqUFCe4WT2pYA0d
 9naIElLLo+OWMhxcxQXikknbmH/wWGKCT7yE3dsZkKTqEMKJSHFc8Av7VfpY0pp5vGntAQrah
 K5jwGzwYFQvWyp5qkur5D4LA3QsPCksRrdABiX8PUvEkqYPoXsyi7+Pc3GBgFdqHAbpcJXJ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split into syscall32_nr.h (ppc, ppc64abi32) and syscall64_nr.h (ppc64, ppc64le)

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ppc/syscall32_nr.h | 390 +++++++++++++++++++++++++++++++++
 linux-user/ppc/syscall64_nr.h | 381 ++++++++++++++++++++++++++++++++
 linux-user/ppc/syscall_nr.h   | 394 +---------------------------------
 3 files changed, 774 insertions(+), 391 deletions(-)
 create mode 100644 linux-user/ppc/syscall32_nr.h
 create mode 100644 linux-user/ppc/syscall64_nr.h

diff --git a/linux-user/ppc/syscall32_nr.h b/linux-user/ppc/syscall32_nr.h
new file mode 100644
index 000000000000..dbad305aef35
--- /dev/null
+++ b/linux-user/ppc/syscall32_nr.h
@@ -0,0 +1,390 @@
+/*
+ * This file contains the system call numbers.
+ */
+
+#ifndef LINUX_USER_PPC_SYSCALL32_NR_H
+#define LINUX_USER_PPC_SYSCALL32_NR_H
+
+#define TARGET_NR_restart_syscall          0
+#define TARGET_NR_exit                     1
+#define TARGET_NR_fork                     2
+#define TARGET_NR_read                     3
+#define TARGET_NR_write                    4
+#define TARGET_NR_open                     5
+#define TARGET_NR_close                    6
+#define TARGET_NR_waitpid                  7
+#define TARGET_NR_creat                    8
+#define TARGET_NR_link                     9
+#define TARGET_NR_unlink                  10
+#define TARGET_NR_execve                  11
+#define TARGET_NR_chdir                   12
+#define TARGET_NR_time                    13
+#define TARGET_NR_mknod                   14
+#define TARGET_NR_chmod                   15
+#define TARGET_NR_lchown                  16
+#define TARGET_NR_break                   17
+#define TARGET_NR_oldstat                 18
+#define TARGET_NR_lseek                   19
+#define TARGET_NR_getpid                  20
+#define TARGET_NR_mount                   21
+#define TARGET_NR_umount                  22
+#define TARGET_NR_setuid                  23
+#define TARGET_NR_getuid                  24
+#define TARGET_NR_stime                   25
+#define TARGET_NR_ptrace                  26
+#define TARGET_NR_alarm                   27
+#define TARGET_NR_oldfstat                28
+#define TARGET_NR_pause                   29
+#define TARGET_NR_utime                   30
+#define TARGET_NR_stty                    31
+#define TARGET_NR_gtty                    32
+#define TARGET_NR_access                  33
+#define TARGET_NR_nice                    34
+#define TARGET_NR_ftime                   35
+#define TARGET_NR_sync                    36
+#define TARGET_NR_kill                    37
+#define TARGET_NR_rename                  38
+#define TARGET_NR_mkdir                   39
+#define TARGET_NR_rmdir                   40
+#define TARGET_NR_dup                     41
+#define TARGET_NR_pipe                    42
+#define TARGET_NR_times                   43
+#define TARGET_NR_prof                    44
+#define TARGET_NR_brk                     45
+#define TARGET_NR_setgid                  46
+#define TARGET_NR_getgid                  47
+#define TARGET_NR_signal                  48
+#define TARGET_NR_geteuid                 49
+#define TARGET_NR_getegid                 50
+#define TARGET_NR_acct                    51
+#define TARGET_NR_umount2                 52
+#define TARGET_NR_lock                    53
+#define TARGET_NR_ioctl                   54
+#define TARGET_NR_fcntl                   55
+#define TARGET_NR_mpx                     56
+#define TARGET_NR_setpgid                 57
+#define TARGET_NR_ulimit                  58
+#define TARGET_NR_oldolduname             59
+#define TARGET_NR_umask                   60
+#define TARGET_NR_chroot                  61
+#define TARGET_NR_ustat                   62
+#define TARGET_NR_dup2                    63
+#define TARGET_NR_getppid                 64
+#define TARGET_NR_getpgrp                 65
+#define TARGET_NR_setsid                  66
+#define TARGET_NR_sigaction               67
+#define TARGET_NR_sgetmask                68
+#define TARGET_NR_ssetmask                69
+#define TARGET_NR_setreuid                70
+#define TARGET_NR_setregid                71
+#define TARGET_NR_sigsuspend              72
+#define TARGET_NR_sigpending              73
+#define TARGET_NR_sethostname             74
+#define TARGET_NR_setrlimit               75
+#define TARGET_NR_getrlimit               76
+#define TARGET_NR_getrusage               77
+#define TARGET_NR_gettimeofday            78
+#define TARGET_NR_settimeofday            79
+#define TARGET_NR_getgroups               80
+#define TARGET_NR_setgroups               81
+#define TARGET_NR_select                  82
+#define TARGET_NR_symlink                 83
+#define TARGET_NR_oldlstat                84
+#define TARGET_NR_readlink                85
+#define TARGET_NR_uselib                  86
+#define TARGET_NR_swapon                  87
+#define TARGET_NR_reboot                  88
+#define TARGET_NR_readdir                 89
+#define TARGET_NR_mmap                    90
+#define TARGET_NR_munmap                  91
+#define TARGET_NR_truncate                92
+#define TARGET_NR_ftruncate               93
+#define TARGET_NR_fchmod                  94
+#define TARGET_NR_fchown                  95
+#define TARGET_NR_getpriority             96
+#define TARGET_NR_setpriority             97
+#define TARGET_NR_profil                  98
+#define TARGET_NR_statfs                  99
+#define TARGET_NR_fstatfs                100
+#define TARGET_NR_ioperm                 101
+#define TARGET_NR_socketcall             102
+#define TARGET_NR_syslog                 103
+#define TARGET_NR_setitimer              104
+#define TARGET_NR_getitimer              105
+#define TARGET_NR_stat                   106
+#define TARGET_NR_lstat                  107
+#define TARGET_NR_fstat                  108
+#define TARGET_NR_olduname               109
+#define TARGET_NR_iopl                   110
+#define TARGET_NR_vhangup                111
+#define TARGET_NR_idle                   112
+#define TARGET_NR_vm86                   113
+#define TARGET_NR_wait4                  114
+#define TARGET_NR_swapoff                115
+#define TARGET_NR_sysinfo                116
+#define TARGET_NR_ipc                    117
+#define TARGET_NR_fsync                  118
+#if !defined(TARGET_PPC64)
+#define TARGET_NR_sigreturn              119
+#endif
+#define TARGET_NR_clone                  120
+#define TARGET_NR_setdomainname          121
+#define TARGET_NR_uname                  122
+#define TARGET_NR_modify_ldt             123
+#define TARGET_NR_adjtimex               124
+#define TARGET_NR_mprotect               125
+#define TARGET_NR_sigprocmask            126
+#define TARGET_NR_create_module          127
+#define TARGET_NR_init_module            128
+#define TARGET_NR_delete_module          129
+#define TARGET_NR_get_kernel_syms        130
+#define TARGET_NR_quotactl               131
+#define TARGET_NR_getpgid                132
+#define TARGET_NR_fchdir                 133
+#define TARGET_NR_bdflush                134
+#define TARGET_NR_sysfs                  135
+#define TARGET_NR_personality            136
+#define TARGET_NR_afs_syscall            137 /* Syscall for Andrew File System */
+#define TARGET_NR_setfsuid               138
+#define TARGET_NR_setfsgid               139
+#define TARGET_NR__llseek                140
+#define TARGET_NR_getdents               141
+#define TARGET_NR__newselect             142
+#define TARGET_NR_flock                  143
+#define TARGET_NR_msync                  144
+#define TARGET_NR_readv                  145
+#define TARGET_NR_writev                 146
+#define TARGET_NR_getsid                 147
+#define TARGET_NR_fdatasync              148
+#define TARGET_NR__sysctl                149
+#define TARGET_NR_mlock                  150
+#define TARGET_NR_munlock                151
+#define TARGET_NR_mlockall               152
+#define TARGET_NR_munlockall             153
+#define TARGET_NR_sched_setparam         154
+#define TARGET_NR_sched_getparam         155
+#define TARGET_NR_sched_setscheduler     156
+#define TARGET_NR_sched_getscheduler     157
+#define TARGET_NR_sched_yield            158
+#define TARGET_NR_sched_get_priority_max 159
+#define TARGET_NR_sched_get_priority_min 160
+#define TARGET_NR_sched_rr_get_interval  161
+#define TARGET_NR_nanosleep              162
+#define TARGET_NR_mremap                 163
+#define TARGET_NR_setresuid32            164
+#define TARGET_NR_getresuid32            165
+#define TARGET_NR_query_module           166
+#define TARGET_NR_poll                   167
+#define TARGET_NR_nfsservctl             168
+#define TARGET_NR_setresgid32            169
+#define TARGET_NR_getresgid32            170
+#define TARGET_NR_prctl                  171
+#define TARGET_NR_rt_sigreturn           172
+#define TARGET_NR_rt_sigaction           173
+#define TARGET_NR_rt_sigprocmask         174
+#define TARGET_NR_rt_sigpending          175
+#define TARGET_NR_rt_sigtimedwait        176
+#define TARGET_NR_rt_sigqueueinfo        177
+#define TARGET_NR_rt_sigsuspend          178
+#define TARGET_NR_pread64                179
+#define TARGET_NR_pwrite64               180
+#define TARGET_NR_chown                  181
+#define TARGET_NR_getcwd                 182
+#define TARGET_NR_capget                 183
+#define TARGET_NR_capset                 184
+#define TARGET_NR_sigaltstack            185
+#define TARGET_NR_sendfile               186
+#define TARGET_NR_getpmsg                187     /* some people actually want streams */
+#define TARGET_NR_putpmsg                188     /* some people actually want streams */
+#define TARGET_NR_vfork                  189
+#define TARGET_NR_ugetrlimit             190     /* SuS compliant getrlimit */
+#define TARGET_NR_readahead              191
+#define TARGET_NR_mmap2                  192
+#define TARGET_NR_truncate64             193
+#define TARGET_NR_ftruncate64            194
+#define TARGET_NR_stat64                 195
+#define TARGET_NR_lstat64                196
+#define TARGET_NR_fstat64                197
+#define TARGET_NR_pciconfig_read         198
+#define TARGET_NR_pciconfig_write        199
+#define TARGET_NR_pciconfig_iobase       200
+#define TARGET_NR_multiplexer            201
+#define TARGET_NR_getdents64             202
+#define TARGET_NR_pivot_root             203
+#define TARGET_NR_fcntl64                204
+#define TARGET_NR_madvise                205
+#define TARGET_NR_mincore                206
+#define TARGET_NR_gettid                 207
+#define TARGET_NR_tkill                  208
+#define TARGET_NR_setxattr               209
+#define TARGET_NR_lsetxattr              210
+#define TARGET_NR_fsetxattr              211
+#define TARGET_NR_getxattr               212
+#define TARGET_NR_lgetxattr              213
+#define TARGET_NR_fgetxattr              214
+#define TARGET_NR_listxattr              215
+#define TARGET_NR_llistxattr             216
+#define TARGET_NR_flistxattr             217
+#define TARGET_NR_removexattr            218
+#define TARGET_NR_lremovexattr           219
+#define TARGET_NR_fremovexattr           220
+#define TARGET_NR_futex                  221
+#define TARGET_NR_sched_setaffinity      222
+#define TARGET_NR_sched_getaffinity      223
+/* 224 currently unused */
+#define TARGET_NR_tuxcall                225
+#define TARGET_NR_sendfile64             226
+#define TARGET_NR_io_setup               227
+#define TARGET_NR_io_destroy             228
+#define TARGET_NR_io_getevents           229
+#define TARGET_NR_io_submit              230
+#define TARGET_NR_io_cancel              231
+#define TARGET_NR_set_tid_address        232
+#define TARGET_NR_fadvise64              233
+#define TARGET_NR_exit_group             234
+#define TARGET_NR_lookup_dcookie         235
+#define TARGET_NR_epoll_create           236
+#define TARGET_NR_epoll_ctl              237
+#define TARGET_NR_epoll_wait             238
+#define TARGET_NR_remap_file_pages       239
+#define TARGET_NR_timer_create           240
+#define TARGET_NR_timer_settime          241
+#define TARGET_NR_timer_gettime          242
+#define TARGET_NR_timer_getoverrun       243
+#define TARGET_NR_timer_delete           244
+#define TARGET_NR_clock_settime          245
+#define TARGET_NR_clock_gettime          246
+#define TARGET_NR_clock_getres           247
+#define TARGET_NR_clock_nanosleep        248
+#define TARGET_NR_swapcontext            249
+#define TARGET_NR_tgkill                 250
+#define TARGET_NR_utimes                 251
+#define TARGET_NR_statfs64               252
+#define TARGET_NR_fstatfs64              253
+#define TARGET_NR_fadvise64_64           254
+#define TARGET_NR_rtas          255
+#define TARGET_NR_sys_debug_setcontext 256
+/* Number 257 is reserved for vserver */
+#define TARGET_NR_migrate_pages 258
+#define TARGET_NR_mbind         259
+#define TARGET_NR_get_mempolicy 260
+#define TARGET_NR_set_mempolicy 261
+#define TARGET_NR_mq_open               262
+#define TARGET_NR_mq_unlink             263
+#define TARGET_NR_mq_timedsend  264
+#define TARGET_NR_mq_timedreceive       265
+#define TARGET_NR_mq_notify             266
+#define TARGET_NR_mq_getsetattr 267
+#define TARGET_NR_kexec_load            268
+#define TARGET_NR_add_key               269
+#define TARGET_NR_request_key   270
+#define TARGET_NR_keyctl                271
+#define TARGET_NR_waitid                272
+#define TARGET_NR_ioprio_set            273
+#define TARGET_NR_ioprio_get            274
+#define TARGET_NR_inotify_init  275
+#define TARGET_NR_inotify_add_watch     276
+#define TARGET_NR_inotify_rm_watch      277
+#define TARGET_NR_spu_run               278
+#define TARGET_NR_spu_create            279
+#define TARGET_NR_pselect6              280
+#define TARGET_NR_ppoll         281
+#define TARGET_NR_unshare               282
+#define TARGET_NR_splice                283
+#define TARGET_NR_tee           284
+#define TARGET_NR_vmsplice              285
+#define TARGET_NR_openat                286
+#define TARGET_NR_mkdirat               287
+#define TARGET_NR_mknodat               288
+#define TARGET_NR_fchownat              289
+#define TARGET_NR_futimesat             290
+#define TARGET_NR_fstatat64             291
+#define TARGET_NR_unlinkat              292
+#define TARGET_NR_renameat              293
+#define TARGET_NR_linkat                294
+#define TARGET_NR_symlinkat             295
+#define TARGET_NR_readlinkat            296
+#define TARGET_NR_fchmodat              297
+#define TARGET_NR_faccessat             298
+#define TARGET_NR_get_robust_list       299
+#define TARGET_NR_set_robust_list       300
+#define TARGET_NR_move_pages            301
+#define TARGET_NR_getcpu                302
+#define TARGET_NR_epoll_pwait   303
+#define TARGET_NR_utimensat             304
+#define TARGET_NR_signalfd              305
+#define TARGET_NR_timerfd_create        306
+#define TARGET_NR_eventfd               307
+#define TARGET_NR_sync_file_range2      308
+#define TARGET_NR_fallocate             309
+#define TARGET_NR_subpage_prot          310
+#define TARGET_NR_timerfd_settime       311
+#define TARGET_NR_timerfd_gettime       312
+#define TARGET_NR_signalfd4             313
+#define TARGET_NR_eventfd2              314
+#define TARGET_NR_epoll_create1 315
+#define TARGET_NR_dup3                  316
+#define TARGET_NR_pipe2         317
+#define TARGET_NR_inotify_init1 318
+#define TARGET_NR_perf_event_open       319
+#define TARGET_NR_preadv                320
+#define TARGET_NR_pwritev               321
+#define TARGET_NR_rt_tgsigqueueinfo     322
+#define TARGET_NR_fanotify_init         323
+#define TARGET_NR_fanotify_mark         324
+#define TARGET_NR_prlimit64             325
+#define TARGET_NR_socket                326
+#define TARGET_NR_bind                  327
+#define TARGET_NR_connect               328
+#define TARGET_NR_listen                329
+#define TARGET_NR_accept                330
+#define TARGET_NR_getsockname           331
+#define TARGET_NR_getpeername           332
+#define TARGET_NR_socketpair            333
+#define TARGET_NR_send                  334
+#define TARGET_NR_sendto                335
+#define TARGET_NR_recv                  336
+#define TARGET_NR_recvfrom              337
+#define TARGET_NR_shutdown              338
+#define TARGET_NR_setsockopt            339
+#define TARGET_NR_getsockopt            340
+#define TARGET_NR_sendmsg               341
+#define TARGET_NR_recvmsg               342
+#define TARGET_NR_recvmmsg              343
+#define TARGET_NR_accept4               344
+#define TARGET_NR_name_to_handle_at     345
+#define TARGET_NR_open_by_handle_at     346
+#define TARGET_NR_clock_adjtime         347
+#define TARGET_NR_syncfs                348
+#define TARGET_NR_sendmmsg              349
+#define TARGET_NR_setns                 350
+#define TARGET_NR_process_vm_readv      351
+#define TARGET_NR_process_vm_writev     352
+#define TARGET_NR_finit_module          353
+#define TARGET_NR_kcmp                  354
+#define TARGET_NR_sched_setattr         355
+#define TARGET_NR_sched_getattr         356
+#define TARGET_NR_renameat2             357
+#define TARGET_NR_seccomp               358
+#define TARGET_NR_getrandom             359
+#define TARGET_NR_memfd_create          360
+#define TARGET_NR_bpf                   361
+#define TARGET_NR_execveat              362
+#define TARGET_NR_switch_endian         363
+#define TARGET_NR_userfaultfd           364
+#define TARGET_NR_membarrier            365
+#define TARGET_NR_semop                 366
+#define TARGET_NR_semget                367
+#define TARGET_NR_semctl                368
+#define TARGET_NR_semtimedop            369
+#define TARGET_NR_msgsnd                370
+#define TARGET_NR_msgrcv                371
+#define TARGET_NR_msgget                372
+#define TARGET_NR_msgctl                373
+#define TARGET_NR_shmat                 374
+#define TARGET_NR_shmdt                 375
+#define TARGET_NR_shmget                376
+#define TARGET_NR_shmctl                377
+#define TARGET_NR_mlock2                378
+
+#endif /* LINUX_USER_PPC_SYSCALL32_NR_H */
diff --git a/linux-user/ppc/syscall64_nr.h b/linux-user/ppc/syscall64_nr.h
new file mode 100644
index 000000000000..9c5334223fae
--- /dev/null
+++ b/linux-user/ppc/syscall64_nr.h
@@ -0,0 +1,381 @@
+/*
+ * This file contains the system call numbers.
+ */
+
+#ifndef LINUX_USER_PPC_SYSCALL64_NR_H
+#define LINUX_USER_PPC_SYSCALL64_NR_H
+
+#define TARGET_NR_restart_syscall          0
+#define TARGET_NR_exit                     1
+#define TARGET_NR_fork                     2
+#define TARGET_NR_read                     3
+#define TARGET_NR_write                    4
+#define TARGET_NR_open                     5
+#define TARGET_NR_close                    6
+#define TARGET_NR_waitpid                  7
+#define TARGET_NR_creat                    8
+#define TARGET_NR_link                     9
+#define TARGET_NR_unlink                  10
+#define TARGET_NR_execve                  11
+#define TARGET_NR_chdir                   12
+#define TARGET_NR_time                    13
+#define TARGET_NR_mknod                   14
+#define TARGET_NR_chmod                   15
+#define TARGET_NR_lchown                  16
+#define TARGET_NR_break                   17
+#define TARGET_NR_oldstat                 18
+#define TARGET_NR_lseek                   19
+#define TARGET_NR_getpid                  20
+#define TARGET_NR_mount                   21
+#define TARGET_NR_umount                  22
+#define TARGET_NR_setuid                  23
+#define TARGET_NR_getuid                  24
+#define TARGET_NR_stime                   25
+#define TARGET_NR_ptrace                  26
+#define TARGET_NR_alarm                   27
+#define TARGET_NR_oldfstat                28
+#define TARGET_NR_pause                   29
+#define TARGET_NR_utime                   30
+#define TARGET_NR_stty                    31
+#define TARGET_NR_gtty                    32
+#define TARGET_NR_access                  33
+#define TARGET_NR_nice                    34
+#define TARGET_NR_ftime                   35
+#define TARGET_NR_sync                    36
+#define TARGET_NR_kill                    37
+#define TARGET_NR_rename                  38
+#define TARGET_NR_mkdir                   39
+#define TARGET_NR_rmdir                   40
+#define TARGET_NR_dup                     41
+#define TARGET_NR_pipe                    42
+#define TARGET_NR_times                   43
+#define TARGET_NR_prof                    44
+#define TARGET_NR_brk                     45
+#define TARGET_NR_setgid                  46
+#define TARGET_NR_getgid                  47
+#define TARGET_NR_signal                  48
+#define TARGET_NR_geteuid                 49
+#define TARGET_NR_getegid                 50
+#define TARGET_NR_acct                    51
+#define TARGET_NR_umount2                 52
+#define TARGET_NR_lock                    53
+#define TARGET_NR_ioctl                   54
+#define TARGET_NR_fcntl                   55
+#define TARGET_NR_mpx                     56
+#define TARGET_NR_setpgid                 57
+#define TARGET_NR_ulimit                  58
+#define TARGET_NR_oldolduname             59
+#define TARGET_NR_umask                   60
+#define TARGET_NR_chroot                  61
+#define TARGET_NR_ustat                   62
+#define TARGET_NR_dup2                    63
+#define TARGET_NR_getppid                 64
+#define TARGET_NR_getpgrp                 65
+#define TARGET_NR_setsid                  66
+#define TARGET_NR_sigaction               67
+#define TARGET_NR_sgetmask                68
+#define TARGET_NR_ssetmask                69
+#define TARGET_NR_setreuid                70
+#define TARGET_NR_setregid                71
+#define TARGET_NR_sigsuspend              72
+#define TARGET_NR_sigpending              73
+#define TARGET_NR_sethostname             74
+#define TARGET_NR_setrlimit               75
+#define TARGET_NR_getrlimit               76
+#define TARGET_NR_getrusage               77
+#define TARGET_NR_gettimeofday            78
+#define TARGET_NR_settimeofday            79
+#define TARGET_NR_getgroups               80
+#define TARGET_NR_setgroups               81
+#define TARGET_NR_select                  82
+#define TARGET_NR_symlink                 83
+#define TARGET_NR_oldlstat                84
+#define TARGET_NR_readlink                85
+#define TARGET_NR_uselib                  86
+#define TARGET_NR_swapon                  87
+#define TARGET_NR_reboot                  88
+#define TARGET_NR_readdir                 89
+#define TARGET_NR_mmap                    90
+#define TARGET_NR_munmap                  91
+#define TARGET_NR_truncate                92
+#define TARGET_NR_ftruncate               93
+#define TARGET_NR_fchmod                  94
+#define TARGET_NR_fchown                  95
+#define TARGET_NR_getpriority             96
+#define TARGET_NR_setpriority             97
+#define TARGET_NR_profil                  98
+#define TARGET_NR_statfs                  99
+#define TARGET_NR_fstatfs                100
+#define TARGET_NR_ioperm                 101
+#define TARGET_NR_socketcall             102
+#define TARGET_NR_syslog                 103
+#define TARGET_NR_setitimer              104
+#define TARGET_NR_getitimer              105
+#define TARGET_NR_stat                   106
+#define TARGET_NR_lstat                  107
+#define TARGET_NR_fstat                  108
+#define TARGET_NR_olduname               109
+#define TARGET_NR_iopl                   110
+#define TARGET_NR_vhangup                111
+#define TARGET_NR_idle                   112
+#define TARGET_NR_vm86                   113
+#define TARGET_NR_wait4                  114
+#define TARGET_NR_swapoff                115
+#define TARGET_NR_sysinfo                116
+#define TARGET_NR_ipc                    117
+#define TARGET_NR_fsync                  118
+#if !defined(TARGET_PPC64)
+#define TARGET_NR_sigreturn              119
+#endif
+#define TARGET_NR_clone                  120
+#define TARGET_NR_setdomainname          121
+#define TARGET_NR_uname                  122
+#define TARGET_NR_modify_ldt             123
+#define TARGET_NR_adjtimex               124
+#define TARGET_NR_mprotect               125
+#define TARGET_NR_sigprocmask            126
+#define TARGET_NR_create_module          127
+#define TARGET_NR_init_module            128
+#define TARGET_NR_delete_module          129
+#define TARGET_NR_get_kernel_syms        130
+#define TARGET_NR_quotactl               131
+#define TARGET_NR_getpgid                132
+#define TARGET_NR_fchdir                 133
+#define TARGET_NR_bdflush                134
+#define TARGET_NR_sysfs                  135
+#define TARGET_NR_personality            136
+#define TARGET_NR_afs_syscall            137 /* Syscall for Andrew File System */
+#define TARGET_NR_setfsuid               138
+#define TARGET_NR_setfsgid               139
+#define TARGET_NR__llseek                140
+#define TARGET_NR_getdents               141
+#define TARGET_NR__newselect             142
+#define TARGET_NR_flock                  143
+#define TARGET_NR_msync                  144
+#define TARGET_NR_readv                  145
+#define TARGET_NR_writev                 146
+#define TARGET_NR_getsid                 147
+#define TARGET_NR_fdatasync              148
+#define TARGET_NR__sysctl                149
+#define TARGET_NR_mlock                  150
+#define TARGET_NR_munlock                151
+#define TARGET_NR_mlockall               152
+#define TARGET_NR_munlockall             153
+#define TARGET_NR_sched_setparam         154
+#define TARGET_NR_sched_getparam         155
+#define TARGET_NR_sched_setscheduler     156
+#define TARGET_NR_sched_getscheduler     157
+#define TARGET_NR_sched_yield            158
+#define TARGET_NR_sched_get_priority_max 159
+#define TARGET_NR_sched_get_priority_min 160
+#define TARGET_NR_sched_rr_get_interval  161
+#define TARGET_NR_nanosleep              162
+#define TARGET_NR_mremap                 163
+#define TARGET_NR_setresuid32            164
+#define TARGET_NR_getresuid32            165
+#define TARGET_NR_query_module           166
+#define TARGET_NR_poll                   167
+#define TARGET_NR_nfsservctl             168
+#define TARGET_NR_setresgid32            169
+#define TARGET_NR_getresgid32            170
+#define TARGET_NR_prctl                  171
+#define TARGET_NR_rt_sigreturn           172
+#define TARGET_NR_rt_sigaction           173
+#define TARGET_NR_rt_sigprocmask         174
+#define TARGET_NR_rt_sigpending          175
+#define TARGET_NR_rt_sigtimedwait        176
+#define TARGET_NR_rt_sigqueueinfo        177
+#define TARGET_NR_rt_sigsuspend          178
+#define TARGET_NR_pread64                179
+#define TARGET_NR_pwrite64               180
+#define TARGET_NR_chown                  181
+#define TARGET_NR_getcwd                 182
+#define TARGET_NR_capget                 183
+#define TARGET_NR_capset                 184
+#define TARGET_NR_sigaltstack            185
+#define TARGET_NR_sendfile               186
+#define TARGET_NR_getpmsg                187     /* some people actually want streams */
+#define TARGET_NR_putpmsg                188     /* some people actually want streams */
+#define TARGET_NR_vfork                  189
+#define TARGET_NR_ugetrlimit             190     /* SuS compliant getrlimit */
+#define TARGET_NR_readahead              191
+#define TARGET_NR_pciconfig_read         198
+#define TARGET_NR_pciconfig_write        199
+#define TARGET_NR_pciconfig_iobase       200
+#define TARGET_NR_multiplexer            201
+#define TARGET_NR_getdents64             202
+#define TARGET_NR_pivot_root             203
+#define TARGET_NR_madvise                205
+#define TARGET_NR_mincore                206
+#define TARGET_NR_gettid                 207
+#define TARGET_NR_tkill                  208
+#define TARGET_NR_setxattr               209
+#define TARGET_NR_lsetxattr              210
+#define TARGET_NR_fsetxattr              211
+#define TARGET_NR_getxattr               212
+#define TARGET_NR_lgetxattr              213
+#define TARGET_NR_fgetxattr              214
+#define TARGET_NR_listxattr              215
+#define TARGET_NR_llistxattr             216
+#define TARGET_NR_flistxattr             217
+#define TARGET_NR_removexattr            218
+#define TARGET_NR_lremovexattr           219
+#define TARGET_NR_fremovexattr           220
+#define TARGET_NR_futex                  221
+#define TARGET_NR_sched_setaffinity      222
+#define TARGET_NR_sched_getaffinity      223
+/* 224 currently unused */
+#define TARGET_NR_tuxcall                225
+#define TARGET_NR_io_setup               227
+#define TARGET_NR_io_destroy             228
+#define TARGET_NR_io_getevents           229
+#define TARGET_NR_io_submit              230
+#define TARGET_NR_io_cancel              231
+#define TARGET_NR_set_tid_address        232
+#define TARGET_NR_fadvise64              233
+#define TARGET_NR_exit_group             234
+#define TARGET_NR_lookup_dcookie         235
+#define TARGET_NR_epoll_create           236
+#define TARGET_NR_epoll_ctl              237
+#define TARGET_NR_epoll_wait             238
+#define TARGET_NR_remap_file_pages       239
+#define TARGET_NR_timer_create           240
+#define TARGET_NR_timer_settime          241
+#define TARGET_NR_timer_gettime          242
+#define TARGET_NR_timer_getoverrun       243
+#define TARGET_NR_timer_delete           244
+#define TARGET_NR_clock_settime          245
+#define TARGET_NR_clock_gettime          246
+#define TARGET_NR_clock_getres           247
+#define TARGET_NR_clock_nanosleep        248
+#define TARGET_NR_swapcontext            249
+#define TARGET_NR_tgkill                 250
+#define TARGET_NR_utimes                 251
+#define TARGET_NR_statfs64               252
+#define TARGET_NR_fstatfs64              253
+#define TARGET_NR_rtas          255
+#define TARGET_NR_sys_debug_setcontext 256
+/* Number 257 is reserved for vserver */
+#define TARGET_NR_migrate_pages 258
+#define TARGET_NR_mbind         259
+#define TARGET_NR_get_mempolicy 260
+#define TARGET_NR_set_mempolicy 261
+#define TARGET_NR_mq_open               262
+#define TARGET_NR_mq_unlink             263
+#define TARGET_NR_mq_timedsend  264
+#define TARGET_NR_mq_timedreceive       265
+#define TARGET_NR_mq_notify             266
+#define TARGET_NR_mq_getsetattr 267
+#define TARGET_NR_kexec_load            268
+#define TARGET_NR_add_key               269
+#define TARGET_NR_request_key   270
+#define TARGET_NR_keyctl                271
+#define TARGET_NR_waitid                272
+#define TARGET_NR_ioprio_set            273
+#define TARGET_NR_ioprio_get            274
+#define TARGET_NR_inotify_init  275
+#define TARGET_NR_inotify_add_watch     276
+#define TARGET_NR_inotify_rm_watch      277
+#define TARGET_NR_spu_run               278
+#define TARGET_NR_spu_create            279
+#define TARGET_NR_pselect6              280
+#define TARGET_NR_ppoll         281
+#define TARGET_NR_unshare               282
+#define TARGET_NR_splice                283
+#define TARGET_NR_tee           284
+#define TARGET_NR_vmsplice              285
+#define TARGET_NR_openat                286
+#define TARGET_NR_mkdirat               287
+#define TARGET_NR_mknodat               288
+#define TARGET_NR_fchownat              289
+#define TARGET_NR_futimesat             290
+#define TARGET_NR_newfstatat            291
+#define TARGET_NR_unlinkat              292
+#define TARGET_NR_renameat              293
+#define TARGET_NR_linkat                294
+#define TARGET_NR_symlinkat             295
+#define TARGET_NR_readlinkat            296
+#define TARGET_NR_fchmodat              297
+#define TARGET_NR_faccessat             298
+#define TARGET_NR_get_robust_list       299
+#define TARGET_NR_set_robust_list       300
+#define TARGET_NR_move_pages            301
+#define TARGET_NR_getcpu                302
+#define TARGET_NR_epoll_pwait   303
+#define TARGET_NR_utimensat             304
+#define TARGET_NR_signalfd              305
+#define TARGET_NR_timerfd_create        306
+#define TARGET_NR_eventfd               307
+#define TARGET_NR_sync_file_range2      308
+#define TARGET_NR_fallocate             309
+#define TARGET_NR_subpage_prot          310
+#define TARGET_NR_timerfd_settime       311
+#define TARGET_NR_timerfd_gettime       312
+#define TARGET_NR_signalfd4             313
+#define TARGET_NR_eventfd2              314
+#define TARGET_NR_epoll_create1 315
+#define TARGET_NR_dup3                  316
+#define TARGET_NR_pipe2         317
+#define TARGET_NR_inotify_init1 318
+#define TARGET_NR_perf_event_open       319
+#define TARGET_NR_preadv                320
+#define TARGET_NR_pwritev               321
+#define TARGET_NR_rt_tgsigqueueinfo     322
+#define TARGET_NR_fanotify_init         323
+#define TARGET_NR_fanotify_mark         324
+#define TARGET_NR_prlimit64             325
+#define TARGET_NR_socket                326
+#define TARGET_NR_bind                  327
+#define TARGET_NR_connect               328
+#define TARGET_NR_listen                329
+#define TARGET_NR_accept                330
+#define TARGET_NR_getsockname           331
+#define TARGET_NR_getpeername           332
+#define TARGET_NR_socketpair            333
+#define TARGET_NR_send                  334
+#define TARGET_NR_sendto                335
+#define TARGET_NR_recv                  336
+#define TARGET_NR_recvfrom              337
+#define TARGET_NR_shutdown              338
+#define TARGET_NR_setsockopt            339
+#define TARGET_NR_getsockopt            340
+#define TARGET_NR_sendmsg               341
+#define TARGET_NR_recvmsg               342
+#define TARGET_NR_recvmmsg              343
+#define TARGET_NR_accept4               344
+#define TARGET_NR_name_to_handle_at     345
+#define TARGET_NR_open_by_handle_at     346
+#define TARGET_NR_clock_adjtime         347
+#define TARGET_NR_syncfs                348
+#define TARGET_NR_sendmmsg              349
+#define TARGET_NR_setns                 350
+#define TARGET_NR_process_vm_readv      351
+#define TARGET_NR_process_vm_writev     352
+#define TARGET_NR_finit_module          353
+#define TARGET_NR_kcmp                  354
+#define TARGET_NR_sched_setattr         355
+#define TARGET_NR_sched_getattr         356
+#define TARGET_NR_renameat2             357
+#define TARGET_NR_seccomp               358
+#define TARGET_NR_getrandom             359
+#define TARGET_NR_memfd_create          360
+#define TARGET_NR_bpf                   361
+#define TARGET_NR_execveat              362
+#define TARGET_NR_switch_endian         363
+#define TARGET_NR_userfaultfd           364
+#define TARGET_NR_membarrier            365
+#define TARGET_NR_semop                 366
+#define TARGET_NR_semget                367
+#define TARGET_NR_semctl                368
+#define TARGET_NR_semtimedop            369
+#define TARGET_NR_msgsnd                370
+#define TARGET_NR_msgrcv                371
+#define TARGET_NR_msgget                372
+#define TARGET_NR_msgctl                373
+#define TARGET_NR_shmat                 374
+#define TARGET_NR_shmdt                 375
+#define TARGET_NR_shmget                376
+#define TARGET_NR_shmctl                377
+#define TARGET_NR_mlock2                378
+
+#endif /* LINUX_USER_PPC_SYSCALL64_NR_H */
diff --git a/linux-user/ppc/syscall_nr.h b/linux-user/ppc/syscall_nr.h
index b57a07b931af..f2bbbee18da3 100644
--- a/linux-user/ppc/syscall_nr.h
+++ b/linux-user/ppc/syscall_nr.h
@@ -5,398 +5,10 @@
 #ifndef LINUX_USER_PPC_SYSCALL_NR_H
 #define LINUX_USER_PPC_SYSCALL_NR_H
 
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
 #if !defined(TARGET_PPC64) || defined(TARGET_ABI32)
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
+#include "syscall32_nr.h"
 #else
-#define TARGET_NR_fstatat64		291
+#include "syscall64_nr.h"
 #endif
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
 
-#endif
+#endif /* LINUX_USER_PPC_SYSCALL_NR_H */
-- 
2.24.1


