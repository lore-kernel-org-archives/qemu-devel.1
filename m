Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37024C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37942071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8S5/jl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37942071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZA0l-0007dr-Qc
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 03:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iZ9zC-00066Y-0j
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iZ9zA-0004oY-SB
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:44:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40505
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iZ9zA-0004oJ-O8
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574671484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4dBhjT1uWH0VCqhFFsGJaKzc2J6PSyGnEtdphUAkNnQ=;
 b=U8S5/jl6pjBQC4ftps5eJqbkY+2ySy87+UFcLYp+gnaNorCIi8YOEKpfcrlrwdI2iu28EP
 IMiMJoLWv1scIhM0HkMm8HTZ832Ph52J7yFZfc74y7Ciiy04YOH3MwNgJbm6Uflqne8wKQ
 KtwC7ZM/2OLaP+hW106VH9ECjO9hJ0M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-3f5LAVnTMUiiXUTlIJ0aJg-1; Mon, 25 Nov 2019 03:44:43 -0500
Received: by mail-qk1-f200.google.com with SMTP id d26so3576644qkk.8
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 00:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=agD97voKPsUwFE0u9W1wgFfuitVi4B3xHtAAj/HEuKg=;
 b=uIeajLO6DzLyhv2lWtKl6SohhcCMyr06gZKmsOlQ1wKQhFM2YT0zxxFo+qfS8RR8t4
 ZMPV/eQCNORtmYMheI0gbtDM5hK+0PYyboRDcqjD6nuzcY2j2yPIwm+95mbg47W7xzU/
 A/MokjjzCgjHpv3ateR5XYJKhr5AyZEMBCHZZ810AmHbOR1Jly8YZ212zjCUR6Awjx6t
 auVcDbPbOR25wWrGEBR84NRn7otqVcsS5KSyWGrZxzmf9tfEq2BAZ7Cu4+pSm43KGPLQ
 SFcxwNFTf/Zm7PBLpXfHi0hf8iwlV0pGuic/Srufqv29R/13cnXlIT87fxPd7ggWfSTk
 3vVQ==
X-Gm-Message-State: APjAAAUx/FMdf0MxTARK+Nh3JQhwKRRbtJpoXgYV6kQS6RulqWK0kZh4
 bI+N3pD1IYpvlS+tP/1J0bkSXpo1DFEgUFbITG0C1tYKufBDOf1MadRGm9RbZv3QrO2LMnQgXDi
 xlmr9hGBvBh7nvy0=
X-Received: by 2002:a37:a51:: with SMTP id 78mr16380819qkk.112.1574671482294; 
 Mon, 25 Nov 2019 00:44:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyM1dvRg2QfyFA3tcKTC3p4KmrZnfzUmKrZ0o2YtDvh0olwUyI1bAP1i+55r6KCiJ8FvvT3fw==
X-Received: by 2002:a37:a51:: with SMTP id 78mr16380803qkk.112.1574671482033; 
 Mon, 25 Nov 2019 00:44:42 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id b81sm3049527qkc.135.2019.11.25.00.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 00:44:41 -0800 (PST)
Date: Mon, 25 Nov 2019 03:44:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] intel_iommu: refine SL-PEs reserved fields checking
Message-ID: <20191125084403.324866-3-mst@redhat.com>
References: <20191125084403.324866-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191125084403.324866-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: 3f5LAVnTMUiiXUTlIJ0aJg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Qi <qi1.zhang@intel.com>, Qi@redhat.com,
 Peter Xu <peterx@redhat.com>, Zhang@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, "Qi, Yadong" <yadong.qi@intel.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Qi, Yadong" <yadong.qi@intel.com>

1. split the resevred fields arrays into two ones,
2. large page only effect for L2(2M) and L3(1G), so
   remove checking of L1 and L4 for large page.

Signed-off-by: Zhang, Qi <qi1.zhang@intel.com>
Signed-off-by: Qi, Yadong <yadong.qi@intel.com>
Message-Id: <20191125003321.5669-2-yadong.qi@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c          | 37 ++++++++++++++++++----------------
 hw/i386/intel_iommu_internal.h |  5 +----
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 14e4e6ad62..feb9e55f87 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -910,19 +910,23 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUS=
tate *s,
=20
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
=20
 static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
 {
-    if (slpte & VTD_SL_PT_PAGE_SIZE_MASK) {
-        /* Maybe large page */
-        return slpte & vtd_paging_entry_rsvd_field[level + 4];
-    } else {
-        return slpte & vtd_paging_entry_rsvd_field[level];
+    uint64_t rsvd_mask =3D vtd_spte_rsvd[level];
+
+    if ((level =3D=3D VTD_SL_PD_LEVEL || level =3D=3D VTD_SL_PDP_LEVEL) &&
+        (slpte & VTD_SL_PT_PAGE_SIZE_MASK)) {
+        /* large page */
+        rsvd_mask =3D vtd_spte_rsvd_large[level];
     }
+
+    return slpte & rsvd_mask;
 }
=20
 /* Find the VTD address space associated with a given bus number */
@@ -3549,15 +3553,14 @@ static void vtd_init(IntelIOMMUState *s)
     /*
      * Rsvd field masks for spte
      */
-    vtd_paging_entry_rsvd_field[0] =3D ~0ULL;
-    vtd_paging_entry_rsvd_field[1] =3D VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bi=
ts);
-    vtd_paging_entry_rsvd_field[2] =3D VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bi=
ts);
-    vtd_paging_entry_rsvd_field[3] =3D VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bi=
ts);
-    vtd_paging_entry_rsvd_field[4] =3D VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bi=
ts);
-    vtd_paging_entry_rsvd_field[5] =3D VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_b=
its);
-    vtd_paging_entry_rsvd_field[6] =3D VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_b=
its);
-    vtd_paging_entry_rsvd_field[7] =3D VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_b=
its);
-    vtd_paging_entry_rsvd_field[8] =3D VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_b=
its);
+    vtd_spte_rsvd[0] =3D ~0ULL;
+    vtd_spte_rsvd[1] =3D VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[2] =3D VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[3] =3D VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[4] =3D VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
+
+    vtd_spte_rsvd_large[2] =3D VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd_large[3] =3D VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
=20
     if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |=3D VTD_ECAP_IR | VTD_ECAP_MHMV;
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index c1235a7063..1654f746bc 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -395,14 +395,11 @@ typedef union VTDInvDesc VTDInvDesc;
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
         (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_LPAGE_L1_RSVD_MASK(aw) \
-        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
+
 #define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
         (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_LPAGE_L4_RSVD_MASK(aw) \
-        (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
=20
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
--=20
MST


