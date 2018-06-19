Received: from eggs.gnu.org ([2001:4830:134:3::10]:45895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5i5-0001hA-7d
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5i4-0008Qy-8X
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:29 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:04 -0500
Message-Id: <20180619014319.28272-39-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 038/113] multiboot: Use header names when
 displaying fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jack Schwartz <jack.schwartz@oracle.com>, Kevin Wolf <kwolf@redhat.com>

From: Jack Schwartz <jack.schwartz@oracle.com>

Refer to field names when displaying fields in printf and debug statements.

Signed-off-by: Jack Schwartz <jack.schwartz@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit ce5eb6dc4dc5652f7e360a1db817f1d5dafab90f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/multiboot.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 964feaf26e..818728bdf8 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -224,7 +224,7 @@ int load_multiboot(FWCfgState *fw_cfg,
 
         mh_load_addr = ldl_p(header+i+16);
         if (mh_header_addr < mh_load_addr) {
-            fprintf(stderr, "invalid mh_load_addr address\n");
+            fprintf(stderr, "invalid load_addr address\n");
             exit(1);
         }
 
@@ -234,7 +234,7 @@ int load_multiboot(FWCfgState *fw_cfg,
 
         if (mh_load_end_addr) {
             if (mh_load_end_addr < mh_load_addr) {
-                fprintf(stderr, "invalid mh_load_end_addr address\n");
+                fprintf(stderr, "invalid load_end_addr address\n");
                 exit(1);
             }
             mb_load_size = mh_load_end_addr - mh_load_addr;
@@ -247,7 +247,7 @@ int load_multiboot(FWCfgState *fw_cfg,
         }
         if (mh_bss_end_addr) {
             if (mh_bss_end_addr < (mh_load_addr + mb_load_size)) {
-                fprintf(stderr, "invalid mh_bss_end_addr address\n");
+                fprintf(stderr, "invalid bss_end_addr address\n");
                 exit(1);
             }
             mb_kernel_size = mh_bss_end_addr - mh_load_addr;
@@ -255,10 +255,10 @@ int load_multiboot(FWCfgState *fw_cfg,
             mb_kernel_size = mb_load_size;
         }
 
-        mb_debug("multiboot: mh_header_addr = %#x\n", mh_header_addr);
-        mb_debug("multiboot: mh_load_addr = %#x\n", mh_load_addr);
-        mb_debug("multiboot: mh_load_end_addr = %#x\n", mh_load_end_addr);
-        mb_debug("multiboot: mh_bss_end_addr = %#x\n", mh_bss_end_addr);
+        mb_debug("multiboot: header_addr = %#x\n", mh_header_addr);
+        mb_debug("multiboot: load_addr = %#x\n", mh_load_addr);
+        mb_debug("multiboot: load_end_addr = %#x\n", mh_load_end_addr);
+        mb_debug("multiboot: bss_end_addr = %#x\n", mh_bss_end_addr);
         mb_debug("qemu: loading multiboot kernel (%#x bytes) at %#x\n",
                  mb_load_size, mh_load_addr);
 
@@ -361,7 +361,7 @@ int load_multiboot(FWCfgState *fw_cfg,
     stl_p(bootinfo + MBI_BOOT_DEVICE, 0x8000ffff); /* XXX: use the -boot switch? */
     stl_p(bootinfo + MBI_MMAP_ADDR,   ADDR_E820_MAP);
 
-    mb_debug("multiboot: mh_entry_addr = %#x\n", mh_entry_addr);
+    mb_debug("multiboot: entry_addr = %#x\n", mh_entry_addr);
     mb_debug("           mb_buf_phys   = "TARGET_FMT_plx"\n", mbs.mb_buf_phys);
     mb_debug("           mod_start     = "TARGET_FMT_plx"\n", mbs.mb_buf_phys + mbs.offset_mods);
     mb_debug("           mb_mods_count = %d\n", mbs.mb_mods_count);
-- 
2.11.0
