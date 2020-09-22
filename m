Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC7FC4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE59B20715
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE59B20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeCT-0000Lr-HY
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdw0-0005tM-11; Tue, 22 Sep 2020 04:46:00 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:41185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvl-0000tP-I8; Tue, 22 Sep 2020 04:45:59 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 24D285803C0;
 Tue, 22 Sep 2020 04:45:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=NCZ0yU1BHKJ39
 xtbA7A7+hI0+r/uzZG/WiijkYTCOcE=; b=jtjPygDTxF3Ca52dVgfZFxO+W2TrE
 cyCzdmY7FnJlLKFnYd7BqNMaGsFkuloCGMbb9wCqDxBaJ14F6CnbDxgkWAYig5i2
 dQTbTqqEv3yMUP0I0TqFlJkSA3sE5feJ6NuG22upL9TfMr6Z+fEs4O1FRJpKSOwD
 eJKMXrhXR9oQM+LiUgTGXsqZG4NAlKjJTB29JEmRMRNXN+Rsgh4NJgrnj1X4bMNQ
 M3j6NyBNq5fxSF63NFyjjAqmjH0f2ehKQ7Er0RAk63a0LABQ6s2csEHV2cE+bpTM
 pzEhtMjPRJPza8crRwwv8ZUjUkDBh5q0gdhZQo7QiEA1CRmNqkCavzH2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=NCZ0yU1BHKJ39xtbA7A7+hI0+r/uzZG/WiijkYTCOcE=; b=niVj0881
 jUwdaZNcnMbgGjC6RrpH+XgS5UvdZ6WmZl+wUgsBR3l+/Adj7B9RzHJYGOYskDvM
 sxKGqsik9XzUAv7HPl6qR4a9V/oaCw/8fciIhheR7BnkA8QY8iUyCh8m7KCR2V0y
 2Ho5Bk1TM8wqKGcZjVKCEh+im0HYHbxlePkqfNhtWjHl6DhxS3cCTmTKMZDvoFma
 ucucp2FhjuYwYUkUGRuzEDgtK3nA1EYeUZ5Qula8eVKNoIeS8BjmuyVP5Jxh6skn
 PucVc8AfKR/Seea9nKSzXwuQM6krM6o5NItgyG7TNf9/F8ZtyzD577WmYsRoFrg1
 guyvADasfSD+CQ==
X-ME-Sender: <xms:tblpX5SF7R_YWfc9RC1jJYGEJA-1uxj8LwDSBTEjBRMsAS4M9sQs1g>
 <xme:tblpXyz0isLqWvGoFcKm3ElO9IY0MBNHqzDg2phGf6C6Q0kHa9A72UO_si5EwR-_L
 _H8WEEv4OTYtDciEpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:tblpX-3WeeSUBQVT8BLlCf_hVZ-qGtltb_ZgCCV1f8Fc1lH_jAO0Ww>
 <xmx:tblpXxDdWKynF7DcwRIDbkKLeyi6Hjl_MiypepLqlxHEuOBWlaLkXA>
 <xmx:tblpXyhEdh8vJG54WGhsXGgiwKZ1ffj0P9UQgfSSoBP9mvvumV9olQ>
 <xmx:tblpX2jhiZHKuL9i8xESbaoQitvo_j4F2OfLI3NYklhAAUSNeaMR5w>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 627033064610;
 Tue, 22 Sep 2020 04:45:40 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/17] hw/block/nvme: commonize nvme_rw error handling
Date: Tue, 22 Sep 2020 10:45:20 +0200
Message-Id: <20200922084533.1273962-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922084533.1273962-1-its@irrelevant.dk>
References: <20200922084533.1273962-1-its@irrelevant.dk>
MIME-Version: 1.0
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
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Move common error handling to a label.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 744ff3d86c22..a76a6464d6a1 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -687,20 +687,18 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     status = nvme_check_mdts(n, data_size);
     if (status) {
         trace_pci_nvme_err_mdts(nvme_cid(req), data_size);
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return status;
+        goto invalid;
     }
 
     status = nvme_check_bounds(n, ns, slba, nlb);
     if (status) {
         trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return status;
+        goto invalid;
     }
 
-    if (nvme_map_dptr(n, data_size, req)) {
-        block_acct_invalid(blk_get_stats(n->conf.blk), acct);
-        return NVME_INVALID_FIELD | NVME_DNR;
+    status = nvme_map_dptr(n, data_size, req);
+    if (status) {
+        goto invalid;
     }
 
     if (req->qsg.nsg > 0) {
@@ -722,6 +720,10 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
     }
 
     return NVME_NO_COMPLETE;
+
+invalid:
+    block_acct_invalid(blk_get_stats(n->conf.blk), acct);
+    return status;
 }
 
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
-- 
2.28.0


