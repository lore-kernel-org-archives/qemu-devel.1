Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3060C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5625E22263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5625E22263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNFy-0002xC-6f
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYS-0000H2-7C; Tue, 27 Oct 2020 06:50:16 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYQ-0002C9-4k; Tue, 27 Oct 2020 06:50:15 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 5975F5C017E;
 Tue, 27 Oct 2020 06:49:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=im3qlV+LNt1Ng
 Idjc9WEWMRpAEkcgO2T5qaSzWFow9E=; b=a7MKLWDuAS6Yz4EGhpa6SY7RrBBn0
 D8gDj6uQFMmusbFykr6Ft2TdCo7TNFzIic8F/N/YtEAZOJIF09o1ZAvIK437xKqi
 6BJDfn9SpZfB3GZtsP/JOtr5p661IjHtrIL9W+MzNemPBqhx2OMIemper7dC487o
 T+2ltTYz7b7ZxyoKmtP2b4YnLmZrSD+gGyIoiYSdSnvhlFs9JKCtjCP2G7+8SvUq
 GGwxEqKKpKByqo9tXnxgXwJOR8f3ml8JKzXRVwVE+EsVOTIY9M5X3ubfUekFllFt
 +NrtN6snO14dsG3DxOrDDjfXdMaUgzTRNTPeRExzVj6ZQ/MhJJoMhUfFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=im3qlV+LNt1NgIdjc9WEWMRpAEkcgO2T5qaSzWFow9E=; b=maQP5BYQ
 et1pE+75bGhoKtShlnhuc8Yly/9vJSTT5ki4aJjbtFCGfnQWzHbb1vNTHMheQ+q/
 qKmuiBl8HYaSRTQRVNaxl109lGVSGo6cSarV1TuUIHxdM8Lw0Ve1b+LKTYuBUxOO
 W3J1MDE6P22fYGeRl+c3O+gSjg93VtYLU9zpyVimWlYb2zhmMA7jT8e+AoDjUK+Z
 pKaFsTxWr5EDExSWF1gjqUHlJI65t6g5GSCW6pqizD3jB6GiEd+2uJFUyrzS0boJ
 s5QmCcnuQu6RnrMCvJaQfeQ6bG1uGHZalzORmk5nbyogWACGXqIeZbW5hz6yQpn7
 xl/pi+F3o5pQeg==
X-ME-Sender: <xms:UfuXX2ETfu0XRVldxZhKYRZgRZ-XSbod6qk3vx_JujMREiq6qksh6g>
 <xme:UfuXX3WCead8B1ck0K2KjhZRFzpuzX4ITRm1w9TNwXZDn3pUsUpXSuSdH5rKF8bg6
 461awVTFFSguV-EfO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepteffteduveekfedufffftddutdejfeeuhffhuefhgeekveeikeevteffgeekuedu
 necuffhomhgrihhnpehnvhhmvgigphhrvghsshdrohhrghdpihhnfhhrrgguvggrugdroh
 hrghenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:UfuXXwICLiuQeh27__nG2bSbe0TardFYsoytOsbVV2Ezqdi9jyvJQQ>
 <xmx:UfuXXwETIJM0F5teqo5FjiJxr7shvihwILZrxu8IAWzu9idPEC9j5w>
 <xmx:UfuXX8XB6hS6T0goo76v-RWACLogWxSdio7ZeSMEWFufwhZtEZM0WA>
 <xmx:UfuXX2fkY5Lso9RUtV8-_OEPqRsnmXSU8gVKSBIhRd5aS-ULNX4iZQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1C85F3280066;
 Tue, 27 Oct 2020 06:49:52 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 16/30] pci: allocate pci id for nvme
Date: Tue, 27 Oct 2020 11:49:18 +0100
Message-Id: <20201027104932.558087-17-its@irrelevant.dk>
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
Cc: qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

The emulated nvme device (hw/block/nvme.c) is currently using an
internal Intel device id.

Prepare to change that by allocating a device id under the 1b36 (Red
Hat, Inc.) vendor id.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 docs/specs/nvme.txt    | 23 +++++++++++++++++++++++
 docs/specs/pci-ids.txt |  1 +
 include/hw/pci/pci.h   |  1 +
 MAINTAINERS            |  1 +
 4 files changed, 26 insertions(+)
 create mode 100644 docs/specs/nvme.txt

diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
new file mode 100644
index 000000000000..56d393884e7a
--- /dev/null
+++ b/docs/specs/nvme.txt
@@ -0,0 +1,23 @@
+NVM Express Controller
+======================
+
+The nvme device (-device nvme) emulates an NVM Express Controller.
+
+
+Reference Specifications
+------------------------
+
+The device currently implements most mandatory features of NVMe v1.3d, see
+
+  https://nvmexpress.org/resources/specifications/
+
+for the specification.
+
+
+Known issues
+------------
+
+* The accounting numbers in the SMART/Health are reset across power cycles
+
+* Interrupt Coalescing is not supported and is disabled by default in volation
+  of the specification.
diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
index 4d53e5c7d9d5..abbdbca6be38 100644
--- a/docs/specs/pci-ids.txt
+++ b/docs/specs/pci-ids.txt
@@ -63,6 +63,7 @@ PCI devices (other than virtio):
 1b36:000b  PCIe Expander Bridge (-device pxb-pcie)
 1b36:000d  PCI xhci usb host adapter
 1b36:000f  mdpy (mdev sample device), linux/samples/vfio-mdev/mdpy.c
+1b36:0010  PCIe NVMe device (-device nvme)
 
 All these devices are documented in docs/specs.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f19ffe6b4fe8..72ce649eee36 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -106,6 +106,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_XHCI        0x000d
 #define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
 #define PCI_DEVICE_ID_REDHAT_MDPY        0x000f
+#define PCI_DEVICE_ID_REDHAT_NVME        0x0010
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
diff --git a/MAINTAINERS b/MAINTAINERS
index ef6f5c739984..9e215088ce8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1877,6 +1877,7 @@ L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/nvme*
 F: tests/qtest/nvme-test.c
+F: docs/specs/nvme.txt
 T: git git://git.infradead.org/qemu-nvme.git nvme-next
 
 megasas
-- 
2.29.1


