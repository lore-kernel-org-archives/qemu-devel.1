Received: from eggs.gnu.org ([2001:4830:134:3::10]:35970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etX5g-0004CJ-Th
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1etX5f-0005iH-O9
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:18:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1etX5f-0005i8-It
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:18:35 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  7 Mar 2018 12:18:21 +0100
Message-Id: <20180307111822.29403-4-kwolf@redhat.com>
In-Reply-To: <20180307111822.29403-1-kwolf@redhat.com>
References: <20180307111822.29403-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] multiboot: Use header names when displaying
 fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jack.schwartz@oracle.com

From: Jack Schwartz <jack.schwartz@oracle.com>

Refer to field names when displaying fields in printf and debug statements.

Signed-off-by: Jack Schwartz <jack.schwartz@oracle.com>
Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/i386/multiboot.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 7d59cbe523..07fdccb84a 100644
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
2.13.6
