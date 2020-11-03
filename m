Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0437C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291B722226
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291B722226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvML-0004Vb-5U
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvIP-0008TY-3w
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:17 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:2127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvII-000850-Ay
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:16 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CQTPY6Xnjz701m;
 Tue,  3 Nov 2020 20:20:01 +0800 (CST)
Received: from localhost (10.174.184.155) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 20:19:54 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v9 0/8] pci_expander_brdige:acpi: Support pxb-pcie for ARM
Date: Tue, 3 Nov 2020 20:01:49 +0800
Message-ID: <20201103120157.2286-1-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=cenjiahui@huawei.com;
 helo=szxga07-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 04:32:14
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: xieyingtai@huawei.com, peter.maydell@linaro.org,
 Jiahui Cen <cenjiahui@huawei.com>, berrange@redhat.com, mst@redhat.com,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, miaoyubo@huawei.com,
 imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes with v8
v8->v9:
Rebase to master

Changes with v7
v7->v8:
Fix the error:no member named 'fw_cfg' in 'struct PCMachineState'

Changes with v6
v6->v7:
Refactor fw_cfg_write_extra_pci_roots
Add API PCI_GET_PCIE_HOST_STATE
Fix typos

Changes with v5
v5->v6: stat crs_range_insert in aml_build.h

Changes with v4
v4->v5: Not using specific resources for PXB.
Instead, the resources for pxb are composed of the bar space of the
pci-bridge/pcie-root-port behined it and the config space of devices
behind it.

Only if the bios(uefi for arm) support multiple roots,
configure space of devices behind pxbs could be obtained.
The uefi work is updated for discussion by the following link:
https://edk2.groups.io/g/devel/message/56901?p=,,,20,0,0,0::Created,,add+extra+roots+for+Arm,20,2,0,72723351
[PATCH] ArmVirtPkg/FdtPciHostBridgeLib: add extra roots for Arm.
This patch will be updated to v2 later.

Currently pxb-pcie is not supported by arm,
the reason for it is pxb-pcie is not described in DSDT table
and only one main host bridge is described in acpi tables,
which means it is not impossible to present different io numas
for different devices.

This series of patches make arm to support PXB-PCIE.

Users can configure pxb-pcie with certain numa, Example command
is:

   -device pxb-pcie,id=pci.7,bus_nr=128,numa_node=0,bus=pcie.0,addr=0x9

Yubo Miao (8):
  acpi: Extract two APIs from acpi_dsdt_add_pci
  fw_cfg: Write the extra roots into the fw_cfg
  acpi: Extract crs build form acpi_build.c
  acpi: Refactor the source of host bridge and build tables for pxb
  acpi: Align the size to 128k
  unit-test: The files changed.
  unit-test: Add testcase for pxb
  unit-test: Add the binary file and clear diff.h

 hw/acpi/aml-build.c            | 273 ++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c       |  30 +++-
 hw/arm/virt.c                  |   8 +
 hw/i386/acpi-build.c           | 293 ---------------------------------
 hw/i386/pc.c                   |  18 +-
 hw/nvram/fw_cfg.c              |  20 +++
 hw/pci-host/gpex-acpi.c        | 205 +++++++++++++++++------
 include/hw/acpi/aml-build.h    |  25 +++
 include/hw/nvram/fw_cfg.h      |   2 +
 include/hw/pci/pcie_host.h     |   4 +
 tests/data/acpi/virt/DSDT.pxb  | Bin 0 -> 7802 bytes
 tests/qtest/bios-tables-test.c |  58 ++++++-
 12 files changed, 568 insertions(+), 368 deletions(-)
 create mode 100644 tests/data/acpi/virt/DSDT.pxb

-- 
2.19.1


