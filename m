Received: from eggs.gnu.org ([209.51.188.92]:34028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h2ynY-0004SX-OU
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h2ynY-0004e1-1U
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:47:28 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:29058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h2ynX-0004bA-Qb
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 09:47:27 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sat, 9 Mar 2019 17:48:40 +0100
Message-Id: <20190309165740.0755B7480BD@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] isa: Add APM and ACPI dependencies for VT82C686
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

Compiling vt82c686.c fails without APM and ACPI_PM funtions. Add
dependency on these in Kconfig to fix this.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/isa/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 57e09a0cb8..e092da3fc3 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -36,6 +36,8 @@ config VT82C686
     select ACPI_SMBUS
     select SERIAL_ISA
     select FDC
+    select APM
+    select ACPI_X86
 
 config SMC37C669
     bool
-- 
2.13.7
