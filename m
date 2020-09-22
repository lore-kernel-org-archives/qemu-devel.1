Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BC9C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BE5238D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BE5238D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKe6B-0004H1-5N
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvv-0005q2-Me; Tue, 22 Sep 2020 04:45:57 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvo-0000tk-Vu; Tue, 22 Sep 2020 04:45:55 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id E5ED95803C8;
 Tue, 22 Sep 2020 04:45:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 qVzj+sd8V8qtSgJnTbXuHzdDLCHWmm6nkGXXm+BIZDM=; b=ibNtkrnt1Nz7G0Ma
 MCal3hwdTmLwoBZ52FfRRd5bjpuSvjStCBV9388Ico8Sfrmc4r28/GPbSZVqn0nx
 7GyPeVC4wmifJ3mn4k6v5Xxrn3jPgneEhClAfGpej+P6lV9V/AZGyNplIvUMV8ZN
 kIriENfWiYyBIp63qJrrntPJTcu+MzxasWFhDroCh9jKlYqoIcB+dNqfZxoUodhk
 FqgruzCsDNP/hstdFXaO8+KqhWUe8eabn3N0Wx+5ACIcQZoU3M6Sf818VJR23jH3
 vNjgkpDSKyyJoSDGeT72Dq5nEx8Rm3T+R+9Ha5AGx3AjW/iCTQhoWrKmgKt0XGAi
 vjm95w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=qVzj+sd8V8qtSgJnTbXuHzdDLCHWmm6nkGXXm+BIZ
 DM=; b=F07PdAFKH/uh6BE8ew45UdMlqrMpKyMJMXt9z5ouPmzE7tuT+Y3y1r26S
 wEq5vTE+WNhU+vafw1WIJz2qg2AUqVTYh5IvjR1yCQpb+FYXMRgYNsYffsEOJ5sq
 y4vwyl+vO05ZPz+KZvJLz+9XQSGD64zEdRXFTir+lwmCrEvGajhqWHZ+8O+glHdG
 yybdZilCaIgiXDvAFU+UWmX+aVTw3hmYtjvu4t4IBKlAuMhlZVZy/syBrWPXnvyu
 LC9USQvTTUkQEu/CbJnPSY1SpdGZfmG34OXVCMoJtOVgM2pZG5dIFgLymq8fxPT7
 Knaqbq5KBInmg93BgGvBFL/qnOJfw==
X-ME-Sender: <xms:urlpX7CNaLYnCl6VVVUgcpwqtnDLCMQkJMBSGB5xqNHuB75QWyXXzw>
 <xme:urlpXxiQBiBsSBtqqGofKPvaldRRZDl-P2OVz8YpH9ip-3HplQofX0p-fPFHK2lVa
 zOQHNJYeUWzzX795Ns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeefne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:urlpX2lCwSX0Gi0oc9Dt6JoD6GTQMgz0WHvTET0_IzEgiPF7E_ioQw>
 <xmx:urlpX9wIo0Az8TBKkZR0MwgKyfB8gNpSqGCndj6eRzhb1pxAqrWjWA>
 <xmx:urlpXwQydC6ImPXa-HykkLST1e3qEX8bJJDpg83IDOHG8nz13BECcA>
 <xmx:urlpXzGX2ccg6X6ZTxDyCX3AceXSwjXJTmUWJ0sq3NJPLzIAoPAxQtTWkBA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0E0913064682;
 Tue, 22 Sep 2020 04:45:44 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/17] hw/block/nvme: fix endian conversion
Date: Tue, 22 Sep 2020 10:45:23 +0200
Message-Id: <20200922084533.1273962-8-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922084533.1273962-1-its@irrelevant.dk>
References: <20200922084533.1273962-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

The raw NLB field is a 16 bit value, so use le16_to_cpu instead of
le32_to_cpu and cast to uint32_t before incrementing the value to not
wrap around.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 25b34b3701db..638e3b1ccac8 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -645,7 +645,7 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
     uint64_t slba = le64_to_cpu(rw->slba);
-    uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
+    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t offset = nvme_l2b(ns, slba);
     uint32_t count = nvme_l2b(ns, nlb);
     uint16_t status;
@@ -669,7 +669,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
-    uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
+    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
 
     uint64_t data_size = nvme_l2b(ns, nlb);
-- 
2.28.0


