Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29263C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA26E208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA26E208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnd5b-0002vx-5A
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 02:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59588)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hnd5N-0002V0-OP
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hnd5L-000582-4x
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:06:41 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.71]:3424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1hnd5K-00057k-PN
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:06:39 -0400
Received: from tpw09926dag18f.domain1.systemhost.net (10.9.212.26) by
 BWP09926076.bt.com (10.36.82.107) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Wed, 17
 Jul 2019 07:06:36 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18f.domain1.systemhost.net (10.9.212.26) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jul 2019 07:06:36 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Wed, 17 Jul
 2019 07:06:36 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 2/4] memory: Single byte swap along the I/O
 path
Thread-Index: AQHVPGXKIM8i1YWtwkykGX0aHoqHKA==
Date: Wed, 17 Jul 2019 06:06:36 +0000
Message-ID: <1563343596429.3033@bt.com>
References: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <a5f7f8854af046c18c6342035662a193@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.71
Subject: [Qemu-devel] [PATCH 2/4] memory: Single byte swap along the I/O path
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
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Collapsed adjust_endianess and handle_bswap into the former.=0A=
=0A=
A single byte swap avoids redundant re-swapping.=0A=
=0A=
This is preparation for upcoming SPARC64 TTE invert endian bit which=0A=
would be a third(!) byte swap along the I/O path.=0A=
=0A=
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>=0A=
---=0A=
 accel/tcg/cputlb.c       | 58 +++++++++++++++++++---------------------=0A=
 exec.c                   |  6 +++--=0A=
 hw/intc/armv7m_nvic.c    | 12 ++++-----=0A=
 hw/s390x/s390-pci-inst.c |  6 ++---=0A=
 hw/vfio/pci-quirks.c     |  4 +--=0A=
 hw/virtio/virtio-pci.c   |  6 +++--=0A=
 include/exec/memop.h     | 18 +++++++++++++=0A=
 include/exec/memory.h    |  9 ++++---=0A=
 include/exec/poison.h    |  1 -=0A=
 memory.c                 | 37 ++++++++++++++-----------=0A=
 memory_ldst.inc.c        | 18 ++++++-------=0A=
 target/mips/op_helper.c  |  4 +--=0A=
 12 files changed, 102 insertions(+), 77 deletions(-)=0A=
=0A=
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c=0A=
index 523be4c848..baa61719ad 100644=0A=
--- a/accel/tcg/cputlb.c=0A=
+++ b/accel/tcg/cputlb.c=0A=
@@ -881,7 +881,7 @@ static void tlb_fill(CPUState *cpu, target_ulong addr, =
int size,=0A=
 =0A=
 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,=0A=
                          int mmu_idx, target_ulong addr, uintptr_t retaddr=
,=0A=
-                         MMUAccessType access_type, int size)=0A=
+                         MMUAccessType access_type, MemOp op)=0A=
 {=0A=
     CPUState *cpu =3D env_cpu(env);=0A=
     hwaddr mr_offset;=0A=
@@ -906,14 +906,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBE=
ntry *iotlbentry,=0A=
         qemu_mutex_lock_iothread();=0A=
         locked =3D true;=0A=
     }=0A=
-    r =3D memory_region_dispatch_read(mr, mr_offset,=0A=
-                                    &val, size, iotlbentry->attrs);=0A=
+    r =3D memory_region_dispatch_read(mr, mr_offset, &val, op, iotlbentry-=
>attrs);=0A=
     if (r !=3D MEMTX_OK) {=0A=
         hwaddr physaddr =3D mr_offset +=0A=
             section->offset_within_address_space -=0A=
             section->offset_within_region;=0A=
 =0A=
-        cpu_transaction_failed(cpu, physaddr, addr, size, access_type,=0A=
+        cpu_transaction_failed(cpu, physaddr, addr, MEMOP_SIZE(op), access=
_type,=0A=
                                mmu_idx, iotlbentry->attrs, r, retaddr);=0A=
     }=0A=
     if (locked) {=0A=
@@ -925,7 +924,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEnt=
ry *iotlbentry,=0A=
 =0A=
 static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,=0A=
                       int mmu_idx, uint64_t val, target_ulong addr,=0A=
-                      uintptr_t retaddr, int size)=0A=
+                      uintptr_t retaddr, MemOp op)=0A=
 {=0A=
     CPUState *cpu =3D env_cpu(env);=0A=
     hwaddr mr_offset;=0A=
@@ -947,15 +946,15 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntr=
y *iotlbentry,=0A=
         qemu_mutex_lock_iothread();=0A=
         locked =3D true;=0A=
     }=0A=
-    r =3D memory_region_dispatch_write(mr, mr_offset,=0A=
-                                     val, size, iotlbentry->attrs);=0A=
+    r =3D memory_region_dispatch_write(mr, mr_offset, val, op, iotlbentry-=
>attrs);=0A=
     if (r !=3D MEMTX_OK) {=0A=
         hwaddr physaddr =3D mr_offset +=0A=
             section->offset_within_address_space -=0A=
             section->offset_within_region;=0A=
 =0A=
-        cpu_transaction_failed(cpu, physaddr, addr, size, MMU_DATA_STORE,=
=0A=
-                               mmu_idx, iotlbentry->attrs, r, retaddr);=0A=
+        cpu_transaction_failed(cpu, physaddr, addr, MEMOP_SIZE(op),=0A=
+                               MMU_DATA_STORE, mmu_idx, iotlbentry->attrs,=
 r,=0A=
+                               retaddr);=0A=
     }=0A=
     if (locked) {=0A=
         qemu_mutex_unlock_iothread();=0A=
@@ -1210,26 +1209,13 @@ static void *atomic_mmu_lookup(CPUArchState *env, t=
arget_ulong addr,=0A=
 #endif=0A=
 =0A=
 /*=0A=
- * Byte Swap Helper=0A=
+ * Byte Swap Checker=0A=
  *=0A=
- * This should all dead code away depending on the build host and=0A=
- * access type.=0A=
+ * Dead code should all go away depending on the build host and access typ=
e.=0A=
  */=0A=
-=0A=
-static inline uint64_t handle_bswap(uint64_t val, int size, bool big_endia=
n)=0A=
+static inline bool need_bswap(bool big_endian)=0A=
 {=0A=
-    if ((big_endian && NEED_BE_BSWAP) || (!big_endian && NEED_LE_BSWAP)) {=
=0A=
-        switch (size) {=0A=
-        case 1: return val;=0A=
-        case 2: return bswap16(val);=0A=
-        case 4: return bswap32(val);=0A=
-        case 8: return bswap64(val);=0A=
-        default:=0A=
-            g_assert_not_reached();=0A=
-        }=0A=
-    } else {=0A=
-        return val;=0A=
-    }=0A=
+    return (big_endian && NEED_BE_BSWAP) || (!big_endian && NEED_LE_BSWAP)=
;=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -1260,6 +1246,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCG=
MemOpIdx oi,=0A=
     unsigned a_bits =3D get_alignment_bits(get_memop(oi));=0A=
     void *haddr;=0A=
     uint64_t res;=0A=
+    MemOp op;=0A=
 =0A=
     /* Handle CPU specific unaligned behaviour */=0A=
     if (addr & ((1 << a_bits) - 1)) {=0A=
@@ -1305,9 +1292,13 @@ load_helper(CPUArchState *env, target_ulong addr, TC=
GMemOpIdx oi,=0A=
             }=0A=
         }=0A=
 =0A=
-        res =3D io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],=0A=
-                       mmu_idx, addr, retaddr, access_type, size);=0A=
-        return handle_bswap(res, size, big_endian);=0A=
+        op =3D MEMOP(size);=0A=
+        if (need_bswap(big_endian)) {=0A=
+            op ^=3D MO_BSWAP;=0A=
+        }=0A=
+=0A=
+        return io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],=0A=
+                       mmu_idx, addr, retaddr, access_type, op);=0A=
     }=0A=
 =0A=
     /* Handle slow unaligned access (it spans two pages or IO).  */=0A=
@@ -1508,6 +1499,7 @@ store_helper(CPUArchState *env, target_ulong addr, ui=
nt64_t val,=0A=
     const size_t tlb_off =3D offsetof(CPUTLBEntry, addr_write);=0A=
     unsigned a_bits =3D get_alignment_bits(get_memop(oi));=0A=
     void *haddr;=0A=
+    MemOp op;=0A=
 =0A=
     /* Handle CPU specific unaligned behaviour */=0A=
     if (addr & ((1 << a_bits) - 1)) {=0A=
@@ -1553,9 +1545,13 @@ store_helper(CPUArchState *env, target_ulong addr, u=
int64_t val,=0A=
             }=0A=
         }=0A=
 =0A=
+        op =3D MEMOP(size);=0A=
+        if (need_bswap(big_endian)) {=0A=
+            op ^=3D MO_BSWAP;=0A=
+        }=0A=
+=0A=
         io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,=0A=
-                  handle_bswap(val, size, big_endian),=0A=
-                  addr, retaddr, size);=0A=
+                  val, addr, retaddr, op);=0A=
         return;=0A=
     }=0A=
 =0A=
diff --git a/exec.c b/exec.c=0A=
index 3e78de3b8f..456e7ae02a 100644=0A=
--- a/exec.c=0A=
+++ b/exec.c=0A=
@@ -3334,7 +3334,8 @@ static MemTxResult flatview_write_continue(FlatView *=
fv, hwaddr addr,=0A=
             /* XXX: could force current_cpu to NULL to avoid=0A=
                potential bugs */=0A=
             val =3D ldn_p(buf, l);=0A=
-            result |=3D memory_region_dispatch_write(mr, addr1, val, l, at=
trs);=0A=
+            result |=3D memory_region_dispatch_write(mr, addr1, val, MEMOP=
(l),=0A=
+                                                   attrs);=0A=
         } else {=0A=
             /* RAM case */=0A=
             ptr =3D qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);=
=0A=
@@ -3395,7 +3396,8 @@ MemTxResult flatview_read_continue(FlatView *fv, hwad=
dr addr,=0A=
             /* I/O case */=0A=
             release_lock |=3D prepare_mmio_access(mr);=0A=
             l =3D memory_access_size(mr, l, addr1);=0A=
-            result |=3D memory_region_dispatch_read(mr, addr1, &val, l, at=
trs);=0A=
+            result |=3D memory_region_dispatch_read(mr, addr1, &val, MEMOP=
(l),=0A=
+                                                  attrs);=0A=
             stn_p(buf, l, val);=0A=
         } else {=0A=
             /* RAM case */=0A=
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c=0A=
index 9f8f0d3ff5..7081e6e128 100644=0A=
--- a/hw/intc/armv7m_nvic.c=0A=
+++ b/hw/intc/armv7m_nvic.c=0A=
@@ -2337,7 +2337,7 @@ static const MemoryRegionOps nvic_sysreg_ops =3D {=0A=
 };=0A=
 =0A=
 static MemTxResult nvic_sysreg_ns_write(void *opaque, hwaddr addr,=0A=
-                                        uint64_t value, unsigned size,=0A=
+                                        uint64_t data, unsigned size,=0A=
                                         MemTxAttrs attrs)=0A=
 {=0A=
     MemoryRegion *mr =3D opaque;=0A=
@@ -2345,7 +2345,7 @@ static MemTxResult nvic_sysreg_ns_write(void *opaque,=
 hwaddr addr,=0A=
     if (attrs.secure) {=0A=
         /* S accesses to the alias act like NS accesses to the real region=
 */=0A=
         attrs.secure =3D 0;=0A=
-        return memory_region_dispatch_write(mr, addr, value, size, attrs);=
=0A=
+        return memory_region_dispatch_write(mr, addr, data, MEMOP(size), a=
ttrs);=0A=
     } else {=0A=
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */=0A=
         if (attrs.user) {=0A=
@@ -2364,7 +2364,7 @@ static MemTxResult nvic_sysreg_ns_read(void *opaque, =
hwaddr addr,=0A=
     if (attrs.secure) {=0A=
         /* S accesses to the alias act like NS accesses to the real region=
 */=0A=
         attrs.secure =3D 0;=0A=
-        return memory_region_dispatch_read(mr, addr, data, size, attrs);=
=0A=
+        return memory_region_dispatch_read(mr, addr, data, MEMOP(size), at=
trs);=0A=
     } else {=0A=
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */=0A=
         if (attrs.user) {=0A=
@@ -2382,7 +2382,7 @@ static const MemoryRegionOps nvic_sysreg_ns_ops =3D {=
=0A=
 };=0A=
 =0A=
 static MemTxResult nvic_systick_write(void *opaque, hwaddr addr,=0A=
-                                      uint64_t value, unsigned size,=0A=
+                                      uint64_t data, unsigned size,=0A=
                                       MemTxAttrs attrs)=0A=
 {=0A=
     NVICState *s =3D opaque;=0A=
@@ -2390,7 +2390,7 @@ static MemTxResult nvic_systick_write(void *opaque, h=
waddr addr,=0A=
 =0A=
     /* Direct the access to the correct systick */=0A=
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]=
), 0);=0A=
-    return memory_region_dispatch_write(mr, addr, value, size, attrs);=0A=
+    return memory_region_dispatch_write(mr, addr, data, MEMOP(size), attrs=
);=0A=
 }=0A=
 =0A=
 static MemTxResult nvic_systick_read(void *opaque, hwaddr addr,=0A=
@@ -2402,7 +2402,7 @@ static MemTxResult nvic_systick_read(void *opaque, hw=
addr addr,=0A=
 =0A=
     /* Direct the access to the correct systick */=0A=
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]=
), 0);=0A=
-    return memory_region_dispatch_read(mr, addr, data, size, attrs);=0A=
+    return memory_region_dispatch_read(mr, addr, data, MEMOP(size), attrs)=
;=0A=
 }=0A=
 =0A=
 static const MemoryRegionOps nvic_systick_ops =3D {=0A=
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c=0A=
index 61f30b8e55..bf04fd2ed9 100644=0A=
--- a/hw/s390x/s390-pci-inst.c=0A=
+++ b/hw/s390x/s390-pci-inst.c=0A=
@@ -372,7 +372,7 @@ static MemTxResult zpci_read_bar(S390PCIBusDevice *pbde=
v, uint8_t pcias,=0A=
     mr =3D pbdev->pdev->io_regions[pcias].memory;=0A=
     mr =3D s390_get_subregion(mr, offset, len);=0A=
     offset -=3D mr->addr;=0A=
-    return memory_region_dispatch_read(mr, offset, data, len,=0A=
+    return memory_region_dispatch_read(mr, offset, data, MEMOP(len),=0A=
                                        MEMTXATTRS_UNSPECIFIED);=0A=
 }=0A=
 =0A=
@@ -471,7 +471,7 @@ static MemTxResult zpci_write_bar(S390PCIBusDevice *pbd=
ev, uint8_t pcias,=0A=
     mr =3D pbdev->pdev->io_regions[pcias].memory;=0A=
     mr =3D s390_get_subregion(mr, offset, len);=0A=
     offset -=3D mr->addr;=0A=
-    return memory_region_dispatch_write(mr, offset, data, len,=0A=
+    return memory_region_dispatch_write(mr, offset, data, MEMOP(len),=0A=
                                         MEMTXATTRS_UNSPECIFIED);=0A=
 }=0A=
 =0A=
@@ -780,7 +780,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8=
_t r3, uint64_t gaddr,=0A=
 =0A=
     for (i =3D 0; i < len / 8; i++) {=0A=
         result =3D memory_region_dispatch_write(mr, offset + i * 8,=0A=
-                                              ldq_p(buffer + i * 8), 8,=0A=
+                                              ldq_p(buffer + i * 8), MO_64=
,=0A=
                                               MEMTXATTRS_UNSPECIFIED);=0A=
         if (result !=3D MEMTX_OK) {=0A=
             s390_program_interrupt(env, PGM_OPERAND, 6, ra);=0A=
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c=0A=
index b35a640030..c8ed308700 100644=0A=
--- a/hw/vfio/pci-quirks.c=0A=
+++ b/hw/vfio/pci-quirks.c=0A=
@@ -1071,7 +1071,7 @@ static void vfio_rtl8168_quirk_address_write(void *op=
aque, hwaddr addr,=0A=
 =0A=
                 /* Write to the proper guest MSI-X table instead */=0A=
                 memory_region_dispatch_write(&vdev->pdev.msix_table_mmio,=
=0A=
-                                             offset, val, size,=0A=
+                                             offset, val, MEMOP(size),=0A=
                                              MEMTXATTRS_UNSPECIFIED);=0A=
             }=0A=
             return; /* Do not write guest MSI-X data to hardware */=0A=
@@ -1102,7 +1102,7 @@ static uint64_t vfio_rtl8168_quirk_data_read(void *op=
aque,=0A=
     if (rtl->enabled && (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX)) {=0A=
         hwaddr offset =3D rtl->addr & 0xfff;=0A=
         memory_region_dispatch_read(&vdev->pdev.msix_table_mmio, offset,=
=0A=
-                                    &data, size, MEMTXATTRS_UNSPECIFIED);=
=0A=
+                                    &data, MEMOP(size), MEMTXATTRS_UNSPECI=
FIED);=0A=
         trace_vfio_quirk_rtl8168_msix_read(vdev->vbasedev.name, offset, da=
ta);=0A=
     }=0A=
 =0A=
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c=0A=
index ce928f2429..378ad6e94f 100644=0A=
--- a/hw/virtio/virtio-pci.c=0A=
+++ b/hw/virtio/virtio-pci.c=0A=
@@ -522,6 +522,7 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, =
hwaddr addr,=0A=
 {=0A=
     uint64_t val;=0A=
     MemoryRegion *mr;=0A=
+    MemOp op =3D MEMOP(len);=0A=
 =0A=
     /* address_space_* APIs assume an aligned address.=0A=
      * As address is under guest control, handle illegal values.=0A=
@@ -550,7 +551,7 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, =
hwaddr addr,=0A=
         /* As length is under guest control, handle illegal values. */=0A=
         return;=0A=
     }=0A=
-    memory_region_dispatch_write(mr, addr, val, len, MEMTXATTRS_UNSPECIFIE=
D);=0A=
+    memory_region_dispatch_write(mr, addr, val, op, MEMTXATTRS_UNSPECIFIED=
);=0A=
 }=0A=
 =0A=
 static void=0A=
@@ -559,6 +560,7 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr=
 addr,=0A=
 {=0A=
     uint64_t val;=0A=
     MemoryRegion *mr;=0A=
+    MemOp op =3D MEMOP(len);=0A=
 =0A=
     /* address_space_* APIs assume an aligned address.=0A=
      * As address is under guest control, handle illegal values.=0A=
@@ -573,7 +575,7 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr=
 addr,=0A=
     /* Make sure caller aligned buf properly */=0A=
     assert(!(((uintptr_t)buf) & (len - 1)));=0A=
 =0A=
-    memory_region_dispatch_read(mr, addr, &val, len, MEMTXATTRS_UNSPECIFIE=
D);=0A=
+    memory_region_dispatch_read(mr, addr, &val, op, MEMTXATTRS_UNSPECIFIED=
);=0A=
     switch (len) {=0A=
     case 1:=0A=
         pci_set_byte(buf, val);=0A=
diff --git a/include/exec/memop.h b/include/exec/memop.h=0A=
index 54a75053ae..4a2eb02b13 100644=0A=
--- a/include/exec/memop.h=0A=
+++ b/include/exec/memop.h=0A=
@@ -100,4 +100,22 @@ typedef enum MemOp {=0A=
     MO_SSIZE =3D MO_SIZE | MO_SIGN,=0A=
 } MemOp;=0A=
 =0A=
+#define MEMOP_SIZE(op) (1 << ((op) & MO_SIZE))=0A=
+=0A=
+static inline MemOp MEMOP(unsigned size)=0A=
+{=0A=
+    switch (size) {=0A=
+    case 1:=0A=
+        return MO_8;=0A=
+    case 2:=0A=
+        return MO_16;=0A=
+    case 4:=0A=
+        return MO_32;=0A=
+    case 8:=0A=
+        return MO_64;=0A=
+    default:=0A=
+        g_assert_not_reached();=0A=
+    }=0A=
+}=0A=
+=0A=
 #endif=0A=
diff --git a/include/exec/memory.h b/include/exec/memory.h=0A=
index bb0961ddb9..30b1c58123 100644=0A=
--- a/include/exec/memory.h=0A=
+++ b/include/exec/memory.h=0A=
@@ -19,6 +19,7 @@=0A=
 #include "exec/cpu-common.h"=0A=
 #include "exec/hwaddr.h"=0A=
 #include "exec/memattrs.h"=0A=
+#include "exec/memop.h"=0A=
 #include "exec/ramlist.h"=0A=
 #include "qemu/queue.h"=0A=
 #include "qemu/int128.h"=0A=
@@ -1731,13 +1732,13 @@ void mtree_info(bool flatview, bool dispatch_tree, =
bool owner);=0A=
  * @mr: #MemoryRegion to access=0A=
  * @addr: address within that region=0A=
  * @pval: pointer to uint64_t which the data is written to=0A=
- * @size: size of the access in bytes=0A=
+ * @op: encodes size of the access in bytes=0A=
  * @attrs: memory transaction attributes to use for the access=0A=
  */=0A=
 MemTxResult memory_region_dispatch_read(MemoryRegion *mr,=0A=
                                         hwaddr addr,=0A=
                                         uint64_t *pval,=0A=
-                                        unsigned size,=0A=
+                                        MemOp op,=0A=
                                         MemTxAttrs attrs);=0A=
 /**=0A=
  * memory_region_dispatch_write: perform a write directly to the specified=
=0A=
@@ -1746,13 +1747,13 @@ MemTxResult memory_region_dispatch_read(MemoryRegio=
n *mr,=0A=
  * @mr: #MemoryRegion to access=0A=
  * @addr: address within that region=0A=
  * @data: data to write=0A=
- * @size: size of the access in bytes=0A=
+ * @op: encodes size of the access in bytes=0A=
  * @attrs: memory transaction attributes to use for the access=0A=
  */=0A=
 MemTxResult memory_region_dispatch_write(MemoryRegion *mr,=0A=
                                          hwaddr addr,=0A=
                                          uint64_t data,=0A=
-                                         unsigned size,=0A=
+                                         MemOp op,=0A=
                                          MemTxAttrs attrs);=0A=
 =0A=
 /**=0A=
diff --git a/include/exec/poison.h b/include/exec/poison.h=0A=
index b862320fa6..ab5a864869 100644=0A=
--- a/include/exec/poison.h=0A=
+++ b/include/exec/poison.h=0A=
@@ -38,7 +38,6 @@=0A=
 #pragma GCC poison TARGET_HAS_BFLT=0A=
 #pragma GCC poison TARGET_NAME=0A=
 #pragma GCC poison TARGET_SUPPORTS_MTTCG=0A=
-#pragma GCC poison TARGET_WORDS_BIGENDIAN=0A=
 #pragma GCC poison BSWAP_NEEDED=0A=
 =0A=
 #pragma GCC poison TARGET_LONG_BITS=0A=
diff --git a/memory.c b/memory.c=0A=
index d4579bbaec..72c494fbe1 100644=0A=
--- a/memory.c=0A=
+++ b/memory.c=0A=
@@ -350,7 +350,7 @@ static bool memory_region_big_endian(MemoryRegion *mr)=
=0A=
 #endif=0A=
 }=0A=
 =0A=
-static bool memory_region_wrong_endianness(MemoryRegion *mr)=0A=
+static bool memory_region_endianness_inverted(MemoryRegion *mr)=0A=
 {=0A=
 #ifdef TARGET_WORDS_BIGENDIAN=0A=
     return mr->ops->endianness =3D=3D DEVICE_LITTLE_ENDIAN;=0A=
@@ -359,23 +359,27 @@ static bool memory_region_wrong_endianness(MemoryRegi=
on *mr)=0A=
 #endif=0A=
 }=0A=
 =0A=
-static void adjust_endianness(MemoryRegion *mr, uint64_t *data, unsigned s=
ize)=0A=
+static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)=
=0A=
 {=0A=
-    if (memory_region_wrong_endianness(mr)) {=0A=
-        switch (size) {=0A=
-        case 1:=0A=
+    if (memory_region_endianness_inverted(mr)) {=0A=
+        op ^=3D MO_BSWAP;=0A=
+    }=0A=
+=0A=
+    if (op & MO_BSWAP) {=0A=
+        switch (op & MO_SIZE) {=0A=
+        case MO_8:=0A=
             break;=0A=
-        case 2:=0A=
+        case MO_16:=0A=
             *data =3D bswap16(*data);=0A=
             break;=0A=
-        case 4:=0A=
+        case MO_32:=0A=
             *data =3D bswap32(*data);=0A=
             break;=0A=
-        case 8:=0A=
+        case MO_64:=0A=
             *data =3D bswap64(*data);=0A=
             break;=0A=
         default:=0A=
-            abort();=0A=
+            g_assert_not_reached();=0A=
         }=0A=
     }=0A=
 }=0A=
@@ -1437,10 +1441,11 @@ static MemTxResult memory_region_dispatch_read1(Mem=
oryRegion *mr,=0A=
 MemTxResult memory_region_dispatch_read(MemoryRegion *mr,=0A=
                                         hwaddr addr,=0A=
                                         uint64_t *pval,=0A=
-                                        unsigned size,=0A=
+                                        MemOp op,=0A=
                                         MemTxAttrs attrs)=0A=
 {=0A=
     MemTxResult r;=0A=
+    unsigned size =3D MEMOP_SIZE(op);=0A=
 =0A=
     if (!memory_region_access_valid(mr, addr, size, false, attrs)) {=0A=
         *pval =3D unassigned_mem_read(mr, addr, size);=0A=
@@ -1448,7 +1453,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion =
*mr,=0A=
     }=0A=
 =0A=
     r =3D memory_region_dispatch_read1(mr, addr, pval, size, attrs);=0A=
-    adjust_endianness(mr, pval, size);=0A=
+    adjust_endianness(mr, pval, op);=0A=
     return r;=0A=
 }=0A=
 =0A=
@@ -1481,15 +1486,17 @@ static bool memory_region_dispatch_write_eventfds(M=
emoryRegion *mr,=0A=
 MemTxResult memory_region_dispatch_write(MemoryRegion *mr,=0A=
                                          hwaddr addr,=0A=
                                          uint64_t data,=0A=
-                                         unsigned size,=0A=
+                                         MemOp op,=0A=
                                          MemTxAttrs attrs)=0A=
 {=0A=
+    unsigned size =3D MEMOP_SIZE(op);=0A=
+=0A=
     if (!memory_region_access_valid(mr, addr, size, true, attrs)) {=0A=
         unassigned_mem_write(mr, addr, data, size);=0A=
         return MEMTX_DECODE_ERROR;=0A=
     }=0A=
 =0A=
-    adjust_endianness(mr, &data, size);=0A=
+    adjust_endianness(mr, &data, op);=0A=
 =0A=
     if ((!kvm_eventfds_enabled()) &&=0A=
         memory_region_dispatch_write_eventfds(mr, addr, data, size, attrs)=
) {=0A=
@@ -2335,7 +2342,7 @@ void memory_region_add_eventfd(MemoryRegion *mr,=0A=
     }=0A=
 =0A=
     if (size) {=0A=
-        adjust_endianness(mr, &mrfd.data, size);=0A=
+        adjust_endianness(mr, &mrfd.data, MEMOP(size));=0A=
     }=0A=
     memory_region_transaction_begin();=0A=
     for (i =3D 0; i < mr->ioeventfd_nb; ++i) {=0A=
@@ -2370,7 +2377,7 @@ void memory_region_del_eventfd(MemoryRegion *mr,=0A=
     unsigned i;=0A=
 =0A=
     if (size) {=0A=
-        adjust_endianness(mr, &mrfd.data, size);=0A=
+        adjust_endianness(mr, &mrfd.data, MEMOP(size));=0A=
     }=0A=
     memory_region_transaction_begin();=0A=
     for (i =3D 0; i < mr->ioeventfd_nb; ++i) {=0A=
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c=0A=
index acf865b900..de658c40c4 100644=0A=
--- a/memory_ldst.inc.c=0A=
+++ b/memory_ldst.inc.c=0A=
@@ -38,7 +38,7 @@ static inline uint32_t glue(address_space_ldl_internal, S=
UFFIX)(ARG1_DECL,=0A=
         release_lock |=3D prepare_mmio_access(mr);=0A=
 =0A=
         /* I/O case */=0A=
-        r =3D memory_region_dispatch_read(mr, addr1, &val, 4, attrs);=0A=
+        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_32, attrs);=
=0A=
 #if defined(TARGET_WORDS_BIGENDIAN)=0A=
         if (endian =3D=3D DEVICE_LITTLE_ENDIAN) {=0A=
             val =3D bswap32(val);=0A=
@@ -114,7 +114,7 @@ static inline uint64_t glue(address_space_ldq_internal,=
 SUFFIX)(ARG1_DECL,=0A=
         release_lock |=3D prepare_mmio_access(mr);=0A=
 =0A=
         /* I/O case */=0A=
-        r =3D memory_region_dispatch_read(mr, addr1, &val, 8, attrs);=0A=
+        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_64, attrs);=
=0A=
 #if defined(TARGET_WORDS_BIGENDIAN)=0A=
         if (endian =3D=3D DEVICE_LITTLE_ENDIAN) {=0A=
             val =3D bswap64(val);=0A=
@@ -188,7 +188,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,=0A=
         release_lock |=3D prepare_mmio_access(mr);=0A=
 =0A=
         /* I/O case */=0A=
-        r =3D memory_region_dispatch_read(mr, addr1, &val, 1, attrs);=0A=
+        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_8, attrs);=
=0A=
     } else {=0A=
         /* RAM case */=0A=
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);=0A=
@@ -224,7 +224,7 @@ static inline uint32_t glue(address_space_lduw_internal=
, SUFFIX)(ARG1_DECL,=0A=
         release_lock |=3D prepare_mmio_access(mr);=0A=
 =0A=
         /* I/O case */=0A=
-        r =3D memory_region_dispatch_read(mr, addr1, &val, 2, attrs);=0A=
+        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_16, attrs);=
=0A=
 #if defined(TARGET_WORDS_BIGENDIAN)=0A=
         if (endian =3D=3D DEVICE_LITTLE_ENDIAN) {=0A=
             val =3D bswap16(val);=0A=
@@ -300,7 +300,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL=
,=0A=
     if (l < 4 || !memory_access_is_direct(mr, true)) {=0A=
         release_lock |=3D prepare_mmio_access(mr);=0A=
 =0A=
-        r =3D memory_region_dispatch_write(mr, addr1, val, 4, attrs);=0A=
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);=
=0A=
     } else {=0A=
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);=0A=
         stl_p(ptr, val);=0A=
@@ -346,7 +346,7 @@ static inline void glue(address_space_stl_internal, SUF=
FIX)(ARG1_DECL,=0A=
             val =3D bswap32(val);=0A=
         }=0A=
 #endif=0A=
-        r =3D memory_region_dispatch_write(mr, addr1, val, 4, attrs);=0A=
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);=
=0A=
     } else {=0A=
         /* RAM case */=0A=
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);=0A=
@@ -408,7 +408,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,=0A=
     mr =3D TRANSLATE(addr, &addr1, &l, true, attrs);=0A=
     if (!memory_access_is_direct(mr, true)) {=0A=
         release_lock |=3D prepare_mmio_access(mr);=0A=
-        r =3D memory_region_dispatch_write(mr, addr1, val, 1, attrs);=0A=
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_8, attrs);=
=0A=
     } else {=0A=
         /* RAM case */=0A=
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);=0A=
@@ -451,7 +451,7 @@ static inline void glue(address_space_stw_internal, SUF=
FIX)(ARG1_DECL,=0A=
             val =3D bswap16(val);=0A=
         }=0A=
 #endif=0A=
-        r =3D memory_region_dispatch_write(mr, addr1, val, 2, attrs);=0A=
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_16, attrs);=
=0A=
     } else {=0A=
         /* RAM case */=0A=
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);=0A=
@@ -524,7 +524,7 @@ static void glue(address_space_stq_internal, SUFFIX)(AR=
G1_DECL,=0A=
             val =3D bswap64(val);=0A=
         }=0A=
 #endif=0A=
-        r =3D memory_region_dispatch_write(mr, addr1, val, 8, attrs);=0A=
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_64, attrs);=
=0A=
     } else {=0A=
         /* RAM case */=0A=
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);=0A=
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c=0A=
index 9e2e02f858..2fc9803f7b 100644=0A=
--- a/target/mips/op_helper.c=0A=
+++ b/target/mips/op_helper.c=0A=
@@ -4740,11 +4740,11 @@ void helper_cache(CPUMIPSState *env, target_ulong a=
ddr, uint32_t op)=0A=
     if (op =3D=3D 9) {=0A=
         /* Index Store Tag */=0A=
         memory_region_dispatch_write(env->itc_tag, index, env->CP0_TagLo,=
=0A=
-                                     8, MEMTXATTRS_UNSPECIFIED);=0A=
+                                     MO_64, MEMTXATTRS_UNSPECIFIED);=0A=
     } else if (op =3D=3D 5) {=0A=
         /* Index Load Tag */=0A=
         memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,=
=0A=
-                                    8, MEMTXATTRS_UNSPECIFIED);=0A=
+                                    MO_64, MEMTXATTRS_UNSPECIFIED);=0A=
     }=0A=
 #endif=0A=
 }=0A=
-- =0A=
2.17.2=0A=

