Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D1DC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55083238D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55083238D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKe70-0004rj-84
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvx-0005rC-P4; Tue, 22 Sep 2020 04:45:58 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:36781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvt-0000uT-MS; Tue, 22 Sep 2020 04:45:57 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 9F6AA5803D2;
 Tue, 22 Sep 2020 04:45:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 uZTCOwZBmQJ+vcy34pRVZzDnBEYW3yz7+LNT9Yctx1k=; b=XWtMy1l/ogggAM7b
 oppF59IPyAh1oS9Xall5n0dF1p5zMbE05qDqGhzi57631gRcxkcFE3Md9UQUJ2/x
 m+U9xi92d92HFuXNZhDKBl3VypHRZzRm2GtlyLeUe60CbPvbcMVFIcOuD93dAcp8
 YJda4smy3E7K66fDu/sygpfzbwpqeLGLs0KJlzPE07hamoYf1LtbrFF7TIFHklLv
 duACp87OcBpoMF+C9wyYiYyev1yt6i6mqOJKYIYGtrt0fd4TbjM7LTo+qsVPU1Zz
 3aUxbvDPDBJzbgIJlQQ1//RdfQb1lWXHbF/XFRXftSWMTEElwcWQPxAPzFDi+P13
 efysNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=uZTCOwZBmQJ+vcy34pRVZzDnBEYW3yz7+LNT9Yctx
 1k=; b=g45UtKuje8L655A/3m5AdDDqXcCMot8aMVCfWerFfCC+bHcDet6wDrnhE
 AU9zAOiBiy09ECOpglkNRJC+9Z+GFGG+mcVDaSf4GFWJpRXjiD40G1TZoroi4dmO
 Oy7LyLpBwqKgR3uN+/+6P7cDblWDqhkbpzM2KAFK7Qgghfk67p8WnglLBUpgPx2N
 bKjsnB3qAXsHWtXDZ+EtZyXAhj8H/bJ25ll7SdVVxNLRWbg0ZOy4Ss6iPMD9++X/
 Fics0cnx/HjK33jgulUm29AuaukJc0msigH+Q+WdyVXRJlsI7PvIqNwYJ1CoxF2c
 tK0jLhNc9KrQvHrVKASNMNXQ0YqPA==
X-ME-Sender: <xms:v7lpX_Md-FPEQa4nc-pPAROK4qczXyt_OnqJ8Op7Gxt-ztLLL3LJfA>
 <xme:v7lpX58uh0kMMAWwMUFMhaWZiOVOVRuu2-YXl1alq28tH2iIm2QHzIpPLBiJuSbGO
 eBhYCMiDZ7-psgXEq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeefne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:v7lpX-QLZpaCrcswLrLkIqYYitfomugt-h75fKV0lxaNnGGSpmk39Q>
 <xmx:v7lpXztUNatISyKVMILk1-Hz-fi25V9-7nwtFpbz5JAmnDPpmkmZPw>
 <xmx:v7lpX3ejCdxd_cbY6uF7bugHnP7ilQILWUlsSFpJvzNs2PkipDZ_qA>
 <xmx:v7lpX2y1_xbhLeZtq5BHZZrEH7pPEcEmKn9KBN8dqhVaTCZSGgVJUREjeZc>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id C7F07306467E;
 Tue, 22 Sep 2020 04:45:49 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/17] hw/block/nvme: default request status to success
Date: Tue, 22 Sep 2020 10:45:26 +0200
Message-Id: <20200922084533.1273962-11-its@irrelevant.dk>
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

Make the default request status NVME_SUCCESS so only error status codes
have to be set.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index aa13809eaab2..7c9ea792483c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -230,6 +230,7 @@ static void nvme_req_clear(NvmeRequest *req)
 {
     req->ns = NULL;
     memset(&req->cqe, 0x0, sizeof(req->cqe));
+    req->status = NVME_SUCCESS;
 }
 
 static void nvme_req_exit(NvmeRequest *req)
@@ -546,8 +547,6 @@ static void nvme_process_aers(void *opaque)
         result->log_page = event->result.log_page;
         g_free(event);
 
-        req->status = NVME_SUCCESS;
-
         trace_pci_nvme_aer_post_cqe(result->event_type, result->event_info,
                                     result->log_page);
 
@@ -626,7 +625,6 @@ static void nvme_rw_cb(void *opaque, int ret)
 
     if (!ret) {
         block_acct_done(stats, acct);
-        req->status = NVME_SUCCESS;
     } else {
         uint16_t status;
 
-- 
2.28.0


