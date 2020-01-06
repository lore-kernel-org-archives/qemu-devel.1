Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B363CC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEF820707
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEF820707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioU7x-0007Me-QA
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ioToQ-0008Nj-Dt
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ioToO-0000Ik-Hc
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:56:58 -0500
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:57736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ioToO-0000Hh-AJ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:56:56 -0500
Received: from player731.ha.ovh.net (unknown [10.108.35.27])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id C32F11F7B4B
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 15:56:53 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 335BADB3A3AC;
 Mon,  6 Jan 2020 14:56:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 00/12] ppc/pnv: remove the use of qdev_get_machine()
Date: Mon,  6 Jan 2020 15:56:33 +0100
Message-Id: <20200106145645.4539-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 5383208932196191206
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.177.69
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

The PowerNV and sPAPR machine use qdev_get_machine() in some places.
This is not a good modeling pratice and it should be avoided. This
series replaces the use of this routine with a set of QOM properties
and aliases.

Thanks,

C.

Changes since v2:

 - rebase on latest ppc tree
 - dropped get_system_memory() removal
 - addition of a couple of cleanup patches of the PSI model from Greg

Changes since v1:

 - fixed a missing assert(chip->system_memory)
 - introduced a XivePresenter link under XiveTCTX
=20
C=C3=A9dric Le Goater (3):
  ppc/pnv: Introduce a "xics" property alias under the PSI model
  ppc/pnv: Introduce a "xics" property under the POWER8 chip
  xive: Add a "presenter" link property to the TCTX object

Greg Kurz (9):
  pnv/xive: Use device_class_set_parent_realize()
  spapr, pnv, xive: Add a "xive-fabric" link to the XIVE router
  xive: Use the XIVE fabric link under the XIVE router
  ppc/pnv: Add an "nr-threads" property to the base chip class
  ppc/pnv: Add a "pnor" const link property to the BMC internal
    simulator
  spapr/xive: Deduce the SpaprXive pointer from XiveTCTX::xptr
  pnv/xive: Deduce the PnvXive pointer from XiveTCTX::xptr
  pnv/psi: Add device reset hook
  pnv/psi: Consolidate some duplicated code in pnv_psi_realize()

 include/hw/ppc/pnv.h      |  7 +++--
 include/hw/ppc/pnv_xive.h | 10 +++++++
 include/hw/ppc/xive.h     | 13 +++++----
 hw/intc/pnv_xive.c        | 18 ++++++++----
 hw/intc/spapr_xive.c      |  2 +-
 hw/intc/spapr_xive_kvm.c  |  9 +++---
 hw/intc/xive.c            | 28 ++++++++++++++++---
 hw/ppc/pnv.c              | 59 ++++++++++++++++++++++-----------------
 hw/ppc/pnv_bmc.c          |  8 ++++--
 hw/ppc/pnv_psi.c          | 43 ++++++++++++++++------------
 hw/ppc/spapr_irq.c        |  2 ++
 11 files changed, 129 insertions(+), 70 deletions(-)

--=20
2.21.1


