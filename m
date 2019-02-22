Received: from eggs.gnu.org ([209.51.188.92]:33490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gxGUz-0004H7-9p
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gxGUx-0001wl-SK
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:28:41 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:55005 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gxGUx-0001TZ-IK
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:28:39 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 22 Feb 2019 20:26:16 +0100
Message-Id: <1550863578-30859-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550863578-30859-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1550863578-30859-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 6/8] qemu-doc: Add section on MIPS' Boston
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add section on MIPS' Boston board in QEMU user documentation.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 qemu-doc.texi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 18e383c..ae3c3f9 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2049,6 +2049,15 @@ Malta FPGA serial device
 Cirrus (default) or any other PCI VGA graphics card
 @end itemize
 
+The Boston board emulation supports the following devices:
+
+@itemize @minus
+@item
+Xilinx FPGA, which includes a PCIe root port and an UART
+@item
+Intel EG20T PCH connects the I/O peripherals, but only the SATA bus is emulated
+@end itemize
+
 The ACER Pica emulation supports:
 
 @itemize @minus
-- 
2.7.4
