Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A6AC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB00620665
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB00620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htADY-00045o-7m
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 08:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45316)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1htA7P-0001T7-WB
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1htA7M-0002tV-Pw
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:23:38 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50846 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1htA7J-0002qG-Gh
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:23:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 58D4A1A215B;
 Thu,  1 Aug 2019 14:23:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 3F7BE1A20CF;
 Thu,  1 Aug 2019 14:23:31 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 14:21:12 +0200
Message-Id: <1564662076-17964-12-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564662076-17964-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1564662076-17964-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.2 v5 11/15] linux-user: Add support for
 KDGKBMETA and KDSKBMETA ioctls
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
Cc: laurent@vivier.eu, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add support for KDGKBMETA and KDSKBMETA ioctls.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 3796ee6..2100cf4 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -63,6 +63,8 @@
      IOCTL(KDSKBMODE, 0, TYPE_INT)
      IOCTL(KDGKBENT, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_kbentry)))
      IOCTL(KDGKBSENT, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_kbsentry)))
+     IOCTL(KDGKBMETA, IOC_R, MK_PTR(TYPE_INT))
+     IOCTL(KDSKBMETA, IOC_W, TYPE_INT)
      IOCTL(KDGKBLED, 0, TYPE_INT)
      IOCTL(KDSKBLED, 0, TYPE_INT)
      IOCTL(KDGETLED, 0, TYPE_INT)
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 766d7b9..50fc44f 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -750,6 +750,8 @@ struct target_pollfd {
 #define TARGET_KDSKBMODE       0x4b45
 #define TARGET_KDGKBENT	       0x4B46	/* gets one entry in translation table */
 #define TARGET_KDGKBSENT       0x4B48	/* gets one function key string entry */
+#define TARGET_KDGKBMETA       0x4B62   /* gets meta key handling mode */
+#define TARGET_KDSKBMETA       0x4B63   /* sets meta key handling mode */
 #define TARGET_KDGKBLED        0x4B64	/* get led flags (not lights) */
 #define TARGET_KDSKBLED        0x4B65	/* set led flags (not lights) */
 #define TARGET_KDGETLED        0x4B31	/* return current led state */
-- 
2.7.4


