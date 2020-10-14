Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DD1C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA29F2064C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA29F2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfAj-00011y-Ls
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0J-0003D9-8z; Wed, 14 Oct 2020 07:31:35 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:58859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kSf0F-0006Xa-CQ; Wed, 14 Oct 2020 07:31:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 39E70580193;
 Wed, 14 Oct 2020 07:31:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 14 Oct 2020 07:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=xTZsNFjgpCwwqiQUYVFLYF3O2V
 N86YpWSmHbCMp94u0=; b=HI07IEOshUHLrma9YlaOB1AY0VT7QTrpYpfBXMPGxI
 3VM5f9f5OaxvTBVUkUKt98WttBddTBsv2xAA1K7VPHotSty5wmZgcQ6LdHoLvDFc
 Ckc7dP6XVcO22CCraZmDXRAlMTP9iSezFd2IcjTEUUZVaYTL9gbKwtYRUBugDhAb
 47FJJyqd/FLV4v7U9Lz0SCGnTEyl4z4tU0R/ddliWuC2GqjJRqOo3r2bl5iFrSz1
 yUH+MTj/VeR+qVgPoCDfS0YrmCupKHLyxSb/bzUkJaAZp+y3OLgbjW2ZfCQ07f2W
 l1T1HYrlNBhyUvR5UCqsbCIQgtvvYElqi86OGUK90C+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xTZsNFjgpCwwqiQUY
 VFLYF3O2VN86YpWSmHbCMp94u0=; b=GqbEB55+VRqrmU727h4r5dJ0WJMS654gs
 +j+viygTKZfKOTX1IJQgtHtw/T5cVUv51LeS1u3I68XRLSK30bzQfa1kESfq1HxJ
 Vt98xsWyVd9lx/hQWH+gpTfdv60EPleuQH9U71KCU3HMtX7ls+qfBJlRybJ22VP3
 jR6jbe+f1XAeScMOZ56R4Y6NpiBCvvGikvnLCndanMrUJhjQN7tMesW3GvlT5BBf
 taQZ2sFRU7GAhPg6PKL3PJ/Q4HFGzGgpoek9/s2r3mQLbSfhSw7/NR+iq3XDZU6z
 pa21K18G/R406C6HiHPCVpnVQcdS+lLU/+K+wVHmgx+PUCD35RPTA==
X-ME-Sender: <xms:jeGGX9ECqGeuxMn-fvjYM2JDGBQLn7ILw_qk9Obj-bAdZLBoW71kKg>
 <xme:jeGGXyUVszM2wTXLLwQqR3RHAF5wTYSS0jOetEVClYeVH4GYDhc-MRf8mA454AghO
 URQ84fupER8YqHBJoM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedugdegudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdhqredtredttdenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 epuedvgeeuhefghfdvffffudevgeeigfdtgefhffdtieeiudehkeefleetvdeikeeunecu
 kfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
 hrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:jeGGX_KWu3MbZdUK5NLch4lkYd8vi-O-6WkLDPZ8hC2BZKSM9ZpyLw>
 <xmx:jeGGXzEdeBgCuBauwAOC1wCpXjWBHlLNXMo22crqw7rfRnBU0nsLBQ>
 <xmx:jeGGXzU4zvg62h8szI3jGzq9Z7jsyOg6-jP6Qpg4BgNM3zv3rnlUbw>
 <xmx:juGGX1K-z_PiqM81nyNO6cOKqSYMDrZSZx6otomBQ_MnX438Zfc6Fg>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2114F3064610;
 Wed, 14 Oct 2020 07:31:24 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/9] hw/block/nvme: zoned namespace command set
Date: Wed, 14 Oct 2020 13:31:13 +0200
Message-Id: <20201014113122.388849-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.229; envelope-from=its@irrelevant.dk;
 helo=new3-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 07:31:27
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>=0D

Updated version of my proposal.=0D
=0D
Based-on: <20201014084324.333774-1-its@irrelevant.dk>=0D
=0D
Changes for v3=0D
~~~~~~~~~~~~~~=0D
=0D
  * Rebased on nvme-next with "[PATCH v2] hw/block/nvme: add dulbe=0D
    support" applied.=0D
=0D
  * "hw/block/nvme: add support for dulbe and block utilization tracking"=0D
    - Dropped from this series. This series instead builds on the=0D
      support for DULBE that I added in "[PATCH v2] hw/block/nvme: add=0D
      dulbe support", previously posted.=0D
=0D
  * "hw/block/nvme: add the zone management send command"=0D
    - Use asynchronous discards.=0D
=0D
  * "hw/block/nvme: add basic read/write for zoned namespaces"=0D
  * "hw/block/nvme: add the zone management receive command"=0D
  * "hw/block/nvme: add the zone management send command"=0D
  * "hw/block/nvme: add the zone append command"=0D
  * "hw/block/nvme: track and enforce zone resources"=0D
  * "hw/block/nvme: allow open to close zone transitions by controller"=0D
    - In compliance with the concensus I dropped zone persistence=0D
      support from all patches.=0D
=0D
Changes for v2=0D
~~~~~~~~~~~~~~=0D
=0D
  * "hw/block/nvme: add support for dulbe and block utilization tracking"=0D
    - Factor out pstate init/load into separate functions.=0D
=0D
    - Fixed a stupid off-by-1 bug that would trigger when resetting the=0D
      last zone.=0D
=0D
    - I added a more formalized pstate file format that includes a=0D
      header. This is pretty similar to what is done in Dmitry's series,=0D
      but with fewer fields. The device parameters for nvme-ns are still=0D
      the "authoritative" ones, so if any parameters that influence LBA=0D
      size, number of zones, etc. do not match, an error indicating the=0D
      discrepancy will be produced. IIRC, Dmitry's version does the=0D
      same.=0D
=0D
      It is set up such that newer versions can load pstate files from=0D
      older versions. The file format header is not unlike a standard=0D
      nvme datastructure with reserved areas. This means that when=0D
      adding new command sets that require persistent state, it is not=0D
      needed to bump the version number, unless the header has to change=0D
      dramatically.  This is demonstrated when the zoned namespace=0D
      command set support is added in "hw/block/nvme: add basic=0D
      read/write for zoned namespaces".=0D
=0D
  * "hw/block/nvme: add basic read/write for zoned namespaces"=0D
    - The device will now transition all opened zones to Closed on=0D
      "normal shutdown". You can force the "transition to Full" behavior=0D
      by killing QEMU from the monitor.=0D
=0D
  * "hw/block/nvme: add the zone append command"=0D
    - Slightly reordered the logic so a LBA Out of Range error is=0D
      returned before Invalid Field in Command for normal read/write=0D
      commands.=0D
=0D
  * "hw/block/nvme: support zone active excursions"=0D
    - Dropped. Optional and non-critical.=0D
=0D
  * "hw/block/nvme: support reset/finish recommended limits"=0D
    - Dropped. Optional and non-critical.=0D
=0D
Gollu Appalanaidu (1):=0D
  hw/block/nvme: add commands supported and effects log page=0D
=0D
Klaus Jensen (8):=0D
  hw/block/nvme: add uuid namespace parameter=0D
  hw/block/nvme: support namespace types=0D
  hw/block/nvme: add basic read/write for zoned namespaces=0D
  hw/block/nvme: add the zone management receive command=0D
  hw/block/nvme: add the zone management send command=0D
  hw/block/nvme: add the zone append command=0D
  hw/block/nvme: track and enforce zone resources=0D
  hw/block/nvme: allow open to close zone transitions by controller=0D
=0D
 docs/specs/nvme.txt   |   17 +=0D
 hw/block/nvme-ns.h    |  112 +++-=0D
 hw/block/nvme.h       |   23 +=0D
 include/block/nvme.h  |  216 ++++++-=0D
 block/nvme.c          |    4 +-=0D
 hw/block/nvme-ns.c    |  172 +++++-=0D
 hw/block/nvme.c       | 1284 +++++++++++++++++++++++++++++++++++++++--=0D
 hw/block/trace-events |   27 +-=0D
 8 files changed, 1791 insertions(+), 64 deletions(-)=0D
=0D
-- =0D
2.28.0=0D
=0D

