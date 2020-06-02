Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3A5C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C93C206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cBo7n2xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C93C206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCPU-0008E5-HZ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jgCOJ-0006n5-90
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:16:03 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jgCOI-0002fy-Cg
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:16:02 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ed6a51a0000>; Tue, 02 Jun 2020 12:14:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 02 Jun 2020 12:16:01 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 02 Jun 2020 12:16:01 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Jun
 2020 19:15:54 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 2 Jun 2020 19:15:48 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH 2/2] vfio iommu: typecast corrections
Date: Wed, 3 Jun 2020 00:12:37 +0530
Message-ID: <1591123357-18297-2-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1591123357-18297-1-git-send-email-kwankhede@nvidia.com>
References: <1591123357-18297-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1591125274; bh=5Wj2K9vuNloUX1WzMLTNpeDsMst3FebRuyzK2zg0M7M=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=cBo7n2xs0y/XG43Pmp4cE0XDWwFN6CRR0/k2U0QvCqC2wiK0KeAwjcCQokSzPLZ9D
 AkJAtp0iaTQxQuJ9GPiQjcIQzxYz6bq7N9FmJ9fzgchpCNYBB2sxFkVmDtS6PboWx3
 tz8tgfiI3THfQoqwU+yLY6+oQm+3wlG6IwXsUaAf/VojEIDUhCpT0HBa3/RCTrlOMJ
 o2C7bfcnViThvxtrwAqfy8OR3w7JNn/8tTqlkeTpaNpXpyS4HNWBKVCNmyw5QmTZGE
 0faAGCCNt1IGuJzIbCvtx1IWHtOVeVDbX9yX16/8VREkYattFwQxN0Sk6oSS2gALAy
 12pHpWs2kZ7qQ==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 15:15:59
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yan.y.zhao@intel.com, kvm@vger.kernel.org, eskultet@redhat.com,
 ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes sparse warnings by adding '__user' in typecast for
copy_[from,to]_user()

Fixes: d6a4c185660c (vfio iommu: Implementation of ioctl for dirty pages tracking)

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 9d9c8709a24c..5e556ac9102a 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -998,14 +998,14 @@ static int update_user_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
 				  nbits + shift);
 
 		if (copy_from_user(&leftover,
-				   (const void *)(bitmap + copy_offset),
+				   (void __user *)(bitmap + copy_offset),
 				   sizeof(leftover)))
 			return -EFAULT;
 
 		bitmap_or(dma->bitmap, dma->bitmap, &leftover, shift);
 	}
 
-	if (copy_to_user((void *)(bitmap + copy_offset), dma->bitmap,
+	if (copy_to_user((void __user *)(bitmap + copy_offset), dma->bitmap,
 			 DIRTY_BITMAP_BYTES(nbits + shift)))
 		return -EFAULT;
 
-- 
2.7.0


