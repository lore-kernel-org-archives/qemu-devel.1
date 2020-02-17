Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7B0C761A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271DF20679
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271DF20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42505 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cli-0000TS-AP
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3ckE-0007ZK-W1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3ckD-0001sK-9o
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:14 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:35533)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j3ckD-0001qV-0Y
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:13 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MtO4E-1jJdBn2tna-00uqvj; Mon, 17 Feb 2020 10:30:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] linux-user: sh4: Update syscall numbers to kernel 5.5 level
Date: Mon, 17 Feb 2020 10:30:28 +0100
Message-Id: <20200217093031.678348-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217093031.678348-1-laurent@vivier.eu>
References: <20200217093031.678348-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9D36PTNM4SE5zuLTORMJC+f0QIzIMQvNuIYLOZ2DBD3tM+88XG8
 9GtZxrWRKWE9PI3cOdphWedPTzolXr1jpAK9AcyKh4TuFMFGhyKcZxnsdOhBOgdwmIuHora
 msgboD3weONF8Jx49T5/I5EgJ2usYPdutG5nfZAAo27gLQ0/hjXwgGhc57vL0dp09Qe90tw
 HHlb6lO7JWexkQBNATg6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VZrc2/D3Z6Y=:kjwYBsCte58OCXyUECFAfd
 IGykQlBRNVO1Vhij2nfttacs2Aot9M6w0P6JxRAvESwOUlpd3hkWgLEIOW60FtcNI7FFEjWwz
 kuTxXS5+f2mr939E3QEIia+4Ypb4LdRWGTbm7IFp+cXjBhXHB9RaMe8DEh1gaVpVHpbg1sQxY
 pWiEWvPEHNPUbZyRrkWbWG5ctWb/0khmWMcySkZ0lVJy6IzmtqUHnqrPlz9po5uepTnnt/Sz9
 zvS1myh2u1ObdbPZzEoW4Px+xxWZdlZWlBb012InLbVFbF9dNSJk+HuiOMhCY2tJNVGSlpenU
 2LyUGB9jDiHv/i6FnZ0H4Dz+LdeWdaDDJaMhksSFMBJnyiN2ZKY1zSjHLVX202y01TM3JikzS
 uqegMdzbs/AqYPAmMUukuR5dDfKHdX5suRdbduOewBRAOFHnVDPo6FepnLVMpCtyCFGH0N7JK
 D7RdrEETFu/CPFWTgYxBZMyVxOaJ6Q5IZO5a5js9PLQ7nL/Oy5OkEFXgBqMtJt9AZpZdW4njO
 4PCFp1hXAffwbPb4hmc6PwlZb9zi3W7FV0fyu+02LgoeTSmJNK+vO8FbeEy9h4nVyRfJdnapz
 qph3g4/Wb5LqyR+TFJUnN/KHDJN68MIyh3FTRqNzpyZhSlU8XfwZB+WekDLLp6WZDmQfpmT1U
 y3uX/dMVuOeUciiFzdPw2tenO8L66HHycz5YlNKRKAkD73GraSe5SCFkDEtaXy+chs9s4q0QN
 gAgQlelgkdbkG+t2xTk+GQFNQOK/3z+ayVt4reH9wW/mxoM1XCCCWGPseqf26iZGxHzqDYR6M
 exPhsc0uzxRRQz7+m0r8fWc7IaQf3/yC7LlnEz6WfIc10MUmMws6Tx7lcqTMHCsq4Z5leM3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Riku Voipio <riku.voipio@iki.fi>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update sh4 syscall numbers based on Linux kernel v5.5.

CC: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1581596954-2305-7-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sh4/syscall_nr.h | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/linux-user/sh4/syscall_nr.h b/linux-user/sh4/syscall_nr.h
index d53a2a07ddbf..8c21fcf81278 100644
--- a/linux-user/sh4/syscall_nr.h
+++ b/linux-user/sh4/syscall_nr.h
@@ -389,5 +389,53 @@
 #define TARGET_NR_copy_file_range       380
 #define TARGET_NR_preadv2               381
 #define TARGET_NR_pwritev2              382
+#define TARGET_NR_statx                 383
+#define TARGET_NR_pkey_mprotect         384
+#define TARGET_NR_pkey_alloc            385
+#define TARGET_NR_pkey_free             386
+#define TARGET_NR_rseq                  387
+/* room for arch specific syscalls */
+#define TARGET_NR_semget                         393
+#define TARGET_NR_semctl                         394
+#define TARGET_NR_shmget                         395
+#define TARGET_NR_shmctl                         396
+#define TARGET_NR_shmat                          397
+#define TARGET_NR_shmdt                          398
+#define TARGET_NR_msgget                         399
+#define TARGET_NR_msgsnd                         400
+#define TARGET_NR_msgrcv                         401
+#define TARGET_NR_msgctl                         402
+#define TARGET_NR_clock_gettime64                403
+#define TARGET_NR_clock_settime64                404
+#define TARGET_NR_clock_adjtime64                405
+#define TARGET_NR_clock_getres_time64            406
+#define TARGET_NR_clock_nanosleep_time64         407
+#define TARGET_NR_timer_gettime64                408
+#define TARGET_NR_timer_settime64                409
+#define TARGET_NR_timerfd_gettime64              410
+#define TARGET_NR_timerfd_settime64              411
+#define TARGET_NR_utimensat_time64               412
+#define TARGET_NR_pselect6_time64                413
+#define TARGET_NR_ppoll_time64                   414
+#define TARGET_NR_io_pgetevents_time64           416
+#define TARGET_NR_recvmmsg_time64                417
+#define TARGET_NR_mq_timedsend_time64            418
+#define TARGET_NR_mq_timedreceive_time64         419
+#define TARGET_NR_semtimedop_time64              420
+#define TARGET_NR_rt_sigtimedwait_time64         421
+#define TARGET_NR_futex_time64                   422
+#define TARGET_NR_sched_rr_get_interval_time64   423
+#define TARGET_NR_pidfd_send_signal              424
+#define TARGET_NR_io_uring_setup                 425
+#define TARGET_NR_io_uring_enter                 426
+#define TARGET_NR_io_uring_register              427
+#define TARGET_NR_open_tree                      428
+#define TARGET_NR_move_mount                     429
+#define TARGET_NR_fsopen                         430
+#define TARGET_NR_fsconfig                       431
+#define TARGET_NR_fsmount                        432
+#define TARGET_NR_fspick                         433
+#define TARGET_NR_pidfd_open                     434
+/* 435 reserved for clone3 */
 
 #endif
-- 
2.24.1


