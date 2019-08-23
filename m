Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E17C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D296421874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D296421874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Ecx-0005To-RU
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 14:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1EOP-0000O1-5p
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1EOM-00083l-SX
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:34:33 -0400
Received: from nsstlmta25p.bpe.bigpond.com ([203.38.21.25]:52153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i1EOL-000822-VD
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:34:30 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep25p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823183425.NRLH14235.nsstlfep25p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 04:34:25 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopegusgiirdhtvghlshhtrhgrrdgtohhmrdgruhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeomhhsthesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgsohhniihinhhisehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeorhhitghhrghrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhgqedprhgtphhtthhopeeorhhthhesthifihguughlvgdrnhgvtheqpdhrtghpthhtohepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3692920C8AF2E7; Sat, 24 Aug 2019 04:34:24 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 04:36:54 +1000
Message-Id: <911ff31af11922a9afba9b7ce128af8b8b80f316.1566466906.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566466906.git.tony.nguyen@bt.com>
References: <cover.1566466906.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.25
Subject: [Qemu-devel] [PATCH v9 16/20] memory: Single byte swap along the
 I/O path
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tony Nguyen <tony.nguyen@bt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that MemOp has been pushed down into the memory API, and
callers are encoding endianness, we can collapse byte swaps
along the I/O path into the accelerator and target independent
adjust_endianness.

Collapsing byte swaps along the I/O path enables additional endian
inversion logic, e.g. SPARC64 Invert Endian TTE bit, with redundant
byte swaps cancelling out.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 accel/tcg/cputlb.c     | 42 ++--------------------------
 exec.c                 | 17 +++---------
 hw/virtio/virtio-pci.c | 10 +++----
 memory.c               | 33 ++++++++--------------
 memory_ldst.inc.c      | 63 ------------------------------------------
 5 files changed, 23 insertions(+), 142 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5c12eef292..3c9e634d99 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1200,38 +1200,6 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     cpu_loop_exit_atomic(env_cpu(env), retaddr);
 }
 
-#ifdef TARGET_WORDS_BIGENDIAN
-#define NEED_BE_BSWAP 0
-#define NEED_LE_BSWAP 1
-#else
-#define NEED_BE_BSWAP 1
-#define NEED_LE_BSWAP 0
-#endif
-
-/*
- * Byte Swap Helper
- *
- * This should all dead code away depending on the build host and
- * access type.
- */
-
-static inline uint64_t handle_bswap(uint64_t val, MemOp op)
-{
-    if ((memop_big_endian(op) && NEED_BE_BSWAP) ||
-        (!memop_big_endian(op) && NEED_LE_BSWAP)) {
-        switch (op & MO_SIZE) {
-        case MO_8: return val;
-        case MO_16: return bswap16(val);
-        case MO_32: return bswap32(val);
-        case MO_64: return bswap64(val);
-        default:
-            g_assert_not_reached();
-        }
-    } else {
-        return val;
-    }
-}
-
 /*
  * Load Helpers
  *
@@ -1306,10 +1274,8 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             }
         }
 
-        /* TODO: Merge bswap into io_readx -> memory_region_dispatch_read.  */
-        res = io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
-                       mmu_idx, addr, retaddr, access_type, op);
-        return handle_bswap(res, op);
+        return io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
+                        mmu_idx, addr, retaddr, access_type, op);
     }
 
     /* Handle slow unaligned access (it spans two pages or IO).  */
@@ -1552,10 +1518,8 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
             }
         }
 
-        /* TODO: Merge bswap into io_writex -> memory_region_dispatch_write.  */
         io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
-                  handle_bswap(val, op),
-                  addr, retaddr, op);
+                  val, addr, retaddr, op);
         return;
     }
 
diff --git a/exec.c b/exec.c
index 39aff6810b..b3c38be5df 100644
--- a/exec.c
+++ b/exec.c
@@ -3363,14 +3363,9 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
             l = memory_access_size(mr, l, addr1);
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
-            val = ldn_p(buf, l);
-            /*
-             * TODO: Merge bswap from ldn_p into memory_region_dispatch_write
-             * by using ldn_he_p and dropping MO_TE to get a host-endian value.
-             */
+            val = ldn_he_p(buf, l);
             result |= memory_region_dispatch_write(mr, addr1, val,
-                                                   size_memop(l) | MO_TE,
-                                                   attrs);
+                                                   size_memop(l), attrs);
         } else {
             /* RAM case */
             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
@@ -3431,13 +3426,9 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             /* I/O case */
             release_lock |= prepare_mmio_access(mr);
             l = memory_access_size(mr, l, addr1);
-            /*
-             * TODO: Merge bswap from stn_p into memory_region_dispatch_read
-             * by using stn_he_p and dropping MO_TE to get a host-endian value.
-             */
             result |= memory_region_dispatch_read(mr, addr1, &val,
-                                                  size_memop(l) | MO_TE, attrs);
-            stn_p(buf, l, val);
+                                                  size_memop(l), attrs);
+            stn_he_p(buf, l, val);
         } else {
             /* RAM case */
             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index d89a85bb33..ffb03728f9 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -544,16 +544,15 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, hwaddr addr,
         val = pci_get_byte(buf);
         break;
     case 2:
-        val = cpu_to_le16(pci_get_word(buf));
+        val = pci_get_word(buf);
         break;
     case 4:
-        val = cpu_to_le32(pci_get_long(buf));
+        val = pci_get_long(buf);
         break;
     default:
         /* As length is under guest control, handle illegal values. */
         return;
     }
-    /* TODO: Merge bswap from cpu_to_leXX into memory_region_dispatch_write.  */
     memory_region_dispatch_write(mr, addr, val, size_memop(len) | MO_LE,
                                  MEMTXATTRS_UNSPECIFIED);
 }
@@ -578,7 +577,6 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr addr,
     /* Make sure caller aligned buf properly */
     assert(!(((uintptr_t)buf) & (len - 1)));
 
-    /* TODO: Merge bswap from leXX_to_cpu into memory_region_dispatch_read.  */
     memory_region_dispatch_read(mr, addr, &val, size_memop(len) | MO_LE,
                                 MEMTXATTRS_UNSPECIFIED);
     switch (len) {
@@ -586,10 +584,10 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr addr,
         pci_set_byte(buf, val);
         break;
     case 2:
-        pci_set_word(buf, le16_to_cpu(val));
+        pci_set_word(buf, val);
         break;
     case 4:
-        pci_set_long(buf, le32_to_cpu(val));
+        pci_set_long(buf, val);
         break;
     default:
         /* As length is under guest control, handle illegal values. */
diff --git a/memory.c b/memory.c
index 66ba23280a..11a9b08060 100644
--- a/memory.c
+++ b/memory.c
@@ -352,32 +352,23 @@ static bool memory_region_big_endian(MemoryRegion *mr)
 #endif
 }
 
-static bool memory_region_wrong_endianness(MemoryRegion *mr)
+static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
 {
-#ifdef TARGET_WORDS_BIGENDIAN
-    return mr->ops->endianness == DEVICE_LITTLE_ENDIAN;
-#else
-    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
-#endif
-}
-
-static void adjust_endianness(MemoryRegion *mr, uint64_t *data, unsigned size)
-{
-    if (memory_region_wrong_endianness(mr)) {
-        switch (size) {
-        case 1:
+    if ((op & MO_BSWAP) != devend_memop(mr->ops->endianness)) {
+        switch (op & MO_SIZE) {
+        case MO_8:
             break;
-        case 2:
+        case MO_16:
             *data = bswap16(*data);
             break;
-        case 4:
+        case MO_32:
             *data = bswap32(*data);
             break;
-        case 8:
+        case MO_64:
             *data = bswap64(*data);
             break;
         default:
-            abort();
+            g_assert_not_reached();
         }
     }
 }
@@ -1451,7 +1442,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
     }
 
     r = memory_region_dispatch_read1(mr, addr, pval, size, attrs);
-    adjust_endianness(mr, pval, size);
+    adjust_endianness(mr, pval, op);
     return r;
 }
 
@@ -1494,7 +1485,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
         return MEMTX_DECODE_ERROR;
     }
 
-    adjust_endianness(mr, &data, size);
+    adjust_endianness(mr, &data, op);
 
     if ((!kvm_eventfds_enabled()) &&
         memory_region_dispatch_write_eventfds(mr, addr, data, size, attrs)) {
@@ -2345,7 +2336,7 @@ void memory_region_add_eventfd(MemoryRegion *mr,
     }
 
     if (size) {
-        adjust_endianness(mr, &mrfd.data, size);
+        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
@@ -2380,7 +2371,7 @@ void memory_region_del_eventfd(MemoryRegion *mr,
     unsigned i;
 
     if (size) {
-        adjust_endianness(mr, &mrfd.data, size);
+        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index 809a7e8389..c54aee4a95 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -38,18 +38,8 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        /* TODO: Merge bswap32 into memory_region_dispatch_read.  */
         r = memory_region_dispatch_read(mr, addr1, &val,
                                         MO_32 | devend_memop(endian), attrs);
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap32(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap32(val);
-        }
-#endif
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -116,18 +106,8 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        /* TODO: Merge bswap64 into memory_region_dispatch_read.  */
         r = memory_region_dispatch_read(mr, addr1, &val,
                                         MO_64 | devend_memop(endian), attrs);
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap64(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap64(val);
-        }
-#endif
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -228,18 +208,8 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        /* TODO: Merge bswap16 into memory_region_dispatch_read.  */
         r = memory_region_dispatch_read(mr, addr1, &val,
                                         MO_16 | devend_memop(endian), attrs);
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap16(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap16(val);
-        }
-#endif
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -342,17 +312,6 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 4 || !memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
-
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap32(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap32(val);
-        }
-#endif
-        /* TODO: Merge bswap32 into memory_region_dispatch_write.  */
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_32 | devend_memop(endian), attrs);
     } else {
@@ -449,17 +408,6 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 2 || !memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
-
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap16(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap16(val);
-        }
-#endif
-        /* TODO: Merge bswap16 into memory_region_dispatch_write.  */
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_16 | devend_memop(endian), attrs);
     } else {
@@ -524,17 +472,6 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 8 || !memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
-
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap64(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap64(val);
-        }
-#endif
-        /* TODO: Merge bswap64 into memory_region_dispatch_write.  */
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_64 | devend_memop(endian), attrs);
     } else {
-- 
2.23.0


