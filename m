Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C392FC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 05:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9616D218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 05:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9616D218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iApMN-0001q5-8P
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 01:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iApKb-0000Gd-2y
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 01:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iApKZ-0007QR-Ji
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 01:50:16 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:57369)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iApKZ-0007PX-Dn
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 01:50:15 -0400
Received: from player788.ha.ovh.net (unknown [10.108.57.38])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 4C0D124EF42
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 07:50:13 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id 9B3C79F172A3;
 Thu, 19 Sep 2019 05:50:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Sep 2019 07:49:41 +0200
Message-Id: <20190919055002.6729-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1662954162933959441
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelgdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.132
Subject: [Qemu-devel] [PATCH 00/21] aspeed: Add support for the AST2600 SoC
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

The series starts with a watchdog fix and a new model for the SDHCI
controller. Follows the code for the AST2600 SoC.

Most of the Aspeed models are reworked with an object class to
introduce the AST2600 variant. A model for the AST2600 SoC and a
simple AST2600 EVB machine is proposed at the end of the series. It
can boot the OpenBMC firmware image which is currently used for HW
bringup.

Thanks,

C.

Amithash Prasad (1):
  aspeed/wdt: Check correct register for clock source

C=C3=A9dric Le Goater (13):
  aspeed/timer: Introduce an object class per SoC
  aspeed/timer: Add support for control register 3
  aspeed/timer: Add AST2600 support
  aspeed/timer: Add support for IRQ status register on the AST2600
  aspeed/sdmc: Introduce an object class per SoC
  watchdog/aspeed: Introduce an object class per SoC
  aspeed/smc: Add AST2600 support
  aspeed/i2c: Introduce an object class per SoC
  aspeed/i2c: Add AST2600 support
  aspeed: Introduce an object class per SoC
  aspeed/soc: Add AST2600 support
  aspeed: Add an AST2600 eval board
  aspeed: add support for the Aspeed MII controller of the AST2600

Eddie James (1):
  hw/sd/aspeed_sdhci: New device

Joel Stanley (5):
  hw: aspeed_scu: Add AST2600 support
  aspeed/sdmc: Add AST2600 support
  hw: wdt_aspeed: Add AST2600 support
  aspeed: Parameterise number of MACs
  aspeed/soc: Add ASPEED Video stub

Rashmica Gupta (1):
  hw/gpio: Add in AST2600 specific implementation

 include/hw/arm/aspeed_soc.h      |  29 +-
 include/hw/i2c/aspeed_i2c.h      |  20 +-
 include/hw/misc/aspeed_scu.h     |   7 +-
 include/hw/misc/aspeed_sdmc.h    |  20 +-
 include/hw/net/ftgmac100.h       |  17 +
 include/hw/sd/aspeed_sdhci.h     |  34 ++
 include/hw/ssi/aspeed_smc.h      |   2 +
 include/hw/timer/aspeed_timer.h  |  18 ++
 include/hw/watchdog/wdt_aspeed.h |  19 +-
 hw/arm/aspeed.c                  |  37 ++-
 hw/arm/aspeed_ast2600.c          | 522 +++++++++++++++++++++++++++++++
 hw/arm/aspeed_soc.c              | 199 +++++++-----
 hw/gpio/aspeed_gpio.c            | 142 ++++++++-
 hw/i2c/aspeed_i2c.c              | 106 ++++++-
 hw/misc/aspeed_scu.c             | 192 +++++++++++-
 hw/misc/aspeed_sdmc.c            | 250 +++++++++++----
 hw/net/ftgmac100.c               | 162 ++++++++++
 hw/sd/aspeed_sdhci.c             | 198 ++++++++++++
 hw/ssi/aspeed_smc.c              | 129 +++++++-
 hw/timer/aspeed_timer.c          | 213 +++++++++++--
 hw/watchdog/wdt_aspeed.c         | 153 +++++----
 hw/arm/Makefile.objs             |   2 +-
 hw/sd/Makefile.objs              |   1 +
 23 files changed, 2204 insertions(+), 268 deletions(-)
 create mode 100644 include/hw/sd/aspeed_sdhci.h
 create mode 100644 hw/arm/aspeed_ast2600.c
 create mode 100644 hw/sd/aspeed_sdhci.c

--=20
2.21.0


