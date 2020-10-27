Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01E9C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5816C21655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5816C21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMpW-0002TD-7P
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXx-0008Ph-RN; Tue, 27 Oct 2020 06:49:45 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXw-000279-4e; Tue, 27 Oct 2020 06:49:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id DEFC35C0159;
 Tue, 27 Oct 2020 06:49:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 s2e8yoSa135asEbsyKVPTRi2H5U2ngmQmhUv9k2GW+s=; b=ogm5opOYGJzYMgG1
 cuMa91uTP2Y5eKVA9reMgPv3ch81YM6+e8nomtlqS+UzyECVHbTCOeYBdyI2E5fU
 fWrkoizYaIuDJ0HLr44pI1ADi46P0Mx5gA+508FGi2rRRokyl5EGmdMpIqQ+F5lQ
 9Jbn8yFrjE+BRiKbkkBqn/hKOkMGSvIzFo3eTNH4py97J5V1wkvVdtgsAhYvUBXt
 STuvqD027XRXq9agjkDD8VvRx8LWO2O8PbXQyvsZwxNwbWkqtsbBGCqeo7v03TBQ
 SS0d31XttZjkz8SRIwlSrAgUgn87NVjGxOT4i0z84L4HgQJyqb1bmqydhpdXWnFE
 rMgPjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=s2e8yoSa135asEbsyKVPTRi2H5U2ngmQmhUv9k2GW
 +s=; b=VRij+Rbuhkq56Hms/TLV2bCaREWbAjnKGLUWjIci0G0ZZD/WVuR8YR+K4
 vWnFxBruT05uRSrsd01VmlrEtvDCAb1hrk+0jjHTkrDCZ65H3AR8XwevtpCmMX9u
 Tf9eg71B2Bj+dXi28tfYMAxoFYQdHkB0jpQ9iohnQDtNGbT/6tzf4IjewpafczXY
 J0a+/WhauqXfq52DfKFl0/bsZH8U2IeVmROkCgBvYBxw7a+JboF/lv5glnln1W2C
 521OiAOYnTbUA48XusUJ/FoqgZWNLWO3DwTvR88DDS8A2nkLdL1cpRdnh19krurD
 oMm3Gfo9gFNCYLxujzlQb8T11hIXA==
X-ME-Sender: <xms:RvuXX4HQ4dDmH7FExBFNwlvReHox09iVZEl4yqRKb3MJb3TuJHYTiQ>
 <xme:RvuXXxXJWy5qY-Ko_kY-3ybEmSKTn7amBtOXKBGlziLX6fu1NmlpMRccBXm4jfMyG
 Kg1mvc2sdtvI4to-18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeetveeuudegveeiheegieelueeftedvtdekteefleegheduhfejueelvdfhffdt
 geenucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpeefne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:RvuXXyLUecBnJUrou0-MA0-9aJF-phFy8Ac5Djthr3oGylJRhc2dQw>
 <xmx:RvuXX6FKsbjsYUisxcbXxuSsKcaA4rKtSydMYoNekppGq_iGWF5L6w>
 <xmx:RvuXX-UwOZMqH03TPmCfvxNj9E24yjli7V3hLEybk9VlXAzvVpXpJA>
 <xmx:RvuXX8ypH4P8IcrX1fGH5a2Q4KkmPH6FeDw6ZE64YlMtly0ET5BpWQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id B795F3280060;
 Tue, 27 Oct 2020 06:49:41 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 07/30] hw/block/nvme: fix endian conversion
Date: Tue, 27 Oct 2020 11:49:09 +0100
Message-Id: <20201027104932.558087-8-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201027104932.558087-1-its@irrelevant.dk>
References: <20201027104932.558087-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

The raw NLB field is a 16 bit value, so use le16_to_cpu instead of
le32_to_cpu and cast to uint32_t before incrementing the value to not
wrap around.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 59338b42328b..158843c14a29 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -645,7 +645,7 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
     uint64_t slba = le64_to_cpu(rw->slba);
-    uint32_t nlb  = le16_to_cpu(rw->nlb) + 1;
+    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t offset = nvme_l2b(ns, slba);
     uint32_t count = nvme_l2b(ns, nlb);
     uint16_t status;
@@ -669,7 +669,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
-    uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
+    uint32_t nlb = (uint32_t)le16_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
 
     uint64_t data_size = nvme_l2b(ns, nlb);
-- 
2.29.1


