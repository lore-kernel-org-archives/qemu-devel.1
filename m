Received: from eggs.gnu.org ([2001:4830:134:3::10]:52747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdvc-00051O-73
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduB-0006mO-JP
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:20:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpduB-0006lk-1d
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:55 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdu9-0007LO-PX
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:53 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:18:02 +0100
Message-Id: <20180814181815.23348-33-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 32/45] arm: Fix return code of arm_load_elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Adam Lackorzynski <adam@l4re.org>

Use an int64_t as a return type to restore
the negative check for arm_load_as.

Signed-off-by: Adam Lackorzynski <adam@l4re.org>
Message-id: 20180730173712.GG4987@os.inf.tu-dresden.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index e09201cc97c..ca9467e583f 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -818,9 +818,9 @@ static int do_arm_linux_init(Object *obj, void *opaque)
     return 0;
 }
 
-static uint64_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
-                             uint64_t *lowaddr, uint64_t *highaddr,
-                             int elf_machine, AddressSpace *as)
+static int64_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
+                            uint64_t *lowaddr, uint64_t *highaddr,
+                            int elf_machine, AddressSpace *as)
 {
     bool elf_is64;
     union {
@@ -829,7 +829,7 @@ static uint64_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
     } elf_header;
     int data_swab = 0;
     bool big_endian;
-    uint64_t ret = -1;
+    int64_t ret = -1;
     Error *err = NULL;
 
 
-- 
2.18.0
