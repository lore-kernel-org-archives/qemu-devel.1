Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3242FC43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA612311A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA612311A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNLw-0003YS-CO
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7V-0004nj-Ok; Fri, 18 Sep 2020 16:36:37 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7S-0004xc-SR; Fri, 18 Sep 2020 16:36:37 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 1B659580215;
 Fri, 18 Sep 2020 16:36:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=OilfjDLIZZFgT
 1MKes1rgGsHvhKPCbnciYBLgxXw6SY=; b=kGKFFFUBJaNqOXeuKcNK9n3fvOGoj
 +aDcAkarUYLo4bA2OPU8iCU+zw93KdUq8PxKGIL5isNx2ID5n2YhDwwvo+xwatUL
 pK10bvQSdF30gCgOIfFUgXwJQWzM+mOnvstVvFypOO2a1T15bcPNrXxHv5Sz0zQp
 jC0M3W15lyjyCY1y0FJ18fXUYHeoqz2o4n1tUVtiMGzZYQxc8xn5waJTLOfxSOlH
 IzS34CbFmOWwqUJ1Cam3gub14m8Jl/G60hOSL4wh6q9shN827bQm/7YofMnbRVZq
 KKxUqzXtZXcISE3GH5R4UmPEdY/u5ZYL1siEZ71mdhQGnFSdhLQyz90kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=OilfjDLIZZFgT1MKes1rgGsHvhKPCbnciYBLgxXw6SY=; b=Z0h3CBIa
 48bungS1PXU9n5TH2ZKTo6otqfnjDN1PnOKOMV2rut0eYX+hyP1UI0kmYXFidF7w
 WDwV7oJRpf3NOB9IBU8QlHz2X3j8W5S1m/lq/Yx6GjHvUifaPKure3bYlNViDbx+
 I0sENWDkR1VnDeZwHePNqaogDBxt1hQCri0oxOzD38Cnqcckico4y9MnoGS4HOz4
 Fl0WYEAmj1SwisXWuzzdq6Xlsq+J1GPlOTKODkbFSqsnkk1qvSBkFtjGoukblfHG
 TkkdRg2Nny3THNV01TgJQA8xtV+p8WV45gcMFU0mfVZ4MVCN3UkQ1WZwJrApRxpJ
 +9IUMDZBKPocKQ==
X-ME-Sender: <xms:URplX_JL1uRD6Ju-eZV5u5O69Us56gYlxWpxuQgI0pj7SkWyvFDr1A>
 <xme:URplXzLehx5zGRte7nybmWXLRcQ98DalmyZCMKnqz_oS4eCqjMMksVSz-T8tmLdN8
 4XhbY9Q--RBYRdcL9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedvne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:URplX3vf8jrwsHjjZVUkq-2P0GLZ40QJAMv2pBxVwxleIGZJSeIBjg>
 <xmx:URplX4YVeUKhKGe7gDGO50svtPkw4iY5720RzAnN5Z-F2R1fb1YgkQ>
 <xmx:URplX2ZSsF7-R1tgkrTKmRWdXGjMYNx605wVYBo6IhdRWH42j3sEDA>
 <xmx:URplX-5YTTFSfPo5N6h7ORgOyaeEe0Fnpb1b9ty0CFtgtCz7EHZGLw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5C32B3064610;
 Fri, 18 Sep 2020 16:36:32 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/17] hw/block/nvme: add a lba to bytes helper
Date: Fri, 18 Sep 2020 22:36:10 +0200
Message-Id: <20200918203621.602915-7-its@irrelevant.dk>
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
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Add the nvme_l2b helper and use it for converting NLB and SLBA to byte
counts and offsets.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.h |  6 ++++++
 hw/block/nvme.c | 12 ++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 52ba794f2e9a..1675c1e0755c 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -77,6 +77,12 @@ static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
     return nvme_ns_lbaf(ns)->ds;
 }
 
+/* convert an LBA to the equivalent in bytes */
+static inline size_t nvme_l2b(NvmeNamespace *ns, uint64_t lba)
+{
+    return lba << nvme_ns_lbads(ns);
+}
+
 #define TYPE_NVME "nvme"
 #define NVME(obj) \
         OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 10568cbf8761..62db87460413 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -644,12 +644,10 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
-    const uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
     uint64_t slba = le64_to_cpu(rw->slba);
     uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
-    uint64_t offset = slba << data_shift;
-    uint32_t count = nlb << data_shift;
+    uint64_t offset = nvme_l2b(ns, slba);
+    uint32_t count = nvme_l2b(ns, nlb);
     uint16_t status;
 
     trace_pci_nvme_write_zeroes(nvme_cid(req), slba, nlb);
@@ -674,10 +672,8 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
 
-    uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
-    uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
-    uint64_t data_size = (uint64_t)nlb << data_shift;
-    uint64_t data_offset = slba << data_shift;
+    uint64_t data_size = nvme_l2b(ns, nlb);
+    uint64_t data_offset = nvme_l2b(ns, slba);
     int is_write = rw->opcode == NVME_CMD_WRITE ? 1 : 0;
     enum BlockAcctType acct = is_write ? BLOCK_ACCT_WRITE : BLOCK_ACCT_READ;
     uint16_t status;
-- 
2.28.0


