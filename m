Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F18C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C4624125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C4624125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXs2-0002K0-BS
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlM-00014u-3v
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlK-00032B-KJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:51 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:34085)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlK-0002zI-Ae
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:22:50 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2w0K-1itRpJ0jHw-003QiD; Thu, 23 Jan 2020 09:22:37 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/17] linux-user: Add support for FDFMT<BEG|TRK|END> ioctls
Date: Thu, 23 Jan 2020 09:22:17 +0100
Message-Id: <20200123082227.2037994-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T6e1aRRRGjwso8DsyU83AP23O2FYyJR89ofrWkTtCHWrLkPdLhy
 p2WCAYG+OH51h4o3GUMr6fvWbh2pBYhTHgx7bYv4QlHxfMN1ossVoiuRtRb9uRun5DnSktC
 TBCm/ndHE95MBb0nX+T+8AjhgaE0E/omeG5+w9QBH/G4MxQZ6Y24KZol11RwDFDZY8zD5hL
 mujA3caCpapQG5sUvyThA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aeHXt/K6uuA=:5K/3ClrR6tUUeqj1/WBuv9
 MD2S7mhHlqHcMio3hRxpJg5fgz3nLa+2lLLqwBCGjbFjlyK3Wm3bNyVGAAfF5VU7G7+SyQe7B
 gDMjWOE2CJhYRRMkHi229e/GbH3PdmDJBQNBJv9x+h3/ng9wQAPEM8oTqId1vGjseEeuz0YnN
 UIvDYLcUrlxPUuDVK4KZv83HsYOlwqbiWv/dOCNG2n1Il0tEX53Ki3ug1SknOvKjnaE55nU9o
 isNyUm5ZbzbCH/AfuWLOy+j93OeUZVbuhhcPfq5+onlT0KtCb3mfKqBsgGB0XSZLF23TRzp45
 j17co/OOSvi4zpBnJmVgeSJ0TTibLdtiNF6I69ltdTqEV2hDycJqANZX88/iGIw9F48zRHbyK
 SEc4N9OenHOOFAJXltqnKBJ75R85IqDK1WCfxoxBX6Gp+xNnVPw6uiSuuh8FHyPRFQdL01O3M
 YU8g2NI+ZdYaFmdw4F5yN9Pqo3AhkiMMo1I+SyXWw7wNFuDG+fFi1jh+0Uh4JveMm9yXIjqpO
 nwVuNWRedfS4zHSX7GY93HphdagoBYQOTxM/ge/c65Z4nyKqxHLYTmKlw/N5dItXy+G4Mj5vE
 X2C/rdXImwUp7nmI8DSm11jXOWyeKXGlPgTLd1YFkDkumakOEMvtgZrO6xLcQQoi1g/dexv1R
 6PZtMlpl2cHRx6Qh9ncb59BwDwnqjDY4nx9GOgV1J2unifPM1rBNr6m1zIRjWT4YpopCC4LCe
 RryLS8Uh4k0OGfD3RE11aKqwlegtRQO1H7u4/+5MJcPpXFL7uowuBpK3ELn9nGqK92cmH/qji
 g9AYHD8cVBUG/Pv1mC1JPh5gZc/dMa1+cNtydSp1L9vKdndH0E=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

FDFMTBEG, FDFMTTRK, and FDFMTEND ioctls provide means for controlling
formatting of a floppy drive.

FDFMTTRK's third agrument is a pointer to the structure:

struct format_descr {
    unsigned int device,head,track;
};

defined in Linux kernel header <linux/fd.h>.

Since all fields of the structure are of type 'unsigned int', there is
no need to define "target_format_descr".

FDFMTBEG and FDFMTEND ioctls do not use the third argument.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1579214991-19602-9-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 3 +++
 linux-user/syscall_defs.h  | 3 +++
 linux-user/syscall_types.h | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 2c3d798842e4..29969e2f2f27 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -115,6 +115,9 @@
      IOCTL(FDMSGON, 0, TYPE_NULL)
      IOCTL(FDMSGOFF, 0, TYPE_NULL)
      IOCTL(FDSETEMSGTRESH, 0, TYPE_NULL)
+     IOCTL(FDFMTBEG, 0, TYPE_NULL)
+     IOCTL(FDFMTTRK, IOC_W, MK_PTR(MK_STRUCT(STRUCT_format_descr)))
+     IOCTL(FDFMTEND, 0, TYPE_NULL)
      IOCTL(FDFLUSH, 0, TYPE_NULL)
      IOCTL(FDSETMAXERRS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
      IOCTL(FDGETMAXERRS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 48de76145f0c..b3acf85a6b23 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -899,6 +899,9 @@ struct target_pollfd {
 
 #define TARGET_FDMSGON        TARGET_IO(2, 0x45)
 #define TARGET_FDMSGOFF       TARGET_IO(2, 0x46)
+#define TARGET_FDFMTBEG       TARGET_IO(2, 0x47)
+#define TARGET_FDFMTTRK      TARGET_IOW(2, 0x48, struct format_descr)
+#define TARGET_FDFMTEND       TARGET_IO(2, 0x49)
 #define TARGET_FDSETEMSGTRESH TARGET_IO(2, 0x4a)
 #define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
 #define TARGET_FDSETMAXERRS  TARGET_IOW(2, 0x4c, struct floppy_max_errors)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index e4e0429637c5..8ff78a625ace 100644
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
 STRUCT(floppy_max_errors,
        TYPE_INT, /* abort */
        TYPE_INT, /* read_track */
-- 
2.24.1


