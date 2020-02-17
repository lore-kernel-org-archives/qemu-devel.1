Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20E7C7619F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC07A2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC07A2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cn0-00039c-U3
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:34:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3ckK-0007dI-CD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3ckI-0001wx-Cm
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:20 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58627)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j3ckI-0001w4-49
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:18 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MBll6-1jBLRv0H3k-00C8Xh; Mon, 17 Feb 2020 10:30:43 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] linux-user: xtensa: Update syscall numbers to kernel 5.5
 level
Date: Mon, 17 Feb 2020 10:30:30 +0100
Message-Id: <20200217093031.678348-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217093031.678348-1-laurent@vivier.eu>
References: <20200217093031.678348-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sYLyRsDLtdnLFj6WLqppBp/UHV/WDtYJpyaVTSvYSs8PYFfGciQ
 ElFbrNo8myr6gdbowDgSPBveIUO3Wu2Ea7Y4mIRbu885J0yb8iB8OBo0ck4ux9tOVmbPYUx
 fq9DhZ4dx2iA4dhiSnN1MxhBCAhhmyTPrOwque4zlp/CpZjvaRuxr1Ti35wi5UdAbiWmp+J
 sDhN0cGaxdWqGsWPsQczg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DKOgkJWhVC0=:+rv/FCgCaE7D0iBGkWyZwL
 zbFsXW26+1KqxKmTG8Gs4W1Zrm4OeF+fkMJCqzlTcp1asIohtW+AI+lj2UA8fzMDgZWqT3h07
 53svh3koQqF1L9UNRXWMtbWHb04mMzaNCggdgOyx4DD9CZFHWyZcbShbegDeJGIi/YMRi7syp
 N0oTUoLoSbPa6wpxeHlOkTlDThBVPoshJSJhQCt/Dvvdf7yrZ33/Ks0EShlvoi3KUEOp9JeeB
 JzRTwHSfGrnck+mPLgxBw4SXxtNJ4Q3V5HLgoQkCNQyCtW+5M9fcvRR/K6X5lXXT6TALB5/hC
 n03vZEOTnMWlsvtSX0KkYMX9Fh6H9yhv7ZOb78eHjEPFSaQJQlaezIlPlcnYvlp/o3I0DvzS6
 dEMiLrd5gxtfD1+ICOmDL7VlfyHgb6ABx1Zury4RJcaSYKi5br5zTqONGjR8jBwBBiC/j+IQz
 9Ld7dAr5nqKdZdIg4bYLG5qY4X9GF+OYvAl1x4J+g7riY5JtkwGOhxowF1MEvTeoCQs584Ec6
 ytWeo+iM8KvB+24NDzC7ddmaj0D1/GbsBhEMeZ5y3i2KB0Hgtqrv59TzFLPNJnYmKZ138gJl/
 39AzWN+9yjlG82jIC2YbPOLOCD09CWDGzgD4PYCv27iN1Au0aUhkat71nmKszu2muwS3KVzFh
 76z9oCRTjdo3MKSWBs6yFXvy8Ci89Fqtu3C+WVG3Jr1Cd5d8Kak2DTNVLcllRI4tXZYygT11b
 LyyQKTzS275My2PUhf82NhQP04Nktfzzx244gRDLVyB+lTQ47zmILob3gHOHw3K4E7iOpN6Vj
 Sop+ywjMaACtQ5iVQG04g5BhgiuECWMLVIpCFP1V1OiGxfuMujfGY7+ayEqJHn8XxoWEzut
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update xtensa syscall numbers based on Linux kernel v5.5.

CC: Max Filippov <jcmvbkbc@gmail.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1581596954-2305-9-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/xtensa/syscall_nr.h | 38 ++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/linux-user/xtensa/syscall_nr.h b/linux-user/xtensa/syscall_nr.h
index 27645bea4750..3d19d0cb70a6 100644
--- a/linux-user/xtensa/syscall_nr.h
+++ b/linux-user/xtensa/syscall_nr.h
@@ -431,7 +431,41 @@
 #define TARGET_NR_pkey_free                          350
 
 #define TARGET_NR_statx                              351
-
-#define TARGET_NR_syscall_count                      352
+#define TARGET_NR_rseq                               352
+/* 353 through 402 are unassigned to sync up with generic numbers */
+#define TARGET_NR_clock_gettime64                    403
+#define TARGET_NR_clock_settime64                    404
+#define TARGET_NR_clock_adjtime64                    405
+#define TARGET_NR_clock_getres_time64                406
+#define TARGET_NR_clock_nanosleep_time64             407
+#define TARGET_NR_timer_gettime64                    408
+#define TARGET_NR_timer_settime64                    409
+#define TARGET_NR_timerfd_gettime64                  410
+#define TARGET_NR_timerfd_settime64                  411
+#define TARGET_NR_utimensat_time64                   412
+#define TARGET_NR_pselect6_time64                    413
+#define TARGET_NR_ppoll_time64                       414
+#define TARGET_NR_io_pgetevents_time64               416
+#define TARGET_NR_recvmmsg_time64                    417
+#define TARGET_NR_mq_timedsend_time64                418
+#define TARGET_NR_mq_timedreceive_time64             419
+#define TARGET_NR_semtimedop_time64                  420
+#define TARGET_NR_rt_sigtimedwait_time64             421
+#define TARGET_NR_futex_time64                       422
+#define TARGET_NR_sched_rr_get_interval_time64       423
+#define TARGET_NR_pidfd_send_signal                  424
+#define TARGET_NR_io_uring_setup                     425
+#define TARGET_NR_io_uring_enter                     426
+#define TARGET_NR_io_uring_register                  427
+#define TARGET_NR_open_tree                          428
+#define TARGET_NR_move_mount                         429
+#define TARGET_NR_fsopen                             430
+#define TARGET_NR_fsconfig                           431
+#define TARGET_NR_fsmount                            432
+#define TARGET_NR_fspick                             433
+#define TARGET_NR_pidfd_open                         434
+#define TARGET_NR_clone3                             435
+
+#define TARGET_NR_syscall_count                      436
 
 #endif /* XTENSA_SYSCALL_NR_H */
-- 
2.24.1


