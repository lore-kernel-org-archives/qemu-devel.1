Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D36AC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0BA221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0BA221EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJNIj-0002H5-KH
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7R-0004jb-4E; Fri, 18 Sep 2020 16:36:33 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:52351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kJN7N-0004wO-ES; Fri, 18 Sep 2020 16:36:32 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailnew.nyi.internal (Postfix) with ESMTP id F04665801ED;
 Fri, 18 Sep 2020 16:36:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 18 Sep 2020 16:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=fm1; bh=mqhEPj63bscuS/IshS3/d9+R1S
 bjeugFll2BFQi7Qkc=; b=C7sBks+JqUAAozEiZM71oqHAIBPehbHaJraOylwkWa
 1QAAfSXU2B12wp3QskXJd5ehMYAnHZXp9xbqLgke/tVSdd9H3CmmWQ+O7qEspEYo
 27FuElv48mKtuNMvumbnLB+RRrtfsWIVGlhiyVoEXGSZh16/QuYKaxuE2FOAGN/X
 XlI3qjlESMpDq75J6lkpY6MyzG2//DieEcf1l6TAL7jJkuRJyCoXfcZikVkygjQh
 LGEaqLa4QjI22gmlyy+8sSca4wVbGINXF5U7BrcqiWh4sJc0w3Xqww3kDVCKZoVR
 uS4e2M+9dpbe5BJ4kX3C5yDZPOvZH4jZJHgZsfNttl9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mqhEPj
 63bscuS/IshS3/d9+R1SbjeugFll2BFQi7Qkc=; b=jZvFtzmqg9fiyedsBvvt/6
 7h3vbDluIOpOy1CqfrzF0zRWNeUhOzqbnjARSnI/F6ZjdZzXtWAXK73rGkNC6lM8
 IlXjdqlpPwvOAbxZpAM8pW5XtLjfi67N1MMkpg1+kFRBFKqv5bSj/zJU7EaFxIEP
 bM03+6N7mLD6LG3QODn2zJwTr2NF553gRyJJcxZlbAxwYn9tWjHPwji8+f5LCIwQ
 ZJji2FXtSonB4quJXs2ZFvsz9FsBotmbfLR5dzwtXHmsUqh0SCeLAnGcxYG40USL
 kRyQJ74p1Lgu7vL6NTRUU0HpfC8Y9JWzYnj39k8Tsmjf6XV/duv2wC0xTMaO9GAQ
 ==
X-ME-Sender: <xms:SBplX94PGA7qn5-voOOPss1d8RQgWtrCeP9wKb6MXcDaoEwbhiiqiw>
 <xme:SBplX65RHgupaXSajzK9W-Cj6ZI2qKkSgSloItSaVPfLqxM1bOi5IXYElS2_Y0BJA
 4_7jZYEjHm9VDHyCJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtdeigdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffogggtgfesthhqredtredtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepfeduheefudfghfdutdetffefleeutddttefgudeludduudfguefhleeuueeugffg
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:SBplX0dzEyEUYJrO-9IQEX3JmQl2RnRzeiJxPqrUe_jDWNb3-NGl9w>
 <xmx:SBplX2JLMav7XJ5Z6e4fRjkH7LqUV0iZ2WRSxt45YDxRN2TdkZF5Wg>
 <xmx:SBplXxLpUuRP2-nvaEOG3d3W7IX-8lP4zKByDK3XcPCklbKx_he4FQ>
 <xmx:ShplX2qjl0Qd8DIQl1qsQQ0njwsw-1VLJdDq_1_Kx_ej-JOxoAkj_g>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 299ED3064674;
 Fri, 18 Sep 2020 16:36:23 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/17] hw/block/nvme: multiple namespaces support
Date: Fri, 18 Sep 2020 22:36:04 +0200
Message-Id: <20200918203621.602915-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.221; envelope-from=its@irrelevant.dk;
 helo=new1-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 16:36:27
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
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
 hw/block/nvme.h        |  94 ++++-=0D
 include/block/nvme.h   |   6 +-=0D
 include/hw/pci/pci.h   |   4 +-=0D
 hw/block/nvme-ns.c     | 167 ++++++++=0D
 hw/block/nvme.c        | 846 ++++++++++++++++++++++++++++++-----------=0D
 hw/core/machine.c      |   1 +=0D
 MAINTAINERS            |   1 +=0D
 hw/block/meson.build   |   2 +-=0D
 hw/block/trace-events  |  22 +-=0D
 12 files changed, 986 insertions(+), 255 deletions(-)=0D
 create mode 100644 docs/specs/nvme.txt=0D
 create mode 100644 hw/block/nvme-ns.h=0D
 create mode 100644 hw/block/nvme-ns.c=0D
=0D
-- =0D
2.28.0=0D
=0D

