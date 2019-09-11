Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104CCECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32C0222BF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32C0222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7weV-0003Bc-Qd
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wRl-00069j-3S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wRk-0004RB-0j
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:44 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50691)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wRj-0004QV-P7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:43 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N0nvJ-1iMQzG3xrh-00wiMo; Wed, 11 Sep 2019 08:49:32 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 08:49:17 +0200
Message-Id: <20190911064920.1718-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911064920.1718-1-laurent@vivier.eu>
References: <20190911064920.1718-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rejogtgCx6V7rSfrGTma3x3K2crDjMlarfafrH3wIPBHhMkOCtT
 8SYw0Y929haq8seefGuywKLADFmW6kayfKZVT4291+LP9X/igg0MKGjW6eX+HLe8fgRO9M+
 MefTjk1ikpTdXbhvDT6x2lUgm4nH7Fsasokg4VXoZYpcVIzJ7jfolgv8kQTRnBEvVl5aVcx
 smsbI3WZDUOiW+Qfq+usA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D32bDUqB9lw=:0xq7qxp+a7oc7KV54q2nEH
 z4YLalHDVuhmtfbz/uJsvrpz6sTPIIqVKeyCEVvoFk3o56PadvCnItIuSyW6DzzTWSMAOFfkl
 u2s9z/LWHjoFPJPp2dW8MVLAQ9KUF58kZj5btT5mW2wost5q5Lbq/0mmTZ1JI/VD6bZPm0igo
 YEa2EI5AJ+zyguhcfomYPN6vBx0ODSE/+VI8IZLhJrxzYnUl8O+w8Ctx1XXTvZtQVgCA5TcOL
 koq0JSpmxJrO+SBHeBMm0W9+SNhp5DvDrFK+CRVy7vbZhF6PwN35PtUNnoQleXG1I3fJGOHeW
 nUYiJL6vwL1WWlN2BVcbiI0E79FRzw19sXLHEdNNmGYXwO4OQHCxaRjS4xSjYdu95/yhwqDZN
 L/Xq/KNap1mBLlxjDGRCPA7AOv7ELFnIjEQ+YZaxN6RLfKoCIj9YvKOIQAL0WkYhC2jm5DoMb
 xB8OzVQKFVNH9z0nNjecdMAZ5iuFmp9OFSjPIE8pht7R9jLtidf7bz9T0bIpDlhR1rxhZyuHY
 ioVhV/yLgCjR/4P+syC3bQ0lTPVABvx61gI8UpbOP+I/PYT6nAC+xLsNUKIvwbTXDiVNliuIk
 gVM/5V2b/UuJO3IQRDnC+cxfLvu+SlIXxpup83Xlosi32cpGlZVfB+jPOB+Y6vOIJn5TA/yzQ
 PMe+HrnHaGREXXe4aibUL5MfpJ0KAhniTQkSdS/p7376LqMQbVD0mNDZfFjbacoAthh3WW3Ol
 RgDpc4dkMoM1wQClitiFbqOl64jY2vdovnbxfO9cfVQBx7fDtni4Pt+pgLrNRK7M3a6WWaNog
 aBtAOsSHJRUtZJDyb0hEgSJ8+mMDoJ9QLXHZhrlW0qckTnFiv0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL v2 12/15] linux-user: Add support for FIOGETOWN
 and FIOSETOWN ioctls
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

FIOGETOWN and FIOSETOWN ioctls have platform-specific definitions,
hence non-standard definition in QEMU too.

Other than that, they both have a single integer argument, and their
functionality is emulated in a straightforward way.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1567601968-26946-4-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index cd9b6f9a8d45..1830de96e12b 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -177,6 +177,8 @@
 #endif
 #endif /* CONFIG_USBFS */
 
+  IOCTL(FIOGETOWN, IOC_R, MK_PTR(TYPE_INT))
+  IOCTL(FIOSETOWN, IOC_W, MK_PTR(TYPE_INT))
   IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
   IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 19a1d39cbc82..498223b77787 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -758,10 +758,14 @@ struct target_pollfd {
 
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
        defined(TARGET_XTENSA)
+#define TARGET_FIOGETOWN       TARGET_IOR('f', 123, int)
+#define TARGET_FIOSETOWN       TARGET_IOW('f', 124, int)
 #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
 #define TARGET_SIOCSPGRP       TARGET_IOW('s', 8, pid_t)
 #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
 #else
+#define TARGET_FIOGETOWN       0x8903
+#define TARGET_FIOSETOWN       0x8901
 #define TARGET_SIOCATMARK      0x8905
 #define TARGET_SIOCSPGRP       0x8902
 #define TARGET_SIOCGPGRP       0x8904
-- 
2.21.0


