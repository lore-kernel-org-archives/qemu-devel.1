Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3DDC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC001206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC001206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hstEw-0007Mk-3X
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50602)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hstCc-0002IK-FV
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hstCb-0001GB-HG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:19:54 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:42898 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hstCb-0001Ei-As
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:19:53 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 32E081A2276;
 Wed, 31 Jul 2019 20:19:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 1A7651A2217;
 Wed, 31 Jul 2019 20:19:51 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 20:19:30 +0200
Message-Id: <1564597178-24649-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564597178-24649-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1564597178-24649-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.2 v4 04/12] linux-user: Add support for
 FDFMTBEG, FDFMTTRK, and FDFMTEND ioctls
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

FDFMTBEG, FDFMTTRK, and FDFMTEND ioctls provide means for controlling
formatting of a floppy drive.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/ioctls.h        | 3 +++
 linux-user/syscall_defs.h  | 3 +++
 linux-user/syscall_types.h | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index ab4ef2e..e393ad6 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -114,6 +114,9 @@
 
      IOCTL(FDMSGON, 0, TYPE_NULL)
      IOCTL(FDMSGOFF, 0, TYPE_NULL)
+     IOCTL(FDFMTBEG, 0, TYPE_NULL)
+     IOCTL(FDFMTTRK, IOC_W, MK_PTR(MK_STRUCT(STRUCT_format_descr)))
+     IOCTL(FDFMTEND, 0, TYPE_NULL)
      IOCTL(FDFLUSH, 0, TYPE_NULL)
      IOCTL(FDRESET, 0, TYPE_NULL)
      IOCTL(FDRAWCMD, 0, TYPE_NULL)
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 4185391..1ca115d 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -887,6 +887,9 @@ struct target_pollfd {
 
 #define TARGET_FDMSGON        TARGET_IO(2, 0x45)
 #define TARGET_FDMSGOFF       TARGET_IO(2, 0x46)
+#define TARGET_FDFMTBEG       TARGET_IO(2, 0x47)
+#define TARGET_FDFMTTRK      TARGET_IOW(2, 0x48, struct target_format_descr)
+#define TARGET_FDFMTEND       TARGET_IO(2, 0x49)
 #define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
 #define TARGET_FDRESET        TARGET_IO(2, 0x54)
 #define TARGET_FDRAWCMD       TARGET_IO(2, 0x58)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 4e36983..d82d1a5 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -261,6 +261,11 @@ STRUCT(blkpg_ioctl_arg,
        TYPE_INT, /* datalen */
        TYPE_PTRVOID) /* data */
 
+STRUCT(format_descr,
+       TYPE_INT,     /* device */
+       TYPE_INT,     /* head */
+       TYPE_INT)     /* track */
+
 #if defined(CONFIG_USBFS)
 /* usb device ioctls */
 STRUCT(usbdevfs_ctrltransfer,
-- 
2.7.4


