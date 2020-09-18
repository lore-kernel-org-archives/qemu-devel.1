Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E801FC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52774208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52774208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNBJ-0006xp-3D
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7S-0004kI-Bw; Fri, 18 Sep 2020 16:36:34 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7P-0004x1-QB; Fri, 18 Sep 2020 16:36:34 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 05B5E58020B;
 Fri, 18 Sep 2020 16:36:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=D0XyVoNRNmtZK
 VNk6B38iosg8D6Qv923fPQFXcdqVYQ=; b=CW9Ny3gJa4oOv9Fd18H/5HTQaM7D7
 BYwBLFCAHGdybI0XLMZDpLYDFyZeyRBgkeSzTpj3AQCFHoosvPndVI42MRxUOUpY
 Ev2jNSGzBJbxDr4DgqUok4YodWZvl4T8oFmiORgyYovNZt8hB1/lg+6BwENleJhX
 k4GWeViNxAXUcBgEpyMwBRPDB5GdfL3Dq42Ftcf/b8u0oEdFYR8fcmhNV8XCh7ir
 sZoOoljGFdGdYzffYbWHC0sorsP/41NJdr6yFUEsDl5cxUW21NWuiUVsTX6tpAWm
 64O95lT9ozOK5Xg5/PtnY/QJz23R8MwYm0jQCvYe1+NjqT6i+1WyvZyKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=D0XyVoNRNmtZKVNk6B38iosg8D6Qv923fPQFXcdqVYQ=; b=n7aCzyBu
 lLMOb3vbSZK25cg6xSwdJUX0bP6pR+XsPGHsvJVGlvEbzp+3xkvJwPUnsKqJnMfQ
 CIaHP2yZbanK+19rN3LJYSutmP3vuR/6kXKTQnq3nroDSjPJLIlsM2Pn/vonBJ0L
 Rd+WFGbXvOe0nKpxEnTKid3X1hz0nwSI6RWq/X3+rZu3h2KvOKXuLR7Hoypb1J1C
 iXnv9Wje4JFhqOWKkiAnc/CNbd1zBq+GtvGPvTOlbFqk5/auD0DJBKW8EVSR34at
 ckhDK/KmNz2HZvOcQQGKPNQW+EFS6KIXlI6HsQomfc5/HxvWLbEFxpAlZWT86aBO
 am69IA+RpBZf3A==
X-ME-Sender: <xms:ThplX1-GEyJ8h2IxY6qhrb-ebBi9LodV9Q_Y39KLh5rKg7s8lj5c3w>
 <xme:ThplX5usk5aLkvX3bAvNvMp9ioA3Tn3a2-dQ0laoNSd3pWLKWlPd1q7OZ2WV5OyVz
 _cDDyUz1wKz9RDYSvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedvne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:ThplXzAYOEo42UzUWTtlcPLSTkrh9lemj6iEtmPRmD-niLmJOFoYtg>
 <xmx:ThplX5fYwDAZHcy-L-esNScURYfufOe1MMWDepRM9zwCVVKD5JF3tg>
 <xmx:ThplX6OmK97odaZDJjCqh8oouYrOP5Iyx08Y5jGNmOI4VHYRNB0F8w>
 <xmx:ThplX5eTfasNlenazLCMyM0XqcdeG7Sqwm3KTZDX-Sr9S1l3g3UVig>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 49A2D3064610;
 Fri, 18 Sep 2020 16:36:29 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/17] hw/block/nvme: commonize nvme_rw error handling
Date: Fri, 18 Sep 2020 22:36:08 +0200
Message-Id: <20200918203621.602915-5-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918203621.602915-1-its@irrelevant.dk>
References: <20200918203621.602915-1-its@irrelevant.dk>
MIME-Version: 1.0
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
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Move common error handling to a label.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 8ffe407ef658..78c3ac80fd4c 100644
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


