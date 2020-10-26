Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ACFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7022206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7022206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWvdJ-0004hs-2o
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 02:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kWvZB-0002yg-S9; Mon, 26 Oct 2020 02:01:13 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kWvZ8-0000Fe-TE; Mon, 26 Oct 2020 02:01:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 5FADAB8B;
 Mon, 26 Oct 2020 02:01:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 26 Oct 2020 02:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:content-type:mime-version
 :content-transfer-encoding; s=fm1; bh=pnFVna00qtc0zPT9sfySRLsX7r
 ovz9xvKeFu3A9oagE=; b=JQZ94HXg83qMi1C6rs1EzbTOqlWfRR0eU4eHxOX/Vd
 3QMGc3Rjkzkxh5MTLHAMpsQGWCamTYjtbb26aC7WgUUmcEAXpOh4LWhCvHVBZB/d
 kwOWEV36qWqY4TrLe1GiAnsHvnQhbCK1l3YbCqtzzDMHLVxg9nun0KlAOE2GBptp
 YxzK6RqVjimduG5whKUCh6hZZr+1/D+SCHMPZjwvsVvE3gAEBBug0ASqC2/SSLWZ
 02JQTeegaDkk86Jfd4cIfDL3RCpHD0aESHA4YiKjZys3McoLXV8EQkThzBVD+15f
 1jov7sx+b0KJO3tBlRfcF2/7HO3wXGBUnObamSXldIkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=pnFVna
 00qtc0zPT9sfySRLsX7rovz9xvKeFu3A9oagE=; b=HQzF6Pcq+H+OXfME7JsgQe
 prAuJewqrbzwjiWgWzVv3kUriF3PGjF6Srv2UBbCkiRhIvbo22ZQ09w6BAouQm8A
 Ku6jLjfrehZW/PWJPUBxLK8v9ho0WP65+XhFkOmywRepPRY9tK6FGgkqFOqBma2+
 PMZiC+cHnmKoS0VMwkAyB4VTp5fNPaJDYtItfMYMx4U2GmE6+YyIHsG8gRIEs0l6
 /IID5G4Wm/YPu0ayip1PEF2Qe1sKjG+2PlywYPhfhzvqywn2sUrhqIr6dHTElAQr
 4TsiIo94bK3Cuv2kDe6dcNyUsXINCRKT+K7yjrpj33J6PK8B3OuT9gfy/bcpJeCQ
 ==
X-ME-Sender: <xms:IGaWX6wq_GotJqvmtIL5dp5CKef2tfbifUw777SjFqfziLfbwGQDcA>
 <xme:IGaWX2TPOuJ6L-aLYBWWIvw5GtgwTmeWlZUFcWgLJLyT7-PSonGDbfu92ZuB1BgTp
 m2BQJKBy9gggrgAe9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeehgdeludcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgtggfgsehtqhertdertdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeehgeehueekteejuddvfeekvdduudehtdejtdetudegjeegvefhkeevtddvueffleen
 ucffohhmrghinhepihhrrhgvlhgvvhgrnhhtrdgukhenucfkphepkedtrdduieejrdelke
 drudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:IGaWX8V97gh82uAj59wCxudXgP4MitQ5q6uZfvnImkrfArk_m_wgeQ>
 <xmx:IGaWXwj3CR-R3UQkWdJEWUFXYwY4zISxoGgPigfGI6yIVmD3VICgDw>
 <xmx:IGaWX8Ai0xIBbfm5HThUBU4uEL8EMvtT7BhBDqnBuQmuc3Tp-ySREg>
 <xmx:IWaWX_-R8O4hv8i24WCC1FrAxKSCp0QYbM8mwIbwfEHD7lwAlHGXyw>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 30E10328005D;
 Mon, 26 Oct 2020 02:01:03 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/3] hw/block/nvme: dulbe and dsm support
Date: Mon, 26 Oct 2020 07:00:58 +0100
Message-Id: <20201026060101.371900-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.20; envelope-from=its@irrelevant.dk;
 helo=wout4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:01:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
v6:=0D
  - Skip the allocation of the discards integer and just use the opaque val=
ue=0D
    directly (Philippe)=0D
  - Split changes to include/block/nvme.h into a separate patch (Philippe)=
=0D
  - Clean up some convoluted checks on the discards value (Philippe)=0D
  - Use unambiguous units in the commit messages (Philippe)=0D
  - Stack allocate the range array (Keith)=0D
=0D
v5:=0D
  - Restore status code from callback (Keith)=0D
=0D
v4:=0D
  - Removed mixed declaration and code (Keith)=0D
  - Set NPDG and NPDA and account for the blockdev cluster size.=0D
=0D
Klaus Jensen (3):=0D
  hw/block/nvme: add dulbe support=0D
  nvme: add namespace I/O optimization fields to shared header=0D
  hw/block/nvme: add the dataset management command=0D
=0D
 hw/block/nvme-ns.h    |   4 +=0D
 hw/block/nvme.h       |   2 +=0D
 include/block/nvme.h  |  12 ++-=0D
 hw/block/nvme-ns.c    |  40 +++++++--=0D
 hw/block/nvme.c       | 185 +++++++++++++++++++++++++++++++++++++++++-=0D
 hw/block/trace-events |   4 +=0D
 6 files changed, 238 insertions(+), 9 deletions(-)=0D
=0D
-- =0D
2.29.1=0D
=0D

