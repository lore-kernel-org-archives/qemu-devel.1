Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADB4C33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 02:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32252072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 02:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32252072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isH8h-00086J-DK
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 21:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1isH7R-0006nS-Lp
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 21:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1isH7Q-0003Ge-4Z
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 21:12:17 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:35003 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1isH7P-0003DX-Q9
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 21:12:16 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id DD7571A2110;
 Fri, 17 Jan 2020 03:12:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id B6D0E1A20E3;
 Fri, 17 Jan 2020 03:12:11 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] linux-user: alpha: Synchronize termbits.h with kernel
Date: Fri, 17 Jan 2020 03:11:54 +0100
Message-Id: <1579227117-6310-2-git-send-email-aleksandar.markovic@rt-rk.com>
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

Synchronize all elements of alpha's termbits.h with kernel and
make sure that all applicable macros and other definitions are
expressed in terms of target, not the host.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/alpha/termbits.h | 82 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 6 deletions(-)

diff --git a/linux-user/alpha/termbits.h b/linux-user/alpha/termbits.h
index a714251..d15f26e 100644
--- a/linux-user/alpha/termbits.h
+++ b/linux-user/alpha/termbits.h
@@ -17,6 +17,32 @@ struct target_termios {
 	target_speed_t c_ospeed;		/* output speed */
 };
 
+/* Alpha has identical termios and termios2 */
+
+struct target_termios2 {
+    target_tcflag_t c_iflag;            /* input mode flags */
+    target_tcflag_t c_oflag;            /* output mode flags */
+    target_tcflag_t c_cflag;            /* control mode flags */
+    target_tcflag_t c_lflag;            /* local mode flags */
+    target_cc_t c_cc[TARGET_NCCS];      /* control characters */
+    target_cc_t c_line;                 /* line discipline (== c_cc[19]) */
+    target_speed_t c_ispeed;            /* input speed */
+    target_speed_t c_ospeed;            /* output speed */
+};
+
+/* Alpha has matching termios and ktermios */
+
+struct target_ktermios {
+    target_tcflag_t c_iflag;            /* input mode flags */
+    target_tcflag_t c_oflag;            /* output mode flags */
+    target_tcflag_t c_cflag;            /* control mode flags */
+    target_tcflag_t c_lflag;            /* local mode flags */
+    target_cc_t c_cc[TARGET_NCCS];      /* control characters */
+    target_cc_t c_line;                 /* line discipline (== c_cc[19]) */
+    target_speed_t c_ispeed;            /* input speed */
+    target_speed_t c_ospeed;            /* output speed */
+};
+
 /* c_cc characters */
 #define TARGET_VEOF 0
 #define TARGET_VEOL 1
@@ -88,7 +114,11 @@ struct target_termios {
 #define TARGET_VTDLY	00200000
 #define   TARGET_VT0	00000000
 #define   TARGET_VT1	00200000
-#define TARGET_XTABS	01000000 /* Hmm.. Linux/i386 considers this part of TABDLY.. */
+/*
+ * Should be equivalent to TAB3, see description of TAB3 in
+ * POSIX.1-2008, Ch. 11.2.3 "Output Modes"
+ */
+#define TARGET_XTABS    TARGET_TAB3
 
 /* c_cflag bit meaning */
 #define TARGET_CBAUD	0000037
@@ -108,8 +138,8 @@ struct target_termios {
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
@@ -143,6 +173,9 @@ struct target_termios {
 #define TARGET_CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define TARGET_CRTSCTS	  020000000000		/* flow control */
 
+#define TARGET_CIBAUD   07600000
+#define TARGET_IBSHIFT  16
+
 /* c_lflag bits */
 #define TARGET_ISIG	0x00000080
 #define TARGET_ICANON	0x00000100
@@ -159,13 +192,30 @@ struct target_termios {
 #define TARGET_FLUSHO	0x00800000
 #define TARGET_PENDIN	0x20000000
 #define TARGET_IEXTEN	0x00000400
+#define TARGET_EXTPROC  0x10000000
+
+/* Values for the ACTION argument to `tcflow'.  */
+#define TCOOFF          0
+#define TCOON           1
+#define TCIOFF          2
+#define TCION           3
+
+/* Values for the QUEUE_SELECTOR argument to `tcflush'.  */
+#define TCIFLUSH        0
+#define TCOFLUSH        1
+#define TCIOFLUSH       2
+
+/* Values for the OPTIONAL_ACTIONS argument to `tcsetattr'.  */
+#define TCSANOW         0
+#define TCSADRAIN       1
+#define TCSAFLUSH       2
 
 #define TARGET_FIOCLEX		TARGET_IO('f', 1)
 #define TARGET_FIONCLEX	TARGET_IO('f', 2)
 #define TARGET_FIOASYNC	TARGET_IOW('f', 125, int)
 #define TARGET_FIONBIO		TARGET_IOW('f', 126, int)
 #define TARGET_FIONREAD	TARGET_IOR('f', 127, int)
-#define TARGET_TIOCINQ		FIONREAD
+#define TARGET_TIOCINQ  TARGET_FIONREAD
 #define TARGET_FIOQSIZE	TARGET_IOR('f', 128, loff_t)
 
 #define TARGET_TIOCGETP	TARGET_IOR('t', 8, struct target_sgttyb)
@@ -188,6 +238,11 @@ struct target_termios {
 #define TARGET_TCXONC		TARGET_IO('t', 30)
 #define TARGET_TCFLSH		TARGET_IO('t', 31)
 
+#define TARGET_TCGETS2          TARGET_IOR('T', 42, struct target_termios2)
+#define TARGET_TCSETS2          TARGET_IOW('T', 43, struct target_termios2)
+#define TARGET_TCSETSW2         TARGET_IOW('T', 44, struct target_termios2)
+#define TARGET_TCSETSF2         TARGET_IOW('T', 45, struct target_termios2)
+
 #define TARGET_TIOCSWINSZ	TARGET_IOW('t', 103, struct target_winsize)
 #define TARGET_TIOCGWINSZ	TARGET_IOR('t', 104, struct target_winsize)
 #define	TARGET_TIOCSTART	TARGET_IO('t', 110)		/* start output, like ^Q */
@@ -217,8 +272,8 @@ struct target_termios {
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
@@ -246,9 +301,24 @@ struct target_termios {
 #define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
 #define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
 #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TARGET_TIOCGRS485       TARGET_IOR('T', 0x2E, struct serial_rs485)
+#define TARGET_TIOCSRS485       TARGET_IOWR('T', 0x2F, struct serial_rs485)
 #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
+                                /* Get primary device node of /dev/console */
+#define TARGET_TIOCGDEV         TARGET_IOR('T', 0x32, unsigned int)
+                                /* Generate signal on Pty slave */
+#define TARGET_TIOCSIG          TARGET_IOW('T', 0x36, int)
+#define TARGET_TIOCVHANGUP      0x5437
+                                 /* Get packet mode state */
+#define TARGET_TIOCGPKT         TARGET_IOR('T', 0x38, int)
+                                /* Get Pty lock state */
+#define TARGET_TIOCGPTLCK       TARGET_IOR('T', 0x39, int)
+                                /* Get exclusive mode state */
+#define TARGET_TIOCGEXCL        TARGET_IOR('T', 0x40, int)
 #define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
+#define TARGET_TIOCGISO7816     TARGET_IOR('T', 0x42, struct serial_iso7816)
+#define TARGET_TIOCSISO7816     TARGET_IOWR('T', 0x43, struct serial_iso7816)
 
 #define TARGET_TIOCSERCONFIG	0x5453
 #define TARGET_TIOCSERGWILD	0x5454
-- 
2.7.4


