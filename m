Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C8FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 04:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A698722316
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 04:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A698722316
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWv9S-0001Dm-Hv
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 23:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qi1.zhang@intel.com>) id 1iWv7k-0007fK-IV
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 23:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qi1.zhang@intel.com>) id 1iWv7j-00035J-EX
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 23:28:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:38424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qi1.zhang@intel.com>) id 1iWv7j-00034e-7E
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 23:28:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Nov 2019 20:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; d="scan'208";a="215444125"
Received: from a23004-02.sh.intel.com ([10.239.9.129])
 by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2019 20:28:16 -0800
From: qi1.zhang@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] intel_iommu: split the resevred fields arrays into two
 ones
Date: Tue, 19 Nov 2019 20:28:13 +0800
Message-Id:
 <d3aa65ad0510cdafd5d7dcbc54bc250feb6aa59b.1570503331.git.qi1.zhang@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1570503331.git.qi1.zhang@intel.com>
References: <cover.1570503331.git.qi1.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: qi1.zhang@intel.com, ehabkost@redhat.com, mst@redhat.com,
 pbonzini@redhat.com, yadong.qi@intel.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191119122813.zCMdUuXpUM11C7w3EIkvC9ZeOPE_ebktTGfX_6PYu0Y@z>

From: "Zhang, Qi" <qi1.zhang@intel.com>

Signed-off-by: Zhang, Qi <qi1.zhang@intel.com>
---
 hw/i386/intel_iommu.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f1de8fdb75..a118efaeaf 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -910,18 +910,19 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
 
 /*
  * Rsvd field masks for spte:
- *     Index [1] to [4] 4k pages
- *     Index [5] to [8] large pages
+ *     vtd_spte_rsvd 4k pages
+ *     vtd_spte_rsvd_large large pages
  */
-static uint64_t vtd_paging_entry_rsvd_field[9];
+static uint64_t vtd_spte_rsvd[5];
+static uint64_t vtd_spte_rsvd_large[5];
 
 static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
 {
     if (slpte & VTD_SL_PT_PAGE_SIZE_MASK) {
         /* Maybe large page */
-        return slpte & vtd_paging_entry_rsvd_field[level + 4];
+        return slpte & vtd_spte_rsvd_large[level];
     } else {
-        return slpte & vtd_paging_entry_rsvd_field[level];
+        return slpte & vtd_spte_rsvd[level];
     }
 }
 
@@ -3547,15 +3548,17 @@ static void vtd_init(IntelIOMMUState *s)
     /*
      * Rsvd field masks for spte
      */
-    vtd_paging_entry_rsvd_field[0] = ~0ULL;
-    vtd_paging_entry_rsvd_field[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[5] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[6] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[7] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
-    vtd_paging_entry_rsvd_field[8] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[0] = ~0ULL;
+    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
+
+    vtd_spte_rsvd_large[0] = ~0ULL;
+    vtd_spte_rsvd_large[1] = VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd_large[4] = VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);
 
     if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
-- 
2.20.1


