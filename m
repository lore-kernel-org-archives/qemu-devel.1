Received: from eggs.gnu.org ([2001:4830:134:3::10]:56373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fV2-0005TA-AG
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fUx-0001WI-Ed
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:14 +1000
Message-Id: <20170511041426.6488-12-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 11/23] Add QemuMacDrivers qemu_vga.ndrv revision
 d4e7d7a built as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 Makefile              |   3 ++-
 pc-bios/qemu_vga.ndrv | Bin 0 -> 14752 bytes
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 pc-bios/qemu_vga.ndrv

diff --git a/Makefile b/Makefile
index 31d41a7..c830d7a 100644
--- a/Makefile
+++ b/Makefile
@@ -552,7 +552,8 @@ multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin \
 s390-ccw.img \
 spapr-rtas.bin slof.bin skiboot.lid \
 palcode-clipper \
-u-boot.e500
+u-boot.e500 \
+qemu_vga.ndrv
 else
 BLOBS=
 endif
diff --git a/pc-bios/qemu_vga.ndrv b/pc-bios/qemu_vga.ndrv
new file mode 100644
index 0000000000000000000000000000000000000000..6e02f74d61e01c87cf50b10e174a6626bee13677
GIT binary patch
literal 14752
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

literal 0
HcmV?d00001

-- 
2.9.3
