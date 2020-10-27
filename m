Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5510C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C3C22264
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C3C22264
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNiD-00032O-1X
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYr-0000nC-Ng; Tue, 27 Oct 2020 06:50:41 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYo-0002JO-DI; Tue, 27 Oct 2020 06:50:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 080735C0175;
 Tue, 27 Oct 2020 06:50:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=lu7JmQcZOw4I1
 V7ibvxCl25CM11aBSCNkyNgQVlyLp8=; b=TpJXW4tenTQ7NxKIvMJDKrCeinTG+
 Waz2ZAqC0dN+fdlcSCG9F8iUDwyvxQbWJvPC/3lc+O2iwE7FzA0QakP4hJ8bsmaV
 5Z/5Cjq1AJmb+pSqLdQdEfcer0MXk+LV4PJmwloJDQhoL8aVp9n9WjdJjDjWvNG+
 H/kF+dgfhc72g8BbioN4Ag5Psn6xryM2cbe1NizXFd0CxRtAovKEG4CXe8ACZ6h6
 x6erMqHf3AZ/BbRYYBh4wbXRQUUytqVihRLNUmODyJSGXcPL7GNHkCdXWgh5mu8T
 1mt+frU9AW5IyOktcsKIiltrAYVylUINZYoXCYoaiLoau6Z0AEcVG79mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=lu7JmQcZOw4I1V7ibvxCl25CM11aBSCNkyNgQVlyLp8=; b=F9lZgACL
 WQKJNJnBIQH4a3t8u8FrtAtOiVvLCRYwljOH1pzghpCPcNm5zWGRTWIDswcrUzXd
 Y5XJOCVPViRDFLZi9pR6e2pt3HHFC2gN0Io6tQ6WgSWYCP60mPUSvJmGQepLxNpN
 pVoNx7Yf/q5+CnRn42dN/X6acSyQ9dWLPKCp8e9nB1XKzoU5ZsGdzy2TwGBOQR8X
 K5S4yOyQ5NKxHt6X/eNMZdnIMSgWwbxoR5PZNuEpfFERd9G+ipmnJwJBqC5zXH7O
 dmGM+BgLQMra6bDWHo6vl1a3Q9Pyl0ejE8o6Db50wiSQIHOefn4K6WvBNxc2L2Rf
 tXvB7/H4K/MbLQ==
X-ME-Sender: <xms:YfuXX2QjNfxqE-4pHdi8BQ31_nD87ryv7P1WV6XIlOT4RNbFJHGfJQ>
 <xme:YfuXX7wFksDplyg0qO6AC7Z9JI2WjjfotkwEsUQ8Bgdi-4yMn-hk-zVYOIMdG5XxX
 WBT3NhfchMSx_Jc5mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepudegne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:YfuXXz2xA3g5vIZIquQoWddxTL3COsyJ9Z1OdeDxiCcKHFyC2CrVrQ>
 <xmx:YfuXXyCx7vngVCUi3uB80YclF4wjfvn23PJPTdXLc1Q4KHLkcWcqow>
 <xmx:YfuXX_juhyMTaKbcPtycEvYCSHRF8FMeVkT4gJpQlIFapzia9uv0BA>
 <xmx:YvuXX_frEO64i3BXu1GJmQzvJqNe05kEyD_r2RlaaBJvDjYJ7KBBhA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id D4FD93280060;
 Tue, 27 Oct 2020 06:50:08 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 30/30] hw/block/nvme: fix queue identifer validation
Date: Tue, 27 Oct 2020 11:49:32 +0100
Message-Id: <20201027104932.558087-31-its@irrelevant.dk>
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
 Gollu Appalanaidu <anaidu.gollu@samsung.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
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
2.29.1


