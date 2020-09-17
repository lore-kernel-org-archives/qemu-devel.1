Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29DBC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 03:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFCF206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 03:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFCF206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIkaY-00065c-E2
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 23:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIkUS-00058i-Tx; Wed, 16 Sep 2020 23:21:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44580 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIkUM-0004QF-Bt; Wed, 16 Sep 2020 23:21:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 02EE63B39BCAAE14CE4B;
 Thu, 17 Sep 2020 11:20:51 +0800 (CST)
Received: from localhost (10.174.185.104) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 11:20:42 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC PATCH 00/12] hw/arm/virt: Introduce cpu and cache topology
 support
Date: Thu, 17 Sep 2020 11:20:21 +0800
Message-ID: <20200917032033.2020-1-fangying1@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 23:20:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, drjones@redhat.com,
 zhang.zhanghailiang@huawei.com, alex.chen@huawei.com, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, alistair.francis@wdc.com,
 Ying Fang <fangying1@huawei.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

An accurate cpu topology may help improve the cpu scheduler's decision
making when dealing with multi-core system. So cpu topology description
is helpful to provide guest with the right view. Cpu cache information may
also have slight impact on the sched domain, and even userspace software
may check the cpu cache information to do some optimizations. Thus this patch
series is posted to provide cpu and cache topology support for arm.

To make the cpu topology consistent with MPIDR, an vcpu ioctl
KVM_ARM_SET_MP_AFFINITY is introduced so that userspace can set MPIDR
according to the topology specified [1]. To describe the cpu topology
both fdt and ACPI are supported. To describe the cpu cache information,
a default cache hierarchy is given and can be made configurable later.
The cpu topology is built according to processor hierarchy node structure.
The cpu cache information is built according to cache type structure.

This patch series is partially based on the patches posted by Andrew Jone
years ago [2], I jumped in on it since some OS vendor cooperative partners
are eager for it. Thanks for Andrew's contribution. Please feel free to reply
to me if there is anything improper.

[1] https://patchwork.kernel.org/cover/11781317
[2] https://patchwork.ozlabs.org/project/qemu-devel/cover/20180704124923.32483-1-drjones@redhat.com

Andrew Jones (2):
  device_tree: add qemu_fdt_add_path
  hw/arm/virt: DT: add cpu-map

Ying Fang (10):
  linux headers: Update linux header with KVM_ARM_SET_MP_AFFINITY
  target/arm/kvm64: make MPIDR consistent with CPU Topology
  target/arm/kvm32: make MPIDR consistent with CPU Topology
  hw/arm/virt-acpi-build: distinguish possible and present cpus
  hw/acpi/aml-build: add processor hierarchy node structure
  hw/arm/virt-acpi-build: add PPTT table
  target/arm/cpu: Add CPU cache description for arm
  hw/arm/virt: add fdt cache information
  hw/acpi/aml-build: build ACPI CPU cache topology information
  hw/arm/virt-acpi-build: Enable CPU cache topology

 device_tree.c                |  24 +++++++
 hw/acpi/aml-build.c          |  68 +++++++++++++++++++
 hw/arm/virt-acpi-build.c     |  99 +++++++++++++++++++++++++--
 hw/arm/virt.c                | 128 ++++++++++++++++++++++++++++++++++-
 include/hw/acpi/acpi-defs.h  |  14 ++++
 include/hw/acpi/aml-build.h  |  11 +++
 include/hw/arm/virt.h        |   1 +
 include/sysemu/device_tree.h |   1 +
 linux-headers/linux/kvm.h    |   3 +
 target/arm/cpu.c             |  42 ++++++++++++
 target/arm/cpu.h             |  27 ++++++++
 target/arm/kvm32.c           |  46 ++++++++++---
 target/arm/kvm64.c           |  46 ++++++++++---
 13 files changed, 488 insertions(+), 22 deletions(-)

-- 
2.23.0


