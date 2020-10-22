Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9ADC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCCC22249
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 09:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCCC22249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVWX2-0004dP-O8
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 05:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1kVWT0-0002BJ-Bg
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:01:02 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:41243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1kVWSs-00028Z-Ai
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 05:01:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 59C8F734;
 Thu, 22 Oct 2020 05:00:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 22 Oct 2020 05:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=vl35n298E8f0GAkn5LSmKqMamj
 Y8tCk5cGUNtVmfpHI=; b=rkQQL1rEvsX+e1DwDqTZsbsVbyGq5P9DO0QzANLE4I
 MD+7oHxVVd0muFXTkPP0uB9RCkCdjzm8XkXMZyNcSoFoSJdVnvo1KhsHbbh5ZkAd
 6eo2mgEmCsbjT7LcIfBqppIE2uyeLNDEQaEM8Y8X90EcrPwsAkc/xaCeFoMLjdU0
 IZoJIFe4eEw4RHJ3wngvmsObPj/fcM7b1QIYDJgJRnjF54DlN/5m2BSBD9FMTWGh
 1wINRwRjgbMdQ0CE2PWEe2cqOXPs6igGpcELg5KZAIEcg1gzwXqtLRNvssqAZEd8
 MqTYtXVasDevZh2nemoXCE8kwhD70wcrP+4bXDEq2dKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vl35n298E8f0GAkn5
 LSmKqMamjY8tCk5cGUNtVmfpHI=; b=nQMAtualbtk6A/xOY63JpV/yPA7B0jo/L
 a7zJ6KWH2GlCZM66rb8sWmZdDDIqH319dKVMHEmE1hfKXgDqM3V4ljC09Rugeu1p
 P6/7PPDZyFYTOCctWYLzfN7/8mkJ16BvHTnMr111ohK+LU1y3bgqBjKpSbfYuIlt
 o1NCK865k8RjznNuNFzM99AZVSotlSNsSSG3GjXXg1aXaxs1ZyLjxCUXV+6h4chn
 lZWPOjxzknzjihBghX6vijGtpJrGmz5baSXgViUrYWzW79kq4+ScqqP2bdq0Cj3r
 zqXc0TShnbAPsZTro7CMWnUJ2BQMS1i/0WrUDfkSzus8kC5K22wwA==
X-ME-Sender: <xms:P0qRX3KJr6Qm-NOy84QCAgXNBUaPEpfmqtqop65eSgd3D1ZyGylJig>
 <xme:P0qRX7INSK2gvLXyZzrevdCaSGIQkA5MRUZ0A8jqnI_HY3d_QfhtEvU0X5HaTRqeW
 CQKPrhaOoxxcFQKtn4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgddutdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 epleefledufeeuieduvdffueefveekffetteeiheevlefffeejleeivedtuefgjeeunecu
 ffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgpdhgihhthhhusgdrtghomhenucfkph
 epkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:P0qRX_sYdHfKC2-F5a_NehsP0-T2nk2FCGBHD7w2qNsGnjUU2j-KPg>
 <xmx:P0qRXwaRJyHPt45JR_I_QcX8gRL4zK0lQOtKc1FZsxL4O9r9mGH6GQ>
 <xmx:P0qRX-bn78vN4ZAqXQFoMTAgC1C7ghsXUZ0Q1eDgA6oa6x98XKqC-g>
 <xmx:QEqRX1Unb2j4HOw3WJsyCmVT_r-V7BZ0sl5pgjhcVUkiXgoLvPjDkQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id CA7F73064687;
 Thu, 22 Oct 2020 05:00:46 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Update nvme entries
Date: Thu, 22 Oct 2020 11:00:45 +0200
Message-Id: <20201022090045.158261-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.20; envelope-from=its@irrelevant.dk;
 helo=wout4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 04:37:21
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Make sure that maintainers of both the nvme block driver and the
emulated nvme device is notified about changes to the shared nvme.h.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a197bd358d6..f546ac6840f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1876,6 +1876,7 @@ M: Klaus Jensen <its@irrelevant.dk>
 L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/nvme*
+F: include/block/nvme.h
 F: tests/qtest/nvme-test.c
 T: git git://git.infradead.org/qemu-nvme.git nvme-next
 
@@ -2953,6 +2954,7 @@ R: Fam Zheng <fam@euphon.net>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/nvme*
+F: include/block/nvme.h
 T: git https://github.com/stefanha/qemu.git block
 
 Bootdevice
-- 
2.28.0


