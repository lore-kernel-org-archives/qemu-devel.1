Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA770C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 20:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8084C2468B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 20:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8084C2468B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir6Xw-0002ta-R0
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 15:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ir6Rb-0001kE-AU
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:36:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ir6RX-0004mW-Vj
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:36:14 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:44013 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1ir6RX-0003f9-HM
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 15:36:11 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 673031A1FB3;
 Mon, 13 Jan 2020 21:35:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 423191A1E5E;
 Mon, 13 Jan 2020 21:35:08 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/20] linux-user: Fix some constants in termbits.h
Date: Mon, 13 Jan 2020 21:34:24 +0100
Message-Id: <1578947683-21011-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
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

Some additional trivial changes in this patch were forced by
checkpatch.pl.

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/aarch64/termbits.h    |   4 +-
 linux-user/alpha/termbits.h      |  10 +--
 linux-user/arm/termbits.h        |   4 +-
 linux-user/cris/termbits.h       |   4 +-
 linux-user/hppa/termbits.h       |   4 +-
 linux-user/i386/termbits.h       |   4 +-
 linux-user/m68k/termbits.h       |   4 +-
 linux-user/microblaze/termbits.h |   4 +-
 linux-user/mips/termbits.h       |   4 +-
 linux-user/nios2/termbits.h      |   4 +-
 linux-user/openrisc/termbits.h   |   6 +-
 linux-user/ppc/termbits.h        |   4 +-
 linux-user/riscv/termbits.h      |   4 +-
 linux-user/s390x/termbits.h      |  26 ++++---
 linux-user/sh4/termbits.h        |   4 +-
 linux-user/sparc/termbits.h      |   4 +-
 linux-user/sparc64/termbits.h    |   4 +-
 linux-user/x86_64/termbits.h     |   6 +-
 linux-user/xtensa/termbits.h     | 156 ++++++++++++++++++++++-----------------
 19 files changed, 141 insertions(+), 119 deletions(-)

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
diff --git a/linux-user/alpha/termbits.h b/linux-user/alpha/termbits.h
index a714251..ace19be 100644
--- a/linux-user/alpha/termbits.h
+++ b/linux-user/alpha/termbits.h
@@ -108,8 +108,8 @@ struct target_termios {
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
@@ -165,7 +165,7 @@ struct target_termios {
 #define TARGET_FIOASYNC	TARGET_IOW('f', 125, int)
 #define TARGET_FIONBIO		TARGET_IOW('f', 126, int)
 #define TARGET_FIONREAD	TARGET_IOR('f', 127, int)
-#define TARGET_TIOCINQ		FIONREAD
+#define TARGET_TIOCINQ  TARGET_FIONREAD
 #define TARGET_FIOQSIZE	TARGET_IOR('f', 128, loff_t)
 
 #define TARGET_TIOCGETP	TARGET_IOR('t', 8, struct target_sgttyb)
@@ -217,8 +217,8 @@ struct target_termios {
 # define TARGET_TIOCM_CAR	0x040
 # define TARGET_TIOCM_RNG	0x080
 # define TARGET_TIOCM_DSR	0x100
-# define TARGET_TIOCM_CD	TIOCM_CAR
-# define TARGET_TIOCM_RI	TIOCM_RNG
+# define TARGET_TIOCM_CD        TARGET_TIOCM_CAR
+# define TARGET_TIOCM_RI        TARGET_TIOCM_RNG
 # define TARGET_TIOCM_OUT1	0x2000
 # define TARGET_TIOCM_OUT2	0x4000
 # define TARGET_TIOCM_LOOP	0x8000
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
diff --git a/linux-user/mips/termbits.h b/linux-user/mips/termbits.h
index 3287cf6..3419a49 100644
--- a/linux-user/mips/termbits.h
+++ b/linux-user/mips/termbits.h
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
index 7a635ff..220742e 100644
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
index 9affa8f..79a71c2 100644
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
+#define TARGET_TCGETS2          TARGET_IOR('T', 0x2A, struct termios2)
+#define TARGET_TCSETS2          TARGET_IOW('T', 0x2B, struct termios2)
+#define TARGET_TCSETSW2         TARGET_IOW('T', 0x2C, struct termios2)
+#define TARGET_TCSETSF2         TARGET_IOW('T', 0x2D, struct termios2)
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
diff --git a/linux-user/x86_64/termbits.h b/linux-user/x86_64/termbits.h
index c8bb599..efd35ae 100644
--- a/linux-user/x86_64/termbits.h
+++ b/linux-user/x86_64/termbits.h
@@ -102,8 +102,8 @@ struct target_termios {
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
@@ -198,7 +198,7 @@ struct target_termios {
 #define TARGET_TIOCGSOFTCAR	0x5419
 #define TARGET_TIOCSSOFTCAR	0x541A
 #define TARGET_FIONREAD	0x541B
-#define TARGET_TIOCINQ		FIONREAD
+#define TARGET_TIOCINQ          TARGET_FIONREAD
 #define TARGET_TIOCLINUX	0x541C
 #define TARGET_TIOCCONS	0x541D
 #define TARGET_TIOCGSERIAL	0x541E
diff --git a/linux-user/xtensa/termbits.h b/linux-user/xtensa/termbits.h
index d1e09e6..d92fe9c 100644
--- a/linux-user/xtensa/termbits.h
+++ b/linux-user/xtensa/termbits.h
@@ -142,8 +142,8 @@ struct target_ktermios {
 #define  TARGET_B9600   0000015
 #define  TARGET_B19200  0000016
 #define  TARGET_B38400  0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA     TARGET_B19200
+#define TARGET_EXTB     TARGET_B38400
 #define TARGET_CSIZE    0000060
 #define   TARGET_CS5    0000000
 #define   TARGET_CS6    0000020
@@ -217,13 +217,13 @@ struct target_ktermios {
 
 /* from arch/xtensa/include/uapi/asm/ioctls.h */
 
-#define TARGET_FIOCLEX     _IO('f', 1)
-#define TARGET_FIONCLEX    _IO('f', 2)
-#define TARGET_FIOASYNC    _IOW('f', 125, int)
-#define TARGET_FIONBIO     _IOW('f', 126, int)
-#define TARGET_FIONREAD    _IOR('f', 127, int)
-#define TARGET_TIOCINQ     FIONREAD
-#define TARGET_FIOQSIZE    _IOR('f', 128, loff_t)
+#define TARGET_FIOCLEX     TARGET_IO('f', 1)
+#define TARGET_FIONCLEX    TARGET_IO('f', 2)
+#define TARGET_FIOASYNC    TARGET_IOW('f', 125, int)
+#define TARGET_FIONBIO     TARGET_IOW('f', 126, int)
+#define TARGET_FIONREAD    TARGET_IOR('f', 127, int)
+#define TARGET_TIOCINQ     TARGET_FIONREAD
+#define TARGET_FIOQSIZE    TARGET_IOR('f', 128, loff_t)
 
 #define TARGET_TCGETS      0x5401
 #define TARGET_TCSETS      0x5402
@@ -235,28 +235,28 @@ struct target_ktermios {
 #define TARGET_TCSETAW     0x40127419  /* _IOW('t', 25, struct termio) */
 #define TARGET_TCSETAF     0x4012741C  /* _IOW('t', 28, struct termio) */
 
-#define TARGET_TCSBRK      _IO('t', 29)
-#define TARGET_TCXONC      _IO('t', 30)
-#define TARGET_TCFLSH      _IO('t', 31)
+#define TARGET_TCSBRK      TARGET_IO('t', 29)
+#define TARGET_TCXONC      TARGET_IO('t', 30)
+#define TARGET_TCFLSH      TARGET_IO('t', 31)
 
 #define TARGET_TIOCSWINSZ  0x40087467  /* _IOW('t', 103, struct winsize) */
 #define TARGET_TIOCGWINSZ  0x80087468  /* _IOR('t', 104, struct winsize) */
-#define TARGET_TIOCSTART   _IO('t', 110)       /* start output, like ^Q */
-#define TARGET_TIOCSTOP    _IO('t', 111)       /* stop output, like ^S */
-#define TARGET_TIOCOUTQ        _IOR('t', 115, int)     /* output queue size */
-
-#define TARGET_TIOCSPGRP   _IOW('t', 118, int)
-#define TARGET_TIOCGPGRP   _IOR('t', 119, int)
-
-#define TARGET_TIOCEXCL    _IO('T', 12)
-#define TARGET_TIOCNXCL    _IO('T', 13)
-#define TARGET_TIOCSCTTY   _IO('T', 14)
-
-#define TARGET_TIOCSTI     _IOW('T', 18, char)
-#define TARGET_TIOCMGET    _IOR('T', 21, unsigned int)
-#define TARGET_TIOCMBIS    _IOW('T', 22, unsigned int)
-#define TARGET_TIOCMBIC    _IOW('T', 23, unsigned int)
-#define TARGET_TIOCMSET    _IOW('T', 24, unsigned int)
+#define TARGET_TIOCSTART   TARGET_IO('t', 110)       /* start output, like ^Q */
+#define TARGET_TIOCSTOP    TARGET_IO('t', 111)       /* stop output, like ^S */
+#define TARGET_TIOCOUTQ    TARGET_IOR('t', 115, int) /* output queue size */
+
+#define TARGET_TIOCSPGRP   TARGET_IOW('t', 118, int)
+#define TARGET_TIOCGPGRP   TARGET_IOR('t', 119, int)
+
+#define TARGET_TIOCEXCL    TARGET_IO('T', 12)
+#define TARGET_TIOCNXCL    TARGET_IO('T', 13)
+#define TARGET_TIOCSCTTY   TARGET_IO('T', 14)
+
+#define TARGET_TIOCSTI     TARGET_IOW('T', 18, char)
+#define TARGET_TIOCMGET    TARGET_IOR('T', 21, unsigned int)
+#define TARGET_TIOCMBIS    TARGET_IOW('T', 22, unsigned int)
+#define TARGET_TIOCMBIC    TARGET_IOW('T', 23, unsigned int)
+#define TARGET_TIOCMSET    TARGET_IOW('T', 24, unsigned int)
 # define TARGET_TIOCM_LE   0x001
 # define TARGET_TIOCM_DTR  0x002
 # define TARGET_TIOCM_RTS  0x004
@@ -266,16 +266,16 @@ struct target_ktermios {
 # define TARGET_TIOCM_CAR  0x040
 # define TARGET_TIOCM_RNG  0x080
 # define TARGET_TIOCM_DSR  0x100
-# define TARGET_TIOCM_CD   TIOCM_CAR
-# define TARGET_TIOCM_RI   TIOCM_RNG
+# define TARGET_TIOCM_CD   TARGET_TIOCM_CAR
+# define TARGET_TIOCM_RI   TARGET_TIOCM_RNG
 
-#define TARGET_TIOCGSOFTCAR    _IOR('T', 25, unsigned int)
-#define TARGET_TIOCSSOFTCAR    _IOW('T', 26, unsigned int)
-#define TARGET_TIOCLINUX   _IOW('T', 28, char)
-#define TARGET_TIOCCONS    _IO('T', 29)
+#define TARGET_TIOCGSOFTCAR    TARGET_IOR('T', 25, unsigned int)
+#define TARGET_TIOCSSOFTCAR    TARGET_IOW('T', 26, unsigned int)
+#define TARGET_TIOCLINUX   TARGET_IOW('T', 28, char)
+#define TARGET_TIOCCONS    TARGET_IO('T', 29)
 #define TARGET_TIOCGSERIAL 0x803C541E  /*_IOR('T', 30, struct serial_struct)*/
 #define TARGET_TIOCSSERIAL 0x403C541F  /*_IOW('T', 31, struct serial_struct)*/
-#define TARGET_TIOCPKT     _IOW('T', 32, int)
+#define TARGET_TIOCPKT     TARGET_IOW('T', 32, int)
 # define TARGET_TIOCPKT_DATA        0
 # define TARGET_TIOCPKT_FLUSHREAD   1
 # define TARGET_TIOCPKT_FLUSHWRITE  2
@@ -286,43 +286,61 @@ struct target_ktermios {
 # define TARGET_TIOCPKT_IOCTL      64
 
 
-#define TARGET_TIOCNOTTY   _IO('T', 34)
-#define TARGET_TIOCSETD    _IOW('T', 35, int)
-#define TARGET_TIOCGETD    _IOR('T', 36, int)
-#define TARGET_TCSBRKP     _IOW('T', 37, int)   /* Needed for POSIX tcsendbreak()*/
-#define TARGET_TIOCSBRK    _IO('T', 39)         /* BSD compatibility */
-#define TARGET_TIOCCBRK    _IO('T', 40)         /* BSD compatibility */
-#define TARGET_TIOCGSID    _IOR('T', 41, pid_t) /* Return the session ID of FD*/
-#define TARGET_TCGETS2     _IOR('T', 42, struct termios2)
-#define TARGET_TCSETS2     _IOW('T', 43, struct termios2)
-#define TARGET_TCSETSW2    _IOW('T', 44, struct termios2)
-#define TARGET_TCSETSF2    _IOW('T', 45, struct termios2)
-#define TARGET_TIOCGRS485  _IOR('T', 46, struct serial_rs485)
-#define TARGET_TIOCSRS485  _IOWR('T', 47, struct serial_rs485)
-#define TARGET_TIOCGPTN    _IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
-#define TARGET_TIOCSPTLCK  _IOW('T',0x31, int)  /* Lock/unlock Pty */
-#define TARGET_TIOCGDEV    _IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
-#define TARGET_TIOCSIG     _IOW('T',0x36, int)  /* Generate signal on Pty slave */
-#define TARGET_TIOCVHANGUP _IO('T', 0x37)
-#define TARGET_TIOCGPKT    _IOR('T', 0x38, int) /* Get packet mode state */
-#define TARGET_TIOCGPTLCK  _IOR('T', 0x39, int) /* Get Pty lock state */
-#define TARGET_TIOCGEXCL   _IOR('T', 0x40, int) /* Get exclusive mode state */
-#define TARGET_TIOCGPTPEER _IO('T', 0x41) /* Safely open the slave */
-
-#define TARGET_TIOCSERCONFIG   _IO('T', 83)
-#define TARGET_TIOCSERGWILD    _IOR('T', 84,  int)
-#define TARGET_TIOCSERSWILD    _IOW('T', 85,  int)
+#define TARGET_TIOCNOTTY   TARGET_IO('T', 34)
+#define TARGET_TIOCSETD    TARGET_IOW('T', 35, int)
+#define TARGET_TIOCGETD    TARGET_IOR('T', 36, int)
+/* Needed for POSIX tcsendbreak()*/
+#define TARGET_TCSBRKP     TARGET_IOW('T', 37, int)
+/* BSD compatibility */
+#define TARGET_TIOCSBRK    TARGET_IO('T', 39)
+/* BSD compatibility */
+#define TARGET_TIOCCBRK    TARGET_IO('T', 40)
+/* Return the session ID of FD*/
+#define TARGET_TIOCGSID    TARGET_IOR('T', 41, pid_t)
+#define TARGET_TCGETS2     TARGET_IOR('T', 42, struct termios2)
+#define TARGET_TCSETS2     TARGET_IOW('T', 43, struct termios2)
+#define TARGET_TCSETSW2    TARGET_IOW('T', 44, struct termios2)
+#define TARGET_TCSETSF2    TARGET_IOW('T', 45, struct termios2)
+#define TARGET_TIOCGRS485  TARGET_IOR('T', 46, struct serial_rs485)
+#define TARGET_TIOCSRS485  TARGET_IOWR('T', 47, struct serial_rs485)
+/* Get Pty Number (of pty-mux device) */
+#define TARGET_TIOCGPTN    TARGET_IOR('T', 0x30, unsigned int)
+/* Lock/unlock Pty */
+#define TARGET_TIOCSPTLCK  TARGET_IOW('T', 0x31, int)
+/* Get primary device node of /dev/console */
+#define TARGET_TIOCGDEV    TARGET_IOR('T', 0x32, unsigned int)
+/* Generate signal on Pty slave */
+#define TARGET_TIOCSIG     TARGET_IOW('T', 0x36, int)
+#define TARGET_TIOCVHANGUP TARGET_IO('T', 0x37)
+/* Get packet mode state */
+#define TARGET_TIOCGPKT    TARGET_IOR('T', 0x38, int)
+/* Get Pty lock state */
+#define TARGET_TIOCGPTLCK  TARGET_IOR('T', 0x39, int)
+/* Get exclusive mode state */
+#define TARGET_TIOCGEXCL   TARGET_IOR('T', 0x40, int)
+/* Safely open the slave */
+#define TARGET_TIOCGPTPEER TARGET_IO('T', 0x41)
+
+#define TARGET_TIOCSERCONFIG   TARGET_IO('T', 83)
+#define TARGET_TIOCSERGWILD    TARGET_IOR('T', 84,  int)
+#define TARGET_TIOCSERSWILD    TARGET_IOW('T', 85,  int)
 #define TARGET_TIOCGLCKTRMIOS  0x5456
 #define TARGET_TIOCSLCKTRMIOS  0x5457
-#define TARGET_TIOCSERGSTRUCT  0x5458           /* For debugging only */
-#define TARGET_TIOCSERGETLSR   _IOR('T', 89, unsigned int) /* Get line status reg. */
+/* For debugging only */
+#define TARGET_TIOCSERGSTRUCT  0x5458
+/* Get line status reg. */
+#define TARGET_TIOCSERGETLSR   TARGET_IOR('T', 89, unsigned int)
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
-# define TARGET_TIOCSER_TEMT    0x01            /* Transmitter physically empty */
-#define TARGET_TIOCSERGETMULTI 0x80a8545a /* Get multiport config  */
+/* Transmitter physically empty */
+# define TARGET_TIOCSER_TEMT    0x01
+/* Get multiport config  */
+#define TARGET_TIOCSERGETMULTI 0x80a8545a
 /* _IOR('T', 90, struct serial_multiport_struct) */
-#define TARGET_TIOCSERSETMULTI 0x40a8545b /* Set multiport config */
+/* Set multiport config */
+#define TARGET_TIOCSERSETMULTI 0x40a8545b
 /* _IOW('T', 91, struct serial_multiport_struct) */
-
-#define TARGET_TIOCMIWAIT  _IO('T', 92) /* wait for a change on serial input line(s) */
-#define TARGET_TIOCGICOUNT 0x545D  /* read serial port inline interrupt counts */
+/* wait for a change on serial input line(s) */
+#define TARGET_TIOCMIWAIT      TARGET_IO('T', 92)
+/* read serial port inline interrupt counts */
+#define TARGET_TIOCGICOUNT 0x545D
 #endif /* XTENSA_TERMBITS_H */
-- 
2.7.4


