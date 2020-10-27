Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D0CC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE3522263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE3522263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXN2a-0002Yp-3R
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYq-0000kd-7s; Tue, 27 Oct 2020 06:50:40 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYo-0002IP-Bj; Tue, 27 Oct 2020 06:50:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 0CBC65C018B;
 Tue, 27 Oct 2020 06:50:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=1i3kcp61iWkwt
 8qf2ro7C4gt23DgmJ5vUwDK900n8fo=; b=Z1jVeQZy7Cqfo9N6+5FT7vKdCMgYy
 LSVs2cPFceAgQ/bzd/naGlsNAGYyhEy5ke4XipD/y/rgzdpgQuL/Cag7rPtYF/2F
 6wqKlllY/V+A++fdz4lson3q34s0nmIq8v3HiXsa/Tax/Qb9i6HSiCbOdFQF94Pc
 eBMmRVjhMt7Si4M0OErvNnmjrz2A93I5+2LSKRcUj1Dl/Rlu4J75jL8Rur0ML1GM
 dYRS3Xm7HywHAxmJKT7me3tCqdRCC+L1ZfxpEIo/rrTNix+gJnWQyvEwLCzB5ket
 pBOOh/YYvT4Vd67LSBbNhzywHiMnWr6N0fGrlmc5mDEV/Htuf5a3Q5u5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=1i3kcp61iWkwt8qf2ro7C4gt23DgmJ5vUwDK900n8fo=; b=VxnWbkfM
 zxxaEmDekUilhuWzu7ShNWAKmmrODingZdS8PPrBNFAsXkGPX9o6/cMPEE0JjDUK
 BNmPSDyTNpmhY2f/K9C0+LkUBULc6sCBrvR4MC065YVUMNc0WLUq5FTN659gsPeg
 F1H7mtpmDITcAaWsfZbtWJNxvsYBhg4FV7QRyNyPUD6/OfT54OcdjazCbxO2VvBx
 wvaTwhgxm3lbHK0R5FqBnFOUD/uBYU92qCEyRem7R2FBO+piNpay607ZgnHg/py0
 jjltxc94k8bgKj3RMhjFZpvBunsBuTarfrfXyZyQbh14PqnlU3xTGGQSDwPXHQkx
 2LRHdKWSDCzlGA==
X-ME-Sender: <xms:W_uXX2Henx9ED-reRBbZ5y3OBYunsTz5tFnsoYuG1mLPqdpOTXkk7A>
 <xme:W_uXX3XxPoDZbdONpKOLJXDme71xQd7Y9_tx7YDT5ouFlJeSsq-yV5F8woUD3vxPE
 cM60SgVhiKKYM3s68M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepuddtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:W_uXXwJF-CznztuczscFf629fQxhdR-3CmERQV0Q99Bma7EA9DnyTw>
 <xmx:W_uXXwGacNKzdUGHtZipHCZCGKu2VIm8t0om3zMs3uHZEyzjj1U0rw>
 <xmx:W_uXX8U8fteR3GKx8xoRZaz2veHXjf2GbXf41CEN2bXku5GsZWzmIQ>
 <xmx:XPuXXzTTNxDYW2oihFwTDeCtCDy2NLQbhm57ASop7-nV_qReCCOifg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B5AE3328005E;
 Tue, 27 Oct 2020 06:50:02 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 25/30] hw/block/nvme: add nsid to get/setfeat trace events
Date: Tue, 27 Oct 2020 11:49:27 +0100
Message-Id: <20201027104932.558087-26-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027104932.558087-1-its@irrelevant.dk>
References: <20201027104932.558087-1-its@irrelevant.dk>
MIME-Version: 1.0
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Include the namespace id in the pci_nvme_{get,set}feat trace events.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c       | 4 ++--
 hw/block/trace-events | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 32c35fe58768..5fd5a45a281a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1639,7 +1639,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
         [NVME_ARBITRATION] = NVME_ARB_AB_NOLIMIT,
     };
 
-    trace_pci_nvme_getfeat(nvme_cid(req), fid, sel, dw11);
+    trace_pci_nvme_getfeat(nvme_cid(req), nsid, fid, sel, dw11);
 
     if (!nvme_feature_support[fid]) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1777,7 +1777,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
     uint8_t fid = NVME_GETSETFEAT_FID(dw10);
     uint8_t save = NVME_SETFEAT_SAVE(dw10);
 
-    trace_pci_nvme_setfeat(nvme_cid(req), fid, save, dw11);
+    trace_pci_nvme_setfeat(nvme_cid(req), nsid, fid, save, dw11);
 
     if (save) {
         return NVME_FID_NOT_SAVEABLE | NVME_DNR;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 7b28091bd60a..2dc85281dc33 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -52,8 +52,8 @@ pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
 pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
 pci_nvme_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
 pci_nvme_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
-pci_nvme_getfeat(uint16_t cid, uint8_t fid, uint8_t sel, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" sel 0x%"PRIx8" cdw11 0x%"PRIx32""
-pci_nvme_setfeat(uint16_t cid, uint8_t fid, uint8_t save, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" save 0x%"PRIx8" cdw11 0x%"PRIx32""
+pci_nvme_getfeat(uint16_t cid, uint32_t nsid, uint8_t fid, uint8_t sel, uint32_t cdw11) "cid %"PRIu16" nsid 0x%"PRIx32" fid 0x%"PRIx8" sel 0x%"PRIx8" cdw11 0x%"PRIx32""
+pci_nvme_setfeat(uint16_t cid, uint32_t nsid, uint8_t fid, uint8_t save, uint32_t cdw11) "cid %"PRIu16" nsid 0x%"PRIx32" fid 0x%"PRIx8" save 0x%"PRIx8" cdw11 0x%"PRIx32""
 pci_nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
 pci_nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
 pci_nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
-- 
2.29.1


