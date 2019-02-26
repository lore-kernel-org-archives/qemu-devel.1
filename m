Received: from eggs.gnu.org ([209.51.188.92]:35679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gycIE-000494-DU
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gycID-0000DE-6U
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:57:06 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:40132 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gycIC-0000CV-Up
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:57:05 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 26 Feb 2019 13:55:31 +0100
Message-Id: <1551185735-17154-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551185735-17154-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551185735-17154-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 5/9] qemu-doc: Add section on MIPS' Boston
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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
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
=20
+The Boston board emulation supports the following devices:
+
+@itemize @minus
+@item
+Xilinx FPGA, which includes a PCIe root port and an UART
+@item
+Intel EG20T PCH connects the I/O peripherals, but only the SATA bus is e=
mulated
+@end itemize
+
 The ACER Pica emulation supports:
=20
 @itemize @minus
--=20
2.7.4
