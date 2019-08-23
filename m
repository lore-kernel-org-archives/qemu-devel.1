Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1179CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF7221848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF7221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Ei9-0004At-JI
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 14:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1EOb-0000fF-1F
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1EOZ-00088R-C5
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:34:44 -0400
Received: from nsstlmta28p.bpe.bigpond.com ([203.38.21.28]:43153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i1EOY-00086K-O8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:34:43 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep28p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823183438.JMKK9614.nsstlfep28p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 04:34:38 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopegusgiirdhtvghlshhtrhgrrdgtohhmrdgruhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeorghtrghrgehqvghmuhesghhmrghilhdrtghomheqpdhrtghpthhtohepoehmrghrkhdrtggrvhgvqdgrhihlrghnugesihhlrghnuggvrdgtohdruhhkqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrgheqpdhrtghpthhtohepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecuvehluhhsthgvrhfuihiivgepud
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D2D11750F57C873; Sat, 24 Aug 2019 04:34:38 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 04:36:57 +1000
Message-Id: <f8fcc3138570c460ef289a6b34ba7715ba36f99e.1566466906.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566466906.git.tony.nguyen@bt.com>
References: <cover.1566466906.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.28
Subject: [Qemu-devel] [PATCH v9 19/20] target/sparc: Add TLB entry with
 attributes
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
Cc: Tony Nguyen <tony.nguyen@bt.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Append MemTxAttrs to interfaces so we can pass along up coming Invert
Endian TTE bit on SPARC64.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/mmu_helper.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index cbd1e91179..826e14b6f0 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -88,7 +88,7 @@ static const int perm_table[2][8] = {
 };
 
 static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
-                                int *prot, int *access_index,
+                                int *prot, int *access_index, MemTxAttrs *attrs,
                                 target_ulong address, int rw, int mmu_idx,
                                 target_ulong *page_size)
 {
@@ -219,6 +219,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     target_ulong vaddr;
     target_ulong page_size;
     int error_code = 0, prot, access_index;
+    MemTxAttrs attrs = {};
 
     /*
      * TODO: If we ever need tlb_vaddr_to_host for this target,
@@ -229,7 +230,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     assert(!probe);
 
     address &= TARGET_PAGE_MASK;
-    error_code = get_physical_address(env, &paddr, &prot, &access_index,
+    error_code = get_physical_address(env, &paddr, &prot, &access_index, &attrs,
                                       address, access_type,
                                       mmu_idx, &page_size);
     vaddr = address;
@@ -490,8 +491,8 @@ static inline int ultrasparc_tag_match(SparcTLBEntry *tlb,
     return 0;
 }
 
-static int get_physical_address_data(CPUSPARCState *env,
-                                     hwaddr *physical, int *prot,
+static int get_physical_address_data(CPUSPARCState *env, hwaddr *physical,
+                                     int *prot, MemTxAttrs *attrs,
                                      target_ulong address, int rw, int mmu_idx)
 {
     CPUState *cs = env_cpu(env);
@@ -608,8 +609,8 @@ static int get_physical_address_data(CPUSPARCState *env,
     return 1;
 }
 
-static int get_physical_address_code(CPUSPARCState *env,
-                                     hwaddr *physical, int *prot,
+static int get_physical_address_code(CPUSPARCState *env, hwaddr *physical,
+                                     int *prot, MemTxAttrs *attrs,
                                      target_ulong address, int mmu_idx)
 {
     CPUState *cs = env_cpu(env);
@@ -686,7 +687,7 @@ static int get_physical_address_code(CPUSPARCState *env,
 }
 
 static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
-                                int *prot, int *access_index,
+                                int *prot, int *access_index, MemTxAttrs *attrs,
                                 target_ulong address, int rw, int mmu_idx,
                                 target_ulong *page_size)
 {
@@ -716,11 +717,11 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
     }
 
     if (rw == 2) {
-        return get_physical_address_code(env, physical, prot, address,
+        return get_physical_address_code(env, physical, prot, attrs, address,
                                          mmu_idx);
     } else {
-        return get_physical_address_data(env, physical, prot, address, rw,
-                                         mmu_idx);
+        return get_physical_address_data(env, physical, prot, attrs, address,
+                                         rw, mmu_idx);
     }
 }
 
@@ -734,10 +735,11 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     target_ulong vaddr;
     hwaddr paddr;
     target_ulong page_size;
+    MemTxAttrs attrs = {};
     int error_code = 0, prot, access_index;
 
     address &= TARGET_PAGE_MASK;
-    error_code = get_physical_address(env, &paddr, &prot, &access_index,
+    error_code = get_physical_address(env, &paddr, &prot, &access_index, &attrs,
                                       address, access_type,
                                       mmu_idx, &page_size);
     if (likely(error_code == 0)) {
@@ -747,7 +749,8 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                                    env->dmmu.mmu_primary_context,
                                    env->dmmu.mmu_secondary_context);
 
-        tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
+        tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, prot, mmu_idx,
+                                page_size);
         return true;
     }
     if (probe) {
@@ -849,9 +852,10 @@ static int cpu_sparc_get_phys_page(CPUSPARCState *env, hwaddr *phys,
 {
     target_ulong page_size;
     int prot, access_index;
+    MemTxAttrs attrs = {};
 
-    return get_physical_address(env, phys, &prot, &access_index, addr, rw,
-                                mmu_idx, &page_size);
+    return get_physical_address(env, phys, &prot, &access_index, &attrs, addr,
+                                rw, mmu_idx, &page_size);
 }
 
 #if defined(TARGET_SPARC64)
-- 
2.23.0


