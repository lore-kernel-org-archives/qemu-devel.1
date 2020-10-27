Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD18C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A8621655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A8621655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMsw-0004px-Aw
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYW-0000Nn-M4; Tue, 27 Oct 2020 06:50:20 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYU-0002CH-ML; Tue, 27 Oct 2020 06:50:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 8597A5C018D;
 Tue, 27 Oct 2020 06:49:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=3POpeQkKnQA6v
 ukpmSu2L8MecW7Wn17wirkEQzmLoOw=; b=gsVQgAi67YPl0ERrJBoBsbapZYIWx
 /03MiiQJr1ZAFbS5heRK83FaZASZAVdqe+kZ5K4v3V+tvuuW8CLxWTganjMeQ8mA
 OfWRy++zjhg2kG2yqndy11YwS4aZ6dMvLxNQ4EG5bLXLEkUEDf6rSI/7j7e2trEX
 rqzDmfTxvOrYP14GuHD+kILYjAleFSRgV23m/OcwrrWud8pgJ25VyP/k5adJDWpQ
 PkQ0tx7v7PJ1zswWuR4t3oBQ3pEztrRY1QrhRX5W+Gt4KnWWPwj9s6A5AJDs/E+B
 djHQd9X5OLyRwIM23VRoeSPY14ijrsuJcLUUPxZu+1gayyI3314aQe0iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=3POpeQkKnQA6vukpmSu2L8MecW7Wn17wirkEQzmLoOw=; b=PuaP9sKe
 4UAkuNTrEse82OZcGx+8rUj5VAE4kN5pDPSaXkVAhknF/xZIIQlDZcqZWEVd/Rku
 ZsrG3BZJLCeah+SFp7cr3iBn1RU5e3w0rad6dYGepY/5Xvp7UIl8EKZULiFizqd3
 xDSKln2DfIwZlxc9lau8F1wEYhClUIgy4c4fJNEIq/8oSn1ahHykMy+C4X//dEiH
 it69G3/Ty2zcDHpKcMLm3Wyx3JP3/Z5oaq2gFIf4T1q1oJSqauD0IdE5LFStBmMk
 hXF4mw/64uu0dyPCbxj3ybQDiqh5GZ+WdndE5CoesJHMy1nqnlRbO5OT4AJrdhOY
 OxccFQxcskle7Q==
X-ME-Sender: <xms:UvuXXy4FJpdGx3Ge9oYJ538xkC7tlwvUtpFuI86H5Wm-xsnuyHU1xw>
 <xme:UvuXX76kNXbTXMB8UIawwVBz2mVcz3v7QTSEKaqIKdqZ0yOFZcoro3H03bZJA3fBz
 KLNNUXiGXX5OFFapTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepieenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:UvuXXxcxYiHS1UxO3HAxn4_Nv3sw8a9m3hNahA5RD0ywG2tFsIWkHw>
 <xmx:UvuXX_L8AOc6n6lGToYOq_37_V2NJuXr9FKlZD2PFlmGbAJblLN7Qw>
 <xmx:UvuXX2LjCIbAABviZagNz327Rl1fClxZgKU3wzEkUMiRaiWj4As-8g>
 <xmx:UvuXX7GEuMhRUlilHbOlbW4lzWUjPywYBolI3RqWF3HfaooR0dL10w>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5FC7F328005E;
 Tue, 27 Oct 2020 06:49:53 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 17/30] hw/block/nvme: change controller pci id
Date: Tue, 27 Oct 2020 11:49:19 +0100
Message-Id: <20201027104932.558087-18-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027104932.558087-1-its@irrelevant.dk>
References: <20201027104932.558087-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.26; envelope-from=its@irrelevant.dk;
 helo=out2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:49:36
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
Cc: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
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
index d96ec15cdffb..e080a2318a50 100644
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
index 1af12f861ac0..5768a6804f41 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2678,6 +2678,15 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 
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
 
@@ -2831,6 +2840,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
     DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
     DEFINE_PROP_UINT8("mdts", NvmeCtrl, params.mdts, 7),
+    DEFINE_PROP_BOOL("use-intel-id", NvmeCtrl, params.use_intel_id, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2847,8 +2857,6 @@ static void nvme_class_init(ObjectClass *oc, void *data)
     pc->realize = nvme_realize;
     pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
-    pc->vendor_id = PCI_VENDOR_ID_INTEL;
-    pc->device_id = 0x5845;
     pc->revision = 2;
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c5e0e79e6dbc..98b87f76cbbe 100644
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
2.29.1


