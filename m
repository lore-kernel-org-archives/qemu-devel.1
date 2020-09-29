Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F18AC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DCA920897
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCA920897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOxg-0002Vz-Ck
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOu8-0000VG-VN; Tue, 29 Sep 2020 19:19:28 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:46811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOu6-000086-SF; Tue, 29 Sep 2020 19:19:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id D1427E24;
 Tue, 29 Sep 2020 19:19:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 19:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 qEKNIM+lPRA0c0RxRX/s4SVmBXPBiqyjUZhRX090gXI=; b=l1TchkFscnMD7Nt1
 EybcOUdB1GWedUrAwj3GGAo3MXibBTpXmt0EYlh/tJilIvYw0pXf/h6kWPg7Ahu8
 v1p8/r2q+QzsavrPJKVLkcS8dXgUSeMlyCb1jdo6CRzoRkwlbY4pxp8/BUtASsPx
 egdYG49M/GOeB8CwCt63WVqKm7vXlz3jkYVnpyEIwIjHLvzjKtOVYJrt3BPR+WcX
 ZvenpOMGZneoPR7ho81EcQcuhfJVlhUle30UxzN/4hrrpwaK+irbXtQLIQhV3j3P
 buqCbOeC3NgYrUxjTQeriSwbXMoOroDUfVhCqG5MdQQvLNJffYjKWnZxGaSg5PU5
 iQTTkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=qEKNIM+lPRA0c0RxRX/s4SVmBXPBiqyjUZhRX090g
 XI=; b=RRC83CP6odk0QRqRYL7hcNeuVWO8wmkIuUVCwCOFo7rXMm8wfjOTL86Xc
 S9YIlEWpZrg+In64dO3O53+k3JSyJgJzwYYiJiBTblP9RhbLK6N1kZdwzCNkXTTO
 t1TwQFqT2wD++kTxpAJ2XttFZroXBSSl1Hfd3omPZ93he8IQye4/dTEtUnZPVQVL
 ozlCIjPz7TOfeaV5KMBRFgUcFmu4VGgdBncza0BNs4abUc8qBi6gBQxrrggGYEXm
 oJ+pezfe6EfL1gwn+9TYq5U6ZOFsxqNDUZ5LH+g4bQ+UZ2q8qoh4ih5NkRInt+g9
 uVDf+lwEG/JaeOga3diamPVRbTRpQ==
X-ME-Sender: <xms:_MBzX8HMEuVWspjSC1NKMPWUfdktojQ-FqI5gRNdNPzQ6V1pT7J27w>
 <xme:_MBzX1Ww2NQlYsDlNui5-JavLs-HSv4RaSPGb9UD6InM8xom-nnxBwhRrMxlsvC7w
 Pu2QFlymTz6Qq5gtDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:_MBzX2LKa4rbCKoT1uhJAGsvjlwdTJ3kmP3xMzUgbPN73ndvnY4ZdQ>
 <xmx:_MBzX-Gj9JqHb-Z_H1FhZXewRSClkUCefuh09nA0eqCpXrKavDa1hw>
 <xmx:_MBzXyWxFTMFgP2BF4rabQflIOM6PcgwTAPYAcIBI7D154eWpSp84g>
 <xmx:_MBzX9H5UnWgXUfkMTcX-ASOAEjbvnjvNu78qYu9tiEdTfAYeRDiInFPJ88>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E9B253280068;
 Tue, 29 Sep 2020 19:19:22 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/14] hw/block/nvme: make lba data size configurable
Date: Wed, 30 Sep 2020 01:19:06 +0200
Message-Id: <20200929231917.433586-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929231917.433586-1-its@irrelevant.dk>
References: <20200929231917.433586-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 17:46:07
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Allos the LBA data size (lbads) to be set between 9 and 12.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 docs/specs/nvme.txt | 11 ++++++++++-
 hw/block/nvme-ns.h  |  1 +
 hw/block/nvme-ns.c  |  8 +++++++-
 hw/block/nvme.c     |  1 +
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
index 56d393884e7a..438ca50d698c 100644
--- a/docs/specs/nvme.txt
+++ b/docs/specs/nvme.txt
@@ -1,7 +1,16 @@
 NVM Express Controller
 ======================
 
-The nvme device (-device nvme) emulates an NVM Express Controller.
+The nvme device (-device nvme) emulates an NVM Express Controller. It is used
+together with nvme-ns devices (-device nvme-ns) which emulates an NVM Express
+Namespace.
+
+nvme-ns Options
+---------------
+
+  `lbads`; The "LBA Data Size (LBADS)" indicates the LBA data size used by the
+     namespace. It is specified in terms of a power of two. Only values between
+     9 and 12 (both inclusive) are supported.
 
 
 Reference Specifications
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index 83734f4606e1..78b0d1a00672 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -21,6 +21,7 @@
 
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
+    uint8_t  lbads;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index 2ba0263ddaca..576c7486f45b 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -36,7 +36,7 @@ static void nvme_ns_init(NvmeNamespace *ns)
         ns->id_ns.dlfeat = 0x9;
     }
 
-    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
+    id_ns->lbaf[0].ds = ns->params.lbads;
 
     id_ns->nsze = cpu_to_le64(nvme_ns_nlbas(ns));
 
@@ -77,6 +77,11 @@ static int nvme_ns_check_constraints(NvmeNamespace *ns, Error **errp)
         return -1;
     }
 
+    if (ns->params.lbads < 9 || ns->params.lbads > 12) {
+        error_setg(errp, "unsupported lbads (supported: 9-12)");
+        return -1;
+    }
+
     return 0;
 }
 
@@ -125,6 +130,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 static Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
+    DEFINE_PROP_UINT8("lbads", NvmeNamespace, params.lbads, BDRV_SECTOR_BITS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3cbc3c7b75b1..758f58c88026 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2812,6 +2812,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     if (n->namespace.blkconf.blk) {
         ns = &n->namespace;
         ns->params.nsid = 1;
+        ns->params.lbads = BDRV_SECTOR_BITS;
 
         if (nvme_ns_setup(n, ns, errp)) {
             return;
-- 
2.28.0


