Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCB3C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DD024650
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DD024650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfmM-0000NR-7J
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 14:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVff7-0005xv-4T; Thu, 22 Oct 2020 14:50:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVff2-0006UC-MT; Thu, 22 Oct 2020 14:50:08 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id B62D65C013A;
 Thu, 22 Oct 2020 14:50:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 22 Oct 2020 14:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:content-type:mime-version
 :content-transfer-encoding; s=fm1; bh=TJn0lNJzSh+0v00CPIuPFlfQaT
 CZSaCOmPPr1sn125w=; b=pyPwzabZngcJZ72uocBiP3ZYW/Fi4szgoBY2GaNaUE
 OXSiyXDcA6RJRErfEBPzJJbXjQ6C+I1VlOdLiIbmPEjZb8mDMmk3gVeT/ueanLhx
 6x+kzzCC1yznqbCglWkO8ZUjlGxiSJblI4G4nYQd3Psn0GTrOovDWXBy83mxnJXa
 I5BGAQXtrPLOl8FMG+rx6hpPAUumh1+4zkwd7MmG82HceqNf90sQ5IuJmTtLOae0
 KhrSrZit+q8y5OyvBxXQ/t8JOY/3ADuqONNFPv1qHQ5I0jl+M2Hj7+qrPf7rnOw9
 XYJEKh8eFRgXmIH8QbHVEXeVanbu6hbvqw8PG5qbusLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TJn0lN
 JzSh+0v00CPIuPFlfQaTCZSaCOmPPr1sn125w=; b=lvpgRTTh/Nuyxuk21yzvk7
 VyWc7iqMw7do3P74mzNWXSNSB8jeVLgZ9b6iGm19z//HSUjP6nu2+48eu19dEMvq
 +hp/T4KcIFOWnnanVxd0C+3GBpInUNXlEBh5h6Z+GbdDHKCUwzvtKBYsPJ2JQxbx
 OMf45Jv1+BfHaG7MMlL6QdegfWKCyb4TO9OV/rnfUofgYRH6aAuvHxHZHVsxTHC2
 fNobY3JWm2w9nmKqdHW7aQun6Ga3fKLzem8gbsfb7mDIO2KipZogw1h+rkoOos9D
 HRofnJRWgwP5cYcOH99GbdLCGPw12EWAhKvn+oJl3GLLBdLzvv711dbBAH+0m7iQ
 ==
X-ME-Sender: <xms:WtSRX9zJ0MmelrVUxgj6jczAgY696Sjlbj0lZxyEj7F1LNaGOcecNQ>
 <xme:WtSRX9S2B6pYDmS7JsipwXdkliwCraIp6GISPIHzbUC81kDTNoqivJj4RY5KLl-G1
 l1JBqh1gEF551CkmKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeekgdegkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgtggfgsehtqhertdertdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeehgeehueekteejuddvfeekvdduudehtdejtdetudegjeegvefhkeevtddvueffleen
 ucffohhmrghinhepihhrrhgvlhgvvhgrnhhtrdgukhenucfkphepkedtrdduieejrdelke
 drudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:WtSRX3WoW65mnVmcERgaGYO8xXAYxLjmnXI8b2houbl3hs5xbhCUDA>
 <xmx:WtSRX_hDH53JAUicEAs6W31XeGxsj-8yMfgODtl9J0AYlWxiZAmV0w>
 <xmx:WtSRX_CERPLq15tdK3tg-1GfcJSsqGLRluvnBwJyqsJI9PcXwmhsVg>
 <xmx:W9SRX6-9BCKeG4AabXT2bUKod48fT12p6MvGxDcjdGmlUz5p-vvIGw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2B64D3064684;
 Thu, 22 Oct 2020 14:50:01 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/2] hw/block/nvme: dulbe and dsm support
Date: Thu, 22 Oct 2020 20:49:57 +0200
Message-Id: <20201022184959.240505-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.29; envelope-from=its@irrelevant.dk;
 helo=out5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 13:43:37
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
v5:=0D
  - Restore status code from callback (Keith)=0D
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
 hw/block/nvme.c       | 184 +++++++++++++++++++++++++++++++++++++++++-=0D
 hw/block/trace-events |   4 +=0D
 6 files changed, 237 insertions(+), 9 deletions(-)=0D
=0D
-- =0D
2.28.0=0D
=0D

