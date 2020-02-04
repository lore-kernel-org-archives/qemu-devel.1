Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F940C3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2504320661
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2504320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyx0q-0008RO-7u
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 07:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iywzl-0006k8-R6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iywzk-000807-DP
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:07:57 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37179 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iywzk-0007wd-54
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:07:56 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 82A4F1A2109;
 Tue,  4 Feb 2020 13:07:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 485021A2010;
 Tue,  4 Feb 2020 13:07:53 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/9] linux-user: microblaze: Update syscall numbers to kernel
 5.5 level
Date: Tue,  4 Feb 2020 13:07:33 +0100
Message-Id: <1580818058-16159-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580818058-16159-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580818058-16159-1-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, laurent@vivier.eu,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update microblaze syscall numbers based on Linux kernel v5.5.

CC: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/microblaze/syscall_nr.h | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/linux-user/microblaze/syscall_nr.h b/linux-user/microblaze/syscall_nr.h
index aa2eb93..ec1758e 100644
--- a/linux-user/microblaze/syscall_nr.h
+++ b/linux-user/microblaze/syscall_nr.h
@@ -393,5 +393,50 @@
 #define TARGET_NR_memfd_create          386
 #define TARGET_NR_bpf                   387
 #define TARGET_NR_execveat              388
+#define TARGET_NR_userfaultfd           389
+#define TARGET_NR_membarrier            390
+#define TARGET_NR_mlock2                391
+#define TARGET_NR_copy_file_range       392
+#define TARGET_NR_preadv2               393
+#define TARGET_NR_pwritev2              394
+#define TARGET_NR_pkey_mprotect         395
+#define TARGET_NR_pkey_alloc            396
+#define TARGET_NR_pkey_free             397
+#define TARGET_NR_statx                 398
+#define TARGET_NR_io_pgetevents         399
+#define TARGET_NR_rseq                  400
+/* 401 and 402 are unused */
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
+#define TARGET_NR_clone3                435
 
 #endif
-- 
2.7.4


