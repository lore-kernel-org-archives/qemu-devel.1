Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88119C761A1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF6B2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF6B2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3clh-0000Rh-HY
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3ckH-0007Zc-AX
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3ckF-0001uZ-Rz
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:17 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:37831)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j3ckF-0001tj-JR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:15 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MeknF-1jeKSp2ExJ-00aii8; Mon, 17 Feb 2020 10:30:38 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] linux-user: alpha: Update syscall numbers to kernel 5.5
 level
Date: Mon, 17 Feb 2020 10:30:23 +0100
Message-Id: <20200217093031.678348-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217093031.678348-1-laurent@vivier.eu>
References: <20200217093031.678348-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xw72ULb53860QTZOljAGRJFmGmC26VgVj55GKU1bgFJJfcKlKAH
 9qQQsRCp7lCGkcvGSRUhYzMJq2L/5Qoail07GJMaeiuGsyswe+lkHtJ0u0oNYdbPAiwNAo9
 r40sYLTglpwZ0UDhhHkkqa12k2tBIRcLVKe/3twru1A2jFaPYt6izC3KfS6FZ9Erh6PWWEr
 M3lVGXew0BUxhvg4uRl5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V31V9gbSZRc=:h6JVZzydlP6UTFPf9OOGCG
 uEQeXNZSvsuG31d5/rm2s9IjX/xRYopeV32uyK5XPFwNnairwvHDgUMQtXMk4e+q8xglg66uT
 sEcQb+D3TOv/6gCg902aSUKNoOtIfDSuVKoOpoKXCVVjFcnm/svTL19qBWpuswStvI3jZxZp6
 zRPkO6UMUz7XuFeSBM6BEK1qe7cFpwjUuMT0X35YszbiSUr9ZgdhrnkPnhWQqyPkTyQYXCoWt
 jV7S/TmaUm/4F3HBmH4j1m0zwKgBXmCna2y0LGB+4a8BGprDZsllVNsaFRnECnxd4Mb+BFr3S
 SDmZZVMrvbJO5QDtEuQd4ccrQROi3u5e88DcMXz1iR1y9kn6MzallABbJclM9Y7Wq9vU/FPPa
 DK/8QLKUzAqTxgnTBkNMCt6EuwtvvTbt1RGaQ1dMUkJmRILKtvlV735Lcpu4rVAfrA+2EFG/D
 1qtfIhEWLivN4poG1gRy672mD3gQkEYfiiDsv2iw+Ikk/xrmgA8Oha6pDiVXYNp4O+3Lri3qy
 7Y8EXzz3UGjnEO+kGUb4x2WJr9hhbJ4g8VsXIEgi8k3wcswiJb2pDAESmg1tkJl6cjPzt9Ng6
 Ymo2jkKMxA/FO8JBZFKOsXlr/8zuPPS7KK1huQ3zjZwXM6ru245p/eftoMaGkqKs5SG9l2Fai
 FAKqk0q/8VyE+xqRN5+8frJ0rdG3pGyYvyGOj90KIAAlQ0OsjJTA0KPN7nYWjQTQNBw2DXqiM
 aoSUKv19SwhsmKWwm2ttzLLDt0shr3NjqD50KXWtoLbvejnJTJSxrlKmvUVmz+ENHBhhAhKum
 qyiU4lckVBpgGj4ZStHe37mj1zHVzEPU03CnCxYFhA/Uhn9kbdmIEgq0Un9NhOvirAkDGe8
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
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update alpha syscall numbers based on Linux kernel v5.5.

CC: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1581596954-2305-2-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/alpha/syscall_nr.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/linux-user/alpha/syscall_nr.h b/linux-user/alpha/syscall_nr.h
index 2e5541bbf902..c29fc17722c5 100644
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
2.24.1


