Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E73C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B41F207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B41F207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTUY-0007ng-Oi
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXTE6-0006DP-Tq; Tue, 27 Oct 2020 13:57:43 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXTDx-00075c-BF; Tue, 27 Oct 2020 13:57:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 8360F5C00DF;
 Tue, 27 Oct 2020 13:57:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 13:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=7fbCF8UgD7UyW
 bwuqMC4pqgRmpsClM6uykXqiD6I41s=; b=VktcJTNYjjSb6iECHPotwY9lIBYyT
 zOI17Q6vuTTkvw5arg9t7m6vpx/x0lbyY3QKSepoMHP7pvBtu0ar5nIXSMXStero
 rjuMNlUnArzNz1jwhHvhuBuIr9E+QhySd/Zc3coz+DjZBu7W5jhrME5R1DzCx+iR
 e6j5vJDXtVXQ/cik9X5/g8G0luqyn7PPgqc99Zn9JfvDzp6gd4dCBQS/L+Iwxv0F
 ZcIi6IrTUWJTDifaRvY3P4QzEMhV8zZ7IbY5EMy32f7uBdMIMt0gpw2a1XphOTnP
 5kqHvS2YRWskUzCam3fzeTUjgBKMkKF5CVuzDrKxhjtwXmKfL032SUCPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=7fbCF8UgD7UyWbwuqMC4pqgRmpsClM6uykXqiD6I41s=; b=MCseFc0C
 lftAiEnfwNHqgMnvxE0lG7r8fwk89CL6VQwHxdAjAaESbFxxuUQVE6bb2oBf+yJ4
 xzu98ENWXc7xfggspAProipG+CHhgLGDUchGLBjRrY3W/1kRVDPGB+uwt54XaOrg
 9wOuyIVM75wejDES6akHZVL2tRpiE3Dm1fIoYw23pVkjwGKXiJT0pVsqUVKlmZ/y
 vu+4Aoo2CFwKYOwHoHDZXdLR7/uxqukKxFZoEn2goIYeeWCqed7rKH4HiV1RhG6W
 OuvbiQ/EtxP0WYFq27K7DMq40jOIWnG0cxvDR5bz73+h+w79mco8W5BACt5LFaxM
 y6dwnY+u+lfMuQ==
X-ME-Sender: <xms:i1-YXySyXR4znbLUrVxiWaYh-k8-wyhvc_hDTA-pSosNB1vKAr8xoA>
 <xme:i1-YX3xNF9WXvT-dEH9-7dSdvL1e5Zr2Cznrcp1zdLn5S_AUAoRmNquz2GijjA3Fi
 vfUDVuWCrhFo1A8YvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddutdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:i1-YX_29OZib6DIR0MaLe0xXZ12xhulECqIZk9VilH5SO6WN-09rcw>
 <xmx:i1-YX-CeZoEHOk0CCsoO5pZWl5WtqutxJOtEZ4fK1jzeqRBnkp6B5w>
 <xmx:i1-YX7ipMj6UauB5myPfURDsOWxBinWKFbHhhjNbxxsENojKbJW1vw>
 <xmx:i1-YX2Xo61TMdWeFdyBfjwjSbyEq48hnxO2xAuQH7yORyL2NJs5udw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id D2BA63280068;
 Tue, 27 Oct 2020 13:57:29 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 2/3] nvme: add namespace I/O optimization fields to shared
 header
Date: Tue, 27 Oct 2020 18:57:24 +0100
Message-Id: <20201027175725.586890-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027175725.586890-1-its@irrelevant.dk>
References: <20201027175725.586890-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.28; envelope-from=its@irrelevant.dk;
 helo=out4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 13:57:29
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

This adds the NPWG, NPWA, NPDG, NPDA and NOWS family of fields to the
shared nvme.h header for use by later patches.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/nvme.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 966c3bb304bd..e95ff6ca9b37 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -990,7 +990,12 @@ typedef struct QEMU_PACKED NvmeIdNs {
     uint16_t    nabspf;
     uint16_t    noiob;
     uint8_t     nvmcap[16];
-    uint8_t     rsvd64[40];
+    uint16_t    npwg;
+    uint16_t    npwa;
+    uint16_t    npdg;
+    uint16_t    npda;
+    uint16_t    nows;
+    uint8_t     rsvd74[30];
     uint8_t     nguid[16];
     uint64_t    eui64;
     NvmeLBAF    lbaf[16];
-- 
2.29.1


