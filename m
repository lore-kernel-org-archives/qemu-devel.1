Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A4CC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3151A22263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3151A22263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXN87-0006XJ-U6
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYr-0000mT-9A; Tue, 27 Oct 2020 06:50:41 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYo-0002IQ-Bg; Tue, 27 Oct 2020 06:50:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id BAE285C019B;
 Tue, 27 Oct 2020 06:50:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=SISRIiTiJ04qh
 VkZqclSVn6Zo+nvig2yOnxM/rx97o8=; b=i6bwjCnygRIPcpzBDMezCp6gkyI8d
 pbdrfldh+GonQ2DCn69g47ynP1dBJ5ssxo07mX3oHEsQ0sLLn+kAS0Tvdb7fE36B
 9PFlQ2NcYHmsgppSKcVkmui8El5sOtP8I1zHoL6jSIO0FrwsdMSN3JBtbVoI+amt
 LhgMw31ENeCTx+RtyyiqvYsFTUbra19dMRAN1eft88hgzf8OpiXBMdJVFRTxF0+K
 KBqgNDga0OLaVQvuOpEK4cyLqcqvAMVDZhVkB9l+u4VC8qnldc6OsPFGUsM5GSZj
 NdPsNZqTnfbDhGwF/FNUGsgcvgph5VSAuacUXWSeqHg4NORXXYfxkIPTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=SISRIiTiJ04qhVkZqclSVn6Zo+nvig2yOnxM/rx97o8=; b=iU5tD9PE
 hBpS7QDPT0dl6XxMFAhZYdbqn7DHzcct1WYJK+s4KSBvchBPziQFK3gb+wJqJTXO
 APBJUqVwAF0KPd0FW/Q3K9UWuvKWmbMoH9bdzL1xz2GU2y6BHBBP0sr3OwobavL6
 DzHBAiTx10SRrkKENELB3XbjjN1rOpMKoDmog0uPb6qHhSbg+F5ph06h3Q1MiQW4
 Z/tm2lWGnPnT7VWmoJ01mfCQpJK+hs5nwAT/sNITG7zR545GsxTR9SIhkqW2+TFI
 2VpLsef7dJ2M38cMq9gNFb6pNUA1Xo1e8saa6Sg3KQsKtQ8Oo+vmwGoCDCMw4tKd
 cDqy5Hl5Bth5fA==
X-ME-Sender: <xms:WvuXXwLvSWnyY92ZVUjq05e6_ejNWAhrB3PO8VoGWkJoYc_oAavbHA>
 <xme:WvuXXwKsBJvzkMeh5seGlWe59m4CQa19u9cKNKpAu5nJc6m_6aahqEKsvv6W_gtyE
 -klBDFnWFQf_d3unhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepuddtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:WvuXXwthv3h4ylMLdVvZDk0P8p1rbsYPNMpXwQSrIMXAuJ9cQNg5ZA>
 <xmx:WvuXX9afs58D3oPfXnRgkxDSPLgYOAIlgV6k8dXWAjmFyHz09BTWZQ>
 <xmx:WvuXX3YWoYqSsL-RznGpEvymuwqkR1pYY6cC7SGKaOvIc7jWGl7QhQ>
 <xmx:WvuXX2Xy5BUSPbDsXo5NNZnxUcX08VvHbimuPNqrb2yXTWWDf_jEWQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 32D123280065;
 Tue, 27 Oct 2020 06:50:01 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 24/30] hw/block/nvme: reject io commands if only admin command
 set selected
Date: Tue, 27 Oct 2020 11:49:26 +0100
Message-Id: <20201027104932.558087-25-its@irrelevant.dk>
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
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

If the host sets CC.CSS to 111b, all commands submitted to I/O queues
should be completed with status Invalid Command Opcode.

Note that this is technically a v1.4 feature, but it does not hurt to
implement before we finally bump the reported version implemented.

Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/block/nvme.h | 5 +++++
 hw/block/nvme.c      | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 521533fd2a10..6de2d5aa75a9 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -115,6 +115,11 @@ enum NvmeCcMask {
 #define NVME_CC_IOSQES(cc) ((cc >> CC_IOSQES_SHIFT) & CC_IOSQES_MASK)
 #define NVME_CC_IOCQES(cc) ((cc >> CC_IOCQES_SHIFT) & CC_IOCQES_MASK)
 
+enum NvmeCcCss {
+    NVME_CC_CSS_NVM        = 0x0,
+    NVME_CC_CSS_ADMIN_ONLY = 0x7,
+};
+
 enum NvmeCstsShift {
     CSTS_RDY_SHIFT      = 0,
     CSTS_CFS_SHIFT      = 1,
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index c1323ca869f1..32c35fe58768 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1026,6 +1026,10 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
                           req->cmd.opcode, nvme_io_opc_str(req->cmd.opcode));
 
+    if (NVME_CC_CSS(n->bar.cc) == NVME_CC_CSS_ADMIN_ONLY) {
+        return NVME_INVALID_OPCODE | NVME_DNR;
+    }
+
     if (!nvme_nsid_valid(n, nsid)) {
         return NVME_INVALID_NSID | NVME_DNR;
     }
-- 
2.29.1


