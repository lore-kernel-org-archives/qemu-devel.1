Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7400C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A76520773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 23:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A76520773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOxf-0002UE-Pb
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 19:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOu7-0000UM-DB; Tue, 29 Sep 2020 19:19:27 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:41317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kNOu5-00007o-6A; Tue, 29 Sep 2020 19:19:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id 45583F11;
 Tue, 29 Sep 2020 19:19:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 29 Sep 2020 19:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=fm1; bh=E+sX1lwObBdNstk9+Ral8pxNrm
 qIX63dHpQucV76Wyc=; b=fwCZYYwxzCjMQhVHJA640FOKo2xgRnNM7mIXFyhKhq
 MfpSL9Lzb3wbm6CYjMS0irr2/X2148WEaARlRKDg0MrKg7inD3HP9MBFBhXmf0pw
 9EBmtp7XuB4YEL8GWJ14rdBICSJaih/1cICKB4SwBtstdI/kE75h+EdeAF03GStO
 54sRoH3NPpDVUjJpjVfIjh4PPQoIsuy33P3z2RhScvw87kgvICBxUuV61mMvM+3S
 4hqv0cBT2qNsNSwlJs6zhQdIXtnJcHi/tSAlD4SBAAPCTPDkSbM0GsQztKoioI8s
 PZ3JdbtYkXTzkNIi7WJ8JWwzw1Z5O90KKl2aoJPZHFZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=E+sX1l
 wObBdNstk9+Ral8pxNrmqIX63dHpQucV76Wyc=; b=dYqLw4Thi4mg9R4y9steA4
 I0Mkr13WIsSkbR9PaG/gcqGy125zfUfxPap4lpC/IRJr1Wub6TeRATnqnBsOYdeg
 exPC8LZN/QbCBSlJf72AFCKe9Z3xKTHEmg0LDMY8l/CXtQTzJjRfhtR54T1HeJWA
 jibFbq0y2X9xQAcH7hH6Q4p3r4RQEnxWm3OQMdkWd6jvWFvQKg+WVeothy+5dmM7
 3zgq4s0YbYoLPjpBFTBNZ0GSbKYDZihVta/2dc3A9WN0BjfwncPE38a57rVmQ/+7
 UkfeJ3ifdbFBJWGe9kCaQpxPdKzemVmTDlbcOoTRu5ypiDscxRwQPEdgQr2Lz/DA
 ==
X-ME-Sender: <xms:-MBzX7W-hblNBxf3zLm4b61iR4wBgUDSg97zYCWIuGIzGp_V5ppsqw>
 <xme:-MBzXzntGjSRylUJkfJxw_4DC5v-r8BqoTczwmkk710hwyxtTPLdx8SIJY2nRgDZ2
 nIVMDdJlq1CZPwOYfI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfedtgddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofggtgfgsehtqhertdertdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeefudehfedugffhuddttefffeeluedttdetgfduleduuddugfeuhfelueeuuefggfen
 ucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:-MBzX3aPhHZaFlynwltgNBW3GUitxZ8SjmAFqJOpddCksam6IPXneg>
 <xmx:-MBzX2WFAGnv6DWDkKLTY5RkkXAVi--MgsBTsKr3-hiBCba5pVlKxg>
 <xmx:-MBzX1lOcfhXzeeWqZgZMnZGZz8qWrmVYJRL5hrMMEntuSXcc5EZZQ>
 <xmx:-cBzX4sJK8VJ__gR7XkPSDhPgQDfe-Tq32L_zQ53BJvQrNUgSzyEy8uZ3xM>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2033A3280063;
 Tue, 29 Sep 2020 19:19:19 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/14] hw/block/nvme: zoned namespace command set
Date: Wed, 30 Sep 2020 01:19:03 +0200
Message-Id: <20200929231917.433586-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=64.147.123.27; envelope-from=its@irrelevant.dk;
 helo=wnew2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 17:46:07
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>=0D

So, things escalated a bit.=0D
=0D
I'm removing the old cover letter. I don't think we need it anymore - you a=
ll=0D
know the reason I keep posting versions of this implementation ;)=0D
=0D
Based-on: <20200922084533.1273962-1-its@irrelevant.dk>=0D
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
Klaus Jensen (13):=0D
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
=0D
 docs/specs/nvme.txt   |   47 +-=0D
 hw/block/nvme-ns.h    |  180 ++++-=0D
 hw/block/nvme.h       |   22 +=0D
 include/block/nvme.h  |  230 +++++-=0D
 block/nvme.c          |    4 +-=0D
 hw/block/nvme-ns.c    |  456 +++++++++++-=0D
 hw/block/nvme.c       | 1560 +++++++++++++++++++++++++++++++++++++++--=0D
 hw/block/trace-events |   42 +-=0D
 8 files changed, 2443 insertions(+), 98 deletions(-)=0D
=0D
-- =0D
2.28.0=0D
=0D

