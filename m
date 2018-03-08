Received: from eggs.gnu.org ([2001:4830:134:3::10]:40304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuG-0005NL-JQ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuE-0005yg-6z
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:44 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  8 Mar 2018 19:04:15 +0100
Message-Id: <20180308180423.941-4-cohuck@redhat.com>
In-Reply-To: <20180308180423.941-1-cohuck@redhat.com>
References: <20180308180423.941-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/11] target/s390x: Remove leading underscores
 from #defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

We should not use leading underscores followed by a capital letter
in #defines since such identifiers are reserved by the C standard.

For ASCE_ORIGIN, REGION_ENTRY_ORIGIN and SEGMENT_ENTRY_ORIGIN I also
added parentheses around the value to silence an error message from
checkpatch.pl.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1520227018-4061-1-git-send-email-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h        | 66 +++++++++++++++++++++++------------------------
 target/s390x/mem_helper.c | 20 +++++++-------
 target/s390x/mmu_helper.c | 54 +++++++++++++++++++-------------------
 3 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index c5ef930876..5f357a4e2d 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -538,39 +538,39 @@ typedef union SysIB {
 QEMU_BUILD_BUG_ON(sizeof(SysIB) != 4096);
 
 /* MMU defines */
-#define _ASCE_ORIGIN            ~0xfffULL /* segment table origin             */
-#define _ASCE_SUBSPACE          0x200     /* subspace group control           */
-#define _ASCE_PRIVATE_SPACE     0x100     /* private space control            */
-#define _ASCE_ALT_EVENT         0x80      /* storage alteration event control */
-#define _ASCE_SPACE_SWITCH      0x40      /* space switch event               */
-#define _ASCE_REAL_SPACE        0x20      /* real space control               */
-#define _ASCE_TYPE_MASK         0x0c      /* asce table type mask             */
-#define _ASCE_TYPE_REGION1      0x0c      /* region first table type          */
-#define _ASCE_TYPE_REGION2      0x08      /* region second table type         */
-#define _ASCE_TYPE_REGION3      0x04      /* region third table type          */
-#define _ASCE_TYPE_SEGMENT      0x00      /* segment table type               */
-#define _ASCE_TABLE_LENGTH      0x03      /* region table length              */
-
-#define _REGION_ENTRY_ORIGIN    ~0xfffULL /* region/segment table origin      */
-#define _REGION_ENTRY_RO        0x200     /* region/segment protection bit    */
-#define _REGION_ENTRY_TF        0xc0      /* region/segment table offset      */
-#define _REGION_ENTRY_INV       0x20      /* invalid region table entry       */
-#define _REGION_ENTRY_TYPE_MASK 0x0c      /* region/segment table type mask   */
-#define _REGION_ENTRY_TYPE_R1   0x0c      /* region first table type          */
-#define _REGION_ENTRY_TYPE_R2   0x08      /* region second table type         */
-#define _REGION_ENTRY_TYPE_R3   0x04      /* region third table type          */
-#define _REGION_ENTRY_LENGTH    0x03      /* region third length              */
-
-#define _SEGMENT_ENTRY_ORIGIN   ~0x7ffULL /* segment table origin             */
-#define _SEGMENT_ENTRY_FC       0x400     /* format control                   */
-#define _SEGMENT_ENTRY_RO       0x200     /* page protection bit              */
-#define _SEGMENT_ENTRY_INV      0x20      /* invalid segment table entry      */
-
-#define VADDR_PX                0xff000   /* page index bits                  */
-
-#define _PAGE_RO        0x200            /* HW read-only bit  */
-#define _PAGE_INVALID   0x400            /* HW invalid bit    */
-#define _PAGE_RES0      0x800            /* bit must be zero  */
+#define ASCE_ORIGIN           (~0xfffULL) /* segment table origin             */
+#define ASCE_SUBSPACE         0x200       /* subspace group control           */
+#define ASCE_PRIVATE_SPACE    0x100       /* private space control            */
+#define ASCE_ALT_EVENT        0x80        /* storage alteration event control */
+#define ASCE_SPACE_SWITCH     0x40        /* space switch event               */
+#define ASCE_REAL_SPACE       0x20        /* real space control               */
+#define ASCE_TYPE_MASK        0x0c        /* asce table type mask             */
+#define ASCE_TYPE_REGION1     0x0c        /* region first table type          */
+#define ASCE_TYPE_REGION2     0x08        /* region second table type         */
+#define ASCE_TYPE_REGION3     0x04        /* region third table type          */
+#define ASCE_TYPE_SEGMENT     0x00        /* segment table type               */
+#define ASCE_TABLE_LENGTH     0x03        /* region table length              */
+
+#define REGION_ENTRY_ORIGIN   (~0xfffULL) /* region/segment table origin    */
+#define REGION_ENTRY_RO       0x200       /* region/segment protection bit  */
+#define REGION_ENTRY_TF       0xc0        /* region/segment table offset    */
+#define REGION_ENTRY_INV      0x20        /* invalid region table entry     */
+#define REGION_ENTRY_TYPE_MASK 0x0c       /* region/segment table type mask */
+#define REGION_ENTRY_TYPE_R1  0x0c        /* region first table type        */
+#define REGION_ENTRY_TYPE_R2  0x08        /* region second table type       */
+#define REGION_ENTRY_TYPE_R3  0x04        /* region third table type        */
+#define REGION_ENTRY_LENGTH   0x03        /* region third length            */
+
+#define SEGMENT_ENTRY_ORIGIN  (~0x7ffULL) /* segment table origin        */
+#define SEGMENT_ENTRY_FC      0x400       /* format control              */
+#define SEGMENT_ENTRY_RO      0x200       /* page protection bit         */
+#define SEGMENT_ENTRY_INV     0x20        /* invalid segment table entry */
+
+#define VADDR_PX              0xff000     /* page index bits   */
+
+#define PAGE_RO               0x200       /* HW read-only bit  */
+#define PAGE_INVALID          0x400       /* HW invalid bit    */
+#define PAGE_RES0             0x800       /* bit must be zero  */
 
 #define SK_C                    (0x1 << 1)
 #define SK_R                    (0x1 << 2)
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index d5291b246e..a0e28bd124 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1924,20 +1924,20 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
 
     if (!(r2 & 0x800)) {
         /* invalidation-and-clearing operation */
-        table = r1 & _ASCE_ORIGIN;
+        table = r1 & ASCE_ORIGIN;
         entries = (r2 & 0x7ff) + 1;
 
-        switch (r1 & _ASCE_TYPE_MASK) {
-        case _ASCE_TYPE_REGION1:
+        switch (r1 & ASCE_TYPE_MASK) {
+        case ASCE_TYPE_REGION1:
             index = (r2 >> 53) & 0x7ff;
             break;
-        case _ASCE_TYPE_REGION2:
+        case ASCE_TYPE_REGION2:
             index = (r2 >> 42) & 0x7ff;
             break;
-        case _ASCE_TYPE_REGION3:
+        case ASCE_TYPE_REGION3:
             index = (r2 >> 31) & 0x7ff;
             break;
-        case _ASCE_TYPE_SEGMENT:
+        case ASCE_TYPE_SEGMENT:
             index = (r2 >> 20) & 0x7ff;
             break;
         }
@@ -1945,9 +1945,9 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
             /* addresses are not wrapped in 24/31bit mode but table index is */
             raddr = table + ((index + i) & 0x7ff) * sizeof(entry);
             entry = cpu_ldq_real_ra(env, raddr, ra);
-            if (!(entry & _REGION_ENTRY_INV)) {
+            if (!(entry & REGION_ENTRY_INV)) {
                 /* we are allowed to not store if already invalid */
-                entry |= _REGION_ENTRY_INV;
+                entry |= REGION_ENTRY_INV;
                 cpu_stq_real_ra(env, raddr, entry, ra);
             }
         }
@@ -1971,12 +1971,12 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
     uint64_t pte_addr, pte;
 
     /* Compute the page table entry address */
-    pte_addr = (pto & _SEGMENT_ENTRY_ORIGIN);
+    pte_addr = (pto & SEGMENT_ENTRY_ORIGIN);
     pte_addr += (vaddr & VADDR_PX) >> 9;
 
     /* Mark the page table entry as invalid */
     pte = cpu_ldq_real_ra(env, pte_addr, ra);
-    pte |= _PAGE_INVALID;
+    pte |= PAGE_INVALID;
     cpu_stq_real_ra(env, pte_addr, pte, ra);
 
     /* XXX we exploit the fact that Linux passes the exact virtual
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 23fb2e7501..1deeb6e6e4 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -128,11 +128,11 @@ static bool lowprot_enabled(const CPUS390XState *env, uint64_t asc)
     /* Check the private-space control bit */
     switch (asc) {
     case PSW_ASC_PRIMARY:
-        return !(env->cregs[1] & _ASCE_PRIVATE_SPACE);
+        return !(env->cregs[1] & ASCE_PRIVATE_SPACE);
     case PSW_ASC_SECONDARY:
-        return !(env->cregs[7] & _ASCE_PRIVATE_SPACE);
+        return !(env->cregs[7] & ASCE_PRIVATE_SPACE);
     case PSW_ASC_HOME:
-        return !(env->cregs[13] & _ASCE_PRIVATE_SPACE);
+        return !(env->cregs[13] & ASCE_PRIVATE_SPACE);
     default:
         /* We don't support access register mode */
         error_report("unsupported addressing mode");
@@ -159,20 +159,20 @@ static int mmu_translate_pte(CPUS390XState *env, target_ulong vaddr,
                              uint64_t asc, uint64_t pt_entry,
                              target_ulong *raddr, int *flags, int rw, bool exc)
 {
-    if (pt_entry & _PAGE_INVALID) {
+    if (pt_entry & PAGE_INVALID) {
         DPRINTF("%s: PTE=0x%" PRIx64 " invalid\n", __func__, pt_entry);
         trigger_page_fault(env, vaddr, PGM_PAGE_TRANS, asc, rw, exc);
         return -1;
     }
-    if (pt_entry & _PAGE_RES0) {
+    if (pt_entry & PAGE_RES0) {
         trigger_page_fault(env, vaddr, PGM_TRANS_SPEC, asc, rw, exc);
         return -1;
     }
-    if (pt_entry & _PAGE_RO) {
+    if (pt_entry & PAGE_RO) {
         *flags &= ~PAGE_WRITE;
     }
 
-    *raddr = pt_entry & _ASCE_ORIGIN;
+    *raddr = pt_entry & ASCE_ORIGIN;
 
     PTE_DPRINTF("%s: PTE=0x%" PRIx64 "\n", __func__, pt_entry);
 
@@ -188,11 +188,11 @@ static int mmu_translate_segment(CPUS390XState *env, target_ulong vaddr,
     CPUState *cs = CPU(s390_env_get_cpu(env));
     uint64_t origin, offs, pt_entry;
 
-    if (st_entry & _SEGMENT_ENTRY_RO) {
+    if (st_entry & SEGMENT_ENTRY_RO) {
         *flags &= ~PAGE_WRITE;
     }
 
-    if ((st_entry & _SEGMENT_ENTRY_FC) && (env->cregs[0] & CR0_EDAT)) {
+    if ((st_entry & SEGMENT_ENTRY_FC) && (env->cregs[0] & CR0_EDAT)) {
         /* Decode EDAT1 segment frame absolute address (1MB page) */
         *raddr = (st_entry & 0xfffffffffff00000ULL) | (vaddr & 0xfffff);
         PTE_DPRINTF("%s: SEG=0x%" PRIx64 "\n", __func__, st_entry);
@@ -200,7 +200,7 @@ static int mmu_translate_segment(CPUS390XState *env, target_ulong vaddr,
     }
 
     /* Look up 4KB page entry */
-    origin = st_entry & _SEGMENT_ENTRY_ORIGIN;
+    origin = st_entry & SEGMENT_ENTRY_ORIGIN;
     offs  = (vaddr & VADDR_PX) >> 9;
     pt_entry = ldq_phys(cs->as, origin + offs);
     PTE_DPRINTF("%s: 0x%" PRIx64 " + 0x%" PRIx64 " => 0x%016" PRIx64 "\n",
@@ -223,39 +223,39 @@ static int mmu_translate_region(CPUS390XState *env, target_ulong vaddr,
 
     PTE_DPRINTF("%s: 0x%" PRIx64 "\n", __func__, entry);
 
-    origin = entry & _REGION_ENTRY_ORIGIN;
+    origin = entry & REGION_ENTRY_ORIGIN;
     offs = (vaddr >> (17 + 11 * level / 4)) & 0x3ff8;
 
     new_entry = ldq_phys(cs->as, origin + offs);
     PTE_DPRINTF("%s: 0x%" PRIx64 " + 0x%" PRIx64 " => 0x%016" PRIx64 "\n",
                 __func__, origin, offs, new_entry);
 
-    if ((new_entry & _REGION_ENTRY_INV) != 0) {
+    if ((new_entry & REGION_ENTRY_INV) != 0) {
         DPRINTF("%s: invalid region\n", __func__);
         trigger_page_fault(env, vaddr, pchks[level / 4], asc, rw, exc);
         return -1;
     }
 
-    if ((new_entry & _REGION_ENTRY_TYPE_MASK) != level) {
+    if ((new_entry & REGION_ENTRY_TYPE_MASK) != level) {
         trigger_page_fault(env, vaddr, PGM_TRANS_SPEC, asc, rw, exc);
         return -1;
     }
 
-    if (level == _ASCE_TYPE_SEGMENT) {
+    if (level == ASCE_TYPE_SEGMENT) {
         return mmu_translate_segment(env, vaddr, asc, new_entry, raddr, flags,
                                      rw, exc);
     }
 
     /* Check region table offset and length */
     offs = (vaddr >> (28 + 11 * (level - 4) / 4)) & 3;
-    if (offs < ((new_entry & _REGION_ENTRY_TF) >> 6)
-        || offs > (new_entry & _REGION_ENTRY_LENGTH)) {
+    if (offs < ((new_entry & REGION_ENTRY_TF) >> 6)
+        || offs > (new_entry & REGION_ENTRY_LENGTH)) {
         DPRINTF("%s: invalid offset or len (%lx)\n", __func__, new_entry);
         trigger_page_fault(env, vaddr, pchks[level / 4 - 1], asc, rw, exc);
         return -1;
     }
 
-    if ((env->cregs[0] & CR0_EDAT) && (new_entry & _REGION_ENTRY_RO)) {
+    if ((env->cregs[0] & CR0_EDAT) && (new_entry & REGION_ENTRY_RO)) {
         *flags &= ~PAGE_WRITE;
     }
 
@@ -271,52 +271,52 @@ static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
     int level;
     int r;
 
-    if (asce & _ASCE_REAL_SPACE) {
+    if (asce & ASCE_REAL_SPACE) {
         /* direct mapping */
         *raddr = vaddr;
         return 0;
     }
 
-    level = asce & _ASCE_TYPE_MASK;
+    level = asce & ASCE_TYPE_MASK;
     switch (level) {
-    case _ASCE_TYPE_REGION1:
-        if ((vaddr >> 62) > (asce & _ASCE_TABLE_LENGTH)) {
+    case ASCE_TYPE_REGION1:
+        if ((vaddr >> 62) > (asce & ASCE_TABLE_LENGTH)) {
             trigger_page_fault(env, vaddr, PGM_REG_FIRST_TRANS, asc, rw, exc);
             return -1;
         }
         break;
-    case _ASCE_TYPE_REGION2:
+    case ASCE_TYPE_REGION2:
         if (vaddr & 0xffe0000000000000ULL) {
             DPRINTF("%s: vaddr doesn't fit 0x%16" PRIx64
                     " 0xffe0000000000000ULL\n", __func__, vaddr);
             trigger_page_fault(env, vaddr, PGM_ASCE_TYPE, asc, rw, exc);
             return -1;
         }
-        if ((vaddr >> 51 & 3) > (asce & _ASCE_TABLE_LENGTH)) {
+        if ((vaddr >> 51 & 3) > (asce & ASCE_TABLE_LENGTH)) {
             trigger_page_fault(env, vaddr, PGM_REG_SEC_TRANS, asc, rw, exc);
             return -1;
         }
         break;
-    case _ASCE_TYPE_REGION3:
+    case ASCE_TYPE_REGION3:
         if (vaddr & 0xfffffc0000000000ULL) {
             DPRINTF("%s: vaddr doesn't fit 0x%16" PRIx64
                     " 0xfffffc0000000000ULL\n", __func__, vaddr);
             trigger_page_fault(env, vaddr, PGM_ASCE_TYPE, asc, rw, exc);
             return -1;
         }
-        if ((vaddr >> 40 & 3) > (asce & _ASCE_TABLE_LENGTH)) {
+        if ((vaddr >> 40 & 3) > (asce & ASCE_TABLE_LENGTH)) {
             trigger_page_fault(env, vaddr, PGM_REG_THIRD_TRANS, asc, rw, exc);
             return -1;
         }
         break;
-    case _ASCE_TYPE_SEGMENT:
+    case ASCE_TYPE_SEGMENT:
         if (vaddr & 0xffffffff80000000ULL) {
             DPRINTF("%s: vaddr doesn't fit 0x%16" PRIx64
                     " 0xffffffff80000000ULL\n", __func__, vaddr);
             trigger_page_fault(env, vaddr, PGM_ASCE_TYPE, asc, rw, exc);
             return -1;
         }
-        if ((vaddr >> 29 & 3) > (asce & _ASCE_TABLE_LENGTH)) {
+        if ((vaddr >> 29 & 3) > (asce & ASCE_TABLE_LENGTH)) {
             trigger_page_fault(env, vaddr, PGM_SEGMENT_TRANS, asc, rw, exc);
             return -1;
         }
-- 
2.13.6
