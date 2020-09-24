Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4317C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E263422208
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E263422208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYO8-0005tP-Nw
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7O-0004RD-1f; Thu, 24 Sep 2020 16:45:30 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:54601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7J-0007h9-O9; Thu, 24 Sep 2020 16:45:29 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id AE0F558050C;
 Thu, 24 Sep 2020 16:45:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 qEKNIM+lPRA0c0RxRX/s4SVmBXPBiqyjUZhRX090gXI=; b=mFIKeNALOPJUzzRw
 iQmgnHbCruZbtxHZ557Ki9T2Dga7uvYIdf7IJyunEHhYJvfawD+lBR1h8hi+vi0U
 Sgmfnu/1BnemS7q5DnipzX2wO4tGWuYT7Q/rDU9e4zhi33zjlGf7KSIdfOXc4MVM
 GPED2AcPoApQFkEMtXqYjiAUmIOGPzVallmizORUeQI/OqIkm2qmP3JKAsgbVqIZ
 rqrdJVd+uIQjSxo1+AsXcHd95utdTNPkOJsNOlVzav3bJalt/9/tCnyzB9K/8Ps7
 j4niKCZzRlL0yode+N5vSJIkwPEfeW3JAkesgXh3JdlplEc7vVNywlSPo7WI87LN
 e9wA8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=qEKNIM+lPRA0c0RxRX/s4SVmBXPBiqyjUZhRX090g
 XI=; b=AhE/dRdrkdAkBngThpoY6CKJWUUXmMoY4KWrDhw6ZYIqSoyo/dY1564MN
 tkYiYiQTf1J0oVQuUSd8IgbuRk4XrPd7CqEVUXMjinlUtzZ+np1B7R6dHnt7fplH
 uQoOz9zK6ay1VPxPQv2L91z0pB0tcGhkf/MLmX4APIXzjJIfsNWxR2kvMW2DxPKi
 x6vrYWd1VmdIAawCqr5OFnZtUBOeNbmitZYagGKtTTrlcbmcrnrtgDl5ZNMD7PA5
 duZsaqUkdfsHgYaOJXJ/VSZWdOHn16DdZpjekY3ri4Uju0Ql8RzPPfTm3cHM/8xx
 cAxS/u9GeRI4hmTTfPASsVksj9lJg==
X-ME-Sender: <xms:YwVtX30ukia9E90olTcBQ21otA5zvVjV1d31LSioElWWdvcazJymaw>
 <xme:YwVtX2E1NEtyLasARQEeZW-SGnky6N_694tklSclBuBjx8KYLamLrtmU0a0WPxrmc
 uDafPX-ZM4iimYzXCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepteevuedugeevieehgeeileeufeetvddtkeetfeelgeehudfhjeeuledvhfff
 tdegnecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:YwVtX344_Dfe7dogoR2AjVWcz9XTHRtMCh9MxYR_2DbJU9qMdOfzWg>
 <xmx:YwVtX82tMA7uwp0IfTjE2hv3peFbb1a7pawlXxsSFC_fMVrhSW9Wtw>
 <xmx:YwVtX6HyHwKjWn_KQ3pfHwx5nHueIOyg436YQt2ELJaxsyXtd7D9Og>
 <xmx:YwVtX93ZCQOtM6CkUDBK_Ov5QbZI5PhLOR1tfjJPkgQb55ou7bfO7Q>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id D8F443064682;
 Thu, 24 Sep 2020 16:45:21 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/16] hw/block/nvme: make lba data size configurable
Date: Thu, 24 Sep 2020 22:45:03 +0200
Message-Id: <20200924204516.1881843-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924204516.1881843-1-its@irrelevant.dk>
References: <20200924204516.1881843-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:55:29
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
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


