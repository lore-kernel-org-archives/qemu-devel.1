Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1532CC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8339621D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8339621D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNAj-0006cx-Dg
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7P-0004j9-QA; Fri, 18 Sep 2020 16:36:31 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7N-0004wP-Fo; Fri, 18 Sep 2020 16:36:31 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id F398E5801EE;
 Fri, 18 Sep 2020 16:36:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=+81fWPyS5O+En
 17bFCxaEDemD8inTiVNp6oK+WilRA8=; b=mXhD0TG+6PBfM23QsQHID9I2YoRAc
 hnfKLCaxON9+4/Ed+9Cagh8I0MC77LoAxcrMUkxL4YE15R+Gbnqh8F1zVyOo25j1
 +gixlDRV6BFCr2kzvGjZNuUGJzlP1/r0DgvaXeTd3g91qWpSe54VcQtzOVCwTV+P
 umspDWmlHZWfWdCxpn9HrariHgZZ6yX1NFNU54MPberb/GFGD49k90Hy4xRnwuhw
 9699+uORkYodopORrWLliDJAeR2LWi7r64fey7xzUIm4jQU+zJ9BF4j2fQbfsL2l
 fCcM/Ak0wcNEbvUbiXdzWewz2JQ247pcRSNiGna8G70FNeATCr7MQtA/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=+81fWPyS5O+En17bFCxaEDemD8inTiVNp6oK+WilRA8=; b=N+kM0QyC
 9/7fq44UZYjKwLrlNoF4Xsgs+OGy7dW6kZg9BxwRdnZwpGB1CqMTOaBvfDOnx3jb
 eQvaAHDNHbb9uK/Rz+sIXEbuYlpMpu6usXqECB3CTNOj39aemnir3dISsddcj8eS
 6TxI8h138R0SD3tS+uALBbp/AXtN2QI5U1noJQhDfZCO/Ibp1Fm9Q0XeUwBCiwHR
 l5us8xO+1DS/SwK9/BQyrGGzjFNybKKRN1V6SthKBA7UXQcKnw1y2sEsTcK0ogv1
 Yioo+RuzLzxSKZPdBuqJtns5xaWLJaszL3hocc+h0nqya+cM0ap7phyh3oyhuVn3
 E6jvyzzuN8booA==
X-ME-Sender: <xms:SRplX3L2hGPQPZtGjBvwiriN0-LIl_N5ARIjDC2VGfLYhOqoXlkWvg>
 <xme:SRplX7J2FSq8CjDC5WLdFf2nYLhHkORO-HxMfOwyvXcNbCidFAhQD5Ev5HZnP8DlW
 0-qIpFCKkppu2uPuA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:ShplX_vNP_ORi1r7LQYG3MGs6tr4mf1AHve1mkcuFQASlbbEkSp2fg>
 <xmx:ShplXwaigbc2iAqKghob6jNcw_VwQe9Mdair7HJgzs4ixiSbgVvDuQ>
 <xmx:ShplX-Ykj2eGRwsz9N3S-U6NViDun0JIUgIJ6nnXzk56xYzBugundA>
 <xmx:ShplX24RclXodMUz-Cco7XhfDgRWs9VOqiko5-Bq9XZQHZqW-Tru0w>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 9F05E3064610;
 Fri, 18 Sep 2020 16:36:24 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/17] hw/block/nvme: fix typo in trace event
Date: Fri, 18 Sep 2020 22:36:05 +0200
Message-Id: <20200918203621.602915-2-its@irrelevant.dk>
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

Fix a typo in the sq doorbell trace event.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index ec94c56a4165..8ff4cbc4932c 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -70,7 +70,7 @@ pci_nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status) "c
 pci_nvme_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64""
 pci_nvme_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu16" new_head %"PRIu16""
-pci_nvme_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_tail %"PRIu16""
+pci_nvme_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "sqid %"PRIu16" new_tail %"PRIu16""
 pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
-- 
2.28.0


