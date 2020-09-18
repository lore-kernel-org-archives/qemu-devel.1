Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4607C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0387C21707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0387C21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOCh-0002Wm-Eu
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN87-0005ML-Mt; Fri, 18 Sep 2020 16:37:15 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN85-000506-0B; Fri, 18 Sep 2020 16:37:15 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 9462C580237;
 Fri, 18 Sep 2020 16:36:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=c3MNHd1b4ehZM
 fR8xo7aUiWt4UkdnXJKm1Oc6eRMdFE=; b=ghe1Wsx7RiHvcs+GmdA4zCtup1yMJ
 O3M5unLGpwYltb/FF/w1xczE7kQdf3k7QYu5pZf69oxVmmFeMkvZy6gmcBWDptHu
 hEiQuTFfD72gMG17XN8vgEmDhx09v+B91UvuRwvSu+IfvIavgcEB/ej3ieD3Qx3g
 5IgVECl1B+egXwmTkEHjTBB6Bi/LHVBPBDRxoRyH/CxTTDnHHM+txOddp3aqYnmj
 w35xKYDJ4mnwsQ1a2xwKEubn9uSKy/SlBBIZ5cYTfBYKVOxMXn87oMeZtxPH738W
 UjdCHWu4tDA7TBGWOFwP3ZoUXlc8ErgVR89xSEcaV+k79dLb0Vm0XM+vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=c3MNHd1b4ehZMfR8xo7aUiWt4UkdnXJKm1Oc6eRMdFE=; b=OgUEiyip
 izNU4tM+8p+GXUwIiAT9so/PVRPulxXSJffWn9YuZOu4zVT+NWJ+VZXJxsWf1JWf
 4qqnthEEMA51jCi906hZNGg6qR0H4te0kNP1kmDYeGNH+S2MbJpzFFDVxz8vT5Ar
 IzOUfhLoD8sexHef1/sAiYl09umd22vj9nwP6NVfjAIS3CGGOV8humQQP9O2nqtA
 gepszH7f4MwBVZfStsn0CkhzDJr76ejKzZuHxbZmGdSwVbS5gqXYuEqETWInJuDN
 ohystdMeZnCYZXmOl9EG4znKkIRookJkuzrjMtLhh9ZaMCEw691aZTI6OWJsr6vr
 5uoE4B0rXtIZYQ==
X-ME-Sender: <xms:YRplXyU6Jusc9hnVOLg2-SiypDkgKOc2qwoSROadKARrW6g6pfiRdw>
 <xme:YRplX-kblm8c6v9H7RqJcrMI7TstDI2bmZD9dHyZ4x-d6jb0zAhm4uEkRDnLsqJ-b
 hh3_Bj_zbWSojqqRyc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetffetudevkeefudffffdtuddtjeefuefhhfeuhfegkeevieekveetffegkeeu
 udenucffohhmrghinhepnhhvmhgvgihprhgvshhsrdhorhhgpdhinhhfrhgruggvrggurd
 horhhgnecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:YRplX2aQKSCcb6xzfUyqrQUoXN-zKibXe151Qyu2Yvs64dV84x_FXw>
 <xmx:YRplX5WLWeBR0tLBXI-5v_po6g8ziPR9AsraLXXwyDJN4vB1dwHA2g>
 <xmx:YRplX8kQKBmT7IXtN923nDm6PGapZHZf0Gvl2fMk0P3sW1O1ZNLtjA>
 <xmx:YRplX5i7bOYzKAurDANN-GSjtVbb2iusldRdQTInYMAdUVcOoBVrm4Kz4cU>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 063B23064674;
 Fri, 18 Sep 2020 16:36:47 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/17] pci: allocate pci id for nvme
Date: Fri, 18 Sep 2020 22:36:20 +0200
Message-Id: <20200918203621.602915-17-its@irrelevant.dk>
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
 Klaus Jensen <its@irrelevant.dk>, Gerd Hoffmann <kraxel@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

The emulated nvme device (hw/block/nvme.c) is currently using an
internal Intel device id.

Prepare to change that by allocating a device id under the 1b36 (Red
Hat, Inc.) vendor id.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
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


