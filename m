Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772F9C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D013206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D013206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToya-0005S6-Hd
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:45:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowv-0004DH-0r
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTowt-0006Cm-Sk
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:04 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49787)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTowt-0006BX-Jk
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:44:03 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1N3suW-1gU7aR2VpQ-00zrVE; Thu, 23 May 2019 16:43:43 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:43:30 +0200
Message-Id: <20190523144336.13960-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523144336.13960-1-laurent@vivier.eu>
References: <20190523144336.13960-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fosqzI4IKyonWFKlDIrgHOJTQ95xdYWKrVKC8/cU5/xi+q9tDbb
	u8Yfz02StRE9/5LpiJVzOcVnlmEfUIlwgW5XP2UdxxCnCWQkalT9o1rwWm23TygbGc2xuC9
	u//TDzzwsp2nLioxm7Mew9Bugtmy9uAThw5ARlPo4Xfy/Q+Sjcj0m06zA+2ACvyI6MW6KED
	PHHZcDwHjL8Ut8O5Px0tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n/TbAKfjseM=:ifwigjrhCyYJrEMH3pvAYf
	+dXJ2c/8WPWZjM6LjxMOscOyxkcFL2ev5Wd10EJAdx1deIEHRgpNn8n79fPHZ/6mZoPGg8wLh
	OupJyLskfwTcoXTH+lSgsQrrGmEWzTMwQIFMBZa6vyGWE1hvu2NVWRr2tIofV8qXyjBtLdH8Z
	RvqguVi1xmPShYC/I6xVsNo8Y89NSacU8UiMfbx2SPWQCMfcnWz/jZNo7FKQ5K3dbdvoDjNXc
	wv5OQoL1je6M5EJLqeKM2Mp2F0ts+3fTodJb/7DpgJZji9RJxR3kraenOpjNv2Ooiw3icQLas
	xyAKNkQgajsJ2ZBvkmOuxRxr3hhDsLDHK74rtOnUejazD4nLVgN4/tWKU6QeTttusKbYJ040+
	K/3EI9C7Dh4TnvUl9VRzn4V06VawB8bjNVZ0GqfywV2SeAj0k9e9aqkwgemNpsh2syZtAqGqC
	RULGgqOyPa/GyjesEHRkcTNPw6FrVswrSoHPmZi9RnC521/Bi+NpZOQYxHsXTIlbImaTWmxbF
	fCh+TQMbfKEB0OVKCs6atLm95aQXI1yDF/JRFXeubQ5dbsmg8vWzokR9lSB5ftlud5AXD5WT3
	NpKjTeWUpzvXyNm9QpG4M8cSx4Qhn1MS5UqU/b9LECx3MFJWkC94h6tT6td8krxidak7xXlqZ
	HgmW/u3xUtsbqTo/li8MnYvYdyGWgSTx/0IybvvT7xdBmukcWmMFEBrt39WGHsW61mC1RuhFh
	JNxRW226uOcqynpo2HujTCHA1DClnmMhkQz9bg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL 04/10] linux-user: Add support for SIOCSPGRP
 ioctl for all targets
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add support for setting the process (or process group) to receive SIGIO
or SIGURG signals when I/O becomes possible or urgent data is available,
using SIOCSPGRP ioctl.

The ioctl numeric values for SIOCSPGRP are platform-dependent and are
determined by following files in Linux kernel source tree:

arch/ia64/include/uapi/asm/sockios.h:#define SIOCSPGRP    0x8902
arch/mips/include/uapi/asm/sockios.h:#define SIOCSPGRP    _IOW('s', 8, pid_t)
arch/parisc/include/uapi/asm/sockios.h:#define SIOCSPGRP  0x8902
arch/sh/include/uapi/asm/sockios.h:#define SIOCSPGRP      _IOW('s', 8, pid_t)
arch/xtensa/include/uapi/asm/sockios.h:#define SIOCSPGRP  _IOW('s', 8, pid_t)
arch/alpha/include/uapi/asm/sockios.h:#define SIOCSPGRP   _IOW('s', 8, pid_t)
arch/sparc/include/uapi/asm/sockios.h:#define SIOCSPGRP   0x8902
include/uapi/asm-generic/sockios.h:#define SIOCSPGRP      0x8902

Hence the different definition for alpha, mips, sh4, and xtensa.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1558282527-22183-3-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 1 +
 linux-user/syscall_defs.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 37501f575cdd..99ed9d982568 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -218,6 +218,7 @@
   IOCTL(SIOCSRARP, IOC_W, MK_PTR(MK_STRUCT(STRUCT_arpreq)))
   IOCTL(SIOCGRARP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_arpreq)))
   IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_ifreq)))
+  IOCTL(SIOCSPGRP, IOC_W, MK_PTR(TYPE_INT)) /* pid_t */
   IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
   IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
   IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 5b530e04b8fd..9470a5ce965b 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -740,11 +740,14 @@ struct target_pollfd {
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
        defined(TARGET_XTENSA)
 #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
+#define TARGET_SIOCSPGRP       TARGET_IOW('s', 8, pid_t)
 #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
 #else
 #define TARGET_SIOCATMARK      0x8905
+#define TARGET_SIOCSPGRP       0x8902
 #define TARGET_SIOCGPGRP       0x8904
 #endif
+
 #define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timeval) */
 #define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (timespec) */
 
-- 
2.20.1


