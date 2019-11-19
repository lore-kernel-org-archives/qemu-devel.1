Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A9DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 235132084D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235132084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX4G9-00065t-SW
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iX4Ex-0004vj-Qw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iX4Ew-0004x2-MV
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:12:23 -0500
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:33872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iX4Ew-0004vw-Ec
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:12:22 -0500
Received: from player795.ha.ovh.net (unknown [10.108.54.237])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id D7F1310E65E
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 15:12:19 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 8F5EBC18A6C7;
 Tue, 19 Nov 2019 14:12:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 00/17] aspeed: extensions and fixes
Date: Tue, 19 Nov 2019 15:11:54 +0100
Message-Id: <20191119141211.25716-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17889142144973507345
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.39.154
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
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Here is a series adding :

 - support for pool buffer transfers in the I2C controller
 - fixes for the AST2600 and for the SMC controller
 - a new Tacoma BMC board using the AST2600 SoC.
 - misc small cleanups

Thanks,

C.


C=C3=A9dric Le Goater (12):
  aspeed/i2c: Add support for pool buffer transfers
  aspeed/i2c: Check SRAM enablement on AST2500
  aspeed: Add a DRAM memory region at the SoC level
  aspeed/i2c: Add support for DMA transfers
  aspeed/i2c: Add trace events
  aspeed/smc: Restore default AHB window mapping at reset
  aspeed/smc: Do not map disabled segment on the AST2600
  aspeed/smc: Add AST2600 timings registers
  aspeed: Remove AspeedBoardConfig array and use AspeedMachineClass
  aspeed: Add support for the tacoma-bmc board
  aspeed: Change the "scu" property definition
  aspeed: Change the "nic" property definition

Joel Stanley (4):
  aspeed/sdmc: Make ast2600 default 1G
  aspeed/scu: Fix W1C behavior
  watchdog/aspeed: Improve watchdog timeout message
  watchdog/aspeed: Fix AST2600 frequency behaviour

PanNengyuan (1):
  gpio: fix memory leak in aspeed_gpio_init()

 include/hw/arm/aspeed.h          |  24 +-
 include/hw/arm/aspeed_soc.h      |   1 +
 include/hw/i2c/aspeed_i2c.h      |  16 ++
 include/hw/ssi/aspeed_smc.h      |   1 +
 include/hw/watchdog/wdt_aspeed.h |   1 +
 hw/arm/aspeed.c                  | 259 ++++++++++--------
 hw/arm/aspeed_ast2600.c          |  25 +-
 hw/arm/aspeed_soc.c              |  22 +-
 hw/gpio/aspeed_gpio.c            |   1 +
 hw/i2c/aspeed_i2c.c              | 439 +++++++++++++++++++++++++++++--
 hw/misc/aspeed_scu.c             |  19 +-
 hw/misc/aspeed_sdmc.c            |   6 +-
 hw/net/ftgmac100.c               |  19 +-
 hw/ssi/aspeed_smc.c              |  63 +++--
 hw/timer/aspeed_timer.c          |  17 +-
 hw/watchdog/wdt_aspeed.c         |  41 ++-
 hw/i2c/trace-events              |   9 +
 17 files changed, 744 insertions(+), 219 deletions(-)

--=20
2.21.0


