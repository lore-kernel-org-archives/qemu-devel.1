Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B126C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3793320720
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3793320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKKD-00059C-TF
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 07:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1kGKED-0003aN-Dd
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:54:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:26671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1kGKEA-0005xE-F4
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:54:57 -0400
IronPort-SDR: 584lHQY74tvxDobLFlqyeI0CFJycdC8LG88aPZ7s/xJAGO5I4thRh4bXphFTizEtYxtoW/UHtx
 qG6GRVHCyWPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="158545466"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="158545466"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 03:54:39 -0700
IronPort-SDR: KYL+DBA7/CqRG61xGOcwFf2KrovP/8NEtBv7A9NJBAUou9bME+cOo+X8tBNE+nCSpQHT7S4X/h
 1/Khj93vKeuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; d="scan'208";a="334140036"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 10 Sep 2020 03:54:39 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com,
 jasowang@redhat.com
Subject: [RFC v10 01/25] scripts/update-linux-headers: Import iommu.h
Date: Thu, 10 Sep 2020 03:56:14 -0700
Message-Id: <1599735398-6829-2-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599735398-6829-1-git-send-email-yi.l.liu@intel.com>
References: <1599735398-6829-1-git-send-email-yi.l.liu@intel.com>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=yi.l.liu@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 06:54:39
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, yi.l.liu@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, Cornelia Huck <cohuck@redhat.com>, eric.auger@redhat.com,
 yi.y.sun@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 pbonzini@redhat.com, hao.wu@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Update the script to import the new iommu.h uapi header.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 29c27f4..5b64ee3 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -141,7 +141,7 @@ done
 
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
-for header in kvm.h vfio.h vfio_ccw.h vhost.h \
+for header in kvm.h vfio.h vfio_ccw.h vhost.h iommu.h \
               psci.h psp-sev.h userfaultfd.h mman.h; do
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
-- 
2.7.4


