Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D964BC47420
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418CE20773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418CE20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOyB-0002lJ-RJ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOu7-0000UV-UN; Tue, 29 Sep 2020 19:19:27 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:56253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOu5-00007n-5V; Tue, 29 Sep 2020 19:19:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 426EBED0;
 Tue, 29 Sep 2020 19:19:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 19:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=1QikJUcbsmo2U
 P6Df439yCuIR8yF+wYrAAq6TthCldM=; b=eCvHv2wCVn0rZRbzcJscUBan3iOb+
 gdrVnzcNOXJcnF3fUWr1cxyXdaJRCtpQW9Qqz8dz2ijvnOncY/P9aUkEyrYZh8ov
 qsgini1gVyrPbBESt3KJLZM2YduCHRRnnr56BFLQ1g3tV/ZimcSrexum63GQFjUY
 qHLU2NlB6dQPhP4QWgGsxyYA54ujtDpzfN0iJwRMionFDLWIn1TlBcO3FovSXiqy
 4ECyDnxte5OGN0aRDBKIxec7lmtFmMROU0mNWSCj4msmSoWQaLnhNWLmyn7yh/bl
 q+aMeHUxPHOak7ig+Jy0KHPF623GEX6BHF7vFTCgYPbB27JeGLQE+5b1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=1QikJUcbsmo2UP6Df439yCuIR8yF+wYrAAq6TthCldM=; b=TOOF0Mv/
 ac9jPlZCfciJKOkWkWXwLMeiEGARZhhyroXN2VE25Jpl50QWivekyvQc9MtIHslL
 8sFS6y50d1Gkz1vTfzGyxvTB8FzCu99TOGs/iE7ITOlYUbVYdkXFPB3G1381zyy/
 sq4Xr2oNZkrJncr8cIgf/7bI9nmzy4wGVnQvePBOUhjFeQp5hKkY/1oQBw5pSq0H
 9HdMGzbyrXCFxRPL6x6/tJNhvHW1WhKqQbibewNv8UTZhS2Ml/3WVyOLhmpc9SwP
 GPSo4cF2DGpyTDIEHGRtNXTuAPijMFBa1nAcEp1l4EpFhe9a5d+nEoVVE/XNNqsb
 4v7tfzRYuNtRyA==
X-ME-Sender: <xms:-cBzXytgR3Gv9ZvP1SgfjptW9MlRMtvm0pJS3z_BKe0bMusTuRXjfw>
 <xme:-cBzX3ewZJXFzuDXi7XVVxdsnKJ81KpzaOz9c4fxXArBjklX-lX6u28bMnGGGsjfp
 FhM_1GWRNEUFOR-h5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:-cBzX9xkfulcx4SkJQO417fRcaEbN5_dBk2wb6E1ZmZIFriSu8IZmA>
 <xmx:-cBzX9MFIgGHdABmMBZcf98Z33rW9uws1eCf1ugvo7afsbxrYiDK1Q>
 <xmx:-cBzXy_Rf6EZVb_0YWgAtpLnr7wYV20GBxkyqB4f9XDyNpUl7DMpXw>
 <xmx:-cBzX5n-_UM-S0pcBWDLg4v--A0z72g2LZstC86389CS0k2w_4VN5_eLDSs>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 64EBB328005D;
 Tue, 29 Sep 2020 19:19:20 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/14] hw/block/nvme: add nsid to get/setfeat trace events
Date: Wed, 30 Sep 2020 01:19:04 +0200
Message-Id: <20200929231917.433586-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929231917.433586-1-its@irrelevant.dk>
References: <20200929231917.433586-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 17:46:07
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Include the namespace id in the pci_nvme_{get,set}feat trace events.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 4 ++--
 hw/block/trace-events | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index da8344f196a8..84b6b516fa7b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1660,7 +1660,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
         [NVME_ARBITRATION] = NVME_ARB_AB_NOLIMIT,
     };
 
-    trace_pci_nvme_getfeat(nvme_cid(req), fid, sel, dw11);
+    trace_pci_nvme_getfeat(nvme_cid(req), nsid, fid, sel, dw11);
 
     if (!nvme_feature_support[fid]) {
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1798,7 +1798,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
     uint8_t fid = NVME_GETSETFEAT_FID(dw10);
     uint8_t save = NVME_SETFEAT_SAVE(dw10);
 
-    trace_pci_nvme_setfeat(nvme_cid(req), fid, save, dw11);
+    trace_pci_nvme_setfeat(nvme_cid(req), nsid, fid, save, dw11);
 
     if (save) {
         return NVME_FID_NOT_SAVEABLE | NVME_DNR;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 446cca08e9ab..5a239b80bf36 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -53,8 +53,8 @@ pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
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
2.28.0


