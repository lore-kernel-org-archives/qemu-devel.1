Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729BFC4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068D2221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068D2221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKe02-00006c-Ul
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvp-0005og-SN; Tue, 22 Sep 2020 04:45:51 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvf-0000sg-BC; Tue, 22 Sep 2020 04:45:48 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 7D4D15803C9;
 Tue, 22 Sep 2020 04:45:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 gp3X/gY01uey3zkC/W7G1dVfSzAISSdZvoBBYxr7njc=; b=gqxyU92/WKK0viz/
 BNfgQJwaMJIVI91y6s2YUTBEf1XCf5q6EFuBMCk7SizxayTP+knJookX7EZE5u7D
 RxVDo3O6akmOqiXR4It/h7/gdKfHvSqWPJ6LNW0lKMIFWnr0XkaVgP/a0fsUV9Xy
 K9i77665z0QFdR9watchvkH/9sA0anU2pU7kFaHf5X9z2L29BVvdxDLlc2gmKb4B
 dSmCxPckewXJCc56DZqzxqDoIqK//SIEEw48r5FCM6Dr3b2W3WOgJqgENBFpSU5j
 CVNr4RLHOisj30TK0rabvsr4o5lfvz8Ccjgrb5+2OoNTeg+Kd/mIqq9KuyGrnhY5
 dWxr+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=gp3X/gY01uey3zkC/W7G1dVfSzAISSdZvoBBYxr7n
 jc=; b=oISDSGaIS8vLZxpT6sKeYC1RM9NUlqaEye4524ArgdT7PWuRxHDy5ClNi
 Ht6wf7PmE8D6pzUdXSEr030OmKI8c776sMEMNzbkgZqudsKa1qF4C2vv7n3tbHjD
 amrMTMjhdXwbT/APmyZQFrqDsc41cGmzl7LZZUd/62ckuVbkqQDTPrS/f9FEBp2E
 OpYy15GGKMdaVF3pIWxpvDBTiSYjSN4PDjqF0GBDExmIMTtNTH5Czfl1K3vQCLfG
 93iBg/NGn0tVDKPYU2fblMExbVhOuTjVJmZd4oQlsi8bw4KKlXYa3hTIigGDwQ9z
 KEB3IXebqT68Uj1Ir0vBifteg1w3g==
X-ME-Sender: <xms:sblpXzwBAoSbQWuFpXJblZFlPAzsnUfDlOOPdHG3-etFcYHNhCJuGw>
 <xme:sblpX7SKPHV-twh5YV9RFq3Mu_R-B_O-oNHfeQ9eUJ1uXrZDXRTRUjFarx9kEMcxt
 ZDSoJHd7V81O5En_Lo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:sblpX9UetTxsQ7h1QCSRkSJFgQHJtu3XttjOZDX75bhUNrlrbsLcqw>
 <xmx:sblpX9jqEPpwkQUqV2AIMtmxWg8U9o6uYw0CxAz6Fsypwr8qrGpptg>
 <xmx:sblpX1DSlbfzPLEUBAZqhVCCio3MZvKULpmuukLAK2uepb0_Rfr5DA>
 <xmx:sblpX51mbeSF-Cka4YAi4nCoFpBnU6LusBIcL6FnrfCmHtRctyaGOewczZ0>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 963053064688;
 Tue, 22 Sep 2020 04:45:35 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/17] hw/block/nvme: fix typo in trace event
Date: Tue, 22 Sep 2020 10:45:17 +0200
Message-Id: <20200922084533.1273962-2-its@irrelevant.dk>
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

Fix a typo in the sq doorbell trace event.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
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


