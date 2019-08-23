Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDF4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4409121848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 18:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4409121848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1EhO-0002v9-QA
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 14:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1EOc-0000h4-5h
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1EOa-00088y-MZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:34:46 -0400
Received: from nsstlmta37p.bpe.bigpond.com ([203.38.21.37]:50424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i1EOZ-00086j-Vq
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:34:44 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep37p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823183439.FUKZ1159.nsstlfep37p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 04:34:39 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopegusgiirdhtvghlshhtrhgrrdgtohhmrdgruhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeorghtrghrgehqvghmuhesghhmrghilhdrtghomheqpdhrtghpthhtohepoehmrghrkhdrtggrvhgvqdgrhihlrghnugesihhlrghnuggvrdgtohdruhhkqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrgheqpdhrtghpthhtohepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecuvehluhhsthgvrhfuihiivgepud
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D2D11750F57C8A6; Sat, 24 Aug 2019 04:34:39 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 04:36:58 +1000
Message-Id: <3c8d5181a584f1b3712d3d8d66801b13cecb4b88.1566466906.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566466906.git.tony.nguyen@bt.com>
References: <cover.1566466906.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.37
Subject: [Qemu-devel] [PATCH v9 20/20] target/sparc: sun4u Invert Endian TTE
 bit
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

This bit configures endianness of PCI MMIO devices. It is used by
Solaris and OpenBSD sunhme drivers.

Tested working on OpenBSD.

Unfortunately Solaris 10 had a unrelated keyboard issue blocking
testing... another inch towards Solaris 10 on SPARC64 =)

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/cpu.h        | 2 ++
 target/sparc/mmu_helper.c | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 694d7139cf..490e14dfcf 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -275,6 +275,7 @@ enum {
 
 #define TTE_VALID_BIT       (1ULL << 63)
 #define TTE_NFO_BIT         (1ULL << 60)
+#define TTE_IE_BIT          (1ULL << 59)
 #define TTE_USED_BIT        (1ULL << 41)
 #define TTE_LOCKED_BIT      (1ULL <<  6)
 #define TTE_SIDEEFFECT_BIT  (1ULL <<  3)
@@ -291,6 +292,7 @@ enum {
 
 #define TTE_IS_VALID(tte)   ((tte) & TTE_VALID_BIT)
 #define TTE_IS_NFO(tte)     ((tte) & TTE_NFO_BIT)
+#define TTE_IS_IE(tte)      ((tte) & TTE_IE_BIT)
 #define TTE_IS_USED(tte)    ((tte) & TTE_USED_BIT)
 #define TTE_IS_LOCKED(tte)  ((tte) & TTE_LOCKED_BIT)
 #define TTE_IS_SIDEEFFECT(tte) ((tte) & TTE_SIDEEFFECT_BIT)
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 826e14b6f0..77dc86ac5c 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -537,6 +537,10 @@ static int get_physical_address_data(CPUSPARCState *env, hwaddr *physical,
         if (ultrasparc_tag_match(&env->dtlb[i], address, context, physical)) {
             int do_fault = 0;
 
+            if (TTE_IS_IE(env->dtlb[i].tte)) {
+                attrs->byte_swap = true;
+            }
+
             /* access ok? */
             /* multiple bits in SFSR.FT may be set on TT_DFAULT */
             if (TTE_IS_PRIV(env->dtlb[i].tte) && is_user) {
@@ -792,7 +796,7 @@ void dump_mmu(CPUSPARCState *env)
             }
             if (TTE_IS_VALID(env->dtlb[i].tte)) {
                 qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
-                            ", %s, %s, %s, %s, ctx %" PRId64 " %s\n",
+                            ", %s, %s, %s, %s, ie %s, ctx %" PRId64 " %s\n",
                             i,
                             env->dtlb[i].tag & (uint64_t)~0x1fffULL,
                             TTE_PA(env->dtlb[i].tte),
@@ -801,6 +805,8 @@ void dump_mmu(CPUSPARCState *env)
                             TTE_IS_W_OK(env->dtlb[i].tte) ? "RW" : "RO",
                             TTE_IS_LOCKED(env->dtlb[i].tte) ?
                             "locked" : "unlocked",
+                            TTE_IS_IE(env->dtlb[i].tte) ?
+                            "yes" : "no",
                             env->dtlb[i].tag & (uint64_t)0x1fffULL,
                             TTE_IS_GLOBAL(env->dtlb[i].tte) ?
                             "global" : "local");
-- 
2.23.0


