Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25FFC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C464B21874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C464B21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FWJ-00057X-J4
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FPy-0007zy-LQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FPx-0002WC-Av
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:14 -0400
Received: from nsstlmta15p.bpe.bigpond.com ([203.38.21.15]:47462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i1FPw-0002Os-Li
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:13 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep15p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823194008.SANB20769.nsstlfep15p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 05:40:08 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopegusgiirdhtvghlshhtrhgrrdgtohhmrdgruhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeophgsohhniihinhhisehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeorhhthhesthifihguughlvgdrnhgvtheqpdhrtghpthhtohepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D2D11750F5B9B11; Sat, 24 Aug 2019 05:40:08 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 05:42:47 +1000
Message-Id: <11377fa49c502c61e74f5cab4d20ea89e317597b.1566588034.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566588033.git.tony.nguyen@bt.com>
References: <cover.1566588033.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.15
Subject: [Qemu-devel]  [PATCH 8/9] exec: Delete DEVICE_HOST_ENDIAN
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
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify code with MemOp short hand for host endianness, 0.

 typedef enum MemOp {
     /* snip */
 #ifdef HOST_WORDS_BIGENDIAN
     MO_LE    = MO_BSWAP,
     MO_BE    = 0,
 #else
     MO_LE    = 0,
     MO_BE    = MO_BSWAP,
 #endif
     /* snip */
 };

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 include/exec/cpu-common.h | 8 --------
 memory.c                  | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 7eeb78c48b..b33dc0c9f5 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -16,14 +16,6 @@ void tcg_flush_softmmu_tlb(CPUState *cs);
 
 #if !defined(CONFIG_USER_ONLY)
 
-#include "exec/memop.h"
-
-#if defined(HOST_WORDS_BIGENDIAN)
-#define DEVICE_HOST_ENDIAN MO_BE
-#else
-#define DEVICE_HOST_ENDIAN MO_LE
-#endif
-
 /* address in the RAM (different from a physical address) */
 #if defined(CONFIG_XEN_BACKEND)
 typedef uint64_t ram_addr_t;
diff --git a/memory.c b/memory.c
index d78d6e46db..ee7559a18c 100644
--- a/memory.c
+++ b/memory.c
@@ -1353,7 +1353,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps ram_device_mem_ops = {
     .read = memory_region_ram_device_read,
     .write = memory_region_ram_device_write,
-    .endianness = DEVICE_HOST_ENDIAN,
+    .endianness = 0, /* Host endianness */
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
-- 
2.23.0


