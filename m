Received: from eggs.gnu.org ([209.51.188.92]:50277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gw9w5-0003JO-Mf
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gw9w4-0005ac-Du
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:16:05 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53891 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gw9w4-0005Qc-4J
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:16:04 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 19 Feb 2019 19:14:18 +0100
Message-Id: <1550600059-5789-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550600059-5789-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550600059-5789-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 8/9] qemu-doc: Move section on MIPS' mipssim
 pseudo board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, peter.maydell@linaro.org, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Move section on MIPS' mipssim pseudo board to the more
appropriate place.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 qemu-doc.texi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 83be010..4c5577f 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2062,19 +2062,6 @@ PC Keyboard
 IDE controller
 @end itemize
 
-The mipssim pseudo board emulation provides an environment similar
-to what the proprietary MIPS emulator uses for running Linux.
-It supports:
-
-@itemize @minus
-@item
-A range of MIPS CPUs, default is the 24Kf
-@item
-PC style serial port
-@item
-MIPSnet network emulation
-@end itemize
-
 The MIPS Magnum R4000 emulation supports:
 
 @itemize @minus
@@ -2090,6 +2077,19 @@ SCSI controller
 G364 framebuffer
 @end itemize
 
+The mipssim pseudo board emulation provides an environment similar
+to what the proprietary MIPS emulator uses for running Linux.
+It supports:
+
+@itemize @minus
+@item
+A range of MIPS CPUs, default is the 24Kf
+@item
+PC style serial port
+@item
+MIPSnet network emulation
+@end itemize
+
 @node nanoMIPS System emulator
 @subsection nanoMIPS System emulator
 @cindex system emulation (nanoMIPS)
-- 
2.7.4
