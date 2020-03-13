Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D4AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469052074E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469052074E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCsCj-0005Ge-Fy
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jCsBz-0004VL-Fi
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jCsBv-0004f9-PS
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:50:07 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58917)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jCsBv-0004Zx-BR; Fri, 13 Mar 2020 17:50:03 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MtOSu-1jRwbK2kPO-00uqEg; Fri, 13 Mar 2020 22:49:57 +0100
Subject: Re: [PATCH v7 4/4] linux-user/riscv: Update the syscall_nr's to the
 5.5 kernel
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, aleksandar.m.mail@gmail.com
References: <cover.1584051142.git.alistair.francis@wdc.com>
 <8e512fa2dc885aafc4d9c4013ee033442827a4a0.1584051142.git.alistair.francis@wdc.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2ee79754-6d99-bea0-4826-fb254dd557dd@vivier.eu>
Date: Fri, 13 Mar 2020 22:49:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8e512fa2dc885aafc4d9c4013ee033442827a4a0.1584051142.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GvGH1vEDH3jVp2/3bdlfkU9XZU9KOCvpAlQyh6cyoZaFChHF6Qn
 W/OfZ7kd6rEkuytWEiPsxQkso+NNYedHTY5foCYprZAnEGQO1ucNTvxT8YlXAfzwtqzaIbb
 VgkPIYkqg12ehJflRsQtH9ieBqBK/zP2N4IMrvcaT+GxE2ZzT1LKVD4Bo4MeEFlQPxY1Ngq
 8v0WBQiBcNiv5dkScFQBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ep0wxB1lzXc=:WunLnqlBC84/icrJ45ZcGi
 3sP1zIFvF84sAIIvQDaW00Z0N/syXEAKSfq85PrmpykRluavNDAWfK9XBRy4M4dck9sKgNgSv
 Iy9/jFNEZBBTWTrkZ6iLD9pga6ej7lgzwAaSsx/J00ka9dRjjBpg6OV95zoc1cyG5Z5rPaKBn
 V2mldy8B+JHRkEwSpdd/nmBjKO8KzwWOap7m2SWWfQ/ec0c1ocB66ExFPMxKi1Nf1vQ8Pvkj/
 9zuGfFpw6R32M/qrCyIBIMt1iFQzqOy+SlygvnD3CZhl5U55JI3z7tfy+zGqsVr1HmLPW++0s
 cf+e0I65KFZE+PcbC4DdYERCLC4C7qzvLRL0WEJ3B6ZtSZTnqepz+/oVIkFRVCv2ohstdY0T6
 klfzKKHNuM4FPHblnVLmqPzZcX3xYsEK7Gsgy6hVJk1C/VjLQhMZvT0Wn+l25T+vIXGgfkTNb
 +Mvc2QCE/JLceXOGIa4iju3+jJBPFS6UwEKPFHLXoM0OhgVD7YZjd6hYXL/g3Xal0uZ5RXKdS
 mJRwMtaKs0O17eXzr9ZvKl0lQOs/WmqZkB6ozZOQ8vclb55yNSVSclhcMMNVFoKq+0/OwLBSU
 hqUAnvalAevlBEB7zJmoet6UPP7KktOzXLKVh2QvE/0OpMCprWPZQRHZdnm4qNVOAdAohmyJh
 iyJ7fuuyUqJAPk8ft7uSumdE9dIKNG/DWmoooeR0qV40qD0QkbHjZjkSHy5MwfNqpvUW0Yp04
 8+1cSDzu5n1PcGEREHNfehqzB0SIhB7SUqNBvZsXAD0TS8h1VZxJ5qioBKr25IqGZ9oxnMaOC
 6kr6ugg731xWK8gKsFc+VZM/HVCyF5kLubSC94lgrxTg4CyRas23SEnK5Vk9yqFGnMk2Jrr
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/03/2020 à 23:14, Alistair Francis a écrit :
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/riscv/syscall32_nr.h | 295 +++++++++++++++++++++++++++++++
>  linux-user/riscv/syscall64_nr.h | 301 ++++++++++++++++++++++++++++++++
>  linux-user/riscv/syscall_nr.h   | 294 +------------------------------
>  3 files changed, 598 insertions(+), 292 deletions(-)
>  create mode 100644 linux-user/riscv/syscall32_nr.h
>  create mode 100644 linux-user/riscv/syscall64_nr.h
> 
> diff --git a/linux-user/riscv/syscall32_nr.h b/linux-user/riscv/syscall32_nr.h
> new file mode 100644
> index 0000000000..4fef73e954
> --- /dev/null
> +++ b/linux-user/riscv/syscall32_nr.h
> @@ -0,0 +1,295 @@
> +/*
> + * This file contains the system call numbers.
> + */
> +#ifndef LINUX_USER_RISCV_SYSCALL32_NR_H
> +#define LINUX_USER_RISCV_SYSCALL32_NR_H
> +
> +#define TARGET_NR_io_setup 0
> +#define TARGET_NR_io_destroy 1
> +#define TARGET_NR_io_submit 2
> +#define TARGET_NR_io_cancel 3
> +#define TARGET_NR_setxattr 5
> +#define TARGET_NR_lsetxattr 6
> +#define TARGET_NR_fsetxattr 7
> +#define TARGET_NR_getxattr 8
> +#define TARGET_NR_lgetxattr 9
> +#define TARGET_NR_fgetxattr 10
> +#define TARGET_NR_listxattr 11
> +#define TARGET_NR_llistxattr 12
> +#define TARGET_NR_flistxattr 13
> +#define TARGET_NR_removexattr 14
> +#define TARGET_NR_lremovexattr 15
> +#define TARGET_NR_fremovexattr 16
> +#define TARGET_NR_getcwd 17
> +#define TARGET_NR_lookup_dcookie 18
> +#define TARGET_NR_eventfd2 19
> +#define TARGET_NR_epoll_create1 20
> +#define TARGET_NR_epoll_ctl 21
> +#define TARGET_NR_epoll_pwait 22
> +#define TARGET_NR_dup 23
> +#define TARGET_NR_dup3 24
> +#define TARGET_NR_fcntl64 25
> +#define TARGET_NR_inotify_init1 26
> +#define TARGET_NR_inotify_add_watch 27
> +#define TARGET_NR_inotify_rm_watch 28
> +#define TARGET_NR_ioctl 29
> +#define TARGET_NR_ioprio_set 30
> +#define TARGET_NR_ioprio_get 31
> +#define TARGET_NR_flock 32
> +#define TARGET_NR_mknodat 33
> +#define TARGET_NR_mkdirat 34
> +#define TARGET_NR_unlinkat 35
> +#define TARGET_NR_symlinkat 36
> +#define TARGET_NR_linkat 37
> +#define TARGET_NR_umount2 39
> +#define TARGET_NR_mount 40
> +#define TARGET_NR_pivot_root 41
> +#define TARGET_NR_nfsservctl 42
> +#define TARGET_NR_statfs64 43
> +#define TARGET_NR_fstatfs64 44
> +#define TARGET_NR_truncate64 45
> +#define TARGET_NR_ftruncate64 46
> +#define TARGET_NR_fallocate 47
> +#define TARGET_NR_faccessat 48
> +#define TARGET_NR_chdir 49
> +#define TARGET_NR_fchdir 50
> +#define TARGET_NR_chroot 51
> +#define TARGET_NR_fchmod 52
> +#define TARGET_NR_fchmodat 53
> +#define TARGET_NR_fchownat 54
> +#define TARGET_NR_fchown 55
> +#define TARGET_NR_openat 56
> +#define TARGET_NR_close 57
> +#define TARGET_NR_vhangup 58
> +#define TARGET_NR_pipe2 59
> +#define TARGET_NR_quotactl 60
> +#define TARGET_NR_getdents64 61
> +#define TARGET_NR_llseek 62
> +#define TARGET_NR_read 63
> +#define TARGET_NR_write 64
> +#define TARGET_NR_readv 65
> +#define TARGET_NR_writev 66
> +#define TARGET_NR_pread64 67
> +#define TARGET_NR_pwrite64 68
> +#define TARGET_NR_preadv 69
> +#define TARGET_NR_pwritev 70
> +#define TARGET_NR_sendfile64 71
> +#define TARGET_NR_signalfd4 74
> +#define TARGET_NR_vmsplice 75
> +#define TARGET_NR_splice 76
> +#define TARGET_NR_tee 77
> +#define TARGET_NR_readlinkat 78
> +#define TARGET_NR_fstatat64 79
> +#define TARGET_NR_fstat64 80
> +#define TARGET_NR_sync 81
> +#define TARGET_NR_fsync 82
> +#define TARGET_NR_fdatasync 83
> +#define TARGET_NR_sync_file_range 84
> +#define TARGET_NR_timerfd_create 85
> +#define TARGET_NR_acct 89
> +#define TARGET_NR_capget 90
> +#define TARGET_NR_capset 91
> +#define TARGET_NR_personality 92
> +#define TARGET_NR_exit 93
> +#define TARGET_NR_exit_group 94
> +#define TARGET_NR_waitid 95
> +#define TARGET_NR_set_tid_address 96
> +#define TARGET_NR_unshare 97
> +#define TARGET_NR_set_robust_list 99
> +#define TARGET_NR_get_robust_list 100
> +#define TARGET_NR_getitimer 102
> +#define TARGET_NR_setitimer 103
> +#define TARGET_NR_kexec_load 104
> +#define TARGET_NR_init_module 105
> +#define TARGET_NR_delete_module 106
> +#define TARGET_NR_timer_create 107
> +#define TARGET_NR_timer_getoverrun 109
> +#define TARGET_NR_timer_delete 111
> +#define TARGET_NR_syslog 116
> +#define TARGET_NR_ptrace 117
> +#define TARGET_NR_sched_setparam 118
> +#define TARGET_NR_sched_setscheduler 119
> +#define TARGET_NR_sched_getscheduler 120
> +#define TARGET_NR_sched_getparam 121
> +#define TARGET_NR_sched_setaffinity 122
> +#define TARGET_NR_sched_getaffinity 123
> +#define TARGET_NR_sched_yield 124
> +#define TARGET_NR_sched_get_priority_max 125
> +#define TARGET_NR_sched_get_priority_min 126
> +#define TARGET_NR_restart_syscall 128
> +#define TARGET_NR_kill 129
> +#define TARGET_NR_tkill 130
> +#define TARGET_NR_tgkill 131
> +#define TARGET_NR_sigaltstack 132
> +#define TARGET_NR_rt_sigsuspend 133
> +#define TARGET_NR_rt_sigaction 134
> +#define TARGET_NR_rt_sigprocmask 135
> +#define TARGET_NR_rt_sigpending 136
> +#define TARGET_NR_rt_sigqueueinfo 138
> +#define TARGET_NR_rt_sigreturn 139
> +#define TARGET_NR_setpriority 140
> +#define TARGET_NR_getpriority 141
> +#define TARGET_NR_reboot 142
> +#define TARGET_NR_setregid 143
> +#define TARGET_NR_setgid 144
> +#define TARGET_NR_setreuid 145
> +#define TARGET_NR_setuid 146
> +#define TARGET_NR_setresuid 147
> +#define TARGET_NR_getresuid 148
> +#define TARGET_NR_setresgid 149
> +#define TARGET_NR_getresgid 150
> +#define TARGET_NR_setfsuid 151
> +#define TARGET_NR_setfsgid 152
> +#define TARGET_NR_times 153
> +#define TARGET_NR_setpgid 154
> +#define TARGET_NR_getpgid 155
> +#define TARGET_NR_getsid 156
> +#define TARGET_NR_setsid 157
> +#define TARGET_NR_getgroups 158
> +#define TARGET_NR_setgroups 159
> +#define TARGET_NR_uname 160
> +#define TARGET_NR_sethostname 161
> +#define TARGET_NR_setdomainname 162
> +#define TARGET_NR_getrlimit 163
> +#define TARGET_NR_setrlimit 164
> +#define TARGET_NR_getrusage 165
> +#define TARGET_NR_umask 166
> +#define TARGET_NR_prctl 167
> +#define TARGET_NR_getcpu 168
> +#define TARGET_NR_getpid 172
> +#define TARGET_NR_getppid 173
> +#define TARGET_NR_getuid 174
> +#define TARGET_NR_geteuid 175
> +#define TARGET_NR_getgid 176
> +#define TARGET_NR_getegid 177
> +#define TARGET_NR_gettid 178
> +#define TARGET_NR_sysinfo 179
> +#define TARGET_NR_mq_open 180
> +#define TARGET_NR_mq_unlink 181
> +#define TARGET_NR_mq_notify 184
> +#define TARGET_NR_mq_getsetattr 185
> +#define TARGET_NR_msgget 186
> +#define TARGET_NR_msgctl 187
> +#define TARGET_NR_msgrcv 188
> +#define TARGET_NR_msgsnd 189
> +#define TARGET_NR_semget 190
> +#define TARGET_NR_semctl 191
> +#define TARGET_NR_semop 193
> +#define TARGET_NR_shmget 194
> +#define TARGET_NR_shmctl 195
> +#define TARGET_NR_shmat 196
> +#define TARGET_NR_shmdt 197
> +#define TARGET_NR_socket 198
> +#define TARGET_NR_socketpair 199
> +#define TARGET_NR_bind 200
> +#define TARGET_NR_listen 201
> +#define TARGET_NR_accept 202
> +#define TARGET_NR_connect 203
> +#define TARGET_NR_getsockname 204
> +#define TARGET_NR_getpeername 205
> +#define TARGET_NR_sendto 206
> +#define TARGET_NR_recvfrom 207
> +#define TARGET_NR_setsockopt 208
> +#define TARGET_NR_getsockopt 209
> +#define TARGET_NR_shutdown 210
> +#define TARGET_NR_sendmsg 211
> +#define TARGET_NR_recvmsg 212
> +#define TARGET_NR_readahead 213
> +#define TARGET_NR_brk 214
> +#define TARGET_NR_munmap 215
> +#define TARGET_NR_mremap 216
> +#define TARGET_NR_add_key 217
> +#define TARGET_NR_request_key 218
> +#define TARGET_NR_keyctl 219
> +#define TARGET_NR_clone 220
> +#define TARGET_NR_execve 221
> +#define TARGET_NR_mmap2 222
> +#define TARGET_NR_fadvise64_64 223
> +#define TARGET_NR_swapon 224
> +#define TARGET_NR_swapoff 225
> +#define TARGET_NR_mprotect 226
> +#define TARGET_NR_msync 227
> +#define TARGET_NR_mlock 228
> +#define TARGET_NR_munlock 229
> +#define TARGET_NR_mlockall 230
> +#define TARGET_NR_munlockall 231
> +#define TARGET_NR_mincore 232
> +#define TARGET_NR_madvise 233
> +#define TARGET_NR_remap_file_pages 234
> +#define TARGET_NR_mbind 235
> +#define TARGET_NR_get_mempolicy 236
> +#define TARGET_NR_set_mempolicy 237
> +#define TARGET_NR_migrate_pages 238
> +#define TARGET_NR_move_pages 239
> +#define TARGET_NR_rt_tgsigqueueinfo 240
> +#define TARGET_NR_perf_event_open 241
> +#define TARGET_NR_accept4 242
> +#define TARGET_NR_arch_specific_syscall 244
> +#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
> +#define TARGET_NR_prlimit64 261
> +#define TARGET_NR_fanotify_init 262
> +#define TARGET_NR_fanotify_mark 263
> +#define TARGET_NR_name_to_handle_at 264
> +#define TARGET_NR_open_by_handle_at 265
> +#define TARGET_NR_syncfs 267
> +#define TARGET_NR_setns 268
> +#define TARGET_NR_sendmmsg 269
> +#define TARGET_NR_process_vm_readv 270
> +#define TARGET_NR_process_vm_writev 271
> +#define TARGET_NR_kcmp 272
> +#define TARGET_NR_finit_module 273
> +#define TARGET_NR_sched_setattr 274
> +#define TARGET_NR_sched_getattr 275
> +#define TARGET_NR_renameat2 276
> +#define TARGET_NR_seccomp 277
> +#define TARGET_NR_getrandom 278
> +#define TARGET_NR_memfd_create 279
> +#define TARGET_NR_bpf 280
> +#define TARGET_NR_execveat 281
> +#define TARGET_NR_userfaultfd 282
> +#define TARGET_NR_membarrier 283
> +#define TARGET_NR_mlock2 284
> +#define TARGET_NR_copy_file_range 285
> +#define TARGET_NR_preadv2 286
> +#define TARGET_NR_pwritev2 287
> +#define TARGET_NR_pkey_mprotect 288
> +#define TARGET_NR_pkey_alloc 289
> +#define TARGET_NR_pkey_free 290
> +#define TARGET_NR_statx 291
> +#define TARGET_NR_rseq 293
> +#define TARGET_NR_kexec_file_load 294
> +#define TARGET_NR_clock_gettime64 403
> +#define TARGET_NR_clock_settime64 404
> +#define TARGET_NR_clock_adjtime64 405
> +#define TARGET_NR_clock_getres_time64 406
> +#define TARGET_NR_clock_nanosleep_time64 407
> +#define TARGET_NR_timer_gettime64 408
> +#define TARGET_NR_timer_settime64 409
> +#define TARGET_NR_timerfd_gettime64 410
> +#define TARGET_NR_timerfd_settime64 411
> +#define TARGET_NR_utimensat_time64 412
> +#define TARGET_NR_pselect6_time64 413
> +#define TARGET_NR_ppoll_time64 414
> +#define TARGET_NR_io_pgetevents_time64 416
> +#define TARGET_NR_recvmmsg_time64 417
> +#define TARGET_NR_mq_timedsend_time64 418
> +#define TARGET_NR_mq_timedreceive_time64 419
> +#define TARGET_NR_semtimedop_time64 420
> +#define TARGET_NR_rt_sigtimedwait_time64 421
> +#define TARGET_NR_futex_time64 422
> +#define TARGET_NR_sched_rr_get_interval_time64 423
> +#define TARGET_NR_pidfd_send_signal 424
> +#define TARGET_NR_io_uring_setup 425
> +#define TARGET_NR_io_uring_enter 426
> +#define TARGET_NR_io_uring_register 427
> +#define TARGET_NR_open_tree 428
> +#define TARGET_NR_move_mount 429
> +#define TARGET_NR_fsopen 430
> +#define TARGET_NR_fsconfig 431
> +#define TARGET_NR_fsmount 432
> +#define TARGET_NR_fspick 433
> +#define TARGET_NR_pidfd_open 434
> +#define TARGET_NR_clone3 435
> +#define TARGET_NR_syscalls 436
> +
> +#endif /* LINUX_USER_RISCV_SYSCALL32_NR_H */
> diff --git a/linux-user/riscv/syscall64_nr.h b/linux-user/riscv/syscall64_nr.h
> new file mode 100644
> index 0000000000..cc82f3244f
> --- /dev/null
> +++ b/linux-user/riscv/syscall64_nr.h
> @@ -0,0 +1,301 @@
> +/*
> + * This file contains the system call numbers.
> + */
> +#ifndef LINUX_USER_RISCV_SYSCALL64_NR_H
> +#define LINUX_USER_RISCV_SYSCALL64_NR_H
> +
> +#define TARGET_NR_io_setup 0
> +#define TARGET_NR_io_destroy 1
> +#define TARGET_NR_io_submit 2
> +#define TARGET_NR_io_cancel 3
> +#define TARGET_NR_io_getevents 4
> +#define TARGET_NR_setxattr 5
> +#define TARGET_NR_lsetxattr 6
> +#define TARGET_NR_fsetxattr 7
> +#define TARGET_NR_getxattr 8
> +#define TARGET_NR_lgetxattr 9
> +#define TARGET_NR_fgetxattr 10
> +#define TARGET_NR_listxattr 11
> +#define TARGET_NR_llistxattr 12
> +#define TARGET_NR_flistxattr 13
> +#define TARGET_NR_removexattr 14
> +#define TARGET_NR_lremovexattr 15
> +#define TARGET_NR_fremovexattr 16
> +#define TARGET_NR_getcwd 17
> +#define TARGET_NR_lookup_dcookie 18
> +#define TARGET_NR_eventfd2 19
> +#define TARGET_NR_epoll_create1 20
> +#define TARGET_NR_epoll_ctl 21
> +#define TARGET_NR_epoll_pwait 22
> +#define TARGET_NR_dup 23
> +#define TARGET_NR_dup3 24
> +#define TARGET_NR_fcntl 25
> +#define TARGET_NR_inotify_init1 26
> +#define TARGET_NR_inotify_add_watch 27
> +#define TARGET_NR_inotify_rm_watch 28
> +#define TARGET_NR_ioctl 29
> +#define TARGET_NR_ioprio_set 30
> +#define TARGET_NR_ioprio_get 31
> +#define TARGET_NR_flock 32
> +#define TARGET_NR_mknodat 33
> +#define TARGET_NR_mkdirat 34
> +#define TARGET_NR_unlinkat 35
> +#define TARGET_NR_symlinkat 36
> +#define TARGET_NR_linkat 37
> +#define TARGET_NR_umount2 39
> +#define TARGET_NR_mount 40
> +#define TARGET_NR_pivot_root 41
> +#define TARGET_NR_nfsservctl 42
> +#define TARGET_NR_statfs 43
> +#define TARGET_NR_fstatfs 44
> +#define TARGET_NR_truncate 45
> +#define TARGET_NR_ftruncate 46
> +#define TARGET_NR_fallocate 47
> +#define TARGET_NR_faccessat 48
> +#define TARGET_NR_chdir 49
> +#define TARGET_NR_fchdir 50
> +#define TARGET_NR_chroot 51
> +#define TARGET_NR_fchmod 52
> +#define TARGET_NR_fchmodat 53
> +#define TARGET_NR_fchownat 54
> +#define TARGET_NR_fchown 55
> +#define TARGET_NR_openat 56
> +#define TARGET_NR_close 57
> +#define TARGET_NR_vhangup 58
> +#define TARGET_NR_pipe2 59
> +#define TARGET_NR_quotactl 60
> +#define TARGET_NR_getdents64 61
> +#define TARGET_NR_lseek 62
> +#define TARGET_NR_read 63
> +#define TARGET_NR_write 64
> +#define TARGET_NR_readv 65
> +#define TARGET_NR_writev 66
> +#define TARGET_NR_pread64 67
> +#define TARGET_NR_pwrite64 68
> +#define TARGET_NR_preadv 69
> +#define TARGET_NR_pwritev 70
> +#define TARGET_NR_sendfile 71
> +#define TARGET_NR_pselect6 72
> +#define TARGET_NR_ppoll 73
> +#define TARGET_NR_signalfd4 74
> +#define TARGET_NR_vmsplice 75
> +#define TARGET_NR_splice 76
> +#define TARGET_NR_tee 77
> +#define TARGET_NR_readlinkat 78
> +#define TARGET_NR_newfstatat 79
> +#define TARGET_NR_fstat 80
> +#define TARGET_NR_sync 81
> +#define TARGET_NR_fsync 82
> +#define TARGET_NR_fdatasync 83
> +#define TARGET_NR_sync_file_range 84
> +#define TARGET_NR_timerfd_create 85
> +#define TARGET_NR_timerfd_settime 86
> +#define TARGET_NR_timerfd_gettime 87
> +#define TARGET_NR_utimensat 88
> +#define TARGET_NR_acct 89
> +#define TARGET_NR_capget 90
> +#define TARGET_NR_capset 91
> +#define TARGET_NR_personality 92
> +#define TARGET_NR_exit 93
> +#define TARGET_NR_exit_group 94
> +#define TARGET_NR_waitid 95
> +#define TARGET_NR_set_tid_address 96
> +#define TARGET_NR_unshare 97
> +#define TARGET_NR_futex 98
> +#define TARGET_NR_set_robust_list 99
> +#define TARGET_NR_get_robust_list 100
> +#define TARGET_NR_nanosleep 101
> +#define TARGET_NR_getitimer 102
> +#define TARGET_NR_setitimer 103
> +#define TARGET_NR_kexec_load 104
> +#define TARGET_NR_init_module 105
> +#define TARGET_NR_delete_module 106
> +#define TARGET_NR_timer_create 107
> +#define TARGET_NR_timer_gettime 108
> +#define TARGET_NR_timer_getoverrun 109
> +#define TARGET_NR_timer_settime 110
> +#define TARGET_NR_timer_delete 111
> +#define TARGET_NR_clock_settime 112
> +#define TARGET_NR_clock_gettime 113
> +#define TARGET_NR_clock_getres 114
> +#define TARGET_NR_clock_nanosleep 115
> +#define TARGET_NR_syslog 116
> +#define TARGET_NR_ptrace 117
> +#define TARGET_NR_sched_setparam 118
> +#define TARGET_NR_sched_setscheduler 119
> +#define TARGET_NR_sched_getscheduler 120
> +#define TARGET_NR_sched_getparam 121
> +#define TARGET_NR_sched_setaffinity 122
> +#define TARGET_NR_sched_getaffinity 123
> +#define TARGET_NR_sched_yield 124
> +#define TARGET_NR_sched_get_priority_max 125
> +#define TARGET_NR_sched_get_priority_min 126
> +#define TARGET_NR_sched_rr_get_interval 127
> +#define TARGET_NR_restart_syscall 128
> +#define TARGET_NR_kill 129
> +#define TARGET_NR_tkill 130
> +#define TARGET_NR_tgkill 131
> +#define TARGET_NR_sigaltstack 132
> +#define TARGET_NR_rt_sigsuspend 133
> +#define TARGET_NR_rt_sigaction 134
> +#define TARGET_NR_rt_sigprocmask 135
> +#define TARGET_NR_rt_sigpending 136
> +#define TARGET_NR_rt_sigtimedwait 137
> +#define TARGET_NR_rt_sigqueueinfo 138
> +#define TARGET_NR_rt_sigreturn 139
> +#define TARGET_NR_setpriority 140
> +#define TARGET_NR_getpriority 141
> +#define TARGET_NR_reboot 142
> +#define TARGET_NR_setregid 143
> +#define TARGET_NR_setgid 144
> +#define TARGET_NR_setreuid 145
> +#define TARGET_NR_setuid 146
> +#define TARGET_NR_setresuid 147
> +#define TARGET_NR_getresuid 148
> +#define TARGET_NR_setresgid 149
> +#define TARGET_NR_getresgid 150
> +#define TARGET_NR_setfsuid 151
> +#define TARGET_NR_setfsgid 152
> +#define TARGET_NR_times 153
> +#define TARGET_NR_setpgid 154
> +#define TARGET_NR_getpgid 155
> +#define TARGET_NR_getsid 156
> +#define TARGET_NR_setsid 157
> +#define TARGET_NR_getgroups 158
> +#define TARGET_NR_setgroups 159
> +#define TARGET_NR_uname 160
> +#define TARGET_NR_sethostname 161
> +#define TARGET_NR_setdomainname 162
> +#define TARGET_NR_getrlimit 163
> +#define TARGET_NR_setrlimit 164
> +#define TARGET_NR_getrusage 165
> +#define TARGET_NR_umask 166
> +#define TARGET_NR_prctl 167
> +#define TARGET_NR_getcpu 168
> +#define TARGET_NR_gettimeofday 169
> +#define TARGET_NR_settimeofday 170
> +#define TARGET_NR_adjtimex 171
> +#define TARGET_NR_getpid 172
> +#define TARGET_NR_getppid 173
> +#define TARGET_NR_getuid 174
> +#define TARGET_NR_geteuid 175
> +#define TARGET_NR_getgid 176
> +#define TARGET_NR_getegid 177
> +#define TARGET_NR_gettid 178
> +#define TARGET_NR_sysinfo 179
> +#define TARGET_NR_mq_open 180
> +#define TARGET_NR_mq_unlink 181
> +#define TARGET_NR_mq_timedsend 182
> +#define TARGET_NR_mq_timedreceive 183
> +#define TARGET_NR_mq_notify 184
> +#define TARGET_NR_mq_getsetattr 185
> +#define TARGET_NR_msgget 186
> +#define TARGET_NR_msgctl 187
> +#define TARGET_NR_msgrcv 188
> +#define TARGET_NR_msgsnd 189
> +#define TARGET_NR_semget 190
> +#define TARGET_NR_semctl 191
> +#define TARGET_NR_semtimedop 192
> +#define TARGET_NR_semop 193
> +#define TARGET_NR_shmget 194
> +#define TARGET_NR_shmctl 195
> +#define TARGET_NR_shmat 196
> +#define TARGET_NR_shmdt 197
> +#define TARGET_NR_socket 198
> +#define TARGET_NR_socketpair 199
> +#define TARGET_NR_bind 200
> +#define TARGET_NR_listen 201
> +#define TARGET_NR_accept 202
> +#define TARGET_NR_connect 203
> +#define TARGET_NR_getsockname 204
> +#define TARGET_NR_getpeername 205
> +#define TARGET_NR_sendto 206
> +#define TARGET_NR_recvfrom 207
> +#define TARGET_NR_setsockopt 208
> +#define TARGET_NR_getsockopt 209
> +#define TARGET_NR_shutdown 210
> +#define TARGET_NR_sendmsg 211
> +#define TARGET_NR_recvmsg 212
> +#define TARGET_NR_readahead 213
> +#define TARGET_NR_brk 214
> +#define TARGET_NR_munmap 215
> +#define TARGET_NR_mremap 216
> +#define TARGET_NR_add_key 217
> +#define TARGET_NR_request_key 218
> +#define TARGET_NR_keyctl 219
> +#define TARGET_NR_clone 220
> +#define TARGET_NR_execve 221
> +#define TARGET_NR_mmap 222
> +#define TARGET_NR_fadvise64 223
> +#define TARGET_NR_swapon 224
> +#define TARGET_NR_swapoff 225
> +#define TARGET_NR_mprotect 226
> +#define TARGET_NR_msync 227
> +#define TARGET_NR_mlock 228
> +#define TARGET_NR_munlock 229
> +#define TARGET_NR_mlockall 230
> +#define TARGET_NR_munlockall 231
> +#define TARGET_NR_mincore 232
> +#define TARGET_NR_madvise 233
> +#define TARGET_NR_remap_file_pages 234
> +#define TARGET_NR_mbind 235
> +#define TARGET_NR_get_mempolicy 236
> +#define TARGET_NR_set_mempolicy 237
> +#define TARGET_NR_migrate_pages 238
> +#define TARGET_NR_move_pages 239
> +#define TARGET_NR_rt_tgsigqueueinfo 240
> +#define TARGET_NR_perf_event_open 241
> +#define TARGET_NR_accept4 242
> +#define TARGET_NR_recvmmsg 243
> +#define TARGET_NR_arch_specific_syscall 244
> +#define TARGET_NR_riscv_flush_icache (TARGET_NR_arch_specific_syscall + 15)
> +#define TARGET_NR_wait4 260
> +#define TARGET_NR_prlimit64 261
> +#define TARGET_NR_fanotify_init 262
> +#define TARGET_NR_fanotify_mark 263
> +#define TARGET_NR_name_to_handle_at 264
> +#define TARGET_NR_open_by_handle_at 265
> +#define TARGET_NR_clock_adjtime 266
> +#define TARGET_NR_syncfs 267
> +#define TARGET_NR_setns 268
> +#define TARGET_NR_sendmmsg 269
> +#define TARGET_NR_process_vm_readv 270
> +#define TARGET_NR_process_vm_writev 271
> +#define TARGET_NR_kcmp 272
> +#define TARGET_NR_finit_module 273
> +#define TARGET_NR_sched_setattr 274
> +#define TARGET_NR_sched_getattr 275
> +#define TARGET_NR_renameat2 276
> +#define TARGET_NR_seccomp 277
> +#define TARGET_NR_getrandom 278
> +#define TARGET_NR_memfd_create 279
> +#define TARGET_NR_bpf 280
> +#define TARGET_NR_execveat 281
> +#define TARGET_NR_userfaultfd 282
> +#define TARGET_NR_membarrier 283
> +#define TARGET_NR_mlock2 284
> +#define TARGET_NR_copy_file_range 285
> +#define TARGET_NR_preadv2 286
> +#define TARGET_NR_pwritev2 287
> +#define TARGET_NR_pkey_mprotect 288
> +#define TARGET_NR_pkey_alloc 289
> +#define TARGET_NR_pkey_free 290
> +#define TARGET_NR_statx 291
> +#define TARGET_NR_io_pgetevents 292
> +#define TARGET_NR_rseq 293
> +#define TARGET_NR_kexec_file_load 294
> +#define TARGET_NR_pidfd_send_signal 424
> +#define TARGET_NR_io_uring_setup 425
> +#define TARGET_NR_io_uring_enter 426
> +#define TARGET_NR_io_uring_register 427
> +#define TARGET_NR_open_tree 428
> +#define TARGET_NR_move_mount 429
> +#define TARGET_NR_fsopen 430
> +#define TARGET_NR_fsconfig 431
> +#define TARGET_NR_fsmount 432
> +#define TARGET_NR_fspick 433
> +#define TARGET_NR_pidfd_open 434
> +#define TARGET_NR_clone3 435
> +#define TARGET_NR_syscalls 436
> +
> +#endif /* LINUX_USER_RISCV_SYSCALL64_NR_H */
> diff --git a/linux-user/riscv/syscall_nr.h b/linux-user/riscv/syscall_nr.h
> index 5c87282209..0a5a2f2fb1 100644
> --- a/linux-user/riscv/syscall_nr.h
> +++ b/linux-user/riscv/syscall_nr.h
> @@ -6,300 +6,10 @@
>  #ifndef LINUX_USER_RISCV_SYSCALL_NR_H
>  #define LINUX_USER_RISCV_SYSCALL_NR_H
>  
> -#define TARGET_NR_io_setup 0
> -#define TARGET_NR_io_destroy 1
> -#define TARGET_NR_io_submit 2
> -#define TARGET_NR_io_cancel 3
> -#define TARGET_NR_io_getevents 4
> -#define TARGET_NR_setxattr 5
> -#define TARGET_NR_lsetxattr 6
> -#define TARGET_NR_fsetxattr 7
> -#define TARGET_NR_getxattr 8
> -#define TARGET_NR_lgetxattr 9
> -#define TARGET_NR_fgetxattr 10
> -#define TARGET_NR_listxattr 11
> -#define TARGET_NR_llistxattr 12
> -#define TARGET_NR_flistxattr 13
> -#define TARGET_NR_removexattr 14
> -#define TARGET_NR_lremovexattr 15
> -#define TARGET_NR_fremovexattr 16
> -#define TARGET_NR_getcwd 17
> -#define TARGET_NR_lookup_dcookie 18
> -#define TARGET_NR_eventfd2 19
> -#define TARGET_NR_epoll_create1 20
> -#define TARGET_NR_epoll_ctl 21
> -#define TARGET_NR_epoll_pwait 22
> -#define TARGET_NR_dup 23
> -#define TARGET_NR_dup3 24
>  #ifdef TARGET_RISCV32
> -#define TARGET_NR_fcntl64 25
> +# include "syscall32_nr.h"
>  #else
> -#define TARGET_NR_fcntl 25
> +# include "syscall64_nr.h"
>  #endif
> -#define TARGET_NR_inotify_init1 26
> -#define TARGET_NR_inotify_add_watch 27
> -#define TARGET_NR_inotify_rm_watch 28
> -#define TARGET_NR_ioctl 29
> -#define TARGET_NR_ioprio_set 30
> -#define TARGET_NR_ioprio_get 31
> -#define TARGET_NR_flock 32
> -#define TARGET_NR_mknodat 33
> -#define TARGET_NR_mkdirat 34
> -#define TARGET_NR_unlinkat 35
> -#define TARGET_NR_symlinkat 36
> -#define TARGET_NR_linkat 37
> -#define TARGET_NR_renameat 38
> -#define TARGET_NR_umount2 39
> -#define TARGET_NR_mount 40
> -#define TARGET_NR_pivot_root 41
> -#define TARGET_NR_nfsservctl 42
> -#define TARGET_NR_statfs 43
> -#define TARGET_NR_fstatfs 44
> -#define TARGET_NR_truncate 45
> -#define TARGET_NR_ftruncate 46
> -#define TARGET_NR_fallocate 47
> -#define TARGET_NR_faccessat 48
> -#define TARGET_NR_chdir 49
> -#define TARGET_NR_fchdir 50
> -#define TARGET_NR_chroot 51
> -#define TARGET_NR_fchmod 52
> -#define TARGET_NR_fchmodat 53
> -#define TARGET_NR_fchownat 54
> -#define TARGET_NR_fchown 55
> -#define TARGET_NR_openat 56
> -#define TARGET_NR_close 57
> -#define TARGET_NR_vhangup 58
> -#define TARGET_NR_pipe2 59
> -#define TARGET_NR_quotactl 60
> -#define TARGET_NR_getdents64 61
> -#ifdef TARGET_RISCV32
> -#define TARGET_NR__llseek 62
> -#else
> -#define TARGET_NR_lseek 62
> -#endif
> -#define TARGET_NR_read 63
> -#define TARGET_NR_write 64
> -#define TARGET_NR_readv 65
> -#define TARGET_NR_writev 66
> -#define TARGET_NR_pread64 67
> -#define TARGET_NR_pwrite64 68
> -#define TARGET_NR_preadv 69
> -#define TARGET_NR_pwritev 70
> -#define TARGET_NR_sendfile 71
> -#define TARGET_NR_pselect6 72
> -#define TARGET_NR_ppoll 73
> -#define TARGET_NR_signalfd4 74
> -#define TARGET_NR_vmsplice 75
> -#define TARGET_NR_splice 76
> -#define TARGET_NR_tee 77
> -#define TARGET_NR_readlinkat 78
> -#define TARGET_NR_newfstatat 79
> -#define TARGET_NR_fstat 80
> -#define TARGET_NR_sync 81
> -#define TARGET_NR_fsync 82
> -#define TARGET_NR_fdatasync 83
> -#define TARGET_NR_sync_file_range 84
> -#define TARGET_NR_timerfd_create 85
> -#define TARGET_NR_timerfd_settime 86
> -#define TARGET_NR_timerfd_gettime 87
> -#define TARGET_NR_utimensat 88
> -#define TARGET_NR_acct 89
> -#define TARGET_NR_capget 90
> -#define TARGET_NR_capset 91
> -#define TARGET_NR_personality 92
> -#define TARGET_NR_exit 93
> -#define TARGET_NR_exit_group 94
> -#define TARGET_NR_waitid 95
> -#define TARGET_NR_set_tid_address 96
> -#define TARGET_NR_unshare 97
> -#define TARGET_NR_futex 98
> -#define TARGET_NR_set_robust_list 99
> -#define TARGET_NR_get_robust_list 100
> -#define TARGET_NR_nanosleep 101
> -#define TARGET_NR_getitimer 102
> -#define TARGET_NR_setitimer 103
> -#define TARGET_NR_kexec_load 104
> -#define TARGET_NR_init_module 105
> -#define TARGET_NR_delete_module 106
> -#define TARGET_NR_timer_create 107
> -#define TARGET_NR_timer_gettime 108
> -#define TARGET_NR_timer_getoverrun 109
> -#define TARGET_NR_timer_settime 110
> -#define TARGET_NR_timer_delete 111
> -#define TARGET_NR_clock_settime 112
> -#define TARGET_NR_clock_gettime 113
> -#define TARGET_NR_clock_getres 114
> -#define TARGET_NR_clock_nanosleep 115
> -#define TARGET_NR_syslog 116
> -#define TARGET_NR_ptrace 117
> -#define TARGET_NR_sched_setparam 118
> -#define TARGET_NR_sched_setscheduler 119
> -#define TARGET_NR_sched_getscheduler 120
> -#define TARGET_NR_sched_getparam 121
> -#define TARGET_NR_sched_setaffinity 122
> -#define TARGET_NR_sched_getaffinity 123
> -#define TARGET_NR_sched_yield 124
> -#define TARGET_NR_sched_get_priority_max 125
> -#define TARGET_NR_sched_get_priority_min 126
> -#define TARGET_NR_sched_rr_get_interval 127
> -#define TARGET_NR_restart_syscall 128
> -#define TARGET_NR_kill 129
> -#define TARGET_NR_tkill 130
> -#define TARGET_NR_tgkill 131
> -#define TARGET_NR_sigaltstack 132
> -#define TARGET_NR_rt_sigsuspend 133
> -#define TARGET_NR_rt_sigaction 134
> -#define TARGET_NR_rt_sigprocmask 135
> -#define TARGET_NR_rt_sigpending 136
> -#define TARGET_NR_rt_sigtimedwait 137
> -#define TARGET_NR_rt_sigqueueinfo 138
> -#define TARGET_NR_rt_sigreturn 139
> -#define TARGET_NR_setpriority 140
> -#define TARGET_NR_getpriority 141
> -#define TARGET_NR_reboot 142
> -#define TARGET_NR_setregid 143
> -#define TARGET_NR_setgid 144
> -#define TARGET_NR_setreuid 145
> -#define TARGET_NR_setuid 146
> -#define TARGET_NR_setresuid 147
> -#define TARGET_NR_getresuid 148
> -#define TARGET_NR_setresgid 149
> -#define TARGET_NR_getresgid 150
> -#define TARGET_NR_setfsuid 151
> -#define TARGET_NR_setfsgid 152
> -#define TARGET_NR_times 153
> -#define TARGET_NR_setpgid 154
> -#define TARGET_NR_getpgid 155
> -#define TARGET_NR_getsid 156
> -#define TARGET_NR_setsid 157
> -#define TARGET_NR_getgroups 158
> -#define TARGET_NR_setgroups 159
> -#define TARGET_NR_uname 160
> -#define TARGET_NR_sethostname 161
> -#define TARGET_NR_setdomainname 162
> -#define TARGET_NR_getrlimit 163
> -#define TARGET_NR_setrlimit 164
> -#define TARGET_NR_getrusage 165
> -#define TARGET_NR_umask 166
> -#define TARGET_NR_prctl 167
> -#define TARGET_NR_getcpu 168
> -#define TARGET_NR_gettimeofday 169
> -#define TARGET_NR_settimeofday 170
> -#define TARGET_NR_adjtimex 171
> -#define TARGET_NR_getpid 172
> -#define TARGET_NR_getppid 173
> -#define TARGET_NR_getuid 174
> -#define TARGET_NR_geteuid 175
> -#define TARGET_NR_getgid 176
> -#define TARGET_NR_getegid 177
> -#define TARGET_NR_gettid 178
> -#define TARGET_NR_sysinfo 179
> -#define TARGET_NR_mq_open 180
> -#define TARGET_NR_mq_unlink 181
> -#define TARGET_NR_mq_timedsend 182
> -#define TARGET_NR_mq_timedreceive 183
> -#define TARGET_NR_mq_notify 184
> -#define TARGET_NR_mq_getsetattr 185
> -#define TARGET_NR_msgget 186
> -#define TARGET_NR_msgctl 187
> -#define TARGET_NR_msgrcv 188
> -#define TARGET_NR_msgsnd 189
> -#define TARGET_NR_semget 190
> -#define TARGET_NR_semctl 191
> -#define TARGET_NR_semtimedop 192
> -#define TARGET_NR_semop 193
> -#define TARGET_NR_shmget 194
> -#define TARGET_NR_shmctl 195
> -#define TARGET_NR_shmat 196
> -#define TARGET_NR_shmdt 197
> -#define TARGET_NR_socket 198
> -#define TARGET_NR_socketpair 199
> -#define TARGET_NR_bind 200
> -#define TARGET_NR_listen 201
> -#define TARGET_NR_accept 202
> -#define TARGET_NR_connect 203
> -#define TARGET_NR_getsockname 204
> -#define TARGET_NR_getpeername 205
> -#define TARGET_NR_sendto 206
> -#define TARGET_NR_recvfrom 207
> -#define TARGET_NR_setsockopt 208
> -#define TARGET_NR_getsockopt 209
> -#define TARGET_NR_shutdown 210
> -#define TARGET_NR_sendmsg 211
> -#define TARGET_NR_recvmsg 212
> -#define TARGET_NR_readahead 213
> -#define TARGET_NR_brk 214
> -#define TARGET_NR_munmap 215
> -#define TARGET_NR_mremap 216
> -#define TARGET_NR_add_key 217
> -#define TARGET_NR_request_key 218
> -#define TARGET_NR_keyctl 219
> -#define TARGET_NR_clone 220
> -#define TARGET_NR_execve 221
> -#ifdef TARGET_RISCV32
> -#define TARGET_NR_mmap2 222
> -#define TARGET_NR_fadvise64_64 223
> -#else
> -#define TARGET_NR_mmap 222
> -#define TARGET_NR_fadvise64 223
> -#endif
> -#define TARGET_NR_swapon 224
> -#define TARGET_NR_swapoff 225
> -#define TARGET_NR_mprotect 226
> -#define TARGET_NR_msync 227
> -#define TARGET_NR_mlock 228
> -#define TARGET_NR_munlock 229
> -#define TARGET_NR_mlockall 230
> -#define TARGET_NR_munlockall 231
> -#define TARGET_NR_mincore 232
> -#define TARGET_NR_madvise 233
> -#define TARGET_NR_remap_file_pages 234
> -#define TARGET_NR_mbind 235
> -#define TARGET_NR_get_mempolicy 236
> -#define TARGET_NR_set_mempolicy 237
> -#define TARGET_NR_migrate_pages 238
> -#define TARGET_NR_move_pages 239
> -#define TARGET_NR_rt_tgsigqueueinfo 240
> -#define TARGET_NR_perf_event_open 241
> -#define TARGET_NR_accept4 242
> -#define TARGET_NR_recvmmsg 243
> -#define TARGET_NR_arch_specific_syscall 244
> -#define TARGET_NR_wait4 260
> -#define TARGET_NR_prlimit64 261
> -#define TARGET_NR_fanotify_init 262
> -#define TARGET_NR_fanotify_mark 263
> -#define TARGET_NR_name_to_handle_at 264
> -#define TARGET_NR_open_by_handle_at 265
> -#define TARGET_NR_clock_adjtime 266
> -#define TARGET_NR_syncfs 267
> -#define TARGET_NR_setns 268
> -#define TARGET_NR_sendmmsg 269
> -#define TARGET_NR_process_vm_readv 270
> -#define TARGET_NR_process_vm_writev 271
> -#define TARGET_NR_kcmp 272
> -#define TARGET_NR_finit_module 273
> -#define TARGET_NR_sched_setattr 274
> -#define TARGET_NR_sched_getattr 275
> -#define TARGET_NR_renameat2 276
> -#define TARGET_NR_seccomp 277
> -#define TARGET_NR_getrandom 278
> -#define TARGET_NR_memfd_create 279
> -#define TARGET_NR_bpf 280
> -#define TARGET_NR_execveat 281
> -#define TARGET_NR_userfaultfd 282
> -#define TARGET_NR_membarrier 283
> -#define TARGET_NR_mlock2 284
> -#define TARGET_NR_copy_file_range 285
> -#define TARGET_NR_preadv2 286
> -#define TARGET_NR_pwritev2 287
> -#define TARGET_NR_pkey_mprotect 288
> -#define TARGET_NR_pkey_alloc 289
> -#define TARGET_NR_pkey_free 290
> -#define TARGET_NR_statx 291
> -#define TARGET_NR_io_pgetevents 292
> -#define TARGET_NR_rseq 293
> -#define TARGET_NR_kexec_file_load 294
> -
> -#define TARGET_NR_syscalls (TARGET_NR_kexec_file_load + 1)
>  
>  #endif
> 

Applied to my linux-user branch.

Thanks,
Laurent

