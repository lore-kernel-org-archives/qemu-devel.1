Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D252C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2E3239D4
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2E3239D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeIv-0004oa-2i
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdwP-0006a6-2u; Tue, 22 Sep 2020 04:46:25 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:59669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdwM-0000w9-By; Tue, 22 Sep 2020 04:46:24 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 915E35803D1;
 Tue, 22 Sep 2020 04:46:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=Br9hKr4EAwYfX
 ynjoYHV9Gb1TMdGDpA64Z/lxDcoyhE=; b=Wp7Pw8pLpztYa/mApIym7KZNUCjUL
 49AguAi2rLNQjzsHvwVzdkNvqlrXr9xb3QufkKNfz9cH2ug8IaSwRWOYF9w4hW1q
 xjoQnCUZpD1EvqxI8g0R7gAvyd8fD8yffM9XpocM5mY8KSjNonVIXK/QbNsxiEtN
 9yAoB9BO/a9ogm8ARPRXr7EHQzBWgoqmesk0J++CPgBqM5IP/5+3rgYkbRdnfNym
 f0+pUPD8Hlgvb2FVI9KOx+nV756rUf24/I9/SC55cgzXGLIAjFASf5x1MAWymwut
 W3bF3uljC9+LNubulsJBXV8rwMmDSCzs2rn5M+D7EdDwkp3Z5BJu+6tRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=Br9hKr4EAwYfXynjoYHV9Gb1TMdGDpA64Z/lxDcoyhE=; b=IA2LVSBK
 bNbIMkk09TGi1fAo/fBqd0ekrDRWphZ5yVhEuqPPnjKOx419vL0W+iu+d7+tB8QC
 qNG5rwiqrBL6f2SVcNmkGy9MGzY0fWy083nSy+gd9oFXGQjpXziC8Os8Kze+GTad
 HMdhtUke6zgCUIo7U1EiHt1+ROLldjHpR/lJiZ/pBDoUYSSvLclVT905HPKpYOA9
 moLZP3FQnjeCFbGALueUBoWINrvKW5Gw+27c6lT/Ad537Ww9InPvVqH5h9Dsvd2r
 vsQbnJ/Aap4rLBdt8ixBhFFy/IGSb6U5agmRwC2uUFz5lOxsxfW32zisvTXeFx81
 w1s6PAxr1XM3fA==
X-ME-Sender: <xms:yblpX5PGl5KUfAZzj-IieAS31_Z1o469Y2s9pkwZ6MN6dJ3860rrIA>
 <xme:yblpX7-6gZhQzHsj-ro9zPcBs4n_jqA8sGI4qMgcJVW6z56R5MnGQ01Tao8L4NJ0d
 bPzWW3WuidpTR8Hqu8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepteffteduveekfedufffftddutdejfeeuhffhuefhgeekveeikeevteffgeekuedu
 necuffhomhgrihhnpehnvhhmvgigphhrvghsshdrohhrghdpihhnfhhrrgguvggrugdroh
 hrghenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:yblpX4R1eD4dTqhQjNQdg78Dn0tarp9xrCY00V_a2lOUftGjhe4t4Q>
 <xmx:yblpX1sNcuWT-51l5Ktvrx2V6NxuM7oCCt2DRveEI2rz0Kkh9zR17w>
 <xmx:yblpXxc2t5_Rsx0YT3-c1OJYlYmdUnunrmNTBZlmzjp8VClE8-G35g>
 <xmx:yblpX946YXDWwAiUsw6LMO9hZyrmDvAPwTNyiudZELI_1v0rwrb3F-eirLQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 74FAB306467E;
 Tue, 22 Sep 2020 04:45:59 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/17] pci: allocate pci id for nvme
Date: Tue, 22 Sep 2020 10:45:32 +0200
Message-Id: <20200922084533.1273962-17-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922084533.1273962-1-its@irrelevant.dk>
References: <20200922084533.1273962-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.230; envelope-from=its@irrelevant.dk;
 helo=new4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 04:45:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
 Keith Busch <kbusch@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Maxim Levitsky <mlevitsk@redhat.com>
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
index 0ff3feec1573..fb3ea21ee1d6 100644
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
index 3d17cad19aa0..3f3babeca663 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1880,6 +1880,7 @@ L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/nvme*
 F: tests/qtest/nvme-test.c
+F: docs/specs/nvme.txt
 T: git git://git.infradead.org/qemu-nvme.git nvme-next
 
 megasas
-- 
2.28.0


