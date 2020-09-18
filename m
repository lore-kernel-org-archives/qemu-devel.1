Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C8C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3C1222BB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 21:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3C1222BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNyd-0001U1-UY
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 17:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN83-0005Hd-OQ; Fri, 18 Sep 2020 16:37:11 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN80-0004zm-58; Fri, 18 Sep 2020 16:37:11 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 8BA9158015F;
 Fri, 18 Sep 2020 16:36:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=oTmjeX5NrZ/Am
 /nSxt2dbO7kocsLPRIC4wXmzsR2j1E=; b=FhUKRdE8+1IJkMRGYjDiKs2O2YJpI
 spenj6CtXxARlDDrpkOlZOgZ+oYoISc9urDl6hVRd9fmBk0Yt4Zher9h2xjISR0Z
 1eq4lP/AGxIFyZYGWSiIXoPYdtWOc5HcHKK+z9DEoJqIng1ZdAMMmFmgOpNFVbvH
 15qcUsw2ST6MF/n7hyFy+JruExAJtGKNwMug9j0PRaMiYB20+Pson42W9/q7JQRj
 0qo8dnCWbwLEejm1s43rl2hQU9v13XZGDeojc8RA6Lg78a8liaNW0FWAkXS4aP7d
 9t+Flc+aFKO7sQdMQfC2Z/iPG959jkJb2NEx7ZFJNocbX0opLaS+ivSfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=oTmjeX5NrZ/Am/nSxt2dbO7kocsLPRIC4wXmzsR2j1E=; b=qvLyCe71
 7suGq5OHq1pZEdASTENNYG+MQqn4s3SVYCqpwzlDB9zPsLmzDF53QkL2b/RRUhoT
 cF/ghiPXowJC5CBj5bQfcVfqKLIkztM3E4ug0zQhfUkqnSxzhEe7LNB1NDDkt6Av
 dJee6Rl+ep1viAuT9jPrg9gNR7GvQn4hJhVVOG2PyPUIHbeo0CxWT/MBejqtapJv
 k4K31I8PecP0jqgWsIX5kIrkZXkvzK4eo4U4o5L7LX0J+FSSOSAsJjur4vfIOqly
 dhjx6be1Mv3OICKhUzFhtzbJ2VJbLTA9hCeJkQ//98DvJS/6kKyifx0QX+e2VWg2
 Qf8ZBJ6JpuW8QQ==
X-ME-Sender: <xms:XhplX_NJUjjRNl8JoKDnXQldWvxZY53WXnfG4gwYy_lbCzV5HSj5jw>
 <xme:XhplX5_qcxfSioNJNrNUiQp9G5bX4hMhHoD-EXQAVuYg4gybk-EK1rpAq3qPSsr3f
 V2qFbd5uBSjFjPPHew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeejne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:XhplX-QXGkU2xd47P0FS0MIN8tOfsQJYU02ei2B11Gcif6T2tdtirA>
 <xmx:XhplXztwpuC8qBaMb6T9z18nLPuL45SMTqLy__x9hYA3Xl2Pi0-3Og>
 <xmx:XhplX3ePWgy5XT8fZu9b6ejcnVkeNFP8C4BZahGVNkQ05uHzx94SVw>
 <xmx:XhplX2zBzko5-1oS1uPKDNWSoFxLNCBGsl8-Pho441XnMoyq9ikdi8HNAdk>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B48CC3064610;
 Fri, 18 Sep 2020 16:36:44 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/17] hw/block/nvme: refactor identify active namespace id
 list
Date: Fri, 18 Sep 2020 22:36:18 +0200
Message-Id: <20200918203621.602915-15-its@irrelevant.dk>
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
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Prepare to support inactive namespaces.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d2e211c7cbc2..f533eec55c5c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1471,7 +1471,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     uint32_t min_nsid = le32_to_cpu(c->nsid);
     uint32_t *list;
     uint16_t ret;
-    int i, j = 0;
+    int j = 0;
 
     trace_pci_nvme_identify_nslist(min_nsid);
 
@@ -1486,11 +1486,11 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     }
 
     list = g_malloc0(data_len);
-    for (i = 0; i < n->num_namespaces; i++) {
-        if (i < min_nsid) {
+    for (int i = 1; i <= n->num_namespaces; i++) {
+        if (i <= min_nsid) {
             continue;
         }
-        list[j++] = cpu_to_le32(i + 1);
+        list[j++] = cpu_to_le32(i);
         if (j == data_len / sizeof(uint32_t)) {
             break;
         }
-- 
2.28.0


