Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035EAC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75281206ED
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75281206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTIg-0001Us-5q
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXTE0-0006C3-R5; Tue, 27 Oct 2020 13:57:37 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kXTDv-00075F-D3; Tue, 27 Oct 2020 13:57:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 999FE5C0131;
 Tue, 27 Oct 2020 13:57:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Tue, 27 Oct 2020 13:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=from:to:cc:subject:date:message-id:content-type:mime-version
 :content-transfer-encoding; s=fm1; bh=RV+MSRaYvx9TQg9woFBAcow8Ke
 RoNCksLqM1eNRZEwI=; b=g6B6fgzWS3C46RZHN0xteMVQZQfeFi5H4OCTJeYwRS
 iHh59KnV0kM9721SlVzkAo/lnmUxZKZ0zA7oclBfsPr59DTjnsDxjQgpW4nKqnNy
 //BNl5KcuA7+afAww4dYKR1+HplA6s2RAkkbsLS/BqV3wnmiiswQIobKTqcpfFQw
 hsHN2KZXnhyA0OeD3KFjQEc11QG2FS5W03wTuzsIHNoEdJdJBZtNVRJK23sZpw3x
 qgXxDWdOBEQHNbeKeeTLv+9Tbns3rxw2eUVdq/eInGxwndagQhNTh2WhTZVZJi9I
 C+fuia38olqaoCyQkXZizaotn+qARhJtD4RBHS28UhPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:message-id:mime-version:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RV+MSR
 aYvx9TQg9woFBAcow8KeRoNCksLqM1eNRZEwI=; b=ac+nCEZsTjbt5uSvA0Ks1d
 wv/2GsSdoSZY0oqT+Q8Rwkzxsf/+aFsPQGINDvi171EnuE/2/CGMfmhMrmgBve/R
 qYk3VG28iSSu7qyus6pSLOkSZQRcQiu28/kXirdXOyth9a77SRXzcHKpPErHn753
 LB5fbZ2jzFPgd1OUBOZ4V/aeQ2YPf1EtgMX8M0WfwaeRSPE3eYOgd92oXQcAnVI2
 k/+hG+r8tU+rpG7UZ2yW4+Ec70lceBEaGrKgNrSA7vtgRp8qOsZaSpnQoUAbEyFC
 RwIzGx2bzEy8mTYR2CQUaApsHksiOi53XDFGvrvDl2C95sNcanZ1TGKxCwD0xAdw
 ==
X-ME-Sender: <xms:iF-YXz4wjdLq_J3OR3yIAxkbQ51cMxoiulckEupJyu3UN-du2-fnIw>
 <xme:iF-YX45akwQQJFOAKQw4lCtTx9fvv9oFrTqdh8PUsvjvJjfHglMleqzBlK298BBbm
 CBjcVaDGvFXV1KpO8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddutdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffotggggfesthhqredtredtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhephfegveekiefgkeevvdetjeejkeekudfgvdehieejfffgkeffvdevlefftedvgefh
 necukfhppeektddrudeijedrleekrdduledtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:iF-YX6d6Yez544OMzL8AOc0UNT2l6ebAN96dQaDaNwPxI7zM7p_6Vw>
 <xmx:iF-YX0KvimKunrHP_iA2eLDD6VRZqk8agsnyrYzJValYj0AYwLOVjw>
 <xmx:iF-YX3KvnZc_zDznbsjd6H1TrOj95-rDLrBKmXmX0NQyd0YM58hBoQ>
 <xmx:iV-YX0GZ2qaAr_7PGbPJEjwK6_RPuhqAOPDF0KDCQQ2ooTLWpC3PDA>
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by mail.messagingengine.com (Postfix) with ESMTPA id 762AF3280067;
 Tue, 27 Oct 2020 13:57:27 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 0/3] hw/block/nvme: dulbe and dsm support
Date: Tue, 27 Oct 2020 18:57:22 +0100
Message-Id: <20201027175725.586890-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.29.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.28; envelope-from=its@irrelevant.dk;
 helo=out4-smtp.messagingengine.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 13:57:29
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
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>=0D

This adds support for the Deallocated or Unwritten Logical Block error=0D
recovery feature as well as the Dataset Management command.=0D
=0D
v7:=0D
  - Handle negative return value from bdrv_block_status.=0D
  - bdrv_get_info may not be supported on all block drivers, so do not=0D
    consider it a fatal error.=0D
=0D
v6:=0D
  - Skip the allocation of the discards integer and just use the opaque=0D
    value directly (Philippe)=0D
  - Split changes to include/block/nvme.h into a separate patch=0D
    (Philippe)=0D
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
 hw/block/nvme-ns.c    |  34 ++++++--=0D
 hw/block/nvme.c       | 193 +++++++++++++++++++++++++++++++++++++++++-=0D
 hw/block/trace-events |   4 +=0D
 6 files changed, 240 insertions(+), 9 deletions(-)=0D
=0D
-- =0D
2.29.1=0D
=0D

