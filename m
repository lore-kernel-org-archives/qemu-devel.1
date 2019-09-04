Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAE7C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537C02168B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537C02168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5VGJ-0006WD-9n
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i5Utv-0001eG-3F
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i5Utt-00089Y-N1
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:00:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46863 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i5Utt-00088Z-Bn
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:00:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 75D8E1A219A;
 Wed,  4 Sep 2019 14:59:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 3C27E1A2179;
 Wed,  4 Sep 2019 14:59:34 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 14:59:25 +0200
Message-Id: <1567601968-26946-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v6 5/8] linux-user: Add support for FDMSGON and
 FDMSGOFF ioctls
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

From: Aleksandar Markovic <amarkovic@wavecomp.com>

FDMSGON and FDMSGOFF switch informational messages of floppy drives
on and off.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index bc19448..b253469 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -112,6 +112,8 @@
      IOCTL(BLKZEROOUT, IOC_W, MK_PTR(MK_ARRAY(TYPE_ULONGLONG, 2)))
 #endif
 
+     IOCTL(FDMSGON, 0, TYPE_NULL)
+     IOCTL(FDMSGOFF, 0, TYPE_NULL)
      IOCTL(FDFLUSH, 0, TYPE_NULL)
 
 #ifdef FIBMAP
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 917202a..4e33ef3 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -890,6 +890,8 @@ struct target_pollfd {
 
 /* From <linux/fd.h> */
 
+#define TARGET_FDMSGON        TARGET_IO(2, 0x45)
+#define TARGET_FDMSGOFF       TARGET_IO(2, 0x46)
 #define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
 
 #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
-- 
2.7.4


