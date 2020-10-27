Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0444C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A24E22258
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A24E22258
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXMcZ-00024t-8l
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXv-0008Nk-77; Tue, 27 Oct 2020 06:49:43 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXMXr-00023h-R4; Tue, 27 Oct 2020 06:49:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 48F855C011B;
 Tue, 27 Oct 2020 06:49:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 06:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=fm1; bh=YkplMDLkCre81nqC2py/rB/FGL
 /h3FSL0oo+/Pxh8Lk=; b=nZh1e+Uxfp7j5SYvQbzn+x65XZqXUFBARRbEsBOFxD
 9pLsF1+ZUYVah1hjVIj47221B4XaR/h4yIIPU0qknQVpOr+ukUBYe5yBm1W0MicT
 hPilC6WeqnZYCV43REP1xU23aYawPZUe/8LwQX8bWmAWPjoMG/kGz2uOVPe1zin8
 hFRlbtjGxAEr/8tzxFGxL4Z50T1ob3CbYwLES/kQF0jD+9U3iWLJml1z6DWAOf4s
 Pma3CzYUFLPlsj+B5gfonfCiSFOa88jokKQXQRASsGMDyOoPKs4d+kzcxNO1wf6R
 kABbjeqAg2kcOmAhlnLblpNIsrMHKN7wvRg//XWxV3Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YkplMD
 LkCre81nqC2py/rB/FGL/h3FSL0oo+/Pxh8Lk=; b=OedGqpJMjf9anrbTXn4DUn
 MiEipyupgl0o68O+nDW7PpFDRnz6wO8yNcJZiYP/WIUKZgEBMLbGsGArMi8k9eZX
 h/+15Lfb9BfKzuhRGn08QEb9kgCn6bvlAeEocuVdlDCZcC/6LTioq3XREne7MnEi
 D8cA/CM0UdJWLZXIItztlFDX1/a7b0k3eWfAPCWbGETQpALme7x20V+ycEfTKWPl
 BJqYmeYQx6Ptfl3WBIdj0slVZnJc+J7neyuLTg81/cZHjJnnwen3zhVFYmnsmX8z
 4CFVyHpTcC2+GgKEgrI06NW6t7oECfpP6//UuRWGLzxYVriSuiLoDBZk1NLPdG5w
 ==
X-ME-Sender: <xms:PvuXX38QK_AVdK1xTrTs4ibtUrtzC8LJRlQr3fI-NQcy7iuNHt64RA>
 <xme:PvuXXzs8MpJ5LQXAikPLCSNJFJuneSa0q8SVM9viVu-zMody1SqMeh-LG8iD3olxH
 FEH2evD5Q2OqJ0RgJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddvtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofggtgfgsehtqhertdertdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpedvhfeujeeujeekvddufedttedvtdfghfetleegleduvdevteeuhfefkeefueehgfen
 ucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucfkphepkedtrdduieejrdelke
 drudeltdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:PvuXX1D_RAml-IjV7QLgI99uIsjQL889a9bmsOufLb3jVOj12Xf62w>
 <xmx:PvuXXzcBZvKuWLHXtq14oPESDNDEMB3bWSjaf7r2VE257xsbYhHDbw>
 <xmx:PvuXX8Oyfefkg0fIaz9l7yW5TDx9U1RCfoWsNI9hQHTJLxviP56BWA>
 <xmx:QPuXXxoD2tfLfBxhxzboLUR9N3drk44s5fVe3lC98VXhGHjOoMh78Q>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id C0D653280063;
 Tue, 27 Oct 2020 06:49:33 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/30] nvme emulation patches for 5.2
Date: Tue, 27 Oct 2020 11:49:02 +0100
Message-Id: <20201027104932.558087-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.26; envelope-from=its@irrelevant.dk;
 helo=out2-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 06:49:36
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
Cc: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>=0D

Hi Peter,=0D
=0D
The following changes since commit 1dc887329a10903940501b43e8c0cc67af7c06d5=
:=0D
=0D
  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-20201026=
' into staging (2020-10-26 17:19:26 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.infradead.org/qemu-nvme.git tags/nvme-next-pull-request=0D
=0D
for you to fetch changes up to 843c8f91a7ad63f8f3e4e564d3f41f3d030ab8a9:=0D
=0D
  hw/block/nvme: fix queue identifer validation (2020-10-27 11:29:25 +0100)=
=0D
=0D
----------------------------------------------------------------=0D
nvme emulation patches for 5.2=0D
=0D
  - lots of cleanups=0D
  - add support for scatter/gather lists=0D
  - add support for multiple namespaces (adds new nvme-ns device)=0D
  - change default pci vendor/device id=0D
  - add support for per-namespace smart log=0D
=0D
----------------------------------------------------------------=0D
=0D
Dmitry Fomichev (1):=0D
  hw/block/nvme: report actual LBA data shift in LBAF=0D
=0D
Gollu Appalanaidu (4):=0D
  hw/block/nvme: add support for sgl bit bucket descriptor=0D
  hw/block/nvme: fix prp mapping status codes=0D
  hw/block/nvme: fix create IO SQ/CQ status codes=0D
  hw/block/nvme: fix queue identifer validation=0D
=0D
Keith Busch (5):=0D
  hw/block/nvme: remove pointless rw indirection=0D
  hw/block/nvme: fix log page offset check=0D
  hw/block/nvme: support per-namespace smart log=0D
  hw/block/nvme: validate command set selected=0D
  hw/block/nvme: support for admin-only command set=0D
=0D
Klaus Jensen (20):=0D
  hw/block/nvme: fix typo in trace event=0D
  pci: pass along the return value of dma_memory_rw=0D
  hw/block/nvme: handle dma errors=0D
  hw/block/nvme: commonize nvme_rw error handling=0D
  hw/block/nvme: alignment style fixes=0D
  hw/block/nvme: add a lba to bytes helper=0D
  hw/block/nvme: fix endian conversion=0D
  hw/block/nvme: add symbolic command name to trace events=0D
  hw/block/nvme: refactor aio submission=0D
  hw/block/nvme: default request status to success=0D
  hw/block/nvme: harden cmb access=0D
  hw/block/nvme: add support for scatter gather lists=0D
  hw/block/nvme: refactor identify active namespace id list=0D
  hw/block/nvme: support multiple namespaces=0D
  pci: allocate pci id for nvme=0D
  hw/block/nvme: change controller pci id=0D
  hw/block/nvme: update nsid when registered=0D
  hw/block/nvme: reject io commands if only admin command set selected=0D
  hw/block/nvme: add nsid to get/setfeat trace events=0D
  hw/block/nvme: add trace event for requests with non-zero status code=0D
=0D
 docs/specs/nvme.txt    |  23 +=0D
 docs/specs/pci-ids.txt |   1 +=0D
 hw/block/nvme-ns.h     |  74 ++++=0D
 hw/block/nvme.h        |  83 +++-=0D
 include/block/nvme.h   |  18 +-=0D
 include/hw/pci/pci.h   |   4 +-=0D
 hw/block/nvme-ns.c     | 168 ++++++++=0D
 hw/block/nvme.c        | 921 +++++++++++++++++++++++++++++------------=0D
 hw/core/machine.c      |   1 +=0D
 MAINTAINERS            |   1 +=0D
 hw/block/meson.build   |   2 +-=0D
 hw/block/trace-events  |  32 +-=0D
 12 files changed, 1025 insertions(+), 303 deletions(-)=0D
 create mode 100644 docs/specs/nvme.txt=0D
 create mode 100644 hw/block/nvme-ns.h=0D
 create mode 100644 hw/block/nvme-ns.c=0D
=0D
-- =0D
2.29.1=0D
=0D

