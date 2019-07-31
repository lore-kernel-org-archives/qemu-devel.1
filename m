Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB23C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CBB206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CBB206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hstEs-0007F4-MD
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50647)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hstCf-0002QO-Vg
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hstCf-0001I8-1u
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:19:57 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43732 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hstCe-0001Hj-Rk
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 14:19:57 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id B1B771A2276;
 Wed, 31 Jul 2019 20:19:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 996DB1A2217;
 Wed, 31 Jul 2019 20:19:54 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 20:19:33 +0200
Message-Id: <1564597178-24649-8-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564597178-24649-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1564597178-24649-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH for 4.2 v4 07/12] linux-user: Add support for
 HDIO_GET_WCACHE and HDIO_SET_WCACHE ioctls
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

Add support for HDIO_GET_WCACHE and HDIO_SET_WCACHE ioctls.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 895ba35..b54a184 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -435,6 +435,7 @@
   IOCTL(HDIO_GET_DMA, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(HDIO_GET_32BIT, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(HDIO_GET_NICE, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(HDIO_GET_WCACHE, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(HDIO_DRIVE_CMD, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(HDIO_SET_UNMASKINTR, 0, TYPE_INT)
   IOCTL(HDIO_SET_MULTCOUNT, 0, TYPE_INT)
@@ -444,6 +445,7 @@
   IOCTL(HDIO_SET_32BIT, 0, TYPE_INT)
   IOCTL(HDIO_SET_PIO_MODE, 0, TYPE_INT)
   IOCTL(HDIO_SET_NICE, 0, TYPE_INT)
+  IOCTL(HDIO_SET_WCACHE, 0, TYPE_INT)
 
   IOCTL(VFAT_IOCTL_READDIR_BOTH, IOC_R, MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_dirent), 2)))
   IOCTL(VFAT_IOCTL_READDIR_SHORT, IOC_R, MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_dirent), 2)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 4e219a1..fb42d32 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1066,6 +1066,7 @@ struct target_format_descr {
 #define TARGET_HDIO_GET_DMA           0x030b  /* get use-dma flag */
 #define TARGET_HDIO_GET_NICE          0x030c  /* get nice flags */
 #define TARGET_HDIO_GET_IDENTITY      0x030d  /* get IDE identification info */
+#define TARGET_HDIO_GET_WCACHE        0x030e  /* get write cache mode on|off */
 #define TARGET_HDIO_DRIVE_CMD         0x031f  /* execute a special drive command */
 
 /* hd/ide ctl's that pass (arg) non-ptr values are numbered 0x032n/0x033n */
@@ -1077,6 +1078,7 @@ struct target_format_descr {
 #define TARGET_HDIO_SET_DMA           0x0326  /* change use-dma flag */
 #define TARGET_HDIO_SET_PIO_MODE      0x0327  /* reconfig interface to new speed */
 #define TARGET_HDIO_SET_NICE          0x0329  /* set nice flags */
+#define TARGET_HDIO_SET_WCACHE        0x032b  /* change write cache mode */
 
 /* loop ioctls */
 #define TARGET_LOOP_SET_FD            0x4C00
-- 
2.7.4


