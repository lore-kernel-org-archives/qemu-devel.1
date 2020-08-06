Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD8DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606F7221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606F7221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3cLd-0006l7-VG
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 05:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k3cKd-0005B5-Du; Thu, 06 Aug 2020 05:37:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4229 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k3cKa-0007WF-8e; Thu, 06 Aug 2020 05:37:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 30D4CDAD1A6B884FFD1C;
 Thu,  6 Aug 2020 17:36:46 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 6 Aug 2020 17:36:35 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH 0/5] log: Add logs for some modules
Date: Thu, 6 Aug 2020 17:37:15 +0800
Message-ID: <20200806093720.2355692-1-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=liangpeng10@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 02:58:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peng Liang <liangpeng10@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This path serial add some logs for some modeuls to make it easier to debug.

Peng Liang (5):
  log: Add logs for vm start and destroy
  log: Add log for each modules
  log: Add more details to virtio_report in virtqueue_pop
  log: Add log at boot & cpu init for aarch64
  log: Add logs during qemu start

 accel/kvm/kvm-all.c         |  5 ++++-
 blockdev.c                  |  2 ++
 hw/acpi/core.c              |  3 +++
 hw/arm/boot.c               |  2 ++
 hw/arm/virt.c               |  2 ++
 hw/core/reset.c             |  2 ++
 hw/pci/pci.c                |  1 +
 hw/usb/host-libusb.c        |  5 +++++
 hw/virtio/virtio-pci.c      |  2 ++
 hw/virtio/virtio-scsi-pci.c |  3 +++
 hw/virtio/virtio.c          | 17 ++++++++++++++---
 monitor/monitor.c           |  9 +++++++++
 monitor/qmp-cmds.c          |  2 ++
 os-posix.c                  |  1 +
 qapi/qmp-dispatch.c         | 17 +++++++++++++++++
 qdev-monitor.c              |  6 ++++++
 softmmu/vl.c                | 10 ++++++++++
 util/oslib-posix.c          |  3 +--
 18 files changed, 86 insertions(+), 6 deletions(-)

-- 
2.18.4


