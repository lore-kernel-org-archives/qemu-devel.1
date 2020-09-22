Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0019EC4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F469238D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F469238D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKe69-0004Fm-4v
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvn-0005oD-M8; Tue, 22 Sep 2020 04:45:49 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:53515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvf-0000sx-SP; Tue, 22 Sep 2020 04:45:47 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 1B85D5803CD;
 Tue, 22 Sep 2020 04:45:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 gn31c3w5iM1EbPGIq2NOqpzeSr7S+7R7lzk+sfWK6ss=; b=wjhYzvxEUhzoouJt
 SnAWt8KjLtsRZfFt9jdTeaiWQs2lKkJhi48XZHdTAvJBP3B6y6S/g6tfou8WdnTZ
 qitVNVjKZLrCbumkiNJkAKZK58RLv5jBkosejCKEucg4W9XzUm5zDctrwtWsuuFZ
 TdgD6ijDmuNZ+ePm/oye/MayrGjSMMJrMw5kB2OW0K/VjdO14V/timigMQDtGcR3
 tjUvb0Qxk6BYwVFbXV09efol2DMvr8/QlOB50k1xOLEfNeNGqPpLRuXGyXJIxa2l
 7MhTTSioKLQqeBBPTAupfB23NKmDxU3RUIgF/53a3mO7fIVwERR5hY2yjlT85GP+
 jlLRAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=gn31c3w5iM1EbPGIq2NOqpzeSr7S+7R7lzk+sfWK6
 ss=; b=oN6Dw/2jHN1yCSdeA25U0vj8FPr4aNmQuOzrlAP2M1Dt/H+JqTHvurv0N
 z4ftqV6uEeZTZtMLIpfehS3VqCNrZyp1VP/X1pQaiWkU5xOS1RjBgnteF7EL4sLe
 b2UkOL1NIcAchyrCD01lrJ4B3djJ1/iPkb6LTViI2fJMzc8Rd09fZYrXSKHeo3Wq
 5rFGORrd5vqhticC2vUgcehKvlxjVPZ2+1kHSOh0YgZrdB+bi0U+zLCPyw/UtfVo
 0WEz6J4R6LbqzvtCHaE/1CgxqY3gxPhKAfzO5BzWD78Ep/C4w4itqzzcMclzMqJd
 nxHmf1AI6zZ10L5dn0zny4JQLkwbA==
X-ME-Sender: <xms:srlpX1-EzntkDGok_KWeOz425kCbvTsfuXBa2zeIdDmQs7JG84jHGQ>
 <xme:srlpX5vSZfMIqFgPOiX4_pA-Oz0S1pf7NLUYzmm9KhAiNHZuUQDIsGFtX1FieUsfv
 lXc7TtA2r-nstYO59U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:srlpXzBG1qXHxPiHtZ9Zs7zSMhT5OxOnw22-UA9aZWRnBdfmFsnOUQ>
 <xmx:srlpX5dubrgJK2iNrTjsscYwL8VEfbhn7E4bEQR525TKqGao7A8Vag>
 <xmx:srlpX6OE2N8MJ6CB-7lCoc-AyJ24prOyb-TrY5V1eHbIyuPQNNSUdQ>
 <xmx:srlpX7gaY83aovI9J5BV0zK6Eu4CUDXLhEV5sJkICh05AGe3iuEwjZEuo1Y>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3DC743064682;
 Tue, 22 Sep 2020 04:45:37 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/17] pci: pass along the return value of dma_memory_rw
Date: Tue, 22 Sep 2020 10:45:18 +0200
Message-Id: <20200922084533.1273962-3-its@irrelevant.dk>
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

Some devices might want to know the return value of dma_memory_rw, so
pass it along instead of ignoring it.

There are no existing users of the return value, so this patch should be
safe.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Keith Busch <kbusch@kernel.org>
---
 include/hw/pci/pci.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c13ae1f8580b..0ff3feec1573 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -785,8 +785,7 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
 static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                              void *buf, dma_addr_t len, DMADirection dir)
 {
-    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
-    return 0;
+    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
 }
 
 static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
-- 
2.28.0


