Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F916C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE0D22208
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 21:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE0D22208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLYSz-0000IC-96
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 17:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7O-0004RY-Aj; Thu, 24 Sep 2020 16:45:31 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kLY7J-0007gR-BG; Thu, 24 Sep 2020 16:45:29 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id 9E625580509;
 Thu, 24 Sep 2020 16:45:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 24 Sep 2020 16:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=fm1; bh=EcyDFk3GQ/NE6CzB2y4ZKq8X2p
 9/hXtL8J3DES1uquw=; b=hMncjVXv0Z+wgJ/259FAybvFAndlUJbpqolPUwKnL1
 mkBjMbkYRZCxWH0jY+CT2ULhfvfs3fng2dqRuOzsg3jpWbhlFqTlExMVlWtWJGFr
 v+EptH/tqW4Fa9T0GmWJJQ9m2JQFNAsXj6qX9ZdCvEje5Xd/VHcVtNHkhNseNJH4
 7KSY6UF3wbC/Ft9czaDiYO7k+9nNZ84V288D6shMUeMBmFxT5TWFTPm4SyL7NL0z
 Lt//gMU5TneoDqTSsaDekd5WF/ci2c4OIxCSgFYTXA29pkWmyJhZMKgvgtDgwq3p
 JUxdpPWBv2ORuTr0v9jgAFyLA4HMFSP1QHxQubIoUdeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=EcyDFk
 3GQ/NE6CzB2y4ZKq8X2p9/hXtL8J3DES1uquw=; b=i5CdtvWcQW1kMhnjoHc5vI
 +rtX9ZDxyN/lV3s33PpB8CXZu+SE538KSo5zZvFmvyYS1FilkI00gvUMCH/Xqvf3
 WsIv4RZtVDHDvJMl4o6nIO7QWCKGSeZ9ab7WsKDP218FfX5qNfiAYT6L/aqB5The
 bA1bI5ngkPCo0qs3ZLh6LCzsRIynRvaXQsStSHQsnJBfYc2x2ENrlmjoO02ot0Tp
 KX/PFYCCHaDMPRBrT5IrDFnjGvym9sadYE9WvmfdkuObBg1xuwP+fbSXx2p5G6f0
 oup0d+IF4P8i6XMyI8kpyFEQeeGoI9nsY6lPIdogM9bW+zedITc3EBHMNVIIGSvQ
 ==
X-ME-Sender: <xms:XwVtX2MjORPYgtQbCiiANfFvkTkNRFqNfp9qw35tkRW434oKnEsPtQ>
 <xme:XwVtX08fWUYFm53UTyDN_6lGdJ-l0cwwgHfZoSBOZGLk4Qm5zNkJWMAl0c9ACeCGi
 qwPzzKcG5Icu-IHtnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekgdduheduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffogggtgfesthhqredtredtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepfeduheefudfghfdutdetffefleeutddttefgudeludduudfguefhleeuueeugffg
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:XwVtX9SmR1wkyZsZ64Pg-PEDoWUpSJY6M06Ow3G98m2lvw7dkDeEsw>
 <xmx:XwVtX2vst5KrrtTeigBWh9qpMZDr8v_llT_45ORgopg3HlfcSK7Qkg>
 <xmx:XwVtX-ePn68l-ULkrtnuZZnOWiMnq4_2eOW5viOYMfIi7RYrD8-bwA>
 <xmx:YgVtX7GhSp5rUqLVNQeiOTmyXvCqkZel68gY6dqiNJYh9jMhbY818w>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 00E8D3064674;
 Thu, 24 Sep 2020 16:45:17 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/16] hw/block/nvme: zoned namespace command set
Date: Thu, 24 Sep 2020 22:45:00 +0200
Message-Id: <20200924204516.1881843-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.224; envelope-from=its@irrelevant.dk;
 helo=new2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:55:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>=0D

While going through a few rounds of reviews on Dmitry's series I have=0D
also continued nursing my own implementation since originally posted. I=0D
did not receive any reviews originally, since it depended on a lot of=0D
preceding series, but now, with the staging of multiple namespaces on=0D
nvme-next yesterday, I think it deserves another shot since it now=0D
applies directly. The series consists of a couple of trivial patches=0D
followed by the "hw/block/nvme: add support for dulbe and block=0D
utilization tracking", "hw/block/nvme: support namespace types" and the=0D
set of zoned namespace support patches.=0D
=0D
A couple of points on how this defers from Dmitry et. al.'s series and=0D
why I think this implementation deserves a review.=0D
=0D
  * Standard blockdev-based approach to persistent state. The=0D
    implementation uses a plain blockdev associated with the nvme-ns=0D
    device for storing state persistently. This same 'pstate' blockdev=0D
    is also used for logical block allocation tracking.=0D
=0D
  * Relies on automatic configuration of DLFEAT according to what the=0D
    underlying blockdev provides (i.e. BDRV_O_UNMAP for guaranteeing=0D
    zeroes on discarded blocks) for handling reads in the gaps between=0D
    write pointer, ZCAP and ZSZE. Issues discards for zone resets. This=0D
    removes the zero filling.=0D
=0D
Finally, I wrote this. I am *NOT* saying that this somehow makes it=0D
better, but as a maintainer, is a big deal to me since both series are=0D
arguably a lot of code to maintain and support (both series are about=0D
the same size). But - I am not the only maintainer, so if Keith (now=0D
suddenly placed in the grim role as some sort of arbiter) signs off on=0D
Dmitry's series, then so be it, I will rest my case.=0D
=0D
I think we all want to see an implementation of zoned namespaces in QEMU=0D
sooner rather than later, but I would lie if I said I wouldn't prefer=0D
that it was this one.=0D
=0D
Based-on: <20200922084533.1273962-1-its@irrelevant.dk>=0D
=0D
Gollu Appalanaidu (1):=0D
  hw/block/nvme: add commands supported and effects log page=0D
=0D
Klaus Jensen (15):=0D
  hw/block/nvme: add nsid to get/setfeat trace events=0D
  hw/block/nvme: add trace event for requests with non-zero status code=0D
  hw/block/nvme: make lba data size configurable=0D
  hw/block/nvme: reject io commands if only admin command set selected=0D
  hw/block/nvme: consolidate read, write and write zeroes=0D
  hw/block/nvme: add support for dulbe and block utilization tracking=0D
  hw/block/nvme: support namespace types=0D
  hw/block/nvme: add basic read/write for zoned namespaces=0D
  hw/block/nvme: add the zone management receive command=0D
  hw/block/nvme: add the zone management send command=0D
  hw/block/nvme: add the zone append command=0D
  hw/block/nvme: track and enforce zone resources=0D
  hw/block/nvme: allow open to close transitions by controller=0D
  hw/block/nvme: support zone active excursions=0D
  hw/block/nvme: support reset/finish recommended limits=0D
=0D
 docs/specs/nvme.txt   |   49 +-=0D
 hw/block/nvme-ns.h    |  166 +++-=0D
 hw/block/nvme.h       |   24 +=0D
 include/block/nvme.h  |  262 ++++++-=0D
 block/nvme.c          |    4 +-=0D
 hw/block/nvme-ns.c    |  411 +++++++++-=0D
 hw/block/nvme.c       | 1727 +++++++++++++++++++++++++++++++++++++++--=0D
 hw/block/trace-events |   50 +-=0D
 8 files changed, 2580 insertions(+), 113 deletions(-)=0D
=0D
-- =0D
2.28.0=0D
=0D

