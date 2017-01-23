Received: from eggs.gnu.org ([2001:4830:134:3::10]:46586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCu-0007kX-HJ
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCs-0004tw-V8
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:08 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUCs-0004tr-Qr
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:06 -0500
Received: by mail-qt0-x241.google.com with SMTP id a29so14086916qtb.1
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:06 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:32 -0800
Message-Id: <20170123021748.13170-11-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 10/26] linux-user: Add HPPA termbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/hppa/termbits.h | 219 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100644 linux-user/hppa/termbits.h

diff --git a/linux-user/hppa/termbits.h b/linux-user/hppa/termbits.h
new file mode 100644
index 0000000..e9633ef
--- /dev/null
+++ b/linux-user/hppa/termbits.h
@@ -0,0 +1,219 @@
+/* from asm/termbits.h */
+
+#define TARGET_NCCS 19
+
+struct target_termios {
+    unsigned int c_iflag;               /* input mode flags */
+    unsigned int c_oflag;               /* output mode flags */
+    unsigned int c_cflag;               /* control mode flags */
+    unsigned int c_lflag;               /* local mode flags */
+    unsigned char c_line;                    /* line discipline */
+    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+};
+
+/* c_iflag bits */
+#define TARGET_IGNBRK  0000001
+#define TARGET_BRKINT  0000002
+#define TARGET_IGNPAR  0000004
+#define TARGET_PARMRK  0000010
+#define TARGET_INPCK   0000020
+#define TARGET_ISTRIP  0000040
+#define TARGET_INLCR   0000100
+#define TARGET_IGNCR   0000200
+#define TARGET_ICRNL   0000400
+#define TARGET_IUCLC   0001000
+#define TARGET_IXON    0002000
+#define TARGET_IXANY   0004000
+#define TARGET_IXOFF   0010000
+#define TARGET_IMAXBEL 0040000
+#define TARGET_IUTF8   0100000
+
+/* c_oflag bits */
+#define TARGET_OPOST   0000001
+#define TARGET_OLCUC   0000002
+#define TARGET_ONLCR   0000004
+#define TARGET_OCRNL   0000010
+#define TARGET_ONOCR   0000020
+#define TARGET_ONLRET  0000040
+#define TARGET_OFILL   0000100
+#define TARGET_OFDEL   0000200
+#define TARGET_NLDLY   0000400
+#define   TARGET_NL0   0000000
+#define   TARGET_NL1   0000400
+#define TARGET_CRDLY   0003000
+#define   TARGET_CR0   0000000
+#define   TARGET_CR1   0001000
+#define   TARGET_CR2   0002000
+#define   TARGET_CR3   0003000
+#define TARGET_TABDLY  0014000
+#define   TARGET_TAB0  0000000
+#define   TARGET_TAB1  0004000
+#define   TARGET_TAB2  0010000
+#define   TARGET_TAB3  0014000
+#define   TARGET_XTABS 0014000
+#define TARGET_BSDLY   0020000
+#define   TARGET_BS0   0000000
+#define   TARGET_BS1   0020000
+#define TARGET_VTDLY   0040000
+#define   TARGET_VT0   0000000
+#define   TARGET_VT1   0040000
+#define TARGET_FFDLY   0100000
+#define   TARGET_FF0   0000000
+#define   TARGET_FF1   0100000
+
+/* c_cflag bit meaning */
+#define TARGET_CBAUD   0010017
+#define  TARGET_B0     0000000         /* hang up */
+#define  TARGET_B50    0000001
+#define  TARGET_B75    0000002
+#define  TARGET_B110   0000003
+#define  TARGET_B134   0000004
+#define  TARGET_B150   0000005
+#define  TARGET_B200   0000006
+#define  TARGET_B300   0000007
+#define  TARGET_B600   0000010
+#define  TARGET_B1200  0000011
+#define  TARGET_B1800  0000012
+#define  TARGET_B2400  0000013
+#define  TARGET_B4800  0000014
+#define  TARGET_B9600  0000015
+#define  TARGET_B19200 0000016
+#define  TARGET_B38400 0000017
+#define TARGET_EXTA B19200
+#define TARGET_EXTB B38400
+#define TARGET_CSIZE   0000060
+#define   TARGET_CS5   0000000
+#define   TARGET_CS6   0000020
+#define   TARGET_CS7   0000040
+#define   TARGET_CS8   0000060
+#define TARGET_CSTOPB  0000100
+#define TARGET_CREAD   0000200
+#define TARGET_PARENB  0000400
+#define TARGET_PARODD  0001000
+#define TARGET_HUPCL   0002000
+#define TARGET_CLOCAL  0004000
+#define TARGET_CBAUDEX 0010000
+#define  TARGET_B57600  0010001
+#define  TARGET_B115200 0010002
+#define  TARGET_B230400 0010003
+#define  TARGET_B460800 0010004
+#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
+#define TARGET_CMSPAR    010000000000  /* mark or space (stick) parity */
+#define TARGET_CRTSCTS   020000000000  /* flow control */
+
+/* c_lflag bits */
+#define TARGET_ISIG    0000001
+#define TARGET_ICANON  0000002
+#define TARGET_XCASE   0000004
+#define TARGET_ECHO    0000010
+#define TARGET_ECHOE   0000020
+#define TARGET_ECHOK   0000040
+#define TARGET_ECHONL  0000100
+#define TARGET_NOFLSH  0000200
+#define TARGET_TOSTOP  0000400
+#define TARGET_ECHOCTL 0001000
+#define TARGET_ECHOPRT 0002000
+#define TARGET_ECHOKE  0004000
+#define TARGET_FLUSHO  0010000
+#define TARGET_PENDIN  0040000
+#define TARGET_IEXTEN  0100000
+
+/* c_cc character offsets */
+#define TARGET_VINTR    0
+#define TARGET_VQUIT    1
+#define TARGET_VERASE   2
+#define TARGET_VKILL    3
+#define TARGET_VEOF     4
+#define TARGET_VTIME    5
+#define TARGET_VMIN     6
+#define TARGET_VSWTC    7
+#define TARGET_VSTART   8
+#define TARGET_VSTOP    9
+#define TARGET_VSUSP    10
+#define TARGET_VEOL     11
+#define TARGET_VREPRINT 12
+#define TARGET_VDISCARD 13
+#define TARGET_VWERASE  14
+#define TARGET_VLNEXT   15
+#define TARGET_VEOL2    16
+
+/* ioctls */
+
+#define TARGET_TCGETS           TARGET_IOR('T', 16, struct target_termios)
+#define TARGET_TCSETS           TARGET_IOW('T', 17, struct target_termios)
+#define TARGET_TCSETSW          TARGET_IOW('T', 18, struct target_termios)
+#define TARGET_TCSETSF          TARGET_IOW('T', 19, struct target_termios)
+#define TARGET_TCGETA           TARGET_IOR('T', 1, struct target_termios)
+#define TARGET_TCSETA           TARGET_IOW('T', 2, struct target_termios)
+#define TARGET_TCSETAW          TARGET_IOW('T', 3, struct target_termios)
+#define TARGET_TCSETAF          TARGET_IOW('T', 4, struct target_termios)
+#define TARGET_TCSBRK           TARGET_IO('T', 5)
+#define TARGET_TCXONC           TARGET_IO('T', 6)
+#define TARGET_TCFLSH           TARGET_IO('T', 7)
+
+#define TARGET_TIOCEXCL         0x540C
+#define TARGET_TIOCNXCL         0x540D
+#define TARGET_TIOCSCTTY        0x540E
+#define TARGET_TIOCGPGRP        TARGET_IOR('T', 30, int)
+#define TARGET_TIOCSPGRP        TARGET_IOW('T', 29, int)
+#define TARGET_TIOCOUTQ         0x5411
+#define TARGET_TIOCSTI          0x5412
+#define TARGET_TIOCGWINSZ       0x5413
+#define TARGET_TIOCSWINSZ       0x5414
+#define TARGET_TIOCMGET         0x5415
+#define TARGET_TIOCMBIS         0x5416
+#define TARGET_TIOCMBIC         0x5417
+#define TARGET_TIOCMSET         0x5418
+#define TARGET_TIOCGSOFTCAR     0x5419
+#define TARGET_TIOCSSOFTCAR     0x541A
+#define TARGET_FIONREAD         0x541B
+#define TARGET_TIOCINQ          TARGET_FIONREAD
+#define TARGET_TIOCLINUX        0x541C
+#define TARGET_TIOCCONS         0x541D
+#define TARGET_TIOCGSERIAL      0x541E
+#define TARGET_TIOCSSERIAL      0x541F
+#define TARGET_TIOCPKT          0x5420
+#define TARGET_FIONBIO          0x5421
+#define TARGET_TIOCNOTTY        0x5422
+#define TARGET_TIOCSETD         0x5423
+#define TARGET_TIOCGETD         0x5424
+#define TARGET_TCSBRKP          0x5425 /* Needed for POSIX tcsendbreak() */
+#define TARGET_TIOCTTYGSTRUCT   0x5426 /* For debugging only */
+#define TARGET_TIOCSBRK         0x5427 /* BSD compatibility */
+#define TARGET_TIOCCBRK         0x5428 /* BSD compatibility */
+#define TARGET_TIOCGSID         TARGET_IOR('T', 20, int)
+#define TARGET_TIOCGPTN         TARGET_IOR('T', 0x30, unsigned int)
+        /* Get Pty Number (of pty-mux device) */
+#define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
+        /* Lock/unlock Pty */
+
+#define TARGET_FIONCLEX         0x5450  /* these numbers need to be adjusted. */
+#define TARGET_FIOCLEX          0x5451
+#define TARGET_FIOASYNC         0x5452
+#define TARGET_TIOCSERCONFIG    0x5453
+#define TARGET_TIOCSERGWILD     0x5454
+#define TARGET_TIOCSERSWILD     0x5455
+#define TARGET_TIOCGLCKTRMIOS   0x5456
+#define TARGET_TIOCSLCKTRMIOS   0x5457
+#define TARGET_TIOCSERGSTRUCT   0x5458 /* For debugging only */
+#define TARGET_TIOCSERGETLSR    0x5459 /* Get line status register */
+#define TARGET_TIOCSERGETMULTI  0x545A /* Get multiport config  */
+#define TARGET_TIOCSERSETMULTI  0x545B /* Set multiport config */
+
+#define TARGET_TIOCMIWAIT      0x545C  /* wait for a change on serial */
+#define TARGET_TIOCGICOUNT     0x545D
+#define TARGET_FIOQSIZE        0x5460
+#define TARGET_TIOCSTART       0x5461
+#define TARGET_TIOCSTOP        0x5462
+#define TARGET_TIOCSLTC        0x5462
+
+/* Used for packet mode */
+#define TARGET_TIOCPKT_DATA              0
+#define TARGET_TIOCPKT_FLUSHREAD         1
+#define TARGET_TIOCPKT_FLUSHWRITE        2
+#define TARGET_TIOCPKT_STOP              4
+#define TARGET_TIOCPKT_START             8
+#define TARGET_TIOCPKT_NOSTOP           16
+#define TARGET_TIOCPKT_DOSTOP           32
+
+#define TARGET_TIOCSER_TEMT    0x01 /* Transmitter physically empty */
-- 
2.9.3
