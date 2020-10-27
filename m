Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F84C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14D322263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14D322263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXN6D-0004ix-BK
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYn-0000hb-GV; Tue, 27 Oct 2020 06:50:37 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMYk-0002Go-Dc; Tue, 27 Oct 2020 06:50:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 2F9075C0194;
 Tue, 27 Oct 2020 06:50:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=9MJBN0ATo2GfJ
 Uy6cOqumOQ5ToeM5s9TjSrK+ZHA6x4=; b=mwqH2QrLv9M57GiAPuVD5e9HFhV67
 1q4GmYH5laWYGftFuTYCSxd24lPBjoRNeB1FFGIeSJ18hzKtQ9LL5MEmkkhcIuWs
 uFF2AvvwA8BzsfTFzwfM/sk5n7ovWVXfVynLau68QNYhkc/jMs4NZMNK67JExR8O
 jUYSfpL5XRDYKaoPp/cl0ohT7LnSuic+6F2kJscbGDBUNzAUYQYJnlJbpI8fnP0L
 zja/FH6S+Gwp3zuOR4Kj56NpVgtbQMTM9FVJf3G9uCXMe+AF9mrs/VW+fIwy7Xdz
 5XBfKHj6bvKHi5RqWyPgET7aMqGF/2SbW4uh/nPjxFybumrANQkgXA/gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=9MJBN0ATo2GfJUy6cOqumOQ5ToeM5s9TjSrK+ZHA6x4=; b=JILtuP/H
 13yg8owdnjMoUmdWL4IeQCKbMaHztK9Dwl9RkvzuCMxOOulJUIIWCttcKDST726T
 RvvbVLi+IW09hj1zmn8yMRxxbHQ0zQTYvPmDesQIiLa9sesFCQEco+gzkpkSfBQv
 duWUar2j1xYMOyC2e6SNhw+nzH83ptuZZDihNCGqUaGonQpwQdgQRr4fC5T3wJ2d
 9vFqSwKqa1UxwEdGZBnqTj1fe3CQpkBvyBbbqos00wDzgnsJ0p0z4uTHVbmuzKMx
 otDOm8n0yU1YrX+djNSGmhuNZk7LzEFndYJ7xgRpnDrXs7O0hImmWT2KDlk+QsHL
 +ytJ3rpciQYkiA==
X-ME-Sender: <xms:WfuXXxpXVTRC38cX4Ne0R2UGAg0TM1kx09LaF1Ovsm1iS-xh6UnUNQ>
 <xme:WfuXXzqOhRTCUbBEaNQuZVK0MuccCjayJApVct5nkGJyXZCItAa_NIp3u-1AVjzmq
 0ZDiMW3reDetW21JF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepueelteegieeuhffgkeefgfevjeeigfetkeeitdfgtdeifefhtdfhfeeuffevgfek
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgepuddtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:WfuXX-MCfhuLF4erRra7sNF0nsmInoRaYPV9nQYPmDFhmb6EeSLqWg>
 <xmx:WfuXX86YZrP2a_19zuWx2Q_eFYL1PcsLDG__v04nbkXbd-4lEsUWEg>
 <xmx:WfuXXw7oI04y0FwK3XjCmSpnen5m_Nx2G64xBfesHrUkpgQ4CHT7vg>
 <xmx:WfuXX-nkMzSy9m3ZOeJZ3Kzaw4Du0o9WlI1ES4D8JEw0Hi9FyIHJXQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1F5553280060;
 Tue, 27 Oct 2020 06:50:00 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 23/30] hw/block/nvme: support for admin-only command set
Date: Tue, 27 Oct 2020 11:49:25 +0100
Message-Id: <20201027104932.558087-24-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027104932.558087-1-its@irrelevant.dk>
References: <20201027104932.558087-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.26; envelope-from=its@irrelevant.dk;
 helo=out2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:49:36
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
Cc: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Keith Busch <kbusch@kernel.org>

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 include/block/nvme.h | 3 ++-
 hw/block/nvme.c      | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index bc20a2ba5e87..521533fd2a10 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -83,7 +83,8 @@ enum NvmeCapMask {
                                                             << CAP_PMR_SHIFT)
 
 enum NvmeCapCss {
-    NVME_CAP_CSS_NVM = 1 << 0,
+    NVME_CAP_CSS_NVM        = 1 << 0,
+    NVME_CAP_CSS_ADMIN_ONLY = 1 << 7,
 };
 
 enum NvmeCcShift {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 94db06cf72be..c1323ca869f1 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2751,6 +2751,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_CQR(n->bar.cap, 1);
     NVME_CAP_SET_TO(n->bar.cap, 0xf);
     NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_NVM);
+    NVME_CAP_SET_CSS(n->bar.cap, NVME_CAP_CSS_ADMIN_ONLY);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
 
     n->bar.vs = NVME_SPEC_VER;
-- 
2.29.1


