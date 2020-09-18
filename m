Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E477C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A26A206A2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A26A206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNLf-0003NV-Ev
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7W-0004oE-1Z; Fri, 18 Sep 2020 16:36:38 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7U-0004xv-B7; Fri, 18 Sep 2020 16:36:37 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 83BF1580219;
 Fri, 18 Sep 2020 16:36:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=7wv89baT9qHbL
 /ezIoIGzPoYiVwB/5EWHsOfYIG7Gjo=; b=Vp9qvyY4GeEMPoBQTlkgEGXpZV1aF
 hYdpa3gZ3T4xGqFDVebcJt/1VU9vsf4IFwvQdeNdOnBnsiZLUcjDHu8E1DkJdY8t
 ctOZL2fVmd+gyIZtuGWVaYUqByfULGvshlbAn5XuVZY3zw1Km7V4tSbHwlvh8ZJt
 dVk3Fk9GhJ/zX9L601+E56pukTYwDkSwRF7fdFRwuoDc/0lLZ+m9VGRu0zhQ4poB
 72HdCBSpZUGg9MOkpn/+jPoXMXYW+NHFZb5ZkMQTERfvHy9qPNUPTxAwi546eoT8
 /muTSc6NvQswtgQgT2gZIuMXBB43+GBxShnDEeLb4rcrIW1U1dT0x3Q2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=7wv89baT9qHbL/ezIoIGzPoYiVwB/5EWHsOfYIG7Gjo=; b=ljGKo7bd
 a+G42ihXC9FI96pjpKRKoNqaGODNTKRxUSjDjOSkeKSMaZ2Bl7n+WELd/YLMEqNu
 CjbyITj367vbf581QBuGeybhf3pbRbZFhaH1yEgk3iQmvxEF3hDKt+JJrh6xBQis
 6Ir/1pmIUhdH4fn/IoYwxDWEchkpChJt3FbMFk3LmiPwk977N38eWGISqYxg/YLx
 6oWewpCZpU8NyJ8fgfvxWmd4sWPa3kSvaEqRwCq3iiS1YJMehH3QII4Vi6Gg3nfn
 bKDRrnZSybq8ym5T96RVF7AOUXSmBY1sNrcGgFapWb8TkMKqdN3GPodxZ22yZN18
 o114SVpyjzSE2w==
X-ME-Sender: <xms:UxplX-L9HJU-nY10rtYBb4ozpwIsv90TZ-EjpeRROHXemJ_b8F-knQ>
 <xme:UxplX2JBv9l0Tgdm4TJX4HipQGvWnMN9ZuiBWoc9N3y8jWctrByin_wcKkgMlYj8o
 EsfS0z1Fpbp09y12tI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedvne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:UxplX-s65cSH18969ZE0RJmAO5HUdE47N2MVeH9wxmD_vSgy-Q-7LQ>
 <xmx:UxplXzakECiNhJ6S94un0C1sMMFJhhVrcjZU8uc40-5DeaPghj2eZw>
 <xmx:UxplX1YzqnTkL2MPtI0vaQFgKGL44fSbKMnqcD2-LZ5duQ7EK-auKQ>
 <xmx:UxplXx7o4xrFqdafUvwpwb5xmxIQZAcYmQoC5_eqZmHgyzTRtkZSxw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id D0665306467E;
 Fri, 18 Sep 2020 16:36:33 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/17] hw/block/nvme: fix endian conversion
Date: Fri, 18 Sep 2020 22:36:11 +0200
Message-Id: <20200918203621.602915-8-its@irrelevant.dk>
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

The raw NLB field is a 16 bit value, so use le16_to_cpu instead of
le32_to_cpu and cast to uint32_t before incrementing the value to not
wrap around.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 62db87460413..32267a3e4782 100644
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


