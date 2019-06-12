Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8230C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B1921019
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B1921019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb7Ri-0000ea-CH
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 13:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42006)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hb7Hy-00019C-P5
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hb7Hx-0005x1-NB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:43:58 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:55749)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hb7Hx-0005w1-GB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:43:57 -0400
Received: from player792.ha.ovh.net (unknown [10.109.146.53])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 6441069056
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 19:43:54 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id 9D7A16D91679;
 Wed, 12 Jun 2019 17:43:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 12 Jun 2019 19:43:43 +0200
Message-Id: <20190612174345.9799-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 4168644409195989990
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehjedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.44.197
Subject: [Qemu-devel] [PATCH 0/2] ppc/pnc: fix XSCOM MMIO base address for
 P9 machines with multiple chips
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

The base address of the MMIO window of the XSCOM bus is incorrect on
P9 machines with multiple chips. Provide a fix for that to prepare
ground for future PowerNV chips.

Thanks,

C.


C=C3=A9dric Le Goater (2):
  ppc/pnc: fix XSCOM MMIO base address for P9 machines with multiple
    chips
  ppc/pnc: remove xscom_base field from PnvChip

 include/hw/ppc/pnv.h       |  8 ++++----
 include/hw/ppc/pnv_xscom.h |  2 +-
 hw/ppc/pnv.c               | 34 ++++++++++++++++------------------
 hw/ppc/pnv_xscom.c         | 17 ++++++++++++-----
 4 files changed, 33 insertions(+), 28 deletions(-)

--=20
2.21.0


