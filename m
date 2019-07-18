Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA5C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6A021019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6A021019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho507-0004dp-N0
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 07:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58509)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1ho4zk-0003pQ-Re
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ho4zj-0001QS-K6
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:54:44 -0400
Received: from 7.mo179.mail-out.ovh.net ([46.105.61.94]:43594)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ho4zj-0001J6-DT
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:54:43 -0400
Received: from player778.ha.ovh.net (unknown [10.109.159.90])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2404C138F79
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 13:54:33 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 45765801F1BE;
 Thu, 18 Jul 2019 11:54:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 13:54:03 +0200
Message-Id: <20190718115420.19919-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6771443516498152422
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.61.94
Subject: [Qemu-devel] [PATCH v2 00/17] ppc/pnv: add XIVE support for KVM
 guests
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

The QEMU PowerNV machine emulates a baremetal OpenPOWER system and
acts as an hypervisor (L0). Supporting emulation of KVM to run guests
(L1) requires a few more extensions, among which guest support for the
XIVE interrupt controller on POWER9 processor.

The following changes include some fixes for the PowerNV machine and
provide support for XIVE escalations and interrupt resend. This
mechanism is used by XIVE to notify the hypervisor that a vCPU is not
dispatched on a HW thread. Tested on a QEMU PowerNV machine and a
simple QEMU pseries guest doing network on a local bridge.

The XIVE interrupt controller offers a way to increase the XIVE
resources per chip by configuring multiple XIVE blocks on a chip. This
is not currently supported by the model. However, some configurations,
such as OPAL/skiboot, use one block-per-chip configuration with some
optimizations. One of them is to override the hardwired chip ID by the
block id in the PowerBUS operations and for CAM compares. This
patchset improves the support for this setup. Tested with 4 chips.

A series from Suraj adding guest support in the Radix MMU model of the
QEMU PowerNV machine is still required and will be send later. The
whole patchset can be found under :

  https://github.com/legoater/qemu/tree/powernv-4.1

Thanks,

C.

Changes since v1:

 - minor extra fixes=20
 - split the escalation support in different patches
 - kept the XiveRouter type for XiveTCTX back pointer (will address
   this in P10)
 - removed pnv_xive_vst_size(). Really broken on indirect tables.
 - improved the dump of the NVT table
 - introduce pnv_xive_get_block_id()


C=C3=A9dric Le Goater (17):
  ppc/xive: use an abstract type for XiveNotifier
  ppc/pnv: add more dummy XSCOM addresses for the P9 CAPP
  ppc/xive: Implement TM_PULL_OS_CTX special command
  ppc/xive: Provide backlog support
  ppc/xive: Provide escalation support
  ppc/xive: Provide unconditional escalation support
  ppc/xive: Provide silent escalation support
  ppc/xive: Improve 'info pic' support
  ppc/xive: Extend XiveTCTX with a XiveRouter pointer
  ppc/xive: Introduce xive_tctx_ipb_update()
  ppc/xive: Synthesize interrupt from the saved IPB in the NVT
  ppc/pnv: Remove pnv_xive_vst_size() routine
  ppc/pnv: Dump the XIVE NVT table
  ppc/pnv: Skip empty slots of the XIVE NVT table
  ppc/pnv: Grab the XiveRouter object from XiveTCTX in
    pnv_xive_get_tctx()
  ppc/pnv: Introduce a pnv_xive_get_block_id() interface to XiveRouter
  ppc/pnv: quiesce some XIVE errors

 include/hw/ppc/pnv_xive.h  |   3 -
 include/hw/ppc/xive.h      |  21 +--
 include/hw/ppc/xive_regs.h |  34 +++++
 hw/intc/pnv_xive.c         | 210 +++++++++++++------------
 hw/intc/spapr_xive.c       |   7 +-
 hw/intc/xive.c             | 304 ++++++++++++++++++++++++++++++-------
 hw/ppc/pnv_xscom.c         |  20 +++
 7 files changed, 428 insertions(+), 171 deletions(-)

--=20
2.21.0


