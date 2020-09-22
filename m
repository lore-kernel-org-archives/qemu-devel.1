Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC52C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7933221EB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7933221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKe00-000071-IF
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdvh-0005mv-Rl; Tue, 22 Sep 2020 04:45:41 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:58671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kKdve-0000sa-DU; Tue, 22 Sep 2020 04:45:41 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id D89B85803C0;
 Tue, 22 Sep 2020 04:45:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 22 Sep 2020 04:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=fm1; bh=iyfc7acZGLQOgH27pF4waqX06L
 BeQe8tSacA8+qvrvg=; b=OYuoxtBklOjdoqF73NXMO4ToV5aHEzdMuINirMSN2C
 d/pTeyRhrLTulaHZuiEBQl5szNarMlqIMgeowa2up1tLxlbakqYG349WVjE/fNaI
 p5fUb4NL70dByl3CqJ0h0uCHzcaGFoaeoLh7+vgk+nyoxuETT2R4z76VcFMkbNW1
 pASGzTDKjeBwlOt+v78Z5IUuhWNcSLzc9R3O9s3iGDKz4Civ9q8PJkHCuqhwGXeK
 7c5oxZkLoTz/qF3OTpqeaMDGF916roncM+9NqjLikMHLRgJ6o1QGGoWXHLfklLhQ
 eYWYzGosE5qajVlDzbFzyRErLLUY0tzhL2FDctU3vg3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=iyfc7a
 cZGLQOgH27pF4waqX06LBeQe8tSacA8+qvrvg=; b=Z/4pFjRQTkg6WLAWEdjmJ9
 rON8vT+Z6l9MWB/bIH5DHov9pqOH74/MS6xsssXlVNyfdA6IzcXylUnIcOnc+RlN
 WSXaeXK0lFuFPwED8ApLG75Tx5XFBgiP/lb0SV4mIW9heajmGhwX8kTAGccjxbYf
 fBtx9/jMDhD7klq7qyAgvq5SXbf/mzhh1/eD7kJ1QGQ8uQytsURWBETCgDSyC4e9
 t9CscaF6vaqbFJGhIkFn+E7e6Sm/gkEsz4LVkcezPrH4ISxyN1I/7X9FgxQxHwEo
 pga/Tbe3uN3DfpjIzl16u3BFn0DUG0LI9x2+m39cEI9/BXjrGwPJ4xXCfCEssOwg
 ==
X-ME-Sender: <xms:r7lpX1wK0Wm_dLwTrLt4EgQGZkx1XTvvkAis92nufMP7z4kpfJyR0Q>
 <xme:r7lpX1QtFnr2h5TK9zy_I_wcDhMdkRdGYEusQ8W4p1Cm3UlvserzpOx14Af8_TbRQ
 10D35OMIjqQKq4T1J8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggddtkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofggtgfgsehtqhertdertdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeefudehfedugffhuddttefffeeluedttdetgfduleduuddugfeuhfelueeuuefggfen
 ucfkphepkedtrdduieejrdelkedrudeltdenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:r7lpX_Uc-4CbXZ-xPLorTanK6wZjfJe5gbWH1BOFVBkuBCUxjruirA>
 <xmx:r7lpX3jervOC3qHpyJy85ysHxbdMQsh-z8sYwyDLR3ErEJE-Wh66Og>
 <xmx:r7lpX3BNOEACkp5boz5kQvDVRmIyeTUkWrUnECykJLVzZKy2SAr1Wg>
 <xmx:sLlpX5C0dShh-qWGf_uETT8FeR-Nm1hU0onVfycUFCYuvas0fxEU0g>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 15FF63064682;
 Tue, 22 Sep 2020 04:45:33 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/17] hw/block/nvme: multiple namespaces support
Date: Tue, 22 Sep 2020 10:45:16 +0200
Message-Id: <20200922084533.1273962-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.230; envelope-from=its@irrelevant.dk;
 helo=new4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 04:45:36
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>=0D

This is the next round of my patches for the nvme device.=0D
=0D
This includes a bit of cleanup and two new features:=0D
=0D
  * support for scatter/gather lists=0D
=0D
  * multiple namespaces support through a new nvme-ns device=0D
=0D
Finally, the series wraps up with changing the PCI vendor and device ID to =
get=0D
rid of the internal Intel id and as a side-effect get rid of some Linux ker=
nel=0D
quirks that no longer applies.=0D
=0D
"pci: pass along the return value of dma_memory_rw" has already been posted=
 by=0D
Philippe in another series, but since it is not applied yet, I am including=
 it=0D
here.=0D
=0D
Changes for v3=0D
~~~~~~~~~~~~~~=0D
=0D
  * hw/block/nvme: handle dma errors=0D
    Do not retry DMA, just set Controller Fatal Status (CFS). This causes=0D
    the Linux kernel to most likely disable the controller when running the=
=0D
    blktests block/011 test case, which causes some havoc when running=0D
    blktests, but I have submitted a patch for blktests to fix this. (Keith=
)=0D
=0D
  * hw/block/nvme: refactor aio submission=0D
    Dropped the unneeded nvme_req_is_write function. (Keith)=0D
=0D
  * Added R-b's from Keith and Philippe.=0D
=0D
Changes for v2=0D
~~~~~~~~~~~~~~=0D
=0D
  * Added a new patch ("hw/block/nvme: fix typo in trace event") that does =
what=0D
    it says on the tin.=0D
=0D
  * Dropped the "hw/block/nvme: support multiple parallel aios per request"=
=0D
    patch (Keith).=0D
=0D
  * hw/block/nvme: add symbolic command name to trace events=0D
    Changed to single quote (Philippe)=0D
=0D
  * hw/block/nvme: default request status to success=0D
    Commit message typo fixed (Philippe)=0D
=0D
  * hw/block/nvme: change controller pci id=0D
    Do NOT bump the device id for the legacy Intel id (David)=0D
=0D
Gollu Appalanaidu (1):=0D
  hw/block/nvme: add support for sgl bit bucket descriptor=0D
=0D
Klaus Jensen (16):=0D
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
=0D
 docs/specs/nvme.txt    |  23 ++=0D
 docs/specs/pci-ids.txt |   1 +=0D
 hw/block/nvme-ns.h     |  74 ++++=0D
 hw/block/nvme.h        |  83 +++-=0D
 include/block/nvme.h   |   6 +-=0D
 include/hw/pci/pci.h   |   4 +-=0D
 hw/block/nvme-ns.c     | 167 ++++++++=0D
 hw/block/nvme.c        | 848 ++++++++++++++++++++++++++++++-----------=0D
 hw/core/machine.c      |   1 +=0D
 MAINTAINERS            |   1 +=0D
 hw/block/meson.build   |   2 +-=0D
 hw/block/trace-events  |  23 +-=0D
 12 files changed, 978 insertions(+), 255 deletions(-)=0D
 create mode 100644 docs/specs/nvme.txt=0D
 create mode 100644 hw/block/nvme-ns.h=0D
 create mode 100644 hw/block/nvme-ns.c=0D
=0D
-- =0D
2.28.0=0D
=0D

