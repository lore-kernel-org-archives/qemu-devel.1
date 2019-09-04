Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2114AC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7992168B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7992168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5VIe-00010G-JW
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i5Utv-0001el-GR
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1i5Utt-00089q-Py
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:00:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46855 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1i5Utt-00088U-D0
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:00:41 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 7F4251A2168;
 Wed,  4 Sep 2019 14:59:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 52DBC1A21F1;
 Wed,  4 Sep 2019 14:59:34 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 14:59:28 +0200
Message-Id: <1567601968-26946-9-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v6 8/8] linux-user: Add support for
 FDSETEMSGTRESH, FDSETMAXERRS, and FDGETMAXERRS ioctls
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

FDSETEMSGTRESH, FDSETMAXERRS, and FDGETMAXERRS ioctls are commands
for controlling error reporting of a floppy drive.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/ioctls.h        |  2 ++
 linux-user/syscall_defs.h  | 19 +++++++++++++++++++
 linux-user/syscall_types.h |  7 +++++++
 3 files changed, 28 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 622874b..0c75d03 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -118,6 +118,8 @@
      IOCTL(FDFMTTRK, IOC_W, MK_PTR(MK_STRUCT(STRUCT_format_descr)))
      IOCTL(FDFMTEND, 0, TYPE_NULL)
      IOCTL(FDFLUSH, 0, TYPE_NULL)
+     IOCTL(FDSETMAXERRS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
+     IOCTL(FDGETMAXERRS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
      IOCTL(FDRESET, 0, TYPE_NULL)
      IOCTL(FDRAWCMD, 0, TYPE_NULL)
      IOCTL(FDTWADDLE, 0, TYPE_NULL)
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 834a085..7c5b614 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -890,12 +890,31 @@ struct target_pollfd {
 
 /* From <linux/fd.h> */
 
+struct target_floppy_max_errors {
+    abi_uint        abort;
+    abi_uint        read_track;
+    abi_uint        reset;
+    abi_uint        recal;
+    abi_uint        reporting;
+};
+
+struct target_format_descr {
+    abi_uint        device;
+    abi_uint        head;
+    abi_uint        track;
+};
+
 #define TARGET_FDMSGON        TARGET_IO(2, 0x45)
 #define TARGET_FDMSGOFF       TARGET_IO(2, 0x46)
 #define TARGET_FDFMTBEG       TARGET_IO(2, 0x47)
 #define TARGET_FDFMTTRK      TARGET_IOW(2, 0x48, struct target_format_descr)
 #define TARGET_FDFMTEND       TARGET_IO(2, 0x49)
+#define TARGET_FDSETEMSGTRESH TARGET_IO(2, 0x4a)
 #define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
+#define TARGET_FDSETMAXERRS  TARGET_IOW(2, 0x4c,                               \
+                                        struct target_floppy_max_errors)
+#define TARGET_FDGETMAXERRS  TARGET_IOR(2, 0x0e,                               \
+                                        struct target_floppy_max_errors)
 #define TARGET_FDRESET        TARGET_IO(2, 0x54)
 #define TARGET_FDRAWCMD       TARGET_IO(2, 0x58)
 #define TARGET_FDTWADDLE      TARGET_IO(2, 0x59)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index d82d1a5..5ba7c34 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -261,6 +261,13 @@ STRUCT(blkpg_ioctl_arg,
        TYPE_INT, /* datalen */
        TYPE_PTRVOID) /* data */
 
+STRUCT(floppy_max_errors,
+       TYPE_INT,     /* abort */
+       TYPE_INT,     /* read_track */
+       TYPE_INT,     /* reset */
+       TYPE_INT,     /* recal */
+       TYPE_INT)     /* reporting */
+
 STRUCT(format_descr,
        TYPE_INT,     /* device */
        TYPE_INT,     /* head */
-- 
2.7.4


