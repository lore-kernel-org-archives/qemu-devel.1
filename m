Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E58C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B486B206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B486B206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyXH1-00087V-QG
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 04:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWpD-0004n8-Dv
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWp5-0003gH-57
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:39:03 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.236]:32936)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hyWoJ-0003L4-43; Fri, 16 Aug 2019 03:38:07 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 RDW083A009ED65.bt.com (10.187.98.35) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 16 Aug 2019 08:34:11 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 16 Aug 2019 08:38:04 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 16 Aug
 2019 08:38:04 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v7 36/42] memory: Access MemoryRegion with
 endianness
Thread-Index: AQHVVAWJ7BwJCpYh+06Xhz6iL6kqLw==
Date: Fri, 16 Aug 2019 07:38:04 +0000
Message-ID: <1565941083234.39909@bt.com>
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.40]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.236
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v7 36/42] memory: Access MemoryRegion with
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
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, lersek@redhat.com,
 jasowang@redhat.com, jiri@resnulli.us, ehabkost@redhat.com,
 b.galvani@gmail.com, eric.auger@redhat.com, alex.williamson@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 andrew@aj.id.au, claudio.fontana@suse.com, crwulff@gmail.com,
 laurent@vivier.eu, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 jan.kiszka@web.de, clg@kaod.org, shorne@gmail.com, qemu-riscv@nongnu.org,
 i.mitsyanko@gmail.com, cohuck@redhat.com, philmd@redhat.com,
 amarkovic@wavecomp.com, peter.chubb@nicta.com.au, aurelien@aurel32.net,
 pburton@wavecomp.com, sagark@eecs.berkeley.edu, green@moxielogic.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 robh@kernel.org, borntraeger@de.ibm.com, joel@jms.id.au,
 antonynpavlov@gmail.com, chouteau@adacore.com, Andrew.Baumann@microsoft.com,
 mreitz@redhat.com, walling@linux.ibm.com, dmitry.fleytman@gmail.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, jslaby@suse.cz, marex@denx.de,
 proljc@gmail.com, marcandre.lureau@redhat.com, alistair@alistair23.me,
 paul.durrant@citrix.com, david@gibson.dropbear.id.au,
 xiaoguangrong.eric@gmail.com, huth@tuxfamily.org, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
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
 accel/tcg/cputlb.c       |  6 ++++--
 exec.c                   |  5 +++--
 hw/intc/armv7m_nvic.c    | 15 ++++++++-------
 hw/s390x/s390-pci-inst.c |  6 ++++--
 hw/vfio/pci-quirks.c     |  5 +++--
 hw/virtio/virtio-pci.c   |  6 ++++--
 memory_ldst.inc.c        | 18 ++++++++++++------
 7 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6c83878..0aff6a3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -906,7 +906,8 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEnt=
ry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked =3D true;
     }
-    r =3D memory_region_dispatch_read(mr, mr_offset, &val, size_memop(size=
),
+    r =3D memory_region_dispatch_read(mr, mr_offset, &val,
+                                    size_memop(size) | MO_TE,
                                     iotlbentry->attrs);
     if (r !=3D MEMTX_OK) {
         hwaddr physaddr =3D mr_offset +
@@ -947,7 +948,8 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry =
*iotlbentry,
         qemu_mutex_lock_iothread();
         locked =3D true;
     }
-    r =3D memory_region_dispatch_write(mr, mr_offset, val, size_memop(size=
),
+    r =3D memory_region_dispatch_write(mr, mr_offset, val,
+                                     size_memop(size) | MO_TE,
                                      iotlbentry->attrs);
     if (r !=3D MEMTX_OK) {
         hwaddr physaddr =3D mr_offset +
diff --git a/exec.c b/exec.c
index 303f9a7..562fb5b 100644
--- a/exec.c
+++ b/exec.c
@@ -3335,7 +3335,8 @@ static MemTxResult flatview_write_continue(FlatView *=
fv, hwaddr addr,
                potential bugs */
             val =3D ldn_p(buf, l);
             result |=3D memory_region_dispatch_write(mr, addr1, val,
-                                                   size_memop(l), attrs);
+                                                   size_memop(l) | MO_TE,
+                                                   attrs);
         } else {
             /* RAM case */
             ptr =3D qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
@@ -3397,7 +3398,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwad=
dr addr,
             release_lock |=3D prepare_mmio_access(mr);
             l =3D memory_access_size(mr, l, addr1);
             result |=3D memory_region_dispatch_read(mr, addr1, &val,
-                                                  size_memop(l), attrs);
+                                                  size_memop(l) | MO_TE, a=
ttrs);
             stn_p(buf, l, val);
         } else {
             /* RAM case */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 975d7cc..e150f9a 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2346,8 +2346,8 @@ static MemTxResult nvic_sysreg_ns_write(void *opaque,=
 hwaddr addr,
     if (attrs.secure) {
         /* S accesses to the alias act like NS accesses to the real region=
 */
         attrs.secure =3D 0;
-        return memory_region_dispatch_write(mr, addr, value, size_memop(si=
ze),
-                                            attrs);
+        return memory_region_dispatch_write(mr, addr, value,
+                                            size_memop(size) | MO_TE, attr=
s);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -2366,8 +2366,8 @@ static MemTxResult nvic_sysreg_ns_read(void *opaque, =
hwaddr addr,
     if (attrs.secure) {
         /* S accesses to the alias act like NS accesses to the real region=
 */
         attrs.secure =3D 0;
-        return memory_region_dispatch_read(mr, addr, data, size_memop(size=
),
-                                           attrs);
+        return memory_region_dispatch_read(mr, addr, data,
+                                           size_memop(size) | MO_TE, attrs=
);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -2393,8 +2393,8 @@ static MemTxResult nvic_systick_write(void *opaque, h=
waddr addr,

     /* Direct the access to the correct systick */
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]=
), 0);
-    return memory_region_dispatch_write(mr, addr, value, size_memop(size),
-                                        attrs);
+    return memory_region_dispatch_write(mr, addr, value,
+                                        size_memop(size) | MO_TE, attrs);
 }

 static MemTxResult nvic_systick_read(void *opaque, hwaddr addr,
@@ -2406,7 +2406,8 @@ static MemTxResult nvic_systick_read(void *opaque, hw=
addr addr,

     /* Direct the access to the correct systick */
     mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]=
), 0);
-    return memory_region_dispatch_read(mr, addr, data, size_memop(size), a=
ttrs);
+    return memory_region_dispatch_read(mr, addr, data, size_memop(size) | =
MO_TE,
+                                       attrs);
 }

 static const MemoryRegionOps nvic_systick_ops =3D {
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 0e92a37..272cb28 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -373,7 +373,8 @@ static MemTxResult zpci_read_bar(S390PCIBusDevice *pbde=
v, uint8_t pcias,
     mr =3D pbdev->pdev->io_regions[pcias].memory;
     mr =3D s390_get_subregion(mr, offset, len);
     offset -=3D mr->addr;
-    return memory_region_dispatch_read(mr, offset, data, size_memop(len),
+    return memory_region_dispatch_read(mr, offset, data,
+                                       size_memop(len) | MO_LE,
                                        MEMTXATTRS_UNSPECIFIED);
 }

@@ -472,7 +473,8 @@ static MemTxResult zpci_write_bar(S390PCIBusDevice *pbd=
ev, uint8_t pcias,
     mr =3D pbdev->pdev->io_regions[pcias].memory;
     mr =3D s390_get_subregion(mr, offset, len);
     offset -=3D mr->addr;
-    return memory_region_dispatch_write(mr, offset, data, size_memop(len),
+    return memory_region_dispatch_write(mr, offset, data,
+                                        size_memop(len) | MO_LE,
                                         MEMTXATTRS_UNSPECIFIED);
 }

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index d5c0268..53db1c3 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1072,7 +1072,8 @@ static void vfio_rtl8168_quirk_address_write(void *op=
aque, hwaddr addr,

                 /* Write to the proper guest MSI-X table instead */
                 memory_region_dispatch_write(&vdev->pdev.msix_table_mmio,
-                                             offset, val, size_memop(size)=
,
+                                             offset, val,
+                                             size_memop(size) | MO_LE,
                                              MEMTXATTRS_UNSPECIFIED);
             }
             return; /* Do not write guest MSI-X data to hardware */
@@ -1103,7 +1104,7 @@ static uint64_t vfio_rtl8168_quirk_data_read(void *op=
aque,
     if (rtl->enabled && (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX)) {
         hwaddr offset =3D rtl->addr & 0xfff;
         memory_region_dispatch_read(&vdev->pdev.msix_table_mmio, offset,
-                                    &data, size_memop(size),
+                                    &data, size_memop(size) | MO_LE,
                                     MEMTXATTRS_UNSPECIFIED);
         trace_vfio_quirk_rtl8168_msix_read(vdev->vbasedev.name, offset, da=
ta);
     }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b929e44..ad06c12 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -551,7 +551,8 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, =
hwaddr addr,
         /* As length is under guest control, handle illegal values. */
         return;
     }
-    memory_region_dispatch_write(mr, addr, val, size_memop(len),
+    /* FIXME: memory_region_dispatch_write ignores MO_BSWAP.  */
+    memory_region_dispatch_write(mr, addr, val, size_memop(len) | MO_LE,
                                  MEMTXATTRS_UNSPECIFIED);
 }

@@ -575,7 +576,8 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr=
 addr,
     /* Make sure caller aligned buf properly */
     assert(!(((uintptr_t)buf) & (len - 1)));

-    memory_region_dispatch_read(mr, addr, &val, size_memop(len),
+    /* FIXME: memory_region_dispatch_read ignores MO_BSWAP.  */
+    memory_region_dispatch_read(mr, addr, &val, size_memop(len) | MO_LE,
                                 MEMTXATTRS_UNSPECIFIED);
     switch (len) {
     case 1:
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index d08fc79..482e4b3 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -37,7 +37,8 @@ static inline uint32_t glue(address_space_ldl_internal, S=
UFFIX)(ARG1_DECL,
         release_lock |=3D prepare_mmio_access(mr);

         /* I/O case */
-        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_32, attrs);
+        /* FIXME: memory_region_dispatch_read ignores MO_BSWAP.  */
+        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_32 | endian,=
 attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian =3D=3D MO_LE) {
             val =3D bswap32(val);
@@ -112,7 +113,8 @@ static inline uint64_t glue(address_space_ldq_internal,=
 SUFFIX)(ARG1_DECL,
         release_lock |=3D prepare_mmio_access(mr);

         /* I/O case */
-        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_64, attrs);
+        /* FIXME: memory_region_dispatch_read ignores MO_BSWAP.  */
+        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_64 | endian,=
 attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian =3D=3D MO_LE) {
             val =3D bswap64(val);
@@ -221,7 +223,8 @@ static inline uint32_t glue(address_space_lduw_internal=
, SUFFIX)(ARG1_DECL,
         release_lock |=3D prepare_mmio_access(mr);

         /* I/O case */
-        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_16, attrs);
+        /* FIXME: memory_region_dispatch_read ignores MO_BSWAP.  */
+        r =3D memory_region_dispatch_read(mr, addr1, &val, MO_16 | endian,=
 attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian =3D=3D MO_LE) {
             val =3D bswap16(val);
@@ -342,7 +345,8 @@ static inline void glue(address_space_stl_internal, SUF=
FIX)(ARG1_DECL,
             val =3D bswap32(val);
         }
 #endif
-        r =3D memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
+        /* FIXME: memory_region_dispatch_write ignores MO_BSWAP.  */
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_32 | endian,=
 attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -447,7 +451,8 @@ static inline void glue(address_space_stw_internal, SUF=
FIX)(ARG1_DECL,
             val =3D bswap16(val);
         }
 #endif
-        r =3D memory_region_dispatch_write(mr, addr1, val, MO_16, attrs);
+        /* FIXME: memory_region_dispatch_write ignores MO_BSWAP.  */
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_16 | endian,=
 attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -520,7 +525,8 @@ static void glue(address_space_stq_internal, SUFFIX)(AR=
G1_DECL,
             val =3D bswap64(val);
         }
 #endif
-        r =3D memory_region_dispatch_write(mr, addr1, val, MO_64, attrs);
+        /* FIXME: memory_region_dispatch_write ignores MO_BSWAP.  */
+        r =3D memory_region_dispatch_write(mr, addr1, val, MO_64 | endian,=
 attrs);
     } else {
         /* RAM case */
         ptr =3D qemu_map_ram_ptr(mr->ram_block, addr1);
--
1.8.3.1

?

