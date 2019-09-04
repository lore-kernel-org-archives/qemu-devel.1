Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA4C3A5AA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 07:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6872087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 07:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6872087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5POG-0002s8-CW
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 03:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i5PME-0001Gr-Ta
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i5PMC-00068V-5d
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:05:33 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:46291)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i5PMB-0005zA-VY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 03:05:32 -0400
Received: from player690.ha.ovh.net (unknown [10.109.159.191])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 1AE29202506
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 09:05:19 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id B9D7D94DC69A;
 Wed,  4 Sep 2019 07:05:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  4 Sep 2019 09:04:56 +0200
Message-Id: <20190904070506.1052-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 7074873541930683153
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejgedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.54.143
Subject: [Qemu-devel] [PATCH 00/10] Aspeed: machine extensions and fixes
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

This series improves the current models of the Aspeed machines in QEMU
and adds new ones. It also prepares ground for the models of the
Aspeed AST2600 SoC by calculating the model typenames using the SoC
name.

You will find patches for :

 - DMA support for the SMC controller, now using address_space_stl/ldl_le
 - GPIO v5 model from Rashmica

Thanks,

C.

Christian Svensson (1):
  aspeed/smc: Calculate checksum on normal DMA

C=C3=A9dric Le Goater (7):
  aspeed: Remove unused SoC definitions
  aspeed: Use consistent typenames
  aspeed/smc: Add support for DMAs
  aspeed/smc: Add DMA calibration settings
  aspeed/smc: Inject errors in DMA checksum
  aspeed/scu: Introduce per-SoC SCU types
  aspeed/scu: Introduce a aspeed_scu_get_apb_freq() routine

Rashmica Gupta (2):
  hw/gpio: Add basic Aspeed GPIO model for AST2400 and AST2500
  aspeed: add a GPIO controller to the SoC

 include/hw/arm/aspeed_soc.h   |   4 +-
 include/hw/gpio/aspeed_gpio.h | 100 ++++
 include/hw/misc/aspeed_scu.h  |  21 +-
 include/hw/ssi/aspeed_smc.h   |   7 +
 hw/arm/aspeed.c               |   2 +
 hw/arm/aspeed_soc.c           |  63 ++-
 hw/gpio/aspeed_gpio.c         | 884 ++++++++++++++++++++++++++++++++++
 hw/misc/aspeed_scu.c          | 102 ++--
 hw/ssi/aspeed_smc.c           | 335 ++++++++++++-
 hw/timer/aspeed_timer.c       |   3 +-
 hw/gpio/Makefile.objs         |   1 +
 11 files changed, 1418 insertions(+), 104 deletions(-)
 create mode 100644 include/hw/gpio/aspeed_gpio.h
 create mode 100644 hw/gpio/aspeed_gpio.c

--=20
2.21.0


