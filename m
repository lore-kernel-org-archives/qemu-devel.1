Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E40DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576EC20449
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576EC20449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5V5h-00041s-Fo
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i5Utt-0001cm-TA
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i5Utr-00087s-Vo
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:00:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44143 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i5Utr-0007RK-M6
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:00:39 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 43BBE1A218B;
 Wed,  4 Sep 2019 14:59:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 22E151A1DCC;
 Wed,  4 Sep 2019 14:59:34 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 14:59:21 +0200
Message-Id: <1567601968-26946-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v6 1/8] linux-user: Add support for
 semtimedop() syscall
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Add support for semtimedop() emulation. It is based on invocation
of safe_semtimedop().

Conversion is left out of safe_semtimedop(), since other safe_xxx()
usually don't contain similar conversions.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/syscall.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8367cb1..b5bc6e4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6649,7 +6649,43 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
     return 0;
 }
 #endif
+#ifdef TARGET_NR_semtimedop
+static inline abi_long do_semtimedop(int semid, abi_long ptr, unsigned nsops,
+                                     abi_long timeout)
+{
+    struct sembuf *sops;
+    struct timespec ts, *pts;
+    abi_long ret;
+
+    if (timeout) {
+        pts = &ts;
+        if (target_to_host_timespec(pts, timeout)) {
+            return -TARGET_EFAULT;
+        }
+    } else {
+        pts = NULL;
+    }
 
+    sops = g_malloc(sizeof(struct sembuf) * nsops);
+    if (sops == NULL) {
+        return -TARGET_EFAULT;
+    }
+
+    if (target_to_host_sembuf(sops, ptr, nsops)) {
+        g_free(sops);
+        return -TARGET_EFAULT;
+    }
+
+#ifdef __NR_semtimedop
+    ret = get_errno(safe_semtimedop(semid, sops, nsops, pts));
+#else
+    ret = -TARGET_ENOSYS;
+#endif
+    g_free(sops);
+
+    return ret;
+}
+#endif
 
 /* ??? Using host futex calls even when target atomic operations
    are not really atomic probably breaks things.  However implementing
@@ -9193,6 +9229,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_semop:
         return do_semop(arg1, arg2, arg3);
 #endif
+#ifdef TARGET_NR_semtimedop
+    case TARGET_NR_semtimedop:
+        return do_semtimedop(arg1, arg2, arg3, arg4);
+#endif
 #ifdef TARGET_NR_semctl
     case TARGET_NR_semctl:
         return do_semctl(arg1, arg2, arg3, arg4);
-- 
2.7.4


