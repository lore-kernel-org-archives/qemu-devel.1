Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F072C3B188
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B2420659
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B2420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j23cT-0007Zz-7c
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 20:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j23bc-0005xv-7N
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:47:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1j23ba-0004TC-UK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:47:52 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:38856 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1j23ba-0002yC-NJ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:47:50 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 830251A2147;
 Thu, 13 Feb 2020 02:46:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 6840B1A1FF3;
 Thu, 13 Feb 2020 02:46:47 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] linux-user: alpha: Update syscall numbers to kernel
 5.5 level
Date: Thu, 13 Feb 2020 02:46:25 +0100
Message-Id: <1581558393-9182-2-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: laurent@vivier.eu, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update alpha syscall numbers based on Linux kernel v5.5.

CC: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/alpha/syscall_nr.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/linux-user/alpha/syscall_nr.h b/linux-user/alpha/syscall_nr.h
index 2e5541b..c29fc17 100644
--- a/linux-user/alpha/syscall_nr.h
+++ b/linux-user/alpha/syscall_nr.h
@@ -453,5 +453,40 @@
 #define TARGET_NR_getrandom                     511
 #define TARGET_NR_memfd_create                  512
 #define TARGET_NR_execveat                      513
+#define TARGET_NR_seccomp                       514
+#define TARGET_NR_bpf                           515
+#define TARGET_NR_userfaultfd                   516
+#define TARGET_NR_membarrier                    517
+#define TARGET_NR_mlock2                        518
+#define TARGET_NR_copy_file_range               519
+#define TARGET_NR_preadv2                       520
+#define TARGET_NR_pwritev2                      521
+#define TARGET_NR_statx                         522
+#define TARGET_NR_io_pgetevents                 523
+#define TARGET_NR_pkey_mprotect                 524
+#define TARGET_NR_pkey_alloc                    525
+#define TARGET_NR_pkey_free                     526
+#define TARGET_NR_rseq                          527
+#define TARGET_NR_statfs64                      528
+#define TARGET_NR_fstatfs64                     529
+#define TARGET_NR_getegid                       530
+#define TARGET_NR_geteuid                       531
+#define TARGET_NR_getppid                       532
+/*
+ * all other architectures have common numbers for new syscall, alpha
+ * is the exception.
+ */
+#define TARGET_NR_pidfd_send_signal             534
+#define TARGET_NR_io_uring_setup                535
+#define TARGET_NR_io_uring_enter                536
+#define TARGET_NR_io_uring_register             537
+#define TARGET_NR_open_tree                     538
+#define TARGET_NR_move_mount                    539
+#define TARGET_NR_fsopen                        540
+#define TARGET_NR_fsconfig                      541
+#define TARGET_NR_fsmount                       542
+#define TARGET_NR_fspick                        543
+#define TARGET_NR_pidfd_open                    544
+/* 545 reserved for clone3 */
 
 #endif
-- 
2.7.4


