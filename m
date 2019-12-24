Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502E3C2D0C0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 02:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244772070E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 02:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244772070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ija9Q-0002Uf-Qs
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 21:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ija8F-00018Q-KB
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 21:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ija8D-0001zF-Tk
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 21:41:11 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:39658 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1ija8D-0000LF-J9
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 21:41:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 424C01A0F22;
 Tue, 24 Dec 2019 03:40:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 022201A0EF2;
 Tue, 24 Dec 2019 03:40:06 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] linux-user: mips: Update syscall numbers to kernel 5.5
 rc3 level
Date: Tue, 24 Dec 2019 03:39:44 +0100
Message-Id: <1577155187-12622-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577155187-12622-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1577155187-12622-1-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: laurent@vivier.eu, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update mips syscall numbers based on Linux kernel tag v5.5-rc3
(commit 46cf053e).

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/mips/cpu_loop.c     | 41 ++++++++++++++++++++++++++++++++++++++
 linux-user/mips/syscall_nr.h   | 45 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/mips64/syscall_nr.h | 13 ++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 39915b3..f8f944f 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -390,6 +390,47 @@ static const uint8_t mips_syscall_args[] = {
         MIPS_SYS(sys_copy_file_range, 6) /* 360 */
         MIPS_SYS(sys_preadv2, 6)
         MIPS_SYS(sys_pwritev2, 6)
+        MIPS_SYS(sys_pkey_mprotect, 4)
+        MIPS_SYS(sys_pkey_alloc, 2)
+        MIPS_SYS(sys_pkey_free, 1)      /* 365 */
+        MIPS_SYS(sys_statx, 5)
+        MIPS_SYS(sys_rseq, 4)
+        MIPS_SYS(sys_io_pgetevents, 6)
+
+        MIPS_SYS(clock_gettime64, 2)
+        MIPS_SYS(clock_settime64, 2)
+        MIPS_SYS(clock_adjtime64, 2)
+        MIPS_SYS(clock_getres_time64, 2)
+        MIPS_SYS(clock_nanosleep_time64, 4)
+        MIPS_SYS(timer_gettime64, 2)
+        MIPS_SYS(timer_settime64, 4)
+        MIPS_SYS(timerfd_gettime64, 2)
+        MIPS_SYS(timerfd_settime64, 4)
+        MIPS_SYS(utimensat_time64, 4)
+        MIPS_SYS(pselect6_time64, 6)
+        MIPS_SYS(ppoll_time64, 5)
+        MIPS_SYS(io_pgetevents_time64, 6)
+        MIPS_SYS(recvmmsg_time64, 5)
+        MIPS_SYS(mq_timedsend_time64, 5)
+        MIPS_SYS(mq_timedreceive_time64, 5)
+        MIPS_SYS(semtimedop_time64, 4)
+        MIPS_SYS(rt_sigtimedwait_time64, 4)
+        MIPS_SYS(futex_time64, 6)
+        MIPS_SYS(sched_rr_get_interval_time64, 2)
+
+        MIPS_SYS(pidfd_send_signal, 4)
+        MIPS_SYS(io_uring_setup, 2)
+        MIPS_SYS(io_uring_enter, 6)
+        MIPS_SYS(io_uring_register, 4)
+        MIPS_SYS(open_tree, 3)
+        MIPS_SYS(move_mount, 5)
+        MIPS_SYS(fsopen, 2)
+        MIPS_SYS(fsconfig, 5)
+        MIPS_SYS(fsmount, 3)
+        MIPS_SYS(fspick, 3)
+        MIPS_SYS(pidfd_open, 2)
+        MIPS_SYS(clone3, 2)
+
 };
 #  undef MIPS_SYS
 # endif /* O32 */
diff --git a/linux-user/mips/syscall_nr.h b/linux-user/mips/syscall_nr.h
index 7fa7fa5..94104d0 100644
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
+/* 424 onwards common for all archs */
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
diff --git a/linux-user/mips64/syscall_nr.h b/linux-user/mips64/syscall_nr.h
index db40f69..c86943a 100644
--- a/linux-user/mips64/syscall_nr.h
+++ b/linux-user/mips64/syscall_nr.h
@@ -674,6 +674,19 @@
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
-- 
2.7.4


