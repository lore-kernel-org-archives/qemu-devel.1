Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076E5C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 05:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3473422273
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 05:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3473422273
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZSke-0003ym-6C
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 00:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kZSdK-0002Oc-AG; Mon, 02 Nov 2020 00:43:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kZSdG-0001EO-JC; Mon, 02 Nov 2020 00:43:57 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPhfh4TjNz15PhT;
 Mon,  2 Nov 2020 13:43:40 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 13:43:31 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC v3 00/10] Support disable/enable CPU features for AArch64
Date: Mon, 2 Nov 2020 13:40:45 +0800
Message-ID: <20201102054055.686143-1-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=liangpeng10@huawei.com; helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 00:43:42
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 zhang.zhanghailiang@huawei.com, mst@redhat.com, cohuck@redhat.com,
 xiexiangyou@huawei.com, Peng Liang <liangpeng10@huawei.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU does not support disable/enable CPU features in AArch64 for now.
This patch series add support for CPU features in AArch64.

Firstly, we change the isar struct in ARMCPU to an array for
convenience.  Secondly, we add support to configure CPU feautres in
AArch64 and make sure that the ID registers can be synchronized to KVM
so that guest can read the value we configure.  Thirdly, we add a
mechanism to solve the dependency relationship of some CPU features.
Last, we add a KVM_CAP_ARM_CPU_FEATURE to check whether KVM supports to
set CPU features in AArch64.

Also export CPU features to the result of qmp query-cpu-model-expansion
so that libvirt can get the supported CPU features.

Update the ID fields to ARMv8.6 and add some CPU features according to
the new ID fields.

With related KVM patch set[1], we can disable/enable CPU features in
AArch64.

[1] https://patchwork.kernel.org/project/kvm/cover/20201102033422.657391-1-liangpeng10@huawei.com/

v2 -> v3:
 - rebase to newest code

v1 -> v2:
 - adjust the order of patches
 - only expose AArch64 features which are exposed by kernel via /proc/cpuinfo
 - add check for conflict CPU features set by user
 - split the change in linux-headers/linux/kvm.h

Peng Liang (10):
  linux-header: Introduce KVM_CAP_ARM_CPU_FEATURE
  target/arm: Update ID fields
  target/arm: only set ID_PFR1_EL1.GIC for AArch32 guest
  target/arm: convert isar regs to array
  target/arm: Introduce kvm_arm_cpu_feature_supported
  target/arm: register CPU features for property
  target/arm: Allow ID registers to synchronize to KVM
  target/arm: Introduce user_mask to indicate whether the feature is set
    explicitly
  target/arm: introduce CPU feature dependency mechanism
  target/arm: Add CPU features to query-cpu-model-expansion

 hw/intc/armv7m_nvic.c     |  32 +--
 linux-headers/linux/kvm.h |   1 +
 target/arm/cpu.c          | 575 +++++++++++++++++++++++++++++---------
 target/arm/cpu.h          | 255 +++++++++--------
 target/arm/cpu64.c        | 190 ++++++-------
 target/arm/cpu_tcg.c      | 314 +++++++++++----------
 target/arm/helper.c       | 106 ++++---
 target/arm/internals.h    |  15 +-
 target/arm/kvm.c          |  38 +++
 target/arm/kvm64.c        |  90 +++---
 target/arm/kvm_arm.h      |  10 +
 target/arm/monitor.c      |   4 +
 12 files changed, 1038 insertions(+), 592 deletions(-)

-- 
2.26.2


