Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4F1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E2F206C1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E2F206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaG0M-0008GQ-J1
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaFwP-0003Sy-OA; Wed, 04 Nov 2020 05:22:57 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:46725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kaFwN-0002Gz-Jg; Wed, 04 Nov 2020 05:22:57 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 07168AED;
 Wed,  4 Nov 2020 05:22:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 04 Nov 2020 05:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=CAmto1w6XHX6Q
 WY+w0wNuJJUjSX8ez69FJ/6/YTcfcg=; b=OUt8c+lo36rinPl393LlU9W1imcgp
 eh8bumuMuVjK11npgDU42NRFwZJ7CLYEGaaneNzcDLTkS9wci0TnRrHazxCJGcxK
 ruNoCFnDMC3713hXuFMrRN7R3VTTn0FTWPi9a55hfdfyIPKnK8IutR5wT8S0LcOl
 aWmAO48T8g5jBsRDBOsGKBV8rJXAwfIUY2HgD8pxBK53IopCj9Id6cggnSAhVUrL
 x+Fl8Rnem0vDnaTLgIpnNLSH3hSAymlceCbDb1DX44+xBie2G3r4440ECwInbneO
 68Z+tz0oAjiB6uI2FWbzUGr4CE9jIcNNvIoLDTHPvkiQbOs3u0pcQAg7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=CAmto1w6XHX6QWY+w0wNuJJUjSX8ez69FJ/6/YTcfcg=; b=Sdj8VjSP
 5VBAkZQkXinyNMJ0owAASryyLqpYJqdmTTQFUZEQqdututG4mebMHFgr0fLSje3b
 D5i1AjxzIoVRAZIqhrSnsRwcCnfqXYV3DGbVObVdsMXTlbSWpS+vI14mGf6/LChL
 muYo/ryJ4MfS3kUcnlwLhujI4qX1+1fdSSAaCIrkO4CDg9CFFacWyuEclyEgywQB
 oqMuBMCeNaKfy0OjuxotHs+IWhAldiYyusKNdvoXnni8YZ9jU7OWbINtN3xzdk7b
 1PSQQ1e//5yJruBmEJh/+1IubRrIoc3Ua3iyElHK8heceVrJc96NkpH1amiKkN+S
 Hn8IhQqyubU1mg==
X-ME-Sender: <xms:_ICiX4qxo11exWde2TUnSXjtbLzxg7VxmxywBjVChvI_DAYGQygeeg>
 <xme:_ICiX-qvYo9flsx7GXHEJvo8LJoUfoWjcW5b8FaSR2ba582cMGfghLJ8MDWvBr4u6
 EdhmoB3dI6fssNXASo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddthedgudeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeeuleetgeeiuefhgfekfefgveejiefgteekiedtgfdtieefhfdthfefueffvefg
 keenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:_ICiX9N6KcYMJOj3oVbwt3micucXJBMUg_e5J8qVzWxVCTpWn3sf1g>
 <xmx:_ICiX_5Jah2lSL8g-hujfREt23gIkvUlLUnFoA4ebTI4x3375L-LzA>
 <xmx:_ICiX355J7tH48thwpJ3JtD7E_ndrnWnO6NSyejVfbCo51iw8vVObg>
 <xmx:_ICiX6YI4JXWMGa8yEDftljLkULWiFu0IbUWypakfCO9IyPAjJuL5A>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 209793280390;
 Wed,  4 Nov 2020 05:22:51 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 1/3] hw/block/nvme: fix null ns in register namespace
Date: Wed,  4 Nov 2020 11:22:46 +0100
Message-Id: <20201104102248.32168-2-its@irrelevant.dk>
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

Fix dereference after NULL check.

Reported-by: Coverity (CID 1436128)
Fixes: b20804946bce ("hw/block/nvme: update nsid when registered")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fa2cba744b57..080d782f1c2b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2562,8 +2562,7 @@ int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 
     if (!nsid) {
         for (int i = 1; i <= n->num_namespaces; i++) {
-            NvmeNamespace *ns = nvme_ns(n, i);
-            if (!ns) {
+            if (!nvme_ns(n, i)) {
                 nsid = ns->params.nsid = i;
                 break;
             }
-- 
2.29.1


