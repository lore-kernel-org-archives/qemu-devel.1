Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DE7C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8DF221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8DF221EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNJl-0002dJ-PW
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7w-000596-Gb; Fri, 18 Sep 2020 16:37:04 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:48301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7u-0004zC-Uz; Fri, 18 Sep 2020 16:37:04 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id A0F19580228;
 Fri, 18 Sep 2020 16:36:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=NU3i7wZQJ1iMp
 0eJQz5wKZXs58UpNvmKz/fJmjx6HEY=; b=T6Fyv5on5zjJi49aDrYZtXdlD3v48
 wJg3gWDuK/pDdU662Ei4vtgYBLduAiF9UvaqZRWbwI2misf5xLnz+CUSoyXpqxNw
 KZJIgD2cTrIcpdtkVDtZUfJTMjSejBPcbzXpjzWVUDwa9f6qZanfGbQtm+bQ1mb6
 fFsBu64bly2Os9QZb2/6+DiqU2walHjhQB2WA7YTJ8l7DhwkcradbVPjpAYHvqAb
 9u1yMw3anV8SQk/O27TgyWx9Wh1iY2i8upRdOuZFrf26o2SyWrSC2HR8APmJ+rXu
 nbd09mrsXxI2g4mjt7sxwcCMK8YjE5brtjXvZaBN40zAPapesw0aCppAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=NU3i7wZQJ1iMp0eJQz5wKZXs58UpNvmKz/fJmjx6HEY=; b=nLN+GYnt
 vNZzBOUCrHp/1t0XaR2s8H/PF/suBtaowSlhMW4VlEJuSWyZIOuXlG618tag6pmF
 MtmBdHqnIzGULVe5fiHix2B8g2NFewLwLKT5TloRhnrmvtE0xWxf4jmnQc8Wxtgc
 R9SGUfJAHPXID2l65WzhaBpXJ1bgyWMxdGDj/RP4c6VHKgwhU+KRz8ruGVTmp/hN
 RnXzEOmvou3PC6JuJQX0KQnf6rRaM4LdUx8MiPCW9FWSZ12ATZtR0p1vpbFQssYZ
 5nkyDdwWU0/+LEtD0+vEUrJSpun0HKo/WUZmcUjtmPJtgWr7t+6kYL+7O9bcwdsQ
 PNXEp0ksf4AKmA==
X-ME-Sender: <xms:WRplX3UvqTXclcUJ9FRqkzpIye0GG50cfBE0t-qovjGY1jCXqav-yQ>
 <xme:WRplX_luflcpESTos_BPPAtobrM677mj_kzH5O2YkiV1d3eSKC4HExyeGrgQjdB7b
 faBhcGv0hixDv5CYbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeehne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:WRplXzZOdQsaAh_yZsDUirUcRy2fLx35iazY5Boh7Q2xg3y-iKtsuw>
 <xmx:WRplXyU94nd1-3LyZGBdry68kpOb9Fwx6nYDzJVOqy3Fr8yIdxtUgw>
 <xmx:WRplXxkLo_6pwv7SWi2jhIjCoy5zh205Ksqu9y0FQhR7EchtJTLlzg>
 <xmx:WRplX3WpNc_qyFgt1rMihL8E-A0PebOdpjOY4EAO7ByKVbcKAguiNQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id F0A6E3064683;
 Fri, 18 Sep 2020 16:36:39 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/17] hw/block/nvme: harden cmb access
Date: Fri, 18 Sep 2020 22:36:15 +0200
Message-Id: <20200918203621.602915-12-its@irrelevant.dk>
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

Since the controller has only supported PRPs so far it has not been
required to check the ending address (addr + len - 1) of the CMB access
for validity since it has been guaranteed to be in range of the CMB.

This changes when the controller adds support for SGLs (next patch), so
add that check.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 7e6cbd3f1058..a440f6617f70 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -142,7 +142,12 @@ static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
 
 static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
-    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
+    hwaddr hi = addr + size - 1;
+    if (hi < addr) {
+        return 1;
+    }
+
+    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr) && nvme_addr_is_cmb(n, hi)) {
         memcpy(buf, nvme_addr_to_cmb(n, addr), size);
         return 0;
     }
-- 
2.28.0


