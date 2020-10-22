Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA25C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90D2D20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D2D20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVasv-0002xq-TB
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVaZh-0007lM-HP; Thu, 22 Oct 2020 09:24:13 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVaZf-0003Ou-2V; Thu, 22 Oct 2020 09:24:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 4A3B75C00C4;
 Thu, 22 Oct 2020 09:24:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 22 Oct 2020 09:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=rDmengqHKe1VY
 9G06a15wup3LUz8qjNGDmc2bf6/D5A=; b=oSrU8Nd5e+DULZOYbQP5Jkq9M8EP4
 77YSP03NWnVsxtD7GSRRtWWPCkY+erz2TGjKU5PuVoHITvvtPTf2QS63Fw7H7gmA
 G2Dw7T6HV4VOlPlkPDePsZHkyiSt5Z5PsYI3VcLRbro2hoqrg4L9B5mRuRrV+c6S
 +z71KvlMs+TEholVaXmtzEIyw5ejaUuB9+m6xjVDQE87D2J6gMzksAw0yoZcKfXf
 tb5cXTochDMUw6tVNxQDx46u6yXHO5PfolHaSF7Dqt3/T9LZV2Kcd8kdBCkZFWpx
 whb1q6vvbE7DnYwFcxZKq4YLpBL1ml/s/c4gCBmOyAKrNZh75X3/EAOBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=rDmengqHKe1VY9G06a15wup3LUz8qjNGDmc2bf6/D5A=; b=RnCh2yjk
 fX+Ou2E4S3+IbjW5xjCo6LA93MxhOkaVT+aGELqG2JW7SjSVOFePUaN/nePSqwBD
 z9uiY1RPSopmmh18NddsDDwdyy+HOQQ+msKLEmCi4eFULfrtLjMQn0pZW5Lt1bpS
 mQa0g4xWq0amWGNpoEvLOhwZdH+7roQ1fJLxi7lvQaoCmEWHUJvs7AMqNJRDQ1a7
 s7HWCpT2sBMYH0Z9ao2fqsEJzOX8KmNupyJ1N3sD3bq+XV4UCu8RfPGVroKz3QeG
 QRzjjAElVNz8TC7NZwI2geOYNsRB4uBn+fmwDxRGaaAH9TZ7SnDfrgtb40ZygyG9
 O6Rxphkcsf3vUA==
X-ME-Sender: <xms:-oeRX0L54t03OH0dRC9S1vTsYa3h3GvAIb6rH4iuSxv01MPt1UodIQ>
 <xme:-oeRX0KJY7LTWtHwbE3cVCOXvn40adtoj7u6VqXcEs-O3LobffbFTLOLoO-E91aXS
 7Pr-ZzzzImDB67eMgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgdeivdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:-oeRX0sV6x0w5eF1Ksd7geKtoJcXTY1JJuQUsjZRL57jCE_CZhj_fw>
 <xmx:-oeRXxbfQOJFhbB0s71m1D2oQnKB1DWvW5z9ccAIlnqipAc0clKYZg>
 <xmx:-oeRX7aEmJYt97CCgYAAG9xXa4L4g1e2SWAURVZCwGSmzfDPNylfcg>
 <xmx:-oeRX2wEFJqYIOIWCInoymTOAxoRX0m6Gvfaku6eoBgT6S41aWMBDg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id F2D2F3064610;
 Thu, 22 Oct 2020 09:24:08 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] nvme: fix queue identifer validation
Date: Thu, 22 Oct 2020 15:24:04 +0200
Message-Id: <20201022132404.190695-3-its@irrelevant.dk>
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

The nvme_check_{sq,cq} functions check if the given queue identifer is
valid *and* that the queue exists. Thus, the function return value
cannot simply be inverted to check if the identifer is valid and that
the queue does *not* exist.

Replace the call with an OR'ed version of the checks.

Signed-off-by: Gollu Appalanaidu <anaidu.gollu@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 5dfef0204c2c..fa2cba744b57 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1143,7 +1143,8 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
         trace_pci_nvme_err_invalid_create_sq_cqid(cqid);
         return NVME_INVALID_CQID | NVME_DNR;
     }
-    if (unlikely(!sqid || !nvme_check_sqid(n, sqid))) {
+    if (unlikely(!sqid || sqid > n->params.max_ioqpairs ||
+        n->sq[sqid] != NULL)) {
         trace_pci_nvme_err_invalid_create_sq_sqid(sqid);
         return NVME_INVALID_QID | NVME_DNR;
     }
@@ -1398,7 +1399,8 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_create_cq(prp1, cqid, vector, qsize, qflags,
                              NVME_CQ_FLAGS_IEN(qflags) != 0);
 
-    if (unlikely(!cqid || !nvme_check_cqid(n, cqid))) {
+    if (unlikely(!cqid || cqid > n->params.max_ioqpairs ||
+        n->cq[cqid] != NULL)) {
         trace_pci_nvme_err_invalid_create_cq_cqid(cqid);
         return NVME_INVALID_QID | NVME_DNR;
     }
-- 
2.28.0


