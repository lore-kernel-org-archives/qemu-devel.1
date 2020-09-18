Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00360C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02774208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02774208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNBK-0006yJ-EI
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7a-0004tu-Ht; Fri, 18 Sep 2020 16:36:44 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:44993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7Y-0004yx-VS; Fri, 18 Sep 2020 16:36:42 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 2CA63580226;
 Fri, 18 Sep 2020 16:36:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 jAOuhAAf23VmKCf10RNUPVfZ5x/ccJIQFO986jexd6U=; b=pEWNLFFqqcxwAGvx
 289XpvY9Zf4EJ46zyvZRNp/T5ydw5UgQmemYO1m2CrBvUZCI5R9qvdHax+ial2Fo
 UZqyRQViiYjD7kNF6ubofAxHJRMSDJzCmrWcro1hn+3EXkz0xmPFl4XuS/NMnzcn
 R/G7hidoZZFIiRYpQN4rFEliifOGQrcYX43nuDiBuxVGLNKyR2iY1BJLQVRXDOLi
 fPKBqLyzqlIZytw6zGQsnj23KQdoxcpvLnbTR9Gm7w8jDPLVLtb8EGj7f0S+HFKc
 nPrfWs3BT4HRHGNt8xAsmQIUCcahVmObHX3B0R4Ye7+E7hzaR68DD4uDI3jKUjYD
 NcQZNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=jAOuhAAf23VmKCf10RNUPVfZ5x/ccJIQFO986jexd
 6U=; b=pxU9NiHCt6wrYB11nr1q7JgUkw8lQIJ3fKdFLnJD81uqEmwEEpaCYBGAr
 AeyBpRnvvHrjYxp9BmMwLRq4psgBY8ZFqdnLD83Yod18FXQuc/s6xyJ3RrEUgFS6
 XXBmaF86YBDJjAb3BKdMKqZS7Ip/nksplMMIfL0/h9dOZ2j6q3pR5JgcnZdogwDH
 ws06dFfKfMwCSx5+C/3V4iA+lZp4I6c7sZXzgJbuwWt1ZgL6tNKMPRSfkl74NtTa
 ROP+STFQnfkHnx6MtVWf0m0fajowr6wB2yw9u7mmPAdOP8sBsYkWTDs452ynCtpD
 falMLItAKPcFi4dIaOwS63rmF64VQ==
X-ME-Sender: <xms:VxplXzHpP7UI1EBWIH230YFnjGvb356MkQS4NhLg16Xe2G7hhnAl8g>
 <xme:VxplXwVs2lbOhpp4FsqleviPtkVG3-ZXD32kBBLxEAidrJWgsxpf40ikgSB4fHALK
 ymLn8MNTvzHcLmW_yI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepteevuedugeevieehgeeileeufeetvddtkeetfeelgeehudfhjeeuledvhfff
 tdegnecukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepvd
 enucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:VxplX1LUCBq5JSPXJAcEbwMy9afsg89cD9moWlaVi0WRPUriT5UAsA>
 <xmx:VxplXxF__yAbWxIzpu-YvTyt4Xn-tQPNH8gSJswPK8KeQ9UubULyZA>
 <xmx:VxplX5Uk4rY7sNMLbm5jZIcH1t1g5F5O9l1sdUds29jsBUx-mxGcUg>
 <xmx:WBplX1p1vdpNAjXGE-8Abl7tpOpj5qkhSgEYpxLrVZmXNxUroS1CFs44bMA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 619513064610;
 Fri, 18 Sep 2020 16:36:38 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/17] hw/block/nvme: default request status to success
Date: Fri, 18 Sep 2020 22:36:14 +0200
Message-Id: <20200918203621.602915-11-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918203621.602915-1-its@irrelevant.dk>
References: <20200918203621.602915-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 16:36:27
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Make the default request status NVME_SUCCESS so only error status codes
have to be set.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/nvme.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index e6790c196d2b..7e6cbd3f1058 100644
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


