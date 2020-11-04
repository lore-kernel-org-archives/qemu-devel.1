Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0063C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F1B206F1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F1B206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaG9G-0005wg-PI
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaFwS-0003WS-4A; Wed, 04 Nov 2020 05:23:01 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:39159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaFwQ-0002I7-BH; Wed, 04 Nov 2020 05:22:59 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id EDBD6AF7;
 Wed,  4 Nov 2020 05:22:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 04 Nov 2020 05:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=Ec7W6yqCDgaIQ
 yq5Zu2HxvoyaH/VyEJWeQB+2zxtbCo=; b=UKOgy4J4AQoH4c/PM7ClMyfbtpyvr
 izuANIygOgdwP4y66UbjrD0sahtbsaMhrB0f0iuFmWGwtsUFC7fo7L8soU+fWdWu
 Wc/WcrekWGh0iluYp6rG1qbSid9d0vg+kMLio5YgV4lAuKfHsvcdSUgkAQ+Yq+X9
 DvKCH7L0tT4jJtV+RuwEaCwiKBWkw+IQRoUjPqX3JV5XkKyzij+4URhNN3ck5Wdh
 x9o1aG7DYhXj4ARGswKIHd2GRdIPM1Y0dp7rVdNxT6KKnxMhY7zKdulz+SIENG1D
 rlS2V53PvIkD6SLuo7VWJbLEeY13SxDVGk4UWZ60emyAeyNM2E6sngkLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=Ec7W6yqCDgaIQyq5Zu2HxvoyaH/VyEJWeQB+2zxtbCo=; b=JLjmsT9r
 QYPvFf+EFhsDOU0P4gHkyhHC0gYmkGF04OsKot8mhWIShyvBqz3NDm2bHp5/ARPP
 ooTcgAJjmULuTyMJAw6WekuoWXdLYlwEgjPKg9ESmp08DyvfGFaLChAaGC11F71D
 WbcXI91haMgfRcZTfO9Go8+ObTo9wrqt6Aw1XuV1vVYxkFlzv3ENqeL/prnqjUdD
 HdpoyIha+y0yVaTZRD39J5c4Y1GeHBWec5/XK0JqI7OWR0oihTSVMRDXAI2lAzcJ
 wNN74wFPOYE5vkORbR8/TLSJ3wb65jAGsYcuA3vJ+MjfPqqDmRr+3QdJ7z1mVIyq
 JVlcQ744P0NYIA==
X-ME-Sender: <xms:_4CiX7_UMH0Bat26Js_jatL2AKk50jqjHXQrXYFQY_X0zfNgUqrt6A>
 <xme:_4CiX3tL-DYAkpEOOAXwvnJnhaFsZ7Uvcaj32JGwSGHpvL3QHvqFQFok_pUsaaiCu
 o02lQtJnJxkZ60VRGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgudeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedune
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:_4CiX5D9TLIgTs5hQol6vIMSpq4PVrmiRXFv0Ls_xqqYkVgOdY2uuQ>
 <xmx:_4CiX3fCOvxwD-cE5oNWxUzMIVOyS01L32uxTWGntanovCftmAYJ8g>
 <xmx:_4CiXwN7s-Ndp9R0pw2hPcMjvtSdjJ8IPz5KKVgq9bLeyxVsYXUMzQ>
 <xmx:_4CiX3eqxyu8qor1ogL0HUJ8W3P07Klj1gRV1YLzCmSkxNtD4kKehQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1A31B3280390;
 Wed,  4 Nov 2020 05:22:54 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 3/3] hw/block/nvme: fix free of array-typed value
Date: Wed,  4 Nov 2020 11:22:48 +0100
Message-Id: <20201104102248.32168-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104102248.32168-1-its@irrelevant.dk>
References: <20201104102248.32168-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.21; envelope-from=its@irrelevant.dk;
 helo=wout5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 05:22:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Since 7f0f1acedf15 ("hw/block/nvme: support multiple namespaces"), the
namespaces member of NvmeCtrl is no longer a dynamically allocated
array. Remove the free.

Fixes: 7f0f1acedf15 ("hw/block/nvme: support multiple namespaces")
Reported-by: Coverity (CID 1436131)
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 2bdc50eb6fce..01b657b1c5e2 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2799,7 +2799,6 @@ static void nvme_exit(PCIDevice *pci_dev)
     NvmeCtrl *n = NVME(pci_dev);
 
     nvme_clear_ctrl(n);
-    g_free(n->namespaces);
     g_free(n->cq);
     g_free(n->sq);
     g_free(n->aer_reqs);
-- 
2.29.1


