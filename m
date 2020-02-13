Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11D0C3B18B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88ECA20578
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88ECA20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Dfv-0001GG-Os
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j2Dca-0004Tm-Nu
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j2DcY-0005wy-P7
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:29:32 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51357 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1j2DcY-0005vk-Dq
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:29:30 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id A69881A1FCA;
 Thu, 13 Feb 2020 13:29:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 59D3F1A20E6;
 Thu, 13 Feb 2020 13:29:27 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/9] linux-user: mips: Update syscall numbers to kernel 5.5
 level
Date: Thu, 13 Feb 2020 13:29:10 +0100
Message-Id: <1581596954-2305-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581596954-2305-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581596954-2305-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, laurent@vivier.eu,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update mips syscall numbers based on Linux kernel tag v5.5.

CC: Aurelien Jarno <aurelien@aurel32.net>
CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/syscall_nr.h   | 45 +++++++++++++++++++++++
 linux-user/mips64/syscall_nr.h | 50 ++++++++++++++++++++++++-
 linux-user/mips/cpu_loop.c     | 83 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 175 insertions(+), 3 deletions(-)

diff --git a/linux-user/mips/syscall_nr.h b/linux-user/mips/syscall_nr.h
index 7fa7fa5..0be3af1 100644
--- a/linux-user/mips/syscall_nr.h
+++ b/linux-user/mips/syscall_nr.h
@@ -376,5 +376,50 @@
 #define TARGET_NR_statx                 (TARGET_NR_Linux + 366)
 #define TARGET_NR_rseq                  (TARGET_NR_Linux + 367)
 #define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 368)
+/* room for arch specific calls */
+#define TARGET_NR_semget                (TARGET_NR_Linux + 393)
+#define TARGET_NR_semctl                (TARGET_NR_Linux + 394)
+#define TARGET_NR_shmget                (TARGET_NR_Linux + 395)
+#define TARGET_NR_shmctl                (TARGET_NR_Linux + 396)
+#define TARGET_NR_shmat                 (TARGET_NR_Linux + 397)
+#define TARGET_NR_shmdt                 (TARGET_NR_Linux + 398)
+#define TARGET_NR_msgget                (TARGET_NR_Linux + 399)
+#define TARGET_NR_msgsnd                (TARGET_NR_Linux + 400)
+#define TARGET_NR_msgrcv                (TARGET_NR_Linux + 401)
+#define TARGET_NR_msgctl                (TARGET_NR_Linux + 402)
+/* 403-423 common for 32-bit archs */
+#define TARGET_NR_clock_gettime64              (TARGET_NR_Linux + 403)
+#define TARGET_NR_clock_settime64              (TARGET_NR_Linux + 404)
+#define TARGET_NR_clock_adjtime64              (TARGET_NR_Linux + 405)
+#define TARGET_NR_clock_getres_time64          (TARGET_NR_Linux + 406)
+#define TARGET_NR_clock_nanosleep_time64       (TARGET_NR_Linux + 407)
+#define TARGET_NR_timer_gettime64              (TARGET_NR_Linux + 408)
+#define TARGET_NR_timer_settime64              (TARGET_NR_Linux + 409)
+#define TARGET_NR_timerfd_gettime64            (TARGET_NR_Linux + 410)
+#define TARGET_NR_timerfd_settime64            (TARGET_NR_Linux + 411)
+#define TARGET_NR_utimensat_time64             (TARGET_NR_Linux + 412)
+#define TARGET_NR_pselect6_time64              (TARGET_NR_Linux + 413)
+#define TARGET_NR_ppoll_time64                 (TARGET_NR_Linux + 414)
+#define TARGET_NR_io_pgetevents_time64         (TARGET_NR_Linux + 416)
+#define TARGET_NR_recvmmsg_time64              (TARGET_NR_Linux + 417)
+#define TARGET_NR_mq_timedsend_time64          (TARGET_NR_Linux + 418)
+#define TARGET_NR_mq_timedreceive_time64       (TARGET_NR_Linux + 419)
+#define TARGET_NR_semtimedop_time64            (TARGET_NR_Linux + 420)
+#define TARGET_NR_rt_sigtimedwait_time64       (TARGET_NR_Linux + 421)
+#define TARGET_NR_futex_time64                 (TARGET_NR_Linux + 422)
+#define TARGET_NR_sched_rr_get_interval_time64 (TARGET_NR_Linux + 423)
+/* 424 onwards common for all archs */
+#define TARGET_NR_pidfd_send_signal            (TARGET_NR_Linux + 424)
+#define TARGET_NR_io_uring_setup               (TARGET_NR_Linux + 425)
+#define TARGET_NR_io_uring_enter               (TARGET_NR_Linux + 426)
+#define TARGET_NR_io_uring_register            (TARGET_NR_Linux + 427)
+#define TARGET_NR_open_tree                    (TARGET_NR_Linux + 428)
+#define TARGET_NR_move_mount                   (TARGET_NR_Linux + 429)
+#define TARGET_NR_fsopen                       (TARGET_NR_Linux + 430)
+#define TARGET_NR_fsconfig                     (TARGET_NR_Linux + 431)
+#define TARGET_NR_fsmount                      (TARGET_NR_Linux + 432)
+#define TARGET_NR_fspick                       (TARGET_NR_Linux + 433)
+#define TARGET_NR_pidfd_open                   (TARGET_NR_Linux + 434)
+#define TARGET_NR_clone3                       (TARGET_NR_Linux + 435)
 
 #endif
diff --git a/linux-user/mips64/syscall_nr.h b/linux-user/mips64/syscall_nr.h
index db40f69..6e23e9f 100644
--- a/linux-user/mips64/syscall_nr.h
+++ b/linux-user/mips64/syscall_nr.h
@@ -339,6 +339,39 @@
 #define TARGET_NR_statx                 (TARGET_NR_Linux + 330)
 #define TARGET_NR_rseq                  (TARGET_NR_Linux + 331)
 #define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 332)
+/* 333 through 402 are unassigned to sync up with generic numbers */
+#define TARGET_NR_clock_gettime64       (TARGET_NR_Linux + 403)
+#define TARGET_NR_clock_settime64       (TARGET_NR_Linux + 404)
+#define TARGET_NR_clock_adjtime64       (TARGET_NR_Linux + 405)
+#define TARGET_NR_clock_getres_time64   (TARGET_NR_Linux + 406)
+#define TARGET_NR_clock_nanosleep_time64 (TARGET_NR_Linux + 407)
+#define TARGET_NR_timer_gettime64       (TARGET_NR_Linux + 408)
+#define TARGET_NR_timer_settime64       (TARGET_NR_Linux + 409)
+#define TARGET_NR_timerfd_gettime64     (TARGET_NR_Linux + 410)
+#define TARGET_NR_timerfd_settime64     (TARGET_NR_Linux + 411)
+#define TARGET_NR_utimensat_time64      (TARGET_NR_Linux + 412)
+#define TARGET_NR_pselect6_time64       (TARGET_NR_Linux + 413)
+#define TARGET_NR_ppoll_time64          (TARGET_NR_Linux + 414)
+#define TARGET_NR_io_pgetevents_time64  (TARGET_NR_Linux + 416)
+#define TARGET_NR_recvmmsg_time64       (TARGET_NR_Linux + 417)
+#define TARGET_NR_mq_timedsend_time64   (TARGET_NR_Linux + 418)
+#define TARGET_NR_mq_timedreceive_time64 (TARGET_NR_Linux + 419)
+#define TARGET_NR_semtimedop_time64     (TARGET_NR_Linux + 420)
+#define TARGET_NR_rt_sigtimedwait_time64 (TARGET_NR_Linux + 421)
+#define TARGET_NR_futex_time64          (TARGET_NR_Linux + 422)
+#define TARGET_NR_sched_rr_get_interval_time64 (TARGET_NR_Linux + 423)
+#define TARGET_NR_pidfd_send_signal     (TARGET_NR_Linux + 424)
+#define TARGET_NR_io_uring_setup        (TARGET_NR_Linux + 425)
+#define TARGET_NR_io_uring_enter        (TARGET_NR_Linux + 426)
+#define TARGET_NR_io_uring_register     (TARGET_NR_Linux + 427)
+#define TARGET_NR_open_tree             (TARGET_NR_Linux + 428)
+#define TARGET_NR_move_mount            (TARGET_NR_Linux + 429)
+#define TARGET_NR_fsopen                (TARGET_NR_Linux + 430)
+#define TARGET_NR_fsconfig              (TARGET_NR_Linux + 431)
+#define TARGET_NR_fsmount               (TARGET_NR_Linux + 432)
+#define TARGET_NR_fspick                (TARGET_NR_Linux + 433)
+#define TARGET_NR_pidfd_open            (TARGET_NR_Linux + 434)
+#define TARGET_NR_clone3                (TARGET_NR_Linux + 435)
 
 #else
 /*
@@ -488,8 +521,8 @@
 #define TARGET_NR_sched_getparam        (TARGET_NR_Linux + 140)
 #define TARGET_NR_sched_setscheduler    (TARGET_NR_Linux + 141)
 #define TARGET_NR_sched_getscheduler    (TARGET_NR_Linux + 142)
-#define TARGET_NR_sched_get_priority_max        (TARGET_NR_Linux + 143)
-#define TARGET_NR_sched_get_priority_min        (TARGET_NR_Linux + 144)
+#define TARGET_NR_sched_get_priority_max (TARGET_NR_Linux + 143)
+#define TARGET_NR_sched_get_priority_min (TARGET_NR_Linux + 144)
 #define TARGET_NR_sched_rr_get_interval (TARGET_NR_Linux + 145)
 #define TARGET_NR_mlock                 (TARGET_NR_Linux + 146)
 #define TARGET_NR_munlock               (TARGET_NR_Linux + 147)
@@ -674,6 +707,19 @@
 #define TARGET_NR_statx                 (TARGET_NR_Linux + 326)
 #define TARGET_NR_rseq                  (TARGET_NR_Linux + 327)
 #define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 328)
+/* 329 through 423 are reserved to sync up with other architectures */
+#define TARGET_NR_pidfd_send_signal     (TARGET_NR_Linux + 424)
+#define TARGET_NR_io_uring_setup        (TARGET_NR_Linux + 425)
+#define TARGET_NR_io_uring_enter        (TARGET_NR_Linux + 426)
+#define TARGET_NR_io_uring_register     (TARGET_NR_Linux + 427)
+#define TARGET_NR_open_tree             (TARGET_NR_Linux + 428)
+#define TARGET_NR_move_mount            (TARGET_NR_Linux + 429)
+#define TARGET_NR_fsopen                (TARGET_NR_Linux + 430)
+#define TARGET_NR_fsconfig              (TARGET_NR_Linux + 431)
+#define TARGET_NR_fsmount               (TARGET_NR_Linux + 432)
+#define TARGET_NR_fspick                (TARGET_NR_Linux + 433)
+#define TARGET_NR_pidfd_open            (TARGET_NR_Linux + 434)
+#define TARGET_NR_clone3                (TARGET_NR_Linux + 435)
 #endif
 
 #endif
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 39915b3..396367d 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -25,8 +25,9 @@
 #include "internal.h"
 
 # ifdef TARGET_ABI_MIPSO32
+#  define MIPS_SYSCALL_NUMBER_UNUSED -1
 #  define MIPS_SYS(name, args) args,
-static const uint8_t mips_syscall_args[] = {
+static const int8_t mips_syscall_args[] = {
         MIPS_SYS(sys_syscall    , 8)    /* 4000 */
         MIPS_SYS(sys_exit       , 1)
         MIPS_SYS(sys_fork       , 0)
@@ -390,6 +391,80 @@ static const uint8_t mips_syscall_args[] = {
         MIPS_SYS(sys_copy_file_range, 6) /* 360 */
         MIPS_SYS(sys_preadv2, 6)
         MIPS_SYS(sys_pwritev2, 6)
+        MIPS_SYS(sys_pkey_mprotect, 4)
+        MIPS_SYS(sys_pkey_alloc, 2)
+        MIPS_SYS(sys_pkey_free, 1)                 /* 365 */
+        MIPS_SYS(sys_statx, 5)
+        MIPS_SYS(sys_rseq, 4)
+        MIPS_SYS(sys_io_pgetevents, 6)
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,                /* 370 */
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,                /* 375 */
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,                /* 380 */
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,                /* 385 */
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,                /* 390 */
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYSCALL_NUMBER_UNUSED,
+        MIPS_SYS(sys_semget, 3)
+        MIPS_SYS(sys_semctl, 4)
+        MIPS_SYS(sys_shmget, 3)                    /* 395 */
+        MIPS_SYS(sys_shmctl, 3)
+        MIPS_SYS(sys_shmat, 3)
+        MIPS_SYS(sys_shmdt, 1)
+        MIPS_SYS(sys_msgget, 2)
+        MIPS_SYS(sys_msgsnd, 4)                    /* 400 */
+        MIPS_SYS(sys_msgrcv, 5)
+        MIPS_SYS(sys_msgctl, 3)
+        MIPS_SYS(sys_clock_gettime64, 2)
+        MIPS_SYS(sys_clock_settime64, 2)
+        MIPS_SYS(sys_clock_adjtime64, 2)           /* 405 */
+        MIPS_SYS(sys_clock_getres_time64, 2)
+        MIPS_SYS(sys_clock_nanosleep_time64, 4)
+        MIPS_SYS(sys_timer_gettime64, 2)
+        MIPS_SYS(sys_timer_settime64, 4)
+        MIPS_SYS(sys_timerfd_gettime64, 2)         /* 410 */
+        MIPS_SYS(sys_timerfd_settime64, 4)
+        MIPS_SYS(sys_utimensat_time64, 4)
+        MIPS_SYS(sys_pselect6_time64, 6)
+        MIPS_SYS(sys_ppoll_time64, 5)
+        MIPS_SYSCALL_NUMBER_UNUSED,                /* 415 */
+        MIPS_SYS(sys_io_pgetevents_time64, 6)
+        MIPS_SYS(sys_recvmmsg_time64, 5)
+        MIPS_SYS(sys_mq_timedsend_time64, 5)
+        MIPS_SYS(sys_mq_timedreceive_time64, 5)
+        MIPS_SYS(sys_semtimedop_time64, 4)         /* 420 */
+        MIPS_SYS(sys_rt_sigtimedwait_time64, 4)
+        MIPS_SYS(sys_futex_time64, 6)
+        MIPS_SYS(sys_sched_rr_get_interval_time64, 2)
+        MIPS_SYS(sys_pidfd_send_signal, 4)
+        MIPS_SYS(sys_io_uring_setup, 2)            /* 425 */
+        MIPS_SYS(sys_io_uring_enter, 6)
+        MIPS_SYS(sys_io_uring_register, 4)
+        MIPS_SYS(sys_open_tree, 3)
+        MIPS_SYS(sys_move_mount, 5)
+        MIPS_SYS(sys_fsopen, 2)                    /* 430 */
+        MIPS_SYS(sys_fsconfig, 5)
+        MIPS_SYS(sys_fsmount, 3)
+        MIPS_SYS(sys_fspick, 3)
+        MIPS_SYS(sys_pidfd_open, 2)
+        MIPS_SYS(sys_clone3, 2)                    /* 435 */
+
 };
 #  undef MIPS_SYS
 # endif /* O32 */
@@ -447,8 +522,14 @@ void cpu_loop(CPUMIPSState *env)
 # ifdef TARGET_ABI_MIPSO32
             syscall_num = env->active_tc.gpr[2] - 4000;
             if (syscall_num >= sizeof(mips_syscall_args)) {
+                /* syscall_num is larger that any defined for MIPS O32 */
+                ret = -TARGET_ENOSYS;
+            } else if (mips_syscall_args[syscall_num] ==
+                       MIPS_SYSCALL_NUMBER_UNUSED) {
+                /* syscall_num belongs to the range not defined for MIPS O32 */
                 ret = -TARGET_ENOSYS;
             } else {
+                /* syscall_num is valid */
                 int nb_args;
                 abi_ulong sp_reg;
                 abi_ulong arg5 = 0, arg6 = 0, arg7 = 0, arg8 = 0;
-- 
2.7.4


