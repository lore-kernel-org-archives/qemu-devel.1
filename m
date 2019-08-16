Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D025C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FE3206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 08:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FE3206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyXRV-0005ta-0u
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 04:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWqg-0006Ih-Fy
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hyWqV-0004IB-4H
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:40:34 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.79]:19398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hyWoc-0003TD-Ny; Fri, 16 Aug 2019 03:38:27 -0400
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 BWP09926084.bt.com (10.36.82.115) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 08:38:03 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18e.domain1.systemhost.net (10.9.212.18) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 16 Aug 2019 08:38:24 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 16 Aug
 2019 08:38:24 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v7 37/42] cputlb: Replace size and endian
 operands for MemOp
Thread-Index: AQHVVAWWeriLpAK7qkS+T9izYShEdQ==
Date: Fri, 16 Aug 2019 07:38:24 +0000
Message-ID: <1565941103483.3364@bt.com>
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
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.79
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v7 37/42] cputlb: Replace size and endian
 operands for MemOp
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

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 accel/tcg/cputlb.c   | 172 +++++++++++++++++++++++++----------------------=
----
 include/exec/memop.h |   6 ++
 memory.c             |  11 +---
 3 files changed, 90 insertions(+), 99 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 0aff6a3..8022c81 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -881,7 +881,7 @@ static void tlb_fill(CPUState *cpu, target_ulong addr, =
int size,

 static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                          int mmu_idx, target_ulong addr, uintptr_t retaddr=
,
-                         MMUAccessType access_type, int size)
+                         MMUAccessType access_type, MemOp op)
 {
     CPUState *cpu =3D env_cpu(env);
     hwaddr mr_offset;
@@ -906,15 +906,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBE=
ntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked =3D true;
     }
-    r =3D memory_region_dispatch_read(mr, mr_offset, &val,
-                                    size_memop(size) | MO_TE,
-                                    iotlbentry->attrs);
+    r =3D memory_region_dispatch_read(mr, mr_offset, &val, op, iotlbentry-=
>attrs);
     if (r !=3D MEMTX_OK) {
         hwaddr physaddr =3D mr_offset +
             section->offset_within_address_space -
             section->offset_within_region;

-        cpu_transaction_failed(cpu, physaddr, addr, size, access_type,
+        cpu_transaction_failed(cpu, physaddr, addr, memop_size(op), access=
_type,
                                mmu_idx, iotlbentry->attrs, r, retaddr);
     }
     if (locked) {
@@ -926,7 +924,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEnt=
ry *iotlbentry,

 static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                       int mmu_idx, uint64_t val, target_ulong addr,
-                      uintptr_t retaddr, int size)
+                      uintptr_t retaddr, MemOp op)
 {
     CPUState *cpu =3D env_cpu(env);
     hwaddr mr_offset;
@@ -948,16 +946,15 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntr=
y *iotlbentry,
         qemu_mutex_lock_iothread();
         locked =3D true;
     }
-    r =3D memory_region_dispatch_write(mr, mr_offset, val,
-                                     size_memop(size) | MO_TE,
-                                     iotlbentry->attrs);
+    r =3D memory_region_dispatch_write(mr, mr_offset, val, op, iotlbentry-=
>attrs);
     if (r !=3D MEMTX_OK) {
         hwaddr physaddr =3D mr_offset +
             section->offset_within_address_space -
             section->offset_within_region;

-        cpu_transaction_failed(cpu, physaddr, addr, size, MMU_DATA_STORE,
-                               mmu_idx, iotlbentry->attrs, r, retaddr);
+        cpu_transaction_failed(cpu, physaddr, addr, memop_size(op),
+                               MMU_DATA_STORE, mmu_idx, iotlbentry->attrs,=
 r,
+                               retaddr);
     }
     if (locked) {
         qemu_mutex_unlock_iothread();
@@ -1218,14 +1215,15 @@ static void *atomic_mmu_lookup(CPUArchState *env, t=
arget_ulong addr,
  * access type.
  */

-static inline uint64_t handle_bswap(uint64_t val, int size, bool big_endia=
n)
+static inline uint64_t handle_bswap(uint64_t val, MemOp op)
 {
-    if ((big_endian && NEED_BE_BSWAP) || (!big_endian && NEED_LE_BSWAP)) {
-        switch (size) {
-        case 1: return val;
-        case 2: return bswap16(val);
-        case 4: return bswap32(val);
-        case 8: return bswap64(val);
+    if ((memop_big_endian(op) && NEED_BE_BSWAP) ||
+        (!memop_big_endian(op) && NEED_LE_BSWAP)) {
+        switch (op & MO_SIZE) {
+        case MO_8: return val;
+        case MO_16: return bswap16(val);
+        case MO_32: return bswap32(val);
+        case MO_64: return bswap64(val);
         default:
             g_assert_not_reached();
         }
@@ -1248,7 +1246,7 @@ typedef uint64_t FullLoadHelper(CPUArchState *env, ta=
rget_ulong addr,

 static inline uint64_t __attribute__((always_inline))
 load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
-            uintptr_t retaddr, size_t size, bool big_endian, bool code_rea=
d,
+            uintptr_t retaddr, MemOp op, bool code_read,
             FullLoadHelper *full_load)
 {
     uintptr_t mmu_idx =3D get_mmuidx(oi);
@@ -1262,6 +1260,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCG=
MemOpIdx oi,
     unsigned a_bits =3D get_alignment_bits(get_memop(oi));
     void *haddr;
     uint64_t res;
+    size_t size =3D memop_size(op);

     /* Handle CPU specific unaligned behaviour */
     if (addr & ((1 << a_bits) - 1)) {
@@ -1307,9 +1306,10 @@ load_helper(CPUArchState *env, target_ulong addr, TC=
GMemOpIdx oi,
             }
         }

+        /* FIXME: io_readx ignores MO_BSWAP.  */
         res =3D io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
-                       mmu_idx, addr, retaddr, access_type, size);
-        return handle_bswap(res, size, big_endian);
+                       mmu_idx, addr, retaddr, access_type, op);
+        return handle_bswap(res, op);
     }

     /* Handle slow unaligned access (it spans two pages or IO).  */
@@ -1326,7 +1326,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCG=
MemOpIdx oi,
         r2 =3D full_load(env, addr2, oi, retaddr);
         shift =3D (addr & (size - 1)) * 8;

-        if (big_endian) {
+        if (memop_big_endian(op)) {
             /* Big-endian combine.  */
             res =3D (r1 << shift) | (r2 >> ((size * 8) - shift));
         } else {
@@ -1338,30 +1338,27 @@ load_helper(CPUArchState *env, target_ulong addr, T=
CGMemOpIdx oi,

  do_aligned_access:
     haddr =3D (void *)((uintptr_t)addr + entry->addend);
-    switch (size) {
-    case 1:
+    switch (op) {
+    case MO_UB:
         res =3D ldub_p(haddr);
         break;
-    case 2:
-        if (big_endian) {
-            res =3D lduw_be_p(haddr);
-        } else {
-            res =3D lduw_le_p(haddr);
-        }
+    case MO_BEUW:
+        res =3D lduw_be_p(haddr);
         break;
-    case 4:
-        if (big_endian) {
-            res =3D (uint32_t)ldl_be_p(haddr);
-        } else {
-            res =3D (uint32_t)ldl_le_p(haddr);
-        }
+    case MO_LEUW:
+        res =3D lduw_le_p(haddr);
         break;
-    case 8:
-        if (big_endian) {
-            res =3D ldq_be_p(haddr);
-        } else {
-            res =3D ldq_le_p(haddr);
-        }
+    case MO_BEUL:
+        res =3D (uint32_t)ldl_be_p(haddr);
+        break;
+    case MO_LEUL:
+        res =3D (uint32_t)ldl_le_p(haddr);
+        break;
+    case MO_BEQ:
+        res =3D ldq_be_p(haddr);
+        break;
+    case MO_LEQ:
+        res =3D ldq_le_p(haddr);
         break;
     default:
         g_assert_not_reached();
@@ -1383,8 +1380,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCG=
MemOpIdx oi,
 static uint64_t full_ldub_mmu(CPUArchState *env, target_ulong addr,
                               TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 1, false, false,
-                       full_ldub_mmu);
+    return load_helper(env, addr, oi, retaddr, MO_8, false, full_ldub_mmu)=
;
 }

 tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *env, target_ulong addr,
@@ -1396,7 +1392,7 @@ tcg_target_ulong helper_ret_ldub_mmu(CPUArchState *en=
v, target_ulong addr,
 static uint64_t full_le_lduw_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, false, false,
+    return load_helper(env, addr, oi, retaddr, MO_LEUW, false,
                        full_le_lduw_mmu);
 }

@@ -1409,7 +1405,7 @@ tcg_target_ulong helper_le_lduw_mmu(CPUArchState *env=
, target_ulong addr,
 static uint64_t full_be_lduw_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, true, false,
+    return load_helper(env, addr, oi, retaddr, MO_BEUW, false,
                        full_be_lduw_mmu);
 }

@@ -1422,7 +1418,7 @@ tcg_target_ulong helper_be_lduw_mmu(CPUArchState *env=
, target_ulong addr,
 static uint64_t full_le_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, false, false,
+    return load_helper(env, addr, oi, retaddr, MO_LEUL, false,
                        full_le_ldul_mmu);
 }

@@ -1435,7 +1431,7 @@ tcg_target_ulong helper_le_ldul_mmu(CPUArchState *env=
, target_ulong addr,
 static uint64_t full_be_ldul_mmu(CPUArchState *env, target_ulong addr,
                                  TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, true, false,
+    return load_helper(env, addr, oi, retaddr, MO_BEUL, false,
                        full_be_ldul_mmu);
 }

@@ -1448,14 +1444,14 @@ tcg_target_ulong helper_be_ldul_mmu(CPUArchState *e=
nv, target_ulong addr,
 uint64_t helper_le_ldq_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, false, false,
+    return load_helper(env, addr, oi, retaddr, MO_LEQ, false,
                        helper_le_ldq_mmu);
 }

 uint64_t helper_be_ldq_mmu(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, true, false,
+    return load_helper(env, addr, oi, retaddr, MO_BEQ, false,
                        helper_be_ldq_mmu);
 }

@@ -1501,7 +1497,7 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env=
, target_ulong addr,

 static inline void __attribute__((always_inline))
 store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
-             TCGMemOpIdx oi, uintptr_t retaddr, size_t size, bool big_endi=
an)
+             TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
 {
     uintptr_t mmu_idx =3D get_mmuidx(oi);
     uintptr_t index =3D tlb_index(env, mmu_idx, addr);
@@ -1510,6 +1506,7 @@ store_helper(CPUArchState *env, target_ulong addr, ui=
nt64_t val,
     const size_t tlb_off =3D offsetof(CPUTLBEntry, addr_write);
     unsigned a_bits =3D get_alignment_bits(get_memop(oi));
     void *haddr;
+    size_t size =3D memop_size(op);

     /* Handle CPU specific unaligned behaviour */
     if (addr & ((1 << a_bits) - 1)) {
@@ -1555,9 +1552,10 @@ store_helper(CPUArchState *env, target_ulong addr, u=
int64_t val,
             }
         }

+        /* FIXME: io_writex ignores MO_BSWAP.  */
         io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
-                  handle_bswap(val, size, big_endian),
-                  addr, retaddr, size);
+                  handle_bswap(val, op),
+                  addr, retaddr, op);
         return;
     }

@@ -1593,7 +1591,7 @@ store_helper(CPUArchState *env, target_ulong addr, ui=
nt64_t val,
          */
         for (i =3D 0; i < size; ++i) {
             uint8_t val8;
-            if (big_endian) {
+            if (memop_big_endian(op)) {
                 /* Big-endian extract.  */
                 val8 =3D val >> (((size - 1) * 8) - (i * 8));
             } else {
@@ -1607,30 +1605,27 @@ store_helper(CPUArchState *env, target_ulong addr, =
uint64_t val,

  do_aligned_access:
     haddr =3D (void *)((uintptr_t)addr + entry->addend);
-    switch (size) {
-    case 1:
+    switch (op) {
+    case MO_UB:
         stb_p(haddr, val);
         break;
-    case 2:
-        if (big_endian) {
-            stw_be_p(haddr, val);
-        } else {
-            stw_le_p(haddr, val);
-        }
+    case MO_BEUW:
+        stw_be_p(haddr, val);
         break;
-    case 4:
-        if (big_endian) {
-            stl_be_p(haddr, val);
-        } else {
-            stl_le_p(haddr, val);
-        }
+    case MO_LEUW:
+        stw_le_p(haddr, val);
         break;
-    case 8:
-        if (big_endian) {
-            stq_be_p(haddr, val);
-        } else {
-            stq_le_p(haddr, val);
-        }
+    case MO_BEUL:
+        stl_be_p(haddr, val);
+        break;
+    case MO_LEUL:
+        stl_le_p(haddr, val);
+        break;
+    case MO_BEQ:
+        stq_be_p(haddr, val);
+        break;
+    case MO_LEQ:
+        stq_le_p(haddr, val);
         break;
     default:
         g_assert_not_reached();
@@ -1641,43 +1636,43 @@ store_helper(CPUArchState *env, target_ulong addr, =
uint64_t val,
 void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t val,
                         TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 1, false);
+    store_helper(env, addr, val, oi, retaddr, MO_8);
 }

 void helper_le_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 2, false);
+    store_helper(env, addr, val, oi, retaddr, MO_LEUW);
 }

 void helper_be_stw_mmu(CPUArchState *env, target_ulong addr, uint16_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 2, true);
+    store_helper(env, addr, val, oi, retaddr, MO_BEUW);
 }

 void helper_le_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 4, false);
+    store_helper(env, addr, val, oi, retaddr, MO_LEUL);
 }

 void helper_be_stl_mmu(CPUArchState *env, target_ulong addr, uint32_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 4, true);
+    store_helper(env, addr, val, oi, retaddr, MO_BEUL);
 }

 void helper_le_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 8, false);
+    store_helper(env, addr, val, oi, retaddr, MO_LEQ);
 }

 void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
                        TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    store_helper(env, addr, val, oi, retaddr, 8, true);
+    store_helper(env, addr, val, oi, retaddr, MO_BEQ);
 }

 /* First set of helpers allows passing in of OI and RETADDR.  This makes
@@ -1742,8 +1737,7 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulon=
g addr, uint64_t val,
 static uint64_t full_ldub_cmmu(CPUArchState *env, target_ulong addr,
                                TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 1, false, true,
-                       full_ldub_cmmu);
+    return load_helper(env, addr, oi, retaddr, MO_8, true, full_ldub_cmmu)=
;
 }

 uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target_ulong addr,
@@ -1755,7 +1749,7 @@ uint8_t helper_ret_ldb_cmmu(CPUArchState *env, target=
_ulong addr,
 static uint64_t full_le_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, false, true,
+    return load_helper(env, addr, oi, retaddr, MO_LEUW, true,
                        full_le_lduw_cmmu);
 }

@@ -1768,7 +1762,7 @@ uint16_t helper_le_ldw_cmmu(CPUArchState *env, target=
_ulong addr,
 static uint64_t full_be_lduw_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 2, true, true,
+    return load_helper(env, addr, oi, retaddr, MO_BEUW, true,
                        full_be_lduw_cmmu);
 }

@@ -1781,7 +1775,7 @@ uint16_t helper_be_ldw_cmmu(CPUArchState *env, target=
_ulong addr,
 static uint64_t full_le_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, false, true,
+    return load_helper(env, addr, oi, retaddr, MO_LEUL, true,
                        full_le_ldul_cmmu);
 }

@@ -1794,7 +1788,7 @@ uint32_t helper_le_ldl_cmmu(CPUArchState *env, target=
_ulong addr,
 static uint64_t full_be_ldul_cmmu(CPUArchState *env, target_ulong addr,
                                   TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 4, true, true,
+    return load_helper(env, addr, oi, retaddr, MO_BEUL, true,
                        full_be_ldul_cmmu);
 }

@@ -1807,13 +1801,13 @@ uint32_t helper_be_ldl_cmmu(CPUArchState *env, targ=
et_ulong addr,
 uint64_t helper_le_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, false, true,
+    return load_helper(env, addr, oi, retaddr, MO_LEQ, true,
                        helper_le_ldq_cmmu);
 }

 uint64_t helper_be_ldq_cmmu(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
 {
-    return load_helper(env, addr, oi, retaddr, 8, true, true,
+    return load_helper(env, addr, oi, retaddr, MO_BEQ, true,
                        helper_be_ldq_cmmu);
 }
diff --git a/include/exec/memop.h b/include/exec/memop.h
index 0a610b7..529d07b 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -125,4 +125,10 @@ static inline MemOp size_memop(unsigned size)
     return ctz32(size);
 }

+/* Big endianness from MemOp.  */
+static inline bool memop_big_endian(MemOp op)
+{
+    return (op & MO_BSWAP) =3D=3D MO_BE;
+}
+
 #endif
diff --git a/memory.c b/memory.c
index 689390f..01fd29d 100644
--- a/memory.c
+++ b/memory.c
@@ -343,15 +343,6 @@ static void flatview_simplify(FlatView *view)
     }
 }

-static bool memory_region_big_endian(MemoryRegion *mr)
-{
-#ifdef TARGET_WORDS_BIGENDIAN
-    return mr->ops->endianness !=3D MO_LE;
-#else
-    return mr->ops->endianness =3D=3D MO_BE;
-#endif
-}
-
 static bool memory_region_wrong_endianness(MemoryRegion *mr)
 {
 #ifdef TARGET_WORDS_BIGENDIAN
@@ -564,7 +555,7 @@ static MemTxResult access_with_adjusted_size(hwaddr add=
r,
     /* FIXME: support unaligned access? */
     access_size =3D MAX(MIN(size, access_size_max), access_size_min);
     access_mask =3D MAKE_64BIT_MASK(0, access_size * 8);
-    if (memory_region_big_endian(mr)) {
+    if (memop_big_endian(mr->ops->endianness)) {
         for (i =3D 0; i < size; i +=3D access_size) {
             r |=3D access_fn(mr, addr + i, value, access_size,
                         (size - access_size - i) * 8, access_mask, attrs);
--
1.8.3.1

?

