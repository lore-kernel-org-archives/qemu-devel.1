Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B7DC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2F020BED
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2F020BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVadd-0001ag-Az
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVaZf-0007he-6w; Thu, 22 Oct 2020 09:24:11 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVaZd-0003NJ-Cm; Thu, 22 Oct 2020 09:24:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 339BA5C008D;
 Thu, 22 Oct 2020 09:24:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 22 Oct 2020 09:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:content-type:mime-version
 :content-transfer-encoding; s=fm1; bh=fUyH1eoaisWO5xBgLBt/UAnCq3
 6mL4eXkkp4rTKtucw=; b=h+DUjAIiENWBQWxwFJLWWLUpoeQakdZx0USs/1kdeE
 3Ac+t6DYfduFPV2OJPlWbwScmxiwzvmGc23IfKXgChTBQsefgMq86oFks8Qt/80F
 TjUWhu3/wngRId07eLBDU++2PH+h0X4y/+dErD0bh+XNYHuWaQUYJQMnPCsMPZJW
 f4v346SPwS/vKkyUob5aSrSIClTF0OIWR4S8NtgXuWBQZRc5W0eIieK5ceqfy155
 Wh7HuPGsW5IIZUQO8PY3On+98EhAfAeXdtPllevYXqfYWNhTHO9LW7T5S9p5NnNX
 ka855qHVD+oE1HQMOyPBGkn65bMEBPhZ5QLRAHqtmrVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fUyH1e
 oaisWO5xBgLBt/UAnCq36mL4eXkkp4rTKtucw=; b=UqLDR2VoPGilzxS5GW0EX3
 wsky7vqkMmuvTKsEIu7CLYmYKZ3x7UQebh3JOAK8Ii571NaptUYi4AyideIGwtJG
 CGtHiPfLUQDjXNnJMzx+6P1ceGHklqpMPk7lc4StrWUYj44cqiitpRaRy+laATUe
 51FxYvoNZg2tGcSz6qdogL18mkPwnm47+GuOFT3CuJ4LsWRSP5uHc8wdvYkuklCY
 7I0JS+yCyCLxAD6AeGG4VPkMPVd+8cKpc7MLuGLZUdJRwIr/YBoz/UiB2a6haboQ
 qbbJkp2ueZRs1jI1mJ94KBV837OSHTyGgBv/e4erOethj5g5DaOIMYPfRz3NDdpQ
 ==
X-ME-Sender: <xms:94eRX1ZPoqp91e6bdzMRl2NRaF_pNdrQPWKCMoPgoLqXj1YzI-juog>
 <xme:94eRX8YnoXkC6TH0MZciuTJpDSF1iapMHlg50l04p-ESig6V_g5z4RxNk5OsdVFHx
 TLmQRh19plvCBohLhM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeejgdeivdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgtggfgsehtqhertdertdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpefhgeevkeeigfekvedvteejjeekkedugfdvheeijeffgfekffdvveelffetvdeghfen
 ucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:94eRX38rQukTM9P0GMOOLKyD7IANbALKcyhcvFO4geL0SPNX7E5z1Q>
 <xmx:94eRXzoLOEQYfIV1a7aZ40iCdGJ4nFoqG4Wvzm1Sh2PrWqi0nwZPhQ>
 <xmx:94eRXwqorkftIdZdLdb_83C68E6kc7laXPokYvZzgB74XOjQsQwJ8g>
 <xmx:-IeRX5nyy4x1bwXb30x_geE1ZMMP4fPOB5uctmvgkV7svahtSqdDZQ>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 7EBEA3064686;
 Thu, 22 Oct 2020 09:24:06 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/block/nvme: two fixes for create sq/cq
Date: Thu, 22 Oct 2020 15:24:02 +0200
Message-Id: <20201022132404.190695-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.28; envelope-from=its@irrelevant.dk;
 helo=out4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 09:17:09
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>=0D

The first patch is a follow up to "hw/block/nvme: fix prp mapping status=0D
codes" and fixes some status codes in the nvme_create_{sq,cq} functions.=0D
=0D
The second patch fixes a faulty check on the given queue identifier.=0D
=0D
Gollu Appalanaidu (2):=0D
  nvme: fix create IO SQ/CQ status codes=0D
  nvme: fix queue identifer validation=0D
=0D
 hw/block/nvme.c | 16 +++++++++-------=0D
 1 file changed, 9 insertions(+), 7 deletions(-)=0D
=0D
-- =0D
2.28.0=0D
=0D

