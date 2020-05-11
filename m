Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF906C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861F8206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861F8206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYDx9-0003dg-Nv
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 15:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jYDve-0001e1-Ir
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:17:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:15020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jYDvc-0001Yf-Ra
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:17:29 -0400
IronPort-SDR: 28auaLFGwNpIbjDKrNsdaUXIe3o8Xm8j+6vfAdtNHWtfMlz5NyhJz93j8OOv1DSvsu1QL1SgPn
 pSZvF4SW7eQA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2020 12:17:20 -0700
IronPort-SDR: WjpuYqEF+qzqXPuACAFjsM92dYFGRCCWz6fzDpq8PNm2nU+qrb85LhLrkwpl4oJJdMYaY82LTH
 gfm/J0thY/mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; d="scan'208";a="463494234"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
 by fmsmga006.fm.intel.com with ESMTP; 11 May 2020 12:17:19 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] VMD endpoint passthrough support
Date: Mon, 11 May 2020 15:01:26 -0400
Message-Id: <20200511190129.9313-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=jonathan.derrick@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 15:17:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 virtualization@lists.linux-foundation.org,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jon Derrick <jonathan.derrick@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This set contains 2 patches for Linux and 1 for QEMU. VMD device
8086:28C0 contains information in registers to assist with direct
assignment passthrough. Several other VMD devices don't have this
information, but can easily be emulated to offer this feature.

The existing VMD devices not supporting the feature cannot be changed to
offer the information, but also don't restrict the ability to offer this
information in emulation by the hypervisor. Future VMD devices will
offer the 28C0 mode natively.

The QEMU patch emulates the hardware assistance that the VMD 28C0 device
provides: a config space register claiming passthrough support, and the
shadow membar registers containing the host information for guest
address assignment in the VMD domain. These VMD devices have this config
space register set as reserved and will not conflict with the emulated
bit.

The Linux patch allows guest kernels to use the passthrough information
emulated by the QEMU patch, by matching the config space register
claiming passthrough support.

Changes from v1:
v1 changed the VMD Subsystem ID to QEMU's so that the guest driver could
match against it. This was unnecessary as the VMLOCK register and shadow
membar registers could be safely emulated. Future VMDs will be aligned
on these register bits.

Added the resource bit filtering patch that got lost in the mailserver.

v1: https://lore.kernel.org/linux-pci/20200422171444.10992-1-jonathan.derrick@intel.com/

Jon Derrick (2):
  PCI: vmd: Filter resource type bits from shadow register
  PCI: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests

 drivers/pci/controller/vmd.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
2.18.1


