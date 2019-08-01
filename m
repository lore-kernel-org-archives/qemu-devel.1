Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF5AC41514
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C480420665
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 12:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C480420665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htABa-0001Ni-2l
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 08:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45213)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1htA7D-0001K4-KI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1htA7B-0002lb-VT
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:23:27 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50315 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1htA7B-0002iw-Lt
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 08:23:25 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id E91B81A215B;
 Thu,  1 Aug 2019 14:23:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id CFE6B1A20CF;
 Thu,  1 Aug 2019 14:23:20 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 14:21:11 +0200
Message-Id: <1564662076-17964-11-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564662076-17964-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1564662076-17964-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.2 v5 10/15] linux-user: Add support for
 HDIO_GET_BUSSTATE and HDIO_SET_BUSSTATE ioctls
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

Add support for HDIO_GET_BUSSTATE and HDIO_SET_BUSSTATE ioctls.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index b9c6a5a..3796ee6 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -438,6 +438,7 @@
   IOCTL(HDIO_GET_WCACHE, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(HDIO_GET_ACOUSTIC, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(HDIO_GET_ADDRESS, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(HDIO_GET_BUSSTATE, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(HDIO_DRIVE_CMD, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(HDIO_SET_UNMASKINTR, 0, TYPE_INT)
   IOCTL(HDIO_SET_MULTCOUNT, 0, TYPE_INT)
@@ -449,6 +450,7 @@
   IOCTL(HDIO_SET_NICE, 0, TYPE_INT)
   IOCTL(HDIO_SET_WCACHE, 0, TYPE_INT)
   IOCTL(HDIO_SET_ACOUSTIC, 0, TYPE_INT)
+  IOCTL(HDIO_SET_BUSSTATE, 0, TYPE_INT)
   IOCTL(HDIO_SET_ADDRESS, 0, TYPE_INT)
 
   IOCTL(VFAT_IOCTL_READDIR_BOTH, IOC_R, MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_dirent), 2)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index aa9c6af..766d7b9 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1069,6 +1069,7 @@ struct target_format_descr {
 #define TARGET_HDIO_GET_WCACHE        0x030e  /* get write cache mode on|off */
 #define TARGET_HDIO_GET_ACOUSTIC      0x030f  /* get acoustic value */
 #define TARGET_HDIO_GET_ADDRESS       0x0310  /* get lba addressing modes */
+#define TARGET_HDIO_GET_BUSSTATE      0x031a  /* get hwif bus state */
 #define TARGET_HDIO_DRIVE_CMD         0x031f  /* execute a special drive command */
 
 /* hd/ide ctl's that pass (arg) non-ptr values are numbered 0x032n/0x033n */
@@ -1082,6 +1083,7 @@ struct target_format_descr {
 #define TARGET_HDIO_SET_NICE          0x0329  /* set nice flags */
 #define TARGET_HDIO_SET_WCACHE        0x032b  /* change write cache mode */
 #define TARGET_HDIO_SET_ACOUSTIC      0x032c  /* change acoustic behavior */
+#define TARGET_HDIO_SET_BUSSTATE      0x032d  /* set hwif bus state */
 #define TARGET_HDIO_SET_ADDRESS       0x032f  /* change lba addressing modes */
 
 /* loop ioctls */
-- 
2.7.4


