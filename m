Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF3C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 22:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF5A241A3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 22:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF5A241A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVMTx-0008Vz-FH
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 18:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVMQV-00077P-OB; Wed, 21 Oct 2020 18:17:47 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:51001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kVMQS-000057-AX; Wed, 21 Oct 2020 18:17:47 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 6C8E71264;
 Wed, 21 Oct 2020 18:17:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 21 Oct 2020 18:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=E+NiYjeA3qOq8nyqEXnp4jxKdW
 6IUjZVLq1wtm2Wx3c=; b=HYJQvCbOpNSrGRTI1SVb2f6tPIK9TkNWjiB7jGa7uo
 NQDSKdpChIHDd4VIzSjXlDq1J4Vw4Lo6xOF9gN5kbEFzetgmHJSW7iIGYblyb05s
 460sZucsP6nhVu+CUty6d/wEj8lIlPpgQSU4NmBL5zBLVxtyflP8BfunHYCkbEZU
 CHMtot9qQ4fIr9Tbl468YOE/8F0/X/2ogD8ZY40TO22Dl3z4KoCD4n3sFYhkE1Hd
 mOHkE5ZXBaaOywGCp4uRDv1zpMTI0xLuusXenScXbX/A4CJXWwPAp7SNOLxrszwY
 ih7GgKg0IZw/A4mwRLmZpBLeknBpUs+fRTPfrwz5IWIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=E+NiYjeA3qOq8nyqE
 Xnp4jxKdW6IUjZVLq1wtm2Wx3c=; b=Ae4l1gUdrajR9gpne0XdmGwxeUU/Jn0xf
 egTOWioT1SAUcSE3ocUVJ+1KOn21FGwlz2RWK5GtZCFGG8TvJEv8G7/mQdLKmtpE
 L0upYMGvwaILjl0qU5PYEJTxStJGsjLFwTW4BAyjb7yDRqwjH1dM6Fre11PSMUCb
 Zx2hngOfwXn2QbTkes3TrL8BPYtmiyUfhq+PaRyTy9lgwGwQdHWdX4qvIW3v6QKr
 dmZaOiQIn97f7wb2U2CKQTc33O8cgYBgqEqp7DgjbHxqIE3k0EIb+S1bzQ3rnimt
 zAMdqUFf1zlw+ABmD/g99p+yckEoDiuKENH7Doj6AWjoq/du7LuRA==
X-ME-Sender: <xms:hLOQX6eWNsSJKuc3STAQBOawkagJg8ZLAjZsH-5qXmRD7j7cfYWWOw>
 <xme:hLOQX0NLgpLY-hyZ2DdCMC5G_loW1N3crMI0WxYu7vD2cwTUHlAuMG4yLon4xLJOg
 2BYJZSofnhY0HMZfBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeeigddtiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdhqredtredttdenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 ephfejffdvtdeufeekleelteetudffhfeliedtvdegudduffdtueffkefgueegtdeunecu
 ffhomhgrihhnpehirhhrvghlvghvrghnthdrughknecukfhppeektddrudeijedrleekrd
 duledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
 ihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:hLOQX7iVPOR0T0ClmoT2-pqHV4kju6hdoxovwEij_ddOcj13KdDE6g>
 <xmx:hLOQX3970nYPkO8WIcdUILvJXEdEnCV9SntHtlCaG7X1f7tVF7ctWg>
 <xmx:hLOQX2tz6ulxGrShB7QQCAix7pWsdXxkl29MSIzatUThUvSME_atmg>
 <xmx:hbOQX4KXgMGwH4k7bVmL-HuCMb_PARA8-QFKTTKyxgN985n7ZXCw7w>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 116043064682;
 Wed, 21 Oct 2020 18:17:38 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] hw/block/nvme: dulbe and dsm support
Date: Thu, 22 Oct 2020 00:17:34 +0200
Message-Id: <20201021221736.100779-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.21; envelope-from=its@irrelevant.dk;
 helo=wout5-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 18:17:42
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
Klaus Jensen (2):=0D
  hw/block/nvme: add dulbe support=0D
  hw/block/nvme: add the dataset management command=0D
=0D
 hw/block/nvme-ns.h    |   4 +=0D
 hw/block/nvme.h       |   2 +=0D
 include/block/nvme.h  |   5 ++=0D
 hw/block/nvme-ns.c    |   8 +-=0D
 hw/block/nvme.c       | 179 +++++++++++++++++++++++++++++++++++++++++-=0D
 hw/block/trace-events |   4 +=0D
 6 files changed, 197 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.28.0=0D
=0D

