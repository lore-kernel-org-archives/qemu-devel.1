Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826B4C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4936C2183E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4936C2183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbpm1-0001eQ-Ji
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53696)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hbphI-0005ij-0b
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hbpY9-0007KI-7S
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:59:38 -0400
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:36350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hbpY9-0007IE-25
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:59:37 -0400
Received: from player692.ha.ovh.net (unknown [10.108.54.94])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id F190A1304F3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 18:59:33 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id EC5516DB37D4;
 Fri, 14 Jun 2019 16:59:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 14 Jun 2019 18:59:18 +0200
Message-Id: <20190614165920.12670-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 15165027323183860710
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeiuddguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.79.46
Subject: [Qemu-devel] [PATCH 0/2] spapr/xive: rework the mapping the KVM
 memory regions
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

Here is a small series simplifying the initialization sequence of the
interrupt device by using memory regions specific for KVM. These are
mapped as overlaps on top of the emulated device.

Thanks,

C.

C=C3=A9dric Le Goater (2):
  spapr/xive: rework the mapping the KVM memory regions
  spapr/xive: simplify spapr_irq_init_device() to remove the emulated
    init

 include/hw/ppc/spapr_irq.h  |  1 -
 include/hw/ppc/spapr_xive.h |  2 +-
 include/hw/ppc/xive.h       |  1 +
 hw/intc/spapr_xive.c        | 38 ++++++++++---------------------------
 hw/intc/spapr_xive_kvm.c    | 21 +++++++++++---------
 hw/ppc/spapr_irq.c          | 21 +++-----------------
 6 files changed, 27 insertions(+), 57 deletions(-)

--=20
2.21.0


