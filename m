Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5B3C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E79221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E79221EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNar-00066C-UV
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN86-0005LB-RT; Fri, 18 Sep 2020 16:37:14 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:35547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN85-000508-0o; Fri, 18 Sep 2020 16:37:14 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id A6A0358023A;
 Fri, 18 Sep 2020 16:36:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=AycJYZl/NgLxN
 PWjandj//+b8/Mw6mQIDrxQg7FfP2U=; b=hRcoK0DrUc++MUPzRpJB5CB6vcDne
 VEweo8ubAnyiC9l1OF744KmW/OETPFcQUBiLmrqQ0rop7g1YYuc7BsH3QWFDk9dZ
 ILcf57JURGMBZCQBzQf/qeFlyUqWcFHBLtCLIjqlipoQ/11QkF7F2ukmpHwXcd//
 OswjAwmjeOx2ouMu01C7ShW3uPwpURlODOJ3cvIVoK832Hv0Ve+MNHU7g8u0cvs9
 PY9Tw5mFUyh9GCPGXYTiwHJmALxl/70hlV93dnOuUeh6G6ovJ/KiWIRleTemt+KM
 /5HrExxuo290PZzIv8zWNY81b8GhpyBK+xWp+b2CEFdqTqkoRKRZ4QXyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=AycJYZl/NgLxNPWjandj//+b8/Mw6mQIDrxQg7FfP2U=; b=QuwFjkQr
 QPAUGkxEN3UfTl7y2jOMnr5VR0+shrMh6VJ0R/eYsUMn8NskgsL99Laj0SBNqbn+
 ib+0RnRMnfnzCQDpPXrxAxZUCBszqMmUSUcb8xxza2CJISkCNT2trtXecxBIjyIj
 1mBqSc4PEL8wCsGHaj2qWovbJFSf6cb+et2Hcs0LIt7y/D3p+cvS1czZo9THV+GP
 FPd8I4sECNVZU3lTlvOEfWVSB9wEHYmTKTG8Xz5RN6BTUIzCjH8RwBcXsOpLwhCe
 odPUm92qxp/gf0M4SMqn/YOI0dU+3dRuhoJsOTt1+Hph8YebKwDeMbGkb08D+M7O
 wbu855ZRN/9hOQ==
X-ME-Sender: <xms:YxplX7uilNP2l0Ov8AL5Eo9BK3wM2XdFZHJr-QNCEEPHroc4r_pqxw>
 <xme:YxplX8dn1xa90XXDgdAszhlJWAq9VMbY4VCy7us8Be0OV8XkfZYQcKKuocyMYSnSQ
 1DQp-zuvWFk4jVncv0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeekne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:YxplX-xRyHV8bQc7xJm7sdDQkRzi0wZRWgS871Gm7_r_XATrKk3HZQ>
 <xmx:YxplX6NVWJLzX1aURIcbHJGy7J1kMrymp5AyFQtcyZh-DW6dpjKArQ>
 <xmx:YxplX7-sFDXzOkm4KuPEwLWgmWfCSf5eEyXMGgurg1LWsQNnNImw7Q>
 <xmx:YxplX3SNH09mcwIWFn30Q5tqboIOlj5h6fQ1hK7YMTMP53WcKaRML8UI_mM>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B0A713064610;
 Fri, 18 Sep 2020 16:36:49 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/17] hw/block/nvme: change controller pci id
Date: Fri, 18 Sep 2020 22:36:21 +0200
Message-Id: <20200918203621.602915-18-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918203621.602915-1-its@irrelevant.dk>
References: <20200918203621.602915-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 16:36:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
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

To keep backward compatibility, add a new 'use-intel-id' parameter to
the nvme device to force use of the Intel vendor and device id. This is
off by default but add a compat property to set this for 5.1 machines
and older. If a 5.1 machine is booted (or the use-intel-id parameter is
explicitly set to true), the Linux kernel will just apply these
unnecessary quirks:

  1. NVME_QUIRK_IDENTIFY_CNS which says that the device does not support
     anything else than values 0x0 and 0x1 for CNS (Identify Namespace
     and Identify Namespace). With multiple namespace support, this just
     means that the kernel will "scan" namespaces instead of using
     "Active Namespace ID list" (CNS 0x2).

  2. NVME_QUIRK_DISABLE_WRITE_ZEROES. The nvme device started out with a
     broken Write Zeroes implementation which has since been fixed in
     commit 9d6459d21a6e ("nvme: fix write zeroes offset and count").

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.h   |  1 +
 hw/block/nvme.c   | 12 ++++++++++--
 hw/core/machine.c |  1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index a8b98a1c1ea9..ccf52ac7bb82 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -15,6 +15,7 @@ typedef struct NvmeParams {
     uint8_t  aerl;
     uint32_t aer_max_queued;
     uint8_t  mdts;
+    bool     use_intel_id;
 } NvmeParams;
 
 typedef struct NvmeAsyncEvent {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3e733a2b1321..c00e78b85f51 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2681,6 +2681,15 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
     pci_conf[PCI_INTERRUPT_PIN] = 1;
     pci_config_set_prog_interface(pci_conf, 0x2);
+
+    if (n->params.use_intel_id) {
+        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
+        pci_config_set_device_id(pci_conf, 0x5845);
+    } else {
+        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
+        pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_NVME);
+    }
+
     pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(pci_dev, 0x80);
 
@@ -2834,6 +2843,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
     DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
     DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
+    DEFINE_PROP_BOOL("use-intel-id", NvmeCtrl, params.use_intel_id, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2850,8 +2860,6 @@ static void nvme_class_init(ObjectClass *oc, void *data)
     pc->realize = nvme_realize;
     pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
-    pc->vendor_id = PCI_VENDOR_ID_INTEL;
-    pc->device_id = 0x5845;
     pc->revision = 2;
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ea26d612374d..944120cf19c8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,6 +34,7 @@ GlobalProperty hw_compat_5_1[] = {
     { "vhost-user-scsi", "num_queues", "1"},
     { "virtio-blk-device", "num-queues", "1"},
     { "virtio-scsi-device", "num_queues", "1"},
+    { "nvme", "use-intel-id", "on"},
 };
 const size_t hw_compat_5_1_len = G_N_ELEMENTS(hw_compat_5_1);
 
-- 
2.28.0


