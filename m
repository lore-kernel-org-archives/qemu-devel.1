Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728E8C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A762070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A762070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cmz-00035U-D0
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3ckF-0007ZL-5c
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3ckD-0001sA-9S
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:15 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:44639)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j3ckD-0001qO-0Z
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:13 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MsZ7T-1jIoF11dwh-00u1z4; Mon, 17 Feb 2020 10:30:40 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] linux-user: microblaze: Update syscall numbers to kernel
 5.5 level
Date: Mon, 17 Feb 2020 10:30:26 +0100
Message-Id: <20200217093031.678348-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217093031.678348-1-laurent@vivier.eu>
References: <20200217093031.678348-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N5CS+8b1+soucHcmLCD8OGfIuprmzUpg2UxHpgDoYFRN8aDEkSo
 6jFxfTTmkIzwSVhVRMxXUD8VJnv34qtZSPn9xbtfGDalo0g6h9fLE4/IuF2zbvscCVBZNeT
 FQvDQ3GC2/wFrf/PdrIOmu6JZ49PkNgiuxdAPR7pqOFq0RYMZJ6hEisIhW6FOjgnN2z8esQ
 YhzHPQnr/oB1Kz4zVDJvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ARIZpaV4CtU=:Ec/P73FGaIqmH53rZ8XFj3
 kbJhBplAy1ocw5zN1CbIsATtfFW5asxrB8c1fXxm0rxqyICr7afCuhLzXAhP5m5iwtbwNrC4u
 31aDpW1MMRvUlm+K9QzZfiXG/GhHK9gJMtmEY5Ya3rVpef5z1Or14FHZT4+R1gN1PMyj8wyiQ
 MrQuhsWlW0xIL8MGPtkDGd55kk1KrI+KKv2vAiwaPQcw2GpUNPNb3ZEAowLR3HgBWP2tQm4yu
 erI77PqPlA+Phl4BNTDDyIVqgMGKO0CsOiOfvdAA0WcnlxMQM4E0xRlPrfWsBgFscFUQLjjb4
 Wp8zWaulGEzX3QXvT7ALUYQE+Zxzi3T2kLHIq93jEpTNKpU5D/QMwfrpAx0vMv7fT/+OZfXyl
 J8kEZ2jtNit5LPcb//F0Zd667YOB0B8c31P1mumblnpB3mZF3e7IcQLI1OeiG90l+9q/7yBZF
 VUdzeBP4HFhDIOZPSi9Cn9s65bz5XAnz0OVT+75DydAw8qN6cQ+ZlCTrf1OdtXmZtONzVe2M9
 EoUSEReqBheHtDk6Pa4AotsRegQPxUCQlPhyaJHWwQ4Ff8QttjzVbW+IRnQdU/hs3wAb6AgNF
 INFT+fvkSQMWZ1fzt/p/h2UaL4A6ENzHvp6zV210TlRJNbLYIZEPx/9rBDzDbQx4GI3WYCxWi
 lRXAuZiZNz/3cGdHGBgYipuf69XAbth5ulZEnWtY5zPpq873gNSMysWJJR2MG8GrQbkH9gdMK
 tvNRCGBGMYAFtTDzrg93EjTtAi4AA9RbPBXptH9T+r/XZexfgcPdx8Z2mRuLUPm91bJhnV1+I
 93U0gmnWlPgaQtj43Yf/5cYatZit85OFuMM14wf7bTQfZINpIBGuANKwU7BV+zpsFNU3/Lz
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update microblaze syscall numbers based on Linux kernel v5.5.

CC: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1581596954-2305-5-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/microblaze/syscall_nr.h | 45 ++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/linux-user/microblaze/syscall_nr.h b/linux-user/microblaze/syscall_nr.h
index aa2eb9388177..ec1758e37434 100644
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
2.24.1


