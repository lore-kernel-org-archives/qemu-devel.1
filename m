Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B41C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B53721D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B53721D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpST-0007iY-E6
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQs-00060G-HN; Tue, 20 Oct 2020 07:03:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38446 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQp-0006li-Ao; Tue, 20 Oct 2020 07:03:58 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 90FA04532CA4D03D7C6B;
 Tue, 20 Oct 2020 19:03:44 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 19:03:36 +0800
From: Gan Qixin <ganqixin@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 00/10] Fix line over 80 characters warning
Date: Tue, 20 Oct 2020 04:30:13 +0800
Message-ID: <20201019203023.658555-1-ganqixin@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=ganqixin@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:03:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, f4bug@amsat.org,
 alistair.francis@wdc.com, Gan Qixin <ganqixin@huawei.com>,
 kuhn.chenqun@huawei.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,
    I used scripts/checkpatch.pl to find that many files in the hw directory 
contain lines with more than 80 characters. Therefore, I splited some lines to
fix this warning. 

Thanks,
Gan Qixin

Gan Qixin (10):
  hw/virtio/:split some lines containing more than 80 characters
  hw/core/:split some lines containing more than 80 characters
  hw/ide/:split some lines containing more than 80 characters
  hw/intc/:split some lines containing more than 80 characters
  hw/misc/:split some lines containing more than 80 characters
  hw/pci/:split some lines containing more than 80 characters
  hw/pci-host/:split some lines containing more than 80 characters
  hw/char/:split some lines containing more than 80 characters
  hw/input/:split some lines containing more than 80 characters
  hw/riscv/:split some lines containing more than 80 characters

 hw/char/ibex_uart.c              | 12 ++++---
 hw/char/omap_uart.c              |  3 +-
 hw/char/parallel.c               | 12 ++++---
 hw/char/serial.c                 | 57 ++++++++++++++++++++++----------
 hw/char/virtio-serial-bus.c      |  3 +-
 hw/core/bus.c                    |  3 +-
 hw/core/loader.c                 | 17 ++++++----
 hw/core/machine-hmp-cmds.c       |  6 ++--
 hw/core/machine.c                |  3 +-
 hw/core/qdev-properties-system.c |  4 +--
 hw/ide/ahci.c                    | 10 +++---
 hw/ide/atapi.c                   |  9 ++---
 hw/ide/cmd646.c                  |  3 +-
 hw/ide/core.c                    | 21 ++++++++----
 hw/ide/piix.c                    |  3 +-
 hw/ide/via.c                     |  3 +-
 hw/input/hid.c                   |  3 +-
 hw/input/milkymist-softusb.c     | 16 +++++----
 hw/input/pxa2xx_keypad.c         |  3 +-
 hw/input/virtio-input.c          |  3 +-
 hw/intc/apic.c                   |  3 +-
 hw/intc/arm_gic.c                |  5 +--
 hw/intc/arm_gic_common.c         |  3 +-
 hw/intc/ioapic.c                 |  3 +-
 hw/intc/xics.c                   |  3 +-
 hw/intc/xics_kvm.c               |  3 +-
 hw/misc/aspeed_sdmc.c            | 10 +++---
 hw/misc/bcm2835_mphi.c           |  3 +-
 hw/misc/edu.c                    |  3 +-
 hw/misc/omap_gpmc.c              |  3 +-
 hw/misc/omap_sdrc.c              |  3 +-
 hw/misc/pci-testdev.c            |  3 +-
 hw/misc/sifive_test.c            |  4 +--
 hw/pci-host/gpex-acpi.c          | 18 +++++-----
 hw/pci-host/pam.c                |  4 +--
 hw/pci-host/ppce500.c            |  8 +++--
 hw/pci-host/q35.c                | 11 +++---
 hw/pci-host/versatile.c          |  5 +--
 hw/pci/msi.c                     |  3 +-
 hw/pci/msix.c                    |  8 ++---
 hw/pci/pci.c                     | 31 +++++++++++------
 hw/pci/pci_bridge.c              |  3 +-
 hw/pci/pcie.c                    | 11 +++---
 hw/pci/pcie_host.c               |  4 +--
 hw/riscv/opentitan.c             |  6 ++--
 hw/riscv/sifive_e.c              |  6 ++--
 hw/riscv/sifive_u.c              | 12 ++++---
 hw/virtio/vhost-backend.c        |  3 +-
 hw/virtio/vhost-user-fs.c        |  6 ++--
 hw/virtio/vhost-user.c           | 10 +++---
 hw/virtio/virtio-balloon.c       |  6 ++--
 hw/virtio/virtio-bus.c           |  3 +-
 hw/virtio/virtio-crypto.c        |  3 +-
 hw/virtio/virtio-pci.c           |  4 +--
 hw/virtio/virtio-pci.h           |  8 +++--
 hw/virtio/virtio-rng.c           |  3 +-
 hw/virtio/virtio.c               | 14 +++++---
 57 files changed, 273 insertions(+), 160 deletions(-)

-- 
2.23.0


