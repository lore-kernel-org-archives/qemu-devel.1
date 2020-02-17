Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3691C761A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1B020732
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1B020732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cq4-0007Pj-Nk
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3ckP-0007gy-K1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3ckO-00023O-9Q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:25 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:51677)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j3ckN-00021z-Tw
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:24 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNc1T-1inr8z1mNH-00P75K; Mon, 17 Feb 2020 10:30:42 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] linux-user: x86_64: Update syscall numbers to kernel 5.5
 level
Date: Mon, 17 Feb 2020 10:30:29 +0100
Message-Id: <20200217093031.678348-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217093031.678348-1-laurent@vivier.eu>
References: <20200217093031.678348-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ImRXrIFxGe8PlPs3tO/qLH35H/YwlayaqtaiOpOAbE/SrfmI/yF
 gP1StVYFaSvcy0YR+mgAERgt1lGoqebMe8ran649AdRS3r5aC7L9KSDkYbTigLxs3YyKnQC
 WlKnAMbcchlxkgJor2kHHS404C33jqOmYsCt6Obcy9swho3BTsJf3snvj3m6irmsaDfQOFS
 duf113byDgHHoP2ivejhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:My9O8i07CTI=:DvaEjqMdZK3n8Xfs/5EJB9
 HdDhShfSPzXQuat9WgfRuX4ApTmFyxIxkPAX5KADvkinGM7YvTxmLyko0Zvncjf/c1EtGI2RT
 Q+AXokPmbNdjO5F8mLRZaqCd4s14ZYHayjq7GyrXxcRroNa248zeW1IuaGbantOpYftEvqxon
 PkwWccrniNG7109Et1vYlo83bGo7bYKRXjFSNhec+y39aLxS3+vmonrr2pjTqlwuX9hHDlTJE
 KiUF322XjeCzInjqUDTOR3pA6rWr4Jm+ZFP5jp9YvNJ4tM1gxYL45O46sX5sKV0Cq9rXl9QHL
 Zcw4QsYzZdvY1KVOd8xtNgfkHKZbR1sSeTQz4FlBRJhJ2cuuSmZCECLrNs5Ff1jCf7rPv6nml
 Du0UjaKHvx8GQ9yZPOhQe7/0+qYfsa828qbjd995hxdat7EhHK6028QNoqyWNyIPQLlYsHBlk
 uuCtEaWFEg4HXhHmLkFkiYGlvhy1O3yLu8/5pZz96hiEu4iui6IV2NLg2bGvBhoP6sr4EKY1a
 t4S7ljE6eIk6oyfSCjKH5NvuvVCXcXf+6hpzkvRilv1xXUBNxV0miLHcQr4UyX3dxCABzoXg+
 KZ6hhcoJ9MYbXXaIjLPTeCj6Ywentdiq/ywq7oPSr5/VqeC36Nk4RwjeFd0GTJb+bPe/44mtc
 tzAAgymZUCbtBibiNcuSrSKpbRJxsv7SD3ZV63r++TXidSJH3twnbqEZh380dfDSVSwMghCJb
 rA9+ZLKiMTEBqPLqU0Kz61uHqCJRP+4c/z2cjq8Chzbw9Gwby6HRaF3Qh2blTME97zkOXOsOA
 lmvfxlyz6K6Co+J+hkth2YmlRCQDgp0ljjAnNhP0Fd8+Pwdj8LPN4E1G9RKxHKD0d4n/cBt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update x86_64 syscall numbers based on Linux kernel v5.5.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1581596954-2305-8-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/x86_64/syscall_nr.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/linux-user/x86_64/syscall_nr.h b/linux-user/x86_64/syscall_nr.h
index 9b6981e74cea..e5d14eca223d 100644
--- a/linux-user/x86_64/syscall_nr.h
+++ b/linux-user/x86_64/syscall_nr.h
@@ -328,5 +328,29 @@
 #define TARGET_NR_membarrier            324
 #define TARGET_NR_mlock2                325
 #define TARGET_NR_copy_file_range       326
+#define TARGET_NR_preadv2               327
+#define TARGET_NR_pwritev2              328
+#define TARGET_NR_pkey_mprotect         329
+#define TARGET_NR_pkey_alloc            330
+#define TARGET_NR_pkey_free             331
+#define TARGET_NR_statx                 332
+#define TARGET_NR_io_pgetevents         333
+#define TARGET_NR_rseq                  334
+/*
+ * don't use numbers 387 through 423, add new calls after the last
+ * 'common' entry
+ */
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


