Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4557DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 08:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03D6820747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 08:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D6820747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrd73-0006hF-8O
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 04:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jrd6N-0006E4-Mc
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 04:00:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:29129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jrd6K-0002rh-Pw
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 04:00:47 -0400
IronPort-SDR: C/puNC7yMjj3rWw6ftfDbO8PaUDKKzfzaSstiPt8VpTkXzuT5d2ty5diESoaTnOOpqNt5huG0b
 v4CorjYgwC0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="146326459"
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; d="scan'208";a="146326459"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2020 01:00:39 -0700
IronPort-SDR: dt75VqsUfuU16HuXYFpzdJe1L6K6lKAPqQbTtrLEgjwjcCLPBg84LhX/SssBXNANePafOPr3xU
 DSyKWofI3aKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; d="scan'208";a="278609818"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 04 Jul 2020 01:00:38 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: peterx@redhat.com
Subject: [PATCH] intel_iommu: Use correct shift for 256 bits qi descriptor
Date: Sat,  4 Jul 2020 01:07:15 -0700
Message-Id: <1593850035-35483-1-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=192.55.52.115; envelope-from=yi.l.liu@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 04:00:39
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: jasowang@redhat.com, yi.l.liu@intel.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In chapter 10.4.23 of VT-d spec 3.0, Descriptor Width bit was introduced
in VTD_IQA_REG. Sfotware could set this bit to tell VT-d the QI descriptor
from software would be 256 bits. Accordingly, the VTD_IQH_QH_SHIFT should
be 5 when descriptor size is 256 bits.

This patch adds the DW bit check when deciding the shift used to update
VTD_IQH_REG.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 7 ++++++-
 hw/i386/intel_iommu_internal.h | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index df7ad25..8703a2d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2549,6 +2549,11 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
 /* Try to fetch and process more Invalidation Descriptors */
 static void vtd_fetch_inv_desc(IntelIOMMUState *s)
 {
+    int qi_shift;
+
+    /* Refer to 10.4.23 of VT-d spec 3.0 */
+    qi_shift = s->iq_dw ? VTD_IQH_QH_SHIFT_5 : VTD_IQH_QH_SHIFT_4;
+
     trace_vtd_inv_qi_fetch();
 
     if (s->iq_tail >= s->iq_size) {
@@ -2567,7 +2572,7 @@ static void vtd_fetch_inv_desc(IntelIOMMUState *s)
         }
         /* Must update the IQH_REG in time */
         vtd_set_quad_raw(s, DMAR_IQH_REG,
-                         (((uint64_t)(s->iq_head)) << VTD_IQH_QH_SHIFT) &
+                         (((uint64_t)(s->iq_head)) << qi_shift) &
                          VTD_IQH_QH_MASK);
     }
 }
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 862033e..3d5487f 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -230,7 +230,8 @@
 #define VTD_IQA_DW_MASK             0x800
 
 /* IQH_REG */
-#define VTD_IQH_QH_SHIFT            4
+#define VTD_IQH_QH_SHIFT_4          4
+#define VTD_IQH_QH_SHIFT_5          5
 #define VTD_IQH_QH_MASK             0x7fff0ULL
 
 /* ICS_REG */
-- 
2.7.4


