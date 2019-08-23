Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEB8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B8921848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B8921848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FSK-0001TE-Ly
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FPx-0007yY-Hx
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FPu-0002U0-V1
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:12 -0400
Received: from nsstlmta33p.bpe.bigpond.com ([203.38.21.33]:56058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i1FPu-0002MX-9n
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:10 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep33p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823194005.JAFI15166.nsstlfep33p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 05:40:05 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopegusgiirdhtvghlshhtrhgrrdgtohhmrdgruhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeouggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruheqpdhrtghpthhtohepoehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeomhhsthesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgsohhniihinhhisehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeorhhitghhrghrugdrhhgvnhguvghrshhonheslhhinhgrrhhordhorhhgqedprhgtphhtthhopeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucevlhhushhtvghr
 ufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D2D11750F5B9A4F; Sat, 24 Aug 2019 05:40:04 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 05:42:44 +1000
Message-Id: <ede636b9438e0c6ddc16292fe776b6569fb87cbf.1566588034.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566588033.git.tony.nguyen@bt.com>
References: <cover.1566588033.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.33
Subject: [Qemu-devel] [PATCH 5/9] exec: Replace enum device_endian with MemOp
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify endianness comparisons with consistent use of the more
expressive MemOp.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/char/serial.c         |  2 +-
 include/exec/memory.h    |  6 +++---
 include/hw/char/serial.h |  2 +-
 memory.c                 |  2 +-
 memory_ldst.inc.c        | 15 ++++++---------
 5 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index cf41203be6..c725688828 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1036,7 +1036,7 @@ static const MemoryRegionOps serial_mm_ops[2] = {
 SerialState *serial_mm_init(MemoryRegion *address_space,
                             hwaddr base, int it_shift,
                             qemu_irq irq, int baudbase,
-                            Chardev *chr, enum device_endian end)
+                            Chardev *chr, MemOp end)
 {
     SerialState *s;
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index c4c86a6ff4..1fa7e03707 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -168,7 +168,7 @@ struct MemoryRegionOps {
                                     unsigned size,
                                     MemTxAttrs attrs);
 
-    enum device_endian endianness;
+    MemOp endianness;
     /* Guest-visible constraints: */
     struct {
         /* If nonzero, specify bounds on access sizes beyond which a machine
@@ -2211,8 +2211,8 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
     }
 }
 
-/* enum device_endian to MemOp.  */
-MemOp devend_memop(enum device_endian end);
+/* MemOp to MemOp.  */
+MemOp devend_memop(MemOp end);
 
 #endif
 
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 8be3d8a4f9..175b980249 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -90,7 +90,7 @@ SerialState *serial_init(int base, qemu_irq irq, int baudbase,
 SerialState *serial_mm_init(MemoryRegion *address_space,
                             hwaddr base, int it_shift,
                             qemu_irq irq, int baudbase,
-                            Chardev *chr, enum device_endian end);
+                            Chardev *chr, MemOp end);
 
 /* serial-isa.c */
 
diff --git a/memory.c b/memory.c
index 52090e18eb..ee2bef7b1e 100644
--- a/memory.c
+++ b/memory.c
@@ -3272,7 +3272,7 @@ static void memory_register_types(void)
 
 type_init(memory_register_types)
 
-MemOp devend_memop(enum device_endian end)
+MemOp devend_memop(MemOp end)
 {
     static MemOp conv[] = {
         [MO_LE] = MO_LE,
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index 45bec83a94..dd1e02d685 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -21,8 +21,7 @@
 
 /* warning: addr must be aligned */
 static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result, MemOp endian)
 {
     uint8_t *ptr;
     uint64_t val;
@@ -89,8 +88,7 @@ uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
 
 /* warning: addr must be aligned */
 static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result, MemOp endian)
 {
     uint8_t *ptr;
     uint64_t val;
@@ -191,8 +189,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
 
 /* warning: addr must be aligned */
 static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result,
-    enum device_endian endian)
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result, MemOp endian)
 {
     uint8_t *ptr;
     uint64_t val;
@@ -299,7 +296,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
 /* warning: addr must be aligned */
 static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs,
-    MemTxResult *result, enum device_endian endian)
+    MemTxResult *result, MemOp endian)
 {
     uint8_t *ptr;
     MemoryRegion *mr;
@@ -395,7 +392,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
 /* warning: addr must be aligned */
 static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs,
-    MemTxResult *result, enum device_endian endian)
+    MemTxResult *result, MemOp endian)
 {
     uint8_t *ptr;
     MemoryRegion *mr;
@@ -459,7 +456,7 @@ void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
 
 static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs,
-    MemTxResult *result, enum device_endian endian)
+    MemTxResult *result, MemOp endian)
 {
     uint8_t *ptr;
     MemoryRegion *mr;
-- 
2.23.0


