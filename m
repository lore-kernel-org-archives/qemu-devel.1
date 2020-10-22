Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A52BC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B7620790
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B7620790
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVan1-0007mL-0p
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVaZf-0007iD-IV; Thu, 22 Oct 2020 09:24:11 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVaZd-0003O9-PM; Thu, 22 Oct 2020 09:24:11 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id F1FBB5C0138;
 Thu, 22 Oct 2020 09:24:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 22 Oct 2020 09:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=QoRKagGBtngGi
 X0d3aHQKdOjVuGkdsnPPfn8jCZ4n7s=; b=c3tYvwzAQux8NHHv0AeZQl2jZO6Ft
 126xEQtzVcnzhE5y+RbBxdawVTa7USYXqsVTOaOu8l7s6DxmkUBg9VuckHIvnf/H
 z+VaxVdvUM0rjL/zT1fRIFaUR3NcQnDbHnTDw+mWpFJA+q3Nynj/vs0oOW3i+8yJ
 RrVGZtvF/wEwtgqzUUFIg6kCqITaUwCWMIYJzj/Zyig8iJMYk6myiz/Gh1f7fsDk
 ncCr08JWRta3d+D/HGPkN4ZQY3SJ1/CwYovNHBb6dgEFX9DAZNcz41Dl97kG+mMX
 rWE1rVRLiJSj/eltvrUXT/px/Z+NDAbBaVowPYBU0RoynL3QsR1oxPtVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=QoRKagGBtngGiX0d3aHQKdOjVuGkdsnPPfn8jCZ4n7s=; b=pli+7+dx
 lSkwumNfrXlN9oRPZBZBBzSom4pdUhB56znu81HEN+wuaeO+g6W45iUP213GkWLJ
 2L34mMxfqOe3dG1/b0Vfv+daaSo6pmpjCJdYVe3UFYTece8S5hWhAyTJ2680PUdR
 b8oVaY8/sGjpw4SkRNF7oQqTxXQMBKnBobBx0BsemNXxnbOId/9DNPlAqjbvQgeV
 gX2Q9dIvz4ia+9S/4ABYU68l2DxGamBSkYQ9/+Pff4emw2IYSmNLvmq/48U+OteU
 c0zhQE/JSPu9kBfQwqeF6Dyyy3vSNzjBTNJZJ/lNn4bAzBK5uMLiDn43jKPa6b6m
 fkeoKpb0QjvtMg==
X-ME-Sender: <xms:-IeRX3Msxf25kC9fAdvpxEZIfeVEi5FKO-g-0iT1u0sQAY0fjYSbLw>
 <xme:-IeRXx9b3S6jALGcWe1HNJLdTlXKnWbV8WUxxBs_0FLw9CKCFkny1Fwk2rhd15Ufk
 GFiJ6I_ozh-d7QsPbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgdeivdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:-IeRX2T-Ea5uDuq0QdpSoA_wtIJlmNFK1FMxlkjNLAzVgNSc1MAGiw>
 <xmx:-IeRX7uUSskJl6aIxv2JC2jo2B0QvizkuQ_XTAhwaNjxF8WX2xYNfQ>
 <xmx:-IeRX_cZCTkQ99fhiz0xJK572TAP4wwcdh5kAAzYOxM0m0O8qjsqSQ>
 <xmx:-IeRXwHZnYrbU73RY_r9ZAa-LQFva_jxhuxWWSBiurMxBLPCLUIZhg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B13FA306467E;
 Thu, 22 Oct 2020 09:24:07 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] nvme: fix create IO SQ/CQ status codes
Date: Thu, 22 Oct 2020 15:24:03 +0200
Message-Id: <20201022132404.190695-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201022132404.190695-1-its@irrelevant.dk>
References: <20201022132404.190695-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.28; envelope-from=its@irrelevant.dk;
 helo=out4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 09:17:09
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>,
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gollu Appalanaidu <anaidu.gollu@samsung.com>

Replace the Invalid Field in Command with the Invalid PRP Offset status
code in the nvme_create_{cq,sq} functions. Also, allow PRP1 to be
address 0x0.

Also replace the Completion Queue Invalid status code returned in
nvme_create_cq when the the queue identifier is invalid with the Invalid
Queue Identifier. The Completion Queue Invalid status code is
exclusively for indicating that the completion queue identifer given
when creating a submission queue is invalid.

See NVM Express v1.3d, Section 5.3 ("Create I/O Completion Queue
command") and 5.4("Create I/O Submission Queue command").

Signed-off-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 2896bb49b9c0..5dfef0204c2c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1151,9 +1151,9 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
         trace_pci_nvme_err_invalid_create_sq_size(qsize);
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
-    if (unlikely(!prp1 || prp1 & (n->page_size - 1))) {
+    if (unlikely(prp1 & (n->page_size - 1))) {
         trace_pci_nvme_err_invalid_create_sq_addr(prp1);
-        return NVME_INVALID_FIELD | NVME_DNR;
+        return NVME_INVALID_PRP_OFFSET | NVME_DNR;
     }
     if (unlikely(!(NVME_SQ_FLAGS_PC(qflags)))) {
         trace_pci_nvme_err_invalid_create_sq_qflags(NVME_SQ_FLAGS_PC(qflags));
@@ -1400,15 +1400,15 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 
     if (unlikely(!cqid || !nvme_check_cqid(n, cqid))) {
         trace_pci_nvme_err_invalid_create_cq_cqid(cqid);
-        return NVME_INVALID_CQID | NVME_DNR;
+        return NVME_INVALID_QID | NVME_DNR;
     }
     if (unlikely(!qsize || qsize > NVME_CAP_MQES(n->bar.cap))) {
         trace_pci_nvme_err_invalid_create_cq_size(qsize);
         return NVME_MAX_QSIZE_EXCEEDED | NVME_DNR;
     }
-    if (unlikely(!prp1)) {
+    if (unlikely(prp1 & (n->page_size - 1))) {
         trace_pci_nvme_err_invalid_create_cq_addr(prp1);
-        return NVME_INVALID_FIELD | NVME_DNR;
+        return NVME_INVALID_PRP_OFFSET | NVME_DNR;
     }
     if (unlikely(!msix_enabled(&n->parent_obj) && vector)) {
         trace_pci_nvme_err_invalid_create_cq_vector(vector);
-- 
2.28.0


