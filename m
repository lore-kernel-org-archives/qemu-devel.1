Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB48C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C323A216F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C323A216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40693 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQIt-0004jb-TD
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:24:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hOQEi-0000oZ-11
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hOQEh-0003mX-0w
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:20:08 -0400
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:56492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hOQEg-0003iH-Q8
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:20:06 -0400
Received: from player711.ha.ovh.net (unknown [10.108.57.43])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 3DA55123F18
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 19:19:56 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player711.ha.ovh.net (Postfix) with ESMTPSA id 1F185576934F;
	Wed,  8 May 2019 17:19:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  8 May 2019 19:19:43 +0200
Message-Id: <20190508171946.657-1-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1133499731866979302
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkeefgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.63.100
Subject: [Qemu-devel] [PATCH 0/3] spapr/xive: fixes on EQ page addresses
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello

Here is a small series adding a check on the EQ page address alignment
and fixing a severe issue when addresses are above 64GB.

Thanks,

C.

C=C3=A9dric Le Goater (3):
  spapr/xive: EQ page should be naturally aligned
  spapr/xive: fix EQ page addresses above 64GB
  spapr/xive: print out the EQ page address in the monitor

 include/hw/ppc/xive_regs.h |  6 ++++++
 hw/intc/spapr_xive.c       | 14 ++++++++++----
 hw/intc/xive.c             |  9 +++------
 3 files changed, 19 insertions(+), 10 deletions(-)

--=20
2.20.1


