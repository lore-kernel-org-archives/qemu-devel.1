Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D414AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD52722CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD52722CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FXB-0006F1-Gm
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FPy-0007zr-JO
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FPv-0002Uu-Rv
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:14 -0400
Received: from nsstlmta31p.bpe.bigpond.com ([203.38.21.31]:55290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i1FPv-0002Mo-5Z
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:11 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep31p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823194006.EIFW30018.nsstlfep31p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 05:40:06 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopegusgiirdhtvghlshhtrhgrrdgtohhmrdgruhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeophgsohhniihinhhisehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D2D11750F5B9AA9; Sat, 24 Aug 2019 05:40:06 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 05:42:45 +1000
Message-Id: <3bd9a0372fe39837f676ed05b1297ecec894e030.1566588034.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566588033.git.tony.nguyen@bt.com>
References: <cover.1566588033.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.31
Subject: [Qemu-devel]  [PATCH 6/9] memory: Delete devend_memop
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

device_endian has been made redundant by MemOp.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 include/exec/memory.h |  3 ---
 memory.c              | 19 +------------------
 memory_ldst.inc.c     | 18 ++++++------------
 3 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1fa7e03707..ff80465ac1 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2211,9 +2211,6 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
     }
 }
 
-/* MemOp to MemOp.  */
-MemOp devend_memop(MemOp end);
-
 #endif
 
 #endif
diff --git a/memory.c b/memory.c
index ee2bef7b1e..d78d6e46db 100644
--- a/memory.c
+++ b/memory.c
@@ -354,7 +354,7 @@ static bool memory_region_big_endian(MemoryRegion *mr)
 
 static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
 {
-    if ((op & MO_BSWAP) != devend_memop(mr->ops->endianness)) {
+    if ((op & MO_BSWAP) != mr->ops->endianness) {
         switch (op & MO_SIZE) {
         case MO_8:
             break;
@@ -3271,20 +3271,3 @@ static void memory_register_types(void)
 }
 
 type_init(memory_register_types)
-
-MemOp devend_memop(MemOp end)
-{
-    static MemOp conv[] = {
-        [MO_LE] = MO_LE,
-        [MO_BE] = MO_BE,
-        [MO_TE] = MO_TE,
-        [DEVICE_HOST_ENDIAN] = 0,
-    };
-    switch (end) {
-    case MO_LE:
-    case MO_BE:
-        return conv[end];
-    default:
-        g_assert_not_reached();
-    }
-}
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index dd1e02d685..028227f52f 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -37,8 +37,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val,
-                                        MO_32 | devend_memop(endian), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, MO_32 | endian, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -104,8 +103,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val,
-                                        MO_64 | devend_memop(endian), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, MO_64 | endian, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -205,8 +203,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val,
-                                        MO_16 | devend_memop(endian), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, MO_16 | endian, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -309,8 +306,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 4 || !memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val,
-                                         MO_32 | devend_memop(endian), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_32 | endian, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -405,8 +401,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 2 || !memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val,
-                                         MO_16 | devend_memop(endian), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_16 | endian, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -469,8 +464,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 8 || !memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val,
-                                         MO_64 | devend_memop(endian), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_64 | endian, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-- 
2.23.0


