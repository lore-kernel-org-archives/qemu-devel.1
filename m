Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3207C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:25:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 643C0206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="UWTRuxdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643C0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECeF-0003rB-Cm
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECaP-0003Vg-QV; Fri, 04 Sep 2020 10:21:05 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECaM-0002kF-Fk; Fri, 04 Sep 2020 10:21:05 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id AC944BFBE9;
 Fri,  4 Sep 2020 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599229238;
 bh=5ZjDoTIIr492u+clFrXjEhMBLTXUh19lollxZUe3VI8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UWTRuxdWg+SN9qos0NbTmmMnmIbqDh6x9Yn53B/nGsh5FJP6eMypccPYrYzQMPQIY
 UJPUAUxI4Z+VAUgwg7/wQPpZIHCI9+muiCgofgLBwbwKKJbXCf8lhSggMAzD4vbkvs
 aX767w+ALtWMsyYjGnecnhtwTHpYEtL55oY95IQ2gXsYBB+qOa/jTlZWKRHghIsx5k
 AZeQCr4osjNuV2SHCozX0iAFQLxduR4N+JA/KQQwdgN8EQ/wU+gfuDVzubKZWhVbGy
 DgZ8plO4Ke3JnhGkigQVTTOfKbYkya330fZ33VbnWKXNai+4dVyeMVFNM+y3pc0XmN
 k0muURni4S2fg==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/17] hw/block/nvme: change controller pci id
Date: Fri,  4 Sep 2020 16:19:56 +0200
Message-Id: <20200904141956.576630-18-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904141956.576630-1-its@irrelevant.dk>
References: <20200904141956.576630-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:20:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

There are two reasons for changing this:

  1. The nvme device currently uses an internal Intel device id.

  2. Since commits "nvme: fix write zeroes offset and count" and "nvme:
     support multiple namespaces" the controller device no longer has
     the quirks that the Linux kernel think it has.

     As the quirks are applied based on pci vendor and device id, change
     them to get rid of the quirks.

To keep backward compatibility, add a new 'x-use-intel-id' parameter to
the nvme device to force use of the Intel vendor and device id. This is
off by default but add a compat property to set this for 5.1 machines
and older.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c   | 12 ++++++++++--
 hw/block/nvme.h   |  1 +
 hw/core/machine.c |  1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 453d3a89d475..8018f8679366 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2749,6 +2749,15 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
     pci_conf[PCI_INTERRUPT_PIN] = 1;
     pci_config_set_prog_interface(pci_conf, 0x2);
+
+    if (n->params.use_intel_id) {
+        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
+        pci_config_set_device_id(pci_conf, 0x5846);
+    } else {
+        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
+        pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_NVME);
+    }
+
     pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(pci_dev, 0x80);
 
@@ -2903,6 +2912,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
     DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
     DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
+    DEFINE_PROP_BOOL("x-use-intel-id", NvmeCtrl, params.use_intel_id, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2919,8 +2929,6 @@ static void nvme_class_init(ObjectClass *oc, void *data)
     pc->realize = nvme_realize;
     pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
-    pc->vendor_id = PCI_VENDOR_ID_INTEL;
-    pc->device_id = 0x5845;
     pc->revision = 2;
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 72260f2e8ea9..a734a5e1370d 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -15,6 +15,7 @@ typedef struct NvmeParams {
     uint8_t  aerl;
     uint32_t aer_max_queued;
     uint8_t  mdts;
+    bool     use_intel_id;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ea26d612374d..67990232528c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,6 +34,7 @@ GlobalProperty hw_compat_5_1[] = {
     { "vhost-user-scsi", "num_queues", "1"},
     { "virtio-blk-device", "num-queues", "1"},
     { "virtio-scsi-device", "num_queues", "1"},
+    { "nvme", "x-use-intel-id", "on"},
 };
 const size_t hw_compat_5_1_len = G_N_ELEMENTS(hw_compat_5_1);
 
-- 
2.28.0


