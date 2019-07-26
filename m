Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D8C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 06:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D498F218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 06:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D498F218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqu2X-0007Y3-NO
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 02:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57656)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hqu26-0006RC-Gc
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 02:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hqu22-0006d1-CR
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 02:48:49 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.77]:51296)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hqu1G-0005Rv-G8; Fri, 26 Jul 2019 02:48:00 -0400
Received: from tpw09926dag18h.domain1.systemhost.net (10.9.212.42) by
 BWP09926082.bt.com (10.36.82.113) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Fri, 26
 Jul 2019 07:47:46 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18h.domain1.systemhost.net (10.9.212.42) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 26 Jul 2019 07:47:47 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Fri, 26 Jul
 2019 07:47:47 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v5 11/15] memory: Single byte swap along the
 I/O path
Thread-Index: AQHVQ34JFcVl51mE9EO/EnEfwkEv1Q==
Date: Fri, 26 Jul 2019 06:47:47 +0000
Message-ID: <1564123667210.66446@bt.com>
References: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <3106a3c959c4498fad13a5799c89ba7b@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.42]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.77
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v5 11/15] memory: Single byte swap along the
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 mst@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 laurent@vivier.eu, Alistair.Francis@wdc.com, edgar.iglesias@gmail.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 stefanha@redhat.com, shorne@gmail.com, david@gibson.dropbear.id.au,
 qemu-riscv@nongnu.org, kbastian@mail.uni-paderborn.de, cohuck@redhat.com,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that MemOp has been pushed down into the memory API, we can
collapse the two byte swaps adjust_endianness and handle_bswap into
the former.

Collapsing byte swaps along the I/O path enables additional endian
inversion logic, e.g. SPARC64 Invert Endian TTE bit, with redundant
byte swaps cancelling out.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 accel/tcg/cputlb.c | 41 +++++++++++++++++++----------------------
 memory.c           | 30 +++++++++++++++++-------------
 2 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5d88cec..e61b1eb 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1209,26 +1209,13 @@ static void *atomic_mmu_lookup(CPUArchState *env, t=
arget_ulong addr,
 #endif

 /*
- * Byte Swap Helper
+ * Byte Swap Checker
  *
- * This should all dead code away depending on the build host and
- * access type.
+ * Dead code should all go away depending on the build host and access typ=
e.
  */
-
-static inline uint64_t handle_bswap(uint64_t val, int size, bool big_endia=
n)
+static inline bool need_bswap(bool big_endian)
 {
-    if ((big_endian && NEED_BE_BSWAP) || (!big_endian && NEED_LE_BSWAP)) {
-        switch (size) {
-        case 1: return val;
-        case 2: return bswap16(val);
-        case 4: return bswap32(val);
-        case 8: return bswap64(val);
-        default:
-            g_assert_not_reached();
-        }
-    } else {
-        return val;
-    }
+    return (big_endian && NEED_BE_BSWAP) || (!big_endian && NEED_LE_BSWAP)=
;
 }

 /*
@@ -1259,6 +1246,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCG=
MemOpIdx oi,
     unsigned a_bits =3D get_alignment_bits(get_memop(oi));
     void *haddr;
     uint64_t res;
+    MemOp op;

     /* Handle CPU specific unaligned behaviour */
     if (addr & ((1 << a_bits) - 1)) {
@@ -1304,9 +1292,13 @@ load_helper(CPUArchState *env, target_ulong addr, TC=
GMemOpIdx oi,
             }
         }

-        res =3D io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
-                       mmu_idx, addr, retaddr, access_type, SIZE_MEMOP(siz=
e));
-        return handle_bswap(res, size, big_endian);
+        op =3D SIZE_MEMOP(size);
+        if (need_bswap(big_endian)) {
+            op ^=3D MO_BSWAP;
+        }
+
+        return io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
+                       mmu_idx, addr, retaddr, access_type, op);
     }

     /* Handle slow unaligned access (it spans two pages or IO).  */
@@ -1507,6 +1499,7 @@ store_helper(CPUArchState *env, target_ulong addr, ui=
nt64_t val,
     const size_t tlb_off =3D offsetof(CPUTLBEntry, addr_write);
     unsigned a_bits =3D get_alignment_bits(get_memop(oi));
     void *haddr;
+    MemOp op;

     /* Handle CPU specific unaligned behaviour */
     if (addr & ((1 << a_bits) - 1)) {
@@ -1552,9 +1545,13 @@ store_helper(CPUArchState *env, target_ulong addr, u=
int64_t val,
             }
         }

+        op =3D SIZE_MEMOP(size);
+        if (need_bswap(big_endian)) {
+            op ^=3D MO_BSWAP;
+        }
+
         io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
-                  handle_bswap(val, size, big_endian),
-                  addr, retaddr, SIZE_MEMOP(size));
+                  val, addr, retaddr, op);
         return;
     }

diff --git a/memory.c b/memory.c
index 6982e19..0277d3d 100644
--- a/memory.c
+++ b/memory.c
@@ -352,7 +352,7 @@ static bool memory_region_big_endian(MemoryRegion *mr)
 #endif
 }

-static bool memory_region_wrong_endianness(MemoryRegion *mr)
+static bool memory_region_endianness_inverted(MemoryRegion *mr)
 {
 #ifdef TARGET_WORDS_BIGENDIAN
     return mr->ops->endianness =3D=3D DEVICE_LITTLE_ENDIAN;
@@ -361,23 +361,27 @@ static bool memory_region_wrong_endianness(MemoryRegi=
on *mr)
 #endif
 }

-static void adjust_endianness(MemoryRegion *mr, uint64_t *data, unsigned s=
ize)
+static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
 {
-    if (memory_region_wrong_endianness(mr)) {
-        switch (size) {
-        case 1:
+    if (memory_region_endianness_inverted(mr)) {
+        op ^=3D MO_BSWAP;
+    }
+
+    if (op & MO_BSWAP) {
+        switch (op & MO_SIZE) {
+        case MO_8:
             break;
-        case 2:
+        case MO_16:
             *data =3D bswap16(*data);
             break;
-        case 4:
+        case MO_32:
             *data =3D bswap32(*data);
             break;
-        case 8:
+        case MO_64:
             *data =3D bswap64(*data);
             break;
         default:
-            abort();
+            g_assert_not_reached();
         }
     }
 }
@@ -1451,7 +1455,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion =
*mr,
     }

     r =3D memory_region_dispatch_read1(mr, addr, pval, size, attrs);
-    adjust_endianness(mr, pval, size);
+    adjust_endianness(mr, pval, op);
     return r;
 }

@@ -1494,7 +1498,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion=
 *mr,
         return MEMTX_DECODE_ERROR;
     }

-    adjust_endianness(mr, &data, size);
+    adjust_endianness(mr, &data, op);

     if ((!kvm_eventfds_enabled()) &&
         memory_region_dispatch_write_eventfds(mr, addr, data, size, attrs)=
) {
@@ -2340,7 +2344,7 @@ void memory_region_add_eventfd(MemoryRegion *mr,
     }

     if (size) {
-        adjust_endianness(mr, &mrfd.data, size);
+        adjust_endianness(mr, &mrfd.data, SIZE_MEMOP(size));
     }
     memory_region_transaction_begin();
     for (i =3D 0; i < mr->ioeventfd_nb; ++i) {
@@ -2375,7 +2379,7 @@ void memory_region_del_eventfd(MemoryRegion *mr,
     unsigned i;

     if (size) {
-        adjust_endianness(mr, &mrfd.data, size);
+        adjust_endianness(mr, &mrfd.data, SIZE_MEMOP(size));
     }
     memory_region_transaction_begin();
     for (i =3D 0; i < mr->ioeventfd_nb; ++i) {
--
1.8.3.1



