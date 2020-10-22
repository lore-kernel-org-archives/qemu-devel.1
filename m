Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C6CC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A928A21707
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A928A21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVC1-0007cu-8X
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVV6B-0005PN-ER; Thu, 22 Oct 2020 03:33:23 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:49615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVV68-0003fR-Ny; Thu, 22 Oct 2020 03:33:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 841CF6C2;
 Thu, 22 Oct 2020 03:33:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 22 Oct 2020 03:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=NxYs9E2rs07+4QygczjJdAcbVJ
 ujuKT92+JfaEgUVSk=; b=zC1VeCzZZlO92Yul5k0IoQHUsazkhAt/hNx8EBiJFq
 3iGkkSOgSI6MuPuvVFvFw00NroRkiwNHjX1gYwvJe3wRDeWTWOmkn21s4/MgAB53
 uSolYM5RygKTJpDSWmT7u7DH3DqVzuVXfxeBLCVwbYOSdCEWS31Fvr6MN64CPNJj
 JDugBpWiyW3+7gtkDfkmNzokGRuOpX26qYgZ6xhVoPmupigysKXRY/TJyAoJaiDE
 BnURikqbqVh8ldamFaRvWHJmcjRGu/5gVAoU+XYWz7m2cN0WbJbWgPn790YUNjMN
 INkqqg9AbjN9mwkNWyym2LMlZSBkHr5Uv+GG47S7s/Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NxYs9E2rs07+4Qygc
 zjJdAcbVJujuKT92+JfaEgUVSk=; b=UCyBX9kNlYDp2wYPRePrFCuNbIU9wbtZB
 LxIguHssc+FhgZsaCKvAzDVK6pGWzBDbY+0wNgYyLVlTi9tNBwhvNnYGrztiD3JH
 csVgCrpqU8I0cSIDF3p8Dhr7RkNWY1xu8NmL5W09TeHQ9kHuUNQ6YHie7nKzyC7B
 Ejafjp3M4/y/fbT3VABbNykEEqV5M3N7htCbzsofWIsdj6DAHxHBaRmaa4K5KMuu
 QT31j4G7lLmQDSzDtcGNx76OtUzj19dI6uwi2re3hkppp9sDFD9b8RrpaW1sftoB
 Jtlfj9xKpeZWqE0QE4jBbEMgHA6cRiBpVkll7VPJD4CcyIpkf2nrA==
X-ME-Sender: <xms:vDWRX_Gbai-OHWeKM29Vk7vEjdkwrqEBpHOfNAOCAWrnJ2HeZq0ADA>
 <xme:vDWRX8UHoQBGm-pzCiM1ljmStYExAl_HrKdiSnUdTyXJL5xVIJmFUTliWePbFsNh1
 Vp3ftpR5dhqbtFUpDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigdduudelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffoggfgsedtqhertdertddtnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpefhjeffvddtueefkeelleettedufffhleeitddvgeduudfftdeuffekgfeugedtueen
 ucffohhmrghinhepihhrrhgvlhgvvhgrnhhtrdgukhenucfkphepkedtrdduieejrdelke
 drudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:vDWRXxKlh-hYzBBn5vojjPb74KuqDJxRXZ_mn7ElaKi1IKHzHCqgEQ>
 <xmx:vDWRX9Hgiu3n_K90U-hSxCJ-5DK_cnlV54VfWkw9G3Euz6151Ck0sQ>
 <xmx:vDWRX1VDDaWFfVhpo3bhzsLdjw-aQ0ZrpttCXT5sdXzk0pb6Ja1w2A>
 <xmx:vTWRX7ynB5wLygNJm9iBBy4uvHzJ57nIR3--0kFmLoU62zKIeaBLUg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 59F433064682;
 Thu, 22 Oct 2020 03:33:15 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] hw/block/nvme: dulbe and dsm support
Date: Thu, 22 Oct 2020 09:33:11 +0200
Message-Id: <20201022073313.143794-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.24; envelope-from=its@irrelevant.dk;
 helo=wout1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 03:33:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds support for the Deallocated or Unwritten Logical Block error=0D
recovery feature as well as the Dataset Management command.=0D
=0D
I wanted to add support for the NPDG and NPDA fields such that the host=0D
could get a hint on how many blocks to request deallocation of for the=0D
deallocation to actually happen, but I cannot find a realiable way to=0D
get the actual block size of the underlying device. If it is an image on=0D
a file system we could typically use the host page size, but if it is a=0D
raw device, we might have 512 byte sectors that we can issue discards=0D
on. And QEMU doesn't seem to provide this without root privileges at=0D
least.=0D
=0D
See the two patches for some gotchas.=0D
=0D
I also integrated this into my zoned proposal. I'll spare you the v4, nobod=
y=0D
cares anyway. But I put it in my repo[1] for posterity.=0D
=0D
  [1]: https://irrelevant.dk/g/pci-nvme.git/tag/?h=3Dzoned-v4.=0D
=0D
v4:=0D
  - Removed mixed declaration and code (Keith)=0D
  - Set NPDG and NPDA and account for the blockdev cluster size.=0D
=0D
Klaus Jensen (2):=0D
  hw/block/nvme: add dulbe support=0D
  hw/block/nvme: add the dataset management command=0D
=0D
 hw/block/nvme-ns.h    |   4 +=0D
 hw/block/nvme.h       |   2 +=0D
 include/block/nvme.h  |  12 ++-=0D
 hw/block/nvme-ns.c    |  40 +++++++--=0D
 hw/block/nvme.c       | 183 +++++++++++++++++++++++++++++++++++++++++-=0D
 hw/block/trace-events |   4 +=0D
 6 files changed, 236 insertions(+), 9 deletions(-)=0D
=0D
-- =0D
2.28.0=0D
=0D

