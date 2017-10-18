Received: from eggs.gnu.org ([2001:4830:134:3::10]:54153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e4bwp-0000mI-SC
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 20:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e4bwp-00045V-0q
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 20:10:59 -0400
Date: Tue, 17 Oct 2017 17:10:50 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1710171708130.27209@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PATCH] aarch64: advertise the GIC system register
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xen.org, sstabellini@kernel.org, julien.grall@arm.com, peter.maydell@linaro.org, qemu-arm@nongnu.org

Advertise the presence of the GIC system register interface (1<<24)
according to H9.248 of the ARM ARM.

This patch allows Xen to boot on QEMU aarch64.

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 670c07a..a451763 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -136,7 +136,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->id_isar3 = 0x01112131;
     cpu->id_isar4 = 0x00011142;
     cpu->id_isar5 = 0x00011121;
-    cpu->id_aa64pfr0 = 0x00002222;
+    cpu->id_aa64pfr0 = 0x01002222;
     cpu->id_aa64dfr0 = 0x10305106;
     cpu->pmceid0 = 0x00000000;
     cpu->pmceid1 = 0x00000000;
@@ -196,7 +196,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->id_isar3 = 0x01112131;
     cpu->id_isar4 = 0x00011142;
     cpu->id_isar5 = 0x00011121;
-    cpu->id_aa64pfr0 = 0x00002222;
+    cpu->id_aa64pfr0 = 0x01002222;
     cpu->id_aa64dfr0 = 0x10305106;
     cpu->id_aa64isar0 = 0x00011120;
     cpu->id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
