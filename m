Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9C2C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95234218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95234218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMj2-0006Bf-CT
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXv-0008OC-Tk; Tue, 27 Oct 2020 06:49:43 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXr-00023g-Lm; Tue, 27 Oct 2020 06:49:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 384415C0115;
 Tue, 27 Oct 2020 06:49:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 2PVe97v31smKull0KxBZGdcCj4TSLA2sP3bikx94fmI=; b=xnpPevahcdDd3T4i
 I882c6YUIsfIaGagFIx23nE/QV6bJQG7CeNlQBwCoY9Gckq9GPbCZjzk15ic1I8T
 YRQ5n2vMn2I8YaiQQfBB8rB2dSkYnKwQmNDxxZl0Ro8cS2vP1M5fxFBkvdcJFpEG
 XgUCk0Ay/ERTY0uaIZtVC/7T68Ig77H2Oa1yXrLJ985nsaYLhozRfXvWf3Vf1XQh
 ICKWtI7UYzme3bVyoRoTR71qzI9fGzWO6n0aCehRSaUjNoQEDbwwLRcy580CvTN0
 wtXaziqBYEtpLNtzsgW0IlrqJ1vB4O3ev+zslep9aNGgVv9lIrDDNs5Gy0wplmVu
 AqcjEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=2PVe97v31smKull0KxBZGdcCj4TSLA2sP3bikx94f
 mI=; b=US5lqZcamK4EE1q7yhig1/z3AKH0a+JqPbKVg+NJzmW+S4RiRTjjPheTO
 dXWDUOkyPL/i6XTUdQPazUzXko+fYXIZVVDjZSGO04Jbbte2ZjZ+Wt8yXKrcKXEm
 sLO0y+VlpSgG9gOi27FB9Tync5b1JnqI+uiHPn3gZ0ij+hvtN26vNOZuZlwKxuNF
 lRJZ/J13VKg8JuneRLZ7zHOGQosKb25q5JnYMxvvk3KCoUxg7QwM+32rjBRir7ah
 3aMV0cRbOemPKDy2IyFMyyVqk+eGKexvue0pU2QQfBsyVhSXa2BKgsnfDf79X83j
 3pId7duh0X0/RRmQUC+tBf+cqFFwA==
X-ME-Sender: <xms:P_uXX6eAfVqLZjXugM4ZfUkxJyome3i4jlIhuGAMWfin4Ib4RNYCZA>
 <xme:P_uXX0Pt7_xD49NiafMkmcDZU_851-RzKJruaJSQE1vc-hxFiFzCZ9Y552rfUAlq6
 hVX6PF_bpVsk3kdodI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:P_uXX7iPdgyQ5coSj9vNLLhs6D8gp47wPSM8QxYdMvxhgsaQceMoeg>
 <xmx:P_uXX3_tHSbt4HjtjiX1CscvnyXb4bLDUoV7BkhZa_HehVbPA9cd0w>
 <xmx:P_uXX2v9dW1b2BMY0DXu4rW8hpRbSnR_wpkOWsjq8OBqVjPLRByjRQ>
 <xmx:QPuXX4JxuT9m0Q43YVCP_HA1a9kiynkxr1tIf1HGzrF9OxaFs-A-Aw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id E01CF328005E;
 Tue, 27 Oct 2020 06:49:34 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 01/30] hw/block/nvme: fix typo in trace event
Date: Tue, 27 Oct 2020 11:49:03 +0100
Message-Id: <20201027104932.558087-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027104932.558087-1-its@irrelevant.dk>
References: <20201027104932.558087-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.26; envelope-from=its@irrelevant.dk;
 helo=out2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:49:36
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
Cc: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
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
2.29.1


