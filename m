Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40594C5B576
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5862089F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5862089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhgkZ-0001Va-BH
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 16:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hhgiS-0008Ef-IB
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hhgiR-0001sJ-Av
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:46:28 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:33590)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hhgiN-0001hm-Fy
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:46:25 -0400
Received: from player157.ha.ovh.net (unknown [10.108.42.192])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 719CC1358FC
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 22:46:13 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 761377575A12;
 Sun, 30 Jun 2019 20:46:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 30 Jun 2019 22:45:51 +0200
Message-Id: <20190630204601.30574-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2275443714157612006
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdeggdduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.78.111
Subject: [Qemu-devel] [PATCH 00/10] ppc/pnv: add XIVE support for KVM guests
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
 Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

The QEMU PowerNV machine emulates a baremetal OpenPOWER system and
acts as an hypervisor (L0). Supporting emulation of KVM to run guests
(L1) requires a few more extensions, among which support for the XIVE
interrupt controller on POWER9 processor.=20

The following changes fix some parts of the XIVE model and provide
support for escalations and resend. This mechanism is used by KVM to
kick a vCPU when it is not dispatched on a HW thread.

A series from Suraj adding guest support in the Radix MMU model of the
QEMU PowerNV machine is still required and will be send later. The
whole patchset can be found under :

  https://github.com/legoater/qemu/tree/powernv-4.1

Thanks,

C.

C=C3=A9dric Le Goater (10):
  ppc/xive: Force the Physical CAM line value to group mode
  ppc/xive: Make the PIPR register readonly
  ppc/pnv: Rework cache watch model of PnvXIVE
  ppc/xive: Fix TM_PULL_POOL_CTX special operation
  ppc/xive: Implement TM_PULL_OS_CTX special command
  ppc/xive: Provide escalation support
  ppc/xive: Improve 'info pic' support
  ppc/xive: Extend XiveTCTX with an router object pointer
  ppc/xive: Synthesize interrupt from the saved IPB in the NVT
  ppc/pnv: Dump the XIVE NVT table

 include/hw/ppc/xive.h      |  23 ++-
 include/hw/ppc/xive_regs.h |  13 ++
 hw/intc/pnv_xive.c         | 211 +++++++++++++++++++----
 hw/intc/spapr_xive.c       |   1 -
 hw/intc/xive.c             | 341 +++++++++++++++++++++++++++++--------
 hw/ppc/pnv.c               |   2 +-
 hw/ppc/spapr_irq.c         |   2 +-
 7 files changed, 479 insertions(+), 114 deletions(-)

--=20
2.21.0


