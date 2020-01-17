Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7AEC33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 02:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1BF20748
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 02:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1BF20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isHBd-0003bv-IT
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 21:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1isH7S-0006nZ-Ly
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 21:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1isH7Q-0003H7-8a
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 21:12:18 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:35007 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1isH7P-0003Dl-QP
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 21:12:16 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 1AC301A2047;
 Fri, 17 Jan 2020 03:12:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id D30A91A207E;
 Fri, 17 Jan 2020 03:12:11 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] linux-user: Fix some constants in remaining termbits.h
Date: Fri, 17 Jan 2020 03:11:57 +0100
Message-Id: <1579227117-6310-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579227117-6310-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1579227117-6310-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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

Some constants were defined in terms of host, instead of target,
as they should be.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/aarch64/termbits.h    |  4 ++--
 linux-user/arm/termbits.h        |  4 ++--
 linux-user/cris/termbits.h       |  4 ++--
 linux-user/hppa/termbits.h       |  4 ++--
 linux-user/i386/termbits.h       |  4 ++--
 linux-user/m68k/termbits.h       |  4 ++--
 linux-user/microblaze/termbits.h |  4 ++--
 linux-user/nios2/termbits.h      |  4 ++--
 linux-user/openrisc/termbits.h   | 14 +++++++-------
 linux-user/ppc/termbits.h        |  4 ++--
 linux-user/riscv/termbits.h      |  4 ++--
 linux-user/s390x/termbits.h      | 26 +++++++++++++++-----------
 linux-user/sh4/termbits.h        |  4 ++--
 linux-user/sparc/termbits.h      |  4 ++--
 linux-user/sparc64/termbits.h    |  4 ++--
 linux-user/tilegx/termbits.h     | 12 ++++++++----
 linux-user/x86_64/termbits.h     | 26 +++++++++++++++++++-------
 17 files changed, 75 insertions(+), 55 deletions(-)

diff --git a/linux-user/aarch64/termbits.h b/linux-user/aarch64/termbits.h
index 0ab448d..998fc1d 100644
--- a/linux-user/aarch64/termbits.h
+++ b/linux-user/aarch64/termbits.h
@@ -83,8 +83,8 @@ struct target_termios {
 #define  TARGET_B9600  0000015
 #define  TARGET_B19200 0000016
 #define  TARGET_B38400 0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA    TARGET_B19200
+#define TARGET_EXTB    TARGET_B38400
 #define TARGET_CSIZE   0000060
 #define   TARGET_CS5   0000000
 #define   TARGET_CS6   0000020
diff --git a/linux-user/arm/termbits.h b/linux-user/arm/termbits.h
index e555cff..7170b8a 100644
--- a/linux-user/arm/termbits.h
+++ b/linux-user/arm/termbits.h
@@ -83,8 +83,8 @@ struct target_termios {
 #define  TARGET_B9600  0000015
 #define  TARGET_B19200 0000016
 #define  TARGET_B38400 0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA    TARGET_B19200
+#define TARGET_EXTB    TARGET_B38400
 #define TARGET_CSIZE   0000060
 #define   TARGET_CS5   0000000
 #define   TARGET_CS6   0000020
diff --git a/linux-user/cris/termbits.h b/linux-user/cris/termbits.h
index 475ee70..76d5ed0 100644
--- a/linux-user/cris/termbits.h
+++ b/linux-user/cris/termbits.h
@@ -81,8 +81,8 @@ struct target_termios {
 #define  TARGET_B9600  0000015
 #define  TARGET_B19200 0000016
 #define  TARGET_B38400 0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA    TARGET_B19200
+#define TARGET_EXTB    TARGET_B38400
 #define TARGET_CSIZE   0000060
 #define   TARGET_CS5   0000000
 #define   TARGET_CS6   0000020
diff --git a/linux-user/hppa/termbits.h b/linux-user/hppa/termbits.h
index 8fba839..3094710 100644
--- a/linux-user/hppa/termbits.h
+++ b/linux-user/hppa/termbits.h
@@ -82,8 +82,8 @@ struct target_termios {
 #define  TARGET_B9600  0000015
 #define  TARGET_B19200 0000016
 #define  TARGET_B38400 0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA    TARGET_B19200
+#define TARGET_EXTB    TARGET_B38400
 #define TARGET_CSIZE   0000060
 #define   TARGET_CS5   0000000
 #define   TARGET_CS6   0000020
diff --git a/linux-user/i386/termbits.h b/linux-user/i386/termbits.h
index 88264bb..3b16977 100644
--- a/linux-user/i386/termbits.h
+++ b/linux-user/i386/termbits.h
@@ -82,8 +82,8 @@ struct target_termios {
 #define  TARGET_B9600  0000015
 #define  TARGET_B19200 0000016
 #define  TARGET_B38400 0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA    TARGET_B19200
+#define TARGET_EXTB    TARGET_B38400
 #define TARGET_CSIZE   0000060
 #define   TARGET_CS5   0000000
 #define   TARGET_CS6   0000020
diff --git a/linux-user/m68k/termbits.h b/linux-user/m68k/termbits.h
index 23840aa..f3ae025 100644
--- a/linux-user/m68k/termbits.h
+++ b/linux-user/m68k/termbits.h
@@ -83,8 +83,8 @@ struct target_termios {
 #define  TARGET_B9600  0000015
 #define  TARGET_B19200 0000016
 #define  TARGET_B38400 0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA    TARGET_B19200
+#define TARGET_EXTB    TARGET_B38400
 #define TARGET_CSIZE   0000060
 #define   TARGET_CS5   0000000
 #define   TARGET_CS6   0000020
diff --git a/linux-user/microblaze/termbits.h b/linux-user/microblaze/termbits.h
index 17db8a4..7697736 100644
--- a/linux-user/microblaze/termbits.h
+++ b/linux-user/microblaze/termbits.h
@@ -81,8 +81,8 @@ struct target_termios {
 #define  TARGET_B9600  0000015
 #define  TARGET_B19200 0000016
 #define  TARGET_B38400 0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA    TARGET_B19200
+#define TARGET_EXTB    TARGET_B38400
 #define TARGET_CSIZE   0000060
 #define   TARGET_CS5   0000000
 #define   TARGET_CS6   0000020
diff --git a/linux-user/nios2/termbits.h b/linux-user/nios2/termbits.h
index 425a2fe..269ab59 100644
--- a/linux-user/nios2/termbits.h
+++ b/linux-user/nios2/termbits.h
@@ -83,8 +83,8 @@ struct target_termios {
 #define  TARGET_B9600  0000015
 #define  TARGET_B19200 0000016
 #define  TARGET_B38400 0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA    TARGET_B19200
+#define TARGET_EXTB    TARGET_B38400
 #define TARGET_CSIZE   0000060
 #define   TARGET_CS5   0000000
 #define   TARGET_CS6   0000020
diff --git a/linux-user/openrisc/termbits.h b/linux-user/openrisc/termbits.h
index 7a635ff..35f7b26 100644
--- a/linux-user/openrisc/termbits.h
+++ b/linux-user/openrisc/termbits.h
@@ -124,8 +124,8 @@ struct target_termios3 {
 #define TARGET_B9600    0000015
 #define TARGET_B19200   0000016
 #define TARGET_B38400   0000017
-#define TARGET_EXTA     B19200
-#define TARGET_EXTB     B38400
+#define TARGET_EXTA     TARGET_B19200
+#define TARGET_EXTB     TARGET_B38400
 #define TARGET_CSIZE    0000060
 #define TARGET_CS5      0000000
 #define TARGET_CS6      0000020
@@ -222,7 +222,7 @@ struct target_termios3 {
 #define TARGET_TIOCGSOFTCAR    0x5419
 #define TARGET_TIOCSSOFTCAR    0x541A
 #define TARGET_FIONREAD        0x541B
-#define TARGET_TIOCINQ         FIONREAD
+#define TARGET_TIOCINQ         TARGET_FIONREAD
 #define TARGET_TIOCLINUX       0x541C
 #define TARGET_TIOCCONS        0x541D
 #define TARGET_TIOCGSERIAL     0x541E
@@ -236,10 +236,10 @@ struct target_termios3 {
 #define TARGET_TIOCSBRK        0x5427  /* BSD compatibility */
 #define TARGET_TIOCCBRK        0x5428  /* BSD compatibility */
 #define TARGET_TIOCGSID        0x5429  /* Return the session ID of FD */
-#define TARGET_TCGETS2         TARGET_IOR('T', 0x2A, struct termios2)
-#define TARGET_TCSETS2         TARGET_IOW('T', 0x2B, struct termios2)
-#define TARGET_TCSETSW2        TARGET_IOW('T', 0x2C, struct termios2)
-#define TARGET_TCSETSF2        TARGET_IOW('T', 0x2D, struct termios2)
+#define TARGET_TCGETS2         TARGET_IOR('T', 0x2A, struct target_termios2)
+#define TARGET_TCSETS2         TARGET_IOW('T', 0x2B, struct target_termios2)
+#define TARGET_TCSETSW2        TARGET_IOW('T', 0x2C, struct target_termios2)
+#define TARGET_TCSETSF2        TARGET_IOW('T', 0x2D, struct target_termios2)
 #define TARGET_TIOCGRS485      0x542E
 #ifndef TARGET_TIOCSRS485
 #define TARGET_TIOCSRS485      0x542F
diff --git a/linux-user/ppc/termbits.h b/linux-user/ppc/termbits.h
index 19e4c6e..66bb76c 100644
--- a/linux-user/ppc/termbits.h
+++ b/linux-user/ppc/termbits.h
@@ -107,8 +107,8 @@ struct target_termios {
 #define  TARGET_B9600	0000015
 #define  TARGET_B19200	0000016
 #define  TARGET_B38400	0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA     TARGET_B19200
+#define TARGET_EXTB     TARGET_B38400
 #define TARGET_CBAUDEX 0000000
 #define  TARGET_B57600   00020
 #define  TARGET_B115200  00021
diff --git a/linux-user/riscv/termbits.h b/linux-user/riscv/termbits.h
index 5e0af0d..778de0c 100644
--- a/linux-user/riscv/termbits.h
+++ b/linux-user/riscv/termbits.h
@@ -83,8 +83,8 @@ struct target_termios {
 #define  TARGET_B9600  0000015
 #define  TARGET_B19200 0000016
 #define  TARGET_B38400 0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA    TARGET_B19200
+#define TARGET_EXTB    TARGET_B38400
 #define TARGET_CSIZE   0000060
 #define   TARGET_CS5   0000000
 #define   TARGET_CS6   0000020
diff --git a/linux-user/s390x/termbits.h b/linux-user/s390x/termbits.h
index 9affa8f..140f684 100644
--- a/linux-user/s390x/termbits.h
+++ b/linux-user/s390x/termbits.h
@@ -128,8 +128,8 @@ struct target_ktermios {
 #define TARGET_B9600	0000015
 #define TARGET_B19200	0000016
 #define TARGET_B38400	0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA     TARGET_B19200
+#define TARGET_EXTB     TARGET_B38400
 #define TARGET_CSIZE	0000060
 #define TARGET_CS5	0000000
 #define TARGET_CS6	0000020
@@ -234,7 +234,7 @@ struct target_ktermios {
 #define TARGET_TIOCGSOFTCAR	0x5419
 #define TARGET_TIOCSSOFTCAR	0x541A
 #define TARGET_FIONREAD	0x541B
-#define TARGET_TIOCINQ		FIONREAD
+#define TARGET_TIOCINQ      TARGET_FIONREAD
 #define TARGET_TIOCLINUX	0x541C
 #define TARGET_TIOCCONS	0x541D
 #define TARGET_TIOCGSERIAL	0x541E
@@ -248,14 +248,18 @@ struct target_ktermios {
 #define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
 #define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
 #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
-#define TARGET_TCGETS2		_IOR('T',0x2A, struct termios2)
-#define TARGET_TCSETS2		_IOW('T',0x2B, struct termios2)
-#define TARGET_TCSETSW2	_IOW('T',0x2C, struct termios2)
-#define TARGET_TCSETSF2	_IOW('T',0x2D, struct termios2)
-#define TARGET_TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
-#define TARGET_TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
-#define TARGET_TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
-#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
+#define TARGET_TCGETS2          TARGET_IOR('T', 0x2A, struct target_termios2)
+#define TARGET_TCSETS2          TARGET_IOW('T', 0x2B, struct target_termios2)
+#define TARGET_TCSETSW2         TARGET_IOW('T', 0x2C, struct target_termios2)
+#define TARGET_TCSETSF2         TARGET_IOW('T', 0x2D, struct target_termios2)
+/* Get Pty Number (of pty-mux device) */
+#define TARGET_TIOCGPTN         TARGET_IOR('T', 0x30, unsigned int)
+/* Lock/unlock Pty */
+#define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
+/* Get real dev no below /dev/console */
+#define TARGET_TIOCGDEV         TARGET_IOR('T', 0x32, unsigned int)
+/* Safely open the slave */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41)
 
 #define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define TARGET_FIOCLEX		0x5451
diff --git a/linux-user/sh4/termbits.h b/linux-user/sh4/termbits.h
index dd125b6..89a124d 100644
--- a/linux-user/sh4/termbits.h
+++ b/linux-user/sh4/termbits.h
@@ -101,8 +101,8 @@ struct target_termios {
 #define TARGET_B9600	0000015
 #define TARGET_B19200	0000016
 #define TARGET_B38400	0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA     TARGET_B19200
+#define TARGET_EXTB     TARGET_B38400
 #define TARGET_CSIZE	0000060
 #define TARGET_CS5	0000000
 #define TARGET_CS6	0000020
diff --git a/linux-user/sparc/termbits.h b/linux-user/sparc/termbits.h
index f85219e..e38e53e 100644
--- a/linux-user/sparc/termbits.h
+++ b/linux-user/sparc/termbits.h
@@ -109,8 +109,8 @@ struct target_termios {
 #define  TARGET_B9600	  0x0000000d
 #define  TARGET_B19200	  0x0000000e
 #define  TARGET_B38400	  0x0000000f
-#define TARGET_EXTA      B19200
-#define TARGET_EXTB      B38400
+#define TARGET_EXTA      TARGET_B19200
+#define TARGET_EXTB      TARGET_B38400
 #define  TARGET_CSIZE    0x00000030
 #define   TARGET_CS5	  0x00000000
 #define   TARGET_CS6	  0x00000010
diff --git a/linux-user/sparc64/termbits.h b/linux-user/sparc64/termbits.h
index 11b5abc..c86f714 100644
--- a/linux-user/sparc64/termbits.h
+++ b/linux-user/sparc64/termbits.h
@@ -109,8 +109,8 @@ struct target_termios {
 #define  TARGET_B9600	  0x0000000d
 #define  TARGET_B19200	  0x0000000e
 #define  TARGET_B38400	  0x0000000f
-#define TARGET_EXTA      B19200
-#define TARGET_EXTB      B38400
+#define TARGET_EXTA       TARGET_B19200
+#define TARGET_EXTB       TARGET_B38400
 #define  TARGET_CSIZE    0x00000030
 #define   TARGET_CS5	  0x00000000
 #define   TARGET_CS6	  0x00000010
diff --git a/linux-user/tilegx/termbits.h b/linux-user/tilegx/termbits.h
index 966daec..75f78d7 100644
--- a/linux-user/tilegx/termbits.h
+++ b/linux-user/tilegx/termbits.h
@@ -224,10 +224,14 @@ struct target_termios2 {
 #define TARGET_TIOCSBRK                 0x5427
 #define TARGET_TIOCCBRK                 0x5428
 #define TARGET_TIOCGSID                 0x5429
-#define TARGET_TCGETS2                  TARGET_IOR('T', 0x2A, struct termios2)
-#define TARGET_TCSETS2                  TARGET_IOW('T', 0x2B, struct termios2)
-#define TARGET_TCSETSW2                 TARGET_IOW('T', 0x2C, struct termios2)
-#define TARGET_TCSETSF2                 TARGET_IOW('T', 0x2D, struct termios2)
+#define TARGET_TCGETS2                  TARGET_IOR('T', 0x2A,                  \
+                                                   struct target_termios2)
+#define TARGET_TCSETS2                  TARGET_IOW('T', 0x2B,                  \
+                                                   struct target_termios2)
+#define TARGET_TCSETSW2                 TARGET_IOW('T', 0x2C,                  \
+                                                   struct target_termios2)
+#define TARGET_TCSETSF2                 TARGET_IOW('T', 0x2D,                  \
+                                                   struct target_termios2)
 #define TARGET_TIOCGRS485               0x542E
 #define TARGET_TIOCSRS485               0x542F
 #define TARGET_TIOCGPTN                 TARGET_IOR('T', 0x30, unsigned int)
diff --git a/linux-user/x86_64/termbits.h b/linux-user/x86_64/termbits.h
index c8bb599..25d9d5d 100644
--- a/linux-user/x86_64/termbits.h
+++ b/linux-user/x86_64/termbits.h
@@ -6,6 +6,7 @@
 typedef unsigned char	target_cc_t;
 typedef unsigned int	target_speed_t;
 typedef unsigned int	target_tcflag_t;
+
 struct target_termios {
 	target_tcflag_t c_iflag;		/* input mode flags */
 	target_tcflag_t c_oflag;		/* output mode flags */
@@ -15,6 +16,17 @@ struct target_termios {
 	target_cc_t c_cc[TARGET_NCCS];		/* control characters */
 };
 
+struct target_termios2 {
+    target_tcflag_t c_iflag;            /* input mode flags */
+    target_tcflag_t c_oflag;            /* output mode flags */
+    target_tcflag_t c_cflag;            /* control mode flags */
+    target_tcflag_t c_lflag;            /* local mode flags */
+    target_cc_t c_line;                 /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];      /* control characters */
+    target_speed_t c_ispeed;            /* input speed */
+    target_speed_t c_ospeed;            /* output speed */
+};
+
 /* c_cc characters */
 #define TARGET_VINTR 0
 #define TARGET_VQUIT 1
@@ -102,8 +114,8 @@ struct target_termios {
 #define  TARGET_B9600	0000015
 #define  TARGET_B19200	0000016
 #define  TARGET_B38400	0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA     TARGET_B19200
+#define TARGET_EXTB     TARGET_B38400
 #define TARGET_CSIZE	0000060
 #define   TARGET_CS5	0000000
 #define   TARGET_CS6	0000020
@@ -198,7 +210,7 @@ struct target_termios {
 #define TARGET_TIOCGSOFTCAR	0x5419
 #define TARGET_TIOCSSOFTCAR	0x541A
 #define TARGET_FIONREAD	0x541B
-#define TARGET_TIOCINQ		FIONREAD
+#define TARGET_TIOCINQ          TARGET_FIONREAD
 #define TARGET_TIOCLINUX	0x541C
 #define TARGET_TIOCCONS	0x541D
 #define TARGET_TIOCGSERIAL	0x541E
@@ -212,10 +224,10 @@ struct target_termios {
 #define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
 #define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
 #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
-#define TARGET_TCGETS2          TARGET_IOR('T',0x2A, struct termios2)
-#define TARGET_TCSETS2          TARGET_IOW('T',0x2B, struct termios2)
-#define TARGET_TCSETSW2         TARGET_IOW('T',0x2C, struct termios2)
-#define TARGET_TCSETSF2         TARGET_IOW('T',0x2D, struct termios2)
+#define TARGET_TCGETS2          TARGET_IOR('T', 0x2A, struct target_termios2)
+#define TARGET_TCSETS2          TARGET_IOW('T', 0x2B, struct target_termios2)
+#define TARGET_TCSETSW2         TARGET_IOW('T', 0x2C, struct target_termios2)
+#define TARGET_TCSETSF2         TARGET_IOW('T', 0x2D, struct target_termios2)
 #define TARGET_TIOCGPTN         TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK       TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
 #define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
-- 
2.7.4


