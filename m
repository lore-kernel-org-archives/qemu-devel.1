Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A800AC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F119206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QJp5mv80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F119206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClUI-0001LZ-Ki
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2341787188=bbhushan2@marvell.com>)
 id 1jCf3T-0005sK-5q
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2341787188=bbhushan2@marvell.com>)
 id 1jCf3S-0001Rw-4Y
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:48:27 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:30980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2341787188=bbhushan2@marvell.com>)
 id 1jCf3P-0001Ka-6m; Fri, 13 Mar 2020 03:48:23 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02D7kdkY020456; Fri, 13 Mar 2020 00:48:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=5x5XWt7UJuZnrVK7KO1KvYL06RXOteeFnKHck+rpKoo=;
 b=QJp5mv80e26+gJ6Tpv9f4df72fcxDsL8hZUnEMzkZrtyCzgFKRsE20L6xxTmaMUx+Yoq
 5M+fpguaAwy56tHiBz7GQxyA8b/Q2LHkzmen3PINsixuuV9dzWZkN72YXAHr1l3B/+WT
 W4pO6sF7MjF6cWPDPh0xyc+al1ayZtkRcVqxL5CMrE4iFhUVQevqvAUG4Q0TbuN5iH4d
 xJJR+LkvgLjLaVsU/UauREff6ZODlfuO6WhgfH5KeWf/eTspP18BOPWtEDoiNZgvnmeS
 Q85Lr1BAhI+1wcneeH4uIgxPYIPDONdMqzBGNYCDPy7wLqX7hIzvlURnwAUoM/0UhkoZ /w== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 2yqt7f2vnk-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2020 00:48:20 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 13 Mar
 2020 00:48:17 -0700
Received: from bbhushan2.marvell.com (10.93.176.43) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Mar 2020 00:48:13 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <peter.maydell@linaro.org>, <peterx@redhat.com>,
 <eric.auger.pro@gmail.com>, <alex.williamson@redhat.com>,
 <kevin.tian@intel.com>, <mst@redhat.com>, <tnowicki@marvell.com>,
 <drjones@redhat.com>, <linuc.decode@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <bharatb.linux@gmail.com>
Subject: [PATCH v7 0/5] virtio-iommu: VFIO integration
Date: Fri, 13 Mar 2020 13:18:06 +0530
Message-ID: <20200313074811.27175-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_03:2020-03-11,
 2020-03-13 signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.156.173
X-Mailman-Approved-At: Fri, 13 Mar 2020 10:36:05 -0400
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
Cc: Bharat Bhushan <bbhushan2@marvell.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series integrates VFIO with virtio-iommu.
This is only applicable for PCI pass-through with virtio-iommu.

This series is available at:
https://github.com/bharat-bhushan-devel/qemu.git virtio-iommu-vfio-integration-v7

This is tested with assigning more than one pci devices to Virtual Machine.

This series is based on:
  - virtio-iommu device emulation by Eric Augur.
    [v16,00/10] VIRTIO-IOMMU device
    https://github.com/eauger/qemu/tree/v4.2-virtio-iommu-v16

  - Linux 5.6.0-rc4

v6->v7:
  - corrected email-address

v5->v6:
  - Rebase to v16 version from Eric
  - Tested with upstream Linux
  - Added a patch from Eric/Myself on removing mmio-region error print in vfio

v4->v5:
 - Rebase to v9 version from Eric
 - PCIe device hotplug fix
 - Added Patch 1/5 from Eric previous series (Eric somehow dropped in
   last version.
 - Patch "Translate the MSI doorbell in kvm_arch_fixup_msi_route"
   already integrated with vsmmu3

v3->v4:
 - Rebase to v4 version from Eric
 - Fixes from Eric with DPDK in VM
 - Logical division in multiple patches

v2->v3:
 - This series is based on "[RFC v3 0/8] VIRTIO-IOMMU device"
   Which is based on top of v2.10-rc0 that
 - Fixed issue with two PCI devices
 - Addressed review comments

v1->v2:
  - Added trace events
  - removed vSMMU3 link in patch description

Bharat Bhushan (5):
  hw/vfio/common: Remove error print on mmio region translation by
    viommu
  virtio-iommu: Add iommu notifier for map/unmap
  virtio-iommu: Call iommu notifier for attach/detach
  virtio-iommu: add iommu replay
  virtio-iommu: add iommu notifier memory-region

 hw/vfio/common.c                 |   2 -
 hw/virtio/trace-events           |   5 +
 hw/virtio/virtio-iommu.c         | 189 ++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-iommu.h |   6 +
 4 files changed, 199 insertions(+), 3 deletions(-)

-- 
2.17.1


