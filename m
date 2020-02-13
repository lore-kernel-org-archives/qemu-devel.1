Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26DFC3B186
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD6520873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD6520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j23dr-0002un-RA
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 20:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j23bc-0005xx-Li
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:47:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j23bb-0004U6-Dr
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:47:52 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:38877 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1j23bb-0002zN-7C
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:47:51 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id B19BD1A2160;
 Thu, 13 Feb 2020 02:46:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 7C9CE1A213A;
 Thu, 13 Feb 2020 02:46:47 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/9] linux-user: m68k: Update syscall numbers to kernel 5.5
 level
Date: Thu, 13 Feb 2020 02:46:27 +0100
Message-Id: <1581558393-9182-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581558393-9182-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581558393-9182-1-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: laurent@vivier.eu, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update m68k syscall numbers based on Linux kernel v5.5.

CC: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/m68k/syscall_nr.h | 50 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/linux-user/m68k/syscall_nr.h b/linux-user/m68k/syscall_nr.h
index d33d8e9..01aee34 100644
--- a/linux-user/m68k/syscall_nr.h
+++ b/linux-user/m68k/syscall_nr.h
@@ -382,5 +382,53 @@
 #define TARGET_NR_copy_file_range       376
 #define TARGET_NR_preadv2               377
 #define TARGET_NR_pwritev2              378
-
+#define TARGET_NR_statx                 379
+#define TARGET_NR_seccomp               380
+#define TARGET_NR_pkey_mprotect         381
+#define TARGET_NR_pkey_alloc            382
+#define TARGET_NR_pkey_free             383
+#define TARGET_NR_rseq                  384
+/* room for arch specific calls */
+#define TARGET_NR_semget                393
+#define TARGET_NR_semctl                394
+#define TARGET_NR_shmget                395
+#define TARGET_NR_shmctl                396
+#define TARGET_NR_shmat                 397
+#define TARGET_NR_shmdt                 398
+#define TARGET_NR_msgget                399
+#define TARGET_NR_msgsnd                400
+#define TARGET_NR_msgrcv                401
+#define TARGET_NR_msgctl                402
+#define TARGET_NR_clock_gettime64       403
+#define TARGET_NR_clock_settime64       404
+#define TARGET_NR_clock_adjtime64       405
+#define TARGET_NR_clock_getres_time64   406
+#define TARGET_NR_clock_nanosleep_time64 407
+#define TARGET_NR_timer_gettime64       408
+#define TARGET_NR_timer_settime64       409
+#define TARGET_NR_timerfd_gettime64     410
+#define TARGET_NR_timerfd_settime64     411
+#define TARGET_NR_utimensat_time64      412
+#define TARGET_NR_pselect6_time64       413
+#define TARGET_NR_ppoll_time64          414
+#define TARGET_NR_io_pgetevents_time64  416
+#define TARGET_NR_recvmmsg_time64       417
+#define TARGET_NR_mq_timedsend_time64   418
+#define TARGET_NR_mq_timedreceive_time64 419
+#define TARGET_NR_semtimedop_time64     420
+#define TARGET_NR_rt_sigtimedwait_time64 421
+#define TARGET_NR_futex_time64          422
+#define TARGET_NR_sched_rr_get_interval_time64 423
+#define TARGET_NR_pidfd_send_signal     424
+#define TARGET_NR_io_uring_setup        425
+#define TARGET_NR_io_uring_enter        426
+#define TARGET_NR_io_uring_register     427
+#define TARGET_NR_open_tree             428
+#define TARGET_NR_move_mount            429
+#define TARGET_NR_fsopen                430
+#define TARGET_NR_fsconfig              431
+#define TARGET_NR_fsmount               432
+#define TARGET_NR_fspick                433
+#define TARGET_NR_pidfd_open            434
+/* 435 reserved for clone3 */
 #endif
-- 
2.7.4


