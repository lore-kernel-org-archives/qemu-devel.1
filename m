Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7235BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4676F21848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4676F21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FPj-0007P7-6Y
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FOw-0006b3-Hg
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FOv-0001zx-0S
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:39:10 -0400
Received: from nsstlmta22p.bpe.bigpond.com ([203.38.21.22]:44994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i1FOu-0001wD-DW
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:39:08 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep22p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823193903.RUEW9585.nsstlfep22p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 05:39:03 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopegusgiirdhtvghlshhtrhgrrdgtohhmrdgruhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeomhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehmshhtsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehpsghonhiiihhnihesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrgheqpdhrtghpthhtohepoehrthhhsehtfihiuggulhgvrdhnvghtqedprhgtphhtthhopeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3692920C8EB6FF; Sat, 24 Aug 2019 05:39:03 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 05:42:40 +1000
Message-Id: <8f687bc199a1f6245ae977141a777a8fd7aa7477.1566588034.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566588033.git.tony.nguyen@bt.com>
References: <cover.1566588033.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.22
Subject: [Qemu-devel]  [PATCH 1/9] exec: Map device_endian onto MemOp
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Preparation to replace device_endian with MemOp.

Mapping device_endian onto MemOp limits behaviour changes to this
relatively smaller patch.

The next patch will replace all device_endian usages with the
equivalent MemOp. That patch will be large but have no behaviour
changes.

A subsequent patch will then delete unused device_endian.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/char/serial.c          | 18 ++++++------------
 include/exec/cpu-common.h | 10 +++++++---
 memory.c                  |  1 -
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index b4aa250950..6328476f52 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1016,22 +1016,15 @@ static void serial_mm_write(void *opaque, hwaddr addr,
     serial_ioport_write(s, addr >> s->it_shift, value, 1);
 }
 
-static const MemoryRegionOps serial_mm_ops[3] = {
-    [DEVICE_NATIVE_ENDIAN] = {
-        .read = serial_mm_read,
-        .write = serial_mm_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
-        .valid.max_access_size = 8,
-        .impl.max_access_size = 8,
-    },
-    [DEVICE_LITTLE_ENDIAN] = {
+static const MemoryRegionOps serial_mm_ops[2] = {
+    [0] = {
         .read = serial_mm_read,
         .write = serial_mm_write,
         .endianness = DEVICE_LITTLE_ENDIAN,
         .valid.max_access_size = 8,
         .impl.max_access_size = 8,
     },
-    [DEVICE_BIG_ENDIAN] = {
+    [1] = {
         .read = serial_mm_read,
         .write = serial_mm_write,
         .endianness = DEVICE_BIG_ENDIAN,
@@ -1057,8 +1050,9 @@ SerialState *serial_mm_init(MemoryRegion *address_space,
     serial_realize_core(s, &error_fatal);
     vmstate_register(NULL, base, &vmstate_serial, s);
 
-    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
-                          "serial", 8 << it_shift);
+    memory_region_init_io(&s->io, NULL,
+                          &serial_mm_ops[end == DEVICE_BIG_ENDIAN],
+                          s, "serial", 8 << it_shift);
     memory_region_add_subregion(address_space, base, &s->io);
     return s;
 }
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index f7dbe75fbc..c388453ed7 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -16,10 +16,14 @@ void tcg_flush_softmmu_tlb(CPUState *cs);
 
 #if !defined(CONFIG_USER_ONLY)
 
+#include "exec/memop.h"
+
 enum device_endian {
-    DEVICE_NATIVE_ENDIAN,
-    DEVICE_BIG_ENDIAN,
-    DEVICE_LITTLE_ENDIAN,
+#ifdef NEED_CPU_H
+    DEVICE_NATIVE_ENDIAN = MO_TE,
+#endif
+    DEVICE_BIG_ENDIAN = MO_BE,
+    DEVICE_LITTLE_ENDIAN = MO_LE,
 };
 
 #if defined(HOST_WORDS_BIGENDIAN)
diff --git a/memory.c b/memory.c
index 11a9b08060..f30ce520c9 100644
--- a/memory.c
+++ b/memory.c
@@ -3283,7 +3283,6 @@ MemOp devend_memop(enum device_endian end)
     switch (end) {
     case DEVICE_LITTLE_ENDIAN:
     case DEVICE_BIG_ENDIAN:
-    case DEVICE_NATIVE_ENDIAN:
         return conv[end];
     default:
         g_assert_not_reached();
-- 
2.23.0


