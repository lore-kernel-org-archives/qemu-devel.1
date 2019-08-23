Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E1FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3523221874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3523221874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1EZR-0002oe-VV
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 14:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1EON-0000L5-78
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1EOK-00083I-US
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:34:31 -0400
Received: from nsstlmta18p.bpe.bigpond.com ([203.38.21.18]:44105)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1i1EOK-000815-1o; Fri, 23 Aug 2019 14:34:28 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep18p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823183422.CPXV10803.nsstlfep18p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 04:34:22 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucffohhmrghinheprghtthhrshdrshgvtghurhgvnecukfhppeehkedrudejfedrleekrdeikeenucfrrghrrghmpehhvghlohepuggsiidrthgvlhhsthhrrgdrtghomhdrrghupdhinhgvthepheekrddujeefrdelkedrieekpdhmrghilhhfrhhomhepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqpdhrtghpthhtohepoegrlhgvgidrfihilhhlihgrmhhsohhnsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoegsohhrnhhtrhgrvghgvghrseguvgdrihgsmhdrtghomheqpdhrtghpthhtohepoegtohhhuhgtkhesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeouggrvhhiugesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeomhhsthesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgrshhitgeslhhinhhugidrihgsmhdrtghomheqpdhrtghpthhtohepoehpsghonhiiihhnihesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeo
 phgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdhsfeeltdigsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehrthhhsehtfihiuggulhgvrdhnvghtqedprhgtphhtthhopeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeofigrlhhlihhngheslhhinhhugidrihgsmhdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3692920C8AF25F; Sat, 24 Aug 2019 04:34:22 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 04:36:52 +1000
Message-Id: <8066ab3eb037c0388dfadfe53c5118429dd1de3a.1566466906.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566466906.git.tony.nguyen@bt.com>
References: <cover.1566466906.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.18
Subject: [Qemu-devel] [PATCH v9 14/20] memory: Access MemoryRegion with
 endianness
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Collin Walling <walling@linux.ibm.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Preparation for collapsing the two byte swaps adjust_endianness and
handle_bswap into the former.

Call memory_region_dispatch_{read|write} with endianness encoded into
the "MemOp op" operand.

This patch does not change any behaviour as
memory_region_dispatch_{read|write} is yet to handle the endianness.

Once it does handle endianness, callers with byte swaps can collapse
them into adjust_endianness.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 accel/tcg/cputlb.c       |  8 ++++++--
 exec.c                   | 13 +++++++++++--
 hw/intc/armv7m_nvic.c    | 15 ++++++++-------
 hw/s390x/s390-pci-inst.c |  6 ++++--
 hw/vfio/pci-quirks.c     |  5 +++--
 hw/virtio/virtio-pci.c   |  6 ++++--
 include/exec/memory.h    |  3 +++
 memory.c                 | 18 ++++++++++++++++++
 memory_ldst.inc.c        | 24 ++++++++++++++++++------
 9 files changed, 75 insertions(+), 23 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6c83878f73..f64c6b1c75 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -906,7 +906,8 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked = true;
     }
-    r = memory_region_dispatch_read(mr, mr_offset, &val, size_memop(size),
+    r = memory_region_dispatch_read(mr, mr_offset, &val,
+                                    size_memop(size) | MO_TE,
                                     iotlbentry->attrs);
     if (r != MEMTX_OK) {
         hwaddr physaddr = mr_offset +
@@ -947,7 +948,8 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked = true;
     }
-    r = memory_region_dispatch_write(mr, mr_offset, val, size_memop(size),
+    r = memory_region_dispatch_write(mr, mr_offset, val,
+                                     size_memop(size) | MO_TE,
                                      iotlbentry->attrs);
     if (r != MEMTX_OK) {
         hwaddr physaddr = mr_offset +
@@ -1305,6 +1307,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             }
         }
 
+        /* TODO: Merge bswap into io_readx -> memory_region_dispatch_read.  */
         res = io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
                        mmu_idx, addr, retaddr, access_type, size);
         return handle_bswap(res, size, big_endian);
@@ -1553,6 +1556,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
             }
         }
 
+        /* TODO: Merge bswap into io_writex -> memory_region_dispatch_write.  */
         io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
                   handle_bswap(val, size, big_endian),
                   addr, retaddr, size);
diff --git a/exec.c b/exec.c
index 73d629b9c8..39aff6810b 100644
--- a/exec.c
+++ b/exec.c
@@ -3364,8 +3364,13 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
             val = ldn_p(buf, l);
+            /*
+             * TODO: Merge bswap from ldn_p into memory_region_dispatch_write
+             * by using ldn_he_p and dropping MO_TE to get a host-endian value.
+             */
             result |= memory_region_dispatch_write(mr, addr1, val,
-                                                   size_memop(l), attrs);
+                                                   size_memop(l) | MO_TE,
+                                                   attrs);
         } else {
             /* RAM case */
             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
@@ -3426,8 +3431,12 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             /* I/O case */
             release_lock |= prepare_mmio_access(mr);
             l = memory_access_size(mr, l, addr1);
+            /*
+             * TODO: Merge bswap from stn_p into memory_region_dispatch_read
+             * by using stn_he_p and dropping MO_TE to get a host-endian value.
+             */
             result |= memory_region_dispatch_read(mr, addr1, &val,
-                                                  size_memop(l), attrs);
+                                                  size_memop(l) | MO_TE, attrs);
             stn_p(buf, l, val);
         } else {
             /* RAM case */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 7220940133..8e93e51e81 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2349,8 +2349,8 @@ static MemTxResult nvic_sysreg_ns_write(void *opaque, hwaddr addr,
     if (attrs.secure) {
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
-        return memory_region_dispatch_write(mr, addr, value, size_memop(size),
-                                            attrs);
+        return memory_region_dispatch_write(mr, addr, value,
+                                            size_memop(size) | MO_TE, attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -2369,8 +2369,8 @@ static MemTxResult nvic_sysreg_ns_read(void *opaque, hwaddr addr,
     if (attrs.secure) {
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
-        return memory_region_dispatch_read(mr, addr, data, size_memop(size),
-                                           attrs);
+        return memory_region_dispatch_read(mr, addr, data,
+                                           size_memop(size) | MO_TE, attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -2396,8 +2396,8 @@ static MemTxResult nvic_systick_write(void *opaque, hwaddr addr,
 
     /* Direct the access to the correct systick */
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
-    return memory_region_dispatch_write(mr, addr, value, size_memop(size),
-                                        attrs);
+    return memory_region_dispatch_write(mr, addr, value,
+                                        size_memop(size) | MO_TE, attrs);
 }
 
 static MemTxResult nvic_systick_read(void *opaque, hwaddr addr,
@@ -2409,7 +2409,8 @@ static MemTxResult nvic_systick_read(void *opaque, hwaddr addr,
 
     /* Direct the access to the correct systick */
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
-    return memory_region_dispatch_read(mr, addr, data, size_memop(size), attrs);
+    return memory_region_dispatch_read(mr, addr, data, size_memop(size) | MO_TE,
+                                       attrs);
 }
 
 static const MemoryRegionOps nvic_systick_ops = {
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 0e92a372ca..4b3bd4a804 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -373,7 +373,8 @@ static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
     offset -= mr->addr;
-    return memory_region_dispatch_read(mr, offset, data, size_memop(len),
+    return memory_region_dispatch_read(mr, offset, data,
+                                       size_memop(len) | MO_BE,
                                        MEMTXATTRS_UNSPECIFIED);
 }
 
@@ -472,7 +473,8 @@ static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
     offset -= mr->addr;
-    return memory_region_dispatch_write(mr, offset, data, size_memop(len),
+    return memory_region_dispatch_write(mr, offset, data,
+                                        size_memop(len) | MO_BE,
                                         MEMTXATTRS_UNSPECIFIED);
 }
 
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index a4e1d2abb5..136f3a9ad6 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1074,7 +1074,8 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
 
                 /* Write to the proper guest MSI-X table instead */
                 memory_region_dispatch_write(&vdev->pdev.msix_table_mmio,
-                                             offset, val, size_memop(size),
+                                             offset, val,
+                                             size_memop(size) | MO_LE,
                                              MEMTXATTRS_UNSPECIFIED);
             }
             return; /* Do not write guest MSI-X data to hardware */
@@ -1105,7 +1106,7 @@ static uint64_t vfio_rtl8168_quirk_data_read(void *opaque,
     if (rtl->enabled && (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX)) {
         hwaddr offset = rtl->addr & 0xfff;
         memory_region_dispatch_read(&vdev->pdev.msix_table_mmio, offset,
-                                    &data, size_memop(size),
+                                    &data, size_memop(size) | MO_LE,
                                     MEMTXATTRS_UNSPECIFIED);
         trace_vfio_quirk_rtl8168_msix_read(vdev->vbasedev.name, offset, data);
     }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 82c5e87a44..d89a85bb33 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -553,7 +553,8 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, hwaddr addr,
         /* As length is under guest control, handle illegal values. */
         return;
     }
-    memory_region_dispatch_write(mr, addr, val, size_memop(len),
+    /* TODO: Merge bswap from cpu_to_leXX into memory_region_dispatch_write.  */
+    memory_region_dispatch_write(mr, addr, val, size_memop(len) | MO_LE,
                                  MEMTXATTRS_UNSPECIFIED);
 }
 
@@ -577,7 +578,8 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr addr,
     /* Make sure caller aligned buf properly */
     assert(!(((uintptr_t)buf) & (len - 1)));
 
-    memory_region_dispatch_read(mr, addr, &val, size_memop(len),
+    /* TODO: Merge bswap from leXX_to_cpu into memory_region_dispatch_read.  */
+    memory_region_dispatch_read(mr, addr, &val, size_memop(len) | MO_LE,
                                 MEMTXATTRS_UNSPECIFIED);
     switch (len) {
     case 1:
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 192875b080..c4c86a6ff4 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2211,6 +2211,9 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
     }
 }
 
+/* enum device_endian to MemOp.  */
+MemOp devend_memop(enum device_endian end);
+
 #endif
 
 #endif
diff --git a/memory.c b/memory.c
index d898ad212e..66ba23280a 100644
--- a/memory.c
+++ b/memory.c
@@ -3280,3 +3280,21 @@ static void memory_register_types(void)
 }
 
 type_init(memory_register_types)
+
+MemOp devend_memop(enum device_endian end)
+{
+    static MemOp conv[] = {
+        [DEVICE_LITTLE_ENDIAN] = MO_LE,
+        [DEVICE_BIG_ENDIAN] = MO_BE,
+        [DEVICE_NATIVE_ENDIAN] = MO_TE,
+        [DEVICE_HOST_ENDIAN] = 0,
+    };
+    switch (end) {
+    case DEVICE_LITTLE_ENDIAN:
+    case DEVICE_BIG_ENDIAN:
+    case DEVICE_NATIVE_ENDIAN:
+        return conv[end];
+    default:
+        g_assert_not_reached();
+    }
+}
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index de658c40c4..809a7e8389 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -38,7 +38,9 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, MO_32, attrs);
+        /* TODO: Merge bswap32 into memory_region_dispatch_read.  */
+        r = memory_region_dispatch_read(mr, addr1, &val,
+                                        MO_32 | devend_memop(endian), attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap32(val);
@@ -114,7 +116,9 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, MO_64, attrs);
+        /* TODO: Merge bswap64 into memory_region_dispatch_read.  */
+        r = memory_region_dispatch_read(mr, addr1, &val,
+                                        MO_64 | devend_memop(endian), attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap64(val);
@@ -224,7 +228,9 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, MO_16, attrs);
+        /* TODO: Merge bswap16 into memory_region_dispatch_read.  */
+        r = memory_region_dispatch_read(mr, addr1, &val,
+                                        MO_16 | devend_memop(endian), attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap16(val);
@@ -346,7 +352,9 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
             val = bswap32(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
+        /* TODO: Merge bswap32 into memory_region_dispatch_write.  */
+        r = memory_region_dispatch_write(mr, addr1, val,
+                                         MO_32 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -451,7 +459,9 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
             val = bswap16(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, MO_16, attrs);
+        /* TODO: Merge bswap16 into memory_region_dispatch_write.  */
+        r = memory_region_dispatch_write(mr, addr1, val,
+                                         MO_16 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -524,7 +534,9 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
             val = bswap64(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, MO_64, attrs);
+        /* TODO: Merge bswap64 into memory_region_dispatch_write.  */
+        r = memory_region_dispatch_write(mr, addr1, val,
+                                         MO_64 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-- 
2.23.0


