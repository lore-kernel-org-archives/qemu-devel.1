Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64B0C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CEA22527
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="e9RikxxK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJnLt6TY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CEA22527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifdq9-0004SS-JS
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 00:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ifdol-0002yk-VU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ifdok-0004hC-T0
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:48:47 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33035)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ifdoh-0004YM-Md; Fri, 13 Dec 2019 00:48:44 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id ED206909;
 Fri, 13 Dec 2019 00:48:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 13 Dec 2019 00:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=N9bCwlClnlHDFDNFqpp3fD4D/m
 1EZqVMm4Nk97EMVP4=; b=e9RikxxK9qaigA7SxEUg3gR9YbtXk+fnRLeeB9h1Oq
 0b8GfuOZC9ELD1gmpwFC5fYEdgbEi8J7oNp7Si0xZLVQC6NlE6x+5tomuaggvjT9
 zu9UB6GyeQg9Zk9YVRRTCqXKOLJnQAO8vgy+0v0pvEFtCkV1AsDBB232zWGwUM1p
 U62oW4qFCWu6cTi9rB97ft1VP0wVs+fDlNLj91rZCN1Y7jyHG1afQ8DeahlFk5eB
 uNNwXRGMBAt2LDRU+2CIaHh3gEaaFSJD57QLovvA+og+EDwJh8ElcKXI4Jt2U2VR
 nncERydcGxaLeFfIVN42YTBGdgM5pRNSm8U9O4NRS0/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=N9bCwlClnlHDFDNFq
 pp3fD4D/m1EZqVMm4Nk97EMVP4=; b=OJnLt6TY6kCam8LNEYFbR/T7mvZzu4wK7
 1sWRZe/Fr4QRm2eA/WvuHdpBBUnBK7Rn3ne0Tsl/QS6CBIihHDOpynFyCHWaj5iZ
 LdtE9blBI4Jj/IC28ftdRkv8Ee2NhyUgjL79RGBlePeeMnai//T+o1p8qdtkI1nK
 4ollp69wj/eP1GGDGFDMaI9QSkBZiYO35UZJB44OOZjloDJPenXW9HkXW0+BOuf7
 UrxSj515tTkVYTntY07ax6N/rrQ6Wg78ajMHuanadlsHmTQRQKyf57EdA5qjC8VY
 /Ogz9fqZ+cI43zbGpIOqjHKJUUOg9YmMhhlb1ZYh2y2UWLmFxp1vA==
X-ME-Sender: <xms:OCbzXc72U_t_HP8zgA010MdlMcrN5yb79zyh1LvcM3g54GtOyiOfSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelkedgkeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
 ihgurdgruheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkphepvddtvddrke
 durddukedrfedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhi
 ugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:OCbzXXchM_kfHTJ5Stqe832G1lV_NHWdbOlsrIjY_UflTkYho9V7SQ>
 <xmx:OCbzXW4MF_QnmgpbnAZD8ORQy78NFNKDVrdaHA7_Lq52sMDI86cSzw>
 <xmx:OCbzXf1fxHvr7jxeXUEfrEApRRBz17PpCttQvJe1zexmJu0m7CqSKg>
 <xmx:OSbzXUvcO83-tFO_hbOGDsZ6JdiP1T0i_4TOdkwV-j9kxdce7QLXMA>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1561E80063;
 Fri, 13 Dec 2019 00:48:37 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH v3 0/4] Expose GT CNTFRQ as a CPU property to support AST2600
Date: Fri, 13 Dec 2019 16:19:47 +1030
Message-Id: <cover.ec85a2db47c3e10de70fba144e1bc75caf2f0a91.1576215453.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.19
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@redhat.com,
 clg@kaod.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

This is a v3 of the belated follow-up from a few of my earlier attempts to fix
up the ARM generic timer for correct behaviour on the ASPEED AST2600 SoC. The
AST2600 clocks the generic timer at the rate of HPLL, which is configured to
1125MHz.  This is significantly quicker than the currently hard-coded generic
timer rate of 62.5MHz and so we see "sticky" behaviour in the guest.

v2 can be found here:

https://patchwork.ozlabs.org/cover/1203474/

Changes since v2:

* Address some minor review comments from Philippe and add tags

Changes since v1:

* Fix a user mode build failure from partial renaming of gt_cntfrq_period_ns()
* Add tags from Cedric and Richard

Please review.

Andrew

Andrew Jeffery (4):
  target/arm: Remove redundant scaling of nexttick
  target/arm: Abstract the generic timer frequency
  target/arm: Prepare generic timer for per-platform CNTFRQ
  ast2600: Configure CNTFRQ at 1125MHz

 hw/arm/aspeed_ast2600.c |  3 ++-
 target/arm/cpu.c        | 65 ++++++++++++++++++++++++++++++++++++------
 target/arm/cpu.h        |  5 +++-
 target/arm/helper.c     | 24 ++++++++++++----
 4 files changed, 83 insertions(+), 14 deletions(-)

base-commit: 04c9c81b8fa2ee33f59a26265700fae6fc646062
-- 
git-series 0.9.1

