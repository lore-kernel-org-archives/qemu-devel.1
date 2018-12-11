Received: from eggs.gnu.org ([2001:4830:134:3::10]:42509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmOP-0007WV-Sn
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmOL-000700-Ue
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:04:25 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:29 +0100
Message-Id: <20181211180352.19644-8-laurent@vivier.eu>
In-Reply-To: <20181211180352.19644-1-laurent@vivier.eu>
References: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/30] MAINTAINERS: Add missing hw/pci-host
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Bonito belongs to Fulong-2E, Sabre belongs to Sun4u, and Mac-Newworld
and Mips-Boston were missing the header files.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1542891760-13937-1-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63effdc473..059c775a06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -885,7 +885,7 @@ R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 F: hw/isa/vt82c686.c
-
+F: hw/pci-host/bonito.c
 F: include/hw/isa/vt82c686.h
 
 Boston
@@ -895,6 +895,7 @@ S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
 F: hw/pci-host/xilinx-pcie.c
+F: include/hw/pci-host/xilinx-pcie.h
 
 OpenRISC Machines
 -----------------
@@ -947,6 +948,7 @@ F: hw/nvram/mac_nvram.c
 F: include/hw/misc/macio/
 F: include/hw/misc/mos6522.h
 F: include/hw/ppc/mac_dbdma.h
+F: include/hw/pci-host/uninorth.h
 
 Old World
 M: David Gibson <david@gibson.dropbear.id.au>
@@ -1038,6 +1040,8 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
 F: hw/sparc64/sun4u.c
 F: pc-bios/openbios-sparc64
+F: hw/pci-host/sabre.c
+F: include/hw/pci-host/sabre.h
 
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
-- 
2.19.2
