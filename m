Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAB6C07542
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942032075E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942032075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43165 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUYNh-0006Kj-Qs
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 11:14:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYM3-0005Fq-Cl
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYM1-00014r-UR
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:13:03 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:34378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hUYM1-0000x0-ON
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:13:01 -0400
Received: from player698.ha.ovh.net (unknown [10.109.160.244])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id EB11112C3B5
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 17:12:52 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player698.ha.ovh.net (Postfix) with ESMTPSA id 866E6625A6BA;
	Sat, 25 May 2019 15:12:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 May 2019 17:12:22 +0200
Message-Id: <20190525151241.5017-1-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6589892155795213073
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddukedgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.63.230
Subject: [Qemu-devel] [PATCH 00/19] aspeed: machine extensions and fixes
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

This series improves the current models of the Aspeed machines in QEMU
and adds new ones. It also prepares ground for the future Aspeed SoC.
You will find patches for :

 - per SoC mappings of the memory space and the interrupt number space=20
 - a RTC model from Joel
 - support for multiple CPUs and NICs
 - fixes for the timer model from Joel, Andrew and Christian
 - DMA support for the SMC controller, which was reworked to use a RAM
   container region as suggested by Peter in September 2018

It is based on Eduardo's series" Machine Core queue, 2019-05-24"

  http://patchwork.ozlabs.org/patch/1105091/

I have included Philippe's patch (comes first) in this patchset for
reference only.

Thanks,

C.

Andrew Jeffery (3):
  aspeed/timer: Status register contains reload for stopped timer
  aspeed/timer: Fix match calculations
  aspeed/timer: Provide back-pressure information for short periods

Christian Svensson (2):
  aspeed/timer: Ensure positive muldiv delta
  aspeed/smc: Calculate checksum on normal DMA

C=C3=A9dric Le Goater (10):
  aspeed: add a per SoC mapping for the interrupt space
  aspeed: add a per SoC mapping for the memory space
  aspeed: introduce a configurable number of CPU per machine
  aspeed: add support for multiple NICs
  aspeed/smc: add a 'sdram_base' propertie
  aspeed: remove the "ram" link
  aspeed: add a RAM memory region container
  aspeed/smc: add support for DMAs
  aspeed/smc: add DMA calibration settings
  aspeed/smc: inject errors in DMA checksum

Joel Stanley (3):
  hw: timer: Add ASPEED RTC device
  hw/arm/aspeed: Add RTC to SoC
  aspeed/timer: Fix behaviour running Linux

Philippe Mathieu-Daud=C3=A9 (1):
  hw/arm/aspeed: Use object_initialize_child for correct ref. counting

 include/hw/arm/aspeed.h         |   1 +
 include/hw/arm/aspeed_soc.h     |  48 ++++-
 include/hw/ssi/aspeed_smc.h     |   9 +
 include/hw/timer/aspeed_rtc.h   |  31 +++
 include/hw/timer/aspeed_timer.h |   1 +
 hw/arm/aspeed.c                 |  35 ++--
 hw/arm/aspeed_soc.c             | 283 ++++++++++++++++++----------
 hw/misc/aspeed_scu.c            |   6 +
 hw/ssi/aspeed_smc.c             | 323 +++++++++++++++++++++++++++++++-
 hw/timer/aspeed_rtc.c           | 180 ++++++++++++++++++
 hw/timer/aspeed_timer.c         |  84 ++++++---
 hw/timer/Makefile.objs          |   2 +-
 hw/timer/trace-events           |   4 +
 13 files changed, 854 insertions(+), 153 deletions(-)
 create mode 100644 include/hw/timer/aspeed_rtc.h
 create mode 100644 hw/timer/aspeed_rtc.c

--=20
2.20.1


